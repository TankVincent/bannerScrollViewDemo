//
//  BSScrollView.m
//  banner轮播Demo
//
//  Created by Tank on 2017/4/25.
//  Copyright © 2017年 Tank. All rights reserved.
//
#import "BSScrollView.h"
static NSUInteger BSCurrentImage = 1; //中间图片的下标是为1
static CGFloat const scrollInterval = 3.0; //定时滚动图片的时间

@implementation BSScrollView {

    BOOL _timerUp;
    UILabel *_titleLabel;
    NSTimer *_scrollTimer;
    UIImageView *_leftView;
    UIImageView *_centerView;
    UIImageView *_rightView;
    UIPageControl *_pageControl;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupMainScrollView:frame];
    }
    return self;
}

/**
 *  初始化scrollView
 */
- (void)setupMainScrollView:(CGRect)frame {
    
    self.bounces = NO;
    self.pagingEnabled = YES;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.contentOffset = CGPointMake(self.bounds.size.width, 0);
    self.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
    self.delegate = self;
    
    CGRect leftRect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    _leftView = [[UIImageView alloc] init];
    _leftView.frame = leftRect;
    [self addSubview:_leftView];
    
    CGRect centerRect = CGRectMake(self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
    _centerView = [[UIImageView alloc] init];
    _centerView.frame = centerRect;
    [self addSubview:_centerView];
    
    CGRect rightRect = CGRectMake(self.bounds.size.width * 2, 0, self.bounds.size.width, self.bounds.size.height);
    _rightView = [[UIImageView alloc] init];
    _rightView.frame = rightRect;
    [self addSubview:_rightView];
    
    _scrollTimer = [NSTimer scheduledTimerWithTimeInterval:scrollInterval target:self selector:@selector(scrollViewScroll) userInfo:nil repeats:YES];
    _timerUp = NO;
}

- (void)scrollViewScroll {
    
    [self setContentOffset:CGPointMake(self.bounds.size.width * 2, 0) animated:YES];
    _timerUp = YES;
     [NSTimer scheduledTimerWithTimeInterval:0.6f target:self selector:@selector(scrollViewDidEndDecelerating:) userInfo:nil repeats:NO];
}

- (void)drawRect:(CGRect)rect {
    
    if (_pageControlPosition == BSPageControlPositionNone) {
        return;
    }
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.numberOfPages = self.imageNames.count;
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:13];
    CGFloat pointW = 25;
    CGFloat pointH = pointW;
    CGFloat pageCtrY = self.bounds.size.height - pointH;
    CGFloat pageCtrW = pointW * _pageControl.numberOfPages;
    CGFloat titleLabW = self.bounds.size.width - pageCtrW;
    
    CGRect bgFrame = CGRectMake(0, pageCtrY, self.bounds.size.width, pointH);
    UIView *bgView = [[UIView alloc] initWithFrame:bgFrame];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    // defailt模式不会显示文字
    if (_pageControlPosition == BSPageControlPositionDefult) {
        CGFloat pageX = self.bounds.size.width  / 2 - pageCtrW / 2;
        _pageControl.frame = CGRectMake(pageX, 0, pageCtrW, pointH);
    } else if (_pageControlPosition == BSPageControlPositionLeft) {
        _pageControl.frame = CGRectMake(0, 0, pageCtrW, pointH);
        _titleLabel.frame = CGRectMake(self.bounds.size.width - titleLabW, 0, titleLabW, pointH);
        _titleLabel.textAlignment = NSTextAlignmentRight;
    } else {
        _pageControl.frame = CGRectMake(self.bounds.size.width - pageCtrW, 0, pageCtrW, pointH);
        _titleLabel.frame = CGRectMake(0, 0, titleLabW, pointH);
    }
    _titleLabel.text = self.titles[0];
    _pageControl.enabled = NO;
    _pageControl.currentPage = 0;
    [bgView addSubview:_pageControl];
    [bgView addSubview:_titleLabel];
    [[self superview] addSubview:bgView];
}

- (void)setImageNames:(NSArray *)imageNames {
    _imageNames = imageNames;
    
    _leftView.image = [UIImage imageNamed:_imageNames[0]];
    _centerView.image = [UIImage imageNamed:_imageNames[1]];
    _rightView.image = [UIImage imageNamed:_imageNames[2]];
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSUInteger imgCount = self.imageNames.count;
    NSUInteger currentPage = _pageControl.currentPage;
    
    if (self.contentOffset.x == 0) {
        BSCurrentImage = (BSCurrentImage - 1) % imgCount;
        _pageControl.currentPage = (currentPage - 1) % imgCount;
    } else if (self.contentOffset.x == self.bounds.size.width * 2) {
        
        BSCurrentImage = (BSCurrentImage + 1) % imgCount;
        _pageControl.currentPage = (currentPage + 1) % imgCount;
    } else {
        return;
    }
    _titleLabel.text = self.titles[_pageControl.currentPage];

    NSString *leftImageName = _imageNames[(BSCurrentImage - 1) % imgCount];
    _leftView.image = [UIImage imageNamed:leftImageName];

    NSString *centerImageName = _imageNames[BSCurrentImage % imgCount];
    _centerView.image = [UIImage imageNamed:centerImageName];
    
    NSString *rightImageName = _imageNames[(BSCurrentImage + 1) % imgCount];
    _rightView.image = [UIImage imageNamed:rightImageName];
    
    self.contentOffset = CGPointMake(self.bounds.size.width, 0);
    
    if (!_timerUp) {
        [_scrollTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:scrollInterval]];
    }
    _timerUp = NO;
}

@end
