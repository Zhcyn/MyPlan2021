#import "STAddTargetButton.h"
#import <CYLTabBarController.h>
@implementation STAddTargetButton
+ (id)plusButton {
    STAddTargetButton* flatButton = [[STAddTargetButton alloc] init];
    [flatButton setImage:[UIImage imageNamed:@"addTarget_item"] forState:UIControlStateNormal];
    flatButton.backgroundColor = [UIColor ST_mainBlueColor];
    flatButton.layer.masksToBounds = YES;
    flatButton.layer.cornerRadius = 30;
    [flatButton ST_setsize:CGSizeMake(60, 60)];
    return flatButton;
}
+ (UIViewController *)plusChildViewController {
    STAddTargetVC* addVC = [[STAddTargetVC alloc] init];
    STBaseNavigationController* addTypenavigationVC = [[STBaseNavigationController alloc] initWithRootViewController:addVC];
     [addVC cyl_setHideNavigationBarSeparator:YES];
    return addTypenavigationVC;
}
+ (NSUInteger)indexOfPlusButtonInTabBar {
    return 1;
}
+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight {
    return 0.1;
}
@end
