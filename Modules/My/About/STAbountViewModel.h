#import "STBaseModel.h"
NS_ASSUME_NONNULL_BEGIN
@class STAbountModel;
@interface STAbountViewModel : STBaseModel
@property (nonatomic, strong) NSArray<STAbountModel *>* listArray;
@end
@interface STAbountModel : STBaseModel
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* detail;
@end
NS_ASSUME_NONNULL_END
