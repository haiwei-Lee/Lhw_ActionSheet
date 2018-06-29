//
//  ViewController.m
//  Lhw_ActionSheet
//
//  Created by lee on 2018/6/29.
//  Copyright © 2018年 首约科技（北京）有限公司 Inc. All rights reserved.
//

#import "ViewController.h"
#import "Lhw_ActionSheet.h"

@interface ViewController ()<Lhw_ActionSheetDelegate>

@property (nonatomic, strong) UIButton * button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = (CGRect){0,0,100,50};
    _button.center = self.view.center;
    [_button setTitle:@"测试" forState:UIControlStateNormal];
    _button.backgroundColor = [UIColor redColor];
    [_button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)buttonClicked{
    Lhw_ActionSheet * actionSheet = [[Lhw_ActionSheet alloc]initWithTitle:@"这是一个测试标题" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拨打电话",@"链接地址", nil];
    actionSheet.titleColor = [UIColor redColor];
    [actionSheet show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
