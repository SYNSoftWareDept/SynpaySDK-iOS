//
//  DTKActionFactoryService.h
//  DTKExternalModule
//
//  Created by 家琪 on 2021/3/10.
//  Copyright © 2021 DingTalk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTKExternalActionProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DTKExternalActionFactoryService <NSObject>

- (id<DTKExternalActionProtocol>)actionForProtocol:(Protocol *)actionProtocol;

@end

NS_ASSUME_NONNULL_END
