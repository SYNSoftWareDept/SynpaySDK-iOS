//
//  DTKExternalJSEventServiceManager.h
//  DTKExternalWorker
//
//  Created by 钟路成 on 2021/3/29.
//  Copyright © 2021 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DTKExternalJSEventServiceManager : NSObject

+ (instancetype)sharedInstance;

- (void)subscribeEvent:(NSString *)eventName
              bundleId:(NSString *)bundleId
           handleBlock:(void (^)(NSDictionary *params))handleBlock;

- (void)unsubscribeEvent:(NSString *)eventName bundleId:(NSString *)bundleId;

- (void)invokeJsEventName:(NSString *)eventName bundleId:(NSString *)bundleId params:(nullable NSDictionary *)params;
@end

NS_ASSUME_NONNULL_END
