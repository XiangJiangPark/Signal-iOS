//
//  Copyright (c) 2018 Open Whisper Systems. All rights reserved.
//

import UIKit

@objc
public class ConversationAvatarImageView: AvatarImageView {

    let thread: TSThread
    let diameter: UInt
    let contactsManager: OWSContactsManager

    // nil if group avatar
    let recipientId: String?

    // nil if contact avatar
    let groupThreadId: String?

    required public init(thread: TSThread, diameter: UInt, contactsManager: OWSContactsManager) {
        self.thread = thread
        self.diameter = diameter
        self.contactsManager = contactsManager

        switch thread {
        case let contactThread as TSContactThread:
            self.recipientId = contactThread.contactIdentifier()
            self.groupThreadId = nil
        case let groupThread as TSGroupThread:
            self.recipientId = nil
            self.groupThreadId = groupThread.uniqueId
        default:
            owsFail("in \(#function) unexpected thread type: \(thread)")
            self.recipientId = nil
            self.groupThreadId = nil
        }

        super.init(frame: .zero)

        if recipientId != nil {
            NotificationCenter.default.addObserver(self, selector: #selector(handleOtherUsersProfileChanged(notification:)), name: NSNotification.Name(rawValue: kNSNotificationName_OtherUsersProfileDidChange), object: nil)

            NotificationCenter.default.addObserver(self, selector: #selector(handleSignalAccountsChanged(notification:)), name: NSNotification.Name.OWSContactsManagerSignalAccountsDidChange, object: nil)
        }

        if groupThreadId != nil {
            NotificationCenter.default.addObserver(self, selector: #selector(handleGroupAvatarChanged(notification:)), name: .TSGroupThreadAvatarChanged, object: nil)
        }

        // TODO group avatar changed
        self.updateImage()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func handleSignalAccountsChanged(notification: Notification) {
        Logger.debug("\(self.logTag) in \(#function)")

        // It would be nice if we could do this only if *this* user changed,
        // but currently this is a course grained notification.

        self.updateImage()
    }

    func handleOtherUsersProfileChanged(notification: Notification) {
        Logger.debug("\(self.logTag) in \(#function)")

        guard let changedRecipientId = notification.userInfo?[kNSNotificationKey_ProfileRecipientId] as? String else {
            owsFail("\(logTag) in \(#function) recipientId was unexpectedly nil")
            return
        }

        guard let recipientId = self.recipientId else {
            // shouldn't call this for group threads
            owsFail("\(logTag) in \(#function) contactId was unexpectedly nil")
            return
        }

        guard recipientId == recipientId else {
            // not this avatar
            return
        }

        self.updateImage()
    }

    func handleGroupAvatarChanged(notification: Notification) {
        Logger.debug("\(self.logTag) in \(#function)")

        guard let changedGroupThreadId = notification.userInfo?[TSGroupThread_NotificaitonKey_UniqueId] as? String else {
            owsFail("\(logTag) in \(#function) groupThreadId was unexpectedly nil")
            return
        }

        guard let groupThreadId = self.groupThreadId else {
            // shouldn't call this for contact threads
            owsFail("\(logTag) in \(#function) groupThreadId was unexpectedly nil")
            return
        }

        guard groupThreadId == changedGroupThreadId else {
            // not this avatar
            return
        }

        thread.reload()

        self.updateImage()
    }

    func updateImage() {
        Logger.debug("\(self.logTag) in \(#function) updateImage")

        self.image = OWSAvatarBuilder.buildImage(thread: thread, diameter: diameter, contactsManager: contactsManager)
    }
}

@objc
public class AvatarImageView: UIImageView {

    public init() {
        super.init(frame: .zero)
        self.configureView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureView()
    }

    override init(image: UIImage?) {
        super.init(image: image)
        self.configureView()
    }

    func configureView() {
        self.autoPinToSquareAspectRatio()

        self.layer.minificationFilter = kCAFilterTrilinear
        self.layer.magnificationFilter = kCAFilterTrilinear
        self.layer.borderWidth = 0.5
        self.layer.masksToBounds = true
        self.contentMode = .scaleToFill
    }

    override public func layoutSubviews() {
        self.layer.borderColor = UIColor.black.cgColor.copy(alpha: 0.15)
        self.layer.cornerRadius = self.frame.size.width / 2
    }
}
