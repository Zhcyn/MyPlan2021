#import "STBaseModel.h"
#import "STCalendarViewModel.h"
NS_ASSUME_NONNULL_BEGIN
@class STTargetModel;
@interface STTargetViewModel : STBaseModel
@property (nonatomic, strong) NSMutableArray<STTargetModel* >* listArray;
@property (nonatomic, strong, nullable) NSMutableArray<STTargetModel* >* currentDaylistArray;
- (void)setupCurrentDaylistArray;
@property (strong, nonatomic) STCalendarViewModel *calendarManger;
@end
@interface STTargetModel : STBaseModel
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* imageView;
@property (nonatomic, assign) NSInteger imageIndex;
@property (nonatomic, strong) NSMutableArray<NSString* >* finishWeekDays;
@property (nonatomic, strong) NSMutableArray<NSString* >* notificationTimes;
@property (nonatomic, copy) NSString* encourage;
@property (nonatomic, assign) BOOL finishStatus;
@property (nonatomic, assign) BOOL notificationStatus;
@property (assign, nonatomic) NSInteger monthNumber; 
@property (assign, nonatomic) NSInteger totalNumber; 
@property (strong, nonatomic) NSMutableArray<NSMutableDictionary*> *finishrecordS; 
@property (assign, nonatomic) NSString* monthDay; 
@end
NS_ASSUME_NONNULL_END
