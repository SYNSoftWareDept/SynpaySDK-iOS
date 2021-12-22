//
//  ViewController.m
//  SynpayDemo
//
//  Created by Objective on 2021/11/14.
//

#import "SYNViewController.h"
#import "SYNResultViewController.h"
#import <SynpaySDK/SynpaySDK.h>
#import "UIImage+SYNCategory.h"
#import "MBProgressHUD.h"
#import "UIView+Toast.h"
#import "YYModel.h"
//#import "RSA.h"

@interface SYNViewController ()

@property (copy  , nonatomic) NSDate *qrcode;
@property (copy  , nonatomic) NSString *barcode;
@property (strong, nonatomic) NSArray *payTypes;

@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation SYNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)configUI {
    self.title = @"SDK demo";
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:YES];
    //  初始化SDK
    [self configSDK:nil];
}

- (NSString *)typeIdAtIndex:(NSInteger)index {
    if (index >= self.payTypes.count) return nil;
    return [[self.payTypes objectAtIndex:index] objectForKey:@"typeId"];
}

- (void)logResutlt:(NSDictionary *)result funcName:(NSString *)name {
    NSString *msg = [result objectForKey:@"msg"];
    NSInteger code = [[result objectForKey:@"code"] integerValue];
    NSString *toast = [NSString stringWithFormat:@"code=%zd, msg=%@", code, msg];
    [self.view makeToast:toast duration:3 position:CSToastPositionCenter];
    printf("\n%s", [name UTF8String]);
    printf("\ncode=%d \nmsg=%s \n%s\n", (int)code, [msg UTF8String], [[result description] UTF8String]);
    printf("=======================================================================================\n");
}

- (void)reloadViewWithBarcode:(NSString *)barcode qrcode:(id)qrcode {
    [self showHUDView:NO];
    if (!barcode && !qrcode) return;
    NSString *text = @"0000 0000 0000 0000 0000";
    if (barcode && barcode.length > 4) {
        text = [barcode substringToIndex:4];
        for (int i = 1; i < barcode.length/4; i++) {
            text = [NSString stringWithFormat:@"%@ %@", text, [barcode substringWithRange:NSMakeRange(4*i, 4)]];
        }
    }
    if (qrcode) {
        self.imageView.image = [UIImage syn_qrImageWithObj:qrcode];
    } else if (barcode) {
        self.imageView.image = [UIImage syn_barImageWithObj:barcode];
    }
    self.codeLabel.text = text;
}

- (void)showHUDView:(BOOL)show {
    if (show) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    } else {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
}

- (void)openResultView:(NSDictionary *)result {
    SYNResultViewController *rvc = [[SYNResultViewController alloc] init];
    [self.navigationController pushViewController:rvc animated:YES];
    [rvc setResult:result];
}
#pragma mark - 测试配置信息

- (SynpayConfig *)synConfig {
    //  开始测试前请先提供您的BundleId
    //  切换测试环境时BundleId也要更换
    SynpayConfig *config = [[SynpayConfig alloc] init];
    config.socketUtl = @"ws://219.143.144.135/websocket/mobile_service_platform/qrcode_ykt";
    config.serverUrl = @"http://219.143.144.135";
    config.appId = @"sdk";
    config.token = @"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc19maXJzdF9sb2dpbiI6dHJ1ZSwic25vIjoiMjM1NTEiLCJ1c2VyX25hbWUiOiIyMzU1MSIsInNjb3BlIjpbImFsbCJdLCJsb2dpbnR5cGUiOiJzbm8iLCJuYW1lIjoi5a6L5pmXIiwiaWQiOjIxODQsImV4cCI6MTY0NTAwMDA0NywibG9naW5Gcm9tIjoiYXBwIiwidXVpZCI6IjU2ZTA5YjI1ZmNhYWMxNmI4Zjk0ZDVhZGNhN2FmMDBiIiwianRpIjoiMjhhN2M3ODctZjIyMi00ODAxLThjODYtZmI1NzdmY2Y4YjM1IiwiY2xpZW50X2lkIjoibW9iaWxlX3NlcnZpY2VfcGxhdGZvcm0ifQ.HG9G4d9vJSQA3R8V6fM1JoIIA-6wX_cgjwexfkzFw1I";
    return config;
}

- (void)showPayListWithType:(NSInteger)type {
    if (self.payTypes.count) {
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"支付列表"
                                                                    message:@"请选择一种支付方式"
                                                             preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [ac addAction:cancel];
        for (int i = 0; i < self.payTypes.count; i++) {
            NSDictionary *dict = [self.payTypes objectAtIndex:i];
            NSString *account = [dict objectForKey:@"account"];
            NSString *payacc = [dict objectForKey:@"payacc"];
            NSString *name = [dict objectForKey:@"name"];
            NSString *typeId = [dict objectForKey:@"typeId"];
            NSString *title = [NSString stringWithFormat:@"%@-%@-%@", name, account, payacc];
            UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self getCodeWithType:type typeId:typeId];
            }];
            [ac addAction:action];
        }
        [self presentViewController:ac animated:YES completion:nil];
    } else {
        self.codeLabel.text = @"请先获取支付列表";
    }
}

- (void)getCodeWithType:(NSInteger)type typeId:(NSString *)typeId {
    [self showHUDView:YES];
    if (type == 0) {
        [SYNSharedPaySDK getOnlineCodeByTypeId:typeId completion:^(NSDictionary * _Nonnull result) {
            [self logResutlt:result funcName:@"getOnlineCodeByTypeId"];
            NSDictionary *data = [result objectForKey:@"data"];
            self.barcode = [data objectForKey:@"barcode"];
            [self reloadViewWithBarcode:self.barcode qrcode:nil];
        }];
    } else if (1 == type) {
        [SYNSharedPaySDK getOfflineCodeByTypeId:typeId completion:^(NSDictionary * _Nonnull result) {
            [self logResutlt:result funcName:@"getOfflineCodeByTypeId"];
            NSDictionary *data = [result objectForKey:@"data"];
            self.qrcode = [data objectForKey:@"qrcode"];
            self.barcode = nil;
            [self reloadViewWithBarcode:self.barcode qrcode:self.qrcode];
        }];
    } else if (2 == type) {
        [SYNSharedPaySDK getCompoundCodeByTypeId:typeId completion:^(NSDictionary * _Nonnull result) {
            [self logResutlt:result funcName:@"getCompoundCode"];
            NSDictionary *data = [result objectForKey:@"data"];
            self.barcode = [data objectForKey:@"barcode"];
            self.qrcode = [data objectForKey:@"qrcode"];
            [self reloadViewWithBarcode:self.barcode qrcode:self.qrcode];
        }];
    }
}

//  初始化SDK
- (IBAction)configSDK:(id)sender {
    [self showHUDView:YES];
    SynpayConfig *config = [self synConfig];
    [SYNSharedPaySDK startSDKWithConfig:config completion:^(NSDictionary *result) {
        [self showHUDView:NO];
        [self logResutlt:result funcName:@"startSDKWithConfig"];
        NSInteger code = [[result objectForKey:@"code"] integerValue];
        if (0 == code) [self getPayTypes:nil];
    }];
}

//  获取支付列表
- (IBAction)getPayTypes:(id)sender {
    [self showHUDView:YES];
    [SYNSharedPaySDK getPayTypes:^(NSDictionary * _Nonnull result) {
        [self showHUDView:NO];
        [self logResutlt:result funcName:@"getPayTypes"];
        NSInteger code = [[result objectForKey:@"code"] integerValue];
        if (0 == code) {
            self.payTypes = [result objectForKey:@"data"];
            if (!sender) [self getOnlineCode:nil];
        }
    }];
}

//  获取联机码
- (IBAction)getOnlineCode:(id)sender {
    [self showPayListWithType:0];
}

//  获取脱机码
- (IBAction)getOfflineCode:(id)sender {
    [self showPayListWithType:1];
}

//  获取复合码
- (IBAction)getCompoundCode:(id)sender {
    [self showPayListWithType:2];
}

//  监听联机码
- (IBAction)observeOnlineCode:(id)sender {
    [SYNSharedPaySDK observeBarcode:self.barcode completion:^(NSDictionary * _Nonnull result) {
        [self logResutlt:result funcName:@"observeBarcode"];
        NSInteger code = [[result objectForKey:@"code"] integerValue];
        if (200 == code) {
            [self openResultView:[result objectForKey:@"data"]];
        }
    }];
}

- (void)dealloc {
    //  关闭监听
    [SYNSharedPaySDK closeObserveBarcode];
}


//  byte 2 hex
+ (NSString *)hexStringFromByte:(Byte)bytes {
    NSMutableString *hexString = [NSMutableString string];
    [hexString appendFormat:@"%x", bytes >> 4];
    [hexString appendFormat:@"%x", bytes & 0xF];
    return hexString;
}

//  data 2 hex
+ (NSString *)hexStringFromData:(NSData *)data {
    if (!data || !data.length) return nil;
    NSMutableString *hexString = [NSMutableString string];
    Byte *bytes = (Byte *)[data bytes];
    for (int i = 0; i < data.length; i++) {
        [hexString appendString:[self hexStringFromByte:*(bytes+i)]];
    }
    return [hexString uppercaseString];
}

//  hex 2 data
+ (NSData *)dataFromHexString:(NSString *)hexStr {
    if (hexStr.length%2 != 0) return nil;
    NSMutableData *data = [[NSMutableData alloc] init];
    for (int i = 0 ; i<hexStr.length/2; i++) {
        NSString *str = [hexStr substringWithRange:NSMakeRange(i*2,2)];
        NSScanner *scanner = [NSScanner scannerWithString:str];
        int intValue;
        [scanner scanInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}

//  data 2 base64String
+ (NSString *)base64StringFromData:(NSData *)data {
    if (!data || !data.length) return nil;
    return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

//  base64String 2 data
+ (NSData *)dataFromBase64String:(NSString *)base64String {
    if (!base64String || !base64String.length) return nil;
    return [[NSData alloc] initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
}

// hex 2 base64
+ (NSString *)base64StringFromhexString:(NSString *)hexString {
    NSData *data = [self dataFromHexString:hexString];
    return [self base64StringFromData:data];
}

// base64 2 hex
+ (NSString *)hexStringFromBase64String:(NSString *)base64String {
    NSData *data = [self dataFromBase64String:base64String];
    return [self hexStringFromData:data];
}

@end
