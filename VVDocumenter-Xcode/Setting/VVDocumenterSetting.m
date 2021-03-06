//
//  VVDocumenterSetting.m
//  VVDocumenter-Xcode
//
//  Created by 王 巍 on 13-8-3.
//  Copyright (c) 2013年 OneV's Den. All rights reserved.
//

#import "VVDocumenterSetting.h"
#import <Carbon/Carbon.h>

NSString *const VVDDefaultTriggerString = @"///";
NSString *const VVDDefaultAuthorString = @"";
NSString *const VVDDefaultDateInfomationFormat = @"YY-MM-dd HH:MM:ss";

NSString *const kVVDUseSpaces = @"com.onevcat.VVDocumenter.useSpaces";
NSString *const kVVDSpaceCount = @"com.onevcat.VVDocumenter.spaceCount";
NSString *const kVVDTriggerString = @"com.onevcat.VVDocumenter.triggerString";
NSString *const kVVDPrefixWithStar = @"com.onevcat.VVDocumenter.prefixWithStar";
NSString *const kVVDPrefixWithSlashes = @"com.onevcat.VVDocumenter.prefixWithSlashes";
NSString *const kVVDAddSinceToComments = @"com.onevcat.VVDocumenter.addSinceToComments";
NSString *const kVVDBriefDescription = @"com.onevcat.VVDocumenter.briefDescription";
NSString *const kVVDUserHeaderDoc = @"com.onevcat.VVDocumenter.useHeaderDoc";
NSString *const kVVDNoBlankLinesBetweenFields = @"com.onevcat.VVDocumenter.noBlankLinesBetweenFields";
NSString *const kVVDNoArgumentPadding = @"com.onevcat.VVDocumenter.noArgumentPadding";
NSString *const kVVDUseAuthorInformation = @"com.onevcat.VVDocumenter.useAuthorInformation";
NSString *const kVVDAuthorInfomation = @"com.onevcat.VVDocumenter.authorInfomation";
NSString *const kVVDUseDateInformation = @"com.onevcat.VVDocumenter.useDateInformation";
NSString *const kVVDDateInformationFormat = @"com.onevcat.VVDocumenter.dateInformationFomat";
@implementation VVDocumenterSetting

+ (VVDocumenterSetting *)defaultSetting
{
    static dispatch_once_t once;
    static VVDocumenterSetting *defaultSetting;
    dispatch_once(&once, ^ {
        defaultSetting = [[VVDocumenterSetting alloc] init];
        
        NSDictionary *defaults = @{kVVDPrefixWithStar: @YES,
                                   kVVDUseSpaces: @YES};
        [[NSUserDefaults standardUserDefaults] registerDefaults:defaults];
    });
    return defaultSetting;
}

-(BOOL) useSpaces
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kVVDUseSpaces];
}

-(void) setUseSpaces:(BOOL)useSpace
{
    [[NSUserDefaults standardUserDefaults] setBool:useSpace forKey:kVVDUseSpaces];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(BOOL) useDvorakLayout
{
    TISInputSourceRef inputSource = TISCopyCurrentKeyboardLayoutInputSource();
    NSString *layoutID = (__bridge NSString *)TISGetInputSourceProperty(inputSource, kTISPropertyInputSourceID);
    CFRelease(inputSource);
    
    if ([layoutID rangeOfString:@"Dvorak" options:NSCaseInsensitiveSearch].location != NSNotFound && ![layoutID containsString:@"QWERTYCMD"]) {
        return YES;
    } else {
        return NO;
    }
}

-(NSInteger) spaceCount
{
    NSInteger count = [[NSUserDefaults standardUserDefaults] integerForKey:kVVDSpaceCount];
    return (count <= 0) ? 2 : count;
}

-(void) setSpaceCount:(NSInteger)spaceCount
{
    if (spaceCount < 1) {
        spaceCount = 1;
    } else if (spaceCount > 10) {
        spaceCount = 10;
    }
    
    [[NSUserDefaults standardUserDefaults] setInteger:spaceCount forKey:kVVDSpaceCount];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString *) triggerString
{
    NSString *s = [[NSUserDefaults standardUserDefaults] stringForKey:kVVDTriggerString];
    if (s.length == 0) {
        s = VVDDefaultTriggerString;
    }
    return s;
}

-(void) setTriggerString:(NSString *)triggerString
{
    if (triggerString.length == 0) {
        [[NSUserDefaults standardUserDefaults] setObject:VVDDefaultTriggerString forKey:kVVDTriggerString];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:triggerString forKey:kVVDTriggerString];
    }

    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(BOOL) prefixWithStar
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kVVDPrefixWithStar];
}

-(void) setPrefixWithStar:(BOOL)prefix
{
    [[NSUserDefaults standardUserDefaults] setBool:prefix forKey:kVVDPrefixWithStar];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(BOOL) prefixWithSlashes
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kVVDPrefixWithSlashes];
}

-(void) setPrefixWithSlashes:(BOOL)prefix
{
    [[NSUserDefaults standardUserDefaults] setBool:prefix forKey:kVVDPrefixWithSlashes];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(BOOL) addSinceToComments
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kVVDAddSinceToComments];
}

-(void) setAddSinceToComments:(BOOL)add
{
    [[NSUserDefaults standardUserDefaults] setBool:add forKey:kVVDAddSinceToComments];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(BOOL) briefDescription
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kVVDBriefDescription];
}

-(void) setBriefDescription:(BOOL)brief
{
    [[NSUserDefaults standardUserDefaults] setBool:brief forKey:kVVDBriefDescription];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(BOOL) useHeaderDoc
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kVVDUserHeaderDoc];
}
-(void) setUseHeaderDoc:(BOOL)use
{
    [[NSUserDefaults standardUserDefaults] setBool:use forKey:kVVDUserHeaderDoc];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(BOOL) blankLinesBetweenSections
{
    return ![[NSUserDefaults standardUserDefaults] boolForKey:kVVDNoBlankLinesBetweenFields];
}
-(void) setBlankLinesBetweenSections:(BOOL)blankLinesBetweenFields
{
    [[NSUserDefaults standardUserDefaults] setBool:!blankLinesBetweenFields forKey:kVVDNoBlankLinesBetweenFields];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(BOOL) alignArgumentComments
{
    return ![[NSUserDefaults standardUserDefaults] boolForKey:kVVDNoArgumentPadding];
}
-(void) setAlignArgumentComments:(BOOL)alignArgumentComments
{
    [[NSUserDefaults standardUserDefaults] setBool:!alignArgumentComments forKey:kVVDNoArgumentPadding];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(BOOL)useAuthorInformation
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kVVDUseAuthorInformation];
}
-(void) setUseAuthorInformation:(BOOL)useAuthorInformation
{
    [[NSUserDefaults standardUserDefaults] setBool:useAuthorInformation forKey:kVVDUseAuthorInformation];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString *)authorInformation {
    NSString *authorInformation = [[NSUserDefaults standardUserDefaults] objectForKey:kVVDAuthorInfomation];
    if (authorInformation == nil ) {
        authorInformation = VVDDefaultAuthorString;
    }
    return authorInformation;
}
-(void)setAuthorInformation:(NSString *)authorInformation {
    [[NSUserDefaults standardUserDefaults] setObject:authorInformation forKey:kVVDAuthorInfomation];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(BOOL)useDateInformation
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kVVDUseDateInformation];
}
-(void) setUseDateInformation:(BOOL)useDateInformation
{
    [[NSUserDefaults standardUserDefaults] setBool:useDateInformation forKey:kVVDUseDateInformation];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString *)dateInformationFormat {
    NSString *formatString = [[NSUserDefaults standardUserDefaults] objectForKey:kVVDDateInformationFormat];
    if (formatString == nil || formatString.length <= 0) {
        formatString = VVDDefaultDateInfomationFormat;
    }
    return formatString;
}
-(void)setDateInformationFormat:(NSString *)dateInformationFormat {
    [[NSUserDefaults standardUserDefaults] setObject:dateInformationFormat forKey:kVVDDateInformationFormat];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString *) spacesString
{
    if ([self useSpaces]) {
        return [@"" stringByPaddingToLength:[self spaceCount] withString:@" " startingAtIndex:0];
    } else {
        return @"\t";
    }
}

@end
