//
//  LoLTimerButton.m
//  LoL Jungle Timer
//
//  Created by Steffen Kolb on 01.02.13.
//  Copyright (c) 2013 Steffen Kolb. All rights reserved.
//

#import "LoLTimerButton.h"

@implementation LoLTimerButton {
    int fontsize;
}

@synthesize state; // 0 = stopped, 1 = init, 2 = normal

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}

- (id) initWithLabel:(NSString*)label withInitCooldown:(NSNumber*)initCD withCooldown:(NSNumber*)cd withActiveImage:(UIImage*)activeImage withInactiveImage:(UIImage*)inactiveImage {
    
    self = [super init];
    if (self) {
        // state
        state = 0;
        
        // assign vars
        _initCD = initCD;
        _cd = cd;
        _label = label;
        _buttonImageActive = activeImage;
        _buttonImageInactive = inactiveImage;
        fontsize = 32;
        
        // remove background
        self.backgroundColor = [UIColor clearColor];
        
        
        // create button
        _btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 283, 190)];
        [_btn setBackgroundImage:_buttonImageActive forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
        [_btn addTarget:self action:@selector(doubleTap:) forControlEvents:UIControlEventTouchDownRepeat];
        [_btn addTarget:self action:@selector(swipe:) forControlEvents:UIControlEventTouchDragOutside];
        
        // create label
        _cdLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 0, 150, 190)];
        _cdLabel.text = _label;
        _cdLabel.backgroundColor = [UIColor clearColor];
        _cdLabel.textAlignment = NSTextAlignmentCenter;
        [self labelActive];
        
        // add views
        [self addSubview:_btn];
        [self addSubview:_cdLabel];
    }
    
    return self;
}

- (void)reset {
    [self setInactiveWithCooldown:_initCD];
    state = 1;
}

- (void)setInactiveWithCooldown:(NSNumber*)cd {
    // no negative CDs alowed
    _counter = [cd intValue] > 0 ? [cd intValue] : 0;
    
    // change label
    [self labelInactive];
    [_cdLabel setText:[self convertTime:_counter]];
    
    // change backgroundimage
    [_btn setBackgroundImage:_buttonImageInactive forState:UIControlStateNormal];
    
    
    if([_countdownTimer isValid]) {
        [_countdownTimer invalidate];
    }
    _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                               target:self
                                                             selector:@selector(advanceTimer:)
                                                             userInfo:nil
                                                              repeats:YES];
}

- (void)advanceTimer:(NSTimer *)timer
{
    //NSLog(@"%d", _counter);
    
    // if timer runs out, activate the button
    if (_counter <= 1) {
        [timer invalidate];
        [self setActive];
    }
    else {
        //decrement counter
        _counter = (_counter -1);
        
        // increase the font-size once we get near to being ready
//        int fontSize = 22;
//        if(_counter < 30) {
//            fontSize = 22 + (fontsize-22) * 1/_counter;
//        }
//        [_cdLabel setFont:[UIFont fontWithName:@"BodoniSvtyTwoITCTT-Book" size:fontSize]];
        [_cdLabel setText:[self convertTime:_counter]];
    }
}

- (void)setActive {
    state = 2;
    if([_countdownTimer isValid]) {
        [_countdownTimer invalidate];
    }
    
    [self labelActive];
    [_cdLabel setText: _label];
    [_btn setBackgroundImage:_buttonImageActive forState:UIControlStateNormal];
}

- (void) setUndefined {
    if([_countdownTimer isValid]) {
        [_countdownTimer invalidate];
    }
    
    [self labelActive];
    [_cdLabel setText: @"?"];
    [_btn setBackgroundImage:_buttonImageInactive forState:UIControlStateNormal];

}

- (void) labelInactive {
    _cdLabel.font = [UIFont fontWithName:@"BodoniSvtyTwoITCTT-Book" size:(fontsize)];
    _cdLabel.textColor = [UIColor colorWithHue:0.8 saturation:0.05 brightness:0.89 alpha:0.3];
}

- (void) labelActive {
    _cdLabel.font = [UIFont fontWithName:@"BodoniSvtyTwoITCTT-Book" size:(fontsize)];
    _cdLabel.textColor = [UIColor colorWithHue:0.8 saturation:0.05 brightness:0.89 alpha:1];
}

- (NSString*) convertTime:(int)time {
    NSMutableString* result = [NSMutableString stringWithCapacity:8];
    int leftOver = _counter;
    
    int minutes = leftOver / 60;
    leftOver = leftOver % 60;
    
    int seconds = leftOver;
    
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

- (IBAction)swipe:(id)sender {
    state = 2;
    [self setUndefined];
}

- (IBAction)touchDown:(id)sender {
    state = 2;
    // start cooldown on pressed button
    [self setInactiveWithCooldown:_cd];
}

- (IBAction)doubleTap:(id)sender {
    state = 2;
    NSLog(@"double pressed");
    [self setActive];
}

- (int)getTime {
    return _counter;
}

- (void)setTime:(NSNumber*)cd {
    _counter = [cd intValue] > 0 ? [cd intValue] : 0;
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
