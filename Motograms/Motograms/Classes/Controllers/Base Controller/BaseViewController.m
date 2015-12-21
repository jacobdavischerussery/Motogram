//
//  BaseViewController.m
//  Motograms
//
//  Created by Jacob Davis Cherussery on 12/19/15.
//  Copyright © 2015 CodeaTechnologies. All rights reserved.
//

#import "BaseViewController.h"
#import "MGAppController.h"
#import "CommonConstant.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self registerKeyboardNotifications];
    [self manageNavigationBarForEachController];
    [self loadTheBackgroundImageAccordingToSelectedLayout];
}

#pragma mark - Notifications

-(void)registerKeyboardNotifications
{
    // Register for keyboard appear and disappear notifications.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:)
                                                name:UIKeyboardWillShowNotification
                                              object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:)
                                                name:UIKeyboardWillHideNotification
                                              object:nil];
}

/*---------------------------------------------------------------------------
 *  Function Name   :unregisterKeyboardNotifications
 *  Purpose         :To unregister all keyboard notifications
 *  Parameters      :None
 *  Return Value    :None
 --------------------------------------------------------------------------*/
- (void)unregisterKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - KeyBoardNotification
/*------------------------------------------------------------------
 *  Function Name   :keyboardWillShow
 *  Purpose         :To move up the login screen view when the keyboard is displayed
 *  Parameters      :NSNotification
 *  Return Value    :None
 ------------------------------------------------------------------*/
-(void) keyboardWillShow:(NSNotification *)notification
{
    self.keyboardHeight = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
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
    self.keyboardHeight = 0.0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation Bar Customizing

-(void)manageNavigationBarForEachController
{
    BOOL isNavigationBarRequired = [self isNavigationBarRequired];
    [self.navigationController setNavigationBarHidden:!isNavigationBarRequired animated:YES];
    self.navigationController.navigationBar.tintColor = [UIColor redColor];
    
    if (isNavigationBarRequired) {
        [self createNavigationBarButtons];
    }
}

-(void)createNavigationBarButtons
{
    [self createLeftBarButton];
    [self createRightBarButtons];
}

-(void)createLeftBarButton
{
    self.navigationItem.hidesBackButton = YES;
    
    if ([self isBackbuttonRequired]) {
        [self createBackButton];
    }
    
}
-(void)createRightBarButtons
{

}

-(void)createBackButton
{
    [self.navigationItem setLeftBarButtonItem:nil];
    UIBarButtonItem  *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav-back"]
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(onBackButtonClick)];
    self.navigationItem.leftBarButtonItem = backButton;
}
-(void)onBackButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark  title

-(void)createTitle:(NSString *)title
{
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    if (!titleView) {
        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.backgroundColor = [UIColor clearColor];
     //   titleView.font = [UIFont fontWithName:kABOF_SF_Display_Medium_Font size:32];
        titleView.textColor = [UIColor whiteColor];
        titleView.textAlignment = NSTextAlignmentCenter;
        titleView.text = title;
        self.navigationItem.titleView = titleView;
        [titleView sizeToFit];
    }
}


#pragma mark - Methods to override

-(BOOL)isNavigationBarRequired
{
    return YES;
}

-(BOOL)isBackbuttonRequired
{
    return YES;
}

-(void)loadTheBackgroundImageAccordingToSelectedLayout
{
    switch ([MGAppController sharedManager].appLayout) {
        case kBlackTileLayout:
        {
            self.backgroundImage = [UIImage imageNamed:@"blackLayout"];
        }
            break;
            
        case kRedTileLayout:
        {
            
        }
            break;
        default:
            break;
    }
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
