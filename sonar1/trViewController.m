//
//  trViewController.m
//  sonar1
//
//  Created by lion on 10/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "trViewController.h"
#import "fileOps.h"

@implementation trViewController

@synthesize audioController;
@synthesize btnPlay;
@synthesize btnStop;
@synthesize tf1;
@synthesize tf2;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [audioController initializeAUGraph];
}

- (void)dealloc {
	[audioController release];
    
    [btnPlay release];
    [btnStop release];
    [tf1 release];
    [tf2 release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setBtnPlay:nil];
    [self setBtnStop:nil];
    [self setTf1:nil];
    [self setTf2:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)backgroundTouched:(id)sender
{
    [tf1 resignFirstResponder];
}


- (IBAction)play:(id)sender {
    int freq = 0;
    freq = [self.tf1.text intValue];
    [audioController setFrequency: freq];

    [audioController startAUGraph];
    NSLog(@"%@%@", @"play freq=", self.tf1.text);
    fileOps *file = [[fileOps alloc] init];
    [file writeToStringfile:[@"play\n" mutableCopy]];
    self.tf2.text = @"play";
}

- (IBAction)stop:(id)sender {
    int freq = 0;
    [audioController getFrequency: &freq];
    self.tf1.text = [NSString stringWithFormat: @"%d", freq];

    [audioController stopAUGraph];
    NSLog(@"%@%@", @"stop freq=", self.tf1.text);
    fileOps *file = [[fileOps alloc] init];
    [file writeToStringfile:[@"stop\n" mutableCopy]];
    self.tf2.text = @"stop";
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == tf1)
        [tf1 resignFirstResponder];
    return NO;
}




@end
