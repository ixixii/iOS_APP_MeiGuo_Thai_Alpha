//
//  SecondViewController.m
//  thaialpha
//
//  Created by beyond on 2020/02/29.
//  Copyright © 2020 Christine. All rights reserved.
//

#import "SecondViewController.h"
#import "MeHeaderView.h"
#import "MeCellView.h"

#import "UIView+Frame.h"

#import "AboutController.h"
@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addHeaderView];
}

- (void)addHeaderView
{
    MeHeaderView *headerView = [MeHeaderView meHeaderView];
    [self.view addSubview:headerView];
    
    MeCellView *cellView1 = [MeCellView meCellView];
    cellView1.y = CGRectGetMaxY(headerView.frame);
    cellView1.width = [UIScreen mainScreen].bounds.size.width;
    cellView1.label.text = @"About";
    cellView1.imgView.image = [UIImage imageNamed:@"about.png"];
    [cellView1.btn addTarget:self action:@selector(aboutBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cellView1];
}

- (void)aboutBtnClicked
{
    AboutController *ctrl = [[AboutController alloc]init];
    [self presentViewController:ctrl animated:YES completion:nil];
    
}
@end
