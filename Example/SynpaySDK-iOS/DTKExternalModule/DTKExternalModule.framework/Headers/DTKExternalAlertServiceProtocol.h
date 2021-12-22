//
//  DTKExternalAlertServiceProtocol.h
//  DTKExternalModule
//
//  Created by 家琪 on 2020/12/28.
//  Copyright © 2020 DingTalk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, DTKExternalAlertActionStyle) {
    DTKExternalAlertActionStyleDefault = 0,
    DTKExternalAlertActionStyleCancel,
    DTKExternalAlertActionStyleDestructive
};

typedef NS_ENUM(NSInteger, DTKExternalAlertStyle) {
    DTKExternalAlertStyleAlert,
    DTKExternalAlertStyleActionSheet,
};

@protocol DTKExternalAlertProtocol <NSObject>

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *message;
@property (nonatomic, copy, readonly) NSArray *actions;
@property (nonatomic, assign, readonly) DTKExternalAlertStyle style;

- (void)addActionWithTitle:(NSString *)title style:(DTKExternalAlertActionStyle)style handler:(nullable void (^)(void))block;

- (void)dismissAlert;
- (void)showInViewController:(UIViewController *)viewController;

@end

@protocol DTKExternalAlertServiceProtocol <NSObject>

- (id<DTKExternalAlertProtocol>)alertWithTitle:(nullable NSString *)title
                                       message:(nullable NSString *)message;

- (id<DTKExternalAlertProtocol>)alertWithTitle:(nullable NSString *)title
                                       message:(nullable NSString *)message
                                         style:(DTKExternalAlertStyle)style;

- (void)showAlert:(id<DTKExternalAlertProtocol>)alert inViewController:(UIViewController *)viewController;
- (void)dismissAlert:(id<DTKExternalAlertProtocol>)alert;

@end

NS_ASSUME_NONNULL_END
