//
//  ChartMessageCell.h
//  XMPP
//
//  Created by 李文强 on 2018/8/24.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChartMessageCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIImageView *backImageView;
- (void)initViewType:(int)type;
@end
