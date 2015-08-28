# JYToast
做一个类似Android吐司控件的一个提示框

####提供两种初始化方法
	- (id)initWithText:(NSString *)text;
	
	+ (id)toastWithText:(NSString *)text;
####提供两种展示方式
	- (void)show;//Default is JYToastShowTypeBottom
	
	- (void)showType:(JYToastShowType)type;

####主要学习

- UILabel的文字设置（主要是这两个方法的使用）

	
		- (void)drawTextInRect:(CGRect)rect
		{
	    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.textInsets)];
		}

		- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
		{
		    bounds.size = [self.text boundingRectWithSize:CGSizeMake(self.maxWidth - self.textInsets.left - self.textInsets.right, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
		    return bounds;
		}

- layer层添加动画的一种方式

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
	    //回调
		- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
		{
		if (flag) {
        [self removeFromSuperview];
        //动画结束时从layer层移除动画，否则，会内存泄露。
        [self.layer removeAnimationForKey:@"customShow"];
        }
        }