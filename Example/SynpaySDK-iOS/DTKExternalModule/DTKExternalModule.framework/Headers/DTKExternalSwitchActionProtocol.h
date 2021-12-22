//
//  DTKExternalSwitchActionProtocol.h
//  DTKExternalModule
//
//  Created by 家琪 on 2021/3/11.
//  Copyright © 2021 DingTalk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTKExternalActionProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DTKExternalSwitchActionProtocol;
typedef void(^DTKExternalSwitchOnValueChangeBlock)(__kindof UIResponder *sender, id<DTKExternalSwitchActionProtocol> action);

@protocol DTKExternalSwitchActionProtocol <DTKExternalActionProtocol>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign, getter=isOn) BOOL on;
@property (nonatomic, copy) DTKExternalSwitchOnValueChangeBlock onValueChange;

@end

NS_ASSUME_NONNULL_END
