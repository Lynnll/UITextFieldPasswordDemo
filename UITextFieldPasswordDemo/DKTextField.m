//
//  DKTextField.m
//  DKTextField
//
//  Created by 张奥 on 14-10-31.
//  Copyright (c) 2014年 DKHS. All rights reserved.
//

#import "DKTextField.h"

@interface DKTextField ()
@property (nonatomic, copy) NSString *password;
//@property (nonatomic, weak) id beginEditingObserver;
//@property (nonatomic, weak) id endEditingObserver;
@end

@implementation DKTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self awakeFromNib];
        self.password = @"";
        [self resigterNotification];
    }
    return self;
}
- (void)resigterNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidBeginEditing) name:UITextFieldTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidEndEditing) name:UITextFieldTextDidEndEditingNotification object:self];
}
- (void)textFieldDidBeginEditing
{
    if(self.secureTextEntry)
    {
        self.text = @"";
        
        [self insertText:self.password];
    }
}
- (void)textFieldDidEndEditing
{
    self.password = self.text;
}
- (void)setSecureTextEntry:(BOOL)secureTextEntry
{
    BOOL isFirstResponder = self.isFirstResponder;
    [self resignFirstResponder];
    [super setSecureTextEntry:secureTextEntry];
    if (isFirstResponder) {
        [self becomeFirstResponder];
    }
}
- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self.beginEditingObserver];
//    [[NSNotificationCenter defaultCenter] removeObserver:self.endEditingObserver];
    [[NSNotificationCenter defaultCenter] removeObserver:UITextFieldTextDidBeginEditingNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:UITextFieldTextDidEndEditingNotification];
}
//-(void)awakeFromNib
//{
//    [super awakeFromNib];
//    self.password = @"";
//    
//    __weak DKTextField *weakSelf = self;
//    
//    self.beginEditingObserver = [[NSNotificationCenter defaultCenter] addObserverForName:UITextFieldTextDidBeginEditingNotification
//                                                                                  object:nil queue:nil usingBlock:^(NSNotification *notify) {
//                                                                                      if (weakSelf == notify.object && weakSelf.isSecureTextEntry) {
//                                                                                          NSLog(@"did begin editing weakSelf.password = %@",weakSelf.password);
//                                                                                          
//                                                                                          weakSelf.text = @"";
//                                                                                          [weakSelf insertText:weakSelf.password];
//                                                                                      }
//                                                                                  }];
//    self.endEditingObserver = [[NSNotificationCenter defaultCenter] addObserverForName:UITextFieldTextDidEndEditingNotification
//                                                                                object:nil queue:nil usingBlock:^(NSNotification *notify) {
//                                                                                    if (weakSelf == notify.object) {
//                                                                                        
//                                                                                        NSLog(@"did end editing weakSelf.text = %@",weakSelf.text);
//                                                                                        weakSelf.password = weakSelf.text;
//                                                                                    }
//                                                                                }];
//}
@end
