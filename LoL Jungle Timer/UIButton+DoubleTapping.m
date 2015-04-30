//
//  UIDoubleTapButton.m
//  LoL Jungle Timer
//
//  Created by Steffen Kolb on 01.02.13.
//  Copyright (c) 2013 Steffen Kolb. All rights reserved.
//

#import "UIButton+DoubleTapping.h"

@implementation UIButton (DoubleTapping)

- (void) delayedSendAction:(NSDictionary *)parameters
{
	// unpack parameters
	NSString *actionString = [parameters objectForKey:@"action"];
	SEL action = NSSelectorFromString(actionString);
	id target = [parameters objectForKey:@"target"];
	UIEvent *event = [parameters objectForKey:@"event"];
    
	// now actually send the action
	[super sendAction:action to:target forEvent:event];
}

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
	// find out if this is a first tap
	NSString *actionString = NSStringFromSelector(action);
    
	NSString *touchDownMethodName = [[self actionsForTarget:target forControlEvent:UIControlEventTouchDown] lastObject];
	NSString *touchDownRepeatMethodName = [[self actionsForTarget:target forControlEvent:UIControlEventTouchDownRepeat] lastObject];
	NSString *swipeMethodName = [[self actionsForTarget:target forControlEvent:UIControlEventTouchDragOutside] lastObject];
    
	// we assume that there is only one action registered for this control event type
	if ([touchDownMethodName isEqualToString:actionString])
	{
		// we delay first touches
        
		// package everything in dictionary so that we can pass it as single parameter
		NSDictionary *tmpDict = [NSDictionary dictionaryWithObjectsAndKeys:actionString, @"action",
								 target, @"target", event, @"event", nil];
        
		[self performSelector:@selector(delayedSendAction:) withObject:tmpDict afterDelay:0.15];
		return;
	}
	else if ([touchDownRepeatMethodName isEqualToString:actionString])
	{
		// Double Touch, we cancel the delayed request
		[NSObject cancelPreviousPerformRequestsWithTarget:self];
	}
    else if ([swipeMethodName isEqualToString:actionString]) {
		// Swipe, we cancel the delayed request
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
    }
    
	// all other events we simple pass on
	[super sendAction:action to:target forEvent:event];
}
@end