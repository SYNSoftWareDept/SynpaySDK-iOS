//
//  DTKExternalJSAPIProtocol.h
//  DTKExternalModule
//
//  Created by 家琪 on 2020/12/10.
//  Copyright © 2020 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <DTKExternalModule/DTKExternalAPIDefines.h>

#ifndef DTKExternalJSAPIRegister
#define DTKExternalJSAPIRegister(bundleId, handler) \
char *k##bundleId__DTKExternalJSAPI__##handler DTKExternalSectionDATA(DTKExternalJSAPI) = \
    "{  \
        \"bundleId\": \""#bundleId"\",\
        \"handler\": \""#handler"\",\
     }";
#endif

NS_ASSUME_NONNULL_BEGIN

@protocol DTKExternalJSAPIContext <DTKExternalAPIContext>

@property (nonatomic, weak, nullable, readonly) __kindof UIViewController *webViewController;
@property (nonatomic, weak, nullable, readonly) __kindof UIView *webView;
@property (nonatomic, copy, nullable, readonly) NSString *tinyAppUrl;

@end

@protocol DTKExternalJSAPIHandlerProtocol <NSObject>


- (void)handleRequest:(id<DTKExternalAPIRequest>)request
          withContext:(id<DTKExternalJSAPIContext>)context
             callback:(DTKExternalAPICallback)callback;

@optional
+ (NSArray<NSString *>*)apiNameList;
@end

NS_ASSUME_NONNULL_END
