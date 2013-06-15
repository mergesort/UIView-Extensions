//
//  UIView+Extensions.h
//  Joseph Fabisevich
//
//  Created by Joseph Fabisevich on 4/8/13.
//  Copyright (c) 2013 mergesort. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extensions)

- (void)addExclusiveTouchToSubviews;
- (void)addTopBorder;
- (void)addBottomBorder;
- (void)addImageAsTopBorder:(UIImage *)image;
- (void)addImageAsBottomBorder:(UIImage *)image;
- (UIImage *)noiseImage;
- (void)drawNoiseOnView;
- (UIImage *)getImageOfView;

- (void)fadeInView;
- (void)fadeOutView;

@end
