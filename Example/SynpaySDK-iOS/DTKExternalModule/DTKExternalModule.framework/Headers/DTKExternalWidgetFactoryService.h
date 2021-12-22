//
//  DTKExternalWidgetFactoryService.h
//  DTKExternalModule
//
//  Created by 家琪 on 2021/3/10.
//  Copyright © 2021 DingTalk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTKExternalWidgetProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DTKExternalWidgetFactoryService <NSObject>

- (id<DTKExternalWidgetProtocol>)widgetForProtocol:(Protocol *)widgetProtocol;

@end

NS_ASSUME_NONNULL_END
