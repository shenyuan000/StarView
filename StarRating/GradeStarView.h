//
//  GradeStarView.h
//  StarRating
//
//  Created by yx on 2017/8/7.
//  Copyright © 2017年 yx. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kNumberOfStar 5
typedef void(^StarScoreBlock)(int score);
@interface GradeStarView : UIView
/** block */
@property (nonatomic, copy) StarScoreBlock scoreBlock;
- (id)initWithFrame:(CGRect)frame numberOfStar:(int)number;
- (void)returnScoreBlock:(StarScoreBlock)block;
@end
