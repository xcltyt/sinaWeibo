//
//  NewFeatureController.m
//  xclSinaWeibo
//
//  Created by xiechanglei on 15/4/2.
//  Copyright (c) 2015年 谢长磊. All rights reserved.
//



#import "NewFeatureController.h"
#import "UIImage+XCL.h"

#define KCOUNT 4

@interface NewFeatureController ()<UIScrollViewDelegate>
{
    UIPageControl *_page;
    UIScrollView *_scroll;
}
@end

@implementation NewFeatureController

- (void)loadView {//创建view时  没有给view设置宽高，那么在后面的时候  一定要给view设置宽高，否则会出错
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage fullScreenImage:@"new_feature_background.png"];
    
//    
    imageView.frame = [UIScreen mainScreen].applicationFrame;
    
//    这一步很重要  如果想要子控件能接收到来自application的点击事件 那么根控制器必须要开启用户交互功能，以便传递给子控件。   一层一层的传递  一层一层的开启用户交互功能。
    
//    
    imageView.userInteractionEnabled = YES;
    
//    
    
/*
 以3.5inch（iPhone4）为例  屏幕分辨率（640x960  像素分辨率）--- 坐标：宽320 x 高480   一个点占两个像素
  1》当没有状态栏，applicationFrame 的值为 {{0, 0}, {320, 480}}
  2>当有状态栏，applicationFrame 的值为 {{0,20}, {320, 460}}
 
 
    而 bounds  永远都是  {{0, 0}, {320, 480}}
 
 
 
 以4inch（iPhone5  5c  5s）为例  屏幕分辨率（640x1136  像素分辨率）--- 坐标：宽320 x 高480   一个点占两个像素
 1》当没有状态栏，applicationFrame 的值为 {{0, 0}, {320, 568}}
 2>当有状态栏，applicationFrame 的值为 {{0,20}, {320, 548}}
 
 
 而 bounds  永远都是  {{0, 0}, {320, 568}}
 */
    
    self.view = imageView;
}


/*
 一个控件无法显示：
 1、没有设置宽高，或者设置的宽高没有具体的值（宽高为0）
 2、位置不对，跑到屏幕外面去了
 3.hidden = YES;
 4.没有添加到控制器的view上面
 
 一个UIScrollView无法滚动的时候
 1.contentsize 没有值
 2.不能接收到触摸事件
 
 
 
 
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//   1. 添加UIScrollView
    [self addScrollView];
    
//    2.添加图片
    
    [self addScrollImages];
    
//   3. 添加UIPageControl
    [self addPageControl];
    
}

#pragma mark - UI界面初始化
#pragma mark 添加滚动视图
- (void)addScrollView {
    
    UIScrollView *scroll = [[UIScrollView alloc] init];
    scroll.frame = self.view.bounds;
    CGSize size = scroll.frame.size;
    //    以后涉及到宽高  都要提前打印看一下是否有具体的值
    //    
    MyLog(@"%@",NSStringFromCGRect(self.view.bounds));
    //    
    
    scroll.showsHorizontalScrollIndicator = NO;//隐藏水平滚动条
    
    
    //    设置滚动区域    这步也很重要
    scroll.contentSize = CGSizeMake(KCOUNT*size.width, 0);
    
    //    打印contentsize的值
    MyLog(@"%@",NSStringFromCGSize(scroll.contentSize));
    
    //    分页  这样滚动起来不会那么随意
    scroll.pagingEnabled = YES;
    //    设置代理来监听scroll的滚动
    scroll.delegate = self;
    
    [self.view addSubview:scroll];
    _scroll = scroll;
}

#pragma mark 添加滚动显示的图片

- (void)addScrollImages {
    
    CGSize size = _scroll.frame.size;
    
    for (int i = 0; i < KCOUNT; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        //        显示图片
        NSString *name = [NSString stringWithFormat:@"new_feature_%d.png",i+1];
        imageView.image = [UIImage fullScreenImage:name];
        //        设置frame
        imageView.frame = CGRectMake(i*size.width, 0, size.width, size.height);
        //        添加到滚动视图上
        [_scroll addSubview:imageView];
        
        if (i == KCOUNT - 1) {
            //            立即体验（开始）
            UIButton *start = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *startNormal = [UIImage imageNamed:@"new_feature_finish_button.png"];
            
            [start setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button.png"] forState:UIControlStateNormal];
            [start setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted.png"] forState:UIControlStateHighlighted];
            //            居中  所以设置center
            start.center = CGPointMake(size.width*0.5, size.height*0.8);
            //            利用结构体赋值  并进行强制转换一下   简单了很多
            start.bounds = (CGRect){CGPointZero, startNormal.size};
            
            //            增加点击事件
            [start addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
            
            [imageView addSubview:start];
            
            //            分享按钮
            UIButton *share = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *shareNormal = [UIImage imageNamed:@"new_feature_share_false.png"];
            
            [share setBackgroundImage:shareNormal forState:UIControlStateNormal];
            
            [share setBackgroundImage:[UIImage imageNamed:@"new_feature_share_true.png"] forState:UIControlStateSelected];
            //            居中  所以设置center  与start 保持相似  适配
            share.center = CGPointMake(start.center.x, start.center.y - 50);
            //            利用结构体赋值  并进行强制转换一下   简单了很多
            share.bounds = (CGRect){CGPointZero, shareNormal.size};
            
            //            增加点击事件
            [share addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
            
            //        share.enabled = NO; 代表  UIControlStateDisabled  状态，
            
            share.selected = YES;
    
            //            按钮在高亮的时候不需要变灰色
            share.adjustsImageWhenHighlighted = NO;
            
            [imageView addSubview:share];
            
            //            父控件的用户交互开通之后  可以传递给子控件的   如果子控件想要有点击事件  那么必须要开通父控件的用户交互功能 userInteractionEnabled = YES
            imageView.userInteractionEnabled = YES;

        }
    }
}

#pragma mark 添加分页指示器
- (void)addPageControl {
    
    CGSize size = _scroll.frame.size;
    
    UIPageControl *page = [[UIPageControl alloc] init];
    //    屏幕适配  利用屏幕的宽高  乘以  一个比例系数  
    page.center = CGPointMake(size.width*0.5, size.height*0.95);
    
    //    
    
    page.bounds = CGRectMake(0, 0, 150, 0);//bounds 的x,y 永远为0，0   只能有宽高
    //    pagecontrol 的高度永远都是36   系统默认的
    
    //    设置pagecontrol 的个数
    page.numberOfPages = KCOUNT;
    //    pagecontrol的颜色   依据美工给的图片  来设置颜色
    page.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_checked_point.png"]];
    page.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_point.png"]];
    
    
    [self.view addSubview:page];
    _page = page;
    
}

#pragma mark -监听按钮点击
#pragma mark - 开始

- (void)start {
    MyLog(@"开始微博");
}


#pragma mark - 分享

- (void)share:(UIButton *)button {
    if (!button.selected) {
        MyLog(@"分享微博");
    } else {
        MyLog(@"不分享微博");
    }
    
    button.selected = !button.selected;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _page.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
