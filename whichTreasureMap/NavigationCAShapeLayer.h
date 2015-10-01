//
//  NavigationCAShapeLayer.h
//  whichTreasureMap
//
//  Created by Gary Riches on 01/10/2015.
//  Copyright (c) 2015 Gary Riches. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface NavigationCAShapeLayer : CAShapeLayer

- (instancetype)initWithDirections:(NSArray *)directions;

@end
