//
//  NavigationCAShapeLayer.m
//  whichTreasureMap
//
//  Created by Gary Riches on 01/10/2015.
//  Copyright (c) 2015 Gary Riches. All rights reserved.
//

#import "NavigationCAShapeLayer.h"
#import <UIKit/UIKit.h>
#import "Defines.h"

@implementation NavigationCAShapeLayer

#pragma mark - Boilerplate -
- (instancetype)initWithDirections:(NSArray *)directions andFinalPoint:(CGPoint *)finalDestination
{
    self = [super init];
    if (self) {
        
        NSString *currentDirection = kNorth;

        UIBezierPath *path = [UIBezierPath bezierPath];
        
        // Loop through direction array and build coordinates
        // Get the application frame
        CGRect frame = [UIScreen mainScreen].applicationFrame;
        
        // A unit for measurement will be N% width of the screen
        float unit = frame.size.width * 0.12f;
        
        if ([[[NSProcessInfo processInfo] arguments] containsObject:@"-BBGTesting"]) {
            unit = 10;
        }
        
        // Make the starting point
        float posY = frame.size.height * 0.84f;
        float posX = frame.size.width * 0.10f;
        
        if ([[[NSProcessInfo processInfo] arguments] containsObject:@"-BBGTesting"]) {
            posY = 0.0f;
            posX = 0.0f;
        }
        
        [path moveToPoint:CGPointMake(posX, posY)];

        // Build the path to draw to
        for (NSUInteger i = 0; i < directions.count; i++) {
            
            // Is the command forward or a turn?
            if ([directions[i] isEqualToString:kForward]) {
                
                if ([currentDirection isEqualToString:kNorth]) {
                    posY -= unit;
                } else if ([currentDirection isEqualToString:kSouth]) {
                    posY += unit;
                } else if ([currentDirection isEqualToString:kEast]) {
                    posX += unit;
                } else if ([currentDirection isEqualToString:kWest]) {
                    posX -= unit;
                }
                
                [path addLineToPoint:CGPointMake(posX, posY)];
            } else {
             
                if ([currentDirection isEqualToString:kNorth]) {
                    if ([directions[i] isEqualToString:kLeft]) {
                        currentDirection = kWest;
                    } else if ([directions[i] isEqualToString:kRight]) {
                        currentDirection = kEast;
                    }
                } else if ([currentDirection isEqualToString:kSouth]) {
                    if ([directions[i] isEqualToString:kLeft]) {
                        currentDirection = kEast;
                    } else if ([directions[i] isEqualToString:kRight]) {
                        currentDirection = kWest;
                    }
                } else if ([currentDirection isEqualToString:kEast]) {
                    if ([directions[i] isEqualToString:kLeft]) {
                        currentDirection = kNorth;
                    } else if ([directions[i] isEqualToString:kRight]) {
                        currentDirection = kSouth;
                    }
                } else if ([currentDirection isEqualToString:kWest]) {
                    if ([directions[i] isEqualToString:kLeft]) {
                        currentDirection = kSouth;
                    } else if ([directions[i] isEqualToString:kRight]) {
                        currentDirection = kNorth;
                    }
                }
            }
        }
        
        finalDestination->x = posX;
        finalDestination->y = posY;
        
        self.path = path.CGPath;
        self.fillColor = [UIColor clearColor].CGColor;
        self.strokeColor = [UIColor darkGrayColor].CGColor;
        self.lineWidth = 2.0f;
        self.lineDashPattern = @[@10,@4];
        
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = kAnimationDuration;
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        [self addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    }
    return self;
}

- (BOOL)isRunningUnitTests {
    NSString *XPCServiceName = [NSProcessInfo processInfo].environment[@"XPC_SERVICE_NAME"];
    BOOL isTesting = ([XPCServiceName rangeOfString:@"xctest"].location != NSNotFound);
    
    return isTesting;
}

@end
