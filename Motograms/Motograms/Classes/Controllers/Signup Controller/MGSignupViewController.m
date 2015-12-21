//
//  MGSignupViewController.m
//  Motograms
//
//  Created by Jacob Davis Cherussery on 12/20/15.
//  Copyright © 2015 CodeaTechnologies. All rights reserved.
//

#import "MGSignupViewController.h"
#import "MGUtility.h"

@interface MGSignupViewController ()

@property (nonatomic,weak) IBOutlet UIView *profileImageContainerView;
@property (nonatomic,weak) IBOutlet UIView *textFieldContainerView;

@property (nonatomic,weak) IBOutlet UITextField *userNameTextField;
@property (nonatomic,weak) IBOutlet UITextField *passwordTextField;

@property (nonatomic,weak) IBOutlet UIButton *createAccountButton;

@end

@implementation MGSignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initializeSignUpView];
}

- (void)initializeSignUpView
{
    [self.createAccountButton setBackgroundImage:self.backgroundImage forState:UIControlStateNormal];
    [self.profileImageContainerView setBackgroundColor:[UIColor colorWithPatternImage:self.backgroundImage]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - KeyBoardNotification
/*------------------------------------------------------------------
 *  Function Name   :keyboardWillShow
 *  Purpose         :To move up the login screen view when the keyboard is displayed
 *  Parameters      :None
 *  Return Value    :None
 ------------------------------------------------------------------*/
-(void)keyboardWillShow:(NSNotification *)notification
{
    [super keyboardWillShow:notification];
    [self adjustTheFrameOfTheViewAccordingToKeyboardVisibility:YES];
}

/*------------------------------------------------------------------
 *  Function Name   :keyboardWillHide
 *  Purpose         :To restore the login screen view back to its orginal position
 :when the keyboard disappears
 *  Parameters      :None
 *  Return Value    :None
 ------------------------------------------------------------------*/
-(void) keyboardWillHide:(NSNotification *)notification
{
    [super keyboardWillHide:notification];
    [self adjustTheFrameOfTheViewAccordingToKeyboardVisibility:NO];
}

-(void)adjustTheFrameOfTheViewAccordingToKeyboardVisibility:(BOOL)isKeyBoardVisible
{
    __weak MGSignupViewController* weakSelf = self;
    
    CGRect tempFrameForPicView = self.profileImageContainerView.frame;
    CGFloat yPosition = (isKeyBoardVisible)?-self.keyboardHeight:0;
    tempFrameForPicView.origin.y = yPosition;
    
    CGRect tempFrameForTextField = self.textFieldContainerView.frame;
    tempFrameForTextField.origin.y = tempFrameForPicView.origin.y + tempFrameForPicView.size.height;
    
    [UIView animateWithDuration:1 animations:^{
        weakSelf.profileImageContainerView.frame = tempFrameForPicView;
        weakSelf.textFieldContainerView.frame = tempFrameForTextField;
    } completion:^(BOOL finished) {
        
    }];
}


#pragma mark - Methods to override

-(BOOL)isNavigationBarRequired
{
    return NO;
}

#pragma mark - TextField Delegate Method
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.userNameTextField)
        [self.passwordTextField becomeFirstResponder];
    
    else if (textField == self.passwordTextField)
        [self.passwordTextField resignFirstResponder];
    
    return YES;
}

#pragma mark - Button Actions

 - (IBAction)clickedOnProfilePicButton:(id)sender
{
    NSString *imagePath = [MGUtility getTheProfileImagePath];
    UIImage *customImage = [UIImage imageWithContentsOfFile:imagePath];

}

- (IBAction)clickedOnCreateAccountButton:(id)sender
{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
