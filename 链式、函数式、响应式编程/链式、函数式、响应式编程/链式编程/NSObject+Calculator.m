//
//  NSObject+Calculator.m
//  链式、函数式、响应式编程
//
//  Created by 张玲玉 on 2017/10/13.
//  Copyright © 2017年 张玲玉. All rights reserved.
//

#import "NSObject+Calculator.h"

@implementation NSObject (Calculator)

+ (int)calculate:(void (^)(CalculatorMaker *maker)) calculator
{
    CalculatorMaker *maker=[[CalculatorMaker alloc]init];
    calculator(maker);
    return maker.result;
}

@end
