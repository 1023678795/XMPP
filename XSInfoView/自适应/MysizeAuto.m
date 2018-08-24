//
//  MysizeAuto.m
//  mentor-teacher
//
//  Created by wemax on 16/4/27.
//  Copyright © 2016年 wemax. All rights reserved.
//

#import "MysizeAuto.h"

@implementation MysizeAuto
+ (CGRect)createSize:(NSString *)lableStr andFont:(NSInteger)fondS andSize:(CGSize)mysize andName:(NSString *)name;
{
    UIFont *font;
    if (name.length == 0)
    {
        font=[UIFont systemFontOfSize:fondS];
    }else
    {
        font=[UIFont fontWithName:name size:fondS];
    }
    CGRect rect=[lableStr boundingRectWithSize:mysize options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    return rect;
}

@end
