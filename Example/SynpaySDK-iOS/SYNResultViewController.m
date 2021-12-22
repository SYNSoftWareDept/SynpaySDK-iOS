//
//  SYNResultViewController.m
//  SynpaySDK-iOS_Example
//
//  Created by Boole on 2021/12/21.
//  Copyright © 2021 gosoftware@synjones.com. All rights reserved.
//

#import "SYNResultViewController.h"
#import "Masonry.h"

@interface SYNResultViewController () <UITableViewDelegate, UITableViewDataSource>

@property (copy  , nonatomic) NSArray *keys;
@property (copy  , nonatomic) NSDictionary *titles;
@property (copy  , nonatomic) NSDictionary *result;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation SYNResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)setPayResult:(NSDictionary *)result {
    _result = result;
    [self.tableView reloadData];
    NSString *title = [NSString stringWithFormat:@"%@", [result objectForKey:@"payName"]];
    self.navigationItem.title = title;
}

- (NSArray *)keys {
    return @[@"orderId", @"payName", @"jndatetime"];
}

- (NSDictionary *)titles {
    if (!_titles) {
        _titles = @{@"orderId"    : @"订单号",
                    @"payName"    : @"付款方式",
                    @"jndatetime" : @"交易时间"};
    }
    return _titles;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString *cellIdentifier = [NSString stringWithFormat:@"%@_cellIdentifier", NSStringFromClass(self.class)];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSString *key = [self.keys objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.titles objectForKey:key]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [self.result objectForKey:key]];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 260;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, tableView.bounds.size.width, 200);
    view.backgroundColor = UIColor.whiteColor;
    
    UIView *contentView = [[UIView alloc] init];
    [view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = [UIImage imageNamed:@"pay-success"];
    [contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(contentView);
        make.width.height.mas_equalTo(60);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = UIColor.grayColor;
    titleLabel.text = @"支付成功";
    [contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom).inset(5);
        make.centerX.equalTo(imageView);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = titleLabel.textColor;
    label.text = @"¥";
    [contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(contentView).inset(3);
        make.left.equalTo(contentView);
    }];
    
    UILabel *detailLabel = [[UILabel alloc] init];
    detailLabel.font = [UIFont systemFontOfSize:28];
    detailLabel.text = [NSString stringWithFormat:@"%.2f", [[self.result objectForKey:@"tranamt"] floatValue]/100];
    [contentView addSubview:detailLabel];
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).inset(15);
        make.left.mas_equalTo(label.mas_right).inset(5);
        make.right.bottom.equalTo(contentView);
    }];
    
    return view;
}



@end
