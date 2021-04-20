#import "STBaseModel.h"
NS_ASSUME_NONNULL_BEGIN
@class STMyCenterModel;
@class STUserModel;
@interface STMyCenterViewModel : STBaseModel
@property (strong, nonatomic) NSArray<STMyCenterModel* > *listArray;
@property (strong, nonatomic) STUserModel *userData;
- (void)setupUserData;
- (void)saveUserData;
@end
@interface STUserModel : STBaseModel
@property (copy, nonatomic) NSString *userName;
@property (copy, nonatomic) NSString *userImageView;
@end
@interface STMyCenterModel : STBaseModel
@property (copy, nonatomic) NSString *imageName;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *detail;
@property (copy, nonatomic) NSString *route;
@property (copy, nonatomic) NSString *subTitle;
@end
NS_ASSUME_NONNULL_END
