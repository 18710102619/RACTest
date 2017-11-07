//
//  RACTest.h
//  链式、函数式、响应式编程
//
//  Created by 张玲玉 on 2017/10/30.
//  Copyright © 2017年 张玲玉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RACTest : NSObject

/**
 RACSignal 信号
 */
+ (void)testRACSignal;

/**
 RACSubject 信号
 */
+ (void)testRACSubject;

/**
 便利 Array 数组和 Dictionary 字典
 */
+ (void)testArrayAndDictionary;

/**
 RACSequence 排序
 */
+ (void)testRACSequence;

@end
