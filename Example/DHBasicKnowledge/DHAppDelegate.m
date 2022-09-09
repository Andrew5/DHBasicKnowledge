//
//  DHAppDelegate.m
//  DHBasicKnowledge
//
//  Created by localhost3585@gmail.com on 08/15/2021.
//  Copyright (c) 2021 localhost3585@gmail.com. All rights reserved.
//

#import "DHAppDelegate.h"
@interface DHAppDelegate()

@property (strong, nonatomic) UIButton *button;

@end
@implementation DHAppDelegate

- (UIButton*)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(258, 450, 50, 50);//初始在屏幕上的位置
        [_button setImage:[UIImage imageNamed:@"bcl_btn_whole"] forState:UIControlStateNormal];
        _button.backgroundColor = UIColor.redColor;
    }
    return _button;
}
- (void)createButton{
    if (!_button) {
        _window = [[UIApplication sharedApplication] keyWindow];
        _window.backgroundColor = [UIColor whiteColor];
        [_window addSubview:self.button];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:
                                       self action:@selector(locationChange:)];
        pan.delaysTouchesBegan = YES;
        [_button addGestureRecognizer:pan];
    }
}
- (void)locationChange:(UIPanGestureRecognizer*)p{
    CGFloat HEIGHT=_button.frame.size.height;
    CGFloat WIDTH=_button.frame.size.width;
    CGFloat KScreenWidth = 0;
    CGFloat KScreenHeight = 0;
    CGFloat space = 20;

    KScreenWidth = [UIScreen mainScreen].bounds.size.width;
    KScreenHeight = [UIScreen mainScreen].bounds.size.height;
    BOOL isOver = NO;
    CGPoint panPoint = [p locationInView:[UIApplication sharedApplication].windows[0]];
    CGRect frame = CGRectMake(panPoint.x, panPoint.y, HEIGHT, WIDTH);
    NSLog(@"panPoint.x:%f---panPoint.y:%f", panPoint.x, panPoint.y);
    if(p.state == UIGestureRecognizerStateChanged){
        _button.center = CGPointMake(panPoint.x, panPoint.y);
    }
    else if(p.state == UIGestureRecognizerStateEnded){
        if (panPoint.x + WIDTH > KScreenWidth) {
            frame.origin.x = KScreenWidth - WIDTH-space;
            isOver = YES;
        } else if (panPoint.y + HEIGHT > KScreenHeight) {//底部
            frame.origin.y = KScreenHeight - HEIGHT-space;
            isOver = YES;
        } else if(panPoint.x - WIDTH / 2< 10) {//左边
            frame.origin.x = space;
            isOver = YES;
        } else if(panPoint.y - HEIGHT / 2 < 50) {//顶部
            frame.origin.y = space;
            isOver = YES;
        }
        NSLog(@"endPoint.x:%f---endPoint.y:%f", frame.origin.x, frame.origin.y);
        if (isOver) {
            [UIView animateWithDuration:0.3 animations:^{
                self.button.frame = frame;
            }];
        }
    }
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self performSelector:@selector(createButton) withObject:nil afterDelay:2];
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
