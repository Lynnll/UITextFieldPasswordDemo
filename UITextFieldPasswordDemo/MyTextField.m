//
//  MyTextField.m
//  UITextFieldPasswordDemo
//
//  Created by lynnjinglei on 15/9/6.
//  Copyright (c) 2015年 XiaoLei. All rights reserved.
//

#import "MyTextField.h"

@implementation MyTextField
-(CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectMake(10, 0, bounds.size.width-10, bounds.size.height);
}

-(CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectMake(10, 0, bounds.size.width-10, bounds.size.height);
}

-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    return CGRectMake(10, 0, bounds.size.width-10, bounds.size.height);
}
@end
