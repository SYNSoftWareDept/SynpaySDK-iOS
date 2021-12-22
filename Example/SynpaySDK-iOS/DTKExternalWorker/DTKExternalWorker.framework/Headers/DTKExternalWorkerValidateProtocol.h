//
//  DTKExternalWorkerValidateProtocol.h
//  DTKExternalWorker
//
//  Created by 家琪 on 2020/12/19.
//  Copyright © 2020 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DTKExternalWorkerValidateProtocol <NSObject>

@required
- (BOOL)externalModuleIsRunnable:(NSString *)appId;

@optional
- (BOOL)externalModuleAllJSAPIIsRunnable:(NSString *)appId;
- (BOOL)externalModuleJSAPI:(NSString *)apiName isRunnableForAppId:(NSString *)appId;
- (BOOL)externalModuleAllNativeAPIIsRunnable:(NSString *)appId;
- (BOOL)externalModuleNativeAPI:(NSString *)apiName isRunnableForAppId:(NSString *)appId;

@end

NS_ASSUME_NONNULL_END
