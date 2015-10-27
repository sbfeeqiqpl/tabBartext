//
//  BaseTabBarViewController.m
//  YYAnimationTabBar
//
//  Created by 王园园 on 15/10/26.
//  Copyright © 2015年 王园园. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "SubItem.h"
#import "HomeViewController.h"
#import "FavoritesViewController.h"
#import "ProfileViewController.h"
#import "PinViewController.h"




#define TabbarHeight self.tabBar.frame.size.height
#define TabbarWidth self.tabBar.frame.size.width
static NSInteger num =0;

@interface BaseTabBarViewController ()

@property (nonatomic,assign)NSInteger ViewControllerCount;
@end

@implementation BaseTabBarViewController
{
    UIView *barView;
    SubItem *tempSelectItem;
}



static BaseTabBarViewController* _myTabBarVC = nil;

+(BaseTabBarViewController*)shareTabBarController{
    @synchronized(self){
        if (!_myTabBarVC) {
            _myTabBarVC = [[BaseTabBarViewController alloc]init];
        }
    }
    return _myTabBarVC;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //自定义的tabBar
    barView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-49, self.view.frame.size.width, 49)];
    barView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
    barView.userInteractionEnabled = YES;
    self.tabBar.hidden = YES;
    [self.view addSubview:barView];

    [self initSubViews];
}

-(void)initSubViews
{
    _ViewControllerCount = 4;
    HomeViewController *hvc = [[HomeViewController alloc]init];
    [self setupItemWithViewController:hvc ItemData:@{@"title":@"home",@"imageStr":@"icon_1",@"imageStr_s":@"icon_1"}];
    
    FavoritesViewController *fvc = [[FavoritesViewController alloc]init];
    [self setupItemWithViewController:fvc ItemData:@{@"title":@"favorite",@"imageStr":@"icon_2",@"imageStr_s":@"icon_2"}];

    
    ProfileViewController *pvc = [[ProfileViewController alloc]init];
    [self setupItemWithViewController:pvc ItemData:@{@"title":@"profile",@"imageStr":@"icon_3",@"imageStr_s":@"icon_3"}];

    
    PinViewController *pivc = [[PinViewController alloc]init];
    [self setupItemWithViewController:pivc ItemData:@{@"title":@"pin",@"imageStr":@"icon_4",@"imageStr_s":@"icon_4"}];
}


-(void)setupItemWithViewController:(UIViewController *)vc ItemData:(NSDictionary *)data
{
    //封装item数据
    
    Item *item = [[Item alloc]initItemWithDictionary:data];
    vc.title = item.title;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    NSLog(@"%@",self.viewControllers);
    
    CGFloat SubItemWidth = barView.frame.size.width/_ViewControllerCount;
    SubItem *subitem = [[SubItem alloc]initWithFrame:CGRectMake(SubItemWidth*num, 0,SubItemWidth, TabbarHeight)];
    subitem.item = item;
    subitem.userInteractionEnabled = YES;
    subitem.tag = num;
    [barView addSubview:subitem];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SelectSubItemIndex:)];
    [subitem addGestureRecognizer:tap];
    num++;
   
    [self initDefaultItem:0];
}



//默认选中item0
-(void)initDefaultItem:(NSInteger)index
{
    SubItem *subitem  = barView.subviews[index];
    tempSelectItem = subitem;
    [subitem setItemSlected:^{
    }];
}

//点击方法
-(void)SelectSubItemIndex:(UIGestureRecognizer *)gesture
{
    NSInteger selectindex = gesture.view.tag;
    [self setTabBarSelectedIndex:selectindex];
}


-(void)setTabBarSelectedIndex:(NSUInteger)selectedIndex
{
    self.selectedIndex = selectedIndex;
    SubItem *selectSubitem  = (SubItem *)barView.subviews[selectedIndex];
    if(selectedIndex != tempSelectItem.tag){
        [selectSubitem setItemSlected:^{
            [tempSelectItem setItemNomal];
        }];
        tempSelectItem = selectSubitem;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
