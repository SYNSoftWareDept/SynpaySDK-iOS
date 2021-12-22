//
//  DTKExternalNativeAPIServiceProtocol.h
//  DTKExternalModule
//
//  Created by 家琪 on 2020/12/25.
//  Copyright © 2020 DingTalk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DTKExternalModule/DTKExternalNativeAPIProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DTKExternalNativeAPIServiceProtocol <NSObject>

- (void)invokeNativeAPI:(NSString *)apiName
           requestParam:(nullable void (^)(id<DTKExternalAPIRequest> param, id<DTKExternalAPIContext> context))paramBlock
               callback:(void (^)(NSDictionary *response))block;

@end

NS_ASSUME_NONNULL_END
