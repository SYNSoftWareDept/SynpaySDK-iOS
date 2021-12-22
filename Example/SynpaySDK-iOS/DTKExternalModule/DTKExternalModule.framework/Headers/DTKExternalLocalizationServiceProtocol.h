//
//  DTKExternalLocalizationServiceProtocol.h
//  DTKExternalModule
//
//  Created by 家琪 on 2021/1/12.
//  Copyright © 2021 DingTalk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTKExternalLocalizationServiceDefine.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DTKExternalLocalizationServiceProtocol <NSObject>

/// en-US, zh-cn等，ISO-3166标准
- (NSString *)getCurrentAppLanguageCode;

@end

NS_ASSUME_NONNULL_END
