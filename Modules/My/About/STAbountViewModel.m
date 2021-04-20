#import "STAbountViewModel.h"
@implementation STAbountViewModel
- (NSArray<STAbountModel *> *)listArray {
    if (!_listArray) {
        NSArray* array = @[@{@"title": @"Official website",
                             @"detail": @"https://www.jianshu.com/p/103cde272183",
                               },
                           @{@"title": @"App version",
                             @"detail": @"V1.0.0",
                             },
                           @{@"title": @"App Rates",
                             @"detail": @"Thank you very much for using our App, if you like easy small goals, just click to go to the comment page to comment!",
                             },
                           ];
        _listArray = [STAbountModel mj_objectArrayWithKeyValuesArray:array];
    }
    return _listArray;
}
@end
@implementation STAbountModel
@end
