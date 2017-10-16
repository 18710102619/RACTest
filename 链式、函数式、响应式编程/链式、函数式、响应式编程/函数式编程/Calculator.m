//
//  Calculator.m
//  链式、函数式、响应式编程
//
//  Created by 张玲玉 on 2017/10/14.
//  Copyright © 2017年 张玲玉. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator

- (Calculator *)calculate:(int(^)(int result)) calculate
{
    self.result=calculate(self.result);
    return self;
}

- (BOOL)equal:(BOOL(^)(int result))operation
{
    return operation(self.result);
}

@end
