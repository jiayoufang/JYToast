//
//  IVFPSLabel.m
//  Van
//
//  Created by fangjiayou on 2018/6/12.
//  Copyright © 2018年 Ivan. All rights reserved.
//

#import "IVFPSLabel.h"

#define kSize CGSizeMake(55, 20)

@implementation IVFPSLabel{
    CADisplayLink *_link;
    NSUInteger _count;
    NSTimeInterval _lastTime;
    UIFont *_font;
    UIFont *_subFont;
}

+ (void)show{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [self showInView:keyWindow];
}

+ (void)showInView:(UIView *)view{
    [self showInView:view location:IVFPSLabelLocationDefault];
}

+ (void)showInView:(UIView *)view location:(IVFPSLabelLocation)location{
    CGPoint poistion = CGPointZero;
    switch (location) {
        case IVFPSLabelLocationTopLeft:
            poistion = CGPointMake(10, 10);
            break;
            case IVFPSLabelLocationTopRight:
            poistion = CGPointMake(CGRectGetMaxX(view.bounds) - 10 - 50, 10);
            break;
            case IVFPSLabelLocationBottomLeft:
            poistion = CGPointMake(10, CGRectGetMaxY(view.bounds) - 10 - 30);
            break;
            case IVFPSLabelLocationBottomRight:
            poistion = CGPointMake(CGRectGetMaxX(view.bounds) - 10 - 50, CGRectGetMaxY(view.bounds) - 10 - 30);
            break;
        default:
            poistion = CGPointMake(10, 10);
            break;
    }
    
    [self showInView:view position:poistion];
}

+ (void)showInView:(UIView *)view position:(CGPoint)poistion{
    static IVFPSLabel *fpsLabel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fpsLabel = [[IVFPSLabel alloc]initWithFrame:CGRectMake(poistion.x, poistion.y, 50, 30)];
    });
    [view addSubview:fpsLabel];
    [view bringSubviewToFront:fpsLabel];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0) {
        frame.size = kSize;
    }
    self = [super initWithFrame:frame];
    
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    self.textAlignment = NSTextAlignmentCenter;
    self.userInteractionEnabled = NO;
    self.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.700];
    
    _font = [UIFont fontWithName:@"Menlo" size:14];
    if (_font) {
        _subFont = [UIFont fontWithName:@"Menlo" size:4];
    } else {
        _font = [UIFont fontWithName:@"Courier" size:14];
        _subFont = [UIFont fontWithName:@"Courier" size:4];
    }
    
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
    [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    return self;
}

- (void)dealloc {
    [_link invalidate];
}

- (CGSize)sizeThatFits:(CGSize)size {
    return kSize;
}

- (void)tick:(CADisplayLink *)link {
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        return;
    }
    
    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) return;
    _lastTime = link.timestamp;
    float fps = _count / delta;
    _count = 0;
    
    CGFloat progress = fps / 60.0;
    UIColor *color = [UIColor colorWithHue:0.27 * (progress - 0.2) saturation:1 brightness:0.9 alpha:1];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d FPS",(int)round(fps)]];
    [text addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, text.length - 3)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(text.length - 3, 3)];
    [text addAttribute:NSFontAttributeName value:_font range:NSMakeRange(0, text.length)];
    [text addAttribute:NSFontAttributeName value:_subFont range:NSMakeRange(text.length - 4, 1)];
    self.attributedText = text;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
