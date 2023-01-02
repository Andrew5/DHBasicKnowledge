//
//  DHObjectDetail.m
//  DHBasicKnowledge_Example
//
//  Created by jabraknight on 2021/8/16.
//  Copyright © 2021 localhost3585@gmail.com. All rights reserved.
//

#import "DHObjectDetail.h"
#import "WTTestObject.h"
#import "ApplicationList.h"
//#import "GKNavigationBarConfigure.h"

#import <malloc/malloc.h>
#import <objc/message.h>
#import <CommonCrypto/CommonCrypto.h>

#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include "WTTestC.h"
#include "TopKaAgorithm.h"


struct StructOne {
    char a;         //1字节
    double b;       //8字节
    int c;          //4字节
    short d;        //2字节
} MyStruct1;

struct StructTwo {
    double b;       //8字节
    char a;         //1字节
    short d;        //2字节
    int c;         //4字节
} MyStruct2;
struct LGStruct1{
    char b;
    int c;
    double a;
    short d;
}struct1;
struct LGStruct2{
    double a;
    int b;
    char c;
    short d;
}struct2;
struct LGStruct3{
    double a;
    int b;
    char c;
    struct LGStruct1 str1;
    short d;
    int e;
    struct LGStruct2 str2;
}struct3;
//官方对于NSObject的解释如下:
//The root class of most Objective-C class hierarchies, from which subclasses inherit a basic interface to the runtime system and the ability to behave as Objective-C objects.
//
//大意是:这个类是大多说 Objective-C类的基类, 为子类提供了访问运行时系统的基本接口,并使子类具有 Objective-C对象的基本能力.
//
//NSObject.h方法分类
//
//1.加载及初始化方法
//2.消息发送方法
//3.复制方法
//4.判断方法
//5.内存管理方法
//
//下面具体看下
//#pragma mark - 类部分
//
//OBJC_AVAILABLE(10.0, 2.0, 9.0, 1.0)
//OBJC_ROOT_CLASS
//OBJC_EXPORT
//@interface NSObject <NSObject> {
//Class isa OBJC_ISA_AVAILABILITY;
//}
//
//1.加载及初始化方法
//
///** 运行时加载类或分类调用该方法,每个类只会调用一次 */
//+ (void)load;
//
///** 类实例化使用前需要先初始化,
// 一个类调用一次,
//如果子类没有实现该方法则会调用父类方法 */
//+ (void)initialize;
//
///** 初始化对象 */
//- (instancetype)init
//#if NS_ENFORCE_NSOBJECT_DESIGNATED_INITIALIZER
//NS_DESIGNATED_INITIALIZER
//#endif
//;
//
///** 为新对象分配内存空间并初始化,
// 等于[[NSObject alloc] init] */
//+ (instancetype)new OBJC_SWIFT_UNAVAILABLE("use object initializers instead");
//
///** 为新对象分配内存空间, 参数传nil */
//+ (instancetype)allocWithZone:(struct _NSZone *)zone OBJC_SWIFT_UNAVAILABLE("use object initializers instead");
//
///** 为新对象分配内存空间 */
//+ (instancetype)alloc OBJC_SWIFT_UNAVAILABLE("use object initializers instead");
///** 释放对象, 当对象的引用计数为0时会调用此方法 */
//- (void)dealloc OBJC_SWIFT_UNAVAILABLE("use 'deinit' to define a de-initializer");
///** 垃圾回收器调用此方法前处理它所使用的内存。 */
//- (void)finalize OBJC_DEPRECATED("Objective-C garbage collection is no longer supported");
//
//2.消息发送方法
//
///** 发送指定的消息给对象,
//返回消息执行结果(相当于方法调用) */
//- (id)performSelector:(SEL)aSelector;
//
///** 发送带一个参数的消息给对象,
//返回消息执行结果(相当于方法调用) */
//- (id)performSelector:(SEL)aSelector withObject:(id)object;
//
///** 发送带两个参数的消息给对象,
//返回消息执行结果(相当于方法调用) */
//- (id)performSelector:(SEL)aSelector withObject:(id)object1 withObject:(id)object2;
//
///** 判断实例是否能够调用给定的方法 */
//+ (BOOL)instancesRespondToSelector:(SEL)aSelector;
//
///** 判断类是否遵从给定的协议 */
//+ (BOOL)conformsToProtocol:(Protocol *)protocol;
//
///** 获取指向方法实现IMP的指针 */
//- (IMP)methodForSelector:(SEL)aSelector;
//
///** 获取指向实例方法实现IMP的指针 */
//+ (IMP)instanceMethodForSelector:(SEL)aSelector;
//
///** 找不到函数实现的将调用此方法抛出异常 */
//- (void)doesNotRecognizeSelector:(SEL)aSelector;
//
///** 返回消息被第一个转发的对象,
//对象没有找到SEL的IML时就会执行调用该方法 */
//- (id)forwardingTargetForSelector:(SEL)aSelector OBJC_AVAILABLE(10.5, 2.0, 9.0, 1.0);
//
///** methodSignatureForSelector:返回不为nil则调用该方法,
//可以重写该方法将SEL转发给另一个对象 */
//- (void)forwardInvocation:(NSInvocation *)anInvocation OBJC_SWIFT_UNAVAILABLE("");
//
///** 获取方法签名,
//对象没有找到SEL的IML时就会执行调用该方法,
//可以重写该方法抛出一个函数的签名，
//再由forwardInvocation:去执行 */
//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector OBJC_SWIFT_UNAVAILABLE("");
//
///** 获取实例方法签名 */
//+ (NSMethodSignature *)instanceMethodSignatureForSelector:(SEL)aSelector OBJC_SWIFT_UNAVAILABLE("");
///** 允许弱引用标量, 对于所有allowsWeakReference方法返回NO的类都绝对不能使用__weak修饰符 */
//- (BOOL)allowsWeakReference UNAVAILABLE_ATTRIBUTE;
///** 保留弱引用变量, 在使用__weak修饰符的变量时, 当被赋值对象的retainWeakReference方法返回NO的情况下, 该变量将使用“nil” */
//- (BOOL)retainWeakReference UNAVAILABLE_ATTRIBUTE;
///** 判断是否是另一个类的子类 */
//+ (BOOL)isSubclassOfClass:(Class)aClass;
//3.复制方法
///** 复制为不可变对象 */
//- (id)copy;
///** 复制为可变对象 */
//- (id)mutableCopy;
///** 在指定的内存空间上复制为不可变对象, 在MRC下使用 */
//+ (id)copyWithZone:(struct _NSZone *)zone OBJC_ARC_UNAVAILABLE;
///** 在指定的内存空间上复制为可变对象, 在MRC下使用 */
//+ (id)mutableCopyWithZone:(struct _NSZone *)zone OBJC_ARC_UNAVAILABLE;
///** 动态解析一个类方法 */
//+ (BOOL)resolveClassMethod:(SEL)sel OBJC_AVAILABLE(10.5, 2.0, 9.0, 1.0);
///** 动态解析一个实例方法, 对象没有找到SEL的IML时就会执行调用该方法, 可以重写该方法给对象添加所需的SEL */
//+ (BOOL)resolveInstanceMethod:(SEL)sel OBJC_AVAILABLE(10.5, 2.0, 9.0, 1.0);
//4.判断方法
///** 判断对象是否是给定类或给定类子类的实例 */
//- (BOOL)isKindOfClass:(Class)aClass;
//
///** 判断对象是否是给定类的实例 */
//- (BOOL)isMemberOfClass:(Class)aClass;
//
///** 判断对象是否遵从给定的协议 */
//- (BOOL)conformsToProtocol:(Protocol *)aProtocol;
//
///** 判断对象是否能够调用给定的方法 */
//- (BOOL)respondsToSelector:(SEL)aSelector;
//5.内存管理方法
//
///** 对象引用计数加1, 在MRC下使用 */
//- (instancetype)retain OBJC_ARC_UNAVAILABLE;
//
///** 对象引用计数减1, 在MRC下使用 */
//- (oneway void)release OBJC_ARC_UNAVAILABLE;
//
///** 对象引用计数以推迟方式自动减1, 在MRC下使用 */
//- (instancetype)autorelease OBJC_ARC_UNAVAILABLE;
//
///** 获取对象引用计数, 在MRC下使用 */
//- (NSUInteger)retainCount OBJC_ARC_UNAVAILABLE;
//源码如下:
//
//#ifndef _OBJC_NSOBJECT_H_
//#define _OBJC_NSOBJECT_H_
//
//#if __OBJC__
//
//#include <objc/objc.h>
//#include <objc/NSObjCRuntime.h>
//
//@class NSString, NSMethodSignature, NSInvocation;
//
//#pragma mark - 协议部分
//
//@protocol NSObject
//
///** 判断两个对象是否相等, 如相等返回YES, 否则返回NO */
//- (BOOL)isEqual:(id)object;
///** 获取对象hash值, 两对象相等hash值也相等 */
//@property (readonly) NSUInteger hash;
//+ (NSUInteger)hash;
//
///** 获取对象的父类 */
//@property (readonly) Class superclass;
//+ (Class)superclass;
///** 获取当前对象的类 */
//- (Class)class OBJC_SWIFT_UNAVAILABLE("use 'type(of: anObject)' instead");
//+ (Class)class OBJC_SWIFT_UNAVAILABLE("use 'aClass.self' instead");
///** 获取当前对象 */
//- (instancetype)self;
///** 发送指定的消息给对象, 返回消息执行结果(相当于方法调用) */
//- (id)performSelector:(SEL)aSelector;
///** 发送带一个参数的消息给对象, 返回消息执行结果(相当于方法调用) */
//- (id)performSelector:(SEL)aSelector withObject:(id)object;
///** 发送带两个参数的消息给对象, 返回消息执行结果(相当于方法调用) */
//- (id)performSelector:(SEL)aSelector withObject:(id)object1 withObject:(id)object2;
//
///** 判断对象是否继承NSObject */
//- (BOOL)isProxy;
//
///** 判断对象是否是给定类或给定类子类的实例 */
//- (BOOL)isKindOfClass:(Class)aClass;
///** 判断对象是否是给定类的实例 */
//- (BOOL)isMemberOfClass:(Class)aClass;
///** 判断对象是否遵从给定的协议 */
//- (BOOL)conformsToProtocol:(Protocol *)aProtocol;
//
///** 判断对象是否能够调用给定的方法 */
//- (BOOL)respondsToSelector:(SEL)aSelector;
//
///** 对象引用计数加1, 在MRC下使用 */
//- (instancetype)retain OBJC_ARC_UNAVAILABLE;
///** 对象引用计数减1, 在MRC下使用 */
//- (oneway void)release OBJC_ARC_UNAVAILABLE;
///** 对象引用计数以推迟方式自动减1, 在MRC下使用 */
//- (instancetype)autorelease OBJC_ARC_UNAVAILABLE;
///** 获取对象引用计数, 在MRC下使用 */
//- (NSUInteger)retainCount OBJC_ARC_UNAVAILABLE;
///** 获取对象存储空间, 在MRC下使用 */
//- (struct _NSZone *)zone OBJC_ARC_UNAVAILABLE;
//
///** 获取对象描述信息 */
//@property (readonly, copy) NSString *description;
///** 获取对象描述信息 */
//+ (NSString *)description;
//@optional
///** 获取对象在调试器中的描述信息 */
//@property (readonly, copy) NSString *debugDescription;
///** 获取对象在调试器中的描述信息 */
//+ (NSString *)debugDescription;
//@end

//
//参考:
//https://developer.apple.com/documentation/objectivec/nsobject?language=objc
//
//https://blog.csdn.net/zeng_zhiming/article/details/70225456
//
@interface DHObjectDetail (){}
/*
 内存管理语义
 
 1.关键词
 strong：表示指向并拥有该对象。其修饰的对象引用计数会 +1 ，该对象只要引用计数不为 0 就不会销毁，强行置空可以销毁它。一般用于修饰对象类型、字符串和集合类的可变版本。
 copy：与strong类似，设置方法会拷贝一份副本。一般用于修饰字符串和集合类的不可变版， block用copy修饰。
 weak：表示指向但不拥有该对象。其修饰的对象引用计数不会增加，属性所指的对象遭到摧毁时属性值会清空。ARC环境下一般用于修饰可能会引起循环引用的对象，delegate用weak修饰，xib控件也用weak修饰。
 assign：主要用于修饰基本数据类型，如NSIteger、CGFloat等，这些数值主要存在于栈中。
 unsafe_unretained：与weak类似，但是销毁时不自动清空，容易形成野指针。
 
 2.比较 copy 与 strong
 copy与strong：相同之处是用于修饰表示拥有关系的对象。不同之处是strong复制是多个指针指向同一个地址，而copy的复制是每次会在内存中复制一份对象，指针指向不同的地址。NSString、NSArray、NSDictionary等不可变对象用copy修饰，因为有可能传入一个可变的版本，此时能保证属性值不会受外界影响。
 注意：若用strong修饰NSArray，当数组接收一个可变数组，可变数组若发生变化，被修饰的属性数组也会发生变化，也就是说属性值容易被篡改；若用copy修饰NSMutableArray，当试图修改属性数组里的值时，程序会崩溃，因为数组被复制成了一个不可变的版本。
 
 3.比较 assign、weak、unsafe_unretain
 
 相同点：都不是强引用。
 不同点：weak引用的 OC 对象被销毁时, 指针会被自动清空，不再指向销毁的对象，不会产生野指针错误；unsafe_unretain引用的 OC 对象被销毁时, 指针并不会被自动清空, 依然指向销毁的对象，很容易产生野指针错误:EXC_BAD_ACCESS；assign修饰基本数据类型，内存在栈上由系统自动回收。
 
 Property的默认设置
 
 基本数据类型：atomic, readwrite, assign
 对象类型：atomic, readwrite, strong
 注意：考虑到代码可读性以及日常代码修改频率，规范的编码风格中关键词的顺序是：原子性、读写权限、内存管理语义、getter/getter。
 
 延伸
 
 我们已经知道 @property 会使编译器自动编写访问这些属性所需的方法，此过程在编译期完成，称为 自动合成 (autosynthesis)。与此相关的还有两个关键词：@dynamic 和 @synthesize。
 
 @dynamic：告诉编译器不要自动创建实现属性所用的实例变量，也不要为其创建存取方法。即使编译器发现没有定义存取方法也不会报错，运行期会导致崩溃。
 @synthesize：在类的实现文件里可以通过 @synthesize 指定实例变量的名称。
 注意：在Xcode4.4之前，@property 配合 @synthesize使用，@property 负责声明属性，@synthesize 负责让编译器生成 带下划线的实例变量并且自动生成setter、getter方法。Xcode4.4 之后 @property 得到增强，直接一并替代了 @synthesize 的工作。
 
 函数参数是以数据结构:栈的形式存取,从右至左入栈。
 首先是参数的内存存放格式：参数存放在内存的堆栈段中，在执行函数的时候，从最后一个开始入栈。因此栈底高地址，栈顶低地址。
 举个例子如下：void func(int x, float y, char z);
 那么，调用函数的时候，实参 char z 先进栈，然后是 float y，最后是 int x，因此在内存中变量的存放次序是 x->y->z，因此，从理论上说，我们只要探测到任意一个变量的地址，并且知道其他变量的类型，通过指针移位运算，则总可以顺藤摸瓜找到其他的输入变量。
 */

//    1.编译时刻:宏是预编译（编译之前处理），const是编译阶段。
//    2.编译检查:宏不做检查，不会报编译错误，只是替换，const会编译检查，会报编译错误。
//    3.宏的好处:宏能定义一些函数，方法。 const不能。
//    4.宏的坏处:使用大量宏，容易造成编译时间久，每次都需要重新替换。
    
//    // 定义变量
//    int a = 1;
//    // 允许修改值
//    a = 20;
//    // const两种用法
//    // const:修饰基本变量p
//    // 这两种写法是一样的，const只修饰右边的基本变量b
//    const int b = 20; // b:只读变量
//    int const b = 20; // b:只读变量
//    // 不允许修改值
//    b = 1;
//    // const:修饰指针变量*p，带*的变量，就是指针变量.
//    // 定义一个指向int类型的指针变量，指向a的地址
//    int *p = &a;
//    int c = 10;
//    p = &c;
//    // 允许修改p指向的地址
//    // 允许修改p访问内存空间的值
//    *p = 20;
//    // const修饰指针变量访问的内存空间，修饰的是右边*p1，
//    // 两种方式一样
//    const int *p1; // *p1：常量 p1:变量
//    int const *p1; // *p1：常量 p1:变量
//    // const修饰指针变量p1
//    int * const p1; // *p1:变量 p1:常量
//    // 第一个const修饰*p1 第二个const修饰 p1
//    // 两种方式一样
//    const int * const p1; // *p1：常量 p1：常量
//    int const * const p1; // *p1：常量 p1：常量
//    静态方法在堆上分配内存，实例方法在堆栈上
//    静态的速度快，占内存。动态的速度相对慢些，但调用完后，立即释放类，可以节省内存
//    static修饰局部变量
//    在局部变量之前加上关键字static，局部变量就被定义成为一个局部静态变量。
//    特点如下:
//    1）存储区：有栈变为静态存储区rw data，生存期为整个源程序，只能在定义该变量的函数内使用。退出该函数后， 尽管该变量还继续存在，
//    但不能使用它；
//    2）作用域：作用域仍为局部作用域，当定义它的函数或者语句块结束的时候，作用域随之结束。
//        static NSString *str = @"123";
    //跨文件访问extern
    //extern则必须是全局变量（静态+非静态）
    //在不通过.h的情况下去访问全局变量，可以通过extern实现
    //extern声明，仅适于修饰全局变量，不能去修饰其他的变量
    //实例方法：首字母大写，实例方法往往首字母小写-实例方法在堆栈上
    //静态方法：首字母小写，静态方法往往首字母大写+静态方法在堆上
    //当你给一个类写一个方法，如果该方法需要访问某个实例的成员变量时，那么方法该被定义为实例方法。 一个类的实例通常有一些成员变量，其中含有该实例的状态信息。而该方法需要改变这些状态，那么该方法需要声明成实例方法
    //堆中的静态区
//        extern NSString *lhString;
//        NSLog(@"%@-%@",lhString,str);
//        extern NSString *StringSwiftUseOC;
//        NSLog(@"StringSwiftUseOC--%@",StringSwiftUseOC);
@property NSTimeInterval tolerance;//这是7.0之后新增的一个属性，因为NSTimer并不完全精准，通过这个值设置误差范围。

@property(nonatomic,  copy)  NSString *str1;
@property(nonatomic,strong)  NSString *str2;
@property(nonatomic,strong)  NSString *rtcMessageID;

@end

@implementation DHObjectDetail

- (void)test1 {
    ///C 语言练习
    printfHelloWord(); //此即为上面C文件的方法u
    WTTestObject *family = [WTTestObject new];
    [family addTommy];
    [family addLily];
    [family everyBodySayHello];
    
    int index;
    int arr[20];
    int arr_top[5];
    memset(arr,0,20);
    srand(time(NULL));
    for(index = 0; index < 20; index++) {
        arr[index] = rand()%50+1;
    }
    showResult(arr,20);
    
    heap_sort(arr,20);
    showResult(arr,20);
    
    my_top(arr,20,5,arr_top,5);
    showResult(arr_top,5);
    printlog();
}

- (void)test2 {
    NSLog(@"输出--%lu",sizeof(struct3));
    union kc_t {
        uintptr_t bits;
        struct {
            int a;
            char b;
        };
    };
}
- (void)test3 {
    //TODO: 获取手机应用信息
    ApplicationList *app = ApplicationList.alloc.init;
    /*
     - (void)applist;
     - (BOOL)isJailBreak;
     - (BOOL)isJailBreakAppList;
     - (BOOL)isJailBreakEnv;
     + (void)test;
     */
    NSLog(@"%d-%d-%d",[app isJailBreak],[app isJailBreakAppList],[app isJailBreakEnv]);
    [ApplicationList testForObject:app withString:@"Hello"];
    [app applist];
    
//    if ([GKNavigationBarConfigure isSimulator]){
//        NSLog(@"%@",[NSString stringWithFormat:@"%s %@", getenv("SIMULATOR_MODEL_IDENTIFIER"),[NSProcessInfo processInfo].environment[@"SIMULATOR_DEVICE_NAME"]]);
//    }
    /*
     
     func getPlatformNSString() {
     #if (arch(i386) || arch(x86_64)) && os(iOS)
     let DEVICE_IS_SIMULATOR = true
     #else
     let DEVICE_IS_SIMULATOR = false
     #endif
     
     var machineSwiftString : String = ""
     
     if DEVICE_IS_SIMULATOR == true
     {
     //这个巧妙的技巧可以在 http://kelan.io/2015/easier-getenv-in-swift/
     if let dir = NSProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
     machineSwiftString = dir
     }
     } else {
     var size : size_t = 0
     sysctlbyname("hw.machine", nil, &size, nil, 0)
     var machine = [CChar](count: Int(size), repeatedValue: 0)
     sysctlbyname("hw.machine", &machine, &size, nil, 0)
     machineSwiftString = String.fromCString(machine)!
     }
     
     print("machine is \(machineSwiftString)")
     }
     
     [NSProcessInfo processInfo].environment
     {
     "CA_ASSERT_MAIN_THREAD_TRANSACTIONS" = 0;
     "CA_DEBUG_TRANSACTIONS" = 0;
     "CFFIXED_USER_HOME" = "/Users/jabraknight/Library/Developer/CoreSimulator/Devices/359BBBF6-8B67-4847-93B8-FEF35CCF47AB/data/Containers/Data/Application/1817DF13-A760-4684-8D18-842EC8BA4112";
     "CLASSIC_OVERRIDE" = 0;
     "CUPS_SERVER" = "/private/tmp/com.apple.launchd.FZhb16dtph/Listeners";
     "DYLD_FALLBACK_FRAMEWORK_PATH" = "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/System/Library/Frameworks";
     "DYLD_FALLBACK_LIBRARY_PATH" = "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/usr/lib";
     "DYLD_FRAMEWORK_PATH" = "/Users/jabraknight/Library/Developer/Xcode/DerivedData/testSingature-fkjpxjxusuhhybgcjoxcmnsstvfd/Build/Products/Debug-iphonesimulator";
     "DYLD_LIBRARY_PATH" = "/Users/jabraknight/Library/Developer/Xcode/DerivedData/testSingature-fkjpxjxusuhhybgcjoxcmnsstvfd/Build/Products/Debug-iphonesimulator:/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/usr/lib/system/introspection";
     "DYLD_ROOT_PATH" = "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot";
     "DYLD_SHARED_CACHE_DIR" = "/Users/jabraknight/Library/Developer/CoreSimulator/Caches/dyld/21E258/com.apple.CoreSimulator.SimRuntime.iOS-15-4.19E240";
     GPUProfilerEnabled = YES;
     HOME = "/Users/jabraknight/Library/Developer/CoreSimulator/Devices/359BBBF6-8B67-4847-93B8-FEF35CCF47AB/data/Containers/Data/Application/1817DF13-A760-4684-8D18-842EC8BA4112";
     "IOS_SIMULATOR_SYSLOG_SOCKET" = "/tmp/com.apple.CoreSimulator.SimDevice.359BBBF6-8B67-4847-93B8-FEF35CCF47AB/syslogsock";
     "IPHONE_SHARED_RESOURCES_DIRECTORY" = "/Users/jabraknight/Library/Developer/CoreSimulator/Devices/359BBBF6-8B67-4847-93B8-FEF35CCF47AB/data";
     "IPHONE_SIMULATOR_ROOT" = "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot";
     "IPHONE_TVOUT_EXTENDED_PROPERTIES" = "/Users/jabraknight/Library/Developer/CoreSimulator/Devices/359BBBF6-8B67-4847-93B8-FEF35CCF47AB/data/Library/Application Support/Simulator/extended_display.plist";
     "LS_ENABLE_BUNDLE_LOCALIZATION_CACHING" = 1;
     "METAL_DEBUG_ERROR_MODE" = 0;
     "METAL_DEVICE_WRAPPER_TYPE" = 1;
     MallocStackLogging = lite;
     NSUnbufferedIO = YES;
     "OS_ACTIVITY_DT_MODE" = YES;
     PATH = "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/usr/bin:/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/bin:/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/usr/sbin:/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/sbin:/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/usr/local/bin";
     "RWI_LISTEN_SOCKET" = "/private/tmp/com.apple.launchd.UKhAn5qu4W/com.apple.webinspectord_sim.socket";
     "SIMULATOR_ARCHS" = "x86_64";
     "SIMULATOR_AUDIO_DEVICES_PLIST_PATH" = "/Users/jabraknight/Library/Developer/CoreSimulator/Devices/359BBBF6-8B67-4847-93B8-FEF35CCF47AB/data/var/run/com.apple.coresimulator.audio.plist";
     "SIMULATOR_AUDIO_SETTINGS_PATH" = "/Users/jabraknight/Library/Developer/CoreSimulator/Devices/359BBBF6-8B67-4847-93B8-FEF35CCF47AB/data/var/run/simulatoraudio/audiosettings.plist";
     "SIMULATOR_BOOT_TIME" = 1650531148;
     "SIMULATOR_CAPABILITIES" = "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/DeviceTypes/iPhone 8.simdevicetype/Contents/Resources/capabilities.plist";
     "SIMULATOR_DEVICE_NAME" = "iPhone 8";
     "SIMULATOR_EXTENDED_DISPLAY_PROPERTIES" = "/Users/jabraknight/Library/Developer/CoreSimulator/Devices/359BBBF6-8B67-4847-93B8-FEF35CCF47AB/data/Library/Application Support/Simulator/extended_display.plist";
     "SIMULATOR_FRAMEBUFFER_FRAMEWORK" = "/Library/Developer/PrivateFrameworks/CoreSimulator.framework/Resources/Platforms/iphoneos/Library/PrivateFrameworks/SimFramebuffer.framework/SimFramebuffer";
     "SIMULATOR_HID_SYSTEM_MANAGER" = "/Library/Developer/PrivateFrameworks/CoreSimulator.framework/Resources/Platforms/iphoneos/Library/Frameworks/SimulatorHID.framework";
     "SIMULATOR_HOST_HOME" = "/Users/jabraknight";
     "SIMULATOR_LEGACY_ASSET_SUFFIX" = iphone;
     "SIMULATOR_LOG_ROOT" = "/Users/jabraknight/Library/Logs/CoreSimulator/359BBBF6-8B67-4847-93B8-FEF35CCF47AB";
     "SIMULATOR_MAINSCREEN_HEIGHT" = 1334;
     "SIMULATOR_MAINSCREEN_PITCH" = "326.000000";
     "SIMULATOR_MAINSCREEN_SCALE" = "2.000000";
     "SIMULATOR_MAINSCREEN_WIDTH" = 750;
     "SIMULATOR_MEMORY_WARNINGS" = "/Users/jabraknight/Library/Developer/CoreSimulator/Devices/359BBBF6-8B67-4847-93B8-FEF35CCF47AB/data/var/run/memory_warning_simulation";
     "SIMULATOR_MODEL_IDENTIFIER" = "iPhone10,4";
     "SIMULATOR_PRODUCT_CLASS" = D20;
     "SIMULATOR_ROOT" = "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot";
     "SIMULATOR_RUNTIME_BUILD_VERSION" = 19E240;
     "SIMULATOR_RUNTIME_VERSION" = "15.4";
     "SIMULATOR_SHARED_RESOURCES_DIRECTORY" = "/Users/jabraknight/Library/Developer/CoreSimulator/Devices/359BBBF6-8B67-4847-93B8-FEF35CCF47AB/data";
     "SIMULATOR_UDID" = "359BBBF6-8B67-4847-93B8-FEF35CCF47AB";
     "SIMULATOR_VERSION_INFO" = "CoreSimulator 802.6 - Device: iPhone 8 (359BBBF6-8B67-4847-93B8-FEF35CCF47AB) - Runtime: iOS 15.4 (19E240) - DeviceType: iPhone 8";
     "SQLITE_ENABLE_THREAD_ASSERTIONS" = 1;
     "SWIFTUI_VIEW_DEBUG" = 287;
     "TESTMANAGERD_REMOTE_AUTOMATION_SIM_SOCK" = "/private/tmp/com.apple.launchd.sKE5DVzmWw/com.apple.testmanagerd.remote-automation.unix-domain.socket";
     "TESTMANAGERD_SIM_SOCK" = "/private/tmp/com.apple.launchd.ECMYRMhLmU/com.apple.testmanagerd.unix-domain.socket";
     TMPDIR = "/Users/jabraknight/Library/Developer/CoreSimulator/Devices/359BBBF6-8B67-4847-93B8-FEF35CCF47AB/data/Containers/Data/Application/1817DF13-A760-4684-8D18-842EC8BA4112/tmp";
     "XPC_FLAGS" = 0x0;
     "XPC_SERVICE_NAME" = "UIKitApplication:edianyun.com.meetCRM[7410][rb-legacy]";
     "XPC_SIMULATOR_LAUNCHD_NAME" = "com.apple.CoreSimulator.SimDevice.359BBBF6-8B67-4847-93B8-FEF35CCF47AB";
     "__CF_USER_TEXT_ENCODING" = "0x1F5:0:0";
     "__XCODE_BUILT_PRODUCTS_DIR_PATHS" = "/Users/jabraknight/Library/Developer/Xcode/DerivedData/testSingature-fkjpxjxusuhhybgcjoxcmnsstvfd/Build/Products/Debug-iphonesimulator";
     "__XPC_DYLD_FRAMEWORK_PATH" = "/Users/jabraknight/Library/Developer/Xcode/DerivedData/testSingature-fkjpxjxusuhhybgcjoxcmnsstvfd/Build/Products/Debug-iphonesimulator";
     "__XPC_DYLD_LIBRARY_PATH" = "/Users/jabraknight/Library/Developer/Xcode/DerivedData/testSingature-fkjpxjxusuhhybgcjoxcmnsstvfd/Build/Products/Debug-iphonesimulator";
     }
     
     */
    
}

- (void)testData {
    int a = 9;
    int b = 10;
    int c;
    //    a = b + 0 * ( b = a);//a=12;b=10
    //    NSLog(@"%d",a);
    a = b - a; //a=2;b=12
    b = b - a; //a=2;b=10
    a = a + b; //a=10;b=10
    NSLog(@"%d",a);
    //    c=(++a==b--)?++a:b--;
    /**
     ++a后  a的值为10
     （++a(10)==b(10)）,执行++a==b--)中的b- -（9）然后在求++a(11)，同时将其赋值给c
     */
    //++a整体和b--整体相等，所以三目运算，选择等号=前面的,再计算出等号前面的++a整体就得到c的值了
    //++a整体是11，加了两次，所以c = 11,++写在前面和写在后面对整体的值有影响，对a的值都是+1操作，

    if (++a==b--) {
        c = ++a;
    }else{
        c =b--;
    }
    NSLog(@"%d,%d,%d",a,b,c);//11，9，11
    
    NSInteger num1 = 10,num2 = 30;
    NSInteger gcd = [self gcdWithNumber1:num1 Number2:num2];
    // 最小公倍数 = 两整数的乘积 ÷ 最大公约数
    NSLog(@"---%ld",num1 * num2 / gcd);
    float fprice = 10.36;
    double dprice = 0.55;
    NSLog(@"舍位：%@", [self notRounding:fprice afterPoint:3]);
    NSLog(@"进位：%@", [self stringByNotRounding:dprice afterPoint:3]);
    int aa = 1;
    int bb = aa++;
    int cc = ++aa;
    NSLog(@"---%d--%d--%d",aa ,bb ,cc);
    
    //对于不可变字符串来说 srong和copy 指向的地址都是一样的
    //对于可变字符串来说 copy的地址已不在指向原有的地址了，深拷贝了testStr字符串，并让copyStr对象指向这个字符串，反之strong是同一地址
    //当原字符串是NSString时，不管是strong还是copy属性的对象，都是指向原对象，copy操作只是做了次浅拷贝
    //当原字符串是NSMutableString时,copy操作只是做了次深拷贝，产生了一个新对象且copy的对象指向了这个新对象，这个copy属性对象类型始终是不可变的，所以是不可变得；
    NSMutableString*str=[NSMutableString stringWithFormat:@"helloworld"];
//  NSString *str = [NSString stringWithFormat:@"helloworld"];
    
    self.str1 = str;//copy
    self.str2 = str;//strong
    
    NSLog(@"****************%@",self.str1);
    NSLog(@"****************%@",self.str2);
    NSLog(@"str:%p--%p",str,&str);
    NSLog(@"copy_str:%p--%p",_str1,&_str1);
    NSLog(@"strong_str:%p--%p",_str2,&_str2);
    
    NSNumber * integerNumber = [NSNumber numberWithInteger:1];
    NSInteger integerValue = [integerNumber integerValue];
    
    NSLog(@"-----");
    
    NSURL *jurl = [NSURL URLWithString:@"http://10.115.91.95:9530/bff-c/"];
    NSLog(@"%@",jurl);
    NSURL *jnewURL = [NSURL URLWithString:@"/login/gome" relativeToURL:jurl];
    NSLog(@"newURL:%@",[jnewURL absoluteString]);
    
    jnewURL = [NSURL URLWithString:@"login/gome" relativeToURL:jurl];
    NSLog(@"====newURL:%@",[jnewURL absoluteString]);
    
    NSURL *url = [NSURL URLWithString:@"http://example.com/v1"];
    NSLog(@"%@",url);
    NSURL *newURL = [NSURL URLWithString:@"foo?bar=baz" relativeToURL:url];
    NSLog(@"newURL:%@",[newURL absoluteString]);
    
    url = [url URLByAppendingPathComponent:@""];
    NSLog(@"****url:%@",[url absoluteString]);
    newURL = [NSURL URLWithString:@"foo?bar=baz" relativeToURL:url];
    NSLog(@"====newURL:%@",[newURL absoluteString]);
    
    NSURL *baseURL1 = [NSURL URLWithString:@"https://api.mydomain.com/api/"];
    NSURL *baseURL2 = [NSURL URLWithString:@"https://api.mydomain.com/api"];
    
    NSURL *relativeURL1 = [NSURL URLWithString:@"/user/getInfo" relativeToURL:baseURL1];
    NSURL *relativeURL2 = [NSURL URLWithString:@"/user/getInfo" relativeToURL:baseURL2];
    NSURL *relativeURL3 = [NSURL URLWithString:@"user/getInfo" relativeToURL:baseURL1];
    NSURL *relativeURL4 = [NSURL URLWithString:@"user/getInfo" relativeToURL:baseURL2];
    
    NSLog(@"1: %@", [relativeURL1 absoluteString]);
    NSLog(@"2: %@", [relativeURL2 absoluteString]);
    NSLog(@"3: %@", [relativeURL3 absoluteString]);
    NSLog(@"4: %@", [relativeURL4 absoluteString]);
    
    NSString *teststr = @"https://api.mydo#main.com";
    NSLog(@"5: %@", teststr);
    NSURLRequest *testURL = [NSURLRequest requestWithURL:[NSURL URLWithString:teststr]];
    NSLog(@"5: %@", testURL.URL);
    teststr = [teststr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURLRequest *testURL1 = [NSURLRequest requestWithURL:[NSURL URLWithString:teststr]];
    NSLog(@"6: %@", testURL1.URL);
    
    //TODO: 转换
    NSString * strTest =@"str";
    NSData *data =[strTest dataUsingEncoding:NSUTF8StringEncoding];
//    2.NSData 转NSString
    NSString * strTest1  =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    3.data 转char
    NSData *dataTest;
    char * haha=[dataTest bytes];
//    4. char 转data
//    Byte * byteData = malloc(sizeof(byte)*16);
//    NSData *content=[NSData dataWithBytes:byteData length:16];
    
    //TODO: 文件路径操作
    NSString* index=@"/Users/junzoo/Library/Application Support/iPhone Simulator/7.0.3/Applications/63925F20-AF97-4610-AF1C-B6B4157D1D92/Documents/DownLoad/books/2013_50.zip";
    
    NSLog(@"1=%@",[index lastPathComponent]); //从路径中获得完整的文件名（带后缀）2013_50.zip
    NSLog(@"2=%@",[index stringByDeletingLastPathComponent]); //
    NSLog(@"3=%@",[index pathExtension]);  //从路径中获得完整的文件名不带'.'）
    NSLog(@"4=%@",[index stringByDeletingPathExtension]);//路径”标准化“
    NSLog(@"5=%@",[index stringByAbbreviatingWithTildeInPath]);//通过把波浪号替换为当前用户的主目录，来把2013_50.zip
    //转换为扩展的绝对路径
    NSLog(@"6=%@",[index stringByExpandingTildeInPath]);
    NSLog(@"7=%@",[index stringByStandardizingPath]); //返回标准格式路径
    NSLog(@"8=%@",[index stringByResolvingSymlinksInPath]);
    NSLog(@"9=%@",[[index lastPathComponent] stringByDeletingPathExtension]); //获取文件名字
//    1= 2013_50.zip
//
//    2= /Users/junzoo/Library/Application Support/iPhone Simulator/7.0.3/Applications/63925F20-AF97-4610-AF1C-B6B4157D1D92/Documents/DownLoad/books
//
//    3= zip
//
//    4= /Users/junzoo/Library/Application Support/iPhone Simulator/7.0.3/Applications/63925F20-AF97-4610-AF1C-B6B4157D1D92/Documents/DownLoad/books/2013_50
//
//    5= ~/Documents/DownLoad/books/2013_50.zip
//
//    6= /Users/junzoo/Library/Application Support/iPhone Simulator/7.0.3/Applications/63925F20-AF97-4610-AF1C-B6B4157D1D92/Documents/DownLoad/books/2013_50.zip
//
//    7= /Users/junzoo/Library/Application Support/iPhone Simulator/7.0.3/Applications/63925F20-AF97-4610-AF1C-B6B4157D1D92/Documents/DownLoad/books/2013_50.zip
//
//    8= /Users/junzoo/Library/Application Support/iPhone Simulator/7.0.3/Applications/63925F20-AF97-4610-AF1C-B6B4157D1D92/Documents/DownLoad/books/2013_50.zip
//
//    9= 2013_50
    
    
    NSString *url111 = @"http://assdfaf:90";
    NSArray *urlarrconut = [url111 componentsSeparatedByString:@":"];
    //时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-M-dd HH:mm:ss "];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString1 = [formatter stringFromDate:datenow];
    
    //时间戳
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time=[date timeIntervalSince1970]*1000;
    NSString *currentTimeString = [NSString stringWithFormat:@"%.0f", time];
    //时间
    NSString *timeString = [currentTimeString stringByReplacingOccurrencesOfString:@"." withString:@""];
    NSString *second = [timeString substringToIndex:10];
    NSString *milliscond = [timeString substringFromIndex:10];
    NSString * timeStampString = [NSString stringWithFormat:@"%@.%@",second,milliscond];
    NSTimeInterval _interval=[timeStampString doubleValue];
    NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    //    [dateFormatter setTimeZone:timeZone];
    //    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"US/Pacific"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSString *dateString = [dateFormatter stringFromDate:date1];
    NSDateFormatter *formatter3333 = [[NSDateFormatter alloc] init];
    [formatter3333 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter3333 setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    NSDate *date213 = [formatter3333 dateFromString:@"2018-12-15 18:12:45"];
    
    
    NSDateFormatter *fod = [[NSDateFormatter alloc] init];
    [fod setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSString *currentStr23e423 = [fod stringFromDate:date213];
    
    NSDictionary  *u = @{@"name":@"qed",@"sex":@"qed12e"};
    NSEnumerator *enumerator;
    //    enumerator = [u objectEnumerator];
    enumerator = [u keyEnumerator];
    
    id thing;
    while (thing = [enumerator nextObject]) {
        NSLog(@"I found %@",thing);
    }
    
    NSString *doingString = @"787子昂";
    ///提取数字
    NSString *numString =[doingString stringByTrimmingCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] ;
    ///设置汉字展示风格
    NSString *string = [doingString substringWithRange:NSMakeRange(numString.length, doingString.length-numString.length)];
    NSMutableAttributedString *attrStr1 = [[NSMutableAttributedString alloc] initWithString:numString];
    NSDictionary *attr_DictStr = @{NSForegroundColorAttributeName:[UIColor blueColor],
                                 NSFontAttributeName:[UIFont systemFontOfSize:24]};
    [attrStr1 setAttributes:attr_DictStr range:NSMakeRange(0, numString.length)];
    
    ///设置汉字
    NSMutableAttributedString *attrStr2 = [[NSMutableAttributedString alloc] initWithString:string];
    NSDictionary * attr_DictStr2 = @{NSForegroundColorAttributeName:[UIColor redColor],
                                  NSFontAttributeName:[UIFont systemFontOfSize:14]};
    [attrStr2 setAttributes:attr_DictStr2 range:NSMakeRange(0, string.length)];
    [attrStr1 appendAttributedString:attrStr2];
    
    [self getEqualStr:@"dczewfwef"];
    [self getEqualStr:@"dczewfwef"];
    [self findNumFromStr:@"addsfa1231说的4话"];
    
    NSLog(@"1==================================");
    
    //TODO: KVO 高级用法
    /**
     doubleValue.intValue double转Int类型
     uppercaseString 小写变大写
     length 求各个元素的长度
     数学元素 @sum.self  @avg.self @max.self @min.self  @distinctUnionOfObjects.self(过滤)
     //这里使用对象操作符：
     //@distinctUnionOfObjects、@unionOfObjects
     //@distinctUnionOfObjects操作符返回被操作对象指定属性的集合并做去重操作，而@unionOfObjects则允许重复。如果其中任何涉及的对象为nil，则抛出异常。
     >>KVC setter方法
     通过setValue:forKeyPath:设置UI控件的属性：
     
     [self.label setValue:[UIColor greenColor] forKeyPath:@"textColor"];
     [self.button setValue:[UIColor orangeColor] forKeyPath:@"backgroundColor"];
     [self.textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
     */
    NSArray *dataSource = @[@{@"name":@"mike", @"sex":@"man", @"age":@"12"},
                            @{@"name":@"jine", @"sex":@"women", @"age":@"10"},
                            @{@"name":@"marry", @"sex":@"women", @"age":@"12"},
                            @{@"name":@"mike", @"sex":@"man", @"age":@"11"},
                            @{@"name":@"selly", @"sex":@"women", @"age":@"12"}];
    //KVC keyPath的getter方法：
    NSLog(@"name = %@",[dataSource valueForKeyPath:@"name"]);
    NSArray *array1 = @[@"apple",@"banana",@"pineapple",@"orange"];
    NSLog(@"%@",[array1 valueForKeyPath:@"uppercaseString"]);
    
    NSLog(@"filterName = %@",[dataSource valueForKeyPath:@"@distinctUnionOfObjects.sex"]);
    
    NSString *strTest0 = nil;
    NSString *emptyStr = @"";
    NSMutableArray *arr = [NSMutableArray array];
    NSMutableDictionary *dictAll = [NSMutableDictionary dictionary];
    
    [dictAll setObject:emptyStr forKey:@"aKey"];
    [dictAll setObject:strTest0 forKey:@"bKey"];
    
    [dictAll setValue:emptyStr forKey:@"aKey"];
    
    for (int i = 0; i<3; i++) {
        NSDictionary *dict = @{@"name":[NSString stringWithFormat:@"name%d",i]};
        [arr addObject:dict];
    }
    [dictAll setObject:arr forKey:@"customerLineMasterRecordList"];
    NSLog(@"输出--%@",@"");
    
    //TODO: 去重
    //容器不仅仅能使用KVC方法实现对容器成员传递普通的操作消息，KVC还定义了特殊的一些常用操作，使用valueForKeyPath:结合操作符来使用
    //这里使用对象操作符：
    //@distinctUnionOfObjects、@unionOfObjects
    //@distinctUnionOfObjects操作符返回被操作对象指定属性的集合并做去重操作，而@unionOfObjects则允许重复。如果其中任何涉及的对象为nil，则抛出异常。
    
    //    “NSSet，NSMutableSet，和NSCountedSet类声明编程接口对象的无序集合（散列存储：在内存中的存储位置不连续）。
    //    而NSArray，NSDictionary类声明编程接口对象的有序集合（有序存储：在内存中的存储位置连续）。”
    //    NSSet 运用 hash(哈希)散列算法 查找目标集合元素比NSArray快
    NSArray *arrayNew = @[@1,@2,@3,@4,@4,@5,@2,@2];
    
    //NSMatableArray 去重结果: 1 2 3 4 5  有序 在 array 里面相对的顺序的"有序"
    NSMutableArray *resultArray = [NSMutableArray array];
    for (NSNumber *num  in arrayNew) {
        if (![resultArray containsObject:num]) {//判断该集合元素否存在
            [resultArray addObject:num];
        }
    }
    NSLog(@"resultArray :%@",resultArray);
    //去重结果  : 5 1 2 3 4 无序
    NSArray *values = [arrayNew valueForKeyPath:@"@distinctUnionOfObjects.self"];
    NSLog(@"value   : %@",values);
    //没使用 NSSet 前 其实我是会使用字典的 字典的特点 也是无序键值对 效率也是优于使用数组排重的.
    //无序结果  :3,2,5,1,4
    NSMutableDictionary *numDictionary = [NSMutableDictionary dictionary];
    for (NSNumber *num  in arrayNew) {
        [numDictionary setObject:num forKey:num];
    }
    NSLog(@"numDictionary all keys : %@",numDictionary.allKeys);
    //NSSet 去重结果  : 5 1 2 3 4  无序
    NSSet *numSet = [[NSSet alloc]initWithArray:arrayNew];
    NSLog(@"numSet Array : %@",numSet.allObjects);
    //NSSet 有序化操作 : 1 2 3 4 5 同上面的"有序"
    NSOrderedSet *orderNumSet = [NSOrderedSet orderedSetWithArray:arrayNew];
    NSLog(@"orderNumSet Array : %@",orderNumSet.array);
    //KVO 容器对象操作符 distinctUnionOfObjects
    //3,2,5,1,4  无序
    NSSet *setValues = [numSet valueForKeyPath:@"@distinctUnionOfObjects.self"];
    NSLog(@"setValues  : %@",setValues);
    
//    __block UIImage *image;
//    dispatch_sync_on_main_queue(^{
//        image = [UIImage imageNamed:@"Resource/img"];
//    });
    NSLog(@"内联函数 %@",testPathForKey(@"123",@"789"));
    NSLog(@"1---%@",[self randomString:6]);
    
    NSLog(@"2---%@",[self generateTradeNO]);
    
    NSLog(@"3---%@",[self getRandomStr]);
    
    NSLog(@"4---%@",[self randomStringWithLength:6]);

    [self testDecimalNumber];
    
    static int kNumber1 = 6;
    NSString *sourceStr1 = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    NSMutableString *resultStr1 = [[NSMutableString alloc] init];
//    srand(time(0));
    for (int i = 0; i < kNumber1; i++) {
        unsigned index = rand() % [sourceStr1 length];
        NSString *oneStr = [sourceStr1 substringWithRange:NSMakeRange(index, 1)];
        [resultStr1 appendString:oneStr];
    }
    NSLog(@"1---%@",resultStr1);
    
    NSString *phoneRegex = @"1\\d{10}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    NSLog(@"手机号BOOL %d",[phoneTest evaluateWithObject:@"手机号1234"]);
    NSLog(@"----%D ",CalcMemLen("sdf", 1000));
    NSDictionary *dict = @{@"name":isNull(@"123")?@"":@"123"};
    NSLog(@"%@",dict);
    
    //TODO: copy&mutableCopy
    // 2. (遵循了NSCopying和NSMutableCopying协议的)不可变的copy就是copy一个指针, 不可变的mutableCopy就是重新mutableCopy一份内存; 可变的copy和mutableCopy就是重新创建一个内存.
    NSString* stringstring = @"ABC";//NSCFConstantString
    NSLog(@"%p, %p, %p", stringstring, stringstring.copy, stringstring.mutableCopy);
    NSString* string1 = [[NSString alloc] initWithFormat:@"ABCD"];//NSTaggedPointerString
    NSLog(@"%p, %p, %p", string1, string1.copy, string1.mutableCopy);
    
    NSMutableString* mString = [[NSMutableString alloc] initWithFormat:@"ABCDE"];//NSCFString
    NSLog(@"%p, %p, %p", mString, mString.copy, mString.mutableCopy);
    
    NSLog(@"2==================================");
    
    /*
     0x101d83198, 0x101d83198, 0x6000033e33c0
     0x6000033e8780, 0x6000033e8780, 0x6000033e87e0
     0x6000033f3300, 0x600001e93520, 0x6000033f39f0
     
    从上面的结果可以看出:

    1. string的地址是在常量区的(先当成栈区,用做字面量，存放在文本区), 而string.copy指向的同样也是栈区, 而且和string的地址是同一个0x101d83198, 而string的mutableCopy指向的是一个堆区的地址0x6000033e33c0, 这是在堆区里面重新开辟了一块内存.

    2. string1的地址是在堆区里面开辟出来的, 同样的string1也是inmutable类型的, 而string1.copy同样的也是和string1的地址是同一个0x6000033e8780, 同样的string1.mutableCopy指向了0x6000033e87e0也是在堆区里面重新开辟出一块内存.

    不可变类型(inmutable)的copy指向的还是原来的地址(不论是在堆区还是在栈区), 而不可变类型(inmutable)的mutableCopy是在堆区里面重新开辟出一块新内存来拷贝.
    
    1. mString的地址是在堆区里面开辟出的一块内存, mString是mutable类型的, 但是mString.copy和mString.mutableCopy都是在堆区里面重新开辟出一块内存来拷贝.

    可变类型(mutable)的copy和mutableCopy都是在堆区里面开辟出一块内存.
    */
    NSLog(@"2==================================");
    NSArray* array = @[@"ABCDF", @"ABCDEFG"];
    NSArray* arrayTmp = array.copy;
    NSArray* array2 = array.mutableCopy;
    NSLog(@"%p, %p, %p", array, arrayTmp, array2);
    for (NSString* string in array) {
        NSLog(@"%p", string);
    }
    NSLog(@"3==================================");
    for (NSString* string in arrayTmp) {
        NSLog(@"%p", string);
    }
    NSLog(@"4==================================");
    for (NSString* string in array2) {
        NSLog(@"%p", string);
    }
    NSLog(@"5==================================");
    NSLog(@"mutableCopy");
    NSMutableArray* mutableArray = [NSMutableArray arrayWithObjects:@"ABCDEFGH", @"ABCDEFGHL", nil];
    NSMutableArray* mutableArray1 = mutableArray.copy;
    NSMutableArray* mutableArray2 = mutableArray.mutableCopy;
    NSLog(@"%p, %p, %p", mutableArray, mutableArray1, mutableArray2);
    for (NSString* string in mutableArray) {
        NSLog(@"%p", string);
    }
    NSLog(@"6==================================");
    for (NSString* string in mutableArray1) {
        NSLog(@"%p", string);
    }
    NSLog(@"7==================================");
    for (NSString* string in mutableArray2) {
        NSLog(@"%p", string);
    }
    NSLog(@"8==================================");
    //对于他们里面的元素就不是了, 元素指向的还是之前的内存地址
}
//比如 float x=0.667，我们想保留两位小数但不进位
//num 是待处理数字
//postion是保留的位数
- (NSString *)notRounding:(float)num afterPoint:(int)position {
    
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:num];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    return [NSString stringWithFormat:@"%@",roundedOunces];
}
//    1.四舍五入, 使用 %.2f 本身就是会四舍五入的.
//    2.对小数点后两位数会大于0即加1
//price:需要处理的数字
//position：保留小数点第几位
- (NSString *)stringByNotRounding:(double)price afterPoint:(int)position {
    
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundUp scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    return [NSString stringWithFormat:@"%@",roundedOunces];
}
//产生随机字符串
- (NSString *)generateTradeNO {
    static int kNumber = 15;
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRST";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0));
    for (int i = 0; i < kNumber; i++) {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}
- (NSString*) randomString:(int)len {
    char* charSet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    char* temp = malloc(12 + 1);
    for (int i = 0; i < 12; i++) {
        int randomPoz = arc4random()%strlen(charSet);
        temp[i] = charSet[randomPoz];
    }
    temp[len] = '\0';
    NSMutableString* randomString = [[NSMutableString alloc] initWithUTF8String:temp];
    free(temp);
    return randomString;
}
- (NSString *)getRandomStr {
    char data[6];
    for (int x=0;x < 6;data[x++] = (char)('A' + (arc4random_uniform(26))));
    NSString *randomStr = [[NSString alloc] initWithBytes:data length:6 encoding:NSUTF8StringEncoding];
    NSString *string = [NSString stringWithFormat:@"%@",randomStr];
    NSLog(@"获取随机字符串 %@",string);
    return string;
}
- (NSString *)randomStringWithLength:(NSInteger)len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (NSInteger i = 0; i < len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    return randomString;
}
- (void)testDecimalNumber {
    NSDecimalNumber *price1 = [NSDecimalNumber decimalNumberWithString:@"15.99"];
    NSDecimalNumber *price2 = [NSDecimalNumber decimalNumberWithString:@"29.99"];
    NSDecimalNumber *coupon = [NSDecimalNumber decimalNumberWithString:@"5.00"];
    NSDecimalNumber *discount = [NSDecimalNumber decimalNumberWithString:@".90"];
    NSDecimalNumber *numProducts = [NSDecimalNumber decimalNumberWithString:@"2.0"];
    // 加
    NSDecimalNumber *subtotal = [price1 decimalNumberByAdding:price2];
    // 减
    NSDecimalNumber *afterCoupon = [subtotal decimalNumberBySubtracting:coupon];
    // 乘
    NSDecimalNumber *afterDiscount = [afterCoupon decimalNumberByMultiplyingBy:discount];
    // 除
    NSDecimalNumber *average = [afterDiscount decimalNumberByDividingBy:numProducts];
    // 乘方
    NSDecimalNumber *averageSquared = [average decimalNumberByRaisingToPower:2];
    
    NSLog(@"Subtotal: %@", subtotal);                    // 45.98
    NSLog(@"After coupon: %@", afterCoupon);           // 40.98
    NSLog(@"After discount: %@", afterDiscount);       // 36.882
    NSLog(@"Average price per product: %@", average);    // 18.441
    NSLog(@"Average price squared: %@", averageSquared); // 340.070481
    
    /*
     NSRoundPlain:四舍五入  NSRoundDown:向下取正   NSRoundUp:向上取正     NSRoundBankers:(特殊的四舍五入，碰到保留位数后一位的数字为5时，根据前一位的奇偶性决定。为偶时向下取正，为奇数时向上取正。如：1.25保留1为小数。5之前是2偶数向下取正1.2；1.35保留1位小数时。5之前为3奇数，向上取正1.4）
     scale:精确到几位小数
     raiseOnExactness:发生精确错误时是否抛出异常，一般为NO
     raiseOnOverflow:发生溢出错误时是否抛出异常，一般为NO
     raiseOnUnderflow:发生不足错误时是否抛出异常，一般为NO
     raiseOnDivideByZero:被0除时是否抛出异常，一般为YES
     */
    NSDecimalNumber * inputNumber = [[NSDecimalNumber alloc]initWithString:@"340.0700001"];
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       decimalNumberHandlerWithRoundingMode:NSRoundDown
                                       scale:2
                                       raiseOnExactness:NO
                                       raiseOnOverflow:NO
                                       raiseOnUnderflow:NO
                                       raiseOnDivideByZero:YES];
    NSDecimalNumber * number = [inputNumber decimalNumberByRoundingAccordingToBehavior: roundUp];
    NSLog(@"%@",number);
}
//科学计数法
- (void)price{
    /*
     typedef NS_ENUM(NSUInteger, NSRoundingMode) {
     NSRoundPlain,   // 四舍五入
     NSRoundDown,    // 只舍不入
     NSRoundUp,      // 只入不舍
     NSRoundBankers  // 这个是特殊的四舍五入。保留位数的后一位为5时，根据保留位数的奇偶性来确定舍入规则。例如：0.235保留两位小数，5前面为3，奇数要进1，结果为0.24。如果是0.245，5前面为4，偶数要舍，结果为0.24。
     };
     // scale 保留几位小数
     // Exactness：进度异常、Overflow:向上溢出、Underflow：向下溢出、DivideByZero：除数为0。当参数为YES出错会抛出异常，为NO时忽略异常。返回nil.
     */
    //方式1：不进行四舍五入
    NSDecimalNumber *number1 = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",10.155]];
    NSDecimalNumber *number2 = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",6.1]];
    NSDecimalNumber *num1 = [number1 decimalNumberByAdding:number2];
    NSLog(@"num===%@",num1);
    //方式2：进行四舍五入
    //    NSRoundUp属性使所有的操作算到最近的位置,其他的进位选项是NSRoundPlain, NSRoundDown, 和 NSRoundBankers,它们都被定义在NSRoundingMode,scale参数定义了结果值保留的小数位的数量,其余的参数给所有的操作定义了异常处理行为.
    //scale四舍五入，舍入位数
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *num2 = [number1 decimalNumberByAdding:number2 withBehavior:roundUp];
    NSLog(@"num1===%@",num2);
    //    2.减法运算
    //方式1：不进行四舍五入
    NSDecimalNumber *num3 = [number1 decimalNumberBySubtracting:number2];
    NSLog(@"num===%@",num3);
    //方式2：进行四舍五入
    NSDecimalNumberHandler *handler1 = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *num4 = [number1 decimalNumberBySubtracting:number2 withBehavior:handler1];
    NSLog(@"num===%@",num4);
    
    //    3.乘法的运算
    //方式1：不进行四舍五入
    NSDecimalNumber *num5 = [number1 decimalNumberByMultiplyingBy:number2];
    NSLog(@"num===%@",num5);
    
    //方式2：进行四舍五入
    NSDecimalNumberHandler *handler2 = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *num6 = [number1 decimalNumberByMultiplyingBy:number2 withBehavior:handler2];
    NSLog(@"num===%@",num6);
    
    //    4.除法的运算
    //方式1：不进行四舍五入
    NSDecimalNumber *num7 = [number1 decimalNumberByDividingBy:number2];
    NSLog(@"num===%@",num7);
    
    //方式2：进行四舍五入
    NSDecimalNumberHandler *handler3 = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:1 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *num8 = [number1 decimalNumberByDividingBy:number2 withBehavior:handler3];
    NSLog(@"num===%@",num8);
    
    //    5.比较
    //self.number1  <  self.number2
    if ([number1 compare:number1] == NSOrderedAscending) {
        NSLog(@"number1  <  number2");
    }else if([number1 compare:number1] ==NSOrderedDescending){//self.number1  >  self.number2
        NSLog(@"number1  >  number2");
    }else if ([number1 compare:number1] == NSOrderedSame){
        //self.number1  =  self.number2
        NSLog(@"number1  =  self.number2");
    }
    //    6.指数运算
    //方式1：不进行四舍五入
    NSDecimalNumber *num9 = [number1 decimalNumberByMultiplyingByPowerOf10:2];
    NSLog(@"~~~%@",num9);
    //方式2：进行四舍五入
    NSDecimalNumberHandler *handler4 = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *num10 = [number1 decimalNumberByMultiplyingByPowerOf10:2 withBehavior:handler4];
    NSLog(@"~~~%@",num10);
    
    
    //    7.次方运算
    //方式1：进行四舍五入
    NSDecimalNumber *num11 = [number1 decimalNumberByRaisingToPower:2];
    NSLog(@"~~~%@",num11);
    
    //方式2：进行四舍五入
    NSDecimalNumberHandler *handler5 = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *num12 = [number1 decimalNumberByRaisingToPower:4 withBehavior:handler5];
    NSLog(@"~~~%@",num12);
}

//多次调用只加载一次
- (void)getEqualStr:(NSString *)str {
    if ([self.rtcMessageID isEqualToString:str] ) {
        NSLog(@"只加载一次");
    }else{
        self.rtcMessageID = str;
    }
}
- (NSString *)findNumFromStr:(NSString *)originalString{
    NSMutableString *numberString = [[NSMutableString alloc] init];
    NSString *tempStr;
    NSScanner *scanner = [NSScanner scannerWithString:originalString];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    while(![scanner isAtEnd]){
        [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
        [scanner scanCharactersFromSet:numbers intoString:&tempStr];
        [numberString appendString:tempStr];tempStr = @"";
    }
    //    return [numberString integerValue];
    return numberString;
}
- (NSInteger)gcdWithNumber1:(NSInteger)num1 Number2:(NSInteger)num2 {
    while(num1 != num2) {
        if(num1 > num2) {
            num1 = num1-num2;
        } else {
            num2 = num2-num1;
        }
    }
    return num1;
}
/**
 *  转换为Base64编码
 */

- (NSString *)base64EncodedString:(NSString *)r {
    NSData *data = [r dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}
/**
 *  将Base64编码还原
 */
- (NSString *)base64DecodedString:(NSString *)r {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:r options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}
- (NSString *)md5EncryptWithString:(NSString *)string {
    if (nil == string || string.length == 0) {
        return nil;
    }
    const char *cStr = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",result[0],result[1],result[2],result[3],result[4],result[5],result[6],result[7],result[8],result[9],result[10],result[11],result[12],result[13],result[14],result[15]];
}
- (void)queryString {
    
    NSDictionary *dic = @{@"devicetype":@"1", @"hospital_id":@"2", @"phone":@"3", @"user_id":@"4", @"hsnm":@"2", @"njh":@"1", @"hanm":@"2", @"hbnm":@"2", @"hcnm":@"2", @"hdnm":@"2", @"hmnm":@"2"};
    NSArray *keyArray = dic.allKeys;
    NSArray *sortArray = [keyArray sortedArrayUsingComparator:^NSComparisonResult(id _Nonnull obj1, id _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    ///重新组装的字典
    NSMutableArray *orderValueArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<sortArray.count; i++) {
        [dic objectForKey:sortArray[i]];
        NSString *result = [NSString stringWithFormat:@"%@=%@",sortArray[i],[dic objectForKey:sortArray[i]]];
        [orderValueArray addObject:result];
    }
    NSString *string = [orderValueArray componentsJoinedByString:@"&"];
    NSLog(@"排序后的字典：%@",dic);
    NSLog(@"%@",orderValueArray);
    NSLog(@"%@",sortArray);
}
static inline int CalcMemLen(void *pSrc, long findRange) {
    return 10;
}
static inline NSString* testPathForKey(NSString* directory, NSString* key) {
    //  stringByAppendingString 字符串拼接
    //    stringByAppendingPathComponent 路径拼接
    return [directory stringByAppendingString:key];
}
static BOOL isNull(NSString *stirng) {
    if (stirng == nil || stirng == NULL) {
        return YES;
    }
    if ([stirng isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[stirng stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    
    if(![stirng isKindOfClass:[NSString class]]) return YES;
    
    if(stirng == nil) return YES;
    if([stirng isEqualToString:@"(null)"]) return YES;
    if([stirng isEqualToString:@"NULL"]) return YES;
    if([stirng isEqualToString:@"(NULL)"]) return YES;
    if([stirng isEqualToString:@"<NULL>"]) return YES;
    if([stirng isEqualToString:@"<null>"]) return YES;
    if([stirng isEqualToString:@"null"]) return YES;
    if([stirng isEqualToString:@"nill"]) return YES;
    if([stirng isEqualToString:@"<nill>"]) return YES;

    if(stirng == nil || stirng == NULL) return YES;
    NSString * string1 = [stirng stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSUInteger len=[string1 length];
    if (len <= 0) return YES;
    return NO;
}
- (void)readFile{
    //第一种方法： NSFileManager实例方法读取数据
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES);
    NSString* thepath = [paths lastObject];
    thepath = [thepath stringByAppendingPathComponent:@"labekl.txt"];
    NSLog(@"桌面目录：%@", thepath);
    NSFileManager* fm = [NSFileManager defaultManager];
    NSData* data = [[NSData alloc] init];
    data = [fm contentsAtPath:thepath];
    NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);

    //第二种方法： NSData类方法读取数据
    data = [NSData dataWithContentsOfFile:thepath];
    NSLog(@"NSData类方法读取的内容是：%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);

    //第三种方法： NSString类方法读取内容
    NSString* content = [NSString stringWithContentsOfFile:thepath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"NSString类方法读取的内容是：\n%@",content);

    //第四种方法： NSFileHandle实例方法读取内容
    NSFileHandle* fh = [NSFileHandle fileHandleForReadingAtPath:thepath];
    data = [fh readDataToEndOfFile];
    NSLog(@"NSFileHandle实例读取的内容是：\n%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    
   
}
- (void)testDataL {
    //    NSMutableArray *arr = [@[@"24", @"17", @"85", @"13", @"9", @"54", @"76", @"45", @"5", @"63"]mutableCopy];
    //    for (int i = 0; i<arr.count-1; i++) {
    //        for (int j = 0; (j < arr.count-1-i); j++) {
    //            if ([arr[j] intValue]<[arr[j+1] intValue]){
    //                int tmp = [arr[j] intValue];
    //                NSLog(@"----<<>>%d",tmp);
    //                arr[j] = arr[j+1];
    //                arr[j+1] = tmp;
    //            }
    //        }
    //    }
    //冒泡排序
    //    int array[10] = {24, 17, 85, 13, 9, 54, 76, 45, 5, 63};
    //    int numcount = sizeof(array)/sizeof(int);
    //    for (int i = 0; i<numcount; i++) {
    //        NSLog(@"-第一层读数-%d",array[i]);
    //        for (int j = 0; j<numcount-i; j++) {
    //            NSLog(@"-第二层读数-%d",array[j]);
    //            //如果一个元素比另一个元素大，交换这两个元素的位置
    //            if (array[j]<array[j+1]) {
    //                int tmp = array[j];
    //                array[j]=array[j+1];
    //                array[j+1] = tmp;
    //            }
    //        }
    //
    //    }
    //    for(int i = 0; i < numcount; i++) {
    //        printf("最终结果--%d\t", array[i]);
    //    }
    //冒泡排序
    NSMutableArray *arrNum = [NSMutableArray arrayWithObjects:@"10",@"23",@"34",@"12",@"2",@"16", nil];
    for (int i = 0; i<arrNum.count; i++) {
        NSLog(@"外层冒泡排序循环：%@",arrNum[i]);
        for (int j = 0; j<arrNum.count-1-i; j++) {
            NSLog(@"内层冒泡排序循环：%@-%@-%lu",arrNum[j],arrNum[j+1],arrNum.count-1-i);
            if ([arrNum[j]intValue]<[arrNum[j+1]intValue]) {
                NSLog(@"冒泡排序判断：%@-%@-%@",arrNum[i],arrNum[j],arrNum[j+1]);
                int tmp = [arrNum[j]intValue];
                arrNum[j] = arrNum[j+1];
                arrNum[j+1] = [NSNumber numberWithInt:tmp];
                NSLog(@"冒泡排序判断：%@-%@-%@",arrNum[i],arrNum[j],arrNum[j+1]);
            }
        }
    }
    //    //选择排序 先设arr[1]为最小，逐一比较，若遇到比之小的则交换,
    //    for (int i = 0;i<arrNum.count; i++) {
    //        NSLog(@"i 选择排序：%@",arrNum[i]);
    //        for (int j = i+1;j<arrNum.count; j++) {
    //            NSLog(@"选择排序：%@",arrNum[j]);
    //            if ([arrNum[i]intValue] > [arrNum[j]intValue]) {// 将上一步找到的最小元素和第i位元素交换。
    //                NSLog(@"选择排序：%@--%@",arrNum[i],arrNum[j]);
    //                int tmp = [arrNum[i]intValue];
    //                arrNum[i] = arrNum[j];//exchange
    //                arrNum[j] = [NSNumber numberWithInt:tmp];
    //                NSLog(@"选择排序：%@--%@",arrNum[i],arrNum[j]);
    //            }
    //        }
    //    }
    
    for(int i = 0; i < arrNum.count; i++) {
        printf("最终结果--%d\t", [arrNum[i]intValue]);
    }
    //冒泡排序
    //    1, 最差时间复杂度 O(n^2)
    //    2, 平均时间复杂度 O(n^2)
    //    NSMutableArray *mutableArray = [@[@"12",@"45",@"1",@"5",@"18",@"35",@"7"]mutableCopy];
    //    for (int i = 0; i < mutableArray.count-1; i++) {
    //        for (int j = 0; j < mutableArray.count-1-i; j++) {
    //            if ([mutableArray[j] integerValue] > [mutableArray[j+1] integerValue]) {
    //                NSString *temp = mutableArray[j];
    //                mutableArray[j] = mutableArray[j+1];
    //                mutableArray[j+1] = temp;
    //            }
    //        }
    //    }
    //    NSLog(@"冒泡排序结果：%@",mutableArray);
    NSMutableArray *numarrar = [@[@"4",@"2",@"7",@"12",@"9",@"1"]mutableCopy];
    //    for (int i = 0; i<numarrar.count-1; i++) {
    //       NSLog(@"输出的数据 %@",numarrar[i]);
    //        for (int j = 0; j<numarrar.count-1-i;j++){
    //            NSLog(@"输出的数据 %@",numarrar[j]);
    //            NSLog(@"输出的数据 %@-%@",numarrar[j],numarrar[j+1]);
    //            if ([numarrar[j] integerValue]>[numarrar[j+1] integerValue]) {
    //                NSLog(@"输出的数据 %@",numarrar[j]);
    //                NSString *tem = numarrar[j];
    //                numarrar[j]  = numarrar[j+1];
    //                numarrar[j+1]  = tem;
    //            }
    //        }
    //    }
    //选择排序
    //    平均时间复杂度：O(n^2)
    //    平均空间复杂度：O(1)
    //    struct utsname systemInfo;
    //    uname(&systemInfo);
    //    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //    NSLog(@"deviceString: %@",deviceString);
    //4 2 7 12 9 1
    for (int i = 0; i<numarrar.count-1; i++) {
        int index = i;//0
        for (int j= i+1; j<numarrar.count; j++) {//2 7 12 9 1;        2 4 7 12 9 1  j=2
            if ([numarrar[index]integerValue]>[numarrar[j]integerValue]) {//numarrar[index]=4，numarrar[j]=2  7
                index = j;//index = j = 1;
            }
            if (index != i) {//1 != 0;
                NSString *temp = numarrar[i];//temp = 4
                numarrar[i] = numarrar[index];//numarrar[i] = numarrar[index]=2
                numarrar[index] = temp;// numarrar[index] = 4
            }//2 4 7 12 9 1;4 2 7 12 9 1
            NSLog(@"选择排序结果：%@",numarrar);
        }
    }
}
- (void)getPrivateVarWithClass:(DHObjectDetail *)object {
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList([object class], &count);
    for (int i = 0 ; i<count ; i++) {
        //从数组中获取成员变量（iVar成员变量是“_开头的”）
        Ivar ivar = ivarList[i];
        //获取成员变量
        NSString *ivarname = [NSString stringWithUTF8String:ivar_getName(ivar)];
        //获取成员变量的类型
        NSString *ivartype = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        
        ivarname = [ivarname stringByReplacingOccurrencesOfString:@"_" withString:@""];
        ivartype = [ivartype stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        ivartype = [ivartype stringByReplacingOccurrencesOfString:@"@" withString:@""];
        // 打印成员变量的数据类型 成员变量名字
        NSLog(@"%@ *%@", ivartype,ivarname);
        //修改对应的值
        //        if ([ivarname containsString:@"privateName"]) {
        //            object_setIvar(object, ivar, @"我的名字");
        //            NSString *privateName = object_getIvar(object, ivar);
        //            NSLog(@"privateName %@",privateName);
        //        }
        //        object_setIvar(object, ivarList[2], @"456");
        //        NSString *privateName = object_getIvar(object, ivar);
        //        NSLog(@"privateName : %@",privateName);
        
        
        //        NSString *key = [ivarname substringFromIndex:1];
        //根据成员属性名去字典查找对应的value
        //        id value = dict[key];
        // 判断值是否是数组
        //        if ([value isKindOfClass:[NSArray class]]) {
        // 判断对应类有没有实现字典数组转模型数组的协议, 协议名称自己可以随便定义, 返回的字典里key对应的类的名称字符串
        // arrayContainModelClass 提供一个协议，只要遵守这个协议的类，都能把数组中的字典转模型
        //        　　　　　　if ([self respondsToSelector:@selector(arrayContainModelClass)]) {
        //            　　　　　　　　// 转换成id类型，就能调用任何对象的方法
        //            　　　　　　　　id idSelf = self;
        //            　　　　　　　　// 获取数组中字典对应的模型
        //            　　　　　　　　NSString *type = [idSelf arrayContainModelClass][key];
        //            　　　　　　　　// 生成模型
        //            　　　　　　　　Class classModel = NSClassFromString(type);
        //            　　　　　　　　NSMutableArray *arrM = [NSMutableArray array];
        //            　　　　　　　　// 遍历字典数组，生成模型数组
        //            　　　　　　　　for (NSDictionary *dict in value) {
        //                　　　　　　　　　　// 字典转模型
        //                　　　　　　　　　　id model = [classModel modelWithDict3:dict];
        //                　　　　　　　　　　 [arrM addObject:model];
        //                　　　　　　　　 }
        //            　　　　　　　　 // 把模型数组赋值给value
        //            　　　　　　　　value = arrM;
        //            　　　　　　}
        //        　　　　}
        //    　　　　// 如果模型属性数量大于字典键值对数理，模型属性会被赋值为nil,而报错
        //    　　　　if (value) {
        //        　　　　// 给模型中属性赋值
        //        　　　　 [objc setValue:value forKey:key];
        //        　　　　 }
    }
}

- (void)acb:(id)data,...NS_REQUIRES_NIL_TERMINATION{
    [self acb:nil,@"配置管理", nil];
}
+ (instancetype)arrayWithObjects:(id)firstObj, ...{
    
    NSMutableArray* arrays = [NSMutableArray array];
    //VA_LIST 是在C语言中解决变参问题的一组宏
    va_list argList;
    
    if (firstObj) {
        [arrays addObject:firstObj];
        // VA_START宏，获取可变参数列表的第一个参数的地址,在这里是获取firstObj的内存地址,这时argList的指针 指向firstObj
        va_start(argList, firstObj);
        // 临时指针变量
        id temp;
        // VA_ARG宏，获取可变参数的当前参数，返回指定类型并将指针指向下一参数
        // 首先 argList的内存地址指向的fristObj将对应储存的值取出,如果不为nil则判断为真,将取出的值存在数组中,
        // 并且将指针指向下一个参数,这样每次循环argList所代表的指针偏移量就不断下移直到取出nil
        while ((temp = va_arg(argList, id))) {
            [arrays addObject:temp];
            NSLog(@"%@",arrays);
        }
        //如果在使用 + (instancetype)arrayWithObjects:(id)firstObj, ... NS_REQUIRES_NIL_TERMINATION;方法中不传入nil值在(temp = va_arg(argList, id))这个函数中便会一直取出值,在C语言中指针指向的即便是一个空内存地址未初始化也是会取出值的,那么一个基本数据类型的随机数则赋值给了 temp 在添加到数组中,则造成将未初始化的内存空间赋值给可变数组的问题程序出现了崩溃.所以我们在使用+ (instancetype)arrayWithObjects:(id)firstObj, ... NS_REQUIRES_NIL_TERMINATION;方法时在多参数的结尾一定要加上nil
    }
    // 清空列表
    va_end(argList);
    return [arrays mutableCopy];
}

@end
