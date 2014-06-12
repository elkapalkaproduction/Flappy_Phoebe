//
//  ViewController.m
//  Neoniks
//
//  Created by Andrei Vidrasco on 2/11/14.
//  Copyright (c) 2014 Andrei Vidrasco. All rights reserved.
//

#import "LogoViewController.h"
#import "RootViewController.h"
#import "AppController.h"
#import "cocos2d.h"

#define IS_PHONE [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone

#define IS_PHONE5 [UIScreen mainScreen].bounds.size.height == 568

#define IS_PHONE4 [UIScreen mainScreen].bounds.size.height != 568 && IS_PHONE

@interface LogoViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *logoImageView;

@end

@implementation LogoViewController

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"AVPreferedLanguage"] isEqualToString:@"RUS"]) {
        [_logoImageView setImage:[UIImage imageNamed:@"logo_rus"]];

    } else {
        [_logoImageView setImage:[UIImage imageNamed:@"logo_eng"]];

    }
    if (IS_PHONE4) {
        [self changeYPos:145 forItem:_logoImageView];
    }

    
}
-(void)changeYPos:(int)y forItem:(id)item{
    [item setFrame:CGRectMake([item frame].origin.x, y, [item frame].size.width, [item frame].size.height)];
}

- (void)viewDidLoad
{
    float timeInterval = 1.f;
    [UIView animateWithDuration:timeInterval delay:timeInterval options:UIViewAnimationOptionCurveEaseIn animations:^{
        _logoImageView.alpha = 1.f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:timeInterval delay:timeInterval options:UIViewAnimationOptionCurveEaseIn animations:^{
            _logoImageView.alpha = 0.f;
        } completion:^(BOOL finished) {
            [self performSelector:@selector(push) withObject:nil afterDelay:timeInterval];
         }];
    }];
    

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
-(void)push{
    
    AppController *rt = (AppController *)[[UIApplication sharedApplication] delegate];
    [rt.window setRootViewController:rt.viewController];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"startCocos" object:nil];
//    cocos2d::CCApplication::sharedApplication()->run();

    [rt.viewController on_launch];


}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
