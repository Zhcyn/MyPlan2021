#import "STTabBarViewController.h"
#import "STAddTargetButton.h"
#import "STPublic.h"
@interface STTabBarViewController ()
@end
@implementation STTabBarViewController
- (instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }
    UIEdgeInsets imageInsets = UIEdgeInsetsZero;
    UIOffset titlePositionAdjustment = UIOffsetMake(0, -1.5);
    CYLTabBarController* tabBarVC = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers  tabBarItemsAttributes:[self tabBarItemsAttributesForController] imageInsets:imageInsets titlePositionAdjustment:titlePositionAdjustment];
    [self customizeTabBarAppearance:tabBarVC];
    return (self = (STTabBarViewController *)tabBarVC);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [STAddTargetButton registerPlusButton];
}
- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    [tabBarController setTintColor:[UIColor ST_mainBlueColor]];
}
- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"Target",
                                                 CYLTabBarItemImage : @"target_item_normal",
                                                 CYLTabBarItemSelectedImage : @"target_item_selected",  
                                                 };
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"Me",
                                                  CYLTabBarItemImage : @"my_item_normal",
                                                  CYLTabBarItemSelectedImage : @"my_item_selected",
                                                  };
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       ];
    return tabBarItemsAttributes;
}
#pragma mark -- set  && get
- (NSArray *)viewControllers {
    STTargetVC *homeViewController = [[STTargetVC alloc] init];
    STBaseNavigationController *homeNavigationController = [[STBaseNavigationController alloc]
                                                  initWithRootViewController:homeViewController];
    [homeViewController cyl_setHideNavigationBarSeparator:YES];
    UIViewController *myCenterVC = [[STMyCenterVC alloc] init];
    UIViewController *myNavigationController = [[STBaseNavigationController alloc]
                                                  initWithRootViewController:myCenterVC];
    [myCenterVC cyl_setHideNavigationBarSeparator: YES];
    NSArray *viewControllers = @[
                                 homeNavigationController,
                                 myNavigationController,
                                 ];
    return viewControllers;
}
@end
