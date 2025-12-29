//
//  ZLStateView.m
//  ZLStateView
//
//  Created by admin on 2025/12/29.
//

#import "ZLStateView.h"
#import <objc/runtime.h>


ZLStateViewStatus const ZLStateViewStatusNoNetwork     = @"ZLStateViewStatusNoNetwork";
ZLStateViewStatus const ZLStateViewStatusError         = @"ZLStateViewStatusError";
ZLStateViewStatus const ZLStateViewStatusNoData        = @"ZLStateViewStatusNoData";

@interface ZLStateView ()
@property (nonatomic, strong, nullable) UILabel *titleLabel;
@property (nonatomic, strong, nullable) UILabel *detailLabel;
@property (nonatomic, strong, nullable) UIImageView *imageView;
@property (nonatomic, strong, nullable) UIButton *button;
@property (nonatomic, strong, nullable) UIView *customView;
@property (nonatomic,strong)UIStackView *stackView;
@property (nonatomic,strong)NSLayoutConstraint *centerYConstraint;
@property (nonatomic,strong)NSLayoutConstraint *topConstraint;
@property (nonatomic,strong)NSLayoutConstraint *bottomConstraint;

@property (nonatomic,strong)NSLayoutConstraint *stackcviewCenterYConstraint;


@end
@implementation ZLStateView
- (UIImageView *)__imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.tag = 10;
    }
    return _imageView;
}
- (UILabel *)__titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor darkTextColor];
        _titleLabel.tag = 11;

    }
    return _titleLabel;
}
- (UILabel *)__detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.font = [UIFont systemFontOfSize:14];
        _detailLabel.textColor = [UIColor lightGrayColor];
        _detailLabel.numberOfLines = 0;
        _detailLabel.tag = 12;

    }
    return _detailLabel;
}

- (UIButton *)__button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        [_button setTitleColor:[UIColor systemBlueColor] forState:UIControlStateNormal];
        _button.titleLabel.font = [UIFont systemFontOfSize:16];
        _button.layer.cornerRadius = 5;
        _button.layer.borderWidth = 1;
        _button.layer.borderColor = [UIColor systemBlueColor].CGColor;
        _button.backgroundColor = [UIColor clearColor];
        _button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _button.tag = 13;
    }
    return _button;
}
- (UIStackView *)stackView {
    if (!_stackView) {
        _stackView = [[UIStackView alloc] init];
        _stackView.axis = UILayoutConstraintAxisVertical;
        _stackView.alignment = UIStackViewAlignmentCenter;
        _stackView.spacing = 10;
        [self addSubview:_stackView];
        _stackView.translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint activateConstraints:@[
            [_stackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
            [_stackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
            self.stackcviewCenterYConstraint,
            [_stackView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        ]];
    }
    return _stackView;
}
- (NSLayoutConstraint *)centerYConstraint {
    if (!_centerYConstraint) {
        _centerYConstraint = [self.centerYAnchor constraintEqualToAnchor:self.superview.centerYAnchor];
    }
    return _centerYConstraint;
}
- (NSLayoutConstraint *)topConstraint {
    if (!_topConstraint) {
        _topConstraint = [self.stackView.topAnchor constraintEqualToAnchor:self.topAnchor];
    }
    return _topConstraint;
}
- (NSLayoutConstraint *)bottomConstraint {
    if (!_bottomConstraint) {
        _bottomConstraint = [self.stackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor];
    }
    return _bottomConstraint;
}
- (NSLayoutConstraint *)stackcviewCenterYConstraint {
    if (!_stackcviewCenterYConstraint) {
        _stackcviewCenterYConstraint = [self.stackView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor];
    }
    return _stackcviewCenterYConstraint;
}
@end
@interface ZLWeakObjectContainer : NSObject
@property (nonatomic, readonly, weak) id weakObject;
- (instancetype)initWithWeakObject:(id)object;
@end
@implementation ZLWeakObjectContainer
- (instancetype)initWithWeakObject:(id)object
{
    self = [super init];
    if (self) {
        _weakObject = object;
    }
    return self;
}
@end

@implementation NSObject (ZLStateView)
- (ZLStateView *)zl_stateView {
    return objc_getAssociatedObject(self, @selector(zl_stateView));
}
- (void)setZl_stateView:(ZLStateView *)zl_stateView {
    objc_setAssociatedObject(self, @selector(zl_stateView), zl_stateView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)setZl_stateViewdelegate:(id<IZLStateViewDelegate>)zl_stateViewdelegate {
    ZLWeakObjectContainer *container = [[ZLWeakObjectContainer alloc] initWithWeakObject:zl_stateViewdelegate];
    objc_setAssociatedObject(self, @selector(zl_stateViewdelegate), container, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (id<IZLStateViewDelegate>)zl_stateViewdelegate {
    ZLWeakObjectContainer *container = objc_getAssociatedObject(self, @selector(zl_stateViewdelegate));
    return container.weakObject;
}
- (ZLStateViewStatus)zl_stateViewStatus {
    return objc_getAssociatedObject(self, @selector(zl_stateViewStatus));
}
- (void)setZl_stateViewStatus:(ZLStateViewStatus)zl_stateViewStatus {
    objc_setAssociatedObject(self, @selector(zl_stateViewStatus), zl_stateViewStatus, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)zl_reloadStateView {
    
    if ([self zl_zl_stateViewShouldDisplay] == NO) {
        [self.zl_stateView removeFromSuperview];
        return;
    }
    
    UIView *superview = nil;
    if (!self.zl_stateView) {
        ZLStateView *stateView = [[ZLStateView alloc] initWithFrame:CGRectZero];
        self.zl_stateView = stateView;
        if ([self.zl_stateViewdelegate respondsToSelector:@selector(zl_initializeStateView:)]) {
            [self.zl_stateViewdelegate zl_initializeStateView:stateView];
        }
    }
    ZLStateView *stateView = self.zl_stateView;
    stateView.zl_stateViewStatus = self.zl_stateViewStatus;
    if ([self.zl_stateViewdelegate respondsToSelector:@selector(zl_superViewForStateView:)]) {
        superview = [self.zl_stateViewdelegate zl_superViewForStateView:stateView];
    }
    if (!superview) {
        if ([self isKindOfClass:UIView.class]) {
            superview = (UIView *)self;
        }else if ([self isKindOfClass:UIViewController.class]) {
            superview = ((UIViewController *)self).view;
        }
    }
    if (!superview) {
        [self.zl_stateView removeFromSuperview];
        return;
    }
    
    [superview addSubview:stateView];
    [self zl_setUI:stateView];
}
- (void)zl_setUI:(ZLStateView *)stateView {
    CGRect frame = CGRectZero;
    if ([self.zl_stateViewdelegate respondsToSelector:@selector(zl_frameForStateView:)]) {
        frame = [self.zl_stateViewdelegate zl_frameForStateView:stateView];
        stateView.frame = frame;
    }else {
        UIView *superView = stateView.superview;
        [stateView removeFromSuperview];
        [superView addSubview:stateView];
        stateView.translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint activateConstraints:@[
            [stateView.leadingAnchor constraintEqualToAnchor:stateView.superview.leadingAnchor],
            [stateView.trailingAnchor constraintEqualToAnchor:stateView.superview.trailingAnchor],
            stateView.centerYConstraint,
            [stateView.centerXAnchor constraintEqualToAnchor:stateView.superview.centerXAnchor],
        ]];
        [NSLayoutConstraint activateConstraints:@[stateView.topConstraint, stateView.bottomConstraint]];
    }
    
    if ([self.zl_stateViewdelegate respondsToSelector:@selector(zl_verticalOffsetInStateView:)]) {
        CGFloat offset = [self.zl_stateViewdelegate zl_verticalOffsetInStateView:stateView];
        [stateView stackView];
        if ([self.zl_stateViewdelegate respondsToSelector:@selector(zl_frameForStateView:)]) {
            stateView.stackcviewCenterYConstraint.constant = offset;
        }else {
            stateView.centerYConstraint.constant = offset;
        }
    }
    
    [self zl_addImageView:stateView];
    [self zl_addTitleLabel:stateView];
    [self zl_addDetailLabel:stateView];
    [self zl_addButton:stateView];
    [self zl_sortStackViewSubviews:stateView];
}
- (void)zl_sortStackViewSubviews:(ZLStateView *)stateView {
    NSArray *arrangedSubviews = stateView.stackView.arrangedSubviews;
    NSArray *sortSubviews = [arrangedSubviews sortedArrayUsingComparator:^NSComparisonResult(UIView *v1, UIView *v2) {
        return v1.tag < v2.tag ? NSOrderedAscending :
               v1.tag > v2.tag ? NSOrderedDescending :
               NSOrderedSame;
    }];
    
    if ([arrangedSubviews isEqualToArray:sortSubviews]) {
        return;
    }
    
    [UIView performWithoutAnimation:^{
        for (UIView *view in arrangedSubviews) {
            [stateView.stackView removeArrangedSubview:view];
            [view removeFromSuperview];
        }

        for (UIView *view in sortSubviews) {
            [stateView.stackView addArrangedSubview:view];
        }
    }];
}

- (BOOL)zl_zl_stateViewShouldDisplay {
    BOOL display = YES;
    if (self.zl_stateViewdelegate && [self.zl_stateViewdelegate respondsToSelector:@selector(zl_stateViewShouldDisplay)]) {
        display = [self.zl_stateViewdelegate zl_stateViewShouldDisplay];
    }
    return display;
}
- (void)zl_addCustomView:(ZLStateView *)stateView {
    if (!stateView.customView) {
        if ([self.zl_stateViewdelegate respondsToSelector:@selector(zl_customViewInStateView:)]) {
            UIView *customView = [self.zl_stateViewdelegate zl_customViewInStateView:stateView];
            if (customView) {
                stateView.customView = customView;
                [stateView.stackView addArrangedSubview:stateView.customView];
            }
        }
    }
}
- (void)zl_addImageView:(ZLStateView *)stateView {
    BOOL display = YES;
    if ([self.zl_stateViewdelegate respondsToSelector:@selector(zl_imageViewShouldDisplayInStateView:)]) {
        display = [self.zl_stateViewdelegate zl_imageViewShouldDisplayInStateView:stateView];
    }
    if (display) {
        if (!stateView.imageView) {
            stateView.imageView = [stateView __imageView];
            if ([self.zl_stateViewdelegate respondsToSelector:@selector(zl_initializeImageView:inStateView:)]) {
                [self.zl_stateViewdelegate zl_initializeImageView:stateView.imageView inStateView:stateView];
            }
            [stateView.stackView addArrangedSubview:stateView.imageView];
        }
        if ([self.zl_stateViewdelegate respondsToSelector:@selector(zl_configureImageView:inStateView:)]) {
            [self.zl_stateViewdelegate zl_configureImageView:stateView.imageView inStateView:stateView];
        }
        if ([self.zl_stateViewdelegate respondsToSelector:@selector(zl_spacingAfterImageViewInStateView:)]) {
            if (@available(iOS 11.0, *)) {
                [stateView.stackView setCustomSpacing:[self.zl_stateViewdelegate zl_spacingAfterImageViewInStateView:stateView] afterView:stateView.imageView];
            } else {
            }
        }
    }else {
        [stateView.stackView removeArrangedSubview:stateView.imageView];
        [stateView.imageView removeFromSuperview];
    }
}
- (void)zl_addTitleLabel:(ZLStateView *)stateView {
    BOOL display = YES;
    if ([self.zl_stateViewdelegate respondsToSelector:@selector(zl_titleLabelShouldDisplayInStateView:)]) {
        display = [self.zl_stateViewdelegate zl_titleLabelShouldDisplayInStateView:stateView];
    }
    if (display) {
        if (!stateView.titleLabel) {
            stateView.titleLabel = [stateView __titleLabel];
            if ([self.zl_stateViewdelegate respondsToSelector:@selector(zl_initializeTitleLabel:inStateView:)]) {
                [self.zl_stateViewdelegate zl_initializeTitleLabel:stateView.titleLabel inStateView:stateView];
            }
            [stateView.stackView addArrangedSubview:stateView.titleLabel];
        }
        if ([self.zl_stateViewdelegate respondsToSelector:@selector(zl_configureTitleLabel:inStateView:)]) {
            [self.zl_stateViewdelegate zl_configureTitleLabel:stateView.titleLabel inStateView:stateView];
        }
        if ([self.zl_stateViewdelegate respondsToSelector:@selector(zl_spacingAfterTitleLabelInStateView:)]) {
            if (@available(iOS 11.0, *)) {
                [stateView.stackView setCustomSpacing:[self.zl_stateViewdelegate zl_spacingAfterTitleLabelInStateView:stateView] afterView:stateView.titleLabel];
            } else {
            }
        }
    }else {
        [stateView.stackView removeArrangedSubview:stateView.titleLabel];
        [stateView.titleLabel removeFromSuperview];
    }
}
- (void)zl_addDetailLabel:(ZLStateView *)stateView {
    BOOL display = NO;
    if ([self.zl_stateViewdelegate respondsToSelector:@selector(zl_detailLabelShouldDisplayInStateView:)]) {
        display = [self.zl_stateViewdelegate zl_detailLabelShouldDisplayInStateView:stateView];
    }
    if (display) {
        if (!stateView.detailLabel) {
            stateView.detailLabel = [stateView __detailLabel];
            if ([self.zl_stateViewdelegate respondsToSelector:@selector(zl_initializeDetailLabel:inStateView:)]) {
                [self.zl_stateViewdelegate zl_initializeDetailLabel:stateView.detailLabel inStateView:stateView];
            }
            [stateView.stackView addArrangedSubview:stateView.detailLabel];
        }
        if ([self.zl_stateViewdelegate respondsToSelector:@selector(zl_configureDetailLabel:inStateView:)]) {
            [self.zl_stateViewdelegate zl_configureDetailLabel:stateView.detailLabel inStateView:stateView];
        }
        if ([self.zl_stateViewdelegate respondsToSelector:@selector(zl_spacingAfterDetailLabelInStateView:)]) {
            if (@available(iOS 11.0, *)) {
                [stateView.stackView setCustomSpacing:[self.zl_stateViewdelegate zl_spacingAfterDetailLabelInStateView:stateView] afterView:stateView.detailLabel];
            } else {
            }
        }
    }else {
        [stateView.stackView removeArrangedSubview:stateView.detailLabel];
        [stateView.detailLabel removeFromSuperview];
    }
}
- (void)zl_addButton:(ZLStateView *)stateView {
    BOOL display = NO;
    if ([self.zl_stateViewdelegate respondsToSelector:@selector(zl_buttonShouldDisplayInStateView:)]) {
        display = [self.zl_stateViewdelegate zl_buttonShouldDisplayInStateView:stateView];
    }
    if (display) {
        if (!stateView.button) {
            stateView.button = [stateView __button];
            if ([self.zl_stateViewdelegate respondsToSelector:@selector(zl_initializeButton:inStateView:)]) {
                [self.zl_stateViewdelegate zl_initializeButton:stateView.button inStateView:stateView];
            }
            [stateView.stackView addArrangedSubview:stateView.button];
            [stateView.button addTarget:self action:@selector(zl_didTapButton:) forControlEvents:UIControlEventTouchUpInside];
        }
        if ([self.zl_stateViewdelegate respondsToSelector:@selector(zl_configureButton:inStateView:)]) {
            [self.zl_stateViewdelegate zl_configureButton:stateView.button inStateView:stateView];
        }
        if ([self.zl_stateViewdelegate respondsToSelector:@selector(zl_spacingAfterButtonInStateView:)]) {
            if (@available(iOS 11.0, *)) {
                [stateView.stackView setCustomSpacing:[self.zl_stateViewdelegate zl_spacingAfterButtonInStateView:stateView] afterView:stateView.button];
            } else {
            }
        }
    }else {
        [stateView.stackView removeArrangedSubview:stateView.button];
        [stateView.button removeFromSuperview];
    }
}
- (void)zl_didTapButton:(UIButton *)button {
    if ([self.zl_stateViewdelegate respondsToSelector:@selector(zl_stateView:didTapButton:)]) {
        [self.zl_stateViewdelegate zl_stateView:self.zl_stateView didTapButton:button];
    }
}
@end
