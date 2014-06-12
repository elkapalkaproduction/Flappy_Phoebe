#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppController : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    
}
@property (strong, nonatomic)RootViewController    *viewController;
@end

