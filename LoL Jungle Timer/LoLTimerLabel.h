//
//  LoLTimerLabel.h
//  Jungle Timer
//
//  Created by Steffen Kolb on 02.02.13.
//  Copyright (c) 2013 Steffen Kolb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoLTimerLabel : UILabel {
    int _counter;
    NSTimer* _countdownTimer;
}

- (id)initWithFrame:(CGRect)frame;
-(int)getTime;
- (void)start;
- (void)pause;
- (void)stop;
- (void)reset;
- (void)changeTimeTo:(int)time;

@end
