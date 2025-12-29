//
//  ZLViewController.m
//  ZLStateView
//
//  Created by fanpeng on 12/29/2025.
//  Copyright (c) 2025 fanpeng. All rights reserved.
//

#import "ZLViewController.h"
#import <ZLStateView/ZLStateView.h>
@interface ZLViewController ()<IZLStateViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, assign)BOOL display;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign)NSInteger sections;
@end

@implementation ZLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    self.tableView.zl_stateViewdelegate = self;
    self.display = YES;
    
    [self.tableView zl_reloadStateView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.sections = 10;
        [self.tableView reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.sections = 0;
            [self.tableView  reloadData];
        });
    });
}
//- (BOOL)zl_stateViewShouldDisplay {
//    return self.display ;
//}
- (void)zl_configureImageView:(UIImageView *)imageView inStateView:(ZLStateView *)stateView {
    imageView.image = [UIImage imageNamed:@"placeholder_appstore"];
}
//- (CGFloat)zl_spacingAfterImageViewInStateView:(ZLStateView *)stateView {
//    return 30;
//}
- (void)zl_configureTitleLabel:(UILabel *)titleLabel inStateView:(ZLStateView *)stateView {
    titleLabel.text = @"No Data Available";
}
//- (CGFloat)zl_spacingAfterTitleLabelInStateView:(ZLStateView *)stateView {
//    return 50;
//}
- (void)zl_initializeButton:(UIButton *)button inStateView:(ZLStateView *)stateView {
    [button.widthAnchor constraintEqualToConstant:100].active = YES;
}
- (BOOL)zl_detailLabelShouldDisplayInStateView:(ZLStateView *)stateView {
    return self.display;
}
//- (CGFloat)zl_spacingAfterDetailLabelInStateView:(ZLStateView *)stateView {
//    return 70;
//}
- (BOOL)zl_buttonShouldDisplayInStateView:(ZLStateView *)stateView {
    return self.display;
}
- (void)zl_configureDetailLabel:(UILabel *)detailLabel inStateView:(ZLStateView *)stateView {
    detailLabel.text = @"Please check back later.";
}
- (void)zl_configureButton:(UIButton *)button inStateView:(ZLStateView *)stateView {
    [button setTitle:@"Retry" forState:UIControlStateNormal];
}
//- (CGFloat)zl_verticalOffsetInStateView:(ZLStateView *)stateView {
//    return 100;
//}
//- (CGRect)zl_frameForStateView:(ZLStateView *)stateView {
//    return CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height - 100);
//}

- (void)zl_stateView:(ZLStateView *)stateView didTapButton:(UIButton *)button {
    NSLog(@"Retry button tapped");
    stateView.imageView.tag = 11;
    stateView.titleLabel.tag = 10;
    [self.tableView zl_reloadStateView];
}
- (UIView *)zl_superViewForStateView:(ZLStateView *)stateView {
    return self.tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sections;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Row %ld", (long)indexPath.row];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections;
}
@end
