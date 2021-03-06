//
//  WHUCalendarYMSelectView.m
//  TEST_Calendar
//
//  Created by SuperNova(QQ:422596694) on 15/11/6.
//  Copyright (c) 2015年 SuperNova(QQ:422596694). All rights reserved.
//
#import "WHUCalendarYMSelectView.h"
#define WHUCalendarYMSelectView_Piker_Height 150.0f
#define WHUCalendarYMSelectView_Margin 10.0f

NSInteger const yearNumber=2016;

@interface WHUCalendarYMSelectView()<UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,strong) UIPickerView* pickerView;
@property(nonatomic,strong) NSArray* monthArr;
@property(nonatomic,strong) NSArray* yearArr;
@property(nonatomic,assign) NSInteger curYear;
@property(nonatomic,assign) NSInteger yearRange;
@end
@implementation WHUCalendarYMSelectView{


    UILabel *_label;

}
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        [self setupViews];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
   self= [super initWithCoder:aDecoder];
    if(self){
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    _yearRange=94;
    _pickerView=[[UIPickerView alloc] init];
    
//    _pickerView.backgroundColor=[UIColor whiteColor];
    _pickerView.translatesAutoresizingMaskIntoConstraints=NO;
    [self addSubview:_pickerView];
    _pickerView.showsSelectionIndicator=YES;
    _pickerView.delegate=self;
    NSDictionary* viewDic=@{
                            @"picker":_pickerView
                            };
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[picker]|" options:0 metrics:nil views:viewDic]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[picker]|" options:0 metrics:nil views:viewDic]];
    NSCalendar* cal=[NSCalendar currentCalendar];
    NSDateComponents* com=[cal components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:[NSDate date]];
    self.curYear=com.year;
    [_pickerView selectRow:_yearRange inComponent:0 animated:NO];
    [_pickerView selectRow:com.month-1 inComponent:1 animated:NO];
}


-(NSString*)selectdDateStr{
  NSInteger year=yearNumber-_yearRange+[_pickerView selectedRowInComponent:0];
  NSInteger month=[_pickerView selectedRowInComponent:1]+1;
  return [NSString stringWithFormat:@"%ld年%ld月",(long)year,(long)month];
}

// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        
        return _yearRange*2-6;
    }
    
    return 12;
}

// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if(component==0){
        return pickerView.frame.size.width/2.0f;
    }
    else{
        return pickerView.frame.size.width/3.0f;
    }
}

// 返回选中的行,改变选中行的颜色
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
   
  UILabel *lable=  (UILabel *)[pickerView viewForRow:row forComponent:component];
    
    
    NSMutableArray *arr = kMainColor2;
    lable.textColor=[UIColor colorWithRed:[arr[0] floatValue] green:[arr[1] floatValue] blue:[arr[2] floatValue] alpha:1];


    
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        row=yearNumber-_yearRange+row;
        
        return  [NSString stringWithFormat:@"%ld年",(long)row];
        
    } else {
        
        return  [NSString stringWithFormat:@"%ld月",(long)row+1];
    }
}

//修改pickerview lable的颜色
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *label = [[UILabel alloc] init];
    
    _label=label;
    
//    _label.font=[UIFont systemFontOfSize:25];

    
    if (component == 0) {
        row=yearNumber-_yearRange+row;
        
        _label.text=[NSString stringWithFormat:@"       %ld年",(long)row];
        
        _label.font=[UIFont systemFontOfSize:20];
        
        _label.textColor = [UIColor lightGrayColor];


    } else {
        
        
        _label.text=  [NSString stringWithFormat:@"       %ld月",(long)row+1];

        _label.font=[UIFont systemFontOfSize:17];

        _label.textColor = [UIColor lightGrayColor];

    }
    return _label;

}
@end
