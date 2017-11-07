//
//  CalculatorMaker.h
//  链式、函数式、响应式编程
//
//  Created by 张玲玉 on 2017/10/13.
//  Copyright © 2017年 张玲玉. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CalculatorMaker;
typedef CalculatorMaker *(^makerBlock)(int);

@interface CalculatorMaker : NSObject

@property(nonatomic,assign)int result;
@property(nonatomic,copy)makerBlock add;

//- (CalculatorMaker *(^)(int))add;
- (CalculatorMaker *(^)(int))sub;
- (CalculatorMaker *(^)(int))multi;
- (CalculatorMaker *(^)(int))divide;

- (NSString *)testAdd;

@end
