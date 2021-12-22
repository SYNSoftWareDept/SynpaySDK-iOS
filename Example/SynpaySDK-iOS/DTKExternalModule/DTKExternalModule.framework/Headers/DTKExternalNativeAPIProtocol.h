//
//  DTKExternalNativeAPIProtocol.h
//  DTKExternalModule
//
//  Created by 家琪 on 2020/12/25.
//  Copyright © 2020 DingTalk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DTKExternalModule/DTKExternalAPIDefines.h>

#ifndef DTKExternalNativeAPIRegister
#define DTKExternalNativeAPIRegister(nativeapi, handler) \
char *kDTKExternalNativeAPI__##nativeapi DTKExternalSectionDATA(DTKExternalNAPI) = \
    "{  \
        \"apiName\": \""#nativeapi"\",\
        \"handler\": \""#handler"\",\
     }";
#endif

NS_ASSUME_NONNULL_BEGIN

@protocol DTKExternalNativeAPIHandlerProtocol <NSObject>

- (void)handleRequest:(id<DTKExternalAPIRequest>)request
          withContext:(id<DTKExternalAPIContext>)context
             callback:(DTKExternalAPICallback)callback;

@end

NS_ASSUME_NONNULL_END
