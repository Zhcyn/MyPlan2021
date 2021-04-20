#import "MDCCollectionViewTextCell.h"
#import "STMyCenterViewModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface STCollectionViewCell : MDCCollectionViewTextCell
@property (strong, nonatomic) STMyCenterModel *model;
@end
NS_ASSUME_NONNULL_END
