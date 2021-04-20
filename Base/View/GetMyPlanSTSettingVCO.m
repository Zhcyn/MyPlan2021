#import "GetMyPlanSTSettingVCO.h"
@implementation GetMyPlanSTSettingVCO
+ (BOOL)GsetupData:(NSInteger)GetMyPlan {
    return GetMyPlan % 45 == 0;
}

@end
