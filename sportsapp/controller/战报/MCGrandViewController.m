//
//  MCGrandViewController.m
//  sportsapp
//
//  Created by WEI ZOU on 2019/4/25.
//  Copyright © 2019 xiguadianjing. All rights reserved.
//

#import "MCGrandViewController.h"
#import "LXTypeCompetSeleVC.h"
#import "LXScoreCell.h"
#import "MCUnderLineBtnScrView.h"
#import "LXStandDetailVC.h"

@interface MCGrandViewController ()<UITableViewDelegate,UITableViewDataSource,ZHPickViewDelegate>

@property (nonatomic, strong) MCStandingsModel *model;
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic, strong) NSString * currentDate;

@property (nonatomic) NSMutableArray *muSelectAry;
@property (nonatomic, strong) NSString *Opcode;
@property (nonatomic, strong) NSString *league;
@property (nonatomic) MCUnderLineBtnScrView * barScrollUnderlineButton;

@property (nonatomic, strong) NSMutableArray *silderDate;
@property (nonatomic, strong) NSMutableArray *moreDate;
@property(nonatomic,strong)ZHPickView *pickview;

@end

@implementation MCGrandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Opcode = @"bcy.footballmatch.war";
    self.league = @"";
    self.currentDate = @"";
    self.muSelectAry = [NSMutableArray array];
    self.silderDate = [NSMutableArray array];
    self.moreDate = [NSMutableArray array];
    
    _currentIndex = 0;
    [self setSegmentView];
    [self hideLeftNavigationBar];
    [self setupUI];
    [self.tableView.mj_header beginRefreshing];
    
    [self initRequestData];
    
}
-(void)setupUI{
    [super setupUI];
    self.tableView.frame = aFrame(0, Height_NavBar+45, kScreenWidth, KScreenHeight - Height_NavBar-Height_TabBar-45);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    WS(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestData];
    }];
}
- (void)setScrollUnderlineButton{
    
    _barScrollUnderlineButton = [[MCUnderLineBtnScrView alloc] initWithFrame:(CGRectMake(0, Height_NavBar, kScreenWidth-40, 45))];
    _barScrollUnderlineButton.titles = (NSArray *)self.silderDate;
    [self.view addSubview:_barScrollUnderlineButton];
    WS(weakSelf);
    _barScrollUnderlineButton.scrollUnderlineButtonBlock = ^(NSUInteger selectedIndex) {
        NSLog(@"selectedIndex = %ld", selectedIndex);
        Silder_Date *model = weakSelf.silderDate[selectedIndex];
        weakSelf.currentDate = model.date;
        weakSelf.barScrollUnderlineButton.lineView.backgroundColor = [UIColor redColor];
        [weakSelf requestData];
    };
    /// 设置字体和颜色
    _barScrollUnderlineButton.normalColor = [UIColor blackColor];
    _barScrollUnderlineButton.selectedColor = [UIColor redColor];
    _barScrollUnderlineButton.selectedFont = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    _barScrollUnderlineButton.normalFont = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    _barScrollUnderlineButton.lineView.backgroundColor = [UIColor redColor];
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0.1];
    UIButton *moreIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    moreIcon.frame = aFrame(KScreenWidth-40, Height_NavBar, 40, 45);
    [moreIcon setImage:kIMAGE(@"downmarked") forState:UIControlStateNormal];
    moreIcon.backgroundColor = [UIColor whiteColor];
    [moreIcon addTarget:self action:@selector(clickSelectData:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:moreIcon];
}
- (void)delayMethod{
    _barScrollUnderlineButton.seleIndex = self.silderDate.count-1;
}
- (void)clickSelectData:(UIButton *)sender{
    
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
#pragma mark - 获得所有的key值并排序，并返回排好序的数组
- (NSArray *)getCityDictAllKeys
{
    NSMutableArray *keys = [NSMutableArray array];
    for (More_Date *rowObj in self.moreDate) {
        NSString *title = [NSString stringWithFormat:@"%@",rowObj.date];
        [keys addObject:title];
    }
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:[keys sortedArrayUsingSelector:@selector(compare:)]];
    return mutableArray;
}
#pragma mark - ZHPickViewDelegate
-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    
    NSString *strUrl = [self.currentDate stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    
    NSArray *keys =[self getCityDictAllKeys];
    if ([keys containsObject:resultString]) {
        self.currentDate = resultString;
        [self.tableView.mj_header beginRefreshing];
    }
    NSLog(@"----date = %@ and url = %@",self.currentDate,strUrl);
    if (![self.currentDate containsString:strUrl]) {
        _barScrollUnderlineButton.lineView.backgroundColor = [UIColor grayColor];
    }
}
- (void)setSegmentView{
    UISegmentedControl *segmt = [[UISegmentedControl alloc] initWithItems:@[@"足球",@"篮球"]];
    segmt.frame = aFrame(KScreenWidth/2-70, Height_StatusBar+10, 140, 24);
    
    [segmt setTintColor:[UIColor whiteColor]];
    [segmt setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(kColorWhite, 1.0),NSFontAttributeName:FrameThreeFont} forState:UIControlStateNormal];
    [segmt setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(kColorRead, 1.0),NSFontAttributeName:FrameThreeFont} forState:UIControlStateSelected];
    
    segmt.selectedSegmentIndex = 0;
    [segmt addTarget:self action:@selector(segmtAction:) forControlEvents:UIControlEventValueChanged];
    self.naTitleView = segmt;
    
    [self setRightNavigationBarWithTitle:@"" image:@"shaixuan" action:@selector(indexRightNavigationBarBtnClick)];
    
}
- (void)segmtAction:(UISegmentedControl *)segmt {
    int index = (int)segmt.selectedSegmentIndex;
    NSLog(@"segmtAction index = %d",index);
    if (_currentIndex == index) return;
    _currentIndex = index;
    if (index == 0) {
        self.Opcode = @"bcy.footballmatch.war";
    }else{
        self.Opcode = @"bcy.basketballmatch.war";
    }
    self.league = @"";
    self.currentDate = @"";
    [self initRequestData];
}
- (void)indexRightNavigationBarBtnClick{
    
    LXTypeCompetSeleVC *vc = [[LXTypeCompetSeleVC alloc] init];
    
    if (_currentIndex == 0) {
        vc.Opcode = @"bcy.footballmatch.filter";
        vc.title = @"足球筛选";
    }else{
        vc.title = @"篮球筛选";
        vc.Opcode = @"bcy.basketballmatch.filter";
    }
    WS(weakSelf)
    vc.clickSureBlack = ^(NSMutableArray * _Nonnull selectAry) {
        weakSelf.muSelectAry = selectAry;
        weakSelf.league = [weakSelf.muSelectAry componentsJoinedByString:@","];
    };
    
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)requestData{
    WS(weakSelf)
    NSDictionary *dict = @{@"DownProtocalType":[MethodFactory rb_jsonStrFromDic:@{@"fields":@[@"*"]}],
                           @"RequireParameter":[MethodFactory rb_jsonStrFromDic:@{@"date":self.currentDate,@"league":self.league}],
                           @"Opcode":self.Opcode,
                           @"UpProtocalType":[MethodFactory rb_jsonStrFromDic:@{@"pagetype":@(0),@"filter":@[],@"pagination":@{},@"orderby":@[],@"groupby":@[]}]
                           };
    [[ZLXNetWork shareNetWork] PosttRequest:kBaseUrl
                                 postParams:dict
                        requestSuccessBlock:^(id result) {
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                [weakSelf.tableView.mj_header endRefreshing];
                                weakSelf.model = [MCStandingsModel modelWithJSON:result];
                                [weakSelf.tableView reloadData];
                                
                            });
                            
                        } requestFailedBlock:^(id error) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [weakSelf.tableView.mj_header endRefreshing];
                            });
                            
                        }];
}
- (void)initRequestData{
    WS(weakSelf)
    NSDictionary *dict = @{@"DownProtocalType":[MethodFactory rb_jsonStrFromDic:@{@"fields":@[@"*"]}],
                           @"RequireParameter":[MethodFactory rb_jsonStrFromDic:@{@"date":@"",@"league":self.league}],
                           @"Opcode":self.Opcode,
                           @"UpProtocalType":[MethodFactory rb_jsonStrFromDic:@{@"pagetype":@(0),@"filter":@[],@"pagination":@{},@"orderby":@[],@"groupby":@[]}]
                           };
    [[ZLXNetWork shareNetWork] PosttRequest:kBaseUrl
                                 postParams:dict
                        requestSuccessBlock:^(id result) {
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                weakSelf.model = [MCStandingsModel modelWithJSON:result];
                                
                                weakSelf.silderDate = [weakSelf.model.Result.rows.silder_date mutableCopy];
                                if (weakSelf.silderDate.count>0) {
                                    Silder_Date *dataM = [weakSelf.silderDate lastObject];
                                    weakSelf.currentDate = dataM.date;
                                }
                                weakSelf.moreDate = [weakSelf.model.Result.rows.more_date mutableCopy];
                                
                                [weakSelf setScrollUnderlineButton];
                                [weakSelf requestData];
                            });
                            
                        } requestFailedBlock:^(id error) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [weakSelf.tableView.mj_header endRefreshing];
                            });
                            
                        }];
}

#pragma mark --- UITableViewDelegate  UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.Result.rows.matchs.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StandMatchs *model = self.model.Result.rows.matchs[indexPath.row];
    LXScoreCell *cell = [LXScoreCell cellForTableView:tableView];
    cell.backgroundColor = [UIColor whiteColor];
    cell.model = model;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    StandMatchs *model = self.model.Result.rows.matchs[indexPath.row];
    
    LXStandDetailVC *vc = [[LXStandDetailVC alloc] init];
    if ([self.Opcode isEqualToString:@"bcy.footballmatch.war"]) {
        //战绩
        vc.recordOpcode = @"bcy.footballmatch.warrecord";
        //综合
        vc.complexOpcode = @"bcy.footballmatch.warcomplex";
        vc.matchID = model.match_id;
        
    }else{
        //战绩
        vc.recordOpcode = @"bcy.basketballmatch.warrecord";
        //综合
        vc.complexOpcode = @"bcy.basketballmatch.warcomplex";
        vc.matchID = model.match_id;
        
    }
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
