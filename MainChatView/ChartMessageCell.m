//
//  ChartMessageCell.m
//  XMPP
//
//  Created by 李文强 on 2018/8/24.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "ChartMessageCell.h"
#import "MysizeAuto.h"

@implementation ChartMessageCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}
- (void)initView{
    [self addSubview:self.backImageView];
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(@50);
    }];
    [_backImageView addSubview:self.textLabel];
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.right.equalTo(@0).offset(-10);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
}
- (UILabel *)textLabel{
    if (!_textLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = 0;
        label.textColor = [UIColor darkGrayColor];
        label.numberOfLines = 0;
        _textLabel = label;
    }
    return _textLabel;
}
- (UIImageView *)backImageView{
    if (!_backImageView) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.backgroundColor =[UIColor whiteColor];
        _backImageView = imageView;
    }
    return _backImageView;
}
- (void)initViewType:(int)type{
    CGFloat H = [MysizeAuto createSize:_textLabel.text andFont:16.5 andSize:CGSizeMake(MAINSCREEN.width-60, MAXFLOAT) andName:nil].size.height;
    CGFloat W = [MysizeAuto createSize:_textLabel.text andFont:16.5 andSize:CGSizeMake(MAINSCREEN.width-60, MAXFLOAT) andName:nil].size.width;
    if (H<50) {
        H = 50;
    }
    if (W<60) {
        W = 60;
    }
    if (type == 0) {
        //对面
        _backImageView.backgroundColor = [UIColor purpleColor];
        _textLabel.textAlignment = 0;
        _textLabel.textColor = [UIColor whiteColor];
        [_backImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.right.equalTo(@0).offset(-MAINSCREEN.width+20+W);
            make.centerY.equalTo(self.mas_centerY);
            make.height.equalTo(@0).offset(H);
        }];
    }else{
        //自己
        _backImageView.backgroundColor = [UIColor blueColor];
        _textLabel.textAlignment = 2;
        _textLabel.textColor = [UIColor whiteColor];
        [_backImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0).offset(MAINSCREEN.width-W-20);
            make.right.equalTo(@0).offset(-10);
            make.centerY.equalTo(self.mas_centerY);
            make.height.equalTo(@0).offset(H);
        }];
    }
}
@end
