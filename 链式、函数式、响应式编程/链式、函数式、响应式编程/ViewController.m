//
//  ViewController.m
//  链式、函数式、响应式编程
//
//  Created by 张玲玉 on 2017/10/13.
//  Copyright © 2017年 张玲玉. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+Calculator.h"
#import "Calculator.h"
#import "RACTest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     链式编程：就是可以通过"."语法，将需要执行的代码块连续的书写下去
     链式编程的特点：
     1、方法的返回值是block.
     2、这个block必须有返回值，并且这个返回值就是对象本身；block也有输入参数.
     */
    int result=[NSObject calculate:^(CalculatorMaker *maker) {
        maker.add(10).sub(2);
    }];
    NSLog(@"result=%d",result);
    
    /*
     函数式编程：就是当对象调用完一个函数之后，返回的还是这个对象本身
     1、calculate方法可以完成任何的数学运算
     2、equal方法用来比较第一步计算的结果与某个值是否相等
     */
    Calculator *calculator=[[Calculator alloc]init];
    BOOL isEqual=[[calculator calculate:^int(int result) {
        result+=2;
        result*=5;
        return result;
    }] equal:^BOOL(int result) {
        return result==10;
    }];
    NSLog(@"isEqual:%d",isEqual);
    
    
    //[RACTest testRACSignal];
    [RACTest testRACSubject];
    
}

@end
