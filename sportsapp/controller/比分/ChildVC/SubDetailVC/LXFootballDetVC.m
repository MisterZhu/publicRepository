//
//  LXFootballDetVC.m
//  testDemo
//
//  Created by MCM on 2019/4/20.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import "LXFootballDetVC.h"
#import "LXFootBallEventCell.h"
#import "LXFootBallDataCell.h"

@interface LXFootballDetVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) LXScoreDetHeadView *detailView;

@property (nonatomic, strong)MCScoreFootballModel *footModel;
@property (nonatomic, strong)MCScoreFoDaModel *footDataModel;
@property (nonatomic,assign) NSInteger currentIndex;

@end

@implementation LXFootballDetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentIndex = 0;
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
                           @"Opcode":self.Opcode,
                           @"UpProtocalType":[MethodFactory rb_jsonStrFromDic:@{@"pagetype":@(0),@"filter":@[],@"pagination":@{},@"orderby":@[],@"groupby":@[]}]
                           };
    [[ZLXNetWork shareNetWork] PosttRequest:kBaseUrl
                                 postParams:dict
                        requestSuccessBlock:^(id result) {
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [weakSelf.tableView.mj_header endRefreshing];

                                weakSelf.footModel = [MCScoreFootballModel modelWithJSON:result];
                                weakSelf.detailView.footModel =weakSelf.footModel.Result.rows.match;
                                [weakSelf.tableView reloadData];
                            });
                            
                        } requestFailedBlock:^(id error) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [weakSelf.tableView.mj_header endRefreshing];
                            });
                            
                        }];
}
- (void)requestData{
    WS(weakSelf);
    NSDictionary *dict = @{@"DownProtocalType":[MethodFactory rb_jsonStrFromDic:@{@"fields":@[@"*"]}],
                           @"RequireParameter":[MethodFactory rb_jsonStrFromDic:@{@"match_id":@(self.matchID)}],
                           @"Opcode":self.dataOpcode,
                           @"UpProtocalType":[MethodFactory rb_jsonStrFromDic:@{@"pagetype":@(0),@"filter":@[],@"pagination":@{},@"orderby":@[],@"groupby":@[]}]
                           };
    [[ZLXNetWork shareNetWork] PosttRequest:kBaseUrl
                                 postParams:dict
                        requestSuccessBlock:^(id result) {
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [weakSelf.tableView.mj_header endRefreshing];
                                
                                weakSelf.footDataModel = [MCScoreFoDaModel modelWithJSON:result];
                                //[weakSelf.tableView reloadData];
                            });
                            
                        } requestFailedBlock:^(id error) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [weakSelf.tableView.mj_header endRefreshing];
                            });
                            
                        }];
}
#pragma mark - 代理方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_currentIndex == 0) {
        return  self.footModel.Result.rows.events.count;
    }else{
        return  self.footDataModel.Result.rows.technics.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_currentIndex == 0) {
        return 60;
    }else{
        return 30;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_currentIndex == 0) {
        LXFootBallEventCell *cell = [LXFootBallEventCell cellForTableView:tableView];
        cell.model = self.footModel.Result.rows.events[indexPath.row];
        return cell;


    }else{
        LXFootBallDataCell *cell = [LXFootBallDataCell cellForTableView:tableView];
        cell.model = self.footDataModel.Result.rows.technics[indexPath.row];
        return cell;

    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 70;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self setHeaderViewWithSec:section];
}
- (UIView *)setHeaderViewWithSec:(NSInteger)section{
    
    FootBallMatch *match = self.footModel.Result.rows.match;

    UIView *view = [[UIView alloc] initWithFrame:aFrame(0, 0, KScreenWidth, 70)];
    
    UIView *oneBgView = [[UIView alloc] initWithFrame:aFrame(0, 0, KScreenWidth, 41)];
    oneBgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIView *twoBgView = [[UIView alloc] initWithFrame:aFrame(0, 41, KScreenWidth, 29)];
    
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    btnLeft.frame = aFrame(0, 0, KScreenWidth/2, 40);
    [btnLeft setTitle:@"比赛事件" forState:UIControlStateNormal];
    btnLeft.titleLabel.font = [UIFont fontWithName :@"Helvetica-Bold" size :14];
    btnLeft.tag = 0;
    [btnLeft addTarget:self action:@selector(clickHeaderVBtn:) forControlEvents:UIControlEventTouchUpInside];
    [oneBgView addSubview:btnLeft];
    
    UIButton *btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRight.frame = aFrame(KScreenWidth/2, 0, KScreenWidth/2, 40);
    [btnRight setTitle:@"比赛数据" forState:UIControlStateNormal];
    btnRight.titleLabel.font = [UIFont fontWithName :@"Helvetica-Bold" size :14];

    btnRight.tag = 1;
    [btnRight addTarget:self action:@selector(clickHeaderVBtn:) forControlEvents:UIControlEventTouchUpInside];
    [oneBgView addSubview:btnRight];

    if (_currentIndex == 0) {
        btnLeft.backgroundColor = [UIColor whiteColor];
        [btnLeft setTitleColor:UIColorFromRGB(kColorDark, 1.0) forState:UIControlStateNormal];
        
        btnRight.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [btnRight setTitleColor:UIColorFromRGB(kColorDark, 0.5) forState:UIControlStateNormal];

        MCLabel *homeTitle = [[MCLabel alloc] initWithFrame:aFrame(20, 0, KScreenWidth/2-20, 29)
                                                       text:match.home
                                                  textColor:kColorDark
                                                   fontSize:14];
        homeTitle.textAlignment = NSTextAlignmentLeft;
        [twoBgView addSubview:homeTitle];
        
        MCLabel *awayTitle = [[MCLabel alloc] initWithFrame:aFrame(KScreenWidth/2, 0, KScreenWidth/2-20, 29)
                                                       text:match.away
                                                  textColor:kColorDark
                                                   fontSize:14];
        awayTitle.textAlignment = NSTextAlignmentRight;
        [twoBgView addSubview:awayTitle];
        twoBgView.backgroundColor = UIColorFromRGB(kColorWhite, 1.0);

        UIView *lineV = [[UIView alloc] initWithFrame:aFrame(0, 28, KScreenWidth, 1)];
        lineV.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [twoBgView addSubview:lineV];
        
    }else{
        btnLeft.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [btnLeft setTitleColor:UIColorFromRGB(kColorDark, 0.5) forState:UIControlStateNormal];

        btnRight.backgroundColor = [UIColor whiteColor];
        [btnRight setTitleColor:UIColorFromRGB(kColorDark, 1.0) forState:UIControlStateNormal];

        MCLabel *homeTitle = [[MCLabel alloc] initWithFrame:aFrame(20, 0, KScreenWidth/2-20, 29)
                                                       text:@"赛事技术统计"
                                                  textColor:kColorWhite
                                                   fontSize:14];
        homeTitle.textAlignment = NSTextAlignmentLeft;
        [twoBgView addSubview:homeTitle];
        twoBgView.backgroundColor = UIColorFromRGB(kColorRead, 1.0);
    }
    
    [view addSubview:oneBgView];
    [view addSubview:twoBgView];
    
    return view;
}
- (void)clickHeaderVBtn:(UIButton *)segmt {
    int index = (int)segmt.tag;
    NSLog(@"segmtAction index = %d",index);
    _currentIndex = index;
    [self.tableView reloadData];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
