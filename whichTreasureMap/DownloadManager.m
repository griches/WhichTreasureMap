//
//  DownloadManager.m
//  whichTreasureMap
//
//  Created by Gary Riches on 01/10/2015.
//  Copyright (c) 2015 Gary Riches. All rights reserved.
//

#import "DownloadManager.h"
#import "AppDelegate.h"
#import "DirectionManagedObjectContext.h"

#define dataPath @"http://which-technical-exercise.herokuapp.com/api/gary@bouncingball.mobi/directions"

@interface DownloadManager ()

@property (nonatomic, weak) AppDelegate *appDelegate;

@end

@implementation DownloadManager

#pragma mark - Download methods -
- (void)downloadAndParseListOfDirections {
    
    NSURL *url = [NSURL URLWithString:dataPath];
    
    NSURLSessionDataTask *downloadDataTask = [[NSURLSession sharedSession]
                                              dataTaskWithURL:url
                                              completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                  
                                                  if (error) {
                                                      
                                                    // For the purposes of the demo I will not display any error, just demonstrate that there is a condition to check for it
                                                    NSLog(@"%@", [error localizedDescription]);
                                                  } else {
                                                      
                                                      if (error) {
                                                          NSLog(@"JSON issue. Check JSON validity: %@", [error localizedDescription]);

                                                      } else {
                                                          
                                                          // Parse and store in to core data
                                                          NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                                          NSArray *directions = jsonDictionary[@"directions"];
                                                          
                                                          // Loop through array and create core data entires
                                                          NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Direction" inManagedObjectContext:self.appDelegate.managedObjectContext];
                                                          
                                                          for (NSUInteger i = 0; i < directions.count; i++) {
                                                              
                                                              DirectionManagedObjectContext *newDirection = [[DirectionManagedObjectContext alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.appDelegate.managedObjectContext];
                                                              
                                                              // Get the parsed dictionary
                                                              NSString *direction = directions[i];
                                                              
                                                              newDirection.index = [NSNumber numberWithUnsignedInteger:i];
                                                              newDirection.direction = direction;
                                                          }
                                                          
                                                          NSError *error = nil;
                                                          
                                                          if (![self.appDelegate.managedObjectContext save:&error]) {
                                                              NSLog(@"Unable to save managed object context.");
                                                              NSLog(@"%@, %@", error, error.localizedDescription);
                                                          }
                                                          
                                                          // Return the values to the completion block
                                                      }
                                                  }
                                              }];
    
    [downloadDataTask resume];
}

#pragma mark - Boilerplate -
- (DownloadManager *)init
{
    self = [super init];
    if (self) {
        self.appDelegate = [UIApplication sharedApplication].delegate;
    }
    return self;
}

@end
