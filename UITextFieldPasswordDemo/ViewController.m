//
//  ViewController.m
//  UITextFieldPasswordDemo
//
//  Created by lynnjinglei on 15/9/6.
//  Copyright (c) 2015年 XiaoLei. All rights reserved.
//

#import "ViewController.h"
#import "DKTextField.h"
#import "EmailCell.h"

@interface ViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITextField *accountTextField;
    
    DKTextField *psdTextField;
    
    UIButton *showButton;
    
    BOOL isShowPsd;
    
    UITableView *listTableView;
    
    NSArray *emailsArray;
    
    BOOL isShowList;
    
    NSMutableArray *tableViewData;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tableViewData = [NSMutableArray array];
    
    isShowList = NO;
    
    emailsArray = [NSArray arrayWithObjects:@"sohu.com",@"sina.com",@"163.com",@"126.com",@"qq.com", nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadAccountTextField];
    
    [self loadPsdTextField];
    
    [self loadTableView];
}
- (void)loadTableView
{
    listTableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 108, self.view.frame.size.width - 20, 100) style:UITableViewStyleGrouped];
    listTableView.delegate = self;
    listTableView.hidden = YES;
    listTableView.dataSource = self;
    listTableView.scrollEnabled = NO;
    listTableView.backgroundColor = [UIColor whiteColor];
    listTableView.separatorColor = [UIColor clearColor];
    listTableView.layer.borderColor = [UIColor colorWithRed:229 / 255.0f green:230 / 255.0f blue:234 / 255.0f alpha:1].CGColor;
    listTableView.layer.borderWidth = 0.5;
    [self.view addSubview:listTableView];
}
- (void)loadAccountTextField
{
    accountTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 64, self.view.frame.size.width - 20, 44)];
    accountTextField.layer.borderColor = [UIColor redColor].CGColor;
    accountTextField.font = [UIFont systemFontOfSize:14];
    accountTextField.autocorrectionType = UITextAutocorrectionTypeNo;//关闭拼写检查
    accountTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;//首字母小写
    
    accountTextField.layer.borderWidth = 0.5;
    accountTextField.delegate = self;
    [accountTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    accountTextField.secureTextEntry = NO;
    
    UILabel *subAccountLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    subAccountLabel.text = @"账号";
    subAccountLabel.font = [UIFont systemFontOfSize:15];
    subAccountLabel.textColor = [UIColor redColor];
    subAccountLabel.textAlignment = NSTextAlignmentCenter;
    accountTextField.leftView = subAccountLabel;
    accountTextField.leftViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:accountTextField];
}
- (void)loadPsdTextField
{
    UIView *psdBgView = [[UIView alloc]init];
    psdBgView.frame = CGRectMake(10, 118, self.view.frame.size.width - 20, 44);
    psdBgView.layer.borderColor = [UIColor redColor].CGColor;
    psdBgView.layer.borderWidth = 0.5;
    [self.view addSubview:psdBgView];
    
    psdTextField = [[DKTextField alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 20 - 44, 44)];
    psdTextField.secureTextEntry = YES;
    psdTextField.font = [UIFont systemFontOfSize:14];
    [psdTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    psdTextField.delegate = self;
    [psdBgView addSubview:psdTextField];
    
    UILabel *subPsdLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    subPsdLabel.text = @"密码";
    subPsdLabel.font = [UIFont systemFontOfSize:15];
    subPsdLabel.textColor = [UIColor redColor];
    subPsdLabel.textAlignment = NSTextAlignmentCenter;
    psdTextField.leftView = subPsdLabel;
    psdTextField.leftViewMode = UITextFieldViewModeAlways;
    
    isShowPsd = NO;
    showButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    showButton.frame = CGRectMake(psdBgView.bounds.size.width - 44, 0, 44, 44);
    showButton.backgroundColor = [UIColor clearColor];
    [showButton setTitle:@"显示" forState:UIControlStateNormal];
    [showButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [psdBgView addSubview:showButton];
}
-(void)setShowList:(BOOL)iShow{
    
    isShowList=iShow;
    
    if(isShowList && tableViewData != nil && tableViewData.count > 0)
    {
        listTableView.frame = CGRectMake(10, 108, self.view.frame.size.width - 20, 36 * tableViewData.count);
    }
    
    listTableView.hidden=!iShow;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if(textField == accountTextField)
    {
        [self setShowList:NO];
    }
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //判断text 是否输入过@ 如果输入过则不出现下啦菜单
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (textField == accountTextField)
    {
        if ([text containsString:@"@"])//是否包含@
        {
            [tableViewData removeAllObjects];
            //范围
            NSRange range = [text rangeOfString:@"@"];
            
            if ((range.location + range.length) == text.length)
            {
                for (NSString *str in emailsArray)
                {
                    [tableViewData addObject:[NSString stringWithFormat:@"%@%@",text,str]];
                }
            }
            else
            {
                
                NSString *suffix = [text substringWithRange:NSMakeRange(range.location+range.length, text.length-(range.location+range.length))];
                
                NSString *headText = [text substringWithRange:NSMakeRange(0,range.location+range.length)];
                
                for (NSString *str in emailsArray)
                {
                    //匹配
                    if ([str hasPrefix:suffix])
                    {
                        [tableViewData addObject:[NSString stringWithFormat:@"%@%@",headText,str]];
                    }
                }

            }
            if (tableViewData.count<=0)
            {
                [self setShowList:NO];
            }
            else
            {
                [self setShowList:YES];
            }
            
            [listTableView reloadData];
        }
        else
        {
            [self setShowList:NO];
        }
    }
    return YES;
}
- (void)buttonClick:(UIButton *)btn
{
    if(!isShowPsd)
    {
        [showButton setTitle:@"隐藏" forState:UIControlStateNormal];
        psdTextField.secureTextEntry = NO;
        isShowPsd = YES;
    }
    else
    {
        [showButton setTitle:@"显示" forState:UIControlStateNormal];
        psdTextField.secureTextEntry = YES;
        isShowPsd = NO;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableViewData != nil && tableViewData.count > 0)
    {
        return tableViewData.count;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 36;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cellName";
    EmailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if(cell == nil)
    {
        cell = [[EmailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    if(indexPath.row %2 == 0)
    {
        cell.backgroundColor = [UIColor colorWithRed:229 / 255.0f green:230 / 255.0f blue:234 / 255.0f alpha:1];
    }
    else
    {
        cell.backgroundColor = [UIColor whiteColor];
    }
    if(tableViewData != nil && tableViewData.count > 0)
    {
        cell.emailLabel.text = [tableViewData objectAtIndex:indexPath.row];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *selectedIndex = [tableView indexPathForSelectedRow];
    [tableView deselectRowAtIndexPath:selectedIndex animated:YES];
    
    if(tableViewData != nil && tableViewData.count > 0)
    {
        accountTextField.text = [tableViewData objectAtIndex:indexPath.row];
        
        [self setShowList:NO];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
