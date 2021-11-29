//
//  UIImage+SYNCategory.h
//  SynpaySDK_Example
//
//  Created by Boole on 2021/11/26.
//  Copyright © 2021 gosoftware@synjones.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (SYNCategory)

+ (UIImage *)syn_qrImageWithObj:(id)obj;
+ (UIImage *)syn_barImageWithObj:(id)obj;

@end

NS_ASSUME_NONNULL_END
