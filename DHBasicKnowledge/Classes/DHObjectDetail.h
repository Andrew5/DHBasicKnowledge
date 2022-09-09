//
//  DHObjectDetail.h
//  DHBasicKnowledge_Example
//
//  Created by jabraknight on 2021/8/16.
//  Copyright © 2021 localhost3585@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DHObjectDetail : NSObject
{
    //成员变量
    /*
    变量声明出来存放在栈上面
    而block，默认存放在NSGlobalBlock 全局的block；我们常常把block和C中的函数做对比，此时也类似，NSGlobalBlock类似于函数，存放在代码段
    
    当block内部使用了外部的变量时，block的存放位置变成了NSMallockBlock（堆）
    
    __block 修饰以后，会类似于桥接，将被修饰的变量被block所持有，此时该变量也转存到堆空间，所以此时Block内部就可以对外部的变量进行修改
    
    （还有NSStatckBlock位于栈内存）
     */
}
@end

NS_ASSUME_NONNULL_END
