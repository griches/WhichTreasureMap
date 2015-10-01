//
//  NavigationCAShapeLayer.m
//  whichTreasureMap
//
//  Created by Gary Riches on 01/10/2015.
//  Copyright (c) 2015 Gary Riches. All rights reserved.
//

#import "NavigationCAShapeLayer.h"
#import <UIKit/UIKit.h>

@implementation NavigationCAShapeLayer

#pragma mark - Boilerplate -
- (instancetype)initWithDirections:(NSArray *)directions
{
    self = [super init];
    if (self) {

        UIBezierPath *path = [UIBezierPath bezierPath];
        
        [path moveToPoint:CGPointMake(50, 50)];
        [path addLineToPoint:CGPointMake(150, 50)];
        
        self.path = path.CGPath;
        self.strokeColor = [UIColor darkGrayColor].CGColor;
        self.lineWidth = 2.0f;
        self.lineDashPattern = @[@10,@4];
        // Animate these
        //    shapeLayer.strokeStart = 0.0f;
        //    shapeLayer.strokeEnd = 1f;
    }
    return self;
}

@end
