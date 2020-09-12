//
//  main.m
//  Clr2Csv
//
//  Created by Chun Tian on 2020/9/12.
//  Copyright © 2020 Ramon Poca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#include <stdio.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *file;
        NSColorList *list;

        if (argc < 2) {
            NSLog(@"Usage: Clr2Csv filename.clr|Palette");
            exit(-1);
        }
        
        if (argc > 1) {
            file = [NSString stringWithCString:argv[1] encoding:NSUTF8StringEncoding];
            NSString *baseName = [file lastPathComponent];

            if ([[[file pathExtension] uppercaseString] isEqualToString:@"CLR"]) {
                NSFileManager *fm = [NSFileManager defaultManager];
                if ([fm fileExistsAtPath:file]) {
                    list = [[NSColorList alloc] initWithName:baseName fromFile:file];
                                } else {
                    NSLog(@"CLR File not found at: %@", file);
                    exit(-1);
                }
            } else {
                // System palette
                list = [NSColorList colorListNamed:file];
            }
            if (!list) {
                NSLog(@"CLR File/Palette cannot be loaded: %@", file);
                exit(-1);
            }
        }

        for (NSString *colorName in list.allKeys) {
            NSColor *color = [list colorWithKey:colorName];
            
            printf("%s\n", [colorName UTF8String]);
        }
    }
    return 0;

}
