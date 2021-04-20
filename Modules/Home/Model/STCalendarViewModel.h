#import <Foundation/Foundation.h>
#import <FSCalendar.h>
NS_ASSUME_NONNULL_BEGIN
@interface STCalendarViewModel : NSObject
@property (nonatomic, assign) NSInteger currentDay; 
@property (nonatomic, strong) NSCalendar* calendar;
@property (nonatomic, strong) NSCalendar* gregorian;
@property (nonatomic, strong) NSArray* titleArray;       
@property (nonatomic, assign) NSInteger index;           
@property (nonatomic, assign) NSInteger year;            
@property (nonatomic, assign) NSInteger month;           
@property (nonatomic, assign) NSInteger day;             
@property (nonatomic, assign) NSInteger dayIndex;
@property (nonatomic, strong) NSDate* currentDate;
@property (nonatomic, strong) NSDate* showDate;
@property (nonatomic, assign) BOOL isShowCurrentMonth;
- (void)update;     
- (void)lastMonthd; 
- (void)nextMonthd; 
#pragma mark -- TargetCalendar
@property (assign, nonatomic) NSInteger targetDay; 
@property (assign, nonatomic) NSInteger targetWeekDay; 
@property (assign, nonatomic) NSInteger targetMonth; 
@property (strong, nonatomic) NSArray* targetDays; 
@property (strong, nonatomic) NSArray* targetWeekDays; 
@property (strong, nonatomic) NSDictionary *targetWeekDaysDic; 
- (void)updateTarget;
@property (copy, nonatomic) NSString *yearMonthDay; 
@end
NS_ASSUME_NONNULL_END
