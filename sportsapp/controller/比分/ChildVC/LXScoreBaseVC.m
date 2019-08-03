//
//  LXScoreBaseVC.m
//  testDemo
//
//  Created by MCM on 2019/4/19.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import "LXScoreBaseVC.h"
#import "LXScoreCell.h"
#import "LXFootballDetVC.h"
#import "LXBasekteBallDetVC.h"

@interface LXScoreBaseVC ()<UITableViewDelegate,UITableViewDataSource,ZHPickViewDelegate>

/** 总数据源 */
@property (nonatomic, strong) NSMutableDictionary *dataMuDict;
@property (nonatomic, strong) NSMutableDictionary *keyMuDict;
@property (nonatomic, strong) NSMutableArray *dataMuAry;
@property (nonatomic, strong) MCScoreModel *model;
@property (nonatomic) NSArray *dataMuAryKeys;
@property(nonatomic,strong)ZHPickView *pickview;
@property (nonatomic, strong) NSString *currentDate;
@end

@implementation LXScoreBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarHidden:YES];
    [self setupUI];
    [self.tableView.mj_header beginRefreshing];
}

-(void)setupUI{
    [super setupUI];
    self.tableView.frame = aFrame(0, 0, kScreenWidth, KScreenHeight - Height_NavBar-Height_TabBar-49);
//    self.tableView.backgroundColor = UIColorFromRGB(kColorCommunBG, 1.0);;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.dataMuAry = [NSMutableArray array];
        [weakSelf requestData];
    }];
    
//    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        [weakSelf requestMoreData];
//    }];
}
- (void)setState:(NSInteger)state{
    _state = state;
    [self requestData];
}
- (void)requestData{
    WS(weakSelf)

    NSDictionary *dict = @{@"DownProtocalType":[MethodFactory rb_jsonStrFromDic:@{@"fields":@[@"*"]}],
                           @"RequireParameter":[MethodFactory rb_jsonStrFromDic:@{@"state":@([MCHostManager sharedConfig].state),@"league":[MCHostManager sharedConfig].league}],
                           @"Opcode":[MCHostManager sharedConfig].Opcode,
                           @"UpProtocalType":[MethodFactory rb_jsonStrFromDic:@{@"pagetype":@(0),@"filter":@[],@"pagination":@{},@"orderby":@[],@"groupby":@[]}]
                           };
    [[ZLXNetWork shareNetWork] PosttRequest:kBaseUrl
                                 postParams:dict
                        requestSuccessBlock:^(id result) {

                            dispatch_async(dispatch_get_main_queue(), ^{
                                [weakSelf.tableView.mj_header endRefreshing];
                                weakSelf.model = [MCScoreModel modelWithJSON:result];
                                [weakSelf.tableView reloadData];
                            });
                            
                        } requestFailedBlock:^(id error) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [weakSelf.tableView.mj_header endRefreshing];
                            });

                        }];
}

#pragma mark --- UITableViewDelegate  UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.model.Result.rows.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Rows *rowModel = self.model.Result.rows[section];
    return rowModel.items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    Rows *rowModel = self.model.Result.rows[indexPath.section];
    Items *itemsModel = rowModel.items[indexPath.row];
    
    LXScoreCell *cell = [LXScoreCell cellForTableView:tableView];
    cell.itme = itemsModel;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self setHeaderViewWithSec:section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    Rows *rowModel = self.model.Result.rows[indexPath.section];
    Items *itemsModel = rowModel.items[indexPath.row];
    
    if ([[MCHostManager sharedConfig].Opcode isEqualToString:@"bcy.footballmatch.score"]) {
        LXFootballDetVC *commentVc = [[LXFootballDetVC alloc] init];
        commentVc.Opcode = @"bcy.footballmatch.event2";
        commentVc.dataOpcode = @"bcy.footballmatch.complexgame";
        commentVc.matchID = itemsModel.match_id;
        commentVc.title = itemsModel.league;
        [self.navigationController pushViewController:commentVc animated:YES];
    }else{
        LXBasekteBallDetVC *commentVc = [[LXBasekteBallDetVC alloc] init];
        commentVc.Opcode = @"bcy.basketballmatch.complex";
        commentVc.matchID = itemsModel.match_id;
        [self.navigationController pushViewController:commentVc animated:YES];
    }
}
- (UIView *)setHeaderViewWithSec:(NSInteger)section{

    Rows *rowModel = self.model.Result.rows[section];

    NSString *title = [NSString stringWithFormat:@"%@ 星期%@ 共%ld场赛事",rowModel.date,rowModel.week,rowModel.items.count];
    UIView *view = [[UIView alloc] initWithFrame:aFrame(0, 0, KScreenWidth, 40)];
    view.backgroundColor = UIColorFromRGB(kTabHeaderBGColor, 1.0);
    MCLabel *titleLB = [[MCLabel alloc] initWithFrame:aFrame(0, 0, KScreenWidth-50, 40)
                                                 text:title
                                            textColor:kColorLabel
                                             fontSize:16];
    titleLB.center = view.center;
    [titleLB setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:14]];
    titleLB.textAlignment = NSTextAlignmentCenter;
    [view addSubview:titleLB];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTapHeaderView)];
    // 允许用户交互
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:tap];
    
    return view;
}
#pragma mark - 点击headerView
- (void)doTapHeaderView{
    
    NSArray *keys =[self getCityDictAllKeys];
  
    NSUInteger index = 0;

    if (self.currentDate.length > 0 && [keys containsObject:self.currentDate]) {
        index = [keys indexOfObject:self.currentDate];
    }
    
    if (keys.count<=0) {
        return;
    }
    _pickview = [[ZHPickView alloc]initPickviewWithArray:keys isHaveNavControler:NO withIndex:index];
    _pickview.delegate=self;
    [self.pickview setPickViewColer:[UIColor whiteColor]];
    [_pickview show];
}
#pragma mark - ZHPickViewDelegate
-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    
    NSArray *keys =[self getCityDictAllKeys];
    if ([keys containsObject:resultString]) {
        NSInteger index = [keys indexOfObject:resultString];
        self.currentDate = resultString;
        
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    
}
#pragma mark - 获得所有的key值并排序，并返回排好序的数组
- (NSArray *)getCityDictAllKeys
{
    NSMutableArray *keys = [NSMutableArray array];
    for (Rows *rowObj in self.model.Result.rows) {
        NSString *title = [NSString stringWithFormat:@"%@ 星期%@ 共%ld场赛事",rowObj.date,rowObj.week,rowObj.items.count];
        [keys addObject:title];
    }
    return keys;
}

@end
