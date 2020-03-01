//
//  FirstViewController.m
//  thaialpha
//
//  Created by beyond on 2020/02/29.
//  Copyright © 2020 Christine. All rights reserved.
//

#import "FirstViewController.h"

#import "TaiYuAlphaModel.h"
#import "MJExtension.h"

#import "CustomButton.h"
#import "HongBaoView.h"
#import "SongTool.h"

#import "UIView+Frame.h"

#import <AVFoundation/AVFoundation.h>
//#import <MediaPlayer/MediaPlayer.h>

#define kHScrollViewTag 2467
#define kVScrollTagBase 1000
#define kCustomBtnTagBase 2000
#define kDelBtnTagBase 3000
#define kShowBtnTagBase 4000

#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define ScreenBounds [UIScreen mainScreen].bounds
#define ScreenWidth ScreenBounds.size.width
#define ScreenHeight ScreenBounds.size.height
//#define kAppName @"Arab Alpha"
#define kMainBundle [NSBundle mainBundle]

#define kHardAlphaColor kColor(254, 199, 97)
#define kMiddleFuAlphaColor kColor(174, 251, 49)
#define kLowFuAlphaColor kColor(255, 255, 255)

@interface FirstViewController ()
{
    NSArray *_alphaModelArr;
    UIScrollView *_hScrollView;
    
    CustomButton *_preBtn;
//    UIColor *_preBtnColor;
    int _currentIndex;
    AlphaModel *_currentModel;
}

@property (nonatomic, strong) HongBaoView *hongbaoView;
@property (nonatomic, strong) AVAudioPlayer *currentPlayingAudioPlayer;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDataFromPlist];
    
    [self addBgImageView];
    [self addHScrollView];
    [self addHeaderView];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
#pragma mark - 数据源
- (void)loadDataFromPlist
{
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *fullPath = [mainBundle pathForResource:@"Tai_Alpha" ofType:@"plist"];
    NSArray *classDictArr = [NSArray arrayWithContentsOfFile:fullPath];
    
        _alphaModelArr = [TaiYuAlphaModel objectArrayWithKeyValuesArray:classDictArr];
}

#pragma mark - 视图
- (void)addBgImageView
{
    UIImageView *bgView = [[UIImageView alloc]init];
    bgView.frame = self.view.frame;
    UIImage *bgImage = [UIImage imageNamed:@"IMG_4398.JPG"];
    CGFloat top = 25;
    CGFloat bottom = 25;
    CGFloat left = 10;
    CGFloat right = 10;
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    bgImage = [bgImage resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
    bgView.image = bgImage;
    [self.view addSubview:bgView];
}

- (void)addHScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    scrollView.tag = kHScrollViewTag;
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollView];
    _hScrollView = scrollView;
    
    [self addSubViewToHScrollView];
}
- (void)addSubViewToHScrollView
{
    UIScrollView *vScrollView = [[UIScrollView alloc]init];
    vScrollView.tag = kVScrollTagBase + 0;
    vScrollView.frame = CGRectMake(0 * ScreenWidth, 0, ScreenWidth*2, ScreenHeight);
    vScrollView.backgroundColor = [UIColor clearColor];
    [_hScrollView addSubview:vScrollView];
    _hScrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight);
    
    for (int i = 0; i < _alphaModelArr.count; i++) {
        AlphaModel *alphaModel = [_alphaModelArr objectAtIndex:i];
            BOOL isDeleted = [self abstract_isAlreadyDelByUser:alphaModel.alpha];
            
            CustomButton *btn = [[CustomButton alloc]init];
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
            btn.tag = kCustomBtnTagBase + i;
            [btn addTarget:self action:@selector(customBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            btn.showsTouchWhenHighlighted = YES;
            btn.titleLabel.font = [UIFont systemFontOfSize:50.0];
            if (isDeleted) {
                btn.hidden = YES;
            }
        
            if ([alphaModel.alpha_remark containsString:@"难"]) {
                [btn setTitleColor:kHardAlphaColor forState:UIControlStateNormal];
            }
            [btn setTitle:alphaModel.alpha forState:UIControlStateNormal];
        
        if (true) {
            if (i > 56) {
                btn.titleLabel.font = [UIFont systemFontOfSize:40.0];
            }
            if (i == 74 || i == 76 || i == 81 || i == 83 || i == 84 || i == 90) {
                btn.titleLabel.font = [UIFont systemFontOfSize:30.0];
            }
            if (i == 80 || i == 82 || i == 91) {
                btn.titleLabel.font = [UIFont systemFontOfSize:26.0];
            }
            TaiYuAlphaModel *tai_model = (TaiYuAlphaModel *)alphaModel;
            if ([tai_model.typeNo isEqualToString:@"1"] || [tai_model.typeNo isEqualToString:@"5"]) {
                [btn setTitleColor:kHardAlphaColor forState:UIControlStateNormal];
            }
            if ([tai_model.typeNo isEqualToString:@"2"]) {
                [btn setTitleColor:kMiddleFuAlphaColor forState:UIControlStateNormal];
            }
        }
        int colsNum = 5;
        int firstBtnY = 65 + 10;
        int btnMargin = 0;
        
        CGFloat btnW = ((ScreenWidth - 10 - 10) - (colsNum - 1) * btnMargin) / colsNum;
        CGFloat btnH = btnW;
            int firstBtnX = 10;
            int row = i/colsNum;
            int cols = i%colsNum;
            
            CGFloat btnX = cols * (btnW+btnMargin)+firstBtnX;
            CGFloat btnY = row * (btnH+btnMargin)+firstBtnY;
            
            btn.frame = CGRectMake(btnX, btnY, btnW, btnH);

        if ([self abstract_isPlaceHolderEmpty:i roma:alphaModel.alpha]) {
            btn.hidden = YES;
            
        }
            [vScrollView addSubview:btn];
            vScrollView.contentSize = CGSizeMake(ScreenWidth, CGRectGetMaxY(btn.frame) + 10 + (true?0:50));
            // showBtn
            UIButton *showBtn = [[UIButton alloc]init];
            
            showBtn.hidden = !isDeleted;
        
            if ([self abstract_isPlaceHolderEmpty:i roma:alphaModel.alpha]) {
                showBtn.hidden = YES;
                
            }
            showBtn.tag = kShowBtnTagBase + i;
            showBtn.alpha = 0.1;
            showBtn.bounds = CGRectMake(0, 0, 32, 32);
            showBtn.center = btn.center;
            [showBtn setBackgroundImage:[UIImage imageNamed:@"showBtn.png"] forState:UIControlStateNormal];
            [showBtn addTarget:self action:@selector(showBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

            [vScrollView addSubview:showBtn];
    }
}
- (void)addHeaderView
{
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor clearColor];
    UIView *bgView =  [[UIView alloc]init];
    bgView.backgroundColor = kColor(85, 92, 92);
    bgView.alpha = 0.55;
    bgView.frame = CGRectMake(0, 0, ScreenWidth, 65);
    [headerView addSubview:bgView];
    headerView.frame = CGRectMake(0, 0, ScreenWidth, 65);
    [self.view addSubview:headerView];
    
    // appName
    UILabel *classLable = [[UILabel alloc]init];
    classLable.text = @"Thai Alpha";
    classLable.font = [UIFont boldSystemFontOfSize:24.0];
    classLable.textAlignment = NSTextAlignmentCenter;
    classLable.textColor = kColor(255, 255, 255);
    classLable.backgroundColor = [UIColor clearColor];
    classLable.frame = CGRectMake(40, 20, ScreenWidth - 80, 45);
    [headerView addSubview:classLable];
}
#pragma mark - 按钮点击事件
- (void)customBtnClicked:(UIButton *)btn
{
    int index = btn.tag - kCustomBtnTagBase;
    _currentIndex = index;
    
    AlphaModel *model_tmp = _alphaModelArr[index];
    [self abstract_playMp3WithModel:model_tmp];
    
    [self performSelectorOnMainThread:@selector(resetBtnColor:) withObject:_preBtn waitUntilDone:YES];
    
    AlphaModel *preModel;
    if (_preBtn) {
        preModel = _alphaModelArr[_preBtn.tag - kCustomBtnTagBase];
    }
    
    if ([preModel.alpha_remark containsString:@"难"]) {
        [self performSelectorOnMainThread:@selector(diyHardBtnColor:) withObject:_preBtn waitUntilDone:YES];
    }
    
    {
        TaiYuAlphaModel *taiModel = (TaiYuAlphaModel *)preModel;
        if ([taiModel.typeNo isEqualToString:@"1"] || [taiModel.typeNo isEqualToString:@"5"]) {
            [self performSelectorOnMainThread:@selector(diyHardBtnColor:) withObject:_preBtn waitUntilDone:YES];
        }
        if ([taiModel.typeNo isEqualToString:@"2"]) {
            [self performSelectorOnMainThread:@selector(diyMiddleFuBtnColor:) withObject:_preBtn waitUntilDone:YES];
        }
    }
    
    if (_preBtn != btn) {
        _preBtn = btn;
    }
    
    [self performSelectorOnMainThread:@selector(highlightBtnColor:) withObject:btn waitUntilDone:YES];
    
    AlphaModel *model = _alphaModelArr[index];
    _currentModel = model;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _hongbaoView.model = _currentModel;
    });
    [self becomeFirstResponder];
    
    UIMenuItem *hideItem = [[UIMenuItem alloc] initWithTitle:@"hide" action:@selector(hideItemClicked)];
    
    // item1
    UIMenuItem *menuItem1 = [[UIMenuItem alloc] initWithTitle:model.menuItem1 action:@selector(detailItemClicked)];
    
    // item2
    UIMenuItem *menuItem2 = [[UIMenuItem alloc] initWithTitle:model.menuItem2 action:@selector(detailItemClicked)];
    
    // item3
    UIMenuItem *menuItem3 = [[UIMenuItem alloc] initWithTitle:model.menuItem3 action:@selector(detailItemClicked)];
    
    // item4
    UIMenuItem *menuItem4 = [[UIMenuItem alloc] initWithTitle:model.menuItem4 action:@selector(detailItemClicked)];
    
    UIMenuController *menuController = [UIMenuController sharedMenuController];

    {
        if (model.alpha_remark.length > 0) {
            [menuController setMenuItems:@[menuItem1,menuItem2,menuItem3,hideItem]];
        } else {
            [menuController setMenuItems:@[menuItem1,menuItem2,hideItem]];
        }
    }
    
    CGRect menuLocation = CGRectMake(btn.centerX, btn.y + 5, 0, 65);
    [menuController setTargetRect:menuLocation inView:btn.superview];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (![_hongbaoView superview]) {
            [menuController setMenuVisible:YES animated:YES];
        }
    });
}
-(BOOL) canPerformAction:(SEL)action withSender:(id)sender{
    if (action == @selector(scrollViewWillBeginDragging:) ) {
        return YES;
    }
    if (action == @selector(detailItemClicked) ) {
        return YES;
    }
    if (action == @selector(hideItemClicked) ) {
        return YES;
    }
    return NO;
}

- (void)resetBtnColor:(UIButton *)btn
{
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
- (void)highlightBtnColor:(UIButton *)btn
{
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}
- (void)diyHardBtnColor:(UIButton *)btn
{
    [btn setTitleColor:kHardAlphaColor forState:UIControlStateNormal];
}

- (void)diyMiddleFuBtnColor:(UIButton *)btn
{
    [btn setTitleColor:kMiddleFuAlphaColor forState:UIControlStateNormal];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}
#pragma mark - 事件 点击菜单
- (void)detailItemClicked
{
    _hongbaoView = [[HongBaoView alloc] initWithFrame:self.view.bounds];
    _hongbaoView.model = _currentModel;
    [_hongbaoView showMenuAtView:self.view startPoint:CGPointMake(CGRectGetWidth(self.view.bounds) - 60, CGRectGetHeight(self.view.bounds)) endPoint:CGPointMake(60, CGRectGetHeight(self.view.bounds))];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    UITapGestureRecognizer *tapReco = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hongbaoViewContentViewTapped)];
    [_hongbaoView.contentView addGestureRecognizer:tapReco];
    
    [_hongbaoView.preBtn addTarget:self action:@selector(hongBaoPreBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [_hongbaoView.nextBtn addTarget:self action:@selector(hongBaoNextBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    });
}

#pragma mark - 事件 点击红包
- (void)hongBaoPreBtnClicked
{
    int preBtnIndex = _currentIndex - 1;
    if (preBtnIndex < 0) {
        preBtnIndex = _alphaModelArr.count - 1;
    }
    CustomButton *btn = [_hScrollView viewWithTag:kCustomBtnTagBase + preBtnIndex];
    AlphaModel *model = _alphaModelArr[preBtnIndex];
    BOOL isPreAlreadyHidden = [self abstract_isAlreadyDelByUser:model.alpha];
    if (isPreAlreadyHidden || [self abstract_isPlaceHolderEmpty:preBtnIndex roma:model.alpha]) {
        _currentIndex--;
        [self hongBaoPreBtnClicked];
    } else {
        [self customBtnClicked:btn];
    }
}
- (void)hongBaoNextBtnClicked
{
    int nextBtnIndex = _currentIndex + 1;
    if (nextBtnIndex > _alphaModelArr.count - 1) {
        nextBtnIndex = 0;
    }
    CustomButton *btn = [_hScrollView viewWithTag:kCustomBtnTagBase + nextBtnIndex];
    AlphaModel *model = _alphaModelArr[nextBtnIndex];
    BOOL isNextAlreadyHidden = [self abstract_isAlreadyDelByUser:model.alpha];
    if (isNextAlreadyHidden || [self abstract_isPlaceHolderEmpty:nextBtnIndex roma:model.alpha] || btn.hidden == YES) {
        _currentIndex++;
        [self hongBaoNextBtnClicked];
    } else {
        [self customBtnClicked:btn];
    }
}
- (void)hongbaoViewContentViewTapped
{
    CustomButton *btn = [_hScrollView viewWithTag:kCustomBtnTagBase + _currentIndex];
    [self customBtnClicked:btn];
}

#pragma mark - 抽取的公共方法
- (BOOL)abstract_isAlreadyDelByUser:(NSString *)alpha
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *delKey = [NSString stringWithFormat:@"%@_%@",@"userDefault_roma",alpha];
    BOOL isDeleted = [userDefault boolForKey:delKey];
    return isDeleted || [alpha isEqualToString:@"sg"];
}
- (BOOL)abstract_isPlaceHolderEmpty:(int )index roma:(NSString *)roma
{
    if ([roma isEqualToString:@"sg"]) {
        return YES;
    }
    return NO;
}
#pragma mark - 抽取的播放声音
- (void)abstract_playMp3WithModel:(AlphaModel *)model
{
    
    NSString *encodeMp3 ;
    if ([model.alpha_mp3 hasPrefix:@"encode_"]) {
        encodeMp3 = model.alpha_mp3;
    } else {
        encodeMp3 = [NSString stringWithFormat:@"encode_%@",model.alpha_mp3];
    }
    NSString *fullPath = [kMainBundle pathForResource:encodeMp3 ofType:nil];
        {
            TaiYuAlphaModel *taiModel = (TaiYuAlphaModel *)model;
            NSString *mp3Name = [NSString stringWithFormat:@"encode_%@.m4a",taiModel.resIndex];
            
            fullPath = [kMainBundle pathForResource:mp3Name ofType:nil];
            [self playMp3WithFullPath:fullPath loopNumber:1 isEncoded:YES];
        }
}
#pragma mark - 抽取的 音乐播放
- (void)playMp3WithFullPath:(NSString *)fullPath loopNumber:(NSInteger)loopNumber isEncoded:(BOOL)isEncoded
{
    if (self.currentPlayingAudioPlayer) {
        [self.currentPlayingAudioPlayer pause];
    }
    AVAudioPlayer *audioPlayer ;
    if (isEncoded) {
        audioPlayer = [SongTool playMusicWithFullPath:fullPath loopNumber:loopNumber isEncoded:YES];
    }else{
        audioPlayer = [SongTool playMusicWithFullPath:fullPath loopNumber:loopNumber];
    }
    audioPlayer.delegate = self;
    self.currentPlayingAudioPlayer = audioPlayer;
}
@end
