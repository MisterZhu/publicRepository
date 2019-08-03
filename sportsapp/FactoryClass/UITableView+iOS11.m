//
//  UITableView+iOS11.m
//  AYR
//
//  Created by Mr.c on 2018/9/6.
//  Copyright © 2018年 喵哥&. All rights reserved.
//

#import "UITableView+iOS11.h"

@implementation UITableView (iOS11)

- (void)adapterIOS11WithTableView{
    
    if (@available(iOS 11.0, *)){
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

@end
