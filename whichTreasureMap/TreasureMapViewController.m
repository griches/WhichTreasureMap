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
#import "Defines.h"

@interface TreasureMapViewController ()

@property (nonatomic, weak) AppDelegate *appDelegate;

@end

@implementation TreasureMapViewController

#pragma mark - Helper methods -
- (void)showTreasureBeTharAtLocation:(CGPoint)point afterDuration:(float)duration {
    UIImageView *treasureBeThar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"treasure"]];
    point.y += treasureBeThar.image.size.height / 2;
    treasureBeThar.center = point;
    [self.view addSubview:treasureBeThar];
    
    treasureBeThar.alpha = 0;
    
    [UIView animateWithDuration:1.0f delay:duration options:UIViewAnimationOptionCurveEaseInOut animations:^(){
        treasureBeThar.alpha = 1.0f;
    } completion:nil];
}

#pragma mark - CoreData methods -
- (NSMutableArray *)resultsFromCoreData {
    
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
            
            // Convert from core data entris to straight string so we can use tests easily
            NSMutableArray *directions = [NSMutableArray array];
            for (NSUInteger i = 0; i < result.count; i++) {
                
                DirectionManagedObjectContext *directionManagedObjectContext = result[i];
                [directions addObject:directionManagedObjectContext.direction];
            }
            
            return directions;
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
    
    __block CGPoint finalDestination = CGPointZero;
    
    // Download the directions if required
    if (cachedDirections == nil) {
        
        DownloadManager *downloadManager = [[DownloadManager alloc] init];
        [downloadManager downloadAndParseListOfDirectionsWithCompletion:^(BOOL success, NSArray *downloadedDirections) {
            
            CAShapeLayer *shapeLayer = [[NavigationCAShapeLayer alloc] initWithDirections:downloadedDirections andFinalPoint:&finalDestination];
           
            // Draw the dotted line onthe main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.view.layer addSublayer:shapeLayer];
                
                [self showTreasureBeTharAtLocation:finalDestination afterDuration:kAnimationDuration];
            });
        }];
    } else {
        
        // Draw the dotted line
        CAShapeLayer *shapeLayer = [[NavigationCAShapeLayer alloc] initWithDirections:cachedDirections andFinalPoint:&finalDestination];
        [self.view.layer addSublayer:shapeLayer];
        
        [self showTreasureBeTharAtLocation:finalDestination afterDuration:kAnimationDuration];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
