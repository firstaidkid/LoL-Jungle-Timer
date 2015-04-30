//
//  LoLTimerLabel.m
//  Jungle Timer
//
//  Created by Steffen Kolb on 02.02.13.
//  Copyright (c) 2013 Steffen Kolb. All rights reserved.
//

#import "LoLTimerLabel.h"

@implementation LoLTimerLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.text = @"00:00";
        self.backgroundColor = [UIColor clearColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor whiteColor];
        [self setFont:[UIFont fontWithName:@"BodoniSvtyTwoITCTT-Book" size:56.0]];
    }
    return self;
}

- (void)advanceTimer:(NSTimer *)timer
{
    _counter = (_counter +1);

    [self setText:[self convertTime:_counter]];
}

- (void)start {
    _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                       target:self
                                                     selector:@selector(advanceTimer:)
                                                     userInfo:nil
                                                      repeats:YES];
}

- (void)pause {
    if([_countdownTimer isValid]) {
        [_countdownTimer invalidate];
    }
}

- (void)stop {
    if([_countdownTimer isValid]) {
        [_countdownTimer invalidate];
    }
    
    _counter = 0;
    self.text = @"00:00";
}


- (void)reset {
    [self stop];
    [self start];
}

- (void)changeTimeTo:(int)time {
    _counter = time;
}

-(int)getTime {
    return _counter;
}

- (NSString*) convertTime:(int)time {
    NSMutableString* result = [NSMutableString stringWithCapacity:8];
    int leftOver = _counter;
    
    int hours = leftOver / 3600;
    leftOver = leftOver % 3600;
    
    int minutes = leftOver / 60;
    leftOver = leftOver % 60;
    
    int seconds = leftOver;
    
    if(hours > 0) {
        [result appendFormat:@"%d:",hours];
    }
    
    if(minutes < 10) {
        [result appendFormat:@"0%d:",minutes];
    }
    else {
        [result appendFormat:@"%d:",minutes];
    }
    
    if(seconds < 10) {
        [result appendFormat:@"0%d",seconds];
    }
    else {
        [result appendFormat:@"%d",seconds];        
    }
    
    return result;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
