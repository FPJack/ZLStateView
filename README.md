# ZLStateView


<img src="https://github.com/FPJack/ZLStateView/blob/master/test.GIF" width="50%" height="30%">

```ruby
pod 'ZLStateView'
```

UITableView,UICollectionView 一行代码集成数据空白状态视图

```ruby
    self.tableView.zl_stateViewDelegate = self;
```
状态视图默认的三种状态，可以自行定义更多状态
```ruby

    FOUNDATION_EXPORT ZLStateViewStatus const ZLStateViewStatusNoNetwork;
    FOUNDATION_EXPORT ZLStateViewStatus const ZLStateViewStatusError;
    FOUNDATION_EXPORT ZLStateViewStatus const ZLStateViewStatusNoData;
    
    // 设置状态视图状态，再刷新，协议方法根据状态值展示相对应的视图
    self.tableView.zl_stateViewStatus = ZLStateViewStatusNoData;
    [self.tableView zl_reloadStateView];

```

手动刷新状态视图
```ruby
    [self.tableView zl_reloadStateView];
```

自定义配置状态视图的协议方法

```ruby


/// 刷新空白视图的时候调用
- (void)zl_reloadStateView:(ZLStateView *)stateView;

///是否需要展示ImageView，默认是YES
- (BOOL )zl_imageViewShouldDisplayInStateView:(ZLStateView *)stateView;

///是否需要展示TitleLabel，默认是YES
- (BOOL )zl_titleLabelShouldDisplayInStateView:(ZLStateView *)stateView;
///是否需要展示DetailLabel，默认是NO
- (BOOL )zl_detailLabelShouldDisplayInStateView:(ZLStateView *)stateView;
///是否需要展示Button，默认是NO
- (BOOL )zl_buttonShouldDisplayInStateView:(ZLStateView *)stateView;
///是否需要展示状态视图，默认是NO,(UITableView,UICollectionView内部会自动判断数据源是否为空)
- (BOOL )zl_stateViewShouldDisplay;

/// 初始化stateView
- (void)zl_initializeStateView:(ZLStateView *)stateView;
///初始化TitleLabel
- (void)zl_initializeTitleLabel:(UILabel *)titleLabel inStateView:(ZLStateView *)stateView;
///初始化DetailLabel
- (void)zl_initializeDetailLabel:(UILabel *)detailLabel inStateView:(ZLStateView *)stateView;
///初始化ImageView
- (void)zl_initializeImageView:(UIImageView *)imageView inStateView:(ZLStateView *)stateView;
///初始化Button
- (void)zl_initializeButton:(UIButton *)button inStateView:(ZLStateView *)stateView;

/// 配置TitleLabel
- (void)zl_configureTitleLabel:(UILabel *)titleLabel inStateView:(ZLStateView *)stateView;
/// 配置DetailLabel
- (void)zl_configureDetailLabel:(UILabel *)detailLabel inStateView:(ZLStateView *)stateView;
/// 配置ImageView
- (void)zl_configureImageView:(UIImageView *)imageView inStateView:(ZLStateView *)stateView;
/// 配置Button
- (void)zl_configureButton:(UIButton *)button inStateView:(ZLStateView *)stateView;

///TitleLabel 后面的间距
- (CGFloat)zl_spacingAfterTitleLabelInStateView:(ZLStateView *)stateView;
///DetailLabel 后面的间距
- (CGFloat)zl_spacingAfterDetailLabelInStateView:(ZLStateView *)stateView;
///ImageView 后面的间距
- (CGFloat)zl_spacingAfterImageViewInStateView:(ZLStateView *)stateView;
///Button 后面的间距
- (CGFloat)zl_spacingAfterButtonInStateView:(ZLStateView *)stateView;

/// 垂直偏移量
- (CGFloat)zl_verticalOffsetInStateView:(ZLStateView *)stateView;

/// 是否使用自定义视图，返回YES则走自定义视图代理方法
- (BOOL)zl_useCustomViewInStateView:(ZLStateView *)stateView;
/// 自定义视图
- (UIView *)zl_customViewForStateView:(ZLStateView *)stateView;

/// Super view to add state view,控制器默认添加到self.view，视图默认添加到自身视图的父视图
- (UIView *)zl_superViewForStateView:(ZLStateView *)stateView;

/// stateView的frame，默认中心布局，高度自适应，宽度等于父视图宽度
- (CGRect)zl_frameForStateView:(ZLStateView *)stateView;
/// stateView的内边距，默认UIEdgeInsets(20,20,20,20)
- (UIEdgeInsets)zl_insetsForStateView:(ZLStateView *)stateView;
/// 按钮点击事件
- (void)zl_stateView:(ZLStateView *)stateView didTapButton:(UIButton *)button;
///如果是scrollview是否可以允许滑动
- (BOOL)zl_stateViewScrollEnabled:(ZLStateView *)stateView;
```
    
    
    




## Author

fanpeng, 2551412939@qq.com

## License

ZLStateView is available under the MIT license. See the LICENSE file for more info.
