//
//  SubTableView.m
//  NestedTable
//
//  Created by LOLITA on 2017/9/19.
//  Copyright © 2017年 LOLITA0164. All rights reserved.
//

#import "SubTableView.h"

@implementation SubTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.table.frame = self.bounds;
        [self addSubview:self.table];
    }
    return self;
}


-(LolitaTableView *)table{
    if (_table==nil) {
        _table = [[LolitaTableView alloc] initWithFrame:CGRectZero];
        _table.delegate = self;
        _table.dataSource = self;
        _table.showsVerticalScrollIndicator = NO;
//        _table.tableFooterView = [UIView new];
        _table.type = LolitaTableViewTypeSub;
        //_table.delegate_StayPosition = self;
        _isFirstLoad = YES;

    }
    return _table;
}
- (UIView *)setHeaderView{
    UIView *headerView = [[UIView alloc] initWithFrame:aFrame(0, 0, screenWidth, 44)];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    headerView.userInteractionEnabled = YES;

    self.backView = [[UIView alloc] initWithFrame:aFrame(0, 0, screenWidth, 43)];
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.userInteractionEnabled = YES;
    [headerView addSubview:self.backView];
    
//    _packageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_packageBtn setTitleColor:FrameRedBGColor forState:UIControlStateSelected];
//    [_packageBtn setTitleColor:Color333333 forState:UIControlStateNormal];
//    _packageBtn.frame = aFrame(0, 0, screenWidth/4, 40);
//    [_packageBtn setTitle:@"套餐" forState:UIControlStateNormal];
//    _packageBtn.titleLabel.font =Font14;
//    _packageBtn.selected = NO;
//    [self.backView addSubview:_packageBtn];
    
    _detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_detailBtn setTitleColor:FrameRedBGColor forState:UIControlStateSelected];
    [_detailBtn setTitleColor:Color333333 forState:UIControlStateNormal];
    _detailBtn.frame = aFrame(0, 0, screenWidth/3, 40);
    [_detailBtn setTitle:@"详情" forState:UIControlStateNormal];
    _detailBtn.titleLabel.font =Font14;
    _detailBtn.selected = NO;
    _detailBtn.tag = 0;
    [_detailBtn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:_detailBtn];
    
    _tripBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_tripBtn setTitleColor:FrameRedBGColor forState:UIControlStateSelected];
    [_tripBtn setTitleColor:Color333333 forState:UIControlStateNormal];
    _tripBtn.frame = aFrame(screenWidth/3, 0, screenWidth/3, 40);
    [_tripBtn setTitle:@"行程" forState:UIControlStateNormal];
    _tripBtn.selected = NO;
    _tripBtn.titleLabel.font =Font14;
    _tripBtn.tag = 1;
    [_tripBtn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];

    [self.backView addSubview:_tripBtn];
    
    _costBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_costBtn setTitleColor:FrameRedBGColor forState:UIControlStateSelected];
    [_costBtn setTitleColor:Color333333 forState:UIControlStateNormal];
    _costBtn.frame = aFrame(screenWidth*2/3, 0, screenWidth/3, 40);
    [_costBtn setTitle:@"费用须知" forState:UIControlStateNormal];
    _costBtn.selected = NO;
    _costBtn.tag = 2;
    [_costBtn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];

    _costBtn.titleLabel.font =Font14;
    [self.backView addSubview:_costBtn];
    
    _lineView = [[UIView alloc] init];
    [self.backView addSubview:_lineView];
    _lineView.backgroundColor = FrameRedBGColor;
    _lineView.frame = aFrame(0, 0, screenWidth/6, 2);
    
    self.centerX = screenWidth/6+screenWidth/3*_currentSection;

    _lineView.center = CGPointMake(self.centerX, 42);
    if (0 == _currentSection) {
        //_packageBtn.selected = YES;
        _detailBtn.selected = YES;
    }else if (1 == _currentSection){
        _tripBtn.selected = YES;
    }else if (2 == _currentSection){
        _costBtn.selected = YES;
    }
    //NSLog(@"----222_currentSection = %ld",_currentSection);
    
    /*延迟执行时间0.5秒*/
    __weak typeof(self) weakSelf = self;

    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        weakSelf.isClick = NO;
    });

    return headerView;
    
}
- (void)clickBtnAction:(UIButton *)sender{
    
    if (_currentSection != sender.tag) {
        
        if (_currentSection == 0) {
            if (self.SubTableDelegate && [self.SubTableDelegate respondsToSelector:@selector(clickheadViewSection:withCell:)]) {
                [self.SubTableDelegate clickheadViewSection:0 withCell:0];
            }
        }
        NSLog(@"----sender,tag = %ld",sender.tag);
        NSIndexPath * dayOne = [NSIndexPath indexPathForRow:0 inSection:sender.tag];
        [_table selectRowAtIndexPath:dayOne animated:YES scrollPosition:UITableViewScrollPositionTop];
        
        _isClick = YES;
        _currentSection = sender.tag;
        [self addSubview:[self setHeaderView]];
    }

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld组 第%ld个",indexPath.section,indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 44;
    }else{
        return 44;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return [self setHeaderView];
    }else{
        UILabel *headerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
        headerView.text = [NSString stringWithFormat:@"我是标题栏 = %ld ",section];
        headerView.textAlignment = NSTextAlignmentCenter;
        headerView.backgroundColor = [UIColor yellowColor];
        return headerView;
    }
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(nonnull UIView *)view forSection:(NSInteger)section{
    
    if (!_isClick) {
        if (!_isUpScroll && (_currentSection - section) == 1) {
            _currentSection = section;
            
            NSLog(@"------111111111111 section = %ld组",section);
            NSLog(@"------111111111111 显示第%ld组",_currentSection);
            if (section == 0) {
                [self addSubview:[self setHeaderView]];
            }else if (section == 1){
                [self addSubview:[self setHeaderView]];
            }else if (section == 2){
                [self addSubview:[self setHeaderView]];
            }
        }
    }
    
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section{
    
    if (!_isClick) {
        if (_isUpScroll) {
            _currentSection = section + 1;
            NSLog(@"------99999999999 section = %ld组",section);
            NSLog(@"------99999999999 显示第%ld组",_currentSection);
            
            if (section == 0) {
                [self addSubview:[self setHeaderView]];
            }else if (section == 1){
                [self addSubview:[self setHeaderView]];
            }else if (section == 2){
                [self addSubview:[self setHeaderView]];
            }
        }
    }
   
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    static CGFloat lastY = 0.000000;
    
    if ([scrollView isEqual: self.table]) {
        
        if (self.table.contentOffset.y > lastY) {
            // 上滑
           //NSLog(@"上滑");
            _isUpScroll = YES;
        } else{
            // 下滑
            //NSLog(@"下滑");
            _isUpScroll = NO;
        }
        lastY = self.table.contentOffset.y;
        _isFirstLoad = NO;
    }
}
//
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//
//    // 获取开始拖拽时tableview偏移量
//
//    _oldY = self.table.contentOffset.y;
//
//    NSLog(@"_oldY = %lf",_oldY);
//
//}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    //_table.contentSize = CGSizeMake(screenWidth,screenHeight);
//}
// !!!: 悬停的位置
//-(CGFloat)lolitaTableViewHeightForStayPosition:(LolitaTableView *)tableView{
//    return [tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]].origin.y;
//}


@end
