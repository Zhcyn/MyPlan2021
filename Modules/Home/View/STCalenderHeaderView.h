#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@protocol STCalenderHeaderViewDelegate <NSObject>
- (void)onTouchCalenderHeaderViewIndex:(NSInteger)index;
@end
@interface STCalenderHeaderView : UIView
@property (nonatomic, weak) id<STCalenderHeaderViewDelegate> delegate;
@end
NS_ASSUME_NONNULL_END
