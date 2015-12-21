//
//  MGAppController.h
//  Motograms
//
//  Created by Jacob Davis Cherussery on 12/19/15.
//  Copyright © 2015 CodeaTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "CommonConstant.h"


@interface MGAppController : NSObject

@property (nonatomic,assign) LayoutType appLayout;
@property (nonatomic,strong)  UIWindow *appWindow;
@property (nonatomic, strong) UIStoryboard *mainStoryBoard;

+ (MGAppController*)sharedManager;
- (void)initializeMotogram;
@end
