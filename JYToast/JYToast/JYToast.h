//
//  JYToast.h
//  JYToast
//
//  Created by fangjiayou on 15/8/28.
//  Copyright (c) 2015年 方. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JYToastShowType) {
    JYToastShowTypeTop,
    JYToastShowTypeCenter,
    JYToastShowTypeBottom,
};

@interface JYToast : UILabel

@property(nonatomic,assign) CFTimeInterval forwardAnimationDuration;
@property(nonatomic,assign) CFTimeInterval backwardAnimationDuration;
@property(nonatomic,assign) UIEdgeInsets textInsets;
@property(nonatomic,assign) CGFloat maxWidth;

/*!
 *  @author Yooeee
 *
 *  @brief  产生实例
 *
 *  @param text 文字
 *
 *  @return 吐司
 */
+ (id)toastWithText:(NSString *)text;

/*!
 *  @author Yooeee
 *
 *  @brief  使用文字进行初始化
 *
 *  @param text 文字
 *
 *  @return 吐司
 */
- (id)initWithText:(NSString *)text;

/*!
 *  @author Yooeee
 *
 *  @brief  默认的展示方式
 */
- (void)show;//Default is JYToastShowTypeBottom

/*!
 *  @author Yooeee
 *
 *  @brief  可设置位置的展示
 *
 *  @param type 上 中 下
 */
- (void)showType:(JYToastShowType)type;

@end
