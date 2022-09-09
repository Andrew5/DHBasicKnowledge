//
//  DHCodingViewController.m
//  DHBasicKnowledge
//
//  Created by jabraknight on 2021/8/16.
//

#import "DHCodingViewController.h"

@interface DHCodingViewController ()

@end
//系统非容器：（NSString，NSMutableString）
//
//不可变对象:
//    NSCopying :浅拷贝(指针拷贝)，引用计数器+1
//    NSMutableCopying:深拷贝（内容拷贝),重新开辟内存空间，指向新的地址；
//可变对象：
//    NSCopying和NSMutableCopying均为深拷贝;
//系统容器（NSArray，NSDictionary）
//
//不可变对象：
//    copy:浅拷贝
//    NSMutableCopying:深拷贝；
//可变对象：
//    copy和NSMutableCopying均为单层深拷贝；
//简单点说:除了继承NSObject对象的不可变对象的Copy为浅拷贝；其他的均为深拷贝。
//自定义类
//
//1、属性拷贝方法：
//
//1、@property 中使用copy，是对属性进行拷贝；优势防止外面数据更改，导致类
//中属性更改；
//2、对像下的属性可以也调用相应的`copyWithZone`或`mutableCopyWithZone`方法；
//2、自定义对象
//
//类的是实例拷贝，该类需要遵守 NSCopying 或 NSMutableCopying协议，实现
//- (id)copyWithZone:(NSZone *)zone 或
//- (id)mutableCopyWithZone:(nullable NSZone *)zone
//3、类的对象拷贝(继承问题)
//
//
//1 类直接继承自NSObject，无需调用[super copyWithZone:zone]
//2 父类实现了copy协议，子类也实现了copy协议，子类需要调用[super
//    copyWithZone:zone]
//3 父类没有实现copy协议，子类实现了copy协议，子类无需调用[super
//copyWithZone:zone]
//4、copyWithZone方法中要调用[[[self class] alloc] init]来分配内存
//[self class]因为可能指向子类；
//
//1.NSCopying协议
//若想令自己所写的对象具有拷贝功能，则需要实现NSCopying协议
//
//实现copyWithZone方法
//方法中应该用全能初始化方法，来初始化待拷贝的对象
////.h
//      @interface Person : NSObject <NSCopying>
//          @property (nonatomic,copy) NSString *name;
//          @property (nonatomic,readonly) NSArray *friends;
//          @property (nonatomic,assign) int age;
//          - (instancetype)initWithName:(NSString *)name age:(int)age;
//      @end
//    //.m
//      @interface Person ()
//        @property (nonatomic,readwrite,strong) NSMutableArray *friends;
//      @end
//      @implementation Person
//        - (instancetype)initWithName:(NSString *)name age:(int)age
//        {
//            self = [super init];
//            if (self) {
//                self.name = name;
//                self.age = age;
//                _friends = [NSMutableArray array];
//            }
//            return self;
//      }
//      ...
//      - (id)copyWithZone:(NSZone *)zone{
//          Person *p = [[[self class] allocWithZone:zone] initWithName:_name age:_age];
//          return p;
//      }
//     @end
//如果全能初始化不能满足要求，还应该手动的加上一些操作
//        //.h
//        @interface Person : NSObject <NSCopying>
//            @property (nonatomic,copy) NSString *name;
//            @property (nonatomic,readonly) NSArray *friends;
//            @property (nonatomic,assign) int age;
//            - (instancetype)initWithName:(NSString *)name age:(int)age;
//        @end
//        //.m
//        @interface Person ()
//          @property (nonatomic,readwrite,strong) NSMutableArray *friends;
//        @end
//        @implementation Person
//        - (instancetype)initWithName:(NSString *)name age:(int)age
//        {
//              self = [super init];
//                if (self) {
//                    self.name = name;
//                    self.age = age;
//                    _friends = [NSMutableArray array];
//                }
//                return self;
//      }
//      ...
//      - (id)copyWithZone:(NSZone *)zone{
//            Person *p = [[[self class] allocWithZone:zone] initWithName:_name age:_age];
//            p->_friends = [_friends mutableCopy]; //额外的代码
//
//            return p;
//        }
//    @end
//如果自定义对象分为可变版本和不可变版本,那么就要同时实现NSCopying与NSMutableCopying协议
//2.深拷贝与浅拷贝
//深拷贝浅拷贝的对比图
//容器
//⬇️
//A B C D   A的拷贝  B的拷贝  C的拷贝  D的拷贝
//⬆️        ⬆️
//浅拷贝     深拷贝
//浅拷贝与深拷贝对比后，浅拷贝之后的内容与原始内容均指向相同的对象。而深拷贝之后的内容所指的对象是原始内容中相关对象的一份拷贝
//复制对象时应该决定是深拷贝还是浅拷贝，一般情况下是浅拷贝,如果你所写的对象需要深拷贝，那么需要新增一个专门执行深拷贝的方法
//一、NSCoding理解
//
//NSCoder的具体子类使用NSCoder抽象类的接口在内存和其他格式之间转换对象和其他数据值，NSCoder可以提供基本的归档——把对象和数据存储在磁盘上，和分配——在不同进程和线程之间复制对象和其他数据。在Foundation框架中会提供NSCoder具体的子类，如：NSArchiver、NSUnarchiver、NSKeyedArchiver、NSKeyUnarchiver和NSPortCoder。NSCoder具体的子类统一称作：编码器类，他们的实例化对象则成为编码器对象，一个编码器对象如果只编码就称做：编码对象，一个编码器对象如果只解码就称作解码对象。
//——概述
//——NSCoder可以操作对象、标量、C数组、结构体和字符串，还有这些类型的指针。它不能操作的类型是那些跨平台执行的变量，例如：union、void *、函数指针和长链表的指针。
//——一个编码器对象储存object类型的信息连同object的数据，因此，一个从字节流解码的对象通常跟最初编码的对象是同一个类。然而，一个对象可以在编码的时候改变它的类；这是描述归档文件和序列化的编程指南。
//从coder中读取数据，并返回相应的类型对象；即反序列化
//
//-(id)initWithCoder:(NSCoder )coder;
//
//将对象转为二进制流，存储在磁盘中
//-(void)encodeWithCoder:(NSCoder )coder;
//注：一般对数据存储时，使用归档/解档；对象需要满足NSCoding协议，对它
//进行数据编码转化成二进制流，存储于磁盘中；解档是将序列化数据转化成
//对象，回调新的对象出来；
//
//如下面例子：Person.h
//
//@interface Person : NSObject<NSCoding>
//
//@property(nonatomic,strong) NSString *name;
//@property(nonatomic,strong) NSString *userNum;
//-(Person *)initWithName:(NSString *)newName andUserNum:(NSString *)newUserNum;
//
//>@end
//Person.m
//
//
//@implementation Person
//
//-(Person *)initWithName:(NSString *)newName andUserNum:(NSString *)newUserNum;
//{
//
//   self = [super init];
//    if (self) {
//      self.name = newName;
//      self.userNum = newUserNum;
//    }
//    return self;
//}
//
//-(void)encodeWithCoder:(NSCoder *)aCoder
//{
//    [aCoder encodeObject:self.name forKey:@"name"];
//    [aCoder encodeObject:self.userNum forKey:@"newUserNum"];
//}
//
//- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder // NS_DESIGNATED_INITIALIZER
//{
//    if (self = [super init]) {
//        self.name = [aDecoder decodeObjectForKey:@"newName"] ;
//        self.userNum = [aDecoder decodeObjectForKey:@"newUserNum"];
//    }
//    return self;
//}
//main.m
//
//Person *per1 = [[Person alloc]initWithName:@"小明" andUserNum:@"123"];
//Person *per2 = [[Person alloc]initWithName:@"小张" andUserNum:@"456"];
//NSArray *perArr = [NSArray arrayWithObjects:per1,per2, nil];
//
//NSData *perData = [NSKeyedArchiver archivedDataWithRootObject:perArr];
//NSLog(@"data = %@",perData);
//NSArray *perArr2 = [NSKeyedUnarchiver unarchiveObjectWithData:perData];
//NSLog(@"arr2 = %@",perArr2);
//打印结果:
//
//
//nscoding_Demo[46577:7372901] data = <62706c69 73743030 d4010203
//04050626 27582476 65727369 6f6e5824 6f626a65 63747359 24617263
//68697665 72542474 6f701200 0186a0aa 07080f15 16171d21 22235524
//6e756c6c d2090a0b 0e5a4e53 2e6f626a 65637473 5624636c 617373a2
//0c0d8002 80068009 d310110a 12131454 6e616d65 5a6e6577 55736572
//4e756d80 03800480 05625c0f 660e5331 3233d218 191a1b5a 24636c61
//73736e61 6d655824 636c6173 73657356 50657273 6f6ea21a 1c584e53
//4f626a65 6374d310 110a1e1f 14800780 08800562 5c0f5f20 53343536
//d2181924 25574e53 41727261 79a2241c 5f100f4e 534b6579 65644172
//63686976 6572d128 2954726f 6f748001 08111a23 2d323742 484d585f
//62646668 6f747f81 83858a8e 939ea7ae b1bac1c3 c5c7ccd0 d5dde0f2
//f5fa0000 00000000 01010000 00000000 002a0000 00000000 00000000
//00000000 00fc>
//2017-03-09 11:17:13.673968 nscoding_Demo[46577:7372901] arr2 = (
//    "<Person: 0x1004057a0>",
//    "<Person: 0x1004057c0>"
//)
//

@implementation DHCodingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
