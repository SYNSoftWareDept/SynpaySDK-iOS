//
//  UIImage+SYNCategory.m
//  SynpaySDK_Example
//
//  Created by Boole on 2021/11/26.
//  Copyright © 2021 gosoftware@synjones.com. All rights reserved.
//

#import "UIImage+SYNCategory.h"

@implementation UIImage (SYNCategory)

#pragma mark - QR Image

+ (UIImage *)syn_qrImageWithObj:(id)obj {
    if ([obj isKindOfClass:NSString.class]) {
        return [self syn_qrImageWithString:obj];
    } else if ([obj isKindOfClass:NSData.class]) {
        return [self syn_qrImageWithData:obj];
    }
    return nil;
}

+ (UIImage *)syn_qrImageWithData:(NSData *)data {
    if (!data || !data.length) return nil;
    UIImage *sourceImage = [UIImage imageWithCIImage:[self syn_CIImageWithData:data type:1]];
    CGFloat minSize = MIN(UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.width);
    CGSize size = CGSizeMake(minSize, minSize);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextSetInterpolationQuality(UIGraphicsGetCurrentContext(), kCGInterpolationNone);
    [sourceImage drawInRect:(CGRect){.size = size}];
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

+ (UIImage *)syn_qrImageWithString:(NSString *)string {
    return [self syn_qrImageWithData:[string dataUsingEncoding:NSUTF8StringEncoding]];
}

#pragma mark - Bar Image

+ (UIImage *)syn_barImageWithObj:(id)obj {
    if ([obj isKindOfClass:NSString.class]) {
        return [self syn_barImageWithString:obj];
    } else if ([obj isKindOfClass:NSData.class]) {
        return [self syn_barImageWithData:obj];
    }
    return nil;
}

+ (UIImage *)syn_barImageWithData:(NSData *)data {
    if (!data || !data.length) return nil;
    CIImage *barcodeImage = [self syn_CIImageWithData:data type:0];
    CGFloat scaleX = UIScreen.mainScreen.bounds.size.width / barcodeImage.extent.size.width;
    CGFloat scaleY = UIScreen.mainScreen.bounds.size.width / barcodeImage.extent.size.height * 0.382;
    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY);
    CIImage *transformedImage = [barcodeImage imageByApplyingTransform:transform];
    return [UIImage imageWithCIImage:transformedImage];
}

+ (UIImage *)syn_barImageWithString:(NSString *)string {
    return [self syn_barImageWithData:[string dataUsingEncoding:NSUTF8StringEncoding]];
}

+ (CIImage *)syn_CIImageWithData:(NSData *)data type:(NSInteger)type {
    NSString *name = type?@"CIQRCodeGenerator":@"CICode128BarcodeGenerator";
    // 1.实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:name];
    // 2.恢复滤镜的默认属性 (因为滤镜有可能保存上一次的属性)
    [filter setDefaults];
    // 3.通过KVO设置滤镜, 传入data, 将来滤镜就知道要通过传入的数据生成二维码
    [filter setValue:data forKey:@"inputMessage"];
    if (!type) {
        // 4.设置生成的条形码的上，下，左，右的margins的值
        [filter setValue:[NSNumber numberWithInteger:0] forKey:@"inputQuietSpace"];
    }
    // 5.生成CIImage
    return [filter outputImage];
}
@end
