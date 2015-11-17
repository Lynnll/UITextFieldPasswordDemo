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
    
    UIView *eyeBgView;
    
    UIImageView *eyeImageView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tableViewData = [NSMutableArray array];
    
    isShowList = NO;
    
    emailsArray = [NSArray arrayWithObjects:@"sohu.com",@"sina.com",@"163.com",@"126.com",@"qq.com", nil];
    
    self.view.backgroundColor = [UIColor colorWithRed:11 / 255.0f green:150 / 255.0f blue:243 / 255.0f alpha:1];
    
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
    listTableView.separatorColor = [UIColor whiteColor];
    listTableView.layer.borderColor = [UIColor colorWithRed:229 / 255.0f green:230 / 255.0f blue:234 / 255.0f alpha:1].CGColor;
    listTableView.layer.borderWidth = 0.5;
    [self.view addSubview:listTableView];
}
- (void)loadAccountTextField
{
    accountTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 64, self.view.frame.size.width - 20, 44)];
    accountTextField.layer.borderColor = [UIColor whiteColor].CGColor;
    accountTextField.font = [UIFont systemFontOfSize:14];
    accountTextField.tintColor = [UIColor whiteColor];
    accountTextField.textColor = [UIColor whiteColor];
    accountTextField.autocorrectionType = UITextAutocorrectionTypeNo;//关闭拼写检查
    accountTextField.keyboardType = UIKeyboardTypeEmailAddress;
    accountTextField.placeholder = @"请输入邮箱";
    [accountTextField setValue:[UIColor colorWithWhite:1 alpha:0.5] forKeyPath:@"_placeholderLabel.textColor"];
    accountTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;//首字母小写
    
    accountTextField.layer.borderWidth = 0.5;
    accountTextField.delegate = self;
    [accountTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    
    accountTextField.secureTextEntry = NO;
    
    UILabel *subAccountLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    subAccountLabel.text = @"账号";
    subAccountLabel.font = [UIFont systemFontOfSize:15];
    subAccountLabel.textColor = [UIColor whiteColor];
    subAccountLabel.textAlignment = NSTextAlignmentCenter;
    accountTextField.leftView = subAccountLabel;
    accountTextField.leftViewMode = UITextFieldViewModeAlways;
    accountTextField.tag = 100;
    
    [self.view addSubview:accountTextField];
}
- (void)loadPsdTextField
{
    UIView *psdBgView = [[UIView alloc]init];
    psdBgView.frame = CGRectMake(10, 118, self.view.frame.size.width - 20, 44);
    psdBgView.layer.borderColor = [UIColor whiteColor].CGColor;
    psdBgView.layer.borderWidth = 0.5;
    [self.view addSubview:psdBgView];
    
    psdTextField = [[DKTextField alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 20, 44)];
    psdTextField.secureTextEntry = YES;
    psdTextField.backgroundColor = [UIColor clearColor];
    psdTextField.textColor = [UIColor whiteColor];
    psdTextField.tintColor = [UIColor whiteColor];
    psdTextField.font = [UIFont systemFontOfSize:14];
    psdTextField.placeholder = @"请输入密码";
    [psdTextField setValue:[UIColor colorWithWhite:1 alpha:0.5] forKeyPath:@"_placeholderLabel.textColor"];
    [psdTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    psdTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;//首字母小写
    /**
     *  keyboardType 英文键盘
     *  autocorrectionType 关闭自动订正功能（在英文键盘下会自动订正为正确的单词）
     *  设置以上两项，保证明文输入密码时，只能输入字母且不能切换输入法
     */
    psdTextField.keyboardType = UIKeyboardTypeASCIICapable;
    psdTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    psdTextField.delegate = self;
    [psdBgView addSubview:psdTextField];
    
    UILabel *subPsdLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    subPsdLabel.text = @"密码";
    subPsdLabel.font = [UIFont systemFontOfSize:15];
    subPsdLabel.textColor = [UIColor whiteColor];
    subPsdLabel.textAlignment = NSTextAlignmentCenter;
    psdTextField.leftView = subPsdLabel;
    psdTextField.leftViewMode = UITextFieldViewModeAlways;
    psdTextField.tag = 101;
    
    eyeBgView = [[UIView alloc]init];
    eyeBgView.frame = CGRectMake(psdBgView.frame.size.width - 54, 0, 54, 44);
    eyeBgView.backgroundColor = [UIColor clearColor];
    eyeBgView.userInteractionEnabled = YES;
    eyeBgView.hidden = YES;
    UITapGestureRecognizer *eyeTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showOrHidePassword)];
    [eyeBgView addGestureRecognizer:eyeTapGesture];
    
    eyeImageView = [[UIImageView alloc]init];
    eyeImageView.frame = CGRectMake(0, -5, 44, 44);//图片不给力，位置没居中。凑合看吧。
    eyeImageView.image = [UIImage imageNamed:@"register_open_eye.png"];
    eyeImageView.backgroundColor = [UIColor clearColor];
    [eyeBgView addSubview:eyeImageView];
    
    [psdBgView addSubview:eyeBgView];
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
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField.tag == 101)
    {
        CGRect psdTextFiledFrame = psdTextField.frame;
        psdTextFiledFrame.size.width = (self.view.frame.size.width - 20 - 54);
        psdTextField.frame = psdTextFiledFrame;
        eyeBgView.hidden = NO;
    }
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if(textField.tag == 100)
    {
        [self setShowList:NO];
    }
    else if(textField.tag == 101)
    {
        CGRect psdTextFiledFrame = psdTextField.frame;
        psdTextFiledFrame.size.width = (self.view.frame.size.width - 50);
        psdTextField.frame = psdTextFiledFrame;
        
        eyeBgView.hidden = YES;
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
- (void)showOrHidePassword
{
    if(!isShowPsd)
    {
        [eyeImageView setImage:[UIImage imageNamed:@"register_open_eye.png"]];
        psdTextField.secureTextEntry = NO;
        isShowPsd = YES;
    }
    else
    {
        [eyeImageView setImage:[UIImage imageNamed:@"register_close_eye.png"]];
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
    cell.backgroundColor = [UIColor whiteColor];

    if(tableViewData != nil && tableViewData.count > 0)
    {
        cell.emailLabel.text = [tableViewData objectAtIndex:indexPath.row];
    }
    if([cell respondsToSelector:@selector(setLayoutMargins:)]){
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if([tableView respondsToSelector:@selector(setLayoutMargins:)]){
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    if([tableView respondsToSelector:@selector(setSeparatorInset:)]){
        [tableView setSeparatorInset:UIEdgeInsetsZero];
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
