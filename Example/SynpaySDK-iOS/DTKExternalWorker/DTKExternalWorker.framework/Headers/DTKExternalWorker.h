//
//  DTKExternalWorker.h
//  DTKExternalWorker
//
//  Created by 家琪 on 2020/12/10.
//

#import <Foundation/Foundation.h>
#import <DTKExternalModule/DTKExternalModule.h>
#import "DTKExternalWorkerManager.h"
#import "DTKExternalJSEventServiceManager.h"

// protocols
#import "DTKExternalWorkerValidateProtocol.h"

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const DTKExternalWorkerBundleId;

@interface DTKExternalWorker : NSObject

+ (_Nullable instancetype)workerForBundle:(NSString *)clazzString;

@property (nonatomic, copy, nonnull, readonly) NSString *bundleId;
@property (nonatomic, nonnull, readonly) id<DTKExternalModuleProtocol> entry;
@property (nonatomic, readonly) NSDictionary *jsapis;

- (void)registerJSAPIHandler:(nonnull NSString *)handlerClazzString;
- (void)invokeJSAPI:(NSString *)apiName
            request:(id<DTKExternalAPIRequest>)request
            context:(id<DTKExternalAPIContext>)context
           callback:(DTKExternalAPICallback)callback;

@end

NS_ASSUME_NONNULL_END



