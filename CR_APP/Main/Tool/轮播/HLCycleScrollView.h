//
//  HLCycleScrollView.h
//  myCycleScrollViewDemo
//
//  Created by user on 15-3-10.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HLCycleScrollViewDelegate;
@protocol HLCycleScrollViewDatasource;

@interface HLCycleScrollView : UIView<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    
//    id<XLCycleScrollViewDelegate> _delegate;
//    id<XLCycleScrollViewDatasource> _datasource;
    
    NSInteger _totalPages;
    long _curPage;
    
    NSMutableArray *_curViews;
}

@property (nonatomic,readonly) UIScrollView *scrollView;
@property (nonatomic,readonly) UIPageControl *pageControl;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,assign,setter = setDataource:) id<HLCycleScrollViewDatasource> datasource;
@property (nonatomic,assign,setter = setDelegate:) id<HLCycleScrollViewDelegate> delegate;

- (void)reloadData;
- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index;
- (id)initWithFrame:(CGRect)frame  animationDuration:(NSTimeInterval)animationDuration;
@end

@protocol HLCycleScrollViewDelegate <NSObject>

@optional
- (void)didClickPage:(HLCycleScrollView *)csView atIndex:(long)index;

@end

@protocol HLCycleScrollViewDatasource <NSObject>

@required
- (NSInteger)numberOfPages;
- (UIView *)pageAtIndex:(int)index;

@end

