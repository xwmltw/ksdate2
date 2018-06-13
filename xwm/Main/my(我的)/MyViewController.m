//
//  MyViewController.m
//  ChooseDay
//
//  Created by Rockeen on 16/1/16.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "MyViewController.h"
#import "EnterViewController.h"
#import "ThemeViewController.h"
#import "InstallViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "GUNMMAFN.h"

@interface MyViewController ()<UIAlertViewDelegate>
{
     NSFileManager *manager;
}
@property (nonatomic, strong) NSMutableArray *lists;


@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = item;
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil]];
    
    //设置用户头像的属性
    self.userImg.layer.borderWidth = 1.f;
    
    self.userImg.layer.borderColor = [[UIColor grayColor]CGColor];
    
    self.userImg.layer.cornerRadius = 50.f;
    
    self.userImg.clipsToBounds = YES;
   
}

// 判断是否登录状态
- (BOOL)isLoggedIn {
    return NO;
}



//cell的点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //获取cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    //根据cell不同的tag值推出显示不同的页面
    if (cell.tag == 100) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"很酷吧！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        alert.alertViewStyle = UIAlertViewStyleDefault;
        
        [alert show];

    }else if (cell.tag == 110) {
    
        //主题切换
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"ThemeViewController" bundle:nil];
        
        ThemeViewController *themeVC = [story instantiateInitialViewController];
        
        [self.navigationController pushViewController:themeVC animated:YES];
    
    }else if (cell.tag == 111) {
    
        
    
    }else if (cell.tag == 120) {
    
        //删除cache文件 清理缓存
        NSString *liabrary = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
        
        //获取Caches文件路径
        NSString *cache = [liabrary stringByAppendingPathComponent:@"Caches"];
        
        
        //for in遍历library文件夹里的所有子文件
        for (NSString *filePath in [manager subpathsAtPath:cache]) {
            
            //转换filePath
            NSString *subPath = [cache stringByAppendingPathComponent:filePath];
            
            //删除指定文件
            [manager removeItemAtPath:subPath error:nil];
            
        }
        //        NSLog(@"cache is:%@",cache);
        
        //弹出提示框
        [self createAlertView];
        
        //刷新表视图
        [self.tableView reloadData];
    
    }
}
//沙盒目录
-(NSString *)sandBox{
    
    //获取library文件
    NSString *library = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    
    //文件缓存数值
    float totalsize = 0;
    
    //for in遍历library文件夹里的所有子文件
    for (NSString *filePath in [manager subpathsAtPath:library]) {
        
        //转换filePath
        NSString *subPath = [library stringByAppendingPathComponent:filePath];
        
        //获取文件里的所有属性，都是存放在字典里
        NSDictionary *dic = [manager attributesOfItemAtPath:subPath error:nil];
        
        //赋值--- 文件大小
        totalsize += [dic[NSFileSize] floatValue];
        
    }
    
    //返回大小---存放的是字节，转换成M
    return [NSString stringWithFormat:@"%.1f",(totalsize/1024.0/1024.0 - 0.08f)];
}

//创建提示框
-(void)createAlertView{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"已成功删除缓存！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    alert.alertViewStyle = UIAlertViewStyleDefault;
    
    [alert show];
    
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
   

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
