//
//  MasonryAutoViewController.m
//  DHBasicKnowledge
//
//  Created by jabraknight on 2021/8/16.
//

#import "MasonryAutoViewController.h"
#import "Masonry.h"
#import <YogaKit/UIView+Yoga.h>
#import "YDYLabel.h"

@interface MasonryAutoViewController ()
//https://zhuanlan.zhihu.com/p/35077511
//https://www.cnblogs.com/leonlincq/p/7272189.html
//业余
//https://www.jianshu.com/p/4d1dadcd2694
//https://www.jianshu.com/p/a731b99a8c8a
//http://t.zoukankan.com/novia-p-4497907.html
@property MASConstraint * expressWayViewHeight0;
@property MASConstraint * carWayViewViewHeight0;
@property (nonatomic, strong) NSMutableArray *masonryViewArray;
@end

@implementation MasonryAutoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *contentView = [[UIView alloc] init];
    [self.view addSubview:contentView];
    contentView.backgroundColor = [UIColor redColor];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.equalTo(@300);
    }];
    
    UILabel *label1 = [[UILabel alloc] init];
    [contentView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        //    make.centerX.equalTo(@0);
        make.left.equalTo(@50);
        make.right.equalTo(@-50);
    }];
    
    label1.numberOfLines = 0;
    // label.preferredMaxLayoutWidth = 200;
    [label1 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    label1.backgroundColor = [UIColor whiteColor];
    label1.text = @"苹果iOS15即将登场，界面设计焕然一新，比iOS14更漂亮";
    
    UILabel *label2 = [[UILabel alloc] init];
    [contentView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(20);
        make.left.equalTo(@50);
        make.right.equalTo(@-50);
        make.bottom.equalTo(@-20);
    }];
    
    label2.numberOfLines = 0;
    // label.preferredMaxLayoutWidth = 200;
    [label2 setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    label2.backgroundColor = [UIColor whiteColor];
    label2.text = @"虽然官方并没有举行任何预热活动，但事实上，目前外网已经传出了诸多关于iOS15系统的消息。综合来看，相比iOS14，iOS15仍是以提升体验为主，并不会有太多亮眼的新功能。";
    
    //     iOS Masonry的使用需要注意的地方
    //    使用前：AutoLayout关于更新的几个方法的区别
    //
    //    setNeedsLayout
    //    ：告知页面需要更新，但是不会立刻开始更新。执行后会立刻调用layoutSubviews。
    //
    //    layoutIfNeeded
    //    ：告知页面布局立刻更新。所以一般都会和setNeedsLayout一起使用。如果希望立刻生成新的frame需要调用此方法，利用这点一般布局动画可以在更新布局后直接使用这个方法让动画生效。
    //
    //    layoutSubviews
    //    ：系统重写布局
    //
    //    setNeedsUpdateConstraints
    //    ：告知需要更新约束，但是不会立刻开始
    //
    //    updateConstraintsIfNeeded
    //    ：告知立刻更新约束
    //
    //    updateConstraints
    //    ：系统更新约束
    //
    //     自动布局最重要的是约束
    //     ：UI元素间关系的数学表达式。约束包括尺寸、由优先级和阈值管理的相对位置。它们是添加剂，可能导致约束冲突
    //     、约束不足造成布局无法确定 。这两种情况都会产生异常。
    //
    //     使用前：AutoLayout关于更新的几个方法的区别
    //
    //     setNeedsLayout
    //     ：告知页面需要更新，但是不会立刻开始更新。执行后会立刻调用layoutSubviews。
    //
    //     layoutIfNeeded
    //     ：告知页面布局立刻更新。所以一般都会和setNeedsLayout一起使用。如果希望立刻生成新的frame需要调用此方法，利用这点一般布局动画可以在更新布局后直接使用这个方法让动画生效。
    //
    //     layoutSubviews
    //     ：系统重写布局
    //
    //     setNeedsUpdateConstraints
    //     ：告知需要更新约束，但是不会立刻开始
    //
    //     updateConstraintsIfNeeded
    //     ：告知立刻更新约束
    //
    //     updateConstraints
    //     ：系统更新约束
    //
    //     使用
    //
    //     基本使用
    //     mas_makeConstraints
    //     :添加约束
    //
    //     mas_updateConstraints
    //     ：更新约束、亦可添加新约束
    //
    //     mas_remakeConstraints
    //     ：重置之前的约束
    //
    //     multipler
    //     属性表示约束值为约束对象的乘因数,
    //     dividedBy
    //     属性表示约束值为约束对象的除因数，可用于设置view
    //     的宽高比
    //
    //     //
    //     进行屏幕的适配的时候，往往需要根据屏幕宽度来适配一个相应的高度，在此推荐使用如下约束的方式来进行控件的适配
    //     [self.topView
    //     addSubview:self.topInnerView];
    //
    //     [self.topInnerView mas_makeConstraints:^(MASConstraintMaker *make)
    //     {
    //
    //     make.height.equalTo(self.topView.mas_height).dividedBy(3);
    //
    //     make.width.and.height.lessThanOrEqualTo(self.topView);
    //
    //     make.width.and.height.equalTo(self.topView).with.priorityLow();
    //
    //     make.center.equalTo(self.topView);
    //
    //     }];
    //
    //     priorityLow()
    //     设置约束优先级
    //
    //     define
    //
    //     MAS_SHORTHAND_GLOBALS
    //     使用全局宏定义，可以使equalTo
    //     等效于mas_equalTo
    //
    //     define MAS_SHORTHAND
    //
    //     使用全局宏定义,
    //     可以在调用masonry方法的时候不使用mas_
    //     前缀
    //
    //     // 这里注意到一个地方，就是当使用了这个全局宏定义之后，发现可以有个类NSArray+MASAdditions.h，看了之后发现可以
    //     self.buttonViews = @[ raiseButton, lowerButton, centerButton ];
    //     // 之后可以在updateConstraints 方法中
    //
    //     (void)updateConstraints {
    //     [self.buttonViews updateConstraints:^(MASConstraintMaker *make) {
    //     make.baseline.equalTo(self.mas_centerY).with.offset(self.offset);
    //     }];
    //     [super updateConstraints];
    //     }
    //     动态修改视图约束:
    //
    //     // 创建视图约束
    //     [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
    //     self.animatableConstraint = make.edges.equalTo(superview).insets(paddingInsets).priorityLow();
    //     ]];
    //     // 更改约束 （另一处方法中）
    //     UIEdgeInsets paddingInsets = UIEdgeInsetsMake(padding, padding, padding, padding);
    //     self.animatableConstraint.insets = paddingInsets；
    //     [self layoutIfNeeded];
    //
    //     debug
    //     模式：
    //     // 对某个view添加key值
    //     greenView.mas_key = @"greenView";
    //     // 或者如下顺序
    //     MASAttachKeys(greenView, redView, blueView, superview);
    //     // 同样的对每条约束亦可以添加key
    //     make.height.greaterThanOrEqualTo(@5000).key(@"ConstantConstraint");
    //
    //     preferredMaxLayoutWidth
    //     :
    //     多行label的约束问题
    //
    //     // 已经确认好了位置
    //     // 在layoutSubviews中确认label的preferredMaxLayoutWidth值
    //
    //     (void)layoutSubviews {
    //     [super layoutSubviews];
    //     // 你必须在 [super layoutSubviews] 调用之后，longLabel的frame有值之后设置preferredMaxLayoutWidth
    //     self.longLabel.preferredMaxLayoutWidth = self.frame.size.width-100;
    //     // 设置preferredLayoutWidth后，需要重新布局
    //     [super layoutSubviews];
    //     }
    //     scrollView
    //     使用约束的问题：原理通过一个contentView来约束scrollView的contentSize大小，也就是说以子控件的约束条件，来控制父视图的大小
    //
    //     // 1. 控制scrollView大小（显示区域）
    //     [self.scrollView makeConstraints:^(MASConstraintMaker *make) {
    //     make.edges.equalTo(self.view);
    //     }];
    //     // 2. 添加一个contentView到scrollView，并且添加好约束条件
    //     [contentView makeConstraints:^(MASConstraintMaker *make) {
    //     make.edges.equalTo(self.scrollView);
    //     // 注意到此处的宽度约束条件，这个宽度的约束条件是比添加项
    //     make.width.equalTo(self.scrollView);
    //     }];
    //     // 3. 对contentView的子控件做好约束，达到可以控制contentView的大小
    //
    //     新方法：2个或2个以上的控件等间隔排序
    //
    //     /**
    //
    //     多个控件固定间隔的等间隔排列，变化的是控件的长度或者宽度值
    //     @param axisType 轴线方向
    //     @param fixedSpacing 间隔大小
    //     @param leadSpacing 头部间隔
    //     @param tailSpacing 尾部间隔
    //     */
    //     (void)mas_distributeViewsAlongAxis:(MASAxisType)axisType
    //     withFixedSpacing:(CGFloat)fixedSpacing l
    //     eadSpacing:(CGFloat)leadSpacing
    //     tailSpacing:(CGFloat)tailSpacing;
    //     /**
    //
    //     多个固定大小的控件的等间隔排列,变化的是间隔的空隙
    //     @param axisType 轴线方向
    //     @param fixedItemLength 每个控件的固定长度或者宽度值
    //     @param leadSpacing 头部间隔
    //     @param tailSpacing 尾部间隔
    //     */
    //     (void)mas_distributeViewsAlongAxis:(MASAxisType)axisType
    //     withFixedItemLength:(CGFloat)fixedItemLength
    //     leadSpacing:(CGFloat)leadSpacing
    //     tailSpacing:(CGFloat)tailSpacing;
    //     使用方法很简单，因为它是NSArray的类扩展：
    //
    //     // 创建水平排列图标 arr中放置了2个或连个以上的初始化后的控件
    //     // alongAxis 轴线方向 固定间隔 头部间隔 尾部间隔
    //     [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:5 tailSpacing:5];
    //     [arr makeConstraints:^(MASConstraintMaker *make) {
    //     make.top.equalTo(@60);
    //     make.height.equalTo(@60);
    //     }];
    //
    //     注意事项
    //     约束视图对象只有在被addSubview
    //     之后，才能给视图添加约束
    //
    //     当你的所有约束都在updateConstraints
    //
    //     内调用的时候，你就需要在此调用此方法，因为updateConstraints
    //     方法是需要触发的
    //
    //     // 调用在view 内部，而不是viewcontroller
    //
    //     (BOOL)requiresConstraintBasedLayout {
    //     return YES;
    //     }
    //     /**
    //
    //     苹果推荐 约束 增加和修改 放在此方法种
    //     */
    //     (void)updateConstraints {
    //     [self.growingButton updateConstraints:^(MASConstraintMaker *make) {
    //     make.center.equalTo(self);
    //     make.width.equalTo(@(self.buttonSize.width)).priorityLow();
    //     make.height.equalTo(@(self.buttonSize.height)).priorityLow();
    //     make.width.lessThanOrEqualTo(self);
    //     make.height.lessThanOrEqualTo(self);
    //     }];
    //     //最后记得回调super方法
    //     [super updateConstraints];
    //     }
    //     如果想要约束变换之后实现动画效果，则需要执行如下操作
    //
    //     // 通知需要更新约束，但是不立即执行
    //     [self setNeedsUpdateConstraints];
    //     // 立即更新约束，以执行动态变换
    //     // update constraints now so we can animate the change
    //     [self updateConstraintsIfNeeded];
    //     // 执行动画效果, 设置动画时间
    //     [UIView animateWithDuration:0.4 animations:^{
    //     [self layoutIfNeeded];
    //     }];
    //
    //     自动计算UITableViewCell高度
    //
    //     推荐使用一个库[UITableView-FDTemplateLayoutCell
    //
    //     想法：动态高度的cell, 主要关注的点是什么？
    //
    //     viewController本身不需要知道cell的类型
    //
    //     cell的高度与viewController没有相关性，cell的高度由cell本身来决定
    //
    //     viewController真正做到的是一个
    //
    //     以下是摘抄过来的
    //
    //     主要是UILabel的高度会有变化，所以这里主要是说说label变化时如何处理，设置UILabel的时候注意要设置
    //     preferredMaxLayoutWidth这个宽度，还有ContentHuggingPriority为
    //     UILayoutPriorityRequried
    //
    //     CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width - 10 * 2;
    //
    //     textLabel = [UILabel new];
    //     textLabel.numberOfLines = 0;
    //     textLabel.preferredMaxLayoutWidth = maxWidth;
    //     [self.contentView addSubview:textLabel];
    //
    //     [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //     make.top.equalTo(statusView.mas_bottom).with.offset(10);
    //     make.left.equalTo(self.contentView).with.offset(10);
    //     make.right.equalTo(self.contentView).with.offset(-10);
    //     make.bottom.equalTo(self.contentView).with.offset(-10);
    //     }];
    //
    //     [_contentLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    //
    //     如果版本支持最低版本为iOS
    //     8以上的话可以直接利用UITableViewAutomaticDimension在tableview的heightForRowAtIndexPath直接返回即可。
    //
    //     tableView.rowHeight = UITableViewAutomaticDimension;
    //     tableView.estimatedRowHeight = 80; //减少第一次计算量，iOS7后支持
    //
    //     (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //     // 只用返回这个！
    //     return UITableViewAutomaticDimension;
    //     }
    //     但如果需要兼容iOS
    //     8之前版本的话，就要回到老路子上了，主要是用systemLayoutSizeFittingSize来取高。步骤是先在数据model中添加一个
    //     height的属性用来缓存高，然后在table
    //     view的heightForRowAtIndexPath代理里static一个只初始化一次的Cell实例，然后根据model内容填充数据，最后根
    //     据cell的contentView的systemLayoutSizeFittingSize的方法获取到cell的高。具体代码如下
    //
    //     //在model中添加属性缓存高度
    //     @interface DataModel : NSObject
    //     @property (copy, nonatomic) NSString *text;
    //     @property (assign, nonatomic) CGFloat cellHeight; //缓存高度
    //     @end
    //
    //     (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //     static CustomCell *cell;
    //     //只初始化一次cell
    //     static dispatch_once_t onceToken;
    //     dispatch_once(&onceToken, ^{
    //     cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CustomCell class])];
    //     });
    //     DataModel *model = self.dataArray[(NSUInteger) indexPath.row];
    //     [cell makeupData:model];
    //     if (model.cellHeight <= 0) {
    //     //使用systemLayoutSizeFittingSize获取高度
    //     model.cellHeight = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
    //     }
    //     return model.cellHeight;
    //     }
    
}
///TODO: 自适应布局
- (void)test24{
   
    
    YDYLabel *_tagLeft = [[YDYLabel alloc]init];
    _tagLeft.font = [UIFont systemFontOfSize:(13)];
    _tagLeft.textColor = UIColor.redColor;
    _tagLeft.textAlignment = NSTextAlignmentCenter;
    [_tagLeft sizeToFit];
    _tagLeft.clipsToBounds = YES;
    _tagLeft.layer.cornerRadius = 13;
    _tagLeft.edgeInsets = UIEdgeInsetsMake(4.5, 9.5, 3.5, 8.5);
    _tagLeft.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_tagLeft];
    [_tagLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(27);
        make.width.mas_greaterThanOrEqualTo(27);
        make.top.mas_equalTo(105);
    }];
    _tagLeft.text = @"是的发送";
        //遮罩
//        UIView *maskView  = [[UIView alloc]init];
//        maskView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
//        [self.view addSubview:maskView];
//        [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self.view);
//        }];
    
//        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
//        view1.backgroundColor = [UIColor redColor];
//        [self.view addSubview:view1];
//        NSLog(@"111=%@", NSStringFromCGRect(view1.frame));
//        // 111={{100, 100}, {200, 200}}
//    
//        CGPoint point =CGPointMake(view1.frame.origin.x-50, view1.frame.origin.y);
//    
//        CGRect centerFrame1 = CGRectMake(view1.frame.origin.x-100, view1.frame.origin.y, 200, 200);
//    
//        CGRect rect = CGRectInset(centerFrame1, 30, 30);
//    
//        UIView *view2 = [[UIView alloc] initWithFrame:rect];
//        view2.backgroundColor = [UIColor yellowColor];
//        [self.view addSubview:view2];
//        NSLog(@"222=%@", NSStringFromCGRect(view2.frame));
    
//    tableViewxxx = UILabel.alloc.init;
//    tableViewxxx.backgroundColor = UIColor.redColor;
//    tableViewxxx.textColor = UIColor.blackColor;
//    NSString *lbtxt = @"优先完全显示内容，优先完全显示内容，优先完全显示内容，优先完全显示内容，且不多占像素优先完全显示内容，且不多占像素优先完全显示内容，且不多占像素优先完全显示内容，且不多占像素";
//    NSString *test = @"标题新增快递";
//    //    NSString *foot = @"请输入公司规模人数，附件及备注为必填内容；\n提交后，将由客户核心系统审核，如需加急处理请联系销售运营单晓柳。";
//    tableViewxxx.text = test;
//    tableViewxxx.numberOfLines = 0;
    //    NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    //    style.paragraphSpacingBefore =  4.0;//段落顶部与文本内容开头之间的距离
    //    style.firstLineHeadIndent = 4.0;//每段首行缩进
    //    style.lineSpacing = 0;//字体的行间距
    //    style.lineSpacing = 10 - (tableViewxxx.font.lineHeight - tableViewxxx.font.pointSize);
    ////    style.baseWritingDirection = 1;//写入方向
    //    style.hyphenationFactor = 0.7;//段落的连字属性
    //    style.alignment = NSTextAlignmentJustified;
    //    style.lineBreakMode = NSLineBreakByCharWrapping;
    //    style.alignment = NSTextAlignmentJustified;//文本对齐方式
    //    style.headIndent = 10.0f;
    //    style.tailIndent = -10.0f;
    ////
    //    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:lbtxt attributes:@{ NSParagraphStyleAttributeName : style}];
    //    tableViewxxx.attributedText = attrText;
//    [self.view addSubview:tableViewxxx];
//    UILabel * orangeLbl = [UILabel new];
//    orangeLbl.backgroundColor = [UIColor orangeColor];
//    [self.view addSubview:orangeLbl];
//    orangeLbl.text = @"设置最小宽度新增快递设置最小专车配送宽度新增快递设置最小宽度新增快递设置最小宽度新增快递";
//    self.infoLabel = orangeLbl;
//    self.infoLabel.numberOfLines = 0;
//
////    [tableViewxxx setContentCompressionResistancePriority:1000 forAxis:(UILayoutConstraintAxisHorizontal)];
//    [tableViewxxx mas_updateConstraints:^(MASConstraintMaker *make) {
//        //        make.bottom.equalTo(self.view.mas_bottom).offset(-100);
//        //        make.height.greaterThanOrEqualTo(@(20));
//        _expressWayViewHeight0 =  make.width.mas_greaterThanOrEqualTo(@(27)).priority(1000);
//                make.height.mas_offset(20);
//        //        make.left.equalTo(self.view).with.offset(50);
//        //        make.right.equalTo(self.view).with.offset(-50);
//        make.top.equalTo(self.view).with.offset(100);
//        make.leading.equalTo(self.view).offset(20).priority(750);
//        make.trailing.equalTo(self.infoLabel.mas_trailing).offset(20).priority(250);
//
//    }];
//    [tableViewxxx mas_makeConstraints:^(MASConstraintMaker *make) {
//        // 边界。不写优先级，默认优先级最高 = UILayoutPriorityRequired = 1000
//        make.leading.top.greaterThanOrEqualTo(self.view);
//        make.trailing.bottom.lessThanOrEqualTo(self.view);
//        // 确定宽高
//        make.width.mas_equalTo(50);
//        make.height.mas_equalTo(50);
//        // 确定位置。高优先级，可变动的位置。
//        self.expressWayViewHeight0 = make.top.equalTo(self.view).offset(50).priority(750);
//        self.carWayViewViewHeight0 = make.leading.equalTo(self.view).offset(50).priority(750);
//    }];
   
//    [self.infoLabel setContentCompressionResistancePriority:250 forAxis:(UILayoutConstraintAxisVertical)];
//    [self.infoLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(tableViewxxx.mas_right).offset(10);
//        make.top.equalTo(tableViewxxx.mas_top);
//        _carWayViewViewHeight0 =  make.height.mas_greaterThanOrEqualTo(30).priority(250);
//        //          make.width.mas_greaterThanOrEqualTo(self.view.frame.size.width * 0.5 - 10); // 设置最小宽度
//        make.right.equalTo(self.view.mas_right).offset(-10);  // 设置距离右边最小距离
//    }];
//    [self performSelector:@selector(startScan) withObject:nil afterDelay:0.5];
    //    [UIView animateWithDuration:1.0 animations:^{
    //        [tableViewxxx layoutIfNeeded];
    //    }];
    //    PasteboardButton *repeatCopyBtn = [PasteboardButton buttonWithType:UIButtonTypeCustom];
    //    repeatCopyBtn.titleLabel.text= @"复制按钮";
    //    repeatCopyBtn.titleLabel.textColor = UIColor.blackColor;
    //    repeatCopyBtn.titleString = @"123123123";
    //    [self.view addSubview:repeatCopyBtn];
    //    [repeatCopyBtn mas_updateConstraints:^(MASConstraintMaker *make) {
    ////        make.bottom.equalTo(self.view.mas_bottom).offset(-100);
    //        make.height.greaterThanOrEqualTo(@(30));
    ////        make.height.lessThanOrEqualTo(@(50));
    ////        make.height.mas_offset(300);
    //        make.left.equalTo(self.view).with.offset(50);
    //        make.right.equalTo(self.view).with.offset(-50);
    //        make.top.equalTo(tableViewxxx.mas_bottom).with.offset(10);
    //
    //    }];
    
    //    self.mytextview = [[UITextView alloc] init];
    //    [maskView addSubview:self.mytextview];
    //    self.mytextview.scrollEnabled = YES;
    //    self.mytextview .layer.cornerRadius = 4;
    //    self.mytextview .layer.masksToBounds = YES;
    ////    拖动tableview时隐藏键盘
    //    self.mytextview .keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;//UIScrollViewKeyboardDismissModeInteractive
    //    self.mytextview .delegate = self;
    //    self.mytextview .layer.borderWidth = 1;
    //    self.mytextview .font = [UIFont systemFontOfSize:14];
    //    self.mytextview .layer.borderColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:0.4] CGColor];
    //    self.mytextview.textColor = UIColor.redColor;
    //    //加下面一句话的目的是，是为了调整光标的位置，让光标出现在UITextView的正中间
    //    self.mytextview.textContainerInset = UIEdgeInsetsMake(10,0, 0, 0);
    //    self.mytextview.text = @"我是inputview";
    //dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //    UIView *lasView = self.mytextview.subviews.lastObject;
    //    lasView.hidden = false;
    //    lasView.alpha = 1;
    //});
    //
    //    [self.mytextview mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.height.mas_offset(60);
    //        make.left.equalTo(maskView).with.offset(0);
    //        make.right.equalTo(maskView).with.offset(0);
    //        make.bottom.equalTo(tableViewxxx.mas_top);
    ////        make.top.equalTo(tableViewxxx.mas_top).offset(5);
    //    }];
    //    self.mytextview.backgroundColor = [UIColor whiteColor];
    //    self.mytextview.layer.borderColor = [UIColor orangeColor].CGColor;
    //    self.mytextview.layer.borderWidth = 5.0;
    //
    //    UILabel * leftlbl = [UILabel new];
    // [maskView addSubview:leftlbl];
    // UILabel * rightLbl = [UILabel new];
    // [maskView addSubview:rightLbl];
    //
    // leftlbl.backgroundColor = [UIColor yellowColor];
    // rightLbl.backgroundColor = [UIColor redColor];
    //
    // [rightLbl mas_makeConstraints:^(MASConstraintMaker *make) {
    //     make.top.equalTo(maskView.mas_top).offset(100);
    //     make.right.equalTo(maskView.mas_right).offset(-10);
    //     make.width.mas_greaterThanOrEqualTo(100);   // 这是最小宽度
    // }];
    // [leftlbl mas_makeConstraints:^(MASConstraintMaker *make) {
    //     make.left.equalTo(maskView.mas_left).offset(10);
    //     make.top.equalTo(maskView.mas_top).offset(100);
    //     make.right.equalTo(rightLbl.mas_left).offset(-10);
    //     make.width.mas_greaterThanOrEqualTo(100);
    // }];
    //
    // leftlbl.text = @"这是左边的文字-";
    // rightLbl.text = @"这是右边的文字-这是右边的文字-这是右边的文字-";
    //
    // // 设置抗压缩优先级
    // [leftlbl setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    // [rightLbl setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    //
    /*
     左右两边数据均不足的时候，谁拉伸：
     这个由HuggingPriority控制。
     如果想让左边的内容拉伸，就设置左边的数值<250（或让右边的>250）；如果想让右边的内容拉伸，就设置右边的数值<250 (或让左边的>250)。左右两个Label对比，数值越大，越不想被拉伸，结果也不会被拉伸；数值越小，越容易被拉伸。
          
     
     左右两边数据都充足的时候，谁收缩：
     这个由ContentCompressionResistancePriority控制。如果想让左边的内容收缩，就设置左边的数值<750（或让右边的>750）;如果想让右边的内容收缩，就设置右边的数值<750（或让左边的>750）。
     
     */
    //
    //    NSString *ui = @"";
    //    NSLog(@"条件 %d",ui.length>0);
    //    orangeLbl.hidden = ui.length>0;
    //
    //    /*
    //    UILabel *testNamelabnel = UILabel.alloc.init;
    //    testNamelabnel.backgroundColor = UIColor.redColor;
    //    testNamelabnel.textColor = UIColor.blackColor;
    //    testNamelabnel.text = @"标签标签标签";
    //    testNamelabnel.numberOfLines = 1;
    //    [self.view addSubview:testNamelabnel];
    //    [testNamelabnel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    //    [testNamelabnel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.bottom.equalTo(self.mytextview.mas_top).offset(-100);
    //        make.left.equalTo(self.view.mas_left).offset(15);
    //        make.height.offset(20);
    //        //        make.height.lessThanOrEqualTo(@(30));
    //    }];
    //
    //
    //    UILabel *testlabnel = UILabel.alloc.init;
    //    testlabnel.backgroundColor = UIColor.redColor;
    //    testlabnel.textColor = UIColor.blackColor;
    //    testlabnel.text = @"优先完全显示内容，且不多占像素优先完全显示内容，且不多占像素优先完全显示内容，且不多占像素优先完全显示内容，且不多占像素";
    //    testlabnel.numberOfLines = 0;
    //    [self.view addSubview:testlabnel];
    //    // 内容紧凑 - 优先完全显示内容，且不多占像素。
    //    //    [self.departmentContent setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    //    //    [self.departmentContent setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    //
    //    //    [self.departmentContent setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    //    [testlabnel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    //    [testlabnel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        //        make.bottom.equalTo(self.mytextview.mas_top).offset(-100);
    //        make.top.equalTo(testNamelabnel.mas_top);
    //        make.left.equalTo(testNamelabnel.mas_right);
    //        make.right.equalTo(self.mytextview.mas_right);
    //        //        make.height.greaterThanOrEqualTo(@(30));
    //        make.height.greaterThanOrEqualTo(testNamelabnel.mas_height);
    //
    //    }];
    //
    //    UIView *testView = UIView.alloc.init;
    //    testView.backgroundColor = UIColor.blackColor;
    //    [self.view addSubview:testView];
    //    [testView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        //        make.bottom.equalTo(self.mytextview.mas_top).offset(-100);
    //        make.top.equalTo(testlabnel.mas_bottom);
    //        make.left.equalTo(self.mytextview.mas_left);
    //        make.right.equalTo(self.mytextview.mas_right);
    //        make.height.mas_offset(50);
    //        //        make.height.lessThanOrEqualTo(@(30));
    //    }];
    //
    
//    for (UIView *view in self.containerView.subviews) {
//        [view removeFromSuperview];
//    }
//    UIView *firstView;/// 记录每行第一个view
//    UIView *lastView;/// 记录当前view
//    CGFloat space = 25.f;/// 这个间距设置的是子控件距离父视图上下左右以及子视图之间的间距，请根据需要设置相关参数
//    int col = 3;/// 定义列数
//    for (int i = 0; i < 控件数量数组.count; i++) {
//        UIView *view = [[UIView alloc] init];
//        view.backgroundColor = UIColor.redColor;
//        [self.containerView addSubview:view];
//        if (i % col == 0) {
//            firstView = view;
//        }
//        if (lastView) {
//            if (i % col == 0) {
//                [view mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.top.equalTo(lastView.mas_bottom).offset(space);
//                    make.left.equalTo(self.containerView).offset(space);
//                    make.width.equalTo(lastView);
//                }];
//            } else {
//                [view mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.left.equalTo(lastView.mas_right).offset(space);
//                    make.top.width.equalTo(lastView);
//                    if (i % col == col - 1) {///这边是设置每行最后一个view的约束
//                        make.right.equalTo(self.containerView).offset(-space);
//                    }
//                }];
//            }
//        } else {
//            [view mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(self.containerView).offset(12);
//                make.left.equalTo(self.containerView).offset(space);
//            }];
//        }
//        lastView = view;
//    }
//  /// 添加最后一个view的bottom约束，这样就可以撑开整个containerView了，可以做到根据控件数量自适应高度
//    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.containerView).offset(-25);
//    }];
    
    
    //     */
    ///TODO:
    ///    [self.serviceAction setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    ///    Axis Horizontal 水平轴
    ///    Axis Vertical 垂直
    ///    setContentCompressionResistancePriority ==> 表示当前的Label的内容不想被收缩
    
//    ///TODO: 循环按钮
    NSMutableArray *arrayView = [NSMutableArray new];
    NSArray *titleArr = @[@"导航栏",@"Swift",@"GIF",@"keyboard",@"Super",@"UIImage图片文件大小",@"扫码",@"autocell",@"设备",@"qrcode"];
    int countNum = (int)titleArr.count;
    for (int i = 0; i < countNum; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor redColor];
        [self.view addSubview:button];
        button.tag = 100+i;
        [button setTitle:titleArr[i] forState:(UIControlStateNormal)];
        [button addTarget:self action:@selector(tagButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [arrayView addObject:button];

    }
    /**
     *  distribute with fixed spacing
     *
     *  @param axisType     横排还是竖排
     *  @param fixedSpacing 两个控件间隔
     *  @param leadSpacing  第一个控件与边缘的间隔
     *  @param tailSpacing  最后一个控件与边缘的间隔
     */
    //    - (void)mas_distributeViewsAlongAxis:(MASAxisType)axisType withFixedSpacing:(CGFloat)fixedSpacing leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing;
    /**
     *  distribute with fixed item size
     *
     *  @param axisType        横排还是竖排
     *  @param fixedItemLength 控件的宽或高
     *  @param leadSpacing     第一个控件与边缘的间隔
     *  @param tailSpacing     最后一个控件与边缘的间隔
     */
    //    - (void)mas_distributeViewsAlongAxis:(MASAxisType)axisType withFixedItemLength:(CGFloat)fixedItemLength leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing;
    [arrayView mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:2 leadSpacing:2 tailSpacing:2];
    //    [arrayView mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:wi leadSpacing:10 tailSpacing:10];
    [arrayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@120);
        //        make.height.equalTo(@30);
    }];
}
- (void)test25{
    _masonryViewArray = [NSMutableArray array];
    for (int i = 0; i<6; i++) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor redColor];
        [self.view addSubview:view];
        [_masonryViewArray addObject:view];
    }
    [self test_masonry_vertical_fixSpace];
//    [self test_masonry_vertical_fixItemWidth];
//    // 实现masonry水平固定间隔方法
//    [self.masonryViewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:30 leadSpacing:10 tailSpacing:10];
//
//    // 设置array的垂直方向的约束
//    [self.masonryViewArray mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.equalTo(@150);
//        make.height.equalTo(@80);
//    }];
    //        [self test_masonry_horizontal_fixItemWidth];
    //        [self.view updateConstraintsIfNeeded];
    
    /**
     *  distribute with fixed spacing
     *
     *  @param axisType     横排还是竖排
     *  @param fixedSpacing 两个控件间隔
     *  @param leadSpacing  第一个控件与边缘的间隔
     *  @param tailSpacing  最后一个控件与边缘的间隔
     */
    //    - (void)mas_distributeViewsAlongAxis:(MASAxisType)axisType withFixedSpacing:(CGFloat)fixedSpacing leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing;
    
    /**
     *  distribute with fixed item size
     *
     *  @param axisType        横排还是竖排
     *  @param fixedItemLength 控件的宽或高
     *  @param leadSpacing     第一个控件与边缘的间隔
     *  @param tailSpacing     最后一个控件与边缘的间隔
     */
    //    - (void)mas_distributeViewsAlongAxis:(MASAxisType)axisType withFixedItemLength:(CGFloat)fixedItemLength leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing;
    
}
- (void)test_masonry_horizontal_fixSpace {
    //实现masonry水平固定间隔方法
    [self.masonryViewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:30 leadSpacing:10 tailSpacing:10];
    //设置array的垂直方向的约束
    [self.masonryViewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@150);
        make.height.equalTo(@80);
    }];
}
- (void)test_masonry_horizontal_fixItemWidth {
    //实现masonry水平固定空间宽度方法
    [self.masonryViewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:80 leadSpacing:10 tailSpacing:10];
    //设置array的垂直方向的约束
    [self.masonryViewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@150);
        make.height.equalTo(@80);
    }];
}
- (void)test_masonry_vertical_fixSpace {
    //实现masonry垂直固定控件高度方法
    [self.masonryViewArray mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:30 leadSpacing:10 tailSpacing:10];
    //设置array的水平方向的约束
    [self.masonryViewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@150);
        make.width.equalTo(@80);
    }];
}
- (void)test_masonry_vertical_fixItemWidth {
    //实现masonry垂直固定控件高度方法
    [self.masonryViewArray mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:80 leadSpacing:10 tailSpacing:10];
    //设置array的水平方向的约束
    [self.masonryViewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@150);
        make.width.equalTo(@80);
    }];
}

//TODO: YOGAKIT 布局
- (void)yogaViews {
    //https://www.jianshu.com/p/9c7230c40ca9
    //https://www.jianshu.com/p/1a1f41098c7f
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor lightGrayColor];
    [view configureLayoutWithBlock:^(YGLayout * layout) {
        layout.isEnabled = YES;
        layout.width = YGPointValue(self.view.bounds.size.width);
        layout.height = YGPointValue(self.view.bounds.size.height);
        layout.alignItems = YGAlignCenter;
    }];
    
    UIView *contentView = [[UIView alloc]init];
    contentView.backgroundColor = [UIColor brownColor];
    [contentView configureLayoutWithBlock:^(YGLayout * layout) {
        layout.isEnabled = true;
        // 4
        layout.flexDirection =  YGFlexDirectionRow;
        layout.width = YGPointValue(320);
        layout.height = YGPointValue(80);
        layout.marginTop = YGPointValue(100);
        
        layout.padding =  YGPointValue(10);//设置了全部子项目的填充值
    }];
    
    UIView *child1 = [[UIView alloc]init];
    child1.backgroundColor = [UIColor redColor];
    [child1 configureLayoutWithBlock:^(YGLayout * layout) {
        layout.isEnabled = YES;
        layout.width = YGPointValue(80);
        layout.marginRight = YGPointValue(10);
    }];
    
    
    
    UIView *child2 = [[UIView alloc]init];
    child2.backgroundColor = [UIColor blueColor];
    [child2 configureLayoutWithBlock:^(YGLayout * layout) {
        layout.isEnabled = YES;
        layout.width = YGPointValue(80);
        layout.flexGrow = 1;
        layout.height = YGPointValue(20);
        layout.alignSelf = YGAlignCenter;
        
    }];
    [contentView addSubview:child1];
    [contentView addSubview:child2];
    [view addSubview:contentView];
    [self.view addSubview:view];
    [view.yoga applyLayoutPreservingOrigin:YES];
    
    /*
     更新布局
     很多时候，我们的视图大小是依据视图内容来决定的,比如按钮的宽依据title进行调整，title变了，宽也要变，暂时只找到用markDirty实现的方法。
     
     FlexBox是一套通用的布局协议，YogaKit实现了这个协议，iOS端可以使用YogaKit来实现FlexBox布局。FlexBox和UIStackView以及Android的LineLayout有相通的地方，优势在于FlexBox是跨平台的，功能上也更强一点。
     
     YogaKit依据你的设置计算出相关的view的frame,直接设置frame,所以和AutoLayout可以混合使用，对同一个view进行设置，以AutoLayout的设置为准。
     
     YogaKit是从从上往下进行计算的，使用过程中需要保证flex container的frame有值，这样它的flex item才会计算出frame，否则都是CGRectZero。
     
     flex direction
     
     布局延伸的方向，确定了主轴和副轴，添加的元素沿着主轴的方向进行排列。
     
     Row
     
     水平方向从左往右进行延伸，主轴为水平方向，副轴为竖直方向
     
     Row Reverse
     
     水平方向从左往右进行延伸，主轴为水平方向，副轴为竖直方向
     
     Column
     
     竖直方向从上往下进行延伸，主轴为竖直方向，副轴为水平方向
     
     Column Reverse
     
     竖直方向从下往上进行延伸，主轴为竖直方向，副轴为水平方向
     
     justify & align-items
     
     justify 进一步明确了元素在主轴方向如何排列，align-items 进一步明确了元素在副轴方向如何排列
     
     flex start
     center
     end
     space between
     space around
     space evenly
     stretch
     flex-wrap (适用于父类容器上)
     设置或检索伸缩盒对象的子元素超出父容器时是否换行
     
     padding & margin
     
     iOS 上 padding 对应的是 content inserts，但是 iOS 大部分控件都没有padding,相信很多人都写过一个继承自 UILabel的控件来提供设置 content inserts 的控件，有了YogaKit，那个类以后用不上了。
     
     padding 指的是自身内边距，margin 指的是外边距，@"H:|-20-[redView]-20-|"，这条VFL里的20就是margin。
     
     display
     
     是否显示这个元素，如果为none,则不显示，也不参与计算
     
     
     */
    
    UIView *brownView = [[UIView alloc]init];
    brownView.backgroundColor = [UIColor brownColor];
    [brownView configureLayoutWithBlock:^(YGLayout * layout) {
        layout.isEnabled = true;
        // 4
        layout.flexDirection =  YGFlexDirectionRow;
        layout.width = YGPointValue(self.view.bounds.size.width);
        layout.height = YGPointValue(100);
        layout.marginTop = YGPointValue(100);
        
        layout.padding =  YGPointValue(10);//设置了全部子项目的填充值
    }];
    [self.view addSubview:brownView];
    
    NSArray *tags = @[@"投资理财",@"超高收益",@"七日年化收益",@"支付宝",@"微信",@"云闪付",@"花呗"];
    
    UIView *tagBgView = [[UIView alloc] init];
    
    tagBgView.backgroundColor = [UIColor lightGrayColor];
    [tagBgView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionRow;//布局方向
        layout.marginTop = YGPointValue(0);
        layout.paddingBottom = YGPointValue(10);
        layout.width = YGPointValue([UIScreen mainScreen].bounds.size.width);
        // 不设置高度，让高度自适应
        layout.flexWrap = YGWrapWrap;
    }];
    
    [view addSubview:tagBgView];
    
    for (NSString *obj in tags) {
        UILabel *label = [[UILabel alloc] init];
        
        label.text = obj;
        label.backgroundColor = [UIColor orangeColor];
        [label configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
            layout.isEnabled =YES;
            layout.marginLeft = YGPointValue(10);
            layout.marginTop = YGPointValue(10);
        }];
        
        [tagBgView addSubview:label];
    }
    
    view.yoga.isEnabled = YES;
    [view.yoga applyLayoutPreservingOrigin:NO];
    
}

//TODO: masonry进阶
- (void)startScan{
//    if ([tableViewxxx.text containsString:@"标题"]) {
//        [_carWayViewViewHeight0 uninstall];
//        [_expressWayViewHeight0 install];
//    }
//    else if ([self.infoLabel.text containsString:@"宽度"]) {
//        [_carWayViewViewHeight0 install];
//        [_expressWayViewHeight0 uninstall];
//    }
//    _carWayViewViewHeight0.height.equalTo(@30);//.priority(1000);
//    self.expressWayViewHeight0 .offset(100);
//    self.carWayViewViewHeight0 .offset(100);
//    [tableViewxxx mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.view).offset(100).priority(750);
//        make.leading.mas_equalTo(self.view).offset(100).priority(750);
//    }];
//    [UIView animateWithDuration:1.0 animations:^{
//        [self.infoLabel layoutIfNeeded];
//    }];
    
//    if ([tableViewxxx.text containsString:@"新增快递"] ||[self.infoLabel.text containsString:@"原路返回"]) {
//                                [_carWayViewViewHeight0 uninstall];
//                                [_expressWayViewHeight0 install];
//                            }else if ([tableViewxxx.text containsString:@"自行派送"] ||[self.infoLabel.text containsString:@"专车配送"]) {
//                                [_carWayViewViewHeight0 install];
//                                [_expressWayViewHeight0 uninstall];
//                            }
    [UIView animateWithDuration:1.0 animations:^{
        [self.view layoutIfNeeded];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
