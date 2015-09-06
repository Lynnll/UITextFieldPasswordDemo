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
    
    NSString *passwordString;
    
    UITableView *listTableView;
    
    NSArray *emailsArray;
    
    BOOL _showList;
    
    NSMutableArray *tableViewData;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tableViewData = [NSMutableArray array];
    
    passwordString = @"";
    
    _showList = NO;
    
    emailsArray = [NSArray arrayWithObjects:@"sohu.com",@"sina.com",@"163.com",@"126.com",@"qq.com", nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadAccountTextField];
    
    [self loadPsdTextField];
    
    [self loadTableView];


//    UIButton * showBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    showBtn.frame = CGRectMake(10, 200, 44, 44);
//    showBtn.backgroundColor = [UIColor clearColor];
//    [showBtn setTitle:@"显示" forState:UIControlStateNormal];
//    [showBtn addTarget:self action:@selector(resigClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:showBtn];
}
//- (void)resigClick
//{
////    [psdTextField resignFirstResponder];
//    NSLog(@"psdtext = %@",psdTextField.text);
//}
- (void)loadTableView
{
    listTableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 108, self.view.frame.size.width - 20, 100) style:UITableViewStyleGrouped];
    listTableView.delegate = self;
    listTableView.hidden = YES;
    listTableView.dataSource = self;
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
    
    _showList=iShow;
    
    listTableView.hidden=!iShow;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
//    if (range.location > 0 && range.length == 1 && string.length == 0)
//    {
//        // Stores cursor position
//        UITextPosition *beginning = textField.beginningOfDocument;
//        UITextPosition *start = [textField positionFromPosition:beginning offset:range.location];
//        NSInteger cursorOffset = [textField offsetFromPosition:beginning toPosition:start] + string.length;
//        
//        // Save the current text, in case iOS deletes the whole text
//        NSString *text = textField.text;
//        
//        // Trigger deletion
//        [textField deleteBackward];
//        
//        // iOS deleted the entire string
//        if (textField.text.length != text.length - 1)
//        {
//            textField.text = [text stringByReplacingCharactersInRange:range withString:string];
//            
//            // Update cursor position
//            UITextPosition *newCursorPosition = [textField positionFromPosition:textField.beginningOfDocument offset:cursorOffset];
//            UITextRange *newSelectedRange = [textField textRangeFromPosition:newCursorPosition toPosition:newCursorPosition];
//            [textField setSelectedTextRange:newSelectedRange];
//        }
//        return NO;
//    }
//    return YES;

    passwordString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    //判断text 是否输入过@ 如果输入过则不出现下啦菜单
    
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (textField == accountTextField) {
        
        //是否包含@
        
        if ([text containsString:@"@"]) {
            
            [self setShowList:YES];
            
            [tableViewData removeAllObjects];
            
            //范围
            NSRange range = [text rangeOfString:@"@"];
            
            if ((range.location + range.length) == text.length) {
                
                for (NSString *str in emailsArray) {
                    
                    [tableViewData addObject:[NSString stringWithFormat:@"%@%@",text,str]];
                }
            }else{
                
                NSString *suffix = [text substringWithRange:NSMakeRange(range.location+range.length, text.length-(range.location+range.length))];
                
                NSString *headText = [text substringWithRange:NSMakeRange(0,range.location+range.length)];
                
                for (NSString *str in emailsArray) {
                    
                    //匹配
                    
                    if ([str hasPrefix:suffix]) {
                        
                        
                        
                        [tableViewData addObject:[NSString stringWithFormat:@"%@%@",headText,str]];
                        
                        
                        
                    }
                    
                }
                
                if (tableViewData.count<=0) {
                    
                    [self setShowList:NO];
                    
                }
                
            }
            
            
            
            [listTableView reloadData];
            
        }else
            
        {
            
            [self setShowList:NO];
            
        }
        
    }
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"textFieldDidEndEditing ~~~");
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"textFieldDidBeginEditing ~~~");
}
- (void)buttonClick:(UIButton *)btn
{
    if(!isShowPsd)
    {
//        psdTextField.text = @"";
//        psdTextField.text = passwordString;

        [showButton setTitle:@"隐藏" forState:UIControlStateNormal];
        psdTextField.secureTextEntry = NO;
        isShowPsd = YES;
    }
    else
    {
//        psdTextField.text = passwordString;

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
    if([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if([tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    if([tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *selectedIndex = [tableView indexPathForSelectedRow];
    [tableView deselectRowAtIndexPath:selectedIndex animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
