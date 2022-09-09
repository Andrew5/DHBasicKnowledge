//
//  DHCategoryViewController.m
//  DHBasicKnowledge
//
//  Created by jabraknight on 2021/8/16.
//

#import "DHCategoryViewController.h"

@interface DHCategoryViewController ()

@end
//property 是包装数据的一种办法.尽管技术上可以实现在category里面声明一个property,但是应该尽量避免这样做.理由是,除了class延续类别外,是不可能用一个category对class添加一个实例变量.因此对于category同样也不可能合成一个实例变量去支持property.我们来切割下本来是实现person的class.你可能需要一个关于友谊的category声明方法,来操作关于这个person朋友的列表.在不知道描述的问题前,你也可以把property的friends列表放到友谊category里面.想这样:
//
//#import <Foundation/Foundation.h>
//@interface EOCPerson : NSObject
//@property (nonatomic, copy, readonly) NSString *firstName;
//@property (nonatomic, copy, readonly) NSString *lastName;
//- (id)initWithFirstName:(NSString*)firstName andLastName:(NSString*)lastName;
//@end
//@implementation EOCPerson
//// Methods
//@end
//
//@interface EOCPerson (Friendship)
//@property (nonatomic, strong) NSArray *friends;
//- (BOOL)isFriendsWith:(EOCPerson*)person;
//@end
//
//@implementation EOCPerson (Friendship)
//// Methods
//@end
//假如你进行编译,可是你将会收到编译器警告后结束warning: property 'friends' requires method 'friends' to bedefined - use @dynamic or provide a method implementation inthis category [-Wobjc-property-implementation]warning: property 'friends' requires method 'setFriends:' to bedefined - use @dynamic or provide a method implementation inthis category [-Wobjc-property-implementation]这个稍微有点含糊的警告意思是说不能用category合成一个实例变量,并且因此property需要有一个accessor方法来实现在category中.或者,可以声明accessor方法@dynamic,意味着你声明的变量将在运行时有效,但是编译时是看不到的.这可能发生的情况是如果你使用消息转发机制来拦截这个方法并且在运行时提供实现.
//
//为了避免category不能合成实例变量的问题,你可以使用关联的对象.例如,你可能需要去实现下面category内的关联:
//
//#import <objc/runtime.h>
//static const char *kFriendsPropertyKey = "kFriendsPropertyKey";
//@implementation EOCPerson (Friendship)
//
//- (NSArray*)friends {
// return objc_getAssociatedObject(self, kFriendsPropertyKey);
//}
//
//- (void)setFriends:(NSArray*)friends {
// objc_setAssociatedObject(self,kFriendsPropertyKey, friends,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//@end
//这样不是很完美的解决办法.是有大量的引用和容易出现内存管理错误.因为很容易就会忘记这个property是像这样实现的.例如,你可以用改变property的属性来修改内存管理语义.但是你同样需要去记得改变内存管理语义在setter内关联的对象.尽管这是一个不错的解决方案,但是我不推荐.
//
//同样,你可能希望这个实例变量可以支持这个friends数组是一个可变数组. 你可以带一个可变拷贝,但是这样又会是另外一种无尽的混乱开始进入你的代码基础.因此property在主要接口定义比在category里面定义要干净的多.
//
//在这个示例中,正确的解决办法就是把所有的property定义放到主接口声明.所有的数据封装在一个主接口定义的类中,主接口是唯一可以声明实例变量(数据)的地方.因为他们仅仅是定义一个实例变量和相关语法糖访问器方法,property受到相同的规则.category应该被想到用做一个类的方法扩展来扩展功能,而不是封装数据.也就是说,有些时候只读属性可以被成功的用在category中.例如,你可能想建立一个NSCalendar的category来返回一个包含月份字符串的数组.因为这个方法访问任何数据,并且这个property不支持一个实例变量,你可以实现这个category像这样:
//
//@interface NSCalendar (EOC_Additions)
//@property (nonatomic, strong, readonly) NSArray *eoc_allMonths;
//@end
//@implementation NSCalendar (EOC_Additions)
//- (NSArray*)eoc_allMonths {
// if ([self.calendarIdentifier
// isEqualToString:NSGregorianCalendar])
// {
// return @[@"January", @"February",
// @"March", @"April",
// @"May", @"June",
// @"July", @"August",
// @"September", @"October",
// @"November", @"December"];
// } else if ( /* other calendar identifiers */ ) {
// /* return months for other calendars */
// }}
//@end
//property所支持的实例变量将不会自动合成,因为所有所需的方法(这里只有一个只读方法)需要被实现.因此,编译器会发出警告.然而,即使在这种情况下,一般最好避免使用property. property的用意就在于依赖class对数据的支持.property是封装数据,在本例中,你在category内将替换声明方法为检索列表中的月份.
//
//@interface NSCalendar (EOC_Additions)
//- (NSArray*)eoc_allMonths;
//@end
//需要记住的事情1.把所有封装数据的property声明都在住接口中定义.2.在category中希望使用访问器方法来声明property,除非他是一个类延续(class-continuation)category

//一、区别
//
//1、静态方法在程序开始时生成内存，实例方法在程序运行中生成内存，所以静态方法可以直接调用。
//
//2、实例方法要先成生实例，通过实例调用方法，静态速度很快，但是多了会占内存。
//
//3、静态内存是连续的，因为是在程序开始时就生成了，而实例申请的是离散的空间，所以当然没有静态方法快，而且静态内存是有限制的，太多了程序会启动不了。
//
//4、类方法常驻内存，实例方法不是，所以类方法效率高但占内存。
//
//5、类方法在堆上分配内存，实例方法在堆栈上。
//
//6、实例方法需要先创建实例才可以调用，比较麻烦，类方法不用，比较简单。
//
//7、类方法，也称静态方法，指的是用static关键字修饰的方法。此方法属类本身的方法，不属于类的某一个实例（对象）。
//
//8、类方法中不可直接使用实例变量。其调用方式有三种：可直接调用、类名.方法名、对象名.方法名。
//
//9、实例方法指的是不用static关键字修饰的方法。每个实例对象都有自身的实例方法，互相独立，不共享一个。其调用方式只能是对象名+方法名。
//
//二、使用场景
//
//1、如果需要访问或者修改某个实例的成员变量时，将该方法定义成实例方法。类方法正好相反，它不需要访问或者修改某个实例的成员变量。
//
//2、类方法一般用于实现一些工具方法，比如对某个对象进行扩展，或者实现单例。
//
//3、事实上如果一个方法与他所在类型的实例无关，那么它就应该是静态的，决不会有人把它写成实例方法。所以所有的实例方法都与实例有关，既然与实例有关，那么创建实例就是必然的步骤，没有麻烦简单一说。实际上上你可以把所有的实例方法都写成静态的，将实例作为参数传入即可。
/*
1. + (id)alloc 分配内存；

2. - (id)init 方法（包括其他-(id)init...方法），只允许调用一次，并且要与 alloc方法 写在一起，在init方法中申请的内存，要在dealloc方法中释放（或者其他地方）；

3. - (void)awakeFromNib 使用Xib初始化后会调用此方法，一般不会重写此方法；

4. - (void)loadView 如果使用Xib创建ViewController，就不要重写该方法。一般不会修改此方法；

5. - (void)viewDidLoad 视图加载完成之后被调用，这个方法很重要，可以在此增加一些自己定义的控件，注意此时view的frame不一定是显示时候的frame，真实的frame会在 - (void)viewDidAppear: 后。
在iOS6.0+版本中在对象的整个生命周期中只会被调用一次，
这里要注意在iOS3.0~iOS5.X版本中可能会被重复调用，当ViewController收到内存警告后，会释放View，并调用viewDidUnload，之后会重新调用viewDidLoad，所以要支持iOS6.0以前版本的童鞋要注意这里的内存管理。
6. - (void)viewWillAppear:(BOOL)animated view 将要显示的时候，可以在此加载一些图片，和一些其他占内存的资源；
7. - (void)viewDidAppear:(BOOL)animated view 已经显示的时候；
8. - (void)viewWillDisappear:(BOOL)animated view 将要隐藏的时候，可以在此将一些占用内存比较大的资源先释放掉，在 viewWillAppear: 中重新加载。如：图片/声音/视频。如果View已经隐藏而又在内存中保留这些在显示前不会被调用的资源，那么App闪退的几率会增加，尤其是ViewController比较多的时候；

9. - (void)viewDidAppear:(BOOL)animated view 已经隐藏的时候；

10. - (void)dealloc，不要手动调用此方法，当引用计数值为0的时候，系统会自动调用此方法。
二、使用 NavigationController 去 Push 切换显示的View的时候，调用的顺序：

例如 从 A 控制器 Push 显示 B 控制器，

[(A *)self.navigationController pushViewController:B animated:YES]

1. 加载B控制器的View（如果没有的话）；

2. 调用 A 的 - (void)viewWillDisappear:(BOOL)animated；

3. 调用 B 的 - (void)viewWillAppear:(BOOL)animated；

4. 调用 A 的 - (void)viewDidDisappear:(BOOL)animated；

5. 调用 B 的 - (void)viewDidAppear:(BOOL)animated；

总结来说，ViewController 的切换是先调用 隐藏的方法，再调用显示的方法；先调用Will，再调用Did。
//加载A界面
1、调用 A 的 viewDidLoad
2、调用 A 的 viewWillAppear
3、调用 A 的 viewDidAppear
A -> B
4、调用 B 的 viewDidLoad
5、调用 A 的 viewWillDisappear
6、调用 B 的 viewWillAppear
7、调用 B 的 viewDidAppear
8、调用 A 的 viewDidDisappear
B -> A
9、 调用 A 的 viewWillAppear
10、调用 A 的 viewDidAppear
11、调用 B 的 dealloc

三、重新布局View的子View

- (void)viewWillLayoutSubviews

- (void)viewDidLayoutSubviews

//自定义View的init方法会默认调用initWithFrame方法
//1、动态查找到CustomView的init方法
//2、调用[super init]方法
//3、super init方法内部执行的的是[super initWithFrame:CGRectZero]
//4、若super发现CustomView实现了initWithFrame方法
//5、转而执行self(CustomView)的initWithFrame方法
//6、最后在执行init的其余部分
//OC中的super实际上是让某个类去调用父类的方法，而不是父类去调用某个方法，方法动态调用过程顺序是由下而上的（这也是为什么在init方法中进行createUI不会执行多次的原因，因为父类的initWithFrame没做createUI操作）。
//createUI方法最好在initWithFrame中调用，外部使用init或initWithFrame均可以正常执行createUI方法.
//addSubview的文档描述
//This method establishes a strong reference to view and sets its next responder to the receiver, which is its new superview.
//Views can have only one superview. If view already has a superview and that view is not the receiver, this method removes the previous superview before making the receiver its new superview.
//View有且仅有一个父视图，如果新的父视图与原父视图不一样，会将View在原视图中移除，添加到新视图上。
 */
@implementation DHCategoryViewController
- (void)loadViewIfNeeded {
    [super loadViewIfNeeded];
}

- (void)loadView {
    [super loadView];
}
//将要显示的时候
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewLayoutMarginsDidChange {//directionalLayoutMargins
    [super viewLayoutMarginsDidChange];
    self.view.directionalLayoutMargins = NSDirectionalEdgeInsetsMake(0, 0, 0, 30);
}
- (void)viewWillLayoutSubviews {//将要布局子视图
    [super viewWillLayoutSubviews];
}

- (void)viewDidLayoutSubviews {//已经布局子视图
    [super viewDidLayoutSubviews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//已经显示的时候  真实的frame会在这之后调用
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (@available(iOS 11.0, *)) {
        NSString *edgeStr = NSStringFromUIEdgeInsets(self.view.safeAreaInsets);
        NSString *layoutFrmStr = NSStringFromCGRect(self.view.safeAreaLayoutGuide.layoutFrame);
        NSLog(@"viewDidLoad safeAreaInsets = %@, layoutFrame = %@", edgeStr, layoutFrmStr);
    } else {
        // Fallback on earlier versions
    }
}

- (void)safeAreaInsetsDidChange {
    //写入变更安全区域后的代码...
    NSLog(@"safeAreaInsetsDidChange");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)createLayerView {
    //这样做的好处：切割的圆角不会产生混合图层，提高效率。
    //这样做的坏处：代码量偏多，且很多 UIView 都是使用约束布局，必须搭配 dispatch_after 函数来设置自身的 mask。因为只有在此时，才能把 UIView 的正确的 bounds 设置到 CAShapeLayer 的 frame 上。
    UIImageView *userHeaderImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header"]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CAShapeLayer *cornerLayer = [CAShapeLayer layer];
        extracted(cornerLayer, userHeaderImgView);
    });
}
static void extracted(CAShapeLayer *cornerLayer, UIImageView *userHeaderImgView) {
    UIBezierPath *cornerPath = [UIBezierPath bezierPathWithRoundedRect:userHeaderImgView.bounds cornerRadius:39];
    cornerLayer.path = cornerPath.CGPath;
    cornerLayer.frame = userHeaderImgView.bounds;
    userHeaderImgView.layer.mask = cornerLayer;
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
