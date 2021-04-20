#import "STBaseModel.h"
#import "STTargetViewModel.h"
extern NSString* _Nonnull const kSTTargetFilesPath;
NS_ASSUME_NONNULL_BEGIN
@interface STTargetManage : STBaseModel
+ (instancetype)sharedInstance;
- (void)addTargetModel:(STTargetModel* )model;
- (void)removeTargetModel:(STTargetModel *)model;
- (void)editTargetModel:(STTargetModel *)model;
- (void)finishTargetModel:(STTargetModel* )model;
- (void)cancelFnishTargetModel:(STTargetModel *)model;
- (BOOL)checkoutFinishStatus:(STTargetModel*)model;
- (BOOL)checkoutFinishStatus:(STTargetModel*)model yearMonthDay:(NSString *)yearMonthDay;
- (BOOL)checkContainsTargetTitle:(NSString *)title;
@property (nonatomic, strong) STTargetViewModel* viewModel;
@property (copy, nonatomic) NSString *yearMonthDay; 
@end
NS_ASSUME_NONNULL_END
