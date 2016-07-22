//
//  StartRatingViewController.m
//  TEST
//
//  Created by hc_cyril on 16/5/31.
//  Copyright © 2016年 Clark. All rights reserved.
//

#import "StarRatingViewController.h"
#import "HCSStarRatingView.h"

@interface StarRatingViewController ()
@property (nonatomic, strong) HCSStarRatingView *starRatingView;
@end

@implementation StarRatingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改过的星星";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    
    self.starRatingView = nil;

}


#pragma mark - private methods

- (void)setUpSubviews {
    
    [self.view addSubview:self.starRatingView];
    //    [self.starRatingView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(@(0));
    //        make.top.equalTo(self.view.mas_top).offset(100);
    //        make.width.equalTo(self.view);
    //        make.height.equalTo(@(100));
    //    }];
}

- (HCSStarRatingView *)starRatingView {
    
    if (!_starRatingView) {
        _starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 50)];
        _starRatingView.maximumValue = 11;
        _starRatingView.minimumValue = 0;
        _starRatingView.emptyStarImage = [UIImage imageNamed:@"starRating_star_gray"];
        _starRatingView.filledStarImage = [UIImage imageNamed:@"starRating_star_yellow"];
        
    }
    return _starRatingView;
}

@end
