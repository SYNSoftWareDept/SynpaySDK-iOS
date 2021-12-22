//
//  DTKExternalJumpServiceProtocol.h
//  DTKExternalModule
//
//  Created by 家琪 on 2020/12/29.
//  Copyright © 2020 DingTalk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <DTKExternalModule/DTKExternalDefines.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSString DTKExternalJumpUserInfoKey;
typedef NSString DTKExternalJumpUserInfoValue;

UIKIT_EXTERN DTKExternalJumpUserInfoKey *const DTKExternalJumpNavigationType; // default is push
UIKIT_EXTERN DTKExternalJumpUserInfoValue *const DTKExternalJumpNavigationPush;
UIKIT_EXTERN DTKExternalJumpUserInfoValue *const DTKExternalJumpNavigationPresent;

UIKIT_EXTERN DTKExternalJumpUserInfoKey *const DTKExternalJumpModalPresentationStyle; // value is UIModalPresentationStyle. available when navigationType is present.
UIKIT_EXTERN DTKExternalJumpUserInfoKey *const DTKExternalJumpNeedNavigationController; // default is NO. available when navigationType is present.

@protocol DTKExternalJumpEvent <NSObject>

@property (nonatomic, copy) NSString *urlString;
@property (nonatomic) NSDictionary *userInfo;

@end

@protocol DTKExternalJumpHandlerProtocol <NSObject>

@optional
- (void)handleJumpEvent:(id<DTKExternalJumpEvent>)event;
- (instancetype)initWithURL:(NSString *)urlString userInfo:(nullable NSDictionary *)userInfo;

@end

@protocol DTKExternalJumpServiceProtocol <NSObject>

- (void)registerHandler:(NSString *)handlerClass forURL:(NSString *)urlString;
- (void)reigsterHandler:(NSString *)handlerClass forURLRegex:(NSString *)urlRegex;


- (void)openURL:(NSString *)urlString;
- (void)openURL:(NSString *)urlString userInfo:(nullable NSDictionary *)userInfo;

@end

NS_ASSUME_NONNULL_END
