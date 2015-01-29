//
//  ToyRobotTests.m
//  ToyRobotTests
//
//  Created by Gerald on 29/01/2015.
//  Copyright (c) 2015 geraldkim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Robot.h"

@interface ToyRobotTests : XCTestCase

@property (nonatomic, strong) Robot *robot;

@end

@implementation ToyRobotTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.robot = [[Robot alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

// Place a robot at (2, 2, North), turn it Left, and Move it 5 times. Should refuse to fall
- (void)testFallOff{
    self.robot.currentPosition = [[Position alloc] initWithXPos:2 yPos:2 face:FaceNorth];
    [self.robot.currentPosition turnLeft];
    [self.robot.currentPosition moveForward];
    [self.robot.currentPosition moveForward];
    [self.robot.currentPosition moveForward];
    [self.robot.currentPosition moveForward];
    XCTAssertFalse([self.robot.currentPosition moveForward], @"Pass");
}

// Place a robot at (2, 2, North) and move it around a few times. Should land at (1, 1, South)
- (void)testStayOn {
    self.robot.currentPosition = [[Position alloc] initWithXPos:2 yPos:2 face:FaceNorth];
    [self.robot.currentPosition turnLeft];      // (2, 2, West)
    [self.robot.currentPosition moveForward];   // (1, 2, West)
    [self.robot.currentPosition moveForward];   // (0, 2, West)
    [self.robot.currentPosition turnLeft];      // (0, 2, South)
    [self.robot.currentPosition moveForward];   // (0, 1, South)
    [self.robot.currentPosition turnLeft];      // (0, 1, East)
    [self.robot.currentPosition moveForward];   // (1, 1, East)
    [self.robot.currentPosition turnRight];     // (1, 1, South);
    XCTAssertEqual(self.robot.currentPosition.x, 1);
    XCTAssertEqual(self.robot.currentPosition.y, 1);
    XCTAssertEqual(self.robot.currentPosition.face, FaceSouth);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
