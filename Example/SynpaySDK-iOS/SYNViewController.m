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
    config.socketUtl = @"ws://219.143.144.135/websocket/mobile_service_platform/qrcode_ykt";
    config.serverUrl = @"http://219.143.144.135";
    config.appId = @"sdk";
    config.token = @"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc19maXJzdF9sb2dpbiI6dHJ1ZSwic25vIjoiMjM1NTEiLCJ1c2VyX25hbWUiOiIyMzU1MSIsInNjb3BlIjpbImFsbCJdLCJsb2dpbnR5cGUiOiJzbm8iLCJuYW1lIjoi5a6L5pmXIiwiaWQiOjIxODQsImV4cCI6MTY0NTAwMDA0NywibG9naW5Gcm9tIjoiYXBwIiwidXVpZCI6IjU2ZTA5YjI1ZmNhYWMxNmI4Zjk0ZDVhZGNhN2FmMDBiIiwianRpIjoiMjhhN2M3ODctZjIyMi00ODAxLThjODYtZmI1NzdmY2Y4YjM1IiwiY2xpZW50X2lkIjoibW9iaWxlX3NlcnZpY2VfcGxhdGZvcm0ifQ.HG9G4d9vJSQA3R8V6fM1JoIIA-6wX_cgjwexfkzFw1I";
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
    [SYNSharedPaySDK closeObserveBarcode];
}



@end
