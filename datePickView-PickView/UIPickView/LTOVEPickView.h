//
//  LTOVEPickView.h
//  pickkkkk
//
//  Created by LTOVE on 16/8/8.
//  Copyright © 2016年 LTOVE. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol datePickDelegate <NSObject>
@optional
/**
 *  返回date对象
 *
 *  @param date
 */
- (void)dateValueChangedWithDate:(NSDate *)date;
/**
 *  返回格式化的字符串
 *
 *  @param ymd ymd description
 */
- (void)dateStrimgWithFormStr:(NSString *)formStr;
/**
 *  pickView改变的时候的回调  返回字符串 - 隔开
 *
 *  @param Str <#Str description#>
 */
- (void)pickViewChangedWithStr:(NSString *)Str;
/**
 *  pickView改变的回调 返回数组
 *
 *  @param array array description
 */
- (void)pickViewChangedWithArray:(NSArray *)array;
@end

@interface LTOVEPickView : UIView


/**
*  创建datepick视图 默认当前时间
*
*  @param heigh     高度
*  @param pickModel 视图类型
*  @param sep       dateForm 字符串
*
*  @return return value description
*/
+ (LTOVEPickView *)dateObjWithHeigh:(CGFloat)heigh andPickModel:(UIDatePickerMode)pickModel andDateFormStr:(NSString *)formStr;
/**
 *  创建datepick视图 自定义时间
 *
 *  @param heigh     heigh description
 *  @param pickModel pickModel description
 *  @param formStr   formStr description
 *  @param date      date 为空则是默认时间
 *
 *  @return return value description
 */
+ (LTOVEPickView *)dateObjWithHeigh:(CGFloat)heigh andPickModel:(UIDatePickerMode)pickModel andDateFormStr:(NSString *)formStr andDefaultDate:(NSDate *)date;
//+ (LTOVEPickView *)dateObjWithHeigh:(CGFloat)heigh andPickModel:(UIDatePickerMode)pickModel andDateFormStr:(NSString *)formStr;
/**
 *  创建pickView  默认第一行
 *
 *  @param heigh     heigh description
 *  @param dateArray dateArray description
 *
 *  @return return value description
 */
+ (LTOVEPickView *)showPickViewWithHeigh:(CGFloat)heigh andDateArray:(NSArray *)dateArray;

/**
 *  创建pickView  默认自定义
 *
 *  @param heigh     heigh description
 *  @param dateArray dateArray description
 *  @param array     默认选中数组
 *
 *  @return return value description
 */
+ (LTOVEPickView *)showPickViewWithHeigh:(CGFloat)heigh andDateArray:(NSArray *)dateArray andInitSelectArray:(NSArray *)array;
@property (nonatomic,weak) id<datePickDelegate>delegate;
@end
