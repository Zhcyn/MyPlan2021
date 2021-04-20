#import "MGSwipeTableCell.h"
NS_ASSUME_NONNULL_BEGIN
@protocol STTargetTableViewCellDelegate <NSObject>
- (void)onTouchFinishModel:(STTargetModel *)model;
@end
@interface STTargetTableViewCell : MGSwipeTableCell
@property (strong, nonatomic) STTargetModel *model;
@property (weak, nonatomic) id<STTargetTableViewCellDelegate> delegate;
@property (copy, nonatomic) NSString *yearMonthDay; 
@end
NS_ASSUME_NONNULL_END
