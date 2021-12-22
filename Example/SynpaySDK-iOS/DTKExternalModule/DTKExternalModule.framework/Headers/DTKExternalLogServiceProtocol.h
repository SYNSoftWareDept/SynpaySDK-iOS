//
//  DTKExternalLogServiceProtocol.h
//  DTKExternalModule
//
//  Created by 家琪 on 2020/12/28.
//  Copyright © 2020 DingTalk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DTKExternalModule/DTKExternalServiceDefines.h>

/**
  Example:
    @code
         id<DTKExternalLogServiceProtocol> logger = DTKExternalGetLogger(yourBundleId);
         DTKExternalLog(logger, @"log some infos");
         DTKExternalLogError(logger, @"log some error: %@", error);
    @endcode
 */

#define DTKExternalGetLogger(bundleId) [DTKExternalGetImpl(bundleId, DTKExternalLogManagerServiceProtocol) getLoggerWithBundleId:bundleId]

#define DTKExternalLog(logger, frmt, ...) _DTKExternalLogLevel(logger, DTKExternalLogLevelInfo, frmt, ##__VA_ARGS__)
#define DTKExternalLogInfo(logger, frmt, ...) _DTKExternalLogLevel(logger, DTKExternalLogLevelInfo, frmt, ##__VA_ARGS__)
#define DTKExternalLogError(logger, frmt, ...) _DTKExternalLogLevel(logger, DTKExternalLogLevelError, frmt, ##__VA_ARGS__)

#define _DTKExternalLogLevel(logger, level, frmt, ...) [logger logLevel:level format:(frmt), ## __VA_ARGS__]

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, DTKExternalLogLevel) {
    DTKExternalLogLevelInfo,
    DTKExternalLogLevelError,
};

@protocol DTKExternalLogServiceProtocol <NSObject>

- (void)logLevel:(DTKExternalLogLevel)level format:(NSString *)frmt, ... NS_FORMAT_FUNCTION(2, 3);

@end

@protocol DTKExternalLogManagerServiceProtocol <NSObject>

- (id<DTKExternalLogServiceProtocol>)getLoggerWithBundleId:(NSString *)bundleId;

@optional
- (id<DTKExternalLogServiceProtocol>)getLoggerWithAppId:(NSString *)appId __DTKExternalDeprecated("Use getLoggerWithBundleId instead.");

@end


/// Deprecated protocol, use DTKExternalLogServiceProtocol plesase
@protocol DTKExternalLogServiceProtcol <DTKExternalLogServiceProtocol>
@end

NS_ASSUME_NONNULL_END
