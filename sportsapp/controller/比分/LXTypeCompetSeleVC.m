//
//  LXTypeCompetSeleVC.m
//  testDemo
//
//  Created by MCM on 2019/4/20.
//  Copyright © 2019年 xiguadianjing. All rights reserved.
//

#import "LXTypeCompetSeleVC.h"
#import "LXTypeCompetCell.h"

@interface LXTypeCompetSeleVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic)  UICollectionView *mainCollectionView;
@property (nonatomic) NSMutableArray *muTabAry;
@property (nonatomic) NSMutableArray *muSelectAry;

@end

@implementation LXTypeCompetSeleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleStr = self.title;
    self.muTabAry = [NSMutableArray array];
    self.muSelectAry = [NSMutableArray array];

    [self createCollectView];
    [self requestData];
    [self setButton];
}
- (void)createCollectView{
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //该方法也可以设置itemSize
    layout.itemSize = CGSizeMake((KScreenWidth-20)/3, 40);
    layout.minimumLineSpacing      = 8.0;
    layout.minimumInteritemSpacing = 8.0;
    //2.初始化collectionView
    _mainCollectionView = [[UICollectionView alloc] initWithFrame:aFrame(0, Height_NavBar, KScreenWidth, KScreenHeight - Height_NavBar-Height_TabBar-1) collectionViewLayout:layout];
    [self.view addSubview:_mainCollectionView];
    _mainCollectionView.layoutMargins = UIEdgeInsetsMake(10, 15, 0, 15);
    _mainCollectionView.backgroundColor = [UIColor whiteColor];
    
    [_mainCollectionView registerNib:[UINib nibWithNibName:@"LXTypeCompetCell" bundle:nil] forCellWithReuseIdentifier:@"TypeCompetCell"];
    //4.设置代理
    _mainCollectionView.delegate = self;
    _mainCollectionView.dataSource = self;
     _mainCollectionView.allowsMultipleSelection = YES;
}
- (void)setButton{
    UIButton *resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    resetBtn.frame = aFrame(0, KScreenHeight-50-Height_HomeIndicator, KScreenWidth/2, 50);
    resetBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [resetBtn setTitleColor:UIColorFromRGB(kColorGSecondary, 1.0) forState:UIControlStateNormal];
    [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    resetBtn.tag = 101;
    [resetBtn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetBtn];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = aFrame(KScreenWidth/2, KScreenHeight-50-Height_HomeIndicator, KScreenWidth/2, 50);
    sureBtn.backgroundColor = [UIColor redColor];
    [sureBtn setTitleColor:UIColorFromRGB(kColorWhite, 1.0) forState:UIControlStateNormal];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.tag = 102;
    [sureBtn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    
}
- (void)requestData{
    WS(weakSelf)
    
    NSDictionary *dict = @{@"DownProtocalType":[MethodFactory rb_jsonStrFromDic:@{@"fields":@[@"*"]}],
                           @"RequireParameter":[MethodFactory rb_jsonStrFromDic:@{@"state":@([MCHostManager sharedConfig].state)}],
                           @"Opcode":self.Opcode,
                           @"UpProtocalType":[MethodFactory rb_jsonStrFromDic:@{@"pagetype":@(0),@"filter":@[],@"pagination":@{},@"orderby":@[],@"groupby":@[]}]
                           };
    [[ZLXNetWork shareNetWork] PosttRequest:kBaseUrl
                                 postParams:dict
                        requestSuccessBlock:^(id result) {
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSDictionary *resultDict = result[@"Result"];
                                weakSelf.muTabAry = [resultDict[@"rows"] mutableCopy];
                                [weakSelf.mainCollectionView reloadData];
                            });
                            
                        } requestFailedBlock:^(id error) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                               // [weakSelf.tableView.mj_header endRefreshing];
                            });
                            
                        }];
}
#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.muTabAry.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    LXTypeCompetCell *cell = (LXTypeCompetCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"TypeCompetCell" forIndexPath:indexPath];
    
//    cell.model = self.model.selectLegue[indexPath.row];
    cell.title = self.muTabAry[indexPath.row];
    return cell;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    LXTypeCompetCell *cell= (LXTypeCompetCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.titleBgV.backgroundColor = [UIColor redColor];
    cell.titleLB.textColor = [UIColor whiteColor];
    [self.muSelectAry addObject:self.muTabAry[indexPath.row]];
}
#pragma mark - 返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LXTypeCompetCell *cell= (LXTypeCompetCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.titleBgV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    cell.titleLB.textColor = UIColorFromRGB(kColorGSecondary, 1.0);
    [self.muSelectAry removeObject:self.muTabAry[indexPath.row]];

}
#pragma mark - 点击按钮
- (void)clickBtnAction:(UIButton *)sender{
    if (sender.tag ==101) {
        [self.muSelectAry removeAllObjects];
        [self.mainCollectionView reloadData];
    }else{
        if (self.clickSureBlack) {
            self.clickSureBlack(self.muSelectAry);
        }
        [self popViewController];
    }
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
