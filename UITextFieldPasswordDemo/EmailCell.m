//
//  EmailCell.m
//  UITextFieldPasswordDemo
//
//  Created by lynnjinglei on 15/9/6.
//  Copyright (c) 2015年 XiaoLei. All rights reserved.
//

#import "EmailCell.h"

@implementation EmailCell

@synthesize emailLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect frame = [UIScreen mainScreen].bounds;
        emailLabel = [[UILabel alloc]init];
        emailLabel.font = [UIFont systemFontOfSize:14];
        emailLabel.frame = CGRectMake(44, 0, frame.size.width - 44, 36);
//        emailLabel.textColor = [UIColor colorWithRed:255 / 255.0f green:227 / 255.0f blue:249 / 255.0f alpha:1];
        emailLabel.textColor = [UIColor colorWithRed:150 / 255.0f green:150 / 255.0f blue:150 / 255.0f alpha:1];
        [self addSubview:emailLabel];
        
//        [self awakeFromNib];
    }
    return self;
}
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    
//    NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
}
@end
