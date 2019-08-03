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
#import "SDCycleScrollView.h"

//#import "QFTProductHeaderView.h"

@interface SecondCtrl ()<UITableViewDelegate,UITableViewDataSource,LolitaTableViewDelegate,SubTableViewDelegata>

@property (strong ,nonatomic) LolitaTableView *mainTable;
@property (strong ,nonatomic) SubTableView *subTable;
@property (nonatomic) UIView *bgView;
//@property (nonatomic) QFTTravelProductInfoModel *infoModel;
//@property (nonatomic) QFTProductHeaderView *headerView;
@property (nonatomic) CGFloat headerViewHeight;
@end

@implementation SecondCtrl

- (void)setupNavigationItems{

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

}

-(SubTableView *)subTable{
    if (_subTable==nil) {
        _subTable = [[SubTableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-Height_NavBar)];
//        _subTable.infoModel = self.infoModel;
        _subTable.SubTableDelegate = self;
    }
    return _subTable;
}

-(LolitaTableView *)mainTable{
    self.titleStr = self.title;

    if (_mainTable==nil) {
        _mainTable = [[LolitaTableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-Height_TabBar)];
        _mainTable.delegate = self;
        _mainTable.dataSource = self;
        _mainTable.tableFooterView = [UIView new];
        _mainTable.type = LolitaTableViewTypeMain;
        _mainTable.delegate_StayPosition = self;

        _mainTable.tableHeaderView = [self setTopScrollViewAry:nil];
        
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
- (UIView *)setTopScrollViewAry:(NSArray *)ary{
    
    UIView *topView = [[UIView alloc] initWithFrame:aFrame(0, 0, KScreenWidth, KScreenWidth*0.62)];
    
    NSArray  *muImgAry = @[@"https://img1.qunliao.info/fastdfs4/M00/CA/34/ChMf8Fzw67GAe_BLAAJmkLLgkbg309.jpg",@"https://img1.qunliao.info/fastdfs4/M00/CA/34/ChMf8Fzw67GAe_BLAAJmkLLgkbg309.jpg",@"https://img1.qunliao.info/fastdfs4/M00/CA/34/ChMf8Fzw67GAe_BLAAJmkLLgkbg309.jpg"];
    NSArray  *muTitleAry = @[@"穆里尼奥点出欧冠决赛双方关键球员：范戴克和埃里克森",@"穆里尼奥点出欧冠决赛双方关键球员：范戴克和埃里克森",@"穆里尼奥点出欧冠决赛双方关键球员：范戴克和埃里克森"];
    
    
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenWidth * 0.62) imageURLStringsGroup:muImgAry];
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView.titlesGroup = muTitleAry;
    [topView addSubview:cycleScrollView];
    
    return topView;
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
        return 50;
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
        _bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, Height_NavBar)];
        [self.navigationController.view insertSubview:_bgView belowSubview:self.navigationController.navigationBar];
        
    }
    return _bgView;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat alpha = scrollView.contentOffset.y/(200-Height_NavBar);
    if (alpha > 1) {
        alpha = 1;
        //self.title = @"产品详情";

    }else{
        //self.title = @"";

    }
    [self bgView].backgroundColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:alpha];
    //NSLog(@"%f", scrollView.contentOffset.y); //  原始偏移的位置是-244
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

