//
//  Calculator.h
//  链式、函数式、响应式编程
//
//  Created by 张玲玉 on 2017/10/14.
//  Copyright © 2017年 张玲玉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculator : NSObject

@property(nonatomic,nonatomic)int result;

- (Calculator *)calculate:(int(^)(int result)) calculate;

- (BOOL)equal:(BOOL(^)(int result))operation;

@end
