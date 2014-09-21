//
//  iphoneAppDelegate.m
//  iphone
//
//  Created by Walzer on 10-11-16.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"
#import "EAGLView.h"
#import "cocos2d.h"
#import "AppDelegate.h"
#import "RootViewController.h"
#import "SHKConfiguration.h"
#import "SHKFacebook.h"
#import "sk_game_services/sk_game_services.h"
#import <AskingPoint/AskingPoint.h>
#import "TSTapstream.h"
#import "LogoViewController.h"

#define urlAboutNeoniksRus "http://www.neoniki.ru"
#define urlAboutNeoniksEng "http://www.neoniks.com"
#define urlRateOnRusStore         "https://itunes.apple.com/ru/app/neoniks-flying-phoebe/id852553704"
#define urlRateOnUsaStore         "https://itunes.apple.com/us/app/neoniks-flying-phoebe/id852553704"


#define kLanguage @"AVPreferedLanguage"
#define kRussianLanguageTag @"RUS"
#define kEnglishLanguageTag @"ENG"
#define IS_PHONE [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
#define IS_PHONE5 [UIScreen mainScreen].bounds.size.height == 568
#define IS_PHONE4 [UIScreen mainScreen].bounds.size.height != 568 && IS_PHONE

@interface SK_SHKConfigurator : DefaultSHKConfigurator
{
}
@end

@implementation SK_SHKConfigurator
- (NSString*)facebookAppId
{
	return [NSString stringWithUTF8String:sk::game_services::facebook_app_id()];
}
@end


@implementation AppController

#pragma mark -
#pragma mark Application lifecycle

// cocos2d application instance
static AppDelegate s_sharedApplication;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	DefaultSHKConfigurator *configurator = [[[SK_SHKConfigurator alloc] init] autorelease];
	[SHKConfiguration sharedInstanceWithConfigurator:configurator];
    
    //           code
    [ASKPManager startup:@"FAAGAEcBU5CFQlmVe3cup03KHdJcntvlvGO51izQU00="];
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert];
    
    // Tapstream code
    TSConfig *config = [TSConfig configWithDefaults];
    [TSTapstream createWithAccountName:@"neoniks" developerSecret:@"c_9ek3--RY-PeLND6eR4_Q" config:config];
    // Override point for customization after application launch.

    // Add the view controller's view to the window and display.
    window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    
    // Init the EAGLView
    EAGLView *__glView = [EAGLView viewWithFrame: [window bounds]
                                     pixelFormat: kEAGLColorFormatRGB565
                                     depthFormat: GL_DEPTH24_STENCIL8_OES
                              preserveBackbuffer: NO
                                      sharegroup: nil
                                   multiSampling: NO
                                 numberOfSamples: 0];
    [__glView setMultipleTouchEnabled:YES];

    // Use RootViewController manage EAGLView
    _viewController = [[RootViewController alloc] initWithNibName:nil bundle:nil];
    _viewController.wantsFullScreenLayout = YES;
    _viewController.view = __glView;
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
		NSString* preferredLanguage = [NSLocale preferredLanguages][0];
		preferredLanguage = [preferredLanguage isEqualToString:@"ru"] ? kRussianLanguageTag : kEnglishLanguageTag;
    NSLog(@"%@",preferredLanguage);
		[userDefaults setObject:preferredLanguage forKey:kLanguage];
    if (IS_PHONE4) {
    [userDefaults setValue:[NSNumber numberWithInt:3] forKey:@"AVdeviceType"];
    } else if (IS_PHONE5){
        [userDefaults setValue:[NSNumber numberWithInt:2] forKey:@"AVdeviceType"];
    } else {
        [userDefaults setValue:[NSNumber numberWithInt:1] forKey:@"AVdeviceType"];
    }
    if ([preferredLanguage isEqualToString:kRussianLanguageTag]) {
        [userDefaults setObject:[NSString stringWithFormat:@"%s",urlAboutNeoniksRus] forKey:@"AVURLNeoninks"];
        [userDefaults setObject:[NSString stringWithFormat:@"%s",urlRateOnRusStore] forKey:@"AVURLRateNeoninks"];

    } else {
        [userDefaults setObject:[NSString stringWithFormat:@"%s",urlAboutNeoniksEng] forKey:@"AVURLNeoninks"];
        [userDefaults setObject:[NSString stringWithFormat:@"%s",urlRateOnUsaStore] forKey:@"AVURLRateNeoninks"];

    }

    // Set RootViewController to window
    if ( [[UIDevice currentDevice].systemVersion floatValue] < 6.0)
    {
        // warning: addSubView doesn't work on iOS6
        [window addSubview: _viewController.view];
    }
    else
    {
        // use this method on ios6
        [window setRootViewController:_viewController];
    }
    
    [window makeKeyAndVisible];
    
    [[UIApplication sharedApplication] setStatusBarHidden:true];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startCocos) name:@"playBGMusic" object:nil];
    cocos2d::CCApplication::sharedApplication()->run();
    
//	[_viewController on_launch];
	
    return YES;
}
-(void)startCocos{
    NSLog(@"fuck yeah");

}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
    cocos2d::CCDirector::sharedDirector()->pause();
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    cocos2d::CCDirector::sharedDirector()->resume();
	[SHKFacebook handleDidBecomeActive];
	
#ifdef FreeVersion
	Chartboost *cb = [Chartboost sharedChartboost];
	
	cb.appId        = [NSString stringWithUTF8String:sk::game_services::get_cb_app_id()];
	cb.appSignature = [NSString stringWithUTF8String:sk::game_services::get_cb_app_signature()];
	
	cb.delegate = _viewController;
	[cb startSession];
	[cb cacheInterstitial];
	[cb cacheMoreApps];
    NSString *revmobID = [NSString stringWithUTF8String:sk::game_services::get_revmob_app_id()];
    [RevMobAds startSessionWithAppID:revmobID];
#endif

    [ASKPManager requestCommandsWithTag:@"Open App"];
	
//#ifndef SK_PAID
//    if (!sk::game_services::is_ads_removed()) {
//        [[RevMobAds session] showFullscreen];
//        [cb showInterstitial];
//    }
//#endif
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
    cocos2d::CCApplication::sharedApplication()->applicationDidEnterBackground();
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
    cocos2d::CCApplication::sharedApplication()->applicationWillEnterForeground();
}

- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
	[SHKFacebook handleWillTerminate];
}

- (BOOL)handleOpenURL:(NSURL*)url
{
    NSString* scheme = [url scheme];
    NSString* prefix = [NSString stringWithFormat:@"fb%@", SHKCONFIG(facebookAppId)];
    if ([scheme hasPrefix:prefix])
        return [SHKFacebook handleOpenURL:url];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [self handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [self handleOpenURL:url];
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
	cocos2d::CCDirector::sharedDirector()->purgeCachedData();
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
