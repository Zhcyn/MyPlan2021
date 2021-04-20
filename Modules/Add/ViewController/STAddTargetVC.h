#import "STBaseViewController.h"
#import "STTargetManage.h"
#import "STTargetViewModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface STAddTargetVC : STBaseViewController
@property (strong, nonatomic, nullable) STTargetModel *model;
@property (assign, nonatomic) BOOL edit;
@end
NS_ASSUME_NONNULL_END
