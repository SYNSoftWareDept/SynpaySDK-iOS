//
//  DTKExternalWorkerManager.h
//  DTKExternalWorker
//
//  Created by 家琪 on 2020/12/10.
//  Copyright © 2020 Dingtalk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DTKExternalModule/DTKExternalModule.h>

#import "DTKExternalAPIRequest.h"
#import "DTKExternalAPIContext.h"
#import "DTKExternalJSAPIContext.h"

NS_ASSUME_NONNULL_BEGIN

@interface DTKExternalWorkerManager : NSObject

+ (instancetype)sharedInstance;

- (void)registerHandler:(id)handler forProtocol:(Protocol *)protocol;
- (id)handlerForProtocol:(Protocol *)protocol;

#pragma mark - Workers

/// 加载所有worker，需要在启动时调用
- (void)loadAllWorkers;


/// 返回所有已注册的bundle的id列表
- (NSArray<NSString *> *)registedBundleIdList;

/// 返回对应bundleId的jsapi列表，key是apiName，value是handler
/// @param bundleId bundleId
- (NSDictionary *)jsapiDictForBundleId:(NSString *)bundleId;

#pragma mark - Life cycle

- (void)onApplicationDidFinishLaunching:(UIApplication *)application;
- (void)onApplicationWillEnterForeground:(UIApplication *)application;
- (void)onApplicationDidEnterBackground:(UIApplication *)application;

- (void)onUserDidLogin:(DTKExternalUserId)userId;
- (void)onUserDidLogout;

#pragma mark - JS API

- (void)invokeJSAPI:(NSString *)apiName
          forBundle:(NSString *)bundleId
        withRequest:(DTKExternalAPIRequest *)request
            context:(DTKExternalJSAPIContext *)context
           callback:(DTKExternalAPICallback)callback;

#pragma mark - Native API

- (void)invokeNavieAPI:(NSString *)apiName
           withRequest:(DTKExternalAPIRequest *)request
               context:(DTKExternalAPIContext *)context
              callback:(DTKExternalAPICallback)callback;

@end

NS_ASSUME_NONNULL_END
