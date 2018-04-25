//
//  ViewController.m
//  banner轮播Demo
//
//  Created by Tank on 2018/4/25.
//  Copyright © 2018年 Tank. All rights reserved.
//

#import "ViewController.h"
#import "BSScrollView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect rect = CGRectMake(0, 0, self.view.bounds.size.width, 200);
    BSScrollView *scrollView = [[BSScrollView alloc] initWithFrame:rect];
    scrollView.imageNames = @[@"image0",@"image1",@"image2",@"image3"];
    scrollView.titles = @[@"原谅",@"我这一生",@"不羁放纵",@"爱自由"];
    scrollView.pageControlPosition = BSPageControlPositionDefult;
    [self.view addSubview:scrollView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
