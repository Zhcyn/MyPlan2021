#import "STMyCenterViewModel.h"
@implementation STMyCenterViewModel
- (NSArray<STMyCenterModel *> *)listArray {
    if (!_listArray) {
        NSArray *array = @[@{
                               @"imageName": @"about_us",
                               @"title": @"About US",
                               @"detail": @"",
                               @"route": @"STAboutUSVC",
                               },
                           @{
                               @"imageName": @"feedback",
                               @"title": @"Feedback",
                               @"detail": @"",
                               @"route": @"STFeedBacksVC",
                               },
                           @{
                               @"imageName": @"grade",
                               @"title": @"Evaluation encouragement",
                               @"detail": @"",
                               @"route": @"App",
                               @"subTitle": @""
                               },
                           ];
        _listArray = [STMyCenterModel mj_objectArrayWithKeyValuesArray:array];
    }
    return _listArray;
}
- (void)setupUserData {
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString* userPath = [documentsDirectory stringByAppendingPathComponent:@"user"];
    if ([fileManager fileExistsAtPath:userPath]) {
    } else {
        [fileManager createFileAtPath:userPath contents:nil attributes:nil];
    }
    NSData* data = [NSData dataWithContentsOfFile:userPath];
    if (data) {
        NSArray* array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (array.count) {
            self.userData = [STUserModel mj_objectArrayWithKeyValuesArray:array].firstObject;
        } else {
            self.userData = [[STUserModel alloc] init];
        }
    } else {
        self.userData = [[STUserModel alloc] init];
    }
}
- (void)saveUserData {
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString* userPath = [documentsDirectory stringByAppendingPathComponent:@"user"];
    NSArray* array = [STUserModel mj_keyValuesArrayWithObjectArray: @[self.userData]];
    NSData* data = array.mj_JSONData;
    [data writeToFile:userPath atomically:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:kMyUserDataNotification object:nil];
}
- (STUserModel *)userData {
    if (!_userData) {
        [self setupUserData];
    }
    return _userData;
}
@end
@implementation STUserModel
- (NSString *)userName {
    if (!_userName) {
        _userName = @"Furture";
    }
    return _userName;
}
@end
@implementation STMyCenterModel
@end
