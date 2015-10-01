//
//  DownloadManager.h
//  whichTreasureMap
//
//  Created by Gary Riches on 01/10/2015.
//  Copyright (c) 2015 Gary Riches. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadManager : NSObject

- (void)downloadAndParseListOfDirectionsWithCompletion:(void (^)(BOOL success, NSArray *directionCoreDataObjects))completionBlock;

@end
