//
//  SocialContainerView.m
//  Motograms
//
//  Created by Jacob Davis Cherussery on 12/19/15.
//  Copyright © 2015 CodeaTechnologies. All rights reserved.
//

#import "MGSocialContainerView.h"

@implementation MGSocialContainerView

- (IBAction)fbLoginButtonClicked:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickedOnFacebookButtonToLoginInView:)]) {
        [self.delegate clickedOnFacebookButtonToLoginInView:self];
    }
}

- (IBAction)twitterLoginButtonClicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickedOnTwitterButtonToLoginInView:)]) {
        [self.delegate clickedOnTwitterButtonToLoginInView:self];
    }
}


- (IBAction)googlePlusLoginButtonClicked:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickedOnGooglePlusButtonToLoginInView:)]) {
        [self.delegate clickedOnGooglePlusButtonToLoginInView:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
