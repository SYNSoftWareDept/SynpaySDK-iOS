//
//  DTKExternalButtonActionProtocol.h
//  DTKExternalModule
//
//  Created by 家琪 on 2021/3/10.
//  Copyright © 2021 DingTalk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTKExternalActionProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DTKExternalButtonActionProtocol;
typedef void(^DTKExternalButtonOnTappedBlock)(__kindof UIResponder *sender, id<DTKExternalButtonActionProtocol> action);

@protocol DTKExternalButtonActionProtocol <DTKExternalActionProtocol>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) DTKExternalButtonOnTappedBlock onTapped;

@end

NS_ASSUME_NONNULL_END
