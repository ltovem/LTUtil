//
//  ViewController.m
//  pickkkkk
//
//  Created by LTOVE on 16/8/8.
//  Copyright © 2016年 LTOVE. All rights reserved.
//

#import "ViewController.h"

#import "LTOVEPickView.h"
@interface ViewController ()<datePickDelegate>

@end

@implementation ViewController

- (void)pickViewChangedWithStr:(NSString *)Str
{
    NSLog(@"huidiao%@",Str);
}

- (void)dateValueChangedWithDate:(NSDate *)date
{
    NSDateFormatter * f = [[NSDateFormatter alloc]init];
    [f setDateFormat:@"yyyy-MM-dd HH mm"];
    NSString *str = [f stringFromDate:date];
    NSLog(@"%@",str);
}

- (void)dateStrimgWithFormStr:(NSString *)formStr
{
    NSLog(@"%@",formStr);
}
- (void)dateStrimgWithFormyyyy_MM_dd:(NSString *)ymd
{
    NSLog(@"%@",ymd);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *first = @[@"田",@"2",@"3",@"2"];
    
    NSArray *sec = @[
                     @[@"2",@"1",@"2",@"2"],
                     @[@"1",@"2",@"1"
                       ],
                     @[@"3",@"1",@"3",],
                     @[@"3",@"1",@"3",],
                     ];
    NSArray *secs = @[
                      @[
                          @[@"2",@"1",@"3",@"4",],
                          @[@"2",@"1",@"2",],
                          @[@"2",@"1",@"2",],
                          @[@"2",@"1",@"2",],
                          ],
                      @[
                          @[@"2",@"1",@"2",],
                          @[@"2",@"1",@"2",],
                          @[@"2",@"1",@"2",],
                          ],
                      @[
                          @[@"2",@"1",@"3",@"4",],
                          @[@"2",@"1",@"2",],
                          @[@"2",@"1",@"2",@"2",],
                          ],
                      @[
                          @[@"2",@"1",@"3",@"4",],
                          @[@"2",@"1",@"2",],
                          @[@"2",@"1",@"2",@"2",],
                          ],
                      
                      ];
    NSArray *daarr = @[first,sec,secs];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *datestr = @"2009-06-12";
    NSDateFormatter *fm = [[NSDateFormatter alloc]init];
    [fm setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date =[fm dateFromString:datestr ];
    //    datePick.date = date;
    LTOVEPickView *view = [LTOVEPickView dateObjWithHeigh:180 andPickModel:UIDatePickerModeDate andDateFormStr:@"yy--MM" andDefaultDate:date];
    //    LTOVEPickView *view = [LTOVEPickView showPickViewWithHeigh:180 andDateArray:daarr andInitSelectArray:@[@"田",@"1",@"1"]];
    view.frame = self.view.bounds;
    
    view.delegate = self;
    
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
