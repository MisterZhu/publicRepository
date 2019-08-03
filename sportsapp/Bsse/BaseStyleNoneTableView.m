//
//  BaseStyleNoneTableView.m
//  WatermelonEsports
//
//  Created by MCM on 2018/12/21.
//  Copyright © 2018年 xiguadianjing. All rights reserved.
//

#import "BaseStyleNoneTableView.h"
#import "UITableView+iOS11.h"

@implementation BaseStyleNoneTableView

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.showsVerticalScrollIndicator = NO;
        [self adapterIOS11WithTableView];
    }
    return self;
    
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.showsVerticalScrollIndicator = NO;
        [self adapterIOS11WithTableView];
        
    }
    return self;
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    id view = [super hitTest:point withEvent:event];
    if (![view isKindOfClass:[UITextView class]]) {
        [self.superview endEditing:YES];
        [self endEditing:YES];
    }
    return view;
}

@end
