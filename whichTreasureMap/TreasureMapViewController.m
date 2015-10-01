//
//  ViewController.m
//  whichTreasureMap
//
//  Created by Gary Riches on 01/10/2015.
//  Copyright (c) 2015 Gary Riches. All rights reserved.
//

#import "TreasureMapViewController.h"
#import "DownloadManager.h"
#import "DirectionManagedObjectContext.h"
#import "AppDelegate.h"
#import "NavigationCAShapeLayer.h"

#define movementUnit

@interface TreasureMapViewController ()

@property (nonatomic, weak) AppDelegate *appDelegate;

@end

@implementation TreasureMapViewController

#pragma mark - CoreData methods -
- (NSArray *)resultsFromCoreData {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Direction" inManagedObjectContext:self.appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    NSError *error = nil;
    NSArray *result = [self.appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"Unable to execute fetch request.");
        NSLog(@"%@, %@", error, error.localizedDescription);
        
    } else {
        
        if (result.count) {
            return result;
        }
    }
    
    return nil;
}

#pragma mark - Boilerplate -
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.appDelegate = [UIApplication sharedApplication].delegate;
    
    // Get the cached data
    NSArray *cachedDirections = [self resultsFromCoreData];
    
    // Download the directions if required
    if (cachedDirections == nil) {
        
        DownloadManager *downloadManager = [[DownloadManager alloc] init];
        [downloadManager downloadAndParseListOfDirectionsWithCompletion:^(BOOL success, NSArray *downloadedDirections) {
           
            // Draw the dotted line onthe main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                CAShapeLayer *shapeLayer = [[NavigationCAShapeLayer alloc] initWithDirections:downloadedDirections];
                [self.view.layer addSublayer:shapeLayer];
            });
        }];
    } else {
        
        // Draw the dotted line
        CAShapeLayer *shapeLayer = [[NavigationCAShapeLayer alloc] initWithDirections:cachedDirections];
        [self.view.layer addSublayer:shapeLayer];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
