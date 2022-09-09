//
//  DHGetClassViewController.m
//  DHBasicKnowledge_Example
//
//  Created by jabraknight on 2021/11/17.
//  Copyright © 2021 localhost3585@gmail.com. All rights reserved.
//

#import "DHGetClassViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface DHGetClassViewController ()

@end

@implementation DHGetClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*
     self 是类的隐藏参数，指向当前调用方法的这个类的实例。而 super 是一个 Magic Keyword， 它本质是一个编译器标示符，和 self 是指向的同一个消息接受者。
     上面的例子不管调用[self class]还是[super class]，接受消息的对象都是当前 Son ＊xxx 这个对象。而不同的是，super是告诉编译器，调用 class 这个方法时，要去父类的方法，而不是本类里的。
     当使用 self 调用方法时，会从当前类的方法列表中开始找，如果没有，就从父类中再找；而当使用 super 时，则从父类的方法列表中开始找。然后调用父类的这个方法。

     当调用 ［self class] 时，实际先调用的是 objc_msgSend函数，第一个参数是 Son当前的这个实例，然后在 Son 这个类里面去找 - (Class)class这个方法，没有，去父类 Father里找，也没有，最后在 NSObject类中发现这个方法。而 - (Class)class的实现就是返回self的类别，故上述输出结果为 Son。

     而当调用 [super class]时，会转换成objc_msgSendSuper函数。第一步先构造 objc_super 结构体，结构体第一个成员就是 self 。 第二个成员是 (id)class_getSuperclass(objc_getClass(“Son”)) , 实际该函数输出结果为 Father。 第二步是去 Father这个类里去找 - (Class)class，没有，然后去NSObject类去找，找到了。最后内部是使用 objc_msgSend(objc_super->receiver, @selector(class))去调用， 此时已经和[self class]调用相同了，故上述输出结果仍然返回 Son。

     */
        Class recyleWebViewController = NSClassFromString(@"DViewController");
        //+
        SEL selasyn=NSSelectorFromString(@"testK");
        //-
        SEL selasyn1=NSSelectorFromString(@"testI");

    //    Method method1 = class_getInstanceMethod([recyleWebViewController class], selasyn);
    //    NSLog(@"%@",[recyleWebViewController performSelector:selasyn1]);
    //    [recyleWebViewController method1];
        NSLog(@"6: ");
        //调用类方法
        Class class = NSClassFromString(@"DViewController");
        if (class) {
            id obj = [[class alloc] init];
            SEL sel = NSSelectorFromString(@"testI");
            //检查是否有"myMethod"这个名称的方法
    //        if ([obj respondsToSelector:sel]) {
    //            [obj performSelector:sel];
    //        }
            IMP imp = [obj methodForSelector:sel];
            void *(*function)(id, SEL) = (void *)imp;
            NSString *u = (__bridge NSString *)(function(obj, sel));
            NSLog(@"---%@",u);
    //        SEL sel1 = NSSelectorFromString(@"testI"); //方法带有参数需要加冒号:
    //        //检查是否有"myMethod"这个名称的方法
    //           if ([obj respondsToSelector:sel1]) {
    ////               [obj performSelector:sel withObject:param]; //方法有多个参数时使用多个withObject传递参数
    //               [obj performSelector:sel1];
    //
    //           }
        }
//        NSArray *method = [EntryViewController getPropertiesWithClass:class];
//        [method enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            if ([obj isEqualToString:@"webview"]) {
//                SEL selasyn=NSSelectorFromString(obj);
//    //                IMP imp = [objC methodForSelector:selasyn];
//    //                void (*function)(id, SEL) = (void *)imp;
//    //                WKWebView *webview = function(objC, selasyn);
//                NSLog(@"6: ");
//                if([class respondsToSelector:selasyn]){
//
//                    NSLog(@"");
//                }
//            }
//        }];
    
    unsigned int ivarsCnt = 0;
    objc_property_t property = class_getProperty( class, "EntryViewController" );
//    NSLog(@"property:%s,%s", property_getName(property),property_getAttributes(property));
    
    //   获取author属性的特征信息列表
    objc_property_attribute_t *attributes = property_copyAttributeList(property, &ivarsCnt);
    for (objc_property_attribute_t *p = attributes; p < attributes + ivarsCnt; p++) {
        objc_property_attribute_t attribute = *p;
        NSLog(@"name: %s value: %s", attribute.name,attribute.value);
        char* value = property_copyAttributeValue ( property, attribute.name );
        NSLog(@"value: %s ", value);
        free(value);
    }
     free(attributes);
}
///TODO: runtime
- (void)test14 {
    /*
     self 是类的隐藏参数，指向当前调用方法的这个类的实例。而 super 是一个 Magic Keyword， 它本质是一个编译器标示符，和 self 是指向的同一个消息接受者。
     上面的例子不管调用[self class]还是[super class]，接受消息的对象都是当前 Son ＊xxx 这个对象。而不同的是，super是告诉编译器，调用 class 这个方法时，要去父类的方法，而不是本类里的。
     当使用 self 调用方法时，会从当前类的方法列表中开始找，如果没有，就从父类中再找；而当使用 super 时，则从父类的方法列表中开始找。然后调用父类的这个方法。
     
     当调用 ［self class] 时，实际先调用的是 objc_msgSend函数，第一个参数是 Son当前的这个实例，然后在 Son 这个类里面去找 - (Class)class这个方法，没有，去父类 Father里找，也没有，最后在 NSObject类中发现这个方法。而 - (Class)class的实现就是返回self的类别，故上述输出结果为 Son。
     
     而当调用 [super class]时，会转换成objc_msgSendSuper函数。第一步先构造 objc_super 结构体，结构体第一个成员就是 self 。 第二个成员是 (id)class_getSuperclass(objc_getClass(“Son”)) , 实际该函数输出结果为 Father。 第二步是去 Father这个类里去找 - (Class)class，没有，然后去NSObject类去找，找到了。最后内部是使用 objc_msgSend(objc_super->receiver, @selector(class))去调用， 此时已经和[self class]调用相同了，故上述输出结果仍然返回 Son。
     
     */
    Class recyleWebViewController = NSClassFromString(@"DHGetClassViewController");
    //+
    SEL selasyn=NSSelectorFromString(@"test14");
    //-
    SEL selasyn1=NSSelectorFromString(@"testI");
    //    Method method1 = class_getInstanceMethod([recyleWebViewController class], selasyn);
    //    NSLog(@"%@",[recyleWebViewController performSelector:selasyn1]);
    //    [recyleWebViewController method1];
    NSLog(@"6: ");
    //调用类方法
    Class class = NSClassFromString(@"DHGetClassViewController");
    if (class) {
        id obj = [[class alloc] init];
        SEL sel = NSSelectorFromString(@"test14");
        //检查是否有"myMethod"这个名称的方法
        //        if ([obj respondsToSelector:sel]) {
        //            [obj performSelector:sel];
        //        }
        IMP imp = [obj methodForSelector:sel];
        void *(*function)(id, SEL) = (void *)imp;
        NSString *u = (__bridge NSString *)(function(obj, sel));
        NSLog(@"---%@",u);
        //        SEL sel1 = NSSelectorFromString(@"testI"); //方法带有参数需要加冒号:
        //        //检查是否有"myMethod"这个名称的方法
        //           if ([obj respondsToSelector:sel1]) {
        ////               [obj performSelector:sel withObject:param]; //方法有多个参数时使用多个withObject传递参数
        //               [obj performSelector:sel1];
        //
        //           }
    }
    NSArray *method = [DHGetClassViewController getPropertiesWithClass:class];
    [method enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:@"webview"]) {
            SEL selasyn=NSSelectorFromString(obj);
            //                IMP imp = [objC methodForSelector:selasyn];
            //                void (*function)(id, SEL) = (void *)imp;
            //                WKWebView *webview = function(objC, selasyn);
            NSLog(@"6: ");
        }
    }];
    [self xxxx:class];
}
- (void)xxxx:(Class)class{
    
    unsigned int ivarsCnt = 0;
    objc_property_t property = class_getProperty( class, "DHGetClassViewController" );
    //    NSLog(@"property:%s,%s", property_getName(property),property_getAttributes(property));
    //   获取author属性的特征信息列表
    objc_property_attribute_t *attributes = property_copyAttributeList(property, &ivarsCnt);
    for (objc_property_attribute_t *p = attributes; p < attributes + ivarsCnt; p++) {
        objc_property_attribute_t attribute = *p;
        NSLog(@"name: %s value: %s", attribute.name,attribute.value);
        char* value = property_copyAttributeValue ( property, attribute.name );
        NSLog(@"value: %s ", value);
        free(value);
    }
    free(attributes);
}
//属性
+ (NSArray *)getPropertiesWithClass:(Class)class {
    NSMutableArray *methods = [NSMutableArray array];
    
    u_int count = 0;
    objc_property_t *properties = class_copyPropertyList(class, &count);
    
    objc_property_attribute_t *attributeList = property_copyAttributeList(*properties, &count);
    
    for (int i = 0; i < count; i++) {
        const char *propertyName = property_getName(properties[i]);
        const char *attributes = property_getAttributes(properties[i]);//属性特性
        NSString *str = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        NSString *attributesStr = [NSString stringWithCString:attributes encoding:NSUTF8StringEncoding];
        NSLog(@"propertyName : %@", str);
        NSLog(@"attributesStr : %@", attributesStr);
        //objc_property_attribute_t 来间接获得关于属性的一些信息。 而这个方法property_copyAttributeList方法就是通过传入objc_property_t来获得objc_property_attribute_t
        //        objc_property_attribute_t attributes1 = {
        //            "T@\"NSString\",C,N,V_studentIdentifier",
        //            "",
        //        };
        //property_getName,property_getAttributes，property_copyAttributeValue，property_copyAttributeList
        objc_property_attribute_t obat = attributeList[i];
        NSLog(@"name=%s value=%s",obat.name,obat.value);
        char *value1 = property_copyAttributeValue(*properties, obat.name);
        NSLog(@"value1=%s",value1);
        
        
        //https://blog.csdn.net/junjun150013652/article/details/48576327
        //        BOOL class_addProperty ( class, const char *name, const objc_property_attribute_t*attributes, unsigned int attributeCount );
        //        NSLog(@"%d",class_addProperty);
        //        class_addProperty(class, "studentIdentifier", &attributes1, 1);
        //        objc_property_t property = class_getProperty(class, "studentIdentifier");
        //        NSLog(@"%s %s", property_getName(property), property_getAttributes(property));
        [methods addObject:str];
        
    }
    free(properties);
    return [NSArray arrayWithArray:methods];
    
}
//成员变量
+ (void)getIvar:(NSString*)className {
    u_int count = 0;
    Ivar *ivarList = class_copyIvarList(NSClassFromString(className), &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        const char *ivarName = ivar_getName(ivar);
        NSLog(@"ivar name -:%@",[NSString stringWithUTF8String:ivarName]);
    }
    free(ivarList);
}
//方法
+ (void)printMethodList:(NSString*)className {
    u_int count;
    Method *methodList = class_copyMethodList(NSClassFromString(className), &count);
    for (unsigned int i = 0; i < count; i++) {
        Method method = methodList[i];
        NSLog(@"method(%d) : %@", i, NSStringFromSelector(method_getName(method)));
    }
    free(methodList);
}
//协议
+ (void)printProtocolList:(NSString*)className {
    u_int count;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList(NSClassFromString(className), &count);
    for (unsigned int i = 0; i < count; i++) {
        Protocol *myProtocal = protocolList[i];
        const char *protocolName = protocol_getName(myProtocal);
        NSLog(@"protocol(%d) : %@", i, [NSString stringWithUTF8String:protocolName]);
    }
    free(protocolList);
}


//get this class all method
+ (NSArray *)allMethodFromClass:(Class)class {
    NSMutableArray *methods = [NSMutableArray array];
    //获取方法
    while (class) {
        unsigned int count = 0;
        Method *method = class_copyMethodList(class, &count);
        for (unsigned int i = 0; i < count; i++) {
            SEL name1 = method_getName(method[i]);
            const char *selName= sel_getName(name1);
            NSString *strName = [NSString stringWithCString:selName encoding:NSUTF8StringEncoding];
            [methods addObject:strName];
        }
        free(method);
        Class cls = class_getSuperclass(class);
        class = [NSStringFromClass(cls) isEqualToString:NSStringFromClass([NSObject class])] ? nil : cls;
    }
    
    return [NSArray arrayWithArray:methods];
}

+ (NSArray *)getPropertiesWithClass1:(Class)class {
    NSMutableArray *methods = [NSMutableArray array];
    //获取属性
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList(class, &propertyCount);
    for (unsigned int i = 0; i<propertyCount; i++) {
        objc_property_t property = properties[i];
        const char* name = property_getName(property);
        const char* attributes = property_getAttributes(property);
        NSLog(@"%s %s", name, attributes);
        NSString *propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        //        NSString *attributesStr = [NSString stringWithCString:attributes encoding:NSUTF8StringEncoding];
        //        NSLog(@"propertyName : %@", str);
        //        NSLog(@"attributesStr : %@", attributesStr);
        [methods addObject:propertyName];
    }
    free(properties);
    return [NSArray arrayWithArray:methods];
}

- (void)gainParmers:(NSString *)className{
    Class  classEntity = NSClassFromString(className);
    NSObject *stu =  [[classEntity alloc] init];
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList(classEntity, &propertyCount);
    for (unsigned int i = 0; i<propertyCount; i++) {
        objc_property_t property = properties[i];
        const char *propertyName = property_getName(property);
        //        const char *propertyName = property_getName(propertyList[i]);
        NSLog(@"property----="">%@", [NSString stringWithUTF8String:propertyName]);
        Method *methodList = class_copyMethodList([stu class], &propertyCount);
        for (unsigned int i = 0; i<propertyCount; i++) {
            Method method = methodList[i];
            SEL  sel = method_getName(method);
            NSString *methodName = NSStringFromSelector(sel);
            if ([methodName isEqualToString:@"readBook"]) {
                NSLog(@"method---->%@", methodName);
                [stu performSelector:sel];
            }else if([methodName isEqualToString:@"happy:"]){
                NSLog(@"method---->%@", methodName);
                [stu performSelector:sel withObject:@"篮球"];
            }
        }
    }
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
