//
//  SYNViewController.m
//  SynpaySDK-iOS
//
//  Created by gosoftware@synjones.com on 11/29/2021.
//  Copyright (c) 2021 gosoftware@synjones.com. All rights reserved.
//

#import "SYNViewController.h"
#import <SynpaySDK/SynpaySDK.h>

@interface SYNViewController ()

@end

@implementation SYNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configSDK];
}

- (void)configSDK
{
    NSLog(@"SynpaySDK version : %@", [SYNSharedPaySDK sdkVersion]);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self configSDK];
}

@end
