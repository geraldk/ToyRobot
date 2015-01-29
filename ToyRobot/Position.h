//
//  Position.h
//  ToyRobot
//
//  Created by Gerald on 29/01/2015.
//  Copyright (c) 2015 geraldkim. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    FaceNorth = 0,
    FaceWest,
    FaceSouth,
    FaceEast
} FaceType;

@interface Position : NSObject

#define MAX_X 4
#define MAX_Y 4

@property (nonatomic, assign) NSInteger x;
@property (nonatomic, assign) NSInteger y;
@property (nonatomic, assign) FaceType face;

- (id)initWithXPos:(NSInteger)xPos yPos:(NSInteger)yPos face:(FaceType)face;

- (BOOL)moveForward;
- (void)turnLeft;
- (void)turnRight;

@end
