//
//  whichTreasureMapTests.m
//  whichTreasureMapTests
//
//  Created by Gary Riches on 01/10/2015.
//  Copyright (c) 2015 Gary Riches. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NavigationCAShapeLayer.h"
#import "DownloadManager.h"

@interface whichTreasureMapTests : XCTestCase

@end

@implementation whichTreasureMapTests



- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPathGeneration {
    
    CGPoint finalDestination = CGPointZero;
    
    (void)[[NavigationCAShapeLayer alloc] initWithDirections:@[@"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward"] andFinalPoint:&finalDestination];
    
    if (finalDestination.x == -10 && finalDestination.y == 10) {
        XCTAssert(YES, @"Pass");
    } else {
        XCTAssert(NO, @"Fail");
    }
}

- (void)testServerResponse {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Download"];
    
    DownloadManager *downloadManager = [[DownloadManager alloc] init];
    [downloadManager downloadAndParseListOfDirectionsWithCompletion:^(BOOL success, NSArray *downloadedDirections) {
        
        if (success) {
            XCTAssert(YES, @"Pass");
            
            [expectation fulfill];
            
        }
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

// Check that our path code isn't too slow with large data sets
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        CGPoint finalDestination = CGPointZero;
        
        (void)[[NavigationCAShapeLayer alloc] initWithDirections:@[@"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward", @"forward", @"left", @"left", @"forward", @"forward", @"right", @"forward"] andFinalPoint:&finalDestination];
    }];
}

@end
