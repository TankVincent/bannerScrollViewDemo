//
//  BSScrollView.h
//  banner轮播Demo
//
//  Created by Tank on 2017/4/25.
//  Copyright © 2017年 Tank. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BSPageControlPosition) {
    BSPageControlPositionDefult,
    BSPageControlPositionLeft,
    BSPageControlPositionRight,
    BSPageControlPositionNone,
};

@interface BSScrollView : UIScrollView<UIScrollViewDelegate>
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *imageNames;
@property (nonatomic, assign) BSPageControlPosition pageControlPosition;

@end
