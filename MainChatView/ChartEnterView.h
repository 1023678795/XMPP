//
//  ChartEnterView.h
//  XMPP
//
//  Created by 李文强 on 2018/8/24.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SendClick)(NSString *text);
typedef void (^VoiceClick)(NSString *text);
typedef void (^AddClick)(NSString *text);

@interface ChartEnterView : UIView<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *enterTF;
@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, strong) UIButton *voiceButton;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) SendClick sendBlock;
@property (nonatomic, strong) VoiceClick voiceClick;
@property (nonatomic, strong) AddClick addClick;
@end
