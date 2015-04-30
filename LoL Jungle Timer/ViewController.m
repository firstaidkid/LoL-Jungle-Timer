//
//  ViewController.m
//  LoL Jungle Timer
//
//  Created by Steffen Kolb on 01.02.13.
//  Copyright (c) 2013 Steffen Kolb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    NSArray* timerButtons;
}

#pragma mark - Properties

@synthesize btnBlue1;
@synthesize btnBlue2;
@synthesize btnRed1;
@synthesize btnRed2;
@synthesize btnBaron;
@synthesize btnDragon;
@synthesize labelMatchTime;
@synthesize timePicker;
@synthesize timePickerContainer;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // timePicker
    timePicker.showsSelectionIndicator = YES;
    [timePicker setDataSource: self];
    [timePicker setDelegate: self];
    [timePickerContainer setFrame:CGRectMake( 0.0f, 900, 1024.0f, 260.0f)]; //notice this is OFF screen!
    
    hoursArray = [[NSMutableArray alloc] init];
    minsArray = [[NSMutableArray alloc] init];
    secsArray = [[NSMutableArray alloc] init];
    
    // populate arrays
    NSString *strVal = [[NSString alloc] init];
    
    for(int i=0; i<61; i++)
    {
        strVal = [NSString stringWithFormat:@"%d", i];
        
        //NSLog(@"strVal: %@", strVal);
        
        //Create array with 0-12 hours
        if (i < 13)
        {
            [hoursArray addObject:strVal];
        }
        
        //create arrays with 0-60 secs/mins
        [minsArray addObject:strVal];
        [secsArray addObject:strVal];
    }
    
    
    // set CDs
    _cdTimes = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:
                                                    [NSNumber numberWithInt:420],
                                                    [NSNumber numberWithInt:360],
                                                    [NSNumber numberWithInt:300],
                                                    [NSNumber numberWithInt:300],nil]
                     forKeys:[NSArray arrayWithObjects:@"baron", @"dragon", @"blue", @"red", nil]];
    
    _initTimes =[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:
                                                     [NSNumber numberWithInt:900],
                                                     [NSNumber numberWithInt:150],
                                                     [NSNumber numberWithInt:115],
                                                     [NSNumber numberWithInt:115],nil]
                     forKeys:[NSArray arrayWithObjects:@"baron", @"dragon", @"blue", @"red", nil]];

    [btnBaron initWithLabel:@"Baron"
           withInitCooldown:[_initTimes valueForKey:@"baron"]
               withCooldown:[_cdTimes valueForKey:@"baron"]
            withActiveImage:[UIImage imageNamed:@"ButtonImageBaron.png"]
          withInactiveImage:[UIImage imageNamed:@"ButtonImageBaron_inactive.png"]];
    
    [btnDragon initWithLabel:@"Dragon"
           withInitCooldown:[_initTimes valueForKey:@"dragon"]
               withCooldown:[_cdTimes valueForKey:@"dragon"]
            withActiveImage:[UIImage imageNamed:@"ButtonImageDragon.png"]
          withInactiveImage:[UIImage imageNamed:@"ButtonImageDragon_inactive.png"]];
    
    [btnBlue1 initWithLabel:@"Blue"
           withInitCooldown:[_initTimes valueForKey:@"blue"]
               withCooldown:[_cdTimes valueForKey:@"blue"]
            withActiveImage:[UIImage imageNamed:@"ButtonImageBlue.png"]
          withInactiveImage:[UIImage imageNamed:@"ButtonImageBlue_inactive.png"]];
    
    [btnBlue2 initWithLabel:@"Blue"
           withInitCooldown:[_initTimes valueForKey:@"blue"]
               withCooldown:[_cdTimes valueForKey:@"blue"]
            withActiveImage:[UIImage imageNamed:@"ButtonImageBlue.png"]
          withInactiveImage:[UIImage imageNamed:@"ButtonImageBlue_inactive.png"]];
    
    [btnRed1 initWithLabel:@"Red"
           withInitCooldown:[_initTimes valueForKey:@"red"]
               withCooldown:[_cdTimes valueForKey:@"red"]
            withActiveImage:[UIImage imageNamed:@"ButtonImageRed.png"]
          withInactiveImage:[UIImage imageNamed:@"ButtonImageRed_inactive.png"]];
    
    [btnRed2 initWithLabel:@"Red"
           withInitCooldown:[_initTimes valueForKey:@"red"]
              withCooldown:[_cdTimes valueForKey:@"red"]
           withActiveImage:[UIImage imageNamed:@"ButtonImageRed.png"]
         withInactiveImage:[UIImage imageNamed:@"ButtonImageRed_inactive.png"]];
    
    [labelMatchTime initWithFrame:CGRectMake(0, 0, 150, 150)];
    
    
    // push all elements into the array
    timerButtons = [NSArray arrayWithObjects:btnBaron, btnBlue1, btnBlue2, btnDragon, btnRed1, btnRed2, nil];
    

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Start match" message:@"Do you want to start the match?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    // optional - add more buttons:
    [alert addButtonWithTitle:@"Start"];
    [alert show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TimePicker

//Method to define how many columns/dials to show
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}


// Method to define the numberOfRows in a component using the array.
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent :(NSInteger)component
{
    if (component==0)
    {
        return [hoursArray count];
    }
    else if (component==1)
    {
        return [minsArray count];
    }
    else
    {
        return [secsArray count];
    }
    
}


// Method to show the title of row for a component.
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    switch (component)
    {
        case 0:
            return [hoursArray objectAtIndex:row];
            break;
        case 1:
            return [minsArray objectAtIndex:row];
            break;
        case 2:
            return [secsArray objectAtIndex:row];
            break;
    }
    return nil;
}

-(int)calculateTimeFromPicker
{
    
    NSString *hoursStr = [NSString stringWithFormat:@"%@",[hoursArray objectAtIndex:[timePicker selectedRowInComponent:0]]];
    NSString *minsStr = [NSString stringWithFormat:@"%@",[minsArray objectAtIndex:[timePicker selectedRowInComponent:1]]];
    NSString *secsStr = [NSString stringWithFormat:@"%@",[secsArray objectAtIndex:[timePicker selectedRowInComponent:2]]];
    
    int hoursInt = [hoursStr intValue];
    int minsInt = [minsStr intValue];
    int secsInt = [secsStr intValue];
    
    int result = secsInt + (minsInt*60) + (hoursInt*3600);
    
    return result;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //[labelMatchTime changeTimeTo:[self calculateTimeFromPicker]];
}

- (void)updatePicker {
    int leftOver = [labelMatchTime getTime];
    int hours = leftOver / 3600;
    leftOver = leftOver % 3600;
    
    int minutes = leftOver / 60;
    leftOver = leftOver % 60;
    
    int seconds = leftOver;
    
    [timePicker selectRow:(hours) inComponent:0 animated:YES];
    [timePicker selectRow:(minutes) inComponent:1 animated:YES];
    [timePicker selectRow:(seconds) inComponent:2 animated:YES];
}

#pragma mark - Reset

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self reset];
    }
}

- (void)reset {
    [btnBlue1 reset];
    [btnBlue2 reset];
    [btnRed1 reset];
    [btnRed2 reset];
    [btnDragon reset];
    [btnBaron reset];
    [labelMatchTime reset];
}



#pragma mark - ActionHandler

- (IBAction)resetHandler:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reset match" message:@"Do you want to reset the match?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    // optional - add more buttons:
    [alert addButtonWithTitle:@"Reset"];
    [alert show];
}

- (IBAction)changeHandler:(id)sender {
    [self updatePicker];
    [timePickerContainer setFrame:CGRectMake( 0.0f, 900, 1024.0f, 260.0f)]; //notice this is OFF screen!
    [self.view addSubview:timePickerContainer];
    [UIView beginAnimations:@"animateTableView" context:nil];
    [UIView setAnimationDuration:0.4];
    [timePickerContainer setFrame:CGRectMake( 0.0f, 468, 1024.0f, 260.0f)]; //notice this is ON screen!
    [UIView commitAnimations];
}

- (IBAction)timePickingCanceled:(id)sender {
    [timePickerContainer removeFromSuperview];
}

- (IBAction)timePickingDone:(id)sender {
    // grab current time
    int old = [labelMatchTime getTime];
    // grab new time
    int new = [self calculateTimeFromPicker];
    // calculate the difference
    int dif = old - new;
    
    // update init-time on elements
    for (int i=0; i<timerButtons.count; i=i+1) {
        if([[timerButtons objectAtIndex:i] state] == 1) {
            NSNumber* newTime = [NSNumber numberWithInt:([[timerButtons objectAtIndex:i] getTime] + dif)];
            [[timerButtons objectAtIndex:i] setTime:newTime];
        }
    }
    
    // update label
    [labelMatchTime changeTimeTo:[self calculateTimeFromPicker]];
    
    // remove picker
    [timePickerContainer removeFromSuperview];
}

- (IBAction)updateTimePicker:(id)sender {
    [self updatePicker];
}
@end
