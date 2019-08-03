//
//  MCHomeViewController.m
//  sportsapp
//
//  Created by WEI ZOU on 2019/4/25.
//  Copyright © 2019 xiguadianjing. All rights reserved.
//

#import "MCHomeViewController.h"
#import "SDCycleScrollView.h"
#import "LXNewsListCell.h"
#import "LXNewDetailVC.h"

@interface MCHomeViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

@property (nonatomic, strong) MCNewsListModel *footModel;
@property (nonatomic, strong) MCNewsListModel *bastketModel;
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic, strong) NSMutableArray *footMuAry;
@property (nonatomic, strong) NSMutableArray *bastketMuAry;

@property (nonatomic) NSInteger footPageNu;

@property (nonatomic) NSInteger bastketPageNu;

@end

@implementation MCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarHidden:YES];
    //    [self hideLeftNavigationBar];
    _currentIndex = 0;
    _footPageNu = 1;
    _bastketPageNu = 1;
    
    _footMuAry = [[NSMutableArray alloc] init];
    _bastketMuAry = [[NSMutableArray alloc] init];
    
    [self setupUI];

}
-(void)setupUI{
    [super setupUI];
    self.tableView.frame = aFrame(0, 0, kScreenWidth, KScreenHeight-Height_TabBar);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    WS(weakSelf)
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
//        if (weakSelf.currentIndex == 0) {
//            weakSelf.footPageNu = 1;
//            [weakSelf requestData];
//        }else{
//            weakSelf.bastketPageNu = 1;
//            [weakSelf requestBasketballData];
//        }
        weakSelf.footPageNu = 1;
        [weakSelf requestData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        if (weakSelf.currentIndex == 0) {
//            weakSelf.footPageNu ++;
//            [weakSelf requestData];
//        }else{
//            weakSelf.bastketPageNu ++;
//            [weakSelf requestBasketballData];
//        }
        weakSelf.footPageNu ++;
        [weakSelf requestData];
    }];
    self.tableView.tableHeaderView = [self setTopScrollViewAry:self.footModel.Result.rows];
    [self.tableView.mj_header beginRefreshing];

}
- (UIView *)setTopScrollViewAry:(NSArray *)ary{
    
    UIView *topView = [[UIView alloc] initWithFrame:aFrame(0, 0, KScreenWidth, KScreenWidth*0.62)];
    
    NSMutableArray  *muImgAry = [[NSMutableArray alloc] init];
    NSMutableArray  *muTitleAry = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<ary.count; i++) {
        
        NewsRows *model = ary[i];
        NSArray *imgAry = [MethodFactory getImageurlFromHtml:model.content];
        if (imgAry.count>0) {
            [muImgAry addObject:imgAry[0]];
            [muTitleAry addObject:model.title];
        }
        if (i >=2) {
            break;
        }
    }
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenWidth * 0.62) imageURLStringsGroup:muImgAry];
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView.titlesGroup = muTitleAry;
    [topView addSubview:cycleScrollView];
    
    return topView;
}
- (void)requestData{
    NSInteger newType = 1;
    if (_currentIndex == 0) {
        newType = 1;
    }else{
        newType = 2;
    }
    WS(weakSelf);
    NSDictionary *dict = @{@"DownProtocalType":[MethodFactory rb_jsonStrFromDic:@{@"fields":@[@"*"]}],
                           @"RequireParameter":@[],
                           @"Opcode":@"bcy.news",
                           @"UpProtocalType":[MethodFactory rb_jsonStrFromDic:@{@"pagetype":@(1),@"filter":@[@[@"news_type",@(newType)]],@"pagination":@{@"pagesize":@(10),@"page":@(self.footPageNu)},@"orderby":@[],@"groupby":@[]}]
                           };
    [[ZLXNetWork shareNetWork] PosttRequest:kBaseUrl
                                 postParams:dict
                        requestSuccessBlock:^(id result) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                [weakSelf.tableView.mj_header endRefreshing];
                                
                                if (newType == 1) {
                                    if (weakSelf.footPageNu == 1) {
                                        weakSelf.footModel = [MCNewsListModel modelWithJSON:result];
                                        weakSelf.footMuAry =  [weakSelf.footModel.Result.rows mutableCopy];
                                        if (weakSelf.footMuAry.count>0) {
                                            weakSelf.tableView.tableHeaderView = [weakSelf setTopScrollViewAry:weakSelf.footModel.Result.rows];
                                        }
                                    }else{
                                        weakSelf.footModel = [MCNewsListModel modelWithJSON:result];
                                        [weakSelf.footMuAry addObjectsFromArray:weakSelf.footModel.Result.rows];
                                    }
                                    
                                    
                                    if (weakSelf.footModel.Result.rows.count>0) {
                                        int remainder = weakSelf.footModel.Result.rows.count%10;
                                        if (!(remainder == 0)){
                                            self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                                        }else{
                                            self.tableView.mj_footer.state = MJRefreshStateIdle;
                                        }
                                    }else{
                                        self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                                    }
                                }else{
                                    if (weakSelf.bastketPageNu == 1) {
                                        weakSelf.bastketModel = [MCNewsListModel modelWithJSON:result];
                                        weakSelf.bastketMuAry =  [weakSelf.bastketModel.Result.rows mutableCopy];
                                    }else{
                                        weakSelf.bastketModel = [MCNewsListModel modelWithJSON:result];
                                        [weakSelf.bastketMuAry addObjectsFromArray:weakSelf.bastketModel.Result.rows];
                                    }
                                    
                                    
                                    if (weakSelf.bastketModel.Result.rows.count>0) {
                                        int remainder = weakSelf.bastketModel.Result.rows.count%10;
                                        if (!(remainder == 0)){
                                            self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                                        }else{
                                            self.tableView.mj_footer.state = MJRefreshStateIdle;
                                        }
                                    }else{
                                        self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                                    }
                                }
                                
                                [weakSelf.tableView reloadData];

                            });
                            
                        } requestFailedBlock:^(id error) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                [weakSelf.tableView.mj_header endRefreshing];
                                [weakSelf.tableView reloadData];

                            });
                            
                        }];
}
//- (void)requestBasketballData{
//    WS(weakSelf);
//    NSDictionary *dict = @{@"DownProtocalType":[MethodFactory rb_jsonStrFromDic:@{@"fields":@[@"*"]}],
//                           @"RequireParameter":@[],
//                           @"Opcode":@"bcy.news",
//                           @"UpProtocalType":[MethodFactory rb_jsonStrFromDic:@{@"pagetype":@(1),@"filter":@[@[@"news_type",@(2)]],@"pagination":@{@"pagesize":@(20),@"page":@(self.bastketPageNu)},@"orderby":@[],@"groupby":@[]}]
//                           };
//
//    [[ZLXNetWork shareNetWork] PosttRequest:kBaseUrl
//                                 postParams:dict
//                        requestSuccessBlock:^(id result) {
//                            dispatch_async(dispatch_get_main_queue(), ^{
//                                [weakSelf.tableView.mj_header endRefreshing];
//
//                                if (weakSelf.bastketPageNu == 1) {
//                                    weakSelf.bastketModel = [MCNewsListModel modelWithJSON:result];
//                                    weakSelf.bastketMuAry =  [weakSelf.bastketModel.Result.rows mutableCopy];
//                                }else{
//                                    weakSelf.bastketModel = [MCNewsListModel modelWithJSON:result];
//                                    [weakSelf.bastketMuAry addObjectsFromArray:weakSelf.bastketModel.Result.rows];
//                                }
//
//
//                                if (weakSelf.bastketModel.Result.rows.count>0) {
//                                    int remainder = weakSelf.bastketModel.Result.rows.count%20;
//                                    if (!(remainder == 0)){
//                                        self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
//                                    }else{
//                                        self.tableView.mj_footer.state = MJRefreshStateIdle;
//                                    }
//                                }else{
//                                    self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
//                                }
//                                [weakSelf.tableView reloadData];
//                            });
//
//                        } requestFailedBlock:^(id error) {
//                            dispatch_async(dispatch_get_main_queue(), ^{
//
//                                [weakSelf.tableView.mj_header endRefreshing];
//
//                            });
//                        }];
//}

#pragma mark --- UITableViewDelegate  UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_currentIndex == 0) {
        return self.footMuAry.count;
    }else{
        return self.bastketMuAry.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LXNewsListCell *cell = [LXNewsListCell cellForTableView:tableView];
    if (_currentIndex == 0) {
        cell.model = self.footMuAry[indexPath.row];
    }else{
        cell.model = self.bastketMuAry[indexPath.row];
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self setHeaderViewWithSec:section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    LXNewDetailVC *vc = [[LXNewDetailVC alloc] init];
    
    if (_currentIndex == 0) {
        vc.title = @"足球资讯";
        vc.model = self.footMuAry[indexPath.row];
        
    }else{
        vc.title = @"篮球资讯";
        vc.model = self.bastketMuAry[indexPath.row];
        
    }
    [self.navigationController pushViewController:vc animated:YES];
}
- (UIView *)setHeaderViewWithSec:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:aFrame(0, 0, KScreenWidth, 41)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    btnLeft.frame = aFrame(0, 0, KScreenWidth/2, 40);
    [btnLeft setTitle:@"足球" forState:UIControlStateNormal];
    btnLeft.titleLabel.font = [UIFont fontWithName :@"Helvetica-Bold" size :14];
    btnLeft.tag = 0;
    btnLeft.backgroundColor = [UIColor whiteColor];
    
    [btnLeft addTarget:self action:@selector(clickHeaderVBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnLeft];
    
    UIButton *btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRight.frame = aFrame(KScreenWidth/2, 0, KScreenWidth/2, 40);
    [btnRight setTitle:@"篮球" forState:UIControlStateNormal];
    btnRight.titleLabel.font = [UIFont fontWithName :@"Helvetica-Bold" size :14];
    btnRight.backgroundColor = [UIColor whiteColor];
    
    btnRight.tag = 1;
    [btnRight addTarget:self action:@selector(clickHeaderVBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btnRight];
    
    UIView *leftLine = [[UIView alloc] initWithFrame:aFrame(0, 40, KScreenWidth/2, 1)];
    [view addSubview:leftLine];
    
    UIView *rightLine = [[UIView alloc] initWithFrame:aFrame(KScreenWidth/2, 40, KScreenWidth/2, 1)];
    [view addSubview:rightLine];
    
    if (_currentIndex == 0) {
        [btnLeft setTitleColor:UIColorFromRGB(kColorRead, 1.0) forState:UIControlStateNormal];
        leftLine.backgroundColor = UIColorFromRGB(kColorRead, 1.0);
        
        [btnRight setTitleColor:UIColorFromRGB(kColorDark, 1.0) forState:UIControlStateNormal];
        rightLine.backgroundColor = [UIColor clearColor];
        
    }else{
        [btnLeft setTitleColor:UIColorFromRGB(kColorDark, 1.0) forState:UIControlStateNormal];
        leftLine.backgroundColor = [UIColor clearColor];
        
        [btnRight setTitleColor:UIColorFromRGB(kColorRead, 1.0) forState:UIControlStateNormal];
        rightLine.backgroundColor = UIColorFromRGB(kColorRead, 1.0);
        
    }
    return view;
}
- (void)clickHeaderVBtn:(UIButton *)segmt {
    int index = (int)segmt.tag;
    NSLog(@"clickHeaderVBtn index = %d",index);
    if (_currentIndex == index) return;
    _currentIndex = index;
//    [self.tableView reloadData];
    [self.tableView.mj_header beginRefreshing];

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
