//
//  LXBasekteBallDetVC.m
//  testDemo
//
//  Created by MCM on 2019/4/20.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import "LXBasekteBallDetVC.h"
#import "LXBasekteDetCell.h"

@interface LXBasekteBallDetVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) LXScoreDetHeadView *detailView;
@property (nonatomic, strong)MCBasektDetModel *model;
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic, strong) NSMutableArray *homeAnalyAry;
@property (nonatomic, strong) NSMutableArray *awayAnalyAry;

@end

@implementation LXBasekteBallDetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _homeAnalyAry = [NSMutableArray array];
    _awayAnalyAry = [NSMutableArray array];
    
    _currentIndex = 0;
    // Do any additional setup after loading the view.
    [self setupUI];
    [self requestData];

}
- (void)setupUI{
    
    [super setupUI];
    
    self.tableView.frame = aFrame(0, Height_NavBar, KScreenWidth, KScreenHeight - Height_NavBar );
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
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
    //self.detailView.model = self.topModel;
}
#pragma mark - 数据请求  requestData

- (void)requestData{
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
                                weakSelf.model = [MCBasektDetModel modelWithJSON:result];
                                weakSelf.detailView.model = weakSelf.model.Result.rows.match;
                                
                                NSDictionary *homeAnaly = self.model.Result.rows.home_analyze;
                                NSDictionary *awayAnaly = self.model.Result.rows.away_analyze;

                                NSArray *keyArr = [homeAnaly allKeys];
                                NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:[keyArr sortedArrayUsingSelector:@selector(compare:)]];
                                for (int i =0; i<mutableArray.count; i++) {
                                    NSString *key = mutableArray[i];
                                    NSArray *dictArr = homeAnaly[key];
                                    [weakSelf.homeAnalyAry addObject:dictArr];
                                }
                                
                                NSArray *awaykeyArr = [awayAnaly allKeys];
                                NSMutableArray *mutaArray = [NSMutableArray arrayWithArray:[awaykeyArr sortedArrayUsingSelector:@selector(compare:)]];

                                for (int i =0; i<mutaArray.count; i++) {
                                    NSString *key = mutaArray[i];
                                    NSArray *dictArr = awayAnaly[key];
                                    [weakSelf.awayAnalyAry addObject:dictArr];
                                }
                                
                                [weakSelf.tableView.mj_header endRefreshing];
                                [weakSelf.tableView reloadData];
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
        return  _homeAnalyAry.count;
    }else{
        return  _awayAnalyAry.count;

    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LXBasekteDetCell *cell = [LXBasekteDetCell cellForTableView:tableView];
    if (_currentIndex == 0) {
        cell.homeModel = _homeAnalyAry[indexPath.row];
    }else{
        cell.homeModel = _awayAnalyAry[indexPath.row];
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 90;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self setHeaderViewWithSec:section];
}
- (UIView *)setHeaderViewWithSec:(NSInteger)section{
    
    DetMatch *match = self.model.Result.rows.match;

    self.titleStr = match.league;
    
    UIView *view = [[UIView alloc] initWithFrame:aFrame(0, 0, KScreenWidth, 90)];
    
    UIView *oneBgView = [[UIView alloc] initWithFrame:aFrame(0, 0, KScreenWidth, 30)];
    oneBgView.backgroundColor = FrameColor;

    UIView *twoBgView = [[UIView alloc] initWithFrame:aFrame(0, 30, KScreenWidth, 30)];
    twoBgView.backgroundColor = UIColorFromRGB(kColorWhite, 1.0);

    UIView *threeBgView = [[UIView alloc] initWithFrame:aFrame(0, 60, KScreenWidth, 30)];
    threeBgView.backgroundColor = UIColorFromRGB(kTabHeaderBGColor, 1.0);

    
    MCLabel *titleLB = [[MCLabel alloc] initWithFrame:aFrame(15, 0, 150, 30)
                                                 text:@"联赛积分排名"
                                            textColor:kColorWhite
                                             fontSize:14];
    titleLB.textAlignment = NSTextAlignmentLeft;
    titleLB.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    UISegmentedControl *segmt = [[UISegmentedControl alloc] initWithItems:@[@"主场",@"客场"]];
    segmt.frame = aFrame(KScreenWidth/2-45, 3, 90, 24);
    [segmt setTintColor:[UIColor whiteColor]];
    [segmt setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(kColorWhite, 1.0),NSFontAttributeName:FrameThreeFont} forState:UIControlStateNormal];
    [segmt setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(kColorRead, 1.0),NSFontAttributeName:FrameThreeFont} forState:UIControlStateSelected];
    
    NSString *teamName = @"";

    if (_currentIndex == 0) {
        segmt.selectedSegmentIndex = 0;
        teamName = match.home;
    }else{
        segmt.selectedSegmentIndex = 1;
        teamName = match.away;
    }
    [segmt addTarget:self action:@selector(segmtAction:) forControlEvents:UIControlEventValueChanged];
    
    [oneBgView addSubview:titleLB];
    [oneBgView addSubview:segmt];
    
    MCLabel *nameLB = [[MCLabel alloc] initWithFrame:aFrame(15, 0, 150, 30)
                                                 text:teamName
                                            textColor:kColorDark
                                             fontSize:14];
    nameLB.textAlignment = NSTextAlignmentLeft;
    [twoBgView addSubview:nameLB];

    
    NSArray *titleAry = @[@"类型",@"赛",@"胜",@"负",@"胜率"];
    for (int i = 0; i<titleAry.count; i++) {
        MCLabel *titLB = [[MCLabel alloc] initWithFrame:aFrame(i*(KScreenWidth/5), 0, KScreenWidth/5, 30)
                                                    text:titleAry[i]
                                               textColor:kColorDark
                                                fontSize:12];
        [titLB setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:12]];
        titLB.textAlignment = NSTextAlignmentCenter;
        [threeBgView addSubview:titLB];
    }
    
    [view addSubview:oneBgView];
    [view addSubview:twoBgView];
    [view addSubview:threeBgView];

    return view;
}
- (void)segmtAction:(UISegmentedControl *)segmt {
    int index = (int)segmt.selectedSegmentIndex;
    NSLog(@"segmtAction index = %d",index);
    _currentIndex = index;
    [self.tableView reloadData];
}

@end
