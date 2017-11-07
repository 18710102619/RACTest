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
#import "ReactiveObjC.h"
#import "Masonry.h"

@interface ViewController ()

@property(nonatomic,strong)UITextField *username;
@property(nonatomic,strong)UITextField *password;
@property(nonatomic,strong)UIButton *loginButton;
@property(nonatomic,strong)RACDisposable *disposable;

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
    
    
    /* 信号 */
    [RACTest testRACSignal];
    [RACTest testRACSubject];
    [RACTest testArrayAndDictionary];
    
    [RACTest testRACSequence];
    
    /* 按钮状态实时监听 */
    RAC(self.loginButton, enabled) = [RACSignal combineLatest:@[self.username.rac_textSignal, self.password.rac_textSignal] reduce:^id _Nullable(NSString * username, NSString * password){
        
        return @(username.length && password.length);
    }];
    
    /* 代替 KVO 监听 */
    [RACObserve(self.loginButton, enabled) subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"登陆按钮状态：%@", x); // x 是监听属性的改变结果
    }];
    
    /* 定义计时器监听 */
    self.disposable = [[RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
        
        NSLog(@"当前时间：%@", x); // x 是当前的系统时间
        
        /* 关闭计时器 */
        [_disposable dispose];
    }];
}

- (UITextField *)username
{
    if (_username==nil) {
        _username=[[UITextField alloc]init];
        _username.backgroundColor=[UIColor yellowColor];
        [self.view addSubview:_username];
        [_username mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 30));
            make.centerX.equalTo(self.view);
            make.top.equalTo(@(100));
        }];
        
        /* 添加监听条件 */
        [[_username.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
            
            return value.length > 5; // 表示输入文字长度 > 5 时才会调用下面的 block
            
        }] subscribeNext:^(NSString * _Nullable x) {
            
            NSLog(@"用户名：%@", x);
        }];
    }
    return _username;
}

- (UITextField *)password
{
    if (_password==nil) {
        _password=[[UITextField alloc]init];
        _password.backgroundColor=[UIColor yellowColor];
        [self.view addSubview:_password];
        [_password mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 30));
            make.centerX.equalTo(self.view);
            make.top.equalTo(@(150));
        }];
        
        /* 添加监听条件 */
        [[_password.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
            
            return value.length > 5; // 表示输入文字长度 > 5 时才会调用下面的 block
            
        }] subscribeNext:^(NSString * _Nullable x) {
            
            NSLog(@"密 码：%@", x);
        }];
    }
    return _password;
}

- (UIButton *)loginButton
{
    if (_loginButton==nil) {
        _loginButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.backgroundColor=[UIColor orangeColor];
        [_loginButton setTitle:@"登  陆" forState:UIControlStateNormal];
        [self.view addSubview:_loginButton];
        [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(70, 40));
            make.centerX.equalTo(self.view);
            make.top.equalTo(@(200));
        }];
        
        [[_loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
            NSLog(@"%@ 按钮被点击了", x); // x 是 button 按钮对象
        }];
    }
    return _loginButton;
}

@end
