//
//  Position.m
//  ToyRobot
//
//  Created by Gerald on 29/01/2015.
//  Copyright (c) 2015 geraldkim. All rights reserved.
//

#import "Position.h"

@implementation Position

- (id)initWithXPos:(NSInteger)xPos yPos:(NSInteger)yPos face:(FaceType)face {
    if (self = [super init]) {
        self.x = xPos;
        self.y = yPos;
        self.face = face;
    }
    return self;
}

#pragma mark - Movement methods

- (BOOL)canMoveForward {
    // Verify that a move forward doesn't go off the table
    switch (self.face) {
        case FaceNorth:
            if (self.y >= MAX_Y) return NO;
            break;
        case FaceSouth:
            if (self.y <= 0) return NO;
            break;
        case FaceWest:
            if (self.x <= 0) return NO;
            break;
        case FaceEast:
            if (self.x >= MAX_X) return NO;
            break;
        default:
            break;
    }
    return YES;
}

- (BOOL)moveForward {
    BOOL isSuccess = [self canMoveForward];
    if (isSuccess) {
        switch (self.face) {
            case FaceNorth:
                self.y++;
                break;
            case FaceSouth:
                self.y--;
                break;
            case FaceWest:
                self.x--;
                break;
            case FaceEast:
                self.x++;
                break;
            default:
                break;
        }
    }
    return isSuccess;
}

- (void)turnLeft {
    // Enum is arranged counterclockwise so only need to special case right to up
    if (self.face == FaceEast) {
        self.face = FaceNorth;
        return;
    } else {
        self.face++;
    }
}

- (void)turnRight {
    // Enum is arranged counterclockwise so only need to special case up to right
    if (self.face == FaceNorth) {
        self.face = FaceEast;
    } else {
        self.face--;
    }
}

@end
