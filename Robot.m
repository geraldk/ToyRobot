//
//  Robot.m
//  ToyRobot
//
//  Created by Gerald on 29/01/2015.
//  Copyright (c) 2015 geraldkim. All rights reserved.
//

#import "Robot.h"

@implementation Robot

- (NSString *)description {
    return [NSString stringWithFormat:@"(%li, %li, %i)", (long)self.currentPosition.x, (long)self.currentPosition.y, self.currentPosition.face];
}

@end
