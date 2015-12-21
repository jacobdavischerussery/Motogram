//
//  AuthenticationViewController.m
//  Motograms
//
//  Created by Jacob Davis Cherussery on 12/19/15.
//  Copyright © 2015 CodeaTechnologies. All rights reserved.
//

#import "MGAuthenticationViewController.h"
#import "MGSocialContainerView.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <TwitterKit/TwitterKit.h>

#import "MGSignupViewController.h"
#import "MGAppController.h"

static NSString * const kClientId = @"390320627914-o7mo29pra35e45hqn1diau8ejgqrke4g.apps.googleusercontent.com";

typedef enum
{
    kLogin,
    kSignup
}AuthenticationType;

#define heightOfButtonContainer 250
#define statusBarHeight 20
#define loginButtonHeight 40
#define loginButtonWidth 100

@interface MGAuthenticationViewController ()<SocialContainerDelegate,GIDSignInUIDelegate>
{
    UIView *curentAuthenticationView;
}
@property (nonatomic,weak) IBOutlet UIView *mainContainerView;
@property (nonatomic,weak) IBOutlet UIView *buttonContainer;
@property (nonatomic,weak) IBOutlet UIView* imageViewContainer;
@property (nonatomic,strong) IBOutlet UIView *loginView;
@property (nonatomic,strong) IBOutlet UIView *signupView;
@property (nonatomic,strong) IBOutlet MGSocialContainerView *socialContainerView;
@property (nonatomic,assign) AuthenticationType selectedAuthenticatedType;

@property (nonatomic,strong) UIButton *loginButton;
@property (nonatomic,strong) UIButton *signupButton;
@property (nonatomic,strong) UIView *backgroundImageContainerView;

@property (nonatomic,strong) NSArray *bgArray;

//login screen items
@property (nonatomic,weak) IBOutlet UITextField *usernameTextField;
@property (nonatomic,weak) IBOutlet UITextField *passwordtextField;


//signup screen
@property (nonatomic,weak) IBOutlet UITextField *emailTextField;

@end

@implementation MGAuthenticationViewController
{
    GIDSignIn *signIn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    signIn = [GIDSignIn sharedInstance];
//    signIn.shouldFetchGooglePlusUser = YES;
//    signIn.shouldFetchGoogleUserID = YES;
//    signIn.shouldFetchGoogleUserEmail = YES;
//    signIn.scopes = @[ kGTLAuthScopePlusLogin ];
//    [GPPSignIn sharedInstance].clientID = kClientId;
//    [GPPSignIn sharedInstance].delegate = self;
    signIn.uiDelegate = self;
   

   
    
}

 - (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initialiseAuthenticationController];

}

-(void)initBgArray
{
    self.bgArray = @[@"signup_BG",@"login_BG"];
}

- (void)initialiseAuthenticationController
{
    [self initBgArray];
    [self setFrameForButtonContainer];
    [self initSocialContainerView];
    [self initImageViewContainer];
    [self makeViewCompatibleForSignUp];
}

- (void)setFrameForImageViewContainer
{
    CGRect tempFrameForImageViewContainer = self.imageViewContainer.frame;
    tempFrameForImageViewContainer.size.width = self.view.frame.size.width;
    self.imageViewContainer.frame = tempFrameForImageViewContainer;
}

- (void)setFrameForButtonContainer
{
    CGRect tempFrameForButtonContainer = self.buttonContainer.frame;
    tempFrameForButtonContainer.size.width = self.view.frame.size.width;
    self.buttonContainer.frame = tempFrameForButtonContainer;
}

- (void)makeViewCompatibleForSignUp
{
    self.selectedAuthenticatedType = kSignup;

    [self removeLoginView];
    [self initSignupView];
    [self commonMethodsUsedWhileTappingOnAuthButtons];
}

- (void)makeViewCompatibleForLogin
{
    self.selectedAuthenticatedType = kLogin;
    [self setFrameForButtonContainer];
    [self removeSignupView];
    [self initLoginView];
    [self commonMethodsUsedWhileTappingOnAuthButtons];
}

- (void)commonMethodsUsedWhileTappingOnAuthButtons
{
    [self dismissKeyboard];
    [self changeTheSelectedStateOfAuthButtonsAccordingly];
    [self setFrameForSocialContainerView];
    [self showBackgroundImageAccordingToSelectionOfAuthentication];
}

-(void)changeTheSelectedStateOfAuthButtonsAccordingly
{
    BOOL isSignUpSelected = (self.selectedAuthenticatedType == kSignup)?YES:NO;
    [self.loginButton setSelected:!isSignUpSelected];
    [self.signupButton setSelected:isSignUpSelected];
}
- (void)removeLoginView{
    if (self.loginView) {
        [self.loginView removeFromSuperview];
        self.loginView = nil;
    }
}

- (void)removeSignupView
{
    if (self.signupView) {
        [self.signupView removeFromSuperview];
        self.signupView = nil;
    }
}
-(void)showBackgroundImageAccordingToSelectionOfAuthentication
{
    
    __weak  MGAuthenticationViewController* weakSelf = self;
    CGFloat xPosition = (self.selectedAuthenticatedType == kSignup)?0:-self.backgroundImageContainerView.frame.size.width/2;
    CGRect tempFrameForBGContainer = self.backgroundImageContainerView.frame;
    tempFrameForBGContainer.origin.x = xPosition;
    
    [UIView animateWithDuration:1.0 animations:^{
        weakSelf.backgroundImageContainerView.frame = tempFrameForBGContainer;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma  mark - View Creation Methods

- (void)initImageViewContainer
{
    CGFloat xPosition = 0;
    
    [self setFrameForImageViewContainer];
    
    self.backgroundImageContainerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * [self.bgArray count], self.view.frame.size.height - heightOfButtonContainer + 64)];
    
    for (int i = 0; i < [self.bgArray count]; i ++) {
        xPosition = i * self.view.frame.size.width + 4;
        UIImageView *backGroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(xPosition, 0, self.view.frame.size.width, self.view.frame.size.height - heightOfButtonContainer + 64)];
        NSString *imageName = [self.bgArray objectAtIndex:i];
        UIImage *imageToDisplay = [UIImage imageNamed:imageName];
        [backGroundImageView setImage:imageToDisplay];
        
        [self.backgroundImageContainerView addSubview:backGroundImageView];
    }
    
    [self.imageViewContainer addSubview:self.backgroundImageContainerView];
    
    
    UIImageView *logoImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 51,self.imageViewContainer.frame.size.height/2 - 41 - 30, 102,  41)];
    [logoImageView setImage:[UIImage imageNamed:@"MotogramLogo"]];
    [self.imageViewContainer addSubview:logoImageView];
    
    [self createAuthenticationButtons];
}

-(void)createAuthenticationButtons
{
    [self createLoginButton];
    [self createSignUpButton];
}

-(void)createSignUpButton
{
    self.signupButton = [self getButtonforAuthenticationWithxPosition:50];
    [self.signupButton setTitle:@"SIGN UP" forState:UIControlStateNormal];
    [self.signupButton addTarget:self action:@selector(signupButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}

-(void)createLoginButton
{
    self.loginButton = [self getButtonforAuthenticationWithxPosition:self.view.frame.size.width - loginButtonWidth - 50];
    [self.loginButton setTitle:@"LOGIN" forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}

-(UIButton *)getButtonforAuthenticationWithxPosition:(CGFloat)xPosition
{
    UIButton *authButton =  [[UIButton alloc]initWithFrame:CGRectMake(xPosition, self.view.frame.size.height - heightOfButtonContainer  - loginButtonHeight - 10 + 64, loginButtonWidth, loginButtonHeight)];
    
    UIControlContentHorizontalAlignment alignment = (xPosition == 50)?UIControlContentHorizontalAlignmentLeft:UIControlContentHorizontalAlignmentRight;
    
    [authButton setContentHorizontalAlignment:alignment];
    [authButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [authButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [authButton.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [self.imageViewContainer addSubview:authButton];
    
    return authButton;
}


- (void)initSignupView
{
    if (self.signupView) {
        return;
    }
    self.signupView =  [[[NSBundle mainBundle] loadNibNamed:@"MGSignupView" owner:self options:nil]lastObject];
    [self setFrameForSignupView];
    [self.buttonContainer addSubview:self.signupView];
    curentAuthenticationView = self.signupView;
}

- (void)initSocialContainerView
{
    self.socialContainerView =  [[[NSBundle mainBundle] loadNibNamed:@"MGSocialContainerView" owner:self options:nil]lastObject];
    self.socialContainerView.delegate = self;
    [self.buttonContainer addSubview:self.socialContainerView];
}

-(void)initLoginView
{
    if (self.loginView) {
        return;
    }
    self.loginView =  [[[NSBundle mainBundle] loadNibNamed:@"MGLoginView" owner:self options:nil]lastObject];
    [self setFrameForLoginView];
    [self.buttonContainer addSubview:self.loginView];
    curentAuthenticationView = self.loginView;

}
#pragma  mark - Frame Setting Methods

- (void)setFrameForSignupView
{
    CGRect tempSignUpFrame = self.signupView.frame;
    tempSignUpFrame.origin.x = 0;
    tempSignUpFrame.origin.y = 0;
    tempSignUpFrame.size.width = self.view.frame.size.width;
    self.signupView.frame = tempSignUpFrame;
}

- (void)setFrameForLoginView
{
    CGRect tempLoginFrame = self.loginView.frame;
    tempLoginFrame.origin.x = 5;
    tempLoginFrame.origin.y = 0;
    tempLoginFrame.size.width = self.view.frame.size.width;
    self.loginView.frame = tempLoginFrame;
}


- (void)setFrameForSocialContainerView
{
    CGFloat yPosition = (self.selectedAuthenticatedType == kSignup)?self.signupView.frame.origin.y + self.signupView.frame.size.height : self.loginView.frame.origin.y + self.loginView.frame.size.height ;
    
    CGRect tempSocialContainerFrame = self.socialContainerView.frame;
    tempSocialContainerFrame.origin.x = 0;
    tempSocialContainerFrame.origin.y = yPosition;
    tempSocialContainerFrame.size.width = self.view.frame.size.width;
    self.socialContainerView.frame = tempSocialContainerFrame;
}

#pragma mark - Button Actions

- (void)signupButtonClicked
{
    [self makeViewCompatibleForSignUp];
}

- (void)loginButtonClicked
{
    [self makeViewCompatibleForLogin];
}

#pragma mark - Methods to override

-(BOOL)isNavigationBarRequired
{
    return NO;
}

#pragma mark - Delegate Methods

- (void)clickedOnFacebookButtonToLoginInView:(MGSocialContainerView *)socialContainerView
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logOut];
    [login
     logInWithReadPermissions: @[@"public_profile", @"email"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
             [self fetchUserInfo];
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in");
             NSLog(@"Result %@",result);
             [self fetchUserInfo];
         }
     }];
}

#pragma mark - Getting User info from Facebook

-(void)fetchUserInfo
{
    if ([FBSDKAccessToken currentAccessToken])
    {
        NSLog(@"Token is available : %@",[[FBSDKAccessToken currentAccessToken]tokenString]);
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, link, first_name, last_name, picture.type(large), email, birthday, bio ,location ,friends ,hometown , friendlists"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error)
             {
                 NSLog(@"resultis:%@",result);
                 NSLog(@"Email id %@", [result valueForKey:@"email"]);
                 NSLog(@"Full Name %@", [result valueForKey:@"name"]);
                 NSLog(@"User ID %@", [result valueForKey:@"id"]);
                 NSLog(@"User Picture %@", [result valueForKey:@"picture"]);
                 NSLog(@"data %@", [[result valueForKey:@"picture"]valueForKey:@"data"]);
                 NSLog(@"Profile Picture URL  %@", [[[result valueForKey:@"picture"]valueForKey:@"data"]valueForKey:@"url"]);
             }
             else
             {
                 NSLog(@"Error %@",error);
             }
         }];
        
    }
}


- (void)clickedOnTwitterButtonToLoginInView:(MGSocialContainerView *)socialContainerView
{
    
    /*------------------------------------------------------------------
     *  Function Name   :[Twitter sharedInstance]
     *  Purpose         :To get the user details
     *  Parameters      :None
     *  Return Value    :username, userID, profileImageURL
     ------------------------------------------------------------------*/
    [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
        if (session) {
            NSLog(@"signed in as %@", [session userName]);
            NSLog(@"User ID %@", [session userID]);
            [[[Twitter sharedInstance] APIClient] loadUserWithID:session.userID completion:^(TWTRUser *user, NSError *error) {
                NSLog(@"User image URL %@", user.profileImageURL);
            }];
        } else {
            NSLog(@"error: %@", [error localizedDescription]);
        }
    }];
    
}

- (void)clickedOnGooglePlusButtonToLoginInView:(MGSocialContainerView *)socialContainerView
{
   // [self setGooglePlusSetups];
    [self loadSignupViewController];
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
    CGRect tempFrame = self.imageViewContainer.frame;
    tempFrame.origin.x = 0;
    
    CGFloat yValue = (isKeyBoardVisible)? - self.keyboardHeight:0;
    tempFrame.origin.y = yValue;
    
    CGRect tempFrameForAuthneticationView = self.buttonContainer.frame;
    tempFrameForAuthneticationView.origin.x = 0;
    tempFrameForAuthneticationView.origin.y = tempFrame.origin.y + tempFrame.size.height;
    
    [UIView animateWithDuration:1 animations:^{
        self.imageViewContainer.frame = tempFrame;
        self.buttonContainer.frame = tempFrameForAuthneticationView;
    } completion:^(BOOL finished) {
        
    }];

}

-(void)dismissKeyboard
{
    [self.emailTextField resignFirstResponder];
    [self.loginView resignFirstResponder];
    [self.passwordtextField resignFirstResponder];
}


#pragma mark - Set Google Plus Button Action

-(void)setGooglePlusSetups
{
//    GPPSignIn *signIn = [GPPSignIn sharedInstance];
//    signIn.delegate = self;
//    signIn.shouldFetchGoogleUserEmail = YES;
//    signIn.clientID = kClientId;
//    signIn.scopes = [NSArray arrayWithObjects:kGTLAuthScopePlusLogin,nil];
//    signIn.actions = [NSArray arrayWithObjects:@"http://schemas.google.com/ListenActivity",nil];
//    [signIn authenticate];
    
       [signIn signIn];
   
   
}





// Implement these methods only if the GIDSignInUIDelegate is not a subclass of
// UIViewController.

// Stop the UIActivityIndicatorView animation that was started when the user
// pressed the Sign In button
- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error {
    
}

// Present a view that prompts the user to sign in with Google
- (void)signIn:(GIDSignIn *)signIn
presentViewController:(UIViewController *)viewController {
    [self presentViewController:viewController animated:YES completion:nil];
}

// Dismiss the "Sign in with Google" view
- (void)signIn:(GIDSignIn *)signIn
dismissViewController:(UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)loadSignupViewController
{
    MGSignupViewController *signupViewController = (MGSignupViewController*)[[MGAppController sharedManager].mainStoryBoard instantiateViewControllerWithIdentifier:@"MGSignupViewController"];
    [self.navigationController pushViewController:signupViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
