//
//  BaseViewController.h
//  Motograms
//
//  Created by Jacob Davis Cherussery on 12/19/15.
//  Copyright © 2015 CodeaTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
@property (nonatomic,assign) CGFloat keyboardHeight;
@property (nonatomic,strong) UIImage *backgroundImage;

-(void)keyboardWillShow:(NSNotification *)notification;
-(void) keyboardWillHide:(NSNotification *)notification;
@end
