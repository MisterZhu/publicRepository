//
//  SecondCtrl.m
//  NestedTableView
//
//  Created by LOLITA on 2017/9/20.
//  Copyright © 2017年 LOLITA0164. All rights reserved.
//

#import "SecondCtrl.h"
#import "LolitaTableView.h"
#import "SubTableView.h"
#import "QFTProductHeaderView.h"

@interface SecondCtrl ()<UITableViewDelegate,UITableViewDataSource,LolitaTableViewDelegate,SubTableViewDelegata>

@property (strong ,nonatomic) LolitaTableView *mainTable;
@property (strong ,nonatomic) SubTableView *subTable;
@property (nonatomic) UIView *bgView;
@property (nonatomic) QFTTravelProductInfoModel *infoModel;
@property (nonatomic) QFTProductHeaderView *headerView;
@property (nonatomic) CGFloat headerViewHeight;
@end

@implementation SecondCtrl

- (void)setupNavigationItems{
    [super setupNavigationItems];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem qmui_itemWithImage:[UIImageMake(@"BtnNavigationBarBackArrowBlack") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] target:self action:@selector(customBackAction)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem qmui_itemWithImage:[UIImageMake(@"分享") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] target:self action:@selector(shareWeChatAction)];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //掉透明导航栏边黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.mainTable];
    [self requestData];
}
- (void)requestData{
    [MBManager showLoading];
    MainViewModel *viewModel = [[MainViewModel alloc]init];
    [viewModel setBlockWithReturnBlock:^(id returnValue) {
        [MBManager hideAlert];
        
        self.infoModel = [[QFTTravelProductInfoModel alloc] init];
        self.infoModel = returnValue;
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.headerView.imageIndexArray = [self.infoModel.data.productMessage.productImage mutableCopy];
            [self.mainTable reloadData];
        });
        
    } WithErrorBlock:^(id errorCode) {
        [MBManager hideAlert];

    } WithFailureBlock:^{
        [MBManager hideAlert];

    }];
    NSDictionary *params = @{@"produceId":@(self.model.produceId),
                             };
    [viewModel encryptionRequestGetProductInfo:@"/app_user/getProduct" withParaDict:params withController:self];
}

-(SubTableView *)subTable{
    if (_subTable==nil) {
        _subTable = [[SubTableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight-Height_NavBar)];
        _subTable.infoModel = self.infoModel;
        _subTable.SubTableDelegate = self;
    }
    return _subTable;
}

-(LolitaTableView *)mainTable{
    
    if (_mainTable==nil) {
        _mainTable = [[LolitaTableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
        _mainTable.delegate = self;
        _mainTable.dataSource = self;
        _mainTable.tableFooterView = [UIView new];
        _mainTable.type = LolitaTableViewTypeMain;
        _mainTable.delegate_StayPosition = self;
        self.headerView = [[QFTProductHeaderView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, SCREEN_WIDTH * 0.6 + 100)];
        _headerViewHeight = [QFTProductHeaderView heightWithModel:self.model.describe];
        
        self.headerView.frame = aFrame(0, 0, screenWidth, _headerViewHeight);
        self.headerView.model = self.model;
        _mainTable.tableHeaderView = self.headerView;
        
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _mainTable.contentInset = UIEdgeInsetsMake(-Height_NavBar, 0, 0, 0);
        _mainTable.scrollIndicatorInsets = _mainTable.contentInset;
    }
    return _mainTable;
}
#pragma mark  -------------- UITableViewDelegate -------------------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row<1) {
        static NSString *cellId = @"cellId0";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell==nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        }
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        return cell;
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell addSubview:self.subTable];
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row<1) {
        return 10;
    }
    return self.subTable.frame.size.height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   
    return nil;
}
// !!!: 悬停的位置
#pragma mark  -------------- LolitaTableViewDelegate -------------------

-(CGFloat)lolitaTableViewHeightForStayPosition:(LolitaTableView *)tableView{
    return [tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]].origin.y;
}

- (void)customBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)shareWeChatAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark  -------------- SubTableViewDelegata -------------------
- (void)clickheadViewSection:(NSInteger)section withCell:(NSInteger)cell{
//    if (section == 0 && cell == 0) {
//        NSIndexPath * dayOne = [NSIndexPath indexPathForRow:0 inSection:0];
//        [_mainTable selectRowAtIndexPath:dayOne animated:YES scrollPosition:UITableViewScrollPositionTop];
//    }
    [_mainTable setContentOffset:CGPointMake(0, _headerViewHeight+11) animated:NO];
    [_mainTable reloadData];
}
//懒加载实现背景View
- (UIView*)bgView {
    if (_bgView == nil) {
        _bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, Height_NavBar)];
        [self.navigationController.view insertSubview:_bgView belowSubview:self.navigationController.navigationBar];
        
    }
    return _bgView;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat alpha = scrollView.contentOffset.y/(200-Height_NavBar);
    if (alpha > 1) {
        alpha = 1;
        self.title = @"产品详情";

    }else{
        self.title = @"";

    }
    [self bgView].backgroundColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:alpha];
    //NSLog(@"%f", scrollView.contentOffset.y); //  原始偏移的位置是-244
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

