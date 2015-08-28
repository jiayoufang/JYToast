//
//  JYToast.m
//  JYToast
//
//  Created by fangjiayou on 15/8/28.
//  Copyright (c) 2015年 方. All rights reserved.
//

#import "JYToast.h"

@interface JYToast ()


@end

static CFTimeInterval const kDefaultForwardAnimationDuration = 0.5f;
static CFTimeInterval const kDefaultBackwardAnimationDuration = 0.5f;
static CFTimeInterval const kDefautlWaitAnimationDuration = 1.0f;

static CGFloat const kDefaultTopMargin = 50.0f;
static CGFloat const kDefaultBottomMargin = 50;
static CGFloat const kDefaultTextInset = 10.0f;

@implementation JYToast

+ (id)toastWithText:(NSString *)text
{
    JYToast *toast = [[JYToast alloc]initWithText:text];
    return toast;
}

- (id)initWithText:(NSString *)text
{
    self = [self initWithFrame:CGRectZero];
    if (self) {
        self.text = text;
        [self sizeToFit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.forwardAnimationDuration = kDefaultForwardAnimationDuration;
        self.backwardAnimationDuration = kDefaultBackwardAnimationDuration;
        self.textInsets = UIEdgeInsetsMake(kDefaultTextInset, kDefaultTextInset, kDefaultTextInset, kDefaultTextInset);
        self.maxWidth = CGRectGetWidth([UIScreen mainScreen].bounds) - 20;
        self.layer.cornerRadius = 5.0f;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6f];
        self.numberOfLines = 0;
        self.textAlignment = NSTextAlignmentLeft;
        self.textColor = [UIColor whiteColor];
        self.font = [UIFont systemFontOfSize:14.0f];
    }
    return self;
}

#pragma mark - Show Methods

- (void)show
{
    [self showType:JYToastShowTypeBottom];
}

- (void)showType:(JYToastShowType)type
{
    UIWindow *keyWindow = [[UIApplication sharedApplication]keyWindow];
    [self addAnimationGroup];
    CGPoint point = keyWindow.center;
    switch (type) {
        case JYToastShowTypeTop:
        {
            point.y = kDefaultTopMargin;
            break;
        }
        case JYToastShowTypeCenter:
        {
            break;
        }
        case JYToastShowTypeBottom:
        {
            point.y = CGRectGetHeight(keyWindow.bounds) - kDefaultBottomMargin;
            break;
        }
    }
    self.center = point;
    [keyWindow addSubview:self];
}

- (void)showText:(NSString *)text
{
    self.text = text;
    [self sizeToFit];
    [self showType:JYToastShowTypeBottom];
}

#pragma mark - Animation

- (void)addAnimationGroup
{
    CABasicAnimation *forwardAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    forwardAnimation.duration = self.forwardAnimationDuration;
    forwardAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5f :1.7f :0.6f :0.85f];
    forwardAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    forwardAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    
    CABasicAnimation *backwardAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    backwardAnimation.duration = self.backwardAnimationDuration;
    backwardAnimation.beginTime = forwardAnimation.duration + kDefautlWaitAnimationDuration;
    backwardAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4f :0.15f :0.5f :-0.7f];
    backwardAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    backwardAnimation.toValue = [NSNumber numberWithFloat:0.0f];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[forwardAnimation,backwardAnimation];
    animationGroup.duration = forwardAnimation.duration + backwardAnimation.duration + kDefautlWaitAnimationDuration;
    animationGroup.removedOnCompletion = NO;
    animationGroup.delegate = self;
    animationGroup.fillMode = kCAFillModeForwards;
    
    [self.layer addAnimation:animationGroup forKey:@"customShow"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        [self removeFromSuperview];
        //动画结束时从layer层移除动画，否则，会内存泄露。
        [self.layer removeAnimationForKey:@"customShow"];
    }
}

#pragma mark - Text Configurate

- (void)sizeToFit
{
    [super sizeToFit];
    
    CGRect frame = self.frame;
    CGFloat width = CGRectGetWidth(self.bounds) + self.textInsets.left + self.textInsets.right;
//    frame.size.width = width > self.maxWidth ? self.maxWidth : width;
    frame.size.width = MIN(width, self.maxWidth);
    frame.size.height = CGRectGetHeight(self.bounds) + self.textInsets.top + self.textInsets.bottom;
    self.frame = frame;
}

- (void)drawTextInRect:(CGRect)rect
{
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.textInsets)];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    bounds.size = [self.text boundingRectWithSize:CGSizeMake(self.maxWidth - self.textInsets.left - self.textInsets.right, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
    return bounds;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
