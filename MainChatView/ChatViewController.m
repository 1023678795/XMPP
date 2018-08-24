//
//  ChatViewController.m
//  XMPP
//
//  Created by 李文强 on 2018/8/24.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "ChatViewController.h"
#import "ChartMessageCell.h"
#import "ChartEnterView.h"
#import "MessageObject.h"
#import "MysizeAuto.h"

@interface ChatViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    CGFloat keybordHeight;
    
}
@property (nonatomic, strong) ChartEnterView *bottomView;
@property (nonatomic, strong) NSMutableArray *messageArray;
@property (nonatomic, assign) int TYpe;
@end

@implementation ChatViewController
- (ChartEnterView *)bottomView{
    if (!_bottomView) {
        ChartEnterView *view = [[ChartEnterView alloc]init];
        _bottomView = view;
    }
    return _bottomView;
}
- (UICollectionView *)mainCollectionView{
    if (!_mainCollectionView) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0,MAINSCREEN.width, MAINSCREEN.height-50) collectionViewLayout:_flowLayout];
        collectionView.delegate =self;
        collectionView.dataSource =self;
        collectionView.backgroundColor = [UIColor lightGrayColor];
        [collectionView registerClass:[ChartMessageCell class] forCellWithReuseIdentifier:@"Cell"];
        [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"fooder"];
        _mainCollectionView = collectionView;
    }
    return _mainCollectionView;
}
- (void)viewWillAppear:(BOOL)animated{
    UIButton *releaseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [releaseButton setTitle:@"切换角色" forState:normal];
    [releaseButton addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *releaseButtonItem = [[UIBarButtonItem alloc] initWithCustomView:releaseButton];
    self.navigationItem.rightBarButtonItem = releaseButtonItem;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"聊天";
    _TYpe = 1;
    // Do any additional setup after loading the view.
    _messageArray = [NSMutableArray new];
    [self addCollection];
    [self registerForKeyboardNotifications];
    [self addEnterView];

}
- (void)change:(UIButton *)sender{
    if (_TYpe == 0) {
        _TYpe = 1;
    }else{
        _TYpe = 0;
    }
}
- (void)addCollection{
    [self.view addSubview:self.mainCollectionView];
}
#pragma mark -- collectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MessageObject *object = [MessageObject new];
    object = _messageArray[indexPath.section];
    CGFloat H = [MysizeAuto createSize:object.text andFont:16.5 andSize:CGSizeMake(MAINSCREEN.width-60, MAXFLOAT) andName:nil].size.height;
    if (H<50) {
        H = 50;
    }
    return CGSizeMake(MAINSCREEN.width,H);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(MAINSCREEN.width, 1);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(MAINSCREEN.width, 0);
}
//设置分区数（必须实现）
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _messageArray.count;
}
//设置每个分区的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}
//设置返回每个item的属性必须实现）
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ChartMessageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    MessageObject *object = [MessageObject new];
    object = _messageArray[indexPath.section];
    cell.textLabel.text = object.text;
    [cell initViewType:object.type];
    NSLog(@"输出文字 %@",object.text);
    return cell;
}
//对头视图或者尾视图进行设置
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
 
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        footerview.backgroundColor=[UIColor whiteColor];
        footerview.frame = CGRectMake(0, 0, 0, 0);
        return footerview;
    }else{
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"fooder" forIndexPath:indexPath];
        footerview.backgroundColor=[UIColor whiteColor];
        footerview.frame = CGRectMake(0, 0, 0, 0);
        return footerview;
    }
    return nil;
}
//是否允许移动Item
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0)
{
    return YES;
}
//移动Item时触发的方法
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath NS_AVAILABLE_IOS(9_0);
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 注册键盘，监控键盘高度
//上移
- (void)keyboardWillShown:(NSNotification*)notification
{
    NSDictionary *info = [notification userInfo];
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    //输入框位置动画加载
    //判断
    keybordHeight = keyboardSize.height;
    [_bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0).offset(-keyboardSize.height);
    }];
    [UIView animateWithDuration:duration animations:^{
        [self.view setNeedsLayout];
    }];
}
- (void)keyboardWillBeHidden:(NSNotification*)notification
{
    NSDictionary *info = [notification userInfo];
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [_bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
    }];
    [UIView animateWithDuration:duration animations:^{
        [self.view setNeedsLayout];
    }];
    
}
- (void)registerForKeyboardNotifications
{
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShown:)
                                                 name:UIKeyboardWillChangeFrameNotification object:nil];
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark - 底部输入文字
- (void)addEnterView{
    [self.view addSubview:self.bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@50);
        make.bottom.equalTo(@0);
    }];
    __block ChatViewController *myself = self;
    _bottomView.sendBlock = ^(NSString *text) {
        MessageObject *object = [[MessageObject alloc]init];
        object.text = text;
        object.type = myself.TYpe;
        [myself.messageArray addObject:object];
        NSLog(@"数组 %@  %@",object.text,text);
        [myself.mainCollectionView reloadData];
        NSIndexPath *collecIndexPath = [NSIndexPath indexPathForRow:0 inSection:myself.messageArray.count-1];//偏移到某行某组
        [myself.mainCollectionView scrollToItemAtIndexPath:collecIndexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];

    };
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
