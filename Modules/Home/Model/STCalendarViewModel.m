#import "STCalendarViewModel.h"
@implementation STCalendarViewModel
- (NSInteger)getCurrentMonthForDays
{
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSRange range = [currentCalendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
    NSUInteger numberOfDaysInMonth = range.length;
    NSLog(@"nsrange = %@----- %ld",NSStringFromRange(range),range.location);
    return numberOfDaysInMonth;
}
-(NSDate *)getAMonthframDate:(NSDate*)date months:(NSInteger)number {
    NSCalendarUnit dayInfoUnits  = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *components = [_calendar components: dayInfoUnits fromDate:date];
    components.day = 1;
    if (number!=0) {
        components.month += number;
    }
    NSDate* nextDate =[_calendar dateFromComponents:components];
    return nextDate;
}
-(void)getNextNMonthForDays:(NSDate * )date
{
    NSInteger monthNum =[[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
    NSMutableArray* tempArray = NSMutableArray.new;
    for (NSInteger i = 0;i < monthNum ; i++) {
        [tempArray addObject:@(i + 1).stringValue];
    }
    self.currentDay = monthNum;
    self.titleArray = tempArray;
}
- (void)getFirstDayWeekForMonth:(NSDate*)date
{
    NSDateComponents *comps = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday fromDate:date];
    NSInteger weekday = [comps weekday];
    weekday--;
    NSLog(@"[comps weekday] = %ld",(long)weekday);
    if (weekday == 7) {
        self.index = 0;
    } else {
        self.index = weekday;
    }
}
- (NSCalendar *)calendar {
    if (!_calendar) {
       _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    return _calendar;
}
#pragma mark --- TODO: 上面方法不用
- (NSCalendar *)gregorian {
    if (!_gregorian) {
        _gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    return _gregorian;
}
- (NSDate *)currentDate {
    if (!_currentDate) {
        _currentDate = [NSDate date];
    }
    return _currentDate;
}
- (NSDate *)showDate {
    if (!_showDate) {
        _showDate = self.currentDate;
    }
    return _showDate;
}
- (void)update {
    NSInteger year = [self.gregorian component:NSCalendarUnitYear fromDate:self.showDate];
    NSInteger month = [self.gregorian component:NSCalendarUnitMonth fromDate:self.showDate];
    NSInteger day = [self.gregorian component:NSCalendarUnitDay fromDate:self.showDate];
    NSInteger weekDay = [self.gregorian component:NSCalendarUnitWeekday fromDate:self.showDate];
    self.index = --weekDay;
    self.year = year;
    self.month = month;
    self.day = day;
    self.dayIndex = day + self.index - 1; 
    NSInteger monthNum = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self.showDate].length;
    NSMutableArray* tempArray = NSMutableArray.new;
    for (NSInteger i = 0;i < monthNum ; i++) {
        [tempArray addObject:@(i + 1).stringValue];
    }
    self.titleArray = tempArray;
    NSInteger currentYear = [self.gregorian component:NSCalendarUnitYear fromDate:self.currentDate];
    NSInteger currentMonth = [self.gregorian component:NSCalendarUnitMonth fromDate:self.currentDate];
    if (currentYear == year && currentMonth == month) {
        self.isShowCurrentMonth = YES;
    } else
    {
        self.isShowCurrentMonth = NO;
    }
}
- (void)lastMonthd {
    self.showDate = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:-1 toDate:self.showDate options:0];
    [self update];
}
- (void)nextMonthd {
    self.showDate = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:self.showDate options:0];
    [self update];
}
- (NSString *)yearMonthDay {
    if (!_yearMonthDay) {
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        _yearMonthDay = [formatter stringFromDate:self.currentDate];
    }
    return _yearMonthDay;
}
#pragma mark -- TargetCalendar
- (void)updateTarget {
    NSDateComponents* compoents = [self.gregorian components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:self.currentDate];
    self.targetDay = compoents.day; 
    self.targetWeekDay = --compoents.weekday; 
    self.targetMonth = compoents.month; 
    NSMutableArray* tempWeekDayArray = NSMutableArray.new;
    NSMutableArray* tempDayArray = NSMutableArray.new;
    for (NSInteger i = -3; i < 0; i++) {
        NSDate* date =  [self.gregorian dateByAddingUnit:NSCalendarUnitWeekday value:i toDate:self.currentDate options:0];
        NSDateComponents* compoents = [self.gregorian components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:date];
        [tempWeekDayArray addObject:@(--compoents.weekday).stringValue];
        [tempDayArray addObject:@(compoents.day).stringValue];
    }
    [tempWeekDayArray addObject:@(self.targetWeekDay).stringValue];
    [tempDayArray addObject:@(self.targetDay).stringValue];
    for (NSInteger i = 1; i < 4; i++) {
        NSDate* date =  [self.gregorian dateByAddingUnit:NSCalendarUnitWeekday value:i toDate:self.currentDate options:0];
        NSDateComponents* compoents = [self.gregorian components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:date];
        [tempWeekDayArray addObject:@(--compoents.weekday).stringValue];
        [tempDayArray addObject:@(compoents.day).stringValue];
    }
    self.targetWeekDays = tempWeekDayArray.copy;
    self.targetDays = tempDayArray.copy;
}
- (NSDictionary *)targetWeekDaysDic {
    if (!_targetWeekDaysDic) {
        _targetWeekDaysDic = @{
                               @"0": @"Sun",
                               @"1": @"Mon",
                               @"2": @"Tues",
                               @"3": @"Wed",
                               @"4": @"Thur",
                               @"5": @"Fri",
                               @"6": @"Sat",
                               };
    }
    return _targetWeekDaysDic;
}
@end
