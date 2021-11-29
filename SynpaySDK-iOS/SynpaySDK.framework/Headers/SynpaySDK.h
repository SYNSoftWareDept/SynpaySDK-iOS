//
//  SynpaySDK.h
//  SynpaySDK
//
//  Created by Objective on 2021/11/10.
//

#import <Foundation/Foundation.h>
#import "SynpayConfig.h"

#define SYNSharedPaySDK [SynpaySDK sharedSDK]

NS_ASSUME_NONNULL_BEGIN

@interface SynpaySDK : NSObject

/// SDK单例
+ (instancetype)sharedSDK;

/// SDK版本
- (NSString *)sdkVersion;

/// 初始化SDK
/// @param config SDK必要配置信息
/// @param completion 调用结果回调block
- (void)startSDKWithConfig:(SynpayConfig *)config
                completion:(void (^)(NSDictionary *result))completion;

/// 获取支付列表
/// @param completion 调用结果回调block
- (void)getPayTypes:(void (^)(NSDictionary *result))completion;

/// 获取联机码
/// @param typeId 支付方式id
/// @param completion 调用结果回调block
- (void)getOnlineCodeByTypeId:(NSString *)typeId
                   completion:(void (^)(NSDictionary *result))completion;

/// 获取脱机码
/// @param typeId 支付方式id
/// @param completion 调用结果回调block
- (void)getOfflineCodeByTypeId:(NSString *)typeId
                    completion:(void (^)(NSDictionary *result))completion;

/// 获取复合码 注:联机码有可能获取失败
/// @param typeId 支付方式id
/// @param completion 调用结果回调block
- (void)getCompoundCodeByTypeId:(NSString *)typeId
                     completion:(void (^)(NSDictionary *result))completion;

/// 监听联机码消费结果
/// @param barcode 联机码
/// @param completion 调用结果回调block
- (void)observeBarcode:(NSString *)barcode
            completion:(void (^)(NSDictionary *result))completion;

/// 关闭监听
- (void)stopObserveBarcode;


@end


NS_ASSUME_NONNULL_END
