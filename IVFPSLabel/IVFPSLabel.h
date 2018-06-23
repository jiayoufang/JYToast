//
//  IVFPSLabel.h
//  Van
//
//  Created by fangjiayou on 2018/6/12.
//  Copyright © 2018年 Ivan. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 Show Screen FPS...
 
 The maximum fps in OSX/iOS Simulator is 60.00.
 The maximum fps on iPhone is 59.97.
 The maxmium fps on iPad is 60.0.
 
 代码主要来自 YYKit ，改掉了使用YYText的部分，解除对YYText的依赖
 
 */

/**
 FPSLabel位置

 - IVFPSLabelLocationTopLeft: 左上角
 - IVFPSLabelLocationTopRight: 右上角
 - IVFPSLabelLocationBottomLeft: 左下角
 - IVFPSLabelLocationBottomRight: 右下角
 - IVFPSLabelLocationDefault: 缺省位置 左上角
 */
typedef NS_ENUM(NSInteger,IVFPSLabelLocation){
    IVFPSLabelLocationTopLeft,
    IVFPSLabelLocationTopRight,
    IVFPSLabelLocationBottomLeft,
    IVFPSLabelLocationBottomRight,
    IVFPSLabelLocationDefault = IVFPSLabelLocationTopLeft,
};

@interface IVFPSLabel : UILabel

/**
 默认显示在 keyWindow 的左上角
 */
+ (void)show;

/**
 指定所在的view 默认位置在 左上角
 */
+ (void)showInView:(UIView *)view;

/**
 指定所在的view 及 位置
 */
+ (void)showInView:(UIView *)view location:(IVFPSLabelLocation)location;

/**
 执行所在的view 及 精确位置
 */
+ (void)showInView:(UIView *)view position:(CGPoint)poistion;

@end
