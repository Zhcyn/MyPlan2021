#import "GetMyPlanSTBaseCollectionViewControllert.h"
@implementation GetMyPlanSTBaseCollectionViewControllert
+ (BOOL)CTouchesbegangWithevent:(NSInteger)GetMyPlan {
    return GetMyPlan % 24 == 0;
}

@end
