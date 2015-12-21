//
//  MGAppController.m
//  Motograms
//
//  Created by Jacob Davis Cherussery on 12/19/15.
//  Copyright © 2015 CodeaTechnologies. All rights reserved.
//

#import "MGAppController.h"
#import "MGNavigationController.h"

@interface MGAppController ()

@end

@implementation MGAppController

#pragma mark - Singleton method and initialization  -

+ (MGAppController*)sharedManager {
    static MGAppController *appController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appController = [[self alloc] init];
    });
    return appController;
}

- (id)init {
    
    self = [super init];
    if(self) {
        
        self.mainStoryBoard     = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     
    }
    return self;
}

- (void)initializeMotogram
{
    [self loadSignInAndSignUpViewController];
}


- (void)loadSignInAndSignUpViewController
{
    MGNavigationController *navigationController = (MGNavigationController *)[self.mainStoryBoard instantiateViewControllerWithIdentifier:@"MGNavigationController"];
    [self.appWindow setRootViewController:navigationController];
}
@end
