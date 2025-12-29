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
- (BOOL )zl_titleLabelShouldDisplayInStateView:(ZLStateView *)stateView;
- (BOOL )zl_detailLabelShouldDisplayInStateView:(ZLStateView *)stateView;
- (BOOL )zl_imageViewShouldDisplayInStateView:(ZLStateView *)stateView;
- (BOOL )zl_buttonShouldDisplayInStateView:(ZLStateView *)stateView;
- (BOOL )zl_stateViewShouldDisplay;

- (void)zl_initializeStateView:(ZLStateView *)stateView;
- (void)zl_initializeTitleLabel:(UILabel *)titleLabel inStateView:(ZLStateView *)stateView;
- (void)zl_initializeDetailLabel:(UILabel *)detailLabel inStateView:(ZLStateView *)stateView;
- (void)zl_initializeImageView:(UIImageView *)imageView inStateView:(ZLStateView *)stateView;
- (void)zl_initializeButton:(UIButton *)button inStateView:(ZLStateView *)stateView;

- (void)zl_configureTitleLabel:(UILabel *)titleLabel inStateView:(ZLStateView *)stateView;
- (void)zl_configureDetailLabel:(UILabel *)detailLabel inStateView:(ZLStateView *)stateView;
- (void)zl_configureImageView:(UIImageView *)imageView inStateView:(ZLStateView *)stateView;
- (void)zl_configureButton:(UIButton *)button inStateView:(ZLStateView *)stateView;

- (CGFloat)zl_spacingAfterTitleLabelInStateView:(ZLStateView *)stateView;
- (CGFloat)zl_spacingAfterDetailLabelInStateView:(ZLStateView *)stateView;
- (CGFloat)zl_spacingAfterImageViewInStateView:(ZLStateView *)stateView;
- (CGFloat)zl_spacingAfterButtonInStateView:(ZLStateView *)stateView;

- (CGFloat)zl_verticalOffsetInStateView:(ZLStateView *)stateView;
- (UIView *)zl_customViewInStateView:(ZLStateView *)stateView;

- (UIView *)zl_superViewForStateView:(ZLStateView *)stateView;
- (CGRect)zl_frameForStateView:(ZLStateView *)stateView;
- (UIEdgeInsets)zl_insetsForStateView:(ZLStateView *)stateView;

- (void)zl_stateView:(ZLStateView *)stateView didTapButton:(UIButton *)button;

@end


typedef NSString * ZLStateViewStatus NS_STRING_ENUM;

FOUNDATION_EXPORT ZLStateViewStatus const ZLStateViewStatusNoNetwork;
FOUNDATION_EXPORT ZLStateViewStatus const ZLStateViewStatusError;
FOUNDATION_EXPORT ZLStateViewStatus const ZLStateViewStatusNoData;


@interface ZLStateView : UIView
@property (nonatomic, strong, nullable,readonly) UILabel *titleLabel;
@property (nonatomic, strong, nullable,readonly) UILabel *detailLabel;
@property (nonatomic, strong, nullable,readonly) UIImageView *imageView;
@property (nonatomic, strong, nullable,readonly) UIButton *button;
@property (nonatomic, strong, nullable,readonly) UIView *customView;
@property (nonatomic, copy) ZLStateViewStatus status;
@end


@interface NSObject (ZLStateView)
@property (nonatomic, weak, nullable) id<IZLStateViewDelegate> zl_stateViewdelegate;
@property (nonatomic, strong) ZLStateView *zl_stateView;
@property (nonatomic, copy, nullable) ZLStateViewStatus zl_stateViewStatus;
- (void)zl_reloadStateView;
@end

NS_ASSUME_NONNULL_END
