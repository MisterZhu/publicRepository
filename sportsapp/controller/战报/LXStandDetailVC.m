//
//  LXStandDetailVC.m
//  testDemo
//
//  Created by WEI ZOU on 2019/4/22.
//  Copyright © 2019 xiguadianjing. All rights reserved.
//

#import "LXStandDetailVC.h"

#import "LXStandLineRateCell.h"
#import "LXStandCircleRateCell.h"
#import "LXStandTitleCell.h"

@interface LXStandDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) LXScoreDetHeadView *detailView;

@property (nonatomic, strong)MCStandComplexModel *complexModel;
@property (nonatomic, strong)MCStandRecordModel *recordModel;

@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,assign) NSInteger oneIndex;
@property (nonatomic,assign) NSInteger twoIndex;
@property (nonatomic,assign) NSInteger threeIndex;

@property (nonatomic,assign) NSInteger rightOneIndex;

@property (nonatomic, strong)NSString *homeName;
@property (nonatomic, strong)NSString *awayName;


@end

@implementation LXStandDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentIndex = 0;
    _oneIndex = 0;
    _twoIndex = 0;
    _threeIndex = 0;
    _rightOneIndex = 0;

    self.titleStr = self.title;
    [self setupUI];
    [self requestEvent];
    [self requestData];
}
- (void)setupUI{
    
    [super setupUI];
    
    self.tableView.frame = aFrame(0, Height_NavBar, KScreenWidth, KScreenHeight - Height_NavBar );
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    [self setTopView];
    
}
- (void)setTopView{
    if (!self.detailView) {
        self.detailView = [[LXScoreDetHeadView alloc] init];
    }
    //self.detailView.GoodsDelegate = self;
    self.detailView.frame = CGRectMake(0, 0, KScreenWidth, 150);
    self.tableView.tableHeaderView = self.detailView;
}

#pragma mark - 数据请求  requestData

- (void)requestEvent{
    WS(weakSelf);
    NSDictionary *dict = @{@"DownProtocalType":[MethodFactory rb_jsonStrFromDic:@{@"fields":@[@"*"]}],
                           @"RequireParameter":[MethodFactory rb_jsonStrFromDic:@{@"match_id":@(self.matchID)}],
                           @"Opcode":self.complexOpcode,
                           @"UpProtocalType":[MethodFactory rb_jsonStrFromDic:@{@"pagetype":@(0),@"filter":@[],@"pagination":@{},@"orderby":@[],@"groupby":@[]}]
                           };
    [[ZLXNetWork shareNetWork] PosttRequest:kBaseUrl
                                 postParams:dict
                        requestSuccessBlock:^(id result) {
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
//                                [weakSelf.tableView.mj_header endRefreshing];
                                
                                weakSelf.complexModel = [MCStandComplexModel modelWithJSON:result];
                                weakSelf.detailView.complexModel =weakSelf.complexModel.Result.rows.match;
                                weakSelf.homeName = weakSelf.complexModel.Result.rows.match.home;
                                weakSelf.awayName = weakSelf.complexModel.Result.rows.match.away;
                                weakSelf.titleStr = weakSelf.complexModel.Result.rows.match.league;

                                [weakSelf.tableView reloadData];
                            });
                            
                        } requestFailedBlock:^(id error) {
                            dispatch_async(dispatch_get_main_queue(), ^{
//                                [weakSelf.tableView.mj_header endRefreshing];
                            });
                            
                        }];
}
- (void)requestData{
    WS(weakSelf);
    NSDictionary *dict = @{@"DownProtocalType":[MethodFactory rb_jsonStrFromDic:@{@"fields":@[@"*"]}],
                           @"RequireParameter":[MethodFactory rb_jsonStrFromDic:@{@"match_id":@(self.matchID)}],
                           @"Opcode":self.recordOpcode,
                           @"UpProtocalType":[MethodFactory rb_jsonStrFromDic:@{@"pagetype":@(0),@"filter":@[],@"pagination":@{},@"orderby":@[],@"groupby":@[]}]
                           };
    [[ZLXNetWork shareNetWork] PosttRequest:kBaseUrl
                                 postParams:dict
                        requestSuccessBlock:^(id result) {
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                weakSelf.recordModel = [MCStandRecordModel modelWithJSON:result];
                                [weakSelf.tableView reloadData];
                            });
                            
                        } requestFailedBlock:^(id error) {
                            dispatch_async(dispatch_get_main_queue(), ^{
//                                [weakSelf.tableView.mj_header endRefreshing];
                            });
                            
                        }];
}
#pragma mark - 代理方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_currentIndex == 0) {
        return 4;
    }else{
        return 2;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_currentIndex == 0) {
        if (section == 0) {
            return  0;
        }else if (section == 1){
            return 2;
        }else if (section == 2){
            return 1;
        }else if (section == 3){
            if (_threeIndex == 0) {
                return self.complexModel.Result.rows.home_future.count-1;
            }else{
                return self.complexModel.Result.rows.away_future.count-1;
            }
        }else{
            return 0;
        }
    }else{
        if (section == 0) {
            return  0;
        }else{
            if (_rightOneIndex == 0) {
                return self.recordModel.Result.rows.home_recent.count;
            }else{
                return self.recordModel.Result.rows.away_recent.count;
            }
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_currentIndex == 0) {
        if (indexPath.section == 0) {
            return 20;
        }else if (indexPath.section == 1){
            return 65;
        }else if (indexPath.section == 2){
            return 170;
        }else if (indexPath.section == 3){
            return 30;
        }else{
            return 30;
        }
    }else{
        return 30;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_currentIndex == 0) {
        if (indexPath.section ==1) {
            
            LXStandLineRateCell *cell = [LXStandLineRateCell cellForTableView:tableView];
            if (_oneIndex == 0) {
                cell.isLeft = YES;
                if (indexPath.row == 0) {
                    cell.homeModel = self.complexModel.Result.rows.odd.home;
                    cell.name = self.homeName;
                }else{
                    cell.awayModel = self.complexModel.Result.rows.odd.away;
                    cell.name = self.awayName;
                }
            }else{
                cell.isLeft = NO;
                if (indexPath.row == 0) {
                    cell.homeModel = self.complexModel.Result.rows.odd.home;
                    cell.name = self.homeName;
                }else{
                    cell.awayModel = self.complexModel.Result.rows.odd.away;
                    cell.name = self.awayName;
                }
            }
            return cell;
            
        }else if (indexPath.section ==2){
            if (_twoIndex == 0) {
                LXStandCircleRateCell *cell = [LXStandCircleRateCell cellForTableView:tableView];
                cell.hisModel = self.complexModel.Result.rows.his_handicap;
                cell.name = self.homeName;

                return cell;
            }else{
                LXStandCircleRateCell *cell = [LXStandCircleRateCell cellForTableView:tableView];
                cell.hisSameModel = self.complexModel.Result.rows.his_same_handicap;
                cell.name = self.homeName;

                return cell;
            }
            
        }else{
            LXStandTitleCell *cell = [LXStandTitleCell cellForTableView:tableView];
            if (_threeIndex == 1) {
                cell.titleAry = self.complexModel.Result.rows.home_future[indexPath.row+1];
            }else{
                cell.titleAry = self.complexModel.Result.rows.away_future[indexPath.row+1];
            }
            return cell;
        }
        
    }else{
        LXStandTitleCell *cell = [LXStandTitleCell cellForTableView:tableView];
        if (_rightOneIndex == 0) {
            cell.recordAry = self.recordModel.Result.rows.home_recent[indexPath.row];
        }else{
            cell.recordAry = self.recordModel.Result.rows.away_recent[indexPath.row];
        }
        return cell;
        
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_currentIndex == 0) {
        if (section == 0) {
            return 40;
        }else{
            if (section == 3) {
                return 60;
            }else{
                return 30;
            }
        }
    }else{
        if (section == 0) {
            return 40;
        }else{
            return 90;
        }
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self setHeaderViewWithSec:section];
}

#pragma mark - 定制header view
- (UIView *)setHeaderViewWithSec:(NSInteger)section{
    if (section == 0) {
        return [self setHeaderViewTypeOne];
    }else{
        return [self setHeaderViewTypeTwoWith:section];
    }
}
- (UIView *)setHeaderViewTypeOne{
    UIView *view = [[UIView alloc] initWithFrame:aFrame(0, 0, KScreenWidth, 41)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    btnLeft.frame = aFrame(0, 0, KScreenWidth/2, 40);
    [btnLeft setTitle:@"综合" forState:UIControlStateNormal];
    btnLeft.titleLabel.font = [UIFont fontWithName :@"Helvetica-Bold" size :14];
    btnLeft.tag = 0;
    [btnLeft addTarget:self action:@selector(clickHeaderVBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnLeft];
    
    UIButton *btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRight.frame = aFrame(KScreenWidth/2, 0, KScreenWidth/2, 40);
    [btnRight setTitle:@"战绩" forState:UIControlStateNormal];
    btnRight.titleLabel.font = [UIFont fontWithName :@"Helvetica-Bold" size :14];
    
    btnRight.tag = 1;
    [btnRight addTarget:self action:@selector(clickHeaderVBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnRight];
    
    if (_currentIndex == 0) {
        btnLeft.backgroundColor = [UIColor whiteColor];
        [btnLeft setTitleColor:UIColorFromRGB(kColorDark, 1.0) forState:UIControlStateNormal];
        
        btnRight.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [btnRight setTitleColor:UIColorFromRGB(kColorDark, 0.5) forState:UIControlStateNormal];
    }else{
        btnLeft.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [btnLeft setTitleColor:UIColorFromRGB(kColorDark, 0.5) forState:UIControlStateNormal];
        
        btnRight.backgroundColor = [UIColor whiteColor];
        [btnRight setTitleColor:UIColorFromRGB(kColorDark, 1.0) forState:UIControlStateNormal];
    }
    return view;
}
- (UIView *)setHeaderViewTypeTwoWith:(NSInteger )section{
    if (_currentIndex == 0) {
        return [self setComplexHeaderWith:section];
    }else{
        return [self setRecordHeaderWith:section];
    }
    
}
- (UIView *)setComplexHeaderWith:(NSInteger )section{
    
    UIView *oneBgView = [[UIView alloc] initWithFrame:aFrame(0, 0, KScreenWidth, 30)];
    oneBgView.backgroundColor = FrameColor;
    
    MCLabel *titleLB = [[MCLabel alloc] initWithFrame:aFrame(15, 0, 150, 30)
                                                 text:@""
                                            textColor:kColorWhite
                                             fontSize:14];
    titleLB.textAlignment = NSTextAlignmentLeft;
    titleLB.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    NSArray *titleAry = [[NSArray alloc] init];
    if (section ==1) {
        titleAry = @[@"盘路",@"胜平负"];
        titleLB.text = @"近期战报";
    }else if (section ==2){
        titleAry = @[@"全部",@"主客相同"];
        titleLB.text = @"历史交锋";

    }else if (section ==3){
        titleAry = @[@"主场",@"客场"];
        titleLB.text = @"未来赛事";

        oneBgView.frame = aFrame(0, 0, KScreenWidth, 60);
        UIView *threeBgView = [[UIView alloc] initWithFrame:aFrame(0, 30, KScreenWidth, 30)];
        threeBgView.backgroundColor = UIColorFromRGB(kTabHeaderBGColor, 1.0);
        
        NSArray *titlesAry = @[@"时间",@"事件",@"赛事对阵",@"相隔"];

        for (int i = 0; i<titlesAry.count; i++) {
            MCLabel *titLB = [[MCLabel alloc] initWithFrame:aFrame(i*(KScreenWidth/4.5), 0, KScreenWidth/4.5, 30)
                                                       text:titlesAry[i]
                                                  textColor:kColorDark
                                                   fontSize:12];
            if (i == 2) {
                titLB.frame = aFrame(KScreenWidth*2/4.5, 0, KScreenWidth*1.5/4.5, 30);
            }else if (i == 3){
                titLB.frame = aFrame(KScreenWidth*3.5/4.5, 0, KScreenWidth/4.5, 30);
            }
            [titLB setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:12]];
            titLB.textAlignment = NSTextAlignmentCenter;
            [threeBgView addSubview:titLB];
        }
        [oneBgView addSubview:threeBgView];

    }
    UISegmentedControl *segmt = [[UISegmentedControl alloc] initWithItems:titleAry];
    segmt.frame = aFrame(KScreenWidth/2-65, 3, 130, 24);
    [segmt setTintColor:[UIColor whiteColor]];
    [segmt setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(kColorWhite, 1.0),NSFontAttributeName:FrameThreeFont} forState:UIControlStateNormal];
    [segmt setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(kColorRead, 1.0),NSFontAttributeName:FrameThreeFont} forState:UIControlStateSelected];
    
    [segmt addTarget:self action:@selector(complexSegmtAction:) forControlEvents:UIControlEventValueChanged];
    if (section ==1) {
        segmt.selectedSegmentIndex = _oneIndex;
    }else if (section ==2){
        segmt.selectedSegmentIndex = _twoIndex;
    }else if (section ==3){
        segmt.selectedSegmentIndex = _threeIndex;
    }
    segmt.tag = section;
    [oneBgView addSubview:titleLB];
    [oneBgView addSubview:segmt];
    
    return oneBgView;
}
- (void)complexSegmtAction:(UISegmentedControl *)segmt {
    int index = (int)segmt.selectedSegmentIndex;
    NSLog(@"segmtAction index = %d",index);
    if (segmt.tag == 1) {
        _oneIndex = index;
    }else if (segmt.tag ==2){
        _twoIndex = index;
    }else if (segmt.tag == 3){
        _threeIndex = index;
    }
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:segmt.tag];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (UIView *)setRecordHeaderWith:(NSInteger )section{
    UIView *view = [[UIView alloc] initWithFrame:aFrame(0, 0, KScreenWidth, 90)];
    
    UIView *oneBgView = [[UIView alloc] initWithFrame:aFrame(0, 0, KScreenWidth, 30)];
    oneBgView.backgroundColor = FrameColor;
    
    UIView *twoBgView = [[UIView alloc] initWithFrame:aFrame(0, 30, KScreenWidth, 30)];
    twoBgView.backgroundColor = UIColorFromRGB(kColorWhite, 1.0);
    
    UIView *threeBgView = [[UIView alloc] initWithFrame:aFrame(0, 60, KScreenWidth, 30)];
    threeBgView.backgroundColor = UIColorFromRGB(kTabHeaderBGColor, 1.0);
    
    
    MCLabel *titleLB = [[MCLabel alloc] initWithFrame:aFrame(15, 0, 150, 30)
                                                 text:@"近期战绩"
                                            textColor:kColorWhite
                                             fontSize:14];
    titleLB.textAlignment = NSTextAlignmentLeft;
    titleLB.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    UISegmentedControl *segmt = [[UISegmentedControl alloc] initWithItems:@[@"主场",@"客场"]];
    segmt.frame = aFrame(KScreenWidth/2-45, 3, 90, 24);
    [segmt setTintColor:[UIColor whiteColor]];
    [segmt setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(kColorWhite, 1.0),NSFontAttributeName:FrameThreeFont} forState:UIControlStateNormal];
    [segmt setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(kColorRead, 1.0),NSFontAttributeName:FrameThreeFont} forState:UIControlStateSelected];
    segmt.selectedSegmentIndex = _rightOneIndex;
    segmt.tag = section;
    
    [segmt addTarget:self action:@selector(recordSegmtAction:) forControlEvents:UIControlEventValueChanged];
    
    [oneBgView addSubview:titleLB];
    [oneBgView addSubview:segmt];
    
    
    NSString *teamName = @"";
    
    if (_rightOneIndex == 0) {
        teamName = self.homeName;
    }else{
        teamName = self.awayName;
    }
    MCLabel *nameLB = [[MCLabel alloc] initWithFrame:aFrame(15, 0, 150, 30)
                                                text:teamName
                                           textColor:kColorDark
                                            fontSize:14];
    nameLB.textAlignment = NSTextAlignmentLeft;
    [twoBgView addSubview:nameLB];
    
    NSArray *titleAry = @[@"时间",@"事件",@"赛事对阵",@"盘路"];
    for (int i = 0; i<titleAry.count; i++) {
        MCLabel *titLB = [[MCLabel alloc] initWithFrame:aFrame(i*(KScreenWidth/4.5), 0, KScreenWidth/4.5, 30)
                                                   text:titleAry[i]
                                              textColor:kColorDark
                                               fontSize:12];
        if (i == 2) {
            titLB.frame = aFrame(KScreenWidth*2/4.5, 0, KScreenWidth*1.5/4.5, 30);
        }else if (i == 3){
            titLB.frame = aFrame(KScreenWidth*3.5/4.5, 0, KScreenWidth/4.5, 30);
        }
        [titLB setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:12]];
        titLB.textAlignment = NSTextAlignmentCenter;
        [threeBgView addSubview:titLB];
    }
    
    [view addSubview:oneBgView];
    [view addSubview:twoBgView];

    [view addSubview:threeBgView];
    
    return view;
}
- (void)clickHeaderVBtn:(UIButton *)segmt {
    int index = (int)segmt.tag;
    NSLog(@"clickHeaderVBtn index = %d",index);
    _currentIndex = index;
    [self.tableView reloadData];
    
}
- (void)recordSegmtAction:(UISegmentedControl *)segmt {
    int index = (int)segmt.selectedSegmentIndex;
    NSLog(@"segmtAction index = %d",index);
    _rightOneIndex = index;
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:1];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}
@end
