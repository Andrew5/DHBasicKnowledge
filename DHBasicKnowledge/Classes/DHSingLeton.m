//
//  DHSingLeton.m
//  DHBasicKnowledge_Example
//
//  Created by jabraknight on 2021/8/15.
//  Copyright © 2021 localhost3585@gmail.com. All rights reserved.
//

#import "DHSingLeton.h"

@implementation DHSingLeton
//SDK 中也有很多类使用了单例模式,例如 Foundation 和 Application Kit 框架中的一些类只允许创建单件对象,即这些类在当前进程中的唯一实例.
//举例来说,NSFileManager 和 NSWorkspace 类在使用时都是基于进程进行单件对象的实例化.当向这些类请求实例的时候,它们会向您传递单一实例的一个引用,如果该实例还不存在,则首先进行实例的分配和初始化.单件对象充当控制中心的角色,负责指引或协调类的各种服务.如果类在概念上只有一个实例(例如:NSWorkspace),就应该产生一个单件实例,而不是多个实例;
//如果未来可能有多个实例,可以使用单件实例机制,而不是工厂方法或函数.
//
//在程序中单例模式经常希望一个类仅有一个实例,而不运行一个类还有多个实例.在 SDK 中根据特定的需求有些类不仅仅提供了单例访问接口同时还提供了实例化的对象接口.例如 NSFileManager 即可用通过 defaultManager 的方法返回一个对象,但若需要一个新的实例对象同样也可以通过 alloc init 的方法.

//单例模式,由于其简单好用容易理解、同时在出问题时也容易定位的特点，在开发中经常用到的一个设计模式，本文主要分享我在自己的代码中是如何使用单例模式的。
//
//1、什么是单例模式
//
//单例模式的定义
//简单的来说，一个单例类，在整个程序中只有一个实例，并且提供一个类方法供全局调用，在编译时初始化这个类，然后一直保存在内存中，到程序（APP）退出时由系统自动释放这部分内存。
//
//系统为我们提供的单例类有哪些？
//UIApplication(应用程序实例类)
//NSNotificationCenter(消息中心类)
//NSFileManager(文件管理类)
//NSUserDefaults(应用程序设置)
//NSURLCache(请求缓存类)
//NSHTTPCookieStorage(应用程序cookies池)
//在哪些地方会用到单例模式
//一般在我的程序中，经常调用的类，如工具类、公共跳转类等，我都会采用单例模式；
//
//重复初始化单例类会怎样？
//请看下面的例子，我在我的工程中，初始化一次UIApplication,
//
//  [[UIApplication alloc]init];
//最后运行的结果是，程序直接崩溃，并报了下面的错，
//
//Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'There can only be one UIApplication instance.'
//
//初始化
//
//所以，由此可以确定，一个单例类只能初始化一次。
//
//2、单例类的生命周期
//
//单例实例在存储器的中位置
//请看下面的表格展示了程序中中不同的变量在手机存储器中的存储位置；
//
//位置    存放的变量
//栈    临时变量（由编译器管理自动创建/分配/释放的，栈中的内存被调用时处于存储空间中，调用完毕后由系统系统自动释放内存）
//堆    通过alloc、calloc、malloc或new申请内存，由开发者手动在调用之后通过free或delete释放内存。动态内存的生存期可以由我们决定，如果我们不释放内存，程序将在最后才释放掉动态内存，在ARC模式下，由系统自动管理。
//全局区域    静态变量（编译时分配，APP结束时由系统释放）
//常量    常量（编译时分配，APP结束时由系统释放）
//代码区    存放代码
//在程序中，一个单例类在程序中只能初始化一次，为了保证在使用中始终都是存在的，所以单例是在存储器的全局区域，在编译时分配内存，只要程序还在运行就会一直占用内存，在APP结束后由系统释放这部分内存内存。
//
//3、新建一个单例类
//
//（1）、单例模式的创建方式；
//
//同步锁 ：NSLock
//@synchronized(self) {}
//信号量控制并发：dispatch_semaphore_t
//条件锁：NSConditionLock
//dispatch_once_t
//考虑数据和线程问题，苹果官方推荐开发者使用dispatch_once_t来创建单例，那么我就采用dispatch_once_t方法来创建一个单例，类名为OneTimeClass。
//
//static OneTimeClass *__onetimeClass;
//+ (OneTimeClass *)sharedOneTimeClass {
//static dispatch_once_t oneToken;
//
//    dispatch_once(&oneToken, ^{
//
//        __onetimeClass = [[OneTimeClass alloc]init];
//
//    });
//    return __onetimeClass;
//}
//4、单例模式的优缺点
//
//先说优点：
//（1）、在整个程序中只会实例化一次，所以在程序如果出了问题，可以快速的定位问题所在；
//（2）、由于在整个程序中只存在一个对象，节省了系统内存资源，提高了程序的运行效率；
//
//再说缺点
//（1）、不能被继承，不能有子类；
//
//（2）、不易被重写或扩展（可以使用分类）；
//
//（3）、同时，由于单例对象只要程序在运行中就会一直占用系统内存，该对象在闲置时并不能销毁，在闲置时也消耗了系统内存资源；
//
//5、单例模式详解
//
//（1）、重写单例类的alloc方法保证这个类只会被初始化一次
//
//我在viewDidLoad方法中调用单例类的alloc和init方法：
//
//[[OneTimeClass alloc]init];
//此时只是报黄点，但是并没有报错，Run程序也可以成功，这样的话，就不符合我们最开始使用单例模式的初衷来，这个类也可以随便初始化类，为什么呢？因为我们并没有获取OneTimeClass类的使用实例，改进代码：
//
//[OneTimeClass sharedOneTimeClass];
// [[OneTimeClass alloc]init];
//这是改进后的，但是在多人开发时，还是没办法保证，我们会先调用alloc方法，这样我们就没办法控制了，但是我们控制OneTimeClass类，此时我们可以重写OneTimeClass类的alloc方法,此处在重写alloc方法的处理可以采用断言或者系统为开发者提供的NSException类来告诉其他的同事这个类是单例类，不能多次初始化。
//
////断言
//+ (instancetype)alloc {
//  NSCAssert(!__onetimeClass, @"OneTimeClass类只能初始化一次");
//  return [super alloc];
//}
////NSException
//+ (instancetype)alloc {
//   //如果已经初始化了
//    if (__onetimeClass) {
//      NSException *exception = [NSException exceptionWithName:@"提示" reason:@"OneTimeClass类只能初始化一次" userInfo:nil];
//      [exception raise];
//   }
// return [super alloc];
//}
//此时在run一次，可以看到程序直接崩到main函数上了，并按照我之前给的提示报错。
//
//
//
//初始化
//但是，如果我们的程序直接就崩溃了，这样的做法与开发者开发APP的初衷是不是又相悖了，作为一个程序员的目的要给用户一个交互友好的APP，而不是一点小问题就崩溃，当然咯，如果想和测试的妹纸多交流交流，那就。。。。。
//对于这种情况，可以用到NSObect类提供的load方法和initialize方法来控制，
//这两个方法的调用时机：
//
//load方法是在整个文件被加载到运行时，在main函数调用之前调用；
//initialize方法是在该类第一次调用该类时调用；
//为了验证load方法和initialize方法的调用时机，我在  Main函数中打印：
//
//printf("\n\n\n\nmain()");
//在OneTimeClass类的load方法中打印：
//
//+ (void)load {
//    printf("\n\nOneTimeClass load()");
//}
//在OneTimeClass类的initialize方法中打印：
//
//+ (void)initialize {
//    printf("\n\nOneTimeClass initialize()");
//}
//运行程序，最后的结果是，load方法先打印出来，所以可以确定的是load的确是在在main函数调用之前调用的。
//
//
//load和initialize
//这样的话，如果我在单例类的load方法或者initialize方法中初始化这个类，是不是就保证了这个类在整个程序中调用一次呢？
//
//+ (void)load {
//  printf("\n\nOneTimeClass load()");
//}
//+ (void)initialize {
//  printf("\nOneTimeClass initialize()\n\n\n");
//  [OneTimeClass sharedOneTimeClass];
//}
//这样就可以保证sharedOneTimeClass方法是最早调用的。同时，再次对alloc方法修改，无论在何时调用OneTimeClass已经初始化了，如果再次调用alloc可直接返回__onetimeClass实例。
//
//+ (instancetype)alloc {
// if (__onetimeClass) {
//        return  __onetimeClass;
//    }
// return [super alloc];
//}
//最后在ViewController中打印调用OneTimeClass的sharedOneTimeClass和alloc方法，可以看到Log出来的内存地址是相同的，这就说明此时我的OneTimeClass类就只初始化了一次。
//
//   OneTimeClass *onetime1 = [OneTimeClass sharedOneTimeClass];
//    NSLog(@"shared:============%@",onetime1);
//    OneTimeClass *onetime2 = [[OneTimeClass alloc] init];
//    NSLog(@"new:============%@",onetime2);
//
//内存地址
//（2）、对new、copy、mutableCopy的处理
//
//方案一：重写这几个方法，当调用时提示或者返回OneTimeClass类实例，请参考alloc方法的处理；
//方案二：直接禁用这个方法，禁止调用这几个方法，否则就报错，编译不过；
//+(instancetype) new __attribute__((unavailable("OneTimeClass类只能初始化一次")));
//-(instancetype) copy __attribute__((unavailable("OneTimeClass类只能初始化一次")));
//-(instancetype) mutableCopy  __attribute__((unavailable("OneTimeClass类只能初始化一次")));
//此时我在viewDidLoad中调用new，然后Build,编译器会直接给出错误警告，如下图：
//
//
//OneTimeClass类只能初始化一次
//这样就解决了单例类被多次初始化的问题；
//
//（3）、分类Category的使用
//
//如果在程序中某个模块的业务逻辑比较多，此时可以选择分类Category的方式，这样做的好处是：
//（1）、减少Controller代码行数，使代码逻辑更清晰；
//（2）、把同一个功能业务区分开，利于后期的维护；
//（3）、遇到BUG能快速定位到相关代码；
//原则上分类Category只能增加和实现方法，而不能增加属性，此处请参考美团技术团队的博客:https://tech.meituan.com/tags/category.html
//
//例如，在我们的APP中，用到了Socket技术，我在客户端Socket部分的代码使用了单例模式。由于和服务器的交互比较多，此时采用分类Category的方式，把Socket异常处理，给服务器发送的协议，和接受到服务器的协议 用三个分类Category来实现。在以后的维护中如果业务复杂度增加，或者加了新的业务或功能，可继续新建一个分类。这样既不影响之前的代码，同时又可以保证新的代码逻辑清晰。
//
//以上是我在单例模式使用上的一些总结，如果有错误的地方，请指出。
//
//本文demo：https://github.com/dengfeng520/onetimedemo
//本文参考：细说@synchronized和dispatch_once

+ (instancetype)shareInstance {
    static DHSingLeton *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    
    return shareInstance;
}
@end
