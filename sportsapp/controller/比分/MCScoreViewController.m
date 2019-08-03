//
//  MCScoreViewController.m
//  sportsapp
//
//  Created by WEI ZOU on 2019/4/25.
//  Copyright © 2019 xiguadianjing. All rights reserved.
//

#import "MCScoreViewController.h"
#import "LXTypeCompetSeleVC.h"

@interface MCScoreViewController ()
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic) NSMutableArray *muSelectAry;
@end

@implementation MCScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.muSelectAry = [NSMutableArray array];
    [self hideLeftNavigationBar];
    
    _currentIndex = 0;
    [self setSegmentView];
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
    [[MCHostManager sharedConfig] setOpcode:@"bcy.footballmatch.score"];
    [self.view addSubview:[self updateUI]];
    
    [self setRightNavigationBarWithTitle:@"" image:@"shaixuan" action:@selector(indexRightNavigationBarBtnClick)];
    
}
- (void)segmtAction:(UISegmentedControl *)segmt {
    int index = (int)segmt.selectedSegmentIndex;
    NSLog(@"segmtAction index = %d",index);
    if (_currentIndex == index) return;
    
    _currentIndex = index;
    if (index == 0) {
        [[MCHostManager sharedConfig] setOpcode:@"bcy.footballmatch.score"];
        [[MCHostManager sharedConfig] setLeague:@""];
        [self.view addSubview:[self updateUI]];
        
    }else{
        [[MCHostManager sharedConfig] setOpcode:@"bcy.basketballmatch.score"];
        [[MCHostManager sharedConfig] setLeague:@""];
        [self.view addSubview:[self updateUI]];
        
    }
}
- (FTPageView *)updateUI{
    
    NSArray *titleAry = @[@"全部",@"未开赛",@"进行中",@"已完赛",@"已完赛",@"已完赛"];
    NSArray *controllerAry = @[@"LXScoreOneVC",@"LXScoreTwoVC",@"LXScoreThreeVC",@"LXScoreFourVC",@"LXScoreFourVC",@"LXScoreFourVC"];
    
    FTPageView *pageView = [[FTPageView alloc] initWithFrame:CGRectMake(0, Height_NavBar, KScreenWidth , KScreenHeight) withTitles:titleAry withViewControllers:controllerAry withParameters:nil];
    pageView.defaultSubscript = 0;
    //    if (_isScroll) {
    //        pageView.bodyPageScrollEnabled=YES;
    //    }else{
    //        pageView.bodyPageScrollEnabled=NO;
    //    }
    pageView.clickTitleBlock = ^(NSInteger btnTag) {
        NSLog(@"clickTitleBlock = %ld",btnTag);
        switch (btnTag) {
            case 0:
                [[MCHostManager sharedConfig] setState:0];
                break;
            case 1:
                [[MCHostManager sharedConfig] setState:1];
                break;
            case 2:
                [[MCHostManager sharedConfig] setState:2];
                break;
            case 3:
                [[MCHostManager sharedConfig] setState:3];
                break;
            default:
                break;
        }
    };
    
    return pageView;
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
        NSString *string = [weakSelf.muSelectAry componentsJoinedByString:@","];
        [[MCHostManager sharedConfig] setLeague:string];
        [weakSelf.view addSubview:[self updateUI]];
        
    };
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
