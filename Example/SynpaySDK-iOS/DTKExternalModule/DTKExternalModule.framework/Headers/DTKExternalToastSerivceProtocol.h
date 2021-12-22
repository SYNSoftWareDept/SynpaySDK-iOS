//
//  DTKExternalToastSerivceProtocol.h
//  DTKExternalModule
//
//  Created by 家琪 on 2020/12/28.
//  Copyright © 2020 DingTalk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DTKExternalToastSerivceProtocol <NSObject>

- (void)showMessage:(NSString *)message inView:(nullable UIView *)view;
- (void)showSuccessMessage:(NSString *)message inView:(nullable UIView *)view;
- (void)showErrorMessage:(NSString *)message inView:(nullable UIView *)view;
- (void)showWarningMessage:(NSString *)message inView:(nullable UIView *)view;

- (void)showLoadingInView:(nullable UIView *)view;
- (void)showLoadingMessage:(NSString *)message inView:(nullable UIView *)view;

- (void)hideInView:(nullable UIView *)view;

@end

NS_ASSUME_NONNULL_END
