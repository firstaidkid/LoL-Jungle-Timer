//
//  LoLTimerButton.h
//  LoL Jungle Timer
//
//  Created by Steffen Kolb on 01.02.13.
//  Copyright (c) 2013 Steffen Kolb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoLTimerButton : UIView {
    int _counter;
    NSTimer* _countdownTimer;
    UILabel* _cdLabel;
    
    NSString* _label;
    NSNumber* _cd;
    NSNumber* _initCD;
    
    UIButton* _btn;
    
    UIImage* _buttonImageActive;
    UIImage* _buttonImageInactive;
}

@property int state;

- (id) initWithLabel:(NSString*)label withInitCooldown:(NSNumber*)initCD withCooldown:(NSNumber*)cd withActiveImage:(UIImage*)activeImage withInactiveImage:(UIImage*)inactiveImage;
- (void)setInactiveWithCooldown:(NSNumber*)cd;
- (int)getTime;
- (void)setTime:(NSNumber*)cd;
- (void)reset;

@end
