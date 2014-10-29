//
//  ViewController.m
//  prar
//
//  Created by Tan Tran on 10/28/14.
//  Copyright (c) 2014 Tan Tran. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void) alert:(NSString*)title withDetails:(NSString*)details {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message: details
                                                   delegate: nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [PRARManager sharedManagerWithRadarAndSize:self.view.frame.size andDelegate:self];
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CLLocationCoordinate2D locationCoordinates = CLLocationCoordinate2DMake(0.0, 0.0);
    
    [[PRARManager sharedManager] startARWithData:[self getDummyData] forLocation:locationCoordinates];
    
}


#pragma mark - Dummy data
-(NSArray *)getDummyData{
    NSArray *dummyData = @[
                           @{
                               @"id" : @(0),
                               @"lat" : @(-48.02442454554005F),
                               @"long" : @(-222),
                               @"title" : @"Place Num 0"
                               },
                           @{
                               @"id" : @(1),
                               @"lat" : @(7.5278965708798568F),
                               @"long" : @(207.3884705083325F),
                               @"title" : @"Place Num 1"
                               },
                           @{
                               @"id" : @(2),
                               @"lat" : @(88.00517389006646F),
                               @"long" : @(-307.6122395161201F),
                               @"title" : @"Place Num 2"
                               }
                           ];
    return dummyData;
}


#pragma mark - PRAR delegate
- (void)prarDidSetupAR:(UIView *)arView withCameraLayer:(AVCaptureVideoPreviewLayer *)cameraLayer andRadarView:(UIView *)radar
{
    [self.view.layer addSublayer:cameraLayer];
    [self.view addSubview:arView];
    
    [self.view bringSubviewToFront:[self.view viewWithTag:AR_VIEW_TAG]];
    
    [self.view addSubview:radar];
    
}
- (void)prarUpdateFrame:(CGRect)arViewFrame
{
    [[self.view viewWithTag:AR_VIEW_TAG] setFrame:arViewFrame];
    
}

-(void)prarGotProblem:(NSString *)problemTitle withDetails:(NSString *)problemDetails
{
    [self alert:problemTitle withDetails:problemDetails];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
