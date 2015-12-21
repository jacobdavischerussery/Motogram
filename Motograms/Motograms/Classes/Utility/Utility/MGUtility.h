//
//  MGUtility.h
//  Motograms
//
//  Created by Jacob Davis Cherussery on 12/21/15.
//  Copyright © 2015 CodeaTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MGUtility : NSObject

+ (void)saveImageInDocumentsDirectoryWithImage:(UIImage *)newImage;
+(NSString *)getTheProfileImagePath;
@end
