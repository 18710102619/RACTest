//
//  RACTest.m
//  链式、函数式、响应式编程
//
//  Created by 张玲玉 on 2017/10/30.
//  Copyright © 2017年 张玲玉. All rights reserved.
//

#import "RACTest.h"
#import "ReactiveObjC.h"

@implementation RACTest

/**
 RACSignal 冷信号
 */
+ (void)testRACSignal
{
    /* 创建信号 */
    RACSignal *signal=[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        /* 发送信号 */
        [subscriber sendNext:@"发送信号1"];
        
        return nil;
    }];
    
    /* 订阅信号 */
    RACDisposable *disposable=[signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"信号内容：%@", x);
    }];
    
    /* 取消订阅 */
    [disposable dispose];
}

/**
 RASSubject 热信号
 */
+ (void)testRACSubject
{
    /* 创建信号 */
    RACSubject *subject=[RACSubject subject];
    
    /* 订阅信号（通常在别的视图控制器中订阅，与代理的用法类似）*/
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"信号内容：%@", x);
    }];
    
    /* 发送信号 */
    [subject sendNext:@"发送信号2"];
}

/**
 RACTuple 元祖
 */
+ (void)testRACTuple
{
    /* 创建元祖 */
    RACTuple *tuple=[RACTuple tupleWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    
    NSLog(@"取元祖内容：%@", tuple[0]);
    NSLog(@"第一个元素：%@", [tuple first]);
    NSLog(@"最后一个元素：%@", [tuple last]);
}

/**
  便利 Array 数组和 Dictionary 字典
 */
+ (void)testArrayAndDictionary
{
    /* 遍历数组 */
    NSArray *array = @[@"1", @"2", @"3", @"4", @"5"];
    [array.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"数组内容：%@", x); // x 可以是任何对象
    }];
    
    /* 遍历字典 */
    NSDictionary *dictionary = @{@"key1":@"value1", @"key2":@"value2", @"key3":@"value3"};
    [dictionary.rac_sequence.signal subscribeNext:^(RACTuple * _Nullable x) {
        
        RACTupleUnpack(NSString *key, NSString *value) = x; // x 是一个元祖，这个宏能够将 key 和 value 拆开
        NSLog(@"字典内容：%@:%@", key, value);
    }];
    
    /* 内容操作 */
    NSArray *array1 = @[@"1", @"2", @"3", @"4", @"5"];
    NSArray *newArray1 = [[array1.rac_sequence map:^id _Nullable(id  _Nullable value) {
        
        NSLog(@"数组内容：%@", value);
        
        return @"0"; // 将所有内容替换为 0
        
    }] array];
    
    /* 内容快速替换 */
    NSArray *array2 = @[@"1", @"2", @"3", @"4", @"5"];
    NSArray *newArray2 = [[array2.rac_sequence mapReplace:@"0"] array]; // 将所有内容替换为 0
}

+ (void)testRACSequence
{
    NSArray *strings=@[@"1", @"2", @"3", @"4", @"5"];
    RACSequence *results=[[strings.rac_sequence
    filter:^BOOL(NSString *str) {
        return str.length>=1;
    }]
    map:^(NSString *str) {
        return [str stringByAppendingString:@"000000"];
    }];
    
    NSArray *news=[results array];
}

@end
