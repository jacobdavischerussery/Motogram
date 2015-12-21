//
//  NSString+Extension.h
//  PlatformMobile
//
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

- (BOOL)empty;
- (BOOL)validEmail;
- (BOOL)validName;
- (BOOL)validNameWithSpace;
- (BOOL)validFacebookName;
- (BOOL)validateUrl;
- (BOOL)validateMobile;
- (BOOL)ValidatePhoneWithString:(NSString *)phoneNumber;
- (int) noOfUpperCaseCharacters;
- (int) noOfLowerCaseCharacters;
- (int) noOfDigits;
- (int) noOfSpecialCharacters;

@end
