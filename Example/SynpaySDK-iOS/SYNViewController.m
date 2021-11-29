//
//  SYNViewController.m
//  SynpaySDK-iOS
//
//  Created by gosoftware@synjones.com on 11/29/2021.
//  Copyright (c) 2021 gosoftware@synjones.com. All rights reserved.
//

#import "SYNViewController.h"
#import <SynpaySDK/SynpaySDK.h>
#import "UIImage+SYNCategory.h"

@interface SYNViewController ()

@property (strong, nonatomic) NSArray *payTypes;
@property (copy  , nonatomic) NSString *barcode;

@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation SYNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startSDK];
}

- (void)startSDK {
    NSLog(@"sdk version : %@", [SYNSharedPaySDK sdkVersion]);
    [self configSDK:nil];
}

- (void)logResutlt:(NSDictionary *)result {
    [result enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"%@ : %@", key, obj);
    }];
}

- (NSString *)typeId {
    NSDictionary *type = self.payTypes.firstObject;
    if (!type) return nil;
    return [type objectForKey:@"typeId"];
}

- (void)reloadViewWithBarcode:(NSString *)barcode qrcode:(id)qrcode {
    self.barcode = barcode;
    NSString *text = @"0000  0000  0000  0000  0000";
    if (barcode) {
        text = [barcode substringToIndex:4];
        for (int i = 1; i < barcode.length/4; i++) {
            text = [NSString stringWithFormat:@"%@  %@", text, [barcode substringWithRange:NSMakeRange(4*i, 4)]];
        }
    }
    self.codeLabel.text = text;
    if (qrcode) {
        self.imageView.image = [UIImage syn_qrImageWithObj:qrcode];
    } else if (barcode) {
        self.imageView.image = [UIImage syn_barImageWithObj:barcode];
    }
}

#pragma mark - 测试配置信息

- (SynpayConfig *)configZju {
    //  开始测试前请先提供您的BundleId
    //  切换测试环境时BundleId也要更换
    SynpayConfig *config = [[SynpayConfig alloc] init];
    config.socketUtl = @"wss://ecard.zju.edu.cn/websocket/mobile_service_platform/qrcode_ykt";
    config.serverUrl = @"https://ecard.zju.edu.cn";
    config.appKey = @"mobile_service_platform_sdk_secret";
    config.appId = @"sdk";
    config.token = @"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc19maXJzdF9sb2dpbiI6ZmFsc2UsInNubyI6IlpaMjAyMDAwMTczMCIsInVzZXJfbmFtZSI6IjEzMDUxNTU3OTk5Iiwic2NvcGUiOlsiYWxsIl0sImxvZ2ludHlwZSI6InZlcmlmaWNhdGlvbkNvZGUiLCJuYW1lIjoi6auY5Li95by6IiwiaWQiOjI3NzQ4OSwiZXhwIjoxNjQzMjgyMTc2LCJsb2dpbkZyb20iOiJhcHAiLCJ1dWlkIjoiYWExMWNhYjk1MjFiMWIyZWM0NWFhOGE4MTc1ZTZhN2EiLCJqdGkiOiI4ODZjNTliMC0wMTA4LTRjOGMtYTMzMS1kYmIwMGM1ODk5MDgiLCJjbGllbnRfaWQiOiJtb2JpbGVfc2VydmljZV9wbGF0Zm9ybSJ9.br-_GMZSxuVtq5YJRaNp3N1DLqk__-xNCT-Dz6PiTJw";
    return config;
}

#pragma mark - 初始化SDK

- (IBAction)configSDK:(id)sender {
    [SYNSharedPaySDK startSDKWithConfig:self.configZju completion:^(NSDictionary * _Nonnull result) {
        [self logResutlt:result];
        NSInteger code = [[result objectForKey:@"code"] integerValue];
        if (0 == code) [self getPayTypes:nil];
    }];
}

#pragma mark - 获取支付列表

- (IBAction)getPayTypes:(id)sender {
    [SYNSharedPaySDK getPayTypes:^(NSDictionary * _Nonnull result) {
        [self logResutlt:result];
        NSInteger code = [[result objectForKey:@"code"] integerValue];
        if (0 == code) {
            self.payTypes = [result objectForKey:@"data"];
            [self getOnlineCode:nil];
        }
    }];
}

#pragma mark - 获取联机码

- (IBAction)getOnlineCode:(id)sender {
    [SYNSharedPaySDK getOnlineCodeByTypeId:self.typeId completion:^(NSDictionary * _Nonnull result) {
        [self logResutlt:result];
        NSInteger code = [[result objectForKey:@"code"] integerValue];
        if (0 == code) {
            NSDictionary *data = [result objectForKey:@"data"];
            NSString *barcode = [data objectForKey:@"barcode"];
            [self reloadViewWithBarcode:barcode qrcode:nil];
        }
    }];
}

#pragma mark - 获取脱机码

- (IBAction)getOfflineCode:(id)sender {
    [SYNSharedPaySDK getOfflineCodeByTypeId:self.typeId completion:^(NSDictionary * _Nonnull result) {
        [self logResutlt:result];
        NSInteger code = [[result objectForKey:@"code"] integerValue];
        if (0 == code) {
            NSDictionary *data = [result objectForKey:@"data"];
            NSString *qrcode = [data objectForKey:@"qrcode"];
            [self reloadViewWithBarcode:nil qrcode:qrcode];
        }
    }];
}

#pragma mark - 获取复合码

- (IBAction)getCompoundCode:(id)sender {
    [SYNSharedPaySDK getCompoundCodeByTypeId:self.typeId completion:^(NSDictionary * _Nonnull result) {
        [self logResutlt:result];
        NSInteger code = [[result objectForKey:@"code"] integerValue];
        if (0 == code) {
            NSDictionary *data = [result objectForKey:@"data"];
            NSString *barcode = [data objectForKey:@"barcode"];
            NSString *qrcode = [data objectForKey:@"qrcode"];
            [self reloadViewWithBarcode:barcode qrcode:qrcode];
        }
    }];
}

#pragma mark - 监听联机码

- (IBAction)observeOnlineCode:(id)sender {
    [SYNSharedPaySDK observeBarcode:self.barcode completion:^(NSDictionary * _Nonnull result) {
        [self logResutlt:result];
    }];
}

#pragma mark - 关闭监听

- (void)dealloc {
    [SYNSharedPaySDK stopObserveBarcode];
}



@end
