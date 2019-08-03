//
//  LXBasekteDetCell.m
//  testDemo
//
//  Created by MCM on 2019/4/20.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import "LXBasekteDetCell.h"

@implementation LXBasekteDetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString *cellID = @"LXBasekteDetCell";
    LXBasekteDetCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LXBasekteDetCell" owner:self options:0] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}
- (void)setHomeModel:(NSArray *)homeModel{
    _homeModel = homeModel;
    for (int i = 0;  i<homeModel.count ; i++) {
        switch (i) {
            case 0:
                _oneLB.text = homeModel[i];
                break;
            case 1:
                _twoLB.text = homeModel[i];

                break;
            case 2:
                _threeLB.text = homeModel[i];

                break;
            case 3:
                _fourLB.text = homeModel[i];

                break;
            case 4:
                _fiveLB.text = homeModel[i];

                break;
            default:
                break;
        }
    }
}

@end
