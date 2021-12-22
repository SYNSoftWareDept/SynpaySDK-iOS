//
//  DTKExternalHostAppServiceProtocol.h
//  DTKExternalModule
//
//  Created by 家琪 on 2020/12/25.
//  Copyright © 2020 DingTalk. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DTKExternalHostAppServiceProtocol <NSObject>

- (NSString *)getHostAppDisplayName;
- (NSString *)getHostAppVersion;
- (NSString *)getHostAppScheme;

@end

NS_ASSUME_NONNULL_END
