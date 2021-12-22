//
//  DTKExternalModuleProtocol.h
//  DTKExternalModule
//
//  Created by 家琪 on 2020/12/10.
//  Copyright © 2020 DingTalk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <DTKExternalModule/DTKExternalDefines.h>


/**
    @brief 模块注册，将模块注册进钉钉底座中。
    @param name DTKExternalModuleName，模块名称必须和类名一致
    @code
        #import <DTKExternalModule/DTKExternalModule.h>
 
        DTKExternalModuleRegister(DTKExternalDemoModule)
 
        @interface DTKExternalDemoModule : NSObject <DTKExternalModuleProtocol>
        @end
    @endcode
 */
#ifndef DTKExternalBundleRegister
#define DTKExternalBundleRegister(name) char *kDTExternal##name DTKExternalSectionDATA(DTKEBundle) = ""#name"";
#endif

typedef NSString* DTKExternalUserId;

NS_ASSUME_NONNULL_BEGIN

/**
 @brief 模块协议，模块入口文件必须实现该协议
 */
@protocol DTKExternalBundleProtocol <NSObject>

@required

/**
  @brief 返回bundleId。
 */
- (NSString *)bundleId;

@optional

/**
  @brief 模块被钉钉加载到底座中时，会调用该方法，此时所有的钉钉底座服务已经启动完成，可以在该方法中做初始化工作。不要执行耗时操作
 */
- (void)bundleDidLoaded;

/**
  @brief 所有扩展模块都加载完成后，会调用该方法，可以在该方法中执行一些依赖其他扩展模块初始化完成的操作。不要执行耗时操作
 */
- (void)allBundlesDidLoaded;

/**
  @brief 钉钉app即将进入前台运行，不要在该方法中执行耗时操作
 */
- (void)hostApplicationWillEnterForeground;
/**
  @brief 钉钉app进入后台运行。
 */
- (void)hostApplicationDidEnterBackground;

/** @brief 用户登录成功后，会调用该方法并传入userId。moduleDidMount方法调用之后，如果底座是已登录状态(自动登录或token未失效)，也会调用一次这个方法
    @param userId DTKExternalUserId  用户账户id，如果模块中需要用到userId，则应该在该方法中将userId自行保存起来
 */
- (void)onUserDidLogin:(DTKExternalUserId)userId;
/**
  @brief 用户登出后，会调用该方法
 */
- (void)onUserDidLogout;

@end

// deprecated protocol, use DTKExternalBundleProtocol instead.
@protocol DTKExternalModuleProtocol <DTKExternalBundleProtocol>

@optional
- (NSString *)appId __DTKExternalDeprecated("Use bundleId instead.");
- (void)moduleDidMount __DTKExternalDeprecated("Use bundleDidLoaded instead.");
- (void)allModulesDidMount __DTKExternalDeprecated("Use allBundlesDidLoaded instead.");

@end

NS_ASSUME_NONNULL_END
