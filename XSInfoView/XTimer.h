//
//  XTimer.h
//  Bole
//
//  Created by 李文强 on 2017/4/10.
//  Copyright © 2017年 李文强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XTimer : NSObject
@property  NSTimeInterval ti;
@property (nullable,weak) id atarget;
@property (nullable,nonatomic, assign) SEL aSelector;
@property (nullable, retain) id userInfo;
+ (nullable XTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(nullable id)aTarget selector:(nullable SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;
- (void)reStart;
- (void)stop;
- (void)invalidate;
@end
