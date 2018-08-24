//
//  ChartEnterView.m
//  XMPP
//
//  Created by 李文强 on 2018/8/24.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "ChartEnterView.h"

@implementation ChartEnterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self addMainBaseView];
        [self addVoiceButton];
        [self addEnterTF];
        [self addSendButton];
    }
    return self;
}
//主题背景
- (void)addMainBaseView{
    self.frame = CGRectMake(0, 0, MAINSCREEN.width, 50);
    self.backgroundColor = [UIColor whiteColor];
}
//语音按钮
- (UIButton *)voiceButton{
    if (!_voiceButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:[UIColor darkGrayColor] forState:0];
        [button setTitle:@"V" forState:UIControlStateSelected];
        [button setTitle:@"K" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(voicerClick:) forControlEvents:UIControlEventTouchUpInside];
        _voiceButton = button;
    }
    return _voiceButton;
}
- (void)addVoiceButton{
    [self addSubview:self.voiceButton];
    [_voiceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
}
- (void)voicerClick:(UIButton *)sender{
    self.voiceClick(@"click");
}
//文字输入
- (UITextField *)enterTF{
    if (!_enterTF) {
        UITextField *tf = [[UITextField alloc]init];
        tf.borderStyle = UITextBorderStyleRoundedRect;
        tf.backgroundColor = [UIColor lightGrayColor];
        tf.delegate = self;
        _enterTF =tf;
    }
    return _enterTF;
}
- (void)addEnterTF{
    [self addSubview:self.enterTF];
    [_enterTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_voiceButton.mas_right).offset(10);
        make.right.equalTo(self.mas_right).offset(-80);
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(@40);
    }];
}
//表情
- (UIButton *)sendButton{
    if (!_sendButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:[UIColor darkGrayColor] forState:0];
        [button setTitle:@"发送" forState:UIControlStateSelected];
        [button setTitle:@"发送" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(sendClick:) forControlEvents:UIControlEventTouchUpInside];
        _sendButton = button;
    }
    return _sendButton;
}
- (void)sendClick:(UIButton *)sender{
    self.sendBlock(_enterTF.text);
    _enterTF.text = @"";
}
- (void)addSendButton{
    [self addSubview:self.sendButton];
    [_sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0).offset(-5);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
    }];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self endEditing:YES];
    return YES;
}
@end
