//
//  ViewController.m
//  StarRating
//
//  Created by yx on 2017/8/7.
//  Copyright © 2017年 yx. All rights reserved.
//

#import "ViewController.h"
#import "GradeStarView.h"

@interface ViewController ()
@property (nonatomic, strong) GradeStarView *startView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.startView = [[GradeStarView alloc] initWithFrame:CGRectMake(30, 200, 250, 50)
                                                     numberOfStar:5];
    self.startView.defaultScore = 0;
    [self.view addSubview:self.startView];
    [self.startView returnScoreBlock:^(int score) {
        NSLog(@"score = %d",score);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
