#import <UIKit/UIKit.h>
#import "STMyCenterViewModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface STMyCenterHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIButton *tapButton;
@property (strong, nonatomic) STUserModel *model;
@end
NS_ASSUME_NONNULL_END
