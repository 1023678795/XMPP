//
//  MessageObject.h
//  XMPP
//
//  Created by 李文强 on 2018/8/24.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    MessageTypeOfText,
    MessageTypeOfPic,
    MessageTypeOfAddress
}TypeOfMessage;

@interface MessageObject : NSObject
@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) int type;
@end
