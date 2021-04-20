#import "STTargetViewModel.h"
@implementation STTargetViewModel
- (NSMutableArray<STTargetModel *> *)listArray {
    if (!_listArray) {
        NSFileManager* fileManager = [NSFileManager defaultManager];
        NSString* document = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString* targetPath = [document stringByAppendingPathComponent: kSTTargetFilesPath];
        if ([fileManager fileExistsAtPath:targetPath]) {
            NSData* data = [NSData dataWithContentsOfFile:targetPath];
            NSArray* array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (array.count) {
                _listArray = [STTargetModel mj_objectArrayWithKeyValuesArray:array];
            } else {
                _listArray = [[NSMutableArray alloc] init];
            }
        } else { 
            NSString* targetPath = [[NSBundle mainBundle] pathForResource:@"JerseyData" ofType:@"json"];
            NSData* data = [NSData dataWithContentsOfFile:targetPath];
            NSArray* array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            _listArray = [STTargetModel mj_objectArrayWithKeyValuesArray:array];
        }
    }
    return _listArray;
}
- (NSMutableArray<STTargetModel *> *)currentDaylistArray {
    if (!_currentDaylistArray) {
        _currentDaylistArray = self.listArray.copy;
    }
    return _currentDaylistArray;
}
- (void)setupCurrentDaylistArray {
    if (self.listArray.count) {
        NSMutableArray* tempArray = NSMutableArray.new;
        for (NSInteger i = 0; i < self.listArray.count; i++) {
            STTargetModel* model = self.listArray[i];
            if ([model.finishWeekDays containsObject:@(self.calendarManger.targetWeekDay).stringValue]) {
                [tempArray addObject:model];
            }
        }
        self.currentDaylistArray = tempArray.mutableCopy;
    } else {
        self.currentDaylistArray = nil;
    }
}
- (STCalendarViewModel *)calendarManger {
    if (!_calendarManger) {
        _calendarManger = [[STCalendarViewModel alloc] init];
        [_calendarManger updateTarget];
    }
    return _calendarManger;
}
@end
@implementation STTargetModel
- (NSMutableArray<NSMutableDictionary *> *)finishrecordS {
    if (!_finishrecordS) {
        STCalendarViewModel* calendar = [[STCalendarViewModel alloc] init];
        NSMutableDictionary* dic = @{
                                     calendar.yearMonthDay: @(NO)
                                     }.mutableCopy;
        _finishrecordS = @[dic].mutableCopy;
    }
    return _finishrecordS;
}
@end
