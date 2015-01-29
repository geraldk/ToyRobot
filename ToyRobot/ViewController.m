//
//  ViewController.m
//  ToyRobot
//
//  Created by Gerald on 29/01/2015.
//  Copyright (c) 2015 geraldkim. All rights reserved.
//

#import "ViewController.h"
#import "Robot.h"

@interface ViewController () <UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, strong) NSArray *directionArray;

@property (weak, nonatomic) IBOutlet UITextField *placeXTextField;
@property (weak, nonatomic) IBOutlet UITextField *placeYTextField;
@property (weak, nonatomic) IBOutlet UITextField *placeFaceTextField;

@property (weak, nonatomic) IBOutlet UIView *directionPanelView;
@property (weak, nonatomic) IBOutlet UIView *reportPanelView;

@property (weak, nonatomic) IBOutlet UITextField *reportXTextField;
@property (weak, nonatomic) IBOutlet UITextField *reportYTextField;
@property (weak, nonatomic) IBOutlet UITextField *reportFaceTextField;

@property (nonatomic, strong) Robot *robot;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.directionArray = @[@"North", @"West", @"South", @"East"];
    
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    self.placeFaceTextField.inputView = pickerView;
    
    self.robot = [[Robot alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - FaceType helper methods

- (FaceType)faceTypeFromString:(NSString *)faceString {
    if ([faceString isEqualToString:@"North"]) {
        return FaceNorth;
    } else if ([faceString isEqualToString:@"West"]) {
        return FaceWest;
    } else if ([faceString isEqualToString:@"South"]) {
        return FaceSouth;
    } else if ([faceString isEqualToString:@"East"]) {
        return FaceEast;
    }
    //Just in case
    return FaceNorth;
}

- (NSString *)stringFromFaceType:(FaceType)faceType {
    switch (faceType) {
        case FaceNorth:
            return @"North";
            break;
        case FaceEast:
            return @"East";
            break;
        case FaceSouth:
            return @"South";
            break;
        case FaceWest:
            return @"West";
            break;
        default:
            return @"None";
            break;
    }
}

#pragma mark - Movement actions

- (IBAction)placeButtonTapped:(id)sender {
    // Verify input
    NSInteger xPos = [self.placeXTextField.text integerValue];
    NSInteger yPos = [self.placeYTextField.text integerValue];
    
    if (xPos >= 0 && yPos >= 0
        && xPos <= MAX_X && yPos <= MAX_Y
        && [self.placeFaceTextField.text length] > 0) {
        self.robot.currentPosition = [[Position alloc] initWithXPos:xPos yPos:yPos face:[self faceTypeFromString:self.placeFaceTextField.text]];
    } else {
        [self invalidInputError];
    }
    
    if (self.robot.currentPosition) {
        self.directionPanelView.hidden = NO;
        self.reportPanelView.hidden = NO;
    }
}

- (IBAction)leftButtonTapped:(id)sender {
    [self.robot.currentPosition turnLeft];
}

- (IBAction)moveButtonTapped:(id)sender {
    if (![self.robot.currentPosition moveForward]) {
        [self invalidInputError];
    }
}

- (IBAction)rightButtonTapped:(id)sender {
    [self.robot.currentPosition turnRight];
}

- (IBAction)reportButtonTapped:(id)sender {
    self.reportXTextField.text = [@(self.robot.currentPosition.x) stringValue];
    self.reportYTextField.text = [@(self.robot.currentPosition.y) stringValue];
    self.reportFaceTextField.text = [self stringFromFaceType:self.robot.currentPosition.face];
}

- (IBAction)startFacePicker:(id)sender {
    // Initialize text field with first value
    if ([self.placeFaceTextField.text length] <= 0) {
        self.placeFaceTextField.text = [self.directionArray objectAtIndex:0];
    }
}


- (void)invalidInputError {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Invalid Input" message:@"You have entered an invalid input" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

#pragma mark - UIPickerView DataSource and delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.directionArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.directionArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.placeFaceTextField.text = [self.directionArray objectAtIndex:row];
}

@end
