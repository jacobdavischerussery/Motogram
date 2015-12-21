//
//  SocialContainerView.h
//  Motograms
//
//  Created by Jacob Davis Cherussery on 12/19/15.
//  Copyright © 2015 CodeaTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MGSocialContainerView;

@protocol SocialContainerDelegate <NSObject>

- (void)clickedOnFacebookButtonToLoginInView:(MGSocialContainerView *)socialContainerView;
- (void)clickedOnTwitterButtonToLoginInView:(MGSocialContainerView *)socialContainerView;
- (void)clickedOnGooglePlusButtonToLoginInView:(MGSocialContainerView *)socialContainerView;

@end

@interface MGSocialContainerView : UIView
@property (nonatomic,weak) id<SocialContainerDelegate>delegate;
@end
