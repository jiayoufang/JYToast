//
//  ViewController.m
//  JYToast
//
//  Created by fangjiayou on 15/8/28.
//  Copyright (c) 2015年 方. All rights reserved.
//

#import "ViewController.h"
#import "JYToast.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor greenColor];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(100, 100, 100, 40);
    [btn setTitle:@"按钮" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnClick:(id)sender
{
    JYToast *toast = [JYToast toastWithText:@"请求成功了"];
    [toast show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
