//
//  SynpayConfig.h
//  SynpaySDK
//
//  Created by Objective on 2021/11/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SynpayConfig : NSObject

/// 用户token
@property (copy  , nonatomic) NSString *token;
/// 开发者AppId
@property (copy  , nonatomic) NSString *appId;
/// 服务器地址
@property (copy  , nonatomic) NSString *serverUrl;
/// socket地址
@property (copy  , nonatomic) NSString *socketUtl;

@end

NS_ASSUME_NONNULL_END
