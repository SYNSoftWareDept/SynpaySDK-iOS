//
//  DTKExternalJSEventProtocol.h
//  DTKExternalModule
//
//  Created by 钟路成 on 2021/3/29.
//  Copyright © 2021 DingTalk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DTKExternalJSEventProtocol <NSObject>

/**
 @brief 调用JS 事件
 @param eventName js侧注册监听的的事件名称
 @param params 事件参数，透传给js
 */
- (void)invokeJsEventName:(NSString *)eventName params:(nullable NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
