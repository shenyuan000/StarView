//
//  GradeStarView.m
//  StarRating
//
//  Created by yx on 2017/8/7.
//  Copyright © 2017年 yx. All rights reserved.
//

#import "GradeStarView.h"
#define kNum 50
#define kImageWidth (self.bounds.size.width-kNum)/10
#define kBACKGROUND_STAR @"emptyStar"
#define kFOREGROUND_STAR @"Star"

typedef NS_ENUM(NSInteger,CommentDescribe) {
    CommentDescribeVeryBad = 1,//很差
    CommentDescribeBad,//差
    CommentDescribeGeneral,//一般
    CommentDescribeGood,//好
    CommentDescribeVeryGood//很好

};

@interface GradeStarView ()
@property (nonatomic, readwrite) int numberOfStar;
@property (nonatomic, strong) UIView *starBackgroundView;
@property (nonatomic, strong) UIView *starForegroundView;
/** 评论lab */
@property (nonatomic, strong) UILabel *commentLab;
@end

@implementation GradeStarView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame numberOfStar:kNumberOfStar];
}

- (id)initWithFrame:(CGRect)frame numberOfStar:(int)number
{
    if (self = [super initWithFrame:frame]) {
        _numberOfStar = number;
        [self setup];
    }
    
    return self;
}

- (void)setup{
    self.starBackgroundView = [self buidlStarViewWithImageName:kBACKGROUND_STAR isfront:NO];
    self.starForegroundView = [self buidlStarViewWithImageName:kFOREGROUND_STAR isfront:YES];
    [self addSubview:self.starBackgroundView];
    [self addSubview:self.starForegroundView];
    self.commentLab = [self commentLab];

    
    /**点击手势*/
    UITapGestureRecognizer *tapGR=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGR:)];
    [self addGestureRecognizer:tapGR];
    
    /**滑动手势*/
    
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tapGR:)];
    [self addGestureRecognizer:panGR];
}

#pragma mark - private function

- (void)setDefaultScore:(int)defaultScore
{
    _defaultScore = defaultScore;
    
    if (defaultScore <= 0) {
        defaultScore = 0;
    } else if (defaultScore > kNumberOfStar) {
        defaultScore = kNumberOfStar;
    }
    self.userInteractionEnabled = !defaultScore ? YES : NO;
    
    
    self.starForegroundView.frame = CGRectMake(0, 0, defaultScore * 2 * kImageWidth, kImageWidth);
    //评论
    self.commentLab.text = [self commentByCase:defaultScore];
    
    
}

- (void)returnScoreBlock:(StarScoreBlock)block
{
    _scoreBlock = block;
}


- (UIView *)buidlStarViewWithImageName:(NSString *)imageName isfront:(BOOL)isFront{
    CGRect frame = self.bounds;
    frame.size.width -= kNum;
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.clipsToBounds = YES;
    for (int i = 0; i < self.numberOfStar; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i * 2 * kImageWidth, 0, kImageWidth, kImageWidth);
        [view addSubview:imageView];
    }
    if (isFront) {
        view.frame = CGRectZero;
    }
    return view;
}

- (UILabel *)commentLab
{
    if (!_commentLab) {
        _commentLab = [[UILabel alloc] init];
        _commentLab.frame = CGRectMake(CGRectGetMaxX(self.starBackgroundView.frame), 0, kNum, kImageWidth);
        [self addSubview:_commentLab];
        _commentLab.textAlignment = NSTextAlignmentCenter;
        _commentLab.textColor = [UIColor lightGrayColor];
    }
    return _commentLab;
}

-(void)tapGR:(UITapGestureRecognizer *)tapGR{
    CGPoint p =[tapGR locationInView:self];
    [UIView animateWithDuration:0.2 animations:^{
        [self changeStarViewWithMoved:p];
    }];
    
}

- (void)changeStarViewWithMoved:(CGPoint)point{
    CGPoint p = point;
    if (p.x<0) {
        p.x = 0;
    }
    
    if (p.x > self.frame.size.width) {
        p.x = self.frame.size.width;
    }
    
    int currentX = (int) p.x/(2 * kImageWidth) + 1;
    
    //重新绘制starForegroundView
    [self redrawStartView:currentX];

}

- (void)redrawStartView:(int)currentX{
    self.starForegroundView.frame = CGRectMake(0, 0, currentX * 2 * kImageWidth, kImageWidth);
    //评论
    self.commentLab.text = [self commentByCase:currentX];
    
    if (self.scoreBlock) {
        self.scoreBlock(currentX);
    }
}

/** 评论 */
- (NSString *)commentByCase:(int)currentX
{
    NSString *commentStr = nil;
    switch (currentX) {
        case CommentDescribeVeryBad:
            commentStr = @"很差";
            break;
        case CommentDescribeBad:
            commentStr = @"差";
            break;
        case CommentDescribeGeneral:
            commentStr = @"一般";
            break;
        case CommentDescribeGood:
            commentStr = @"好";
            break;
        case CommentDescribeVeryGood:
            commentStr = @"很好";
            break;
            
        default:
            break;
    }
    return commentStr;
}

@end
