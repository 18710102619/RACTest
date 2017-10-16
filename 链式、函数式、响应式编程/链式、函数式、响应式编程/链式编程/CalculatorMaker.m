

//
//  CalculatorMaker.m
//  链式、函数式、响应式编程
//
//  Created by 张玲玉 on 2017/10/13.
//  Copyright © 2017年 张玲玉. All rights reserved.
//

#import "CalculatorMaker.h"

@implementation CalculatorMaker

- (CalculatorMaker *(^)(int)) add
{
    return ^(int num) {
        self.result+=num;
        return self;
    };
}
- (CalculatorMaker *(^)(int))sub
{
    return ^(int num) {
        self.result-=num;
        return self;
    };
}

- (CalculatorMaker *(^)(int))multi
{
    return ^(int num) {
        self.result*=num;
        return self;
    };
}
- (CalculatorMaker *(^)(int))divide
{
    return ^(int num) {
        self.result/=num;
        return self;
    };
}

- (NSString *)testAdd
{
    return @"!@#$%^&*()";
}
@end
