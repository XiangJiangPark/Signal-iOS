//
// Copyright 2024 Signal Messenger, LLC
// SPDX-License-Identifier: AGPL-3.0-only
//

// Code generated by Wire protocol buffer compiler, do not edit.
// Source: BackupProto.BackupProtoChat in Backup.proto
import Wire

public struct BackupProtoChat {

    /**
     * generated id for reference only within this file
     */
    public var id: UInt64
    public var recipientId: UInt64
    public var archived: Bool
    /**
     * 0 = unpinned, otherwise chat is considered pinned and will be displayed in ascending order
     */
    public var pinnedOrder: UInt32
    /**
     * 0 = no expire timer.
     */
    public var expirationTimerMs: UInt64
    public var muteUntilMs: UInt64
    public var markedUnread: Bool
    public var dontNotifyForMentionsIfMuted: Bool
    @ProtoDefaulted
    public var wallpaper: BackupProtoFilePointer?
    public var unknownFields: UnknownFields = .init()

    public init(
        id: UInt64,
        recipientId: UInt64,
        archived: Bool,
        pinnedOrder: UInt32,
        expirationTimerMs: UInt64,
        muteUntilMs: UInt64,
        markedUnread: Bool,
        dontNotifyForMentionsIfMuted: Bool,
        configure: (inout Self) -> Swift.Void = { _ in }
    ) {
        self.id = id
        self.recipientId = recipientId
        self.archived = archived
        self.pinnedOrder = pinnedOrder
        self.expirationTimerMs = expirationTimerMs
        self.muteUntilMs = muteUntilMs
        self.markedUnread = markedUnread
        self.dontNotifyForMentionsIfMuted = dontNotifyForMentionsIfMuted
        configure(&self)
    }

}

#if !WIRE_REMOVE_EQUATABLE
extension BackupProtoChat : Equatable {
}
#endif

#if !WIRE_REMOVE_HASHABLE
extension BackupProtoChat : Hashable {
}
#endif

extension BackupProtoChat : Sendable {
}

extension BackupProtoChat : ProtoMessage {

    public static func protoMessageTypeURL() -> String {
        return "type.googleapis.com/BackupProto.BackupProtoChat"
    }

}

extension BackupProtoChat : Proto3Codable {

    public init(from protoReader: ProtoReader) throws {
        var id: UInt64 = 0
        var recipientId: UInt64 = 0
        var archived: Bool = false
        var pinnedOrder: UInt32 = 0
        var expirationTimerMs: UInt64 = 0
        var muteUntilMs: UInt64 = 0
        var markedUnread: Bool = false
        var dontNotifyForMentionsIfMuted: Bool = false
        var wallpaper: BackupProtoFilePointer? = nil

        let token = try protoReader.beginMessage()
        while let tag = try protoReader.nextTag(token: token) {
            switch tag {
            case 1: id = try protoReader.decode(UInt64.self)
            case 2: recipientId = try protoReader.decode(UInt64.self)
            case 3: archived = try protoReader.decode(Bool.self)
            case 4: pinnedOrder = try protoReader.decode(UInt32.self)
            case 5: expirationTimerMs = try protoReader.decode(UInt64.self)
            case 6: muteUntilMs = try protoReader.decode(UInt64.self)
            case 7: markedUnread = try protoReader.decode(Bool.self)
            case 8: dontNotifyForMentionsIfMuted = try protoReader.decode(Bool.self)
            case 9: wallpaper = try protoReader.decode(BackupProtoFilePointer.self)
            default: try protoReader.readUnknownField(tag: tag)
            }
        }
        self.unknownFields = try protoReader.endMessage(token: token)

        self.id = id
        self.recipientId = recipientId
        self.archived = archived
        self.pinnedOrder = pinnedOrder
        self.expirationTimerMs = expirationTimerMs
        self.muteUntilMs = muteUntilMs
        self.markedUnread = markedUnread
        self.dontNotifyForMentionsIfMuted = dontNotifyForMentionsIfMuted
        self._wallpaper.wrappedValue = wallpaper
    }

    public func encode(to protoWriter: ProtoWriter) throws {
        try protoWriter.encode(tag: 1, value: self.id)
        try protoWriter.encode(tag: 2, value: self.recipientId)
        try protoWriter.encode(tag: 3, value: self.archived)
        try protoWriter.encode(tag: 4, value: self.pinnedOrder)
        try protoWriter.encode(tag: 5, value: self.expirationTimerMs)
        try protoWriter.encode(tag: 6, value: self.muteUntilMs)
        try protoWriter.encode(tag: 7, value: self.markedUnread)
        try protoWriter.encode(tag: 8, value: self.dontNotifyForMentionsIfMuted)
        try protoWriter.encode(tag: 9, value: self.wallpaper)
        try protoWriter.writeUnknownFields(unknownFields)
    }

}

#if !WIRE_REMOVE_CODABLE
extension BackupProtoChat : Codable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StringLiteralCodingKeys.self)
        self.id = try container.decode(stringEncoded: UInt64.self, forKey: "id")
        self.recipientId = try container.decode(stringEncoded: UInt64.self, forKey: "recipientId")
        self.archived = try container.decode(Bool.self, forKey: "archived")
        self.pinnedOrder = try container.decode(UInt32.self, forKey: "pinnedOrder")
        self.expirationTimerMs = try container.decode(stringEncoded: UInt64.self, forKey: "expirationTimerMs")
        self.muteUntilMs = try container.decode(stringEncoded: UInt64.self, forKey: "muteUntilMs")
        self.markedUnread = try container.decode(Bool.self, forKey: "markedUnread")
        self.dontNotifyForMentionsIfMuted = try container.decode(Bool.self, forKey: "dontNotifyForMentionsIfMuted")
        self._wallpaper.wrappedValue = try container.decodeIfPresent(BackupProtoFilePointer.self, forKey: "wallpaper")
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: StringLiteralCodingKeys.self)
        let includeDefaults = encoder.protoDefaultValuesEncodingStrategy == .include

        if includeDefaults || self.id != 0 {
            try container.encode(stringEncoded: self.id, forKey: "id")
        }
        if includeDefaults || self.recipientId != 0 {
            try container.encode(stringEncoded: self.recipientId, forKey: "recipientId")
        }
        if includeDefaults || self.archived != false {
            try container.encode(self.archived, forKey: "archived")
        }
        if includeDefaults || self.pinnedOrder != 0 {
            try container.encode(self.pinnedOrder, forKey: "pinnedOrder")
        }
        if includeDefaults || self.expirationTimerMs != 0 {
            try container.encode(stringEncoded: self.expirationTimerMs, forKey: "expirationTimerMs")
        }
        if includeDefaults || self.muteUntilMs != 0 {
            try container.encode(stringEncoded: self.muteUntilMs, forKey: "muteUntilMs")
        }
        if includeDefaults || self.markedUnread != false {
            try container.encode(self.markedUnread, forKey: "markedUnread")
        }
        if includeDefaults || self.dontNotifyForMentionsIfMuted != false {
            try container.encode(self.dontNotifyForMentionsIfMuted, forKey: "dontNotifyForMentionsIfMuted")
        }
        try container.encodeIfPresent(self.wallpaper, forKey: "wallpaper")
    }

}
#endif
