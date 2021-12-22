//
//  DTKExternalActionGroupProtocol.h
//  DTKExternalModule
//
//  Created by 家琪 on 2021/3/11.
//  Copyright © 2021 DingTalk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTKExternalActionProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DTKExternalActionGroupProtocol <DTKExternalActionProtocol>

@property (nonatomic, copy) NSArray<id<DTKExternalActionProtocol>> *actions;

@end

NS_ASSUME_NONNULL_END
