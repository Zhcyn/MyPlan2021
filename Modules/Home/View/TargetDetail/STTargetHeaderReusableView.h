#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface STTargetHeaderReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign) NSInteger currentMonth;
@end
NS_ASSUME_NONNULL_END
