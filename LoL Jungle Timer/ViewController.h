//
//  ViewController.h
//  LoL Jungle Timer
//
//  Created by Steffen Kolb on 01.02.13.
//  Copyright (c) 2013 Steffen Kolb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoLTimerButton.h"
#import "LoLTimerLabel.h"

@interface ViewController : UIViewController <UIAlertViewDelegate,UIPickerViewDelegate, UIPickerViewDataSource> {
    NSDictionary* _initTimes;
    NSDictionary* _cdTimes;
    
    NSMutableArray *hoursArray;
    NSMutableArray *minsArray;
    NSMutableArray *secsArray;
}

@property (weak, nonatomic) IBOutlet LoLTimerButton *btnBlue1;
@property (weak, nonatomic) IBOutlet LoLTimerButton *btnBlue2;
@property (weak, nonatomic) IBOutlet LoLTimerButton *btnRed1;
@property (weak, nonatomic) IBOutlet LoLTimerButton *btnRed2;
@property (weak, nonatomic) IBOutlet LoLTimerButton *btnDragon;
@property (weak, nonatomic) IBOutlet LoLTimerButton *btnBaron;
@property (weak, nonatomic) IBOutlet LoLTimerLabel *labelMatchTime;
@property (strong, nonatomic) IBOutlet UIPickerView *timePicker;
@property (strong, nonatomic) IBOutlet UIView *timePickerContainer;


- (IBAction)resetHandler:(id)sender;
- (IBAction)changeHandler:(id)sender;
- (IBAction)timePickingCanceled:(id)sender;
- (IBAction)timePickingDone:(id)sender;
- (IBAction)updateTimePicker:(id)sender;

@end
