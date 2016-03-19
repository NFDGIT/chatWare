//
//  QYTableHeaderView.m
//  weixin1512
//
//  Created by qingyun on 16/3/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYTableHeaderView.h"
#import "QYImageModel.h"
@interface QYTableHeaderView ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *middleImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (nonatomic) CGFloat height;
@property (nonatomic) NSInteger currentIndex;
@end

@implementation QYTableHeaderView

-(void)awakeFromNib{
    _middleImageView.contentMode = UIViewContentModeScaleAspectFill;
    _middleImageView.layer.masksToBounds = YES;
    
    _leftImageView.contentMode = UIViewContentModeScaleAspectFill;
    _leftImageView.layer.masksToBounds = YES;
    
    _rightImageView.contentMode = UIViewContentModeScaleAspectFill;
    _rightImageView.layer.masksToBounds = YES;
    
    _middleImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goWebView)];
    [_middleImageView addGestureRecognizer:tap];
    
    NSLog(@"%@",NSStringFromCGRect(self.frame));
    NSLog(@"%@",NSStringFromCGRect(_middleImageView.frame));
    NSLog(@"%@",NSStringFromCGRect(_pageControl.frame));
}

-(void)goWebView{
    QYImageModel *imageModel = self.imagePaths[_currentIndex];
    NSLog(@"当前显示的图片:%@",imageModel.imagepath);
    if (_gotoWebView) {
        _gotoWebView(imageModel.weburl);
    }
}

+(instancetype)headerView{
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"QYTableHeaderView" owner:self options:nil];
    QYTableHeaderView *headerView = views.firstObject;
  
    return headerView;
}

-(void)setImagePaths:(NSArray *)imagePaths{
    _imagePaths = imagePaths;
    //设置imageViews中的图片
    [self setimageForImageViews];
    //设置numberOfPages
    _pageControl.numberOfPages = imagePaths.count;
}
//确保索引可用
-(NSInteger)indexEnableWithIndex:(NSInteger)index{
    if (index < 0) {
        return self.imagePaths.count - 1;
    }else if (index > self.imagePaths.count - 1){
        return 0;
    }else{
        return index;
    }
}

-(void)setimageForImageViews{
    _pageControl.currentPage = _currentIndex;
    //取到当前页面对应的数据模型
    QYImageModel *currentModel = self.imagePaths[[self indexEnableWithIndex:_currentIndex]];
    _middleImageView.image = [UIImage imageNamed:currentModel.imagepath];
    
    //取左边页面对应的数据模型
    QYImageModel *leftModel = self.imagePaths[[self indexEnableWithIndex:_currentIndex - 1]];
    _leftImageView.image = [UIImage imageNamed:leftModel.imagepath];
    
    //取右边页面对应的数据模型
    QYImageModel *rightModel = self.imagePaths[[self indexEnableWithIndex:_currentIndex + 1]];
    _rightImageView.image = [UIImage imageNamed:rightModel.imagepath];
    
    //设置偏移量,始终显示_middleImageView
    _scrollView.contentOffset = CGPointMake(CGRectGetWidth(_scrollView.frame), 0);
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x == 0) {//右滑
        _currentIndex--;
    }else if (scrollView.contentOffset.x == CGRectGetWidth(_scrollView.frame) * 2){
        //左滑
        _currentIndex++;
    }
    _currentIndex = [self indexEnableWithIndex:_currentIndex];
    [self setimageForImageViews];
}


-(void)setFrame:(CGRect)frame{
    CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100);
    [super setFrame:rect];
}


@end
