//
// Copyright 2021 Signal Messenger, LLC
// SPDX-License-Identifier: AGPL-3.0-only
//

import Lottie
import SignalServiceKit

public class CVMediaCache: NSObject {

    public enum CacheKey: Hashable, Equatable {
        case blurHash(String)
        case attachment(TSResourceId)
        case attachmentThumbnail(TSResourceId, quality: AttachmentThumbnailQuality)
    }

    private let stillMediaCache = LRUCache<CacheKey, AnyObject>(maxSize: 16,
                                                              shouldEvacuateInBackground: true)
    private let animatedMediaCache = LRUCache<CacheKey, AnyObject>(maxSize: 8,
                                                                 shouldEvacuateInBackground: true)

    private typealias MediaViewCache = LRUCache<CacheKey, ThreadSafeCacheHandle<ReusableMediaView>>
    private let stillMediaViewCache = MediaViewCache(maxSize: 12, shouldEvacuateInBackground: true)
    private let animatedMediaViewCache = MediaViewCache(maxSize: 6, shouldEvacuateInBackground: true)

    private let lottieAnimationCache = LRUCache<String, Lottie.Animation>(maxSize: 8,
                                                                          shouldEvacuateInBackground: true)
    private let lottieImageProvider = BundleImageProvider(bundle: .main, searchPath: nil)

    public override init() {
        AssertIsOnMainThread()

        super.init()
    }

    public func getMedia(_ key: CacheKey, isAnimated: Bool) -> AnyObject? {
        let cache = isAnimated ? animatedMediaCache : stillMediaCache
        return cache.get(key: key)
    }

    public func setMedia(_ value: AnyObject, forKey key: CacheKey, isAnimated: Bool) {
        let cache = isAnimated ? animatedMediaCache : stillMediaCache
        cache.set(key: key, value: value)
    }

    public func getMediaView(_ key: CacheKey, isAnimated: Bool) -> ReusableMediaView? {
        let cache = isAnimated ? animatedMediaViewCache : stillMediaViewCache
        return cache.get(key: key)?.value
    }

    public func setMediaView(_ value: ReusableMediaView, forKey key: CacheKey, isAnimated: Bool) {
        let cache = isAnimated ? animatedMediaViewCache : stillMediaViewCache
        cache.set(key: key, value: ThreadSafeCacheHandle(value))
    }

    public func getLottieAnimation(name: String) -> Lottie.Animation? {
        AssertIsOnMainThread()

        if let value = lottieAnimationCache.get(key: name) {
            return value
        }
        guard let value = Lottie.Animation.named(name) else {
            owsFailDebug("Invalid Lottie animation: \(name).")
            return nil
        }
        lottieAnimationCache.set(key: name, value: value)
        return value
    }

    public func buildLottieAnimationView(name: String) -> Lottie.AnimationView {
        AssertIsOnMainThread()

        // Don't use Lottie.AnimationCacheProvider; LRUCache is better.
        let animation: Lottie.Animation? = getLottieAnimation(name: name)
        // Don't specify textProvider.
        let animationView = Lottie.AnimationView(animation: animation, imageProvider: lottieImageProvider)
        return animationView
    }

    public func removeAllObjects() {
        AssertIsOnMainThread()

        stillMediaCache.removeAllObjects()
        animatedMediaCache.removeAllObjects()

        stillMediaViewCache.removeAllObjects()
        animatedMediaViewCache.removeAllObjects()

        lottieAnimationCache.removeAllObjects()
    }
}
