//
//  DTKExternalUIHierarchyServiceProtocol.h
//  DTKExternalModule
//
//  Created by 家琪 on 2020/12/29.
//  Copyright © 2020 DingTalk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DTKExternalUIHierarchyServiceProtocol <NSObject>

- (UIViewController *)currentTopViewController;
- (UINavigationController *)currentNavigationController;
- (UIViewController *)rootViewController;

@end

NS_ASSUME_NONNULL_END
