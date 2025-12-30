//
//  ZLViewController.m
//  ZLStateView
//
//  Created by fanpeng on 12/29/2025.
//  Copyright (c) 2025 fanpeng. All rights reserved.
//

#import "ZLViewController.h"
#import <ZLStateView/ZLStateView.h>
#import <ZLPopView/ZLPopView.h>
#import <FPRefresh/UIScrollView+Refresh.h>
@interface ZLViewController ()<IZLStateViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign)NSInteger sections;
@property (nonatomic,assign)CGFloat verticalOffset;
@property (nonatomic, strong) NSMutableArray *sortTags;
@property (nonatomic, assign)BOOL useCustomView;
@end

@implementation ZLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    self.tableView.zl_stateViewDelegate = self;
//    self.tableView.headerCanRefresh = YES;
//    self.tableView.refreshBlock = ^(RefreshType type) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            self.sections = 5;
//            [self.tableView reloadData];
//            [self.tableView end_Refresh];
//        });
//    };
//    [self.tableView begin_Refreshing];
//      
    ///导航栏添加右侧按钮
    ///
    UIButton *btn = UIButton.new;
    [btn setTitleColor:UIColor.orangeColor forState:UIControlStateNormal];
    [btn setTitle:@"切换" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(toggleDisplay:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
  
}
- (void)toggleDisplay:(UIButton *)sender {
    
    
    kPopViewColumnBuilder
        .tapMaskDismiss
        .space(10)
        .inset(10, 10, 10, 10)
        .addViewBK(^ViewKFCType  _Nonnull{
            return  UILabel.kfc.dismissPopViewWhenTap.text(@"空白页面").addTapAction(^(__kindof UIView * _Nonnull view) {
                self.tableView.zl_stateViewStatus = ZLStateViewStatusNoData;
                [self.tableView zl_reloadStateView];
            });
        })
    
        .addViewBK(^ViewKFCType  _Nonnull{
            return  UILabel.kfc.dismissPopViewWhenTap.text(@"无网络页面").addTapAction(^(__kindof UIView * _Nonnull view) {
                self.tableView.zl_stateViewStatus = ZLStateViewStatusNoNetwork;
                [self.tableView zl_reloadStateView];

            });
        })
        .addViewBK(^ViewKFCType  _Nonnull{
            return  UILabel.kfc.dismissPopViewWhenTap.text(@"错误页面").addTapAction(^(__kindof UIView * _Nonnull view) {
                self.tableView.zl_stateViewStatus = ZLStateViewStatusError;
                [self.tableView zl_reloadStateView];
            });
        })
        .addViewBK(^ViewKFCType  _Nonnull{
            return  UILabel.kfc.dismissPopViewWhenTap.text(@"垂直偏移100").addTapAction(^(__kindof UIView * _Nonnull view) {
                self.verticalOffset = 100;
                [self.tableView zl_reloadStateView];
            });
        })
        .addViewBK(^ViewKFCType  _Nonnull{
            return  UILabel.kfc.dismissPopViewWhenTap.text(@"垂直偏移-100").addTapAction(^(__kindof UIView * _Nonnull view) {
                self.verticalOffset = -100;
                [self.tableView zl_reloadStateView];
            });
        })
        .addViewBK(^ViewKFCType  _Nonnull{
            return  UILabel.kfc.dismissPopViewWhenTap.text(@"随机调整位置").addTapAction(^(__kindof UIView * _Nonnull view) {
                NSArray *sortTags = @[@10,@11,@12,@13];
                // 随机打乱数组
                NSArray *shuffledArray = [sortTags sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                    return arc4random_uniform(2) ? NSOrderedAscending : NSOrderedDescending;
                }];
                self.sortTags = [NSMutableArray arrayWithArray:shuffledArray];
               
                [self.tableView zl_reloadStateView];
            });
        })
        .addViewBK(^ViewKFCType  _Nonnull{
            return  UILabel.kfc.dismissPopViewWhenTap.text(@"显示自定义view").addTapAction(^(__kindof UIView * _Nonnull view) {
                self.useCustomView = YES;
                [self.tableView zl_reloadStateView];
            });
        })
        .addViewBK(^ViewKFCType  _Nonnull{
            return  UILabel.kfc.dismissPopViewWhenTap.text(@"恢复默认view").addTapAction(^(__kindof UIView * _Nonnull view) {
                self.useCustomView = NO;
                [self.tableView zl_reloadStateView];
            });
        })
        
        .buildPopOverView
        .setFromView(sender)
        .setDirection(ZLPopOverDirectionUp)
        .showPopView();
    
    
}

- (void)zl_reloadStateView:(ZLStateView *)stateView {
    if (self.sortTags.count == 4) {
        stateView.imageView.tag = [self.sortTags[0] integerValue];
        stateView.titleLabel.tag = [self.sortTags[1] integerValue];
        stateView.detailLabel.tag = [self.sortTags[2] integerValue];
        stateView.button.tag = [self.sortTags[3] integerValue];
    }
}

- (BOOL)zl_imageViewShouldDisplayInStateView:(ZLStateView *)stateView {
    return YES;
}
- (void)zl_configureImageView:(UIImageView *)imageView inStateView:(ZLStateView *)stateView {
    NSString *imageName = @"";
    if ([stateView.status isEqualToString:ZLStateViewStatusNoNetwork]) {
        imageName = @"placeholder_remote";
    }else if ([stateView.status isEqualToString:ZLStateViewStatusError]) {
        imageName = @"placeholder_dropbox";
    }else if ([stateView.status isEqualToString:ZLStateViewStatusNoData]) {
        imageName = @"emptyView";
    }
    imageView.image = [UIImage imageNamed:imageName];
}
- (CGFloat)zl_spacingAfterImageViewInStateView:(ZLStateView *)stateView {
    return 10;
}


- (BOOL)zl_titleLabelShouldDisplayInStateView:(ZLStateView *)stateView {
    return YES;
}
- (void)zl_configureTitleLabel:(UILabel *)titleLabel inStateView:(ZLStateView *)stateView {
    NSString *title = @"";
    if ([stateView.status isEqualToString:ZLStateViewStatusNoNetwork]) {
        title = @"无网络";
    }else if ([stateView.status isEqualToString:ZLStateViewStatusError]) {
        title = @"发生错误";
    }else if ([stateView.status isEqualToString:ZLStateViewStatusNoData]) {
        title = @"无数据";
    }
    titleLabel.text = title;
}
- (CGFloat)zl_spacingAfterTitleLabelInStateView:(ZLStateView *)stateView {
    return 15;
}
- (BOOL)zl_detailLabelShouldDisplayInStateView:(ZLStateView *)stateView {
    return YES;
}
- (void)zl_configureDetailLabel:(UILabel *)detailLabel inStateView:(ZLStateView *)stateView {
    NSString *title = @"";
    if ([stateView.status isEqualToString:ZLStateViewStatusNoNetwork]) {
        title = @"检查您的网络连接";
    }else if ([stateView.status isEqualToString:ZLStateViewStatusError]) {
        title = @"发生错误，请稍后重试";
    }else if ([stateView.status isEqualToString:ZLStateViewStatusNoData]) {
        title = @"暂无数据，请稍后再试";
    }
    detailLabel.text = title;
}
- (CGFloat)zl_spacingAfterDetailLabelInStateView:(ZLStateView *)stateView {
    return 20;
}

- (BOOL)zl_buttonShouldDisplayInStateView:(ZLStateView *)stateView {
    return YES;
}
- (void)zl_initializeButton:(UIButton *)button inStateView:(ZLStateView *)stateView {
    [button.widthAnchor constraintEqualToConstant:100].active = YES;
}
- (void)zl_configureButton:(UIButton *)button inStateView:(ZLStateView *)stateView {
    [button setTitle:@"重试" forState:UIControlStateNormal];
}
- (CGFloat)zl_spacingAfterButtonInStateView:(ZLStateView *)stateView {
    return 20;
}

- (CGFloat)zl_verticalOffsetInStateView:(ZLStateView *)stateView {
    return self.verticalOffset;
}

- (void)zl_stateView:(ZLStateView *)stateView didTapButton:(UIButton *)button {
    NSLog(@"Retry button tapped");
    kPopViewColumnBuilder
        .title(@"点击了重试按钮")
        .addConfirmViewStyleActionText(@"确认", nil)
        .showAlert();
}
- (BOOL)zl_stateViewScrollEnabled:(ZLStateView *)stateView {
    return NO;
}
- (UIView *)zl_superViewForStateView:(ZLStateView *)stateView {
    return self.tableView;
}

- (BOOL)zl_useCustomViewInStateView:(ZLStateView *)stateView {
    return self.useCustomView;
}
- (UIView *)zl_customViewForStateView:(ZLStateView *)stateView {
    UILabel *label = UILabel.new;
    label.backgroundColor = UIColor.orangeColor;
    label.text = @"这是一个自定义view";
    label.font = [UIFont boldSystemFontOfSize:38];
    label.numberOfLines = 0;
    label.textColor = UIColor.whiteColor;
    label.frame = CGRectMake(0, 0, 200, 50);
    label.center = CGPointMake(100, 100);
    label.textAlignment = NSTextAlignmentCenter;
    return label;
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
