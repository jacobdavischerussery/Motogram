//
//  MGUtility.m
//  Motograms
//
//  Created by Jacob Davis Cherussery on 12/21/15.
//  Copyright © 2015 CodeaTechnologies. All rights reserved.
//

#import "MGUtility.h"

@implementation MGUtility

+ (void)saveImageInDocumentsDirectoryWithImage:(UIImage *)newImage
{
    NSData *imageData = UIImagePNGRepresentation(newImage);
    NSString *profilePicPath = [self getTheProfilePictureImagePath];
    NSLog((@"pre writing to file"));
    
    if (![imageData writeToFile:profilePicPath atomically:NO])
    {
        NSLog((@"Failed to cache image data to disk"));
    }
    else
    {
        NSLog(@"the cachedImagedPath is %@",profilePicPath);
        [self saveTheProfileImagePathWithImagePath:profilePicPath];
    }
}

 + (NSString *)getTheProfilePictureImagePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imagePath =[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",@"profilePic"]];
    
    return imagePath;
}

+ (void)saveTheProfileImagePathWithImagePath:(NSString *)imagePath
{
    [[NSUserDefaults standardUserDefaults]setObject:imagePath forKey:@"cachedImagePath"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+(NSString *)getTheProfileImagePath
{
    NSString *theImagePath = [[NSUserDefaults standardUserDefaults]valueForKey:@"cachedImagePath"];
    return theImagePath;
}
@end
