//
//  ContentProvider.m
//  SampleApp
//
//  Created by Jenkins, Peter on 5/29/14.
//  Copyright (c) 2014 DibiStore. All rights reserved.
//

#import "ContentProvider.h"

@implementation ContentProvider
+ (NSString *)content {
    NSDate *date = [NSDate date];
    NSString *dateString = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterFullStyle];
    NSString *content = dateString;
    NSLog(@"content = \"%@\"", content);
    return content;
}
@end
