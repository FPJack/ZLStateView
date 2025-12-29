//
//  ZLStateView.h
//  ZLStateView
//
//  Created by admin on 2025/12/29.
//

#import <UIKit/UIKit.h>
#import <HealthKit/HealthKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZLStateView;

@protocol IZLStateViewDelegate <NSObject>
@optional

/// Reload data of state view
- (void)zl_reloadStateView:(ZLStateView *)stateView;

///default is YES
- (BOOL )zl_imageViewShouldDisplayInStateView:(ZLStateView *)stateView;

///defalut is YES
- (BOOL )zl_titleLabelShouldDisplayInStateView:(ZLStateView *)stateView;
///defalut is NO
- (BOOL )zl_detailLabelShouldDisplayInStateView:(ZLStateView *)stateView;
///default is NO
- (BOOL )zl_buttonShouldDisplayInStateView:(ZLStateView *)stateView;
///default is NO
- (BOOL )zl_stateViewShouldDisplay;

/// Initialize views
- (void)zl_initializeStateView:(ZLStateView *)stateView;
- (void)zl_initializeTitleLabel:(UILabel *)titleLabel inStateView:(ZLStateView *)stateView;
- (void)zl_initializeDetailLabel:(UILabel *)detailLabel inStateView:(ZLStateView *)stateView;
- (void)zl_initializeImageView:(UIImageView *)imageView inStateView:(ZLStateView *)stateView;
- (void)zl_initializeButton:(UIButton *)button inStateView:(ZLStateView *)stateView;

/// Configure views
- (void)zl_configureTitleLabel:(UILabel *)titleLabel inStateView:(ZLStateView *)stateView;
- (void)zl_configureDetailLabel:(UILabel *)detailLabel inStateView:(ZLStateView *)stateView;
- (void)zl_configureImageView:(UIImageView *)imageView inStateView:(ZLStateView *)stateView;
- (void)zl_configureButton:(UIButton *)button inStateView:(ZLStateView *)stateView;

/// Spacing between views
- (CGFloat)zl_spacingAfterTitleLabelInStateView:(ZLStateView *)stateView;
- (CGFloat)zl_spacingAfterDetailLabelInStateView:(ZLStateView *)stateView;
- (CGFloat)zl_spacingAfterImageViewInStateView:(ZLStateView *)stateView;
- (CGFloat)zl_spacingAfterButtonInStateView:(ZLStateView *)stateView;

/// Vertical offset of the entire state view
- (CGFloat)zl_verticalOffsetInStateView:(ZLStateView *)stateView;

/// Custom view
- (UIView *)zl_customViewForStateView:(ZLStateView *)stateView;

/// Super view to add state view,控制器默认添加到self.view，视图默认添加到自身视图的父视图
- (UIView *)zl_superViewForStateView:(ZLStateView *)stateView;

/// Frame for state view
- (CGRect)zl_frameForStateView:(ZLStateView *)stateView;
/// Insets for state view
- (UIEdgeInsets)zl_insetsForStateView:(ZLStateView *)stateView;
/// Button tap action
- (void)zl_stateView:(ZLStateView *)stateView didTapButton:(UIButton *)button;

@end


typedef NSString * ZLStateViewStatus NS_STRING_ENUM;

FOUNDATION_EXPORT ZLStateViewStatus const ZLStateViewStatusNoNetwork;
FOUNDATION_EXPORT ZLStateViewStatus const ZLStateViewStatusError;
FOUNDATION_EXPORT ZLStateViewStatus const ZLStateViewStatusNoData;


@interface ZLStateView : UIView
/*
 如果要调整view的排列顺序，修改tag值即可，tag值越小，排列越靠前
 */

@property (nonatomic, strong, nullable,readonly) UIImageView *imageView; ///tag 10
@property (nonatomic, strong, nullable,readonly) UILabel *titleLabel; ///tag 11
@property (nonatomic, strong, nullable,readonly) UILabel *detailLabel; ///tag 12
@property (nonatomic, strong, nullable,readonly) UIButton *button; ///tag 13
///
@property (nonatomic, strong, nullable,readonly) UIView *customView;
///default is ZLStateViewStatusNoData
@property (nonatomic, copy) ZLStateViewStatus status;

@end

@interface NSObject (ZLStateView)
/// State view delegate
@property (nonatomic, weak, nullable) id<IZLStateViewDelegate> zl_stateViewdelegate;
///  Current state view status
@property (nonatomic, copy, nullable) ZLStateViewStatus zl_stateViewStatus;
/// Reload state view
- (void)zl_reloadStateView;
@end

NS_ASSUME_NONNULL_END
