//
//  DTKExternalJSAPIContext.h
//  DTKExternalWorker
//
//  Created by 家琪 on 2020/12/25.
//  Copyright © 2020 Alibaba. All rights reserved.
//

#import "DTKExternalAPIContext.h"

NS_ASSUME_NONNULL_BEGIN

@interface DTKExternalJSAPIContext : DTKExternalAPIContext

@property (nonatomic, weak, nullable, readwrite) __kindof UIViewController *webViewController;
@property (nonatomic, weak, nullable, readwrite) __kindof UIView *webView;
@property (nonatomic, copy, nullable, readwrite) NSString *tinyAppUrl;
@property (nonatomic, copy, nullable, readwrite) NSString *tinyAppId;

@end

NS_ASSUME_NONNULL_END
