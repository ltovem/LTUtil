//
//  LTOVEPickView.m
//  pickkkkk
//
//  Created by LTOVE on 16/8/8.
//  Copyright © 2016年 LTOVE. All rights reserved.
//

#import "LTOVEPickView.h"
#define topViewHeigh 35
@interface LTOVEPickView ()<UIGestureRecognizerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    //    NSString *_sep;
    //    CGFloat _topViewMaxY;
}

@property (nonatomic,strong)NSDate *date;
@property (nonatomic,weak)LTOVEPickView *ContentView;
@property (nonatomic,copy)NSString *formStr;
@property (nonatomic,assign)CGFloat topViewMaxY;
@property (nonatomic,strong)UIDatePicker *datePicview;

@property (nonatomic,strong)NSMutableArray *countArray;
@property (nonatomic,strong)NSArray *dateArray;
@property (nonatomic,strong)UIPickerView *picview;
@property (nonatomic,strong)NSMutableArray *selectedArray;
@property (nonatomic,strong)NSMutableArray *selectedStrArray;
@end

@implementation LTOVEPickView

+ (LTOVEPickView *)showPickViewWithHeigh:(CGFloat)heigh andDateArray:(NSArray *)dateArray andInitSelectArray:(NSArray *)array
{
    LTOVEPickView *view = [LTOVEPickView showPickViewWithHeigh:heigh andDateArray:dateArray];
    
    
    //首次进入设置默认值
    
    [view setValveWithselsetedArray:array];
    return view;
}
/**
 *  首次进入设置默认值
 *
 *  @param array array description
 */
- (void)setValveWithselsetedArray:(NSArray *)array
{
    //    int count = 0;
    for (int i = 0; i < array.count; i ++) {
        NSString *title = array[i];
        NSArray *array = [self arrayWithCompontent:i];
        for (int j = 0; j < array.count; j ++) {
            NSString *titStr = array[j];
            if ([title isEqualToString:titStr]) {
                
                NSString *countStr = [NSString stringWithFormat:@"%d",j];
                [_countArray replaceObjectAtIndex:i withObject:countStr];
                
            }
        }
        
    }
    [self reloadAndSetRows];
}


+ (LTOVEPickView *)dateObjWithHeigh:(CGFloat)heigh andPickModel:(UIDatePickerMode)pickModel andDateFormStr:(NSString *)formStr andDefaultDate:(NSDate *)date
{
    LTOVEPickView *view = [LTOVEPickView dateObjWithHeigh:heigh andPickModel:pickModel andDateFormStr:formStr];
    if (!date) {
        return view;
    }
    view.datePicview.date = date;
    [view.datePicview reloadInputViews];
    return view;
}


+ (LTOVEPickView *)dateObjWithHeigh:(CGFloat)heigh andPickModel:(UIDatePickerMode)pickModel andDateFormStr:(NSString *)formStr
{
    
    //        [[UIApplication sharedApplication].keyWindow addSubview:datePick];
    
    LTOVEPickView *view = [[LTOVEPickView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    view.formStr = formStr == nil ? @"yy-MM-dd" :formStr;
    
    //    增加通用子视图
    [view setUpSubViewsWithView:view andHeigh:heigh];
    
    UIDatePicker *datePick = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, view.topViewMaxY, [UIScreen mainScreen].bounds.size.width, heigh)];
    //    datePick.center = view.center;
    NSLocale *local = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    datePick.locale = local;
    datePick.datePickerMode = pickModel;
    datePick.backgroundColor = [UIColor whiteColor];
    view.userInteractionEnabled = YES;
    
    [datePick reloadInputViews];
    
    view.datePicview = datePick;
    
    [view addSubview:datePick];
    //    view.backgroundColor = [UIColor greenColor];
    [datePick addTarget:view action:@selector(datePichChanged:) forControlEvents:UIControlEventValueChanged];
    //    result(view.date);
    
    return view;
    
    
}



+ (LTOVEPickView *)showPickViewWithHeigh:(CGFloat)heigh andDateArray:(NSArray *)dateArray
{
    LTOVEPickView *view = [[LTOVEPickView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    //增加通用子视图
    [view setUpSubViewsWithView:view andHeigh:heigh];
    
    //标签数组
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < dateArray.count; i ++) {
        [arr addObject:@"0"];
    }
    view.countArray = arr;
    //创建pickView
    UIPickerView *picView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, view.topViewMaxY, [UIScreen mainScreen].bounds.size.width, heigh)];
    picView.backgroundColor = [UIColor whiteColor];
    picView.alpha = 1;
    view.picview = picView;
    picView.delegate = view;
    picView.dataSource = view;
    [view addSubview:picView];
    view.dateArray = dateArray;
    //设置默认选中
    [view initSelectedArray];
    [view reloadAndSetRows];
    
    [view initSelectedStrArray];
    
    
    
    return view;
}
/**
 *  初始化PickView默认选中值
 */
- (void)initPickViewValue
{
    [self setDeleGatePickView];
    
}

- (void)initDatePickViewValue
{
    [self datePichChanged:_datePicview];
}
/**
 *  初始化选中数组字符数组
 */
- (void)initSelectedStrArray
{
    for (int i = 0; i < _countArray.count; i ++) {
        NSString *rows = _countArray[i];
        //        [_picview selectRow:[rows integerValue] inComponent:i animated:YES];
        
        //初始化选中数组
        if (!_selectedStrArray) {
            _selectedStrArray = [NSMutableArray new];
        }
        NSArray *array = _selectedArray[i];
        NSString *str = array[[rows integerValue]];
        [_selectedStrArray addObject:str];
    }
}

/**
 *  初始化选中数组
 */
- (void)initSelectedArray
{
    for (NSInteger i = 0; i < _countArray.count; i ++) {
        NSArray *array = [self arrayWithCompontent:i];
        if (!_selectedArray) {
            _selectedArray = [NSMutableArray new];
        }
        [_selectedArray addObject:array];
    }
}
/**
 *  改变选中数组
 */
- (void)changeSelectedArray
{
    for (NSInteger i = 0; i < _countArray.count; i ++) {
        NSArray *array = [self arrayWithCompontent:i];
        //        if (!_selectedArray) {
        //            _selectedArray = [NSMutableArray new];
        //        }
        //        [_selectedArray addObject:array];
        [_selectedArray replaceObjectAtIndex:i withObject:array];
    }
}

#pragma pickView数据源方法


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return _dateArray.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //    NSArray *array = _dateArray[component];
    //    for (int i = 0; i < component; i++) {
    //        NSString *count = _countArray[i];
    //        array = [self getArrayWithArray:array count:[count integerValue]];
    //    }
    NSArray *array = [self arrayWithCompontent:component];
    return array.count;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = @"";
    if (!_selectedArray) {
        _selectedArray = [NSMutableArray new];
    }
    //    [_selectedArray addObject:array];
    
    //    _selectedArray = selectArray;
    
    NSArray *array = [self arrayWithCompontent:component];
    title = array[row];
    return title;
}

- (NSArray *)arrayWithCompontent:(NSInteger)commontent
{
    NSArray *array = _dateArray[commontent];
    //    NSMutableArray *selectArray = [NSMutableArray new];
    for (int i = 0; i <commontent; i ++) {
        NSString *count = _countArray[i];
        array = [self getArrayWithArray:array count:[count integerValue]];
    }
    return array;
    
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *countStr = [NSString stringWithFormat:@"%ld",(long)row];
    [_countArray replaceObjectAtIndex:component withObject:countStr];
    for (NSInteger i = component + 1;i < _countArray.count; i++) {
        [_countArray replaceObjectAtIndex:i withObject:@"0"];
    }
    [self reloadAndSetRows];
    //    NSLog(@"%@",_selectedArray);
    [self changeSelectedArray];
    //    [_selectedArray writeToFile:@"/Users/LTOVE/Desktop/xxxx.plist" atomically:YES];
    [self selectedStrChangedWithDidcomponent:component selectedRow:row];
}

- (void)selectedStrChangedWithDidcomponent:(NSInteger)component selectedRow:(NSInteger)row
{
    
    for (NSInteger i = component; i <_countArray.count; i ++) {
        NSArray *array = _selectedArray[i];
        NSString *str = _countArray[i];
        NSString *selectedStr = array[[str integerValue]];
        [_selectedStrArray replaceObjectAtIndex:i withObject:selectedStr];
        
    }
    
    [self setDeleGatePickView];
    
    
}
/**
 *  设置pickView代理
 */
- (void)setDeleGatePickView
{
    //设置代理方法
    if ([_delegate respondsToSelector:@selector(pickViewChangedWithStr:)]) {
        //        返回字符串
        NSMutableString *str = [NSMutableString string];
        for (NSString *sttr in _selectedStrArray) {
            //            CGFloat x = str.length;
            if (str.length == 0) {
                
                str = [NSMutableString stringWithFormat:@"%@",sttr];
            }else
                
                [str appendFormat:@"-%@",sttr];
        }
        //        NSLog(@"ss--%@",str);
        [_delegate pickViewChangedWithStr:str];
        
    }
    
    if ([_delegate respondsToSelector:@selector(pickViewChangedWithArray:)]) {
        [_delegate pickViewChangedWithArray:_selectedStrArray];
    }
    
}


/**
 *  刷新数据设置默认选中
 */
- (void)reloadAndSetRows
{
    [_picview reloadAllComponents];
    for (int i = 0; i < _countArray.count; i ++) {
        NSString *rows = _countArray[i];
        [_picview selectRow:[rows integerValue] inComponent:i animated:YES];
    }
    
}

/**
 *  剥离数组
 *
 *  @param array array description
 *  @param count count description
 *
 *  @return return value description
 */
- (NSArray *)getArrayWithArray:(NSArray *)array count:(NSUInteger)count
{
    NSArray *subArray = array[count];
    return subArray;
}



/**
 *  加载通用子视图
 *
 *  @param view  view description
 *  @param heigh heigh description
 */
- (void)setUpSubViewsWithView:(LTOVEPickView *)view andHeigh:(CGFloat)heigh
{
    view.ContentView = view;
    view.backgroundColor = [UIColor clearColor];
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, view.frame.size.height - topViewHeigh - heigh, view.frame.size.width, topViewHeigh)];
    
    
    topView.backgroundColor = [UIColor whiteColor];
    
    //添加分割线
    UILabel *topLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, topView.frame.size.width, 1)];
    topLine.backgroundColor = [UIColor blackColor];
    UILabel *buttomLine = [[UILabel alloc]initWithFrame:CGRectMake(0, topView.frame.size.height - 1, topView.frame.size.width, 1)];
    buttomLine.backgroundColor = [UIColor blackColor];
    [topView addSubview:topLine];
    [topView addSubview:buttomLine];
    //    添加button
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    btn.titleLabel.text = @"确定";
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn sizeToFit];
    //    btn.backgroundColor = [UIColor whiteColor];
    //    btn.frame = CGRectMake(topView.frame.size.width - 20, topView.frame.size.height * 0.5 ,20, 20);
    btn.center = CGPointMake(topView.frame.size.width - 30, topView.frame.size.height * 0.5);
    [topView addSubview:btn];
    
    //    上部视图
    UIView *topContentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, topView.frame.origin.y)];
    
    //view注册点击事件
    UIGestureRecognizer *tapGestur = [[UITapGestureRecognizer alloc]initWithTarget:view action:@selector(hiddenView:)];
    tapGestur.delegate = view;
    topContentView.backgroundColor = [UIColor clearColor];
    [topContentView addGestureRecognizer:tapGestur];
    
    [view addSubview:topContentView];
    [btn addTarget:view action:@selector(hiddenView:) forControlEvents:UIControlEventTouchUpInside];
    
    _topViewMaxY = CGRectGetMaxY(topView.frame);
    
    [view addSubview:topView];
}

//- (void)setDatePicview:(UIDatePicker *)datePicview
/**
 *  日期改变
 *
 *  @param sender sender description
 */
- (void)datePichChanged:(id)sender
{
    UIDatePicker *pick = sender;
    if ([_delegate respondsToSelector:@selector(dateValueChangedWithDate:)]) {
        [_delegate dateValueChangedWithDate:pick.date];
    }
    if ([_delegate respondsToSelector:@selector(dateStrimgWithFormStr:)]) {
        [_delegate dateStrimgWithFormStr:[self dateFormateWithDate:pick.date]];
    }
    
}
/**
 *  格式化日期
 *
 *  @param date <#date description#>
 *
 *  @return <#return value description#>
 */
- (NSString *)dateFormateWithDate:(NSDate *)date
{
    NSDateFormatter *form = [[NSDateFormatter alloc]init];
    [form setDateFormat:_formStr];
    return [form stringFromDate:date];
}


/**
 *  消失动画
 *
 *  @param view view description
 */
- (void)hiddenView:(UIView *)view
{
    [UIView animateWithDuration:0.5 animations:^{
        _ContentView.alpha = 0;
    } completion:^(BOOL finished) {
        [_ContentView removeFromSuperview];
    }];
    
    
    
}

@end
