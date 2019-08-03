//
//  MCRigImageView.m
//  QuFuTong
//
//  Created by 颜廷洋 on 2018/11/21.
//  Copyright © 2018 quFuTong. All rights reserved.
//

#import "MCRigImageView.h"

@implementation MCRigImageView

- (id)initWithFrame:(CGRect)frame imgName:(NSString *)name{
    if(self = [super init]){
        self.frame = frame;
        self.image = [UIImage imageNamed:name];
    }
    return self;
}

@end
