//
//  UIView+Extensions.m
//  Joseph Fabisevich
//
//  Created by Joseph Fabisevich on 4/8/13.
//  Copyright (c) 2013 mergesort. All rights reserved.
//

#import "UIView+Extensions.h"
#import <QuartzCore/QuartzCore.h>


@implementation UIView (Extensions)

- (void)addExclusiveTouchToSubviews
{
    for (UIButton *button in self.subviews)
    {
        if ([button isKindOfClass:[UIButton class]])
        {
            button.exclusiveTouch = YES;
        }
    }
}

- (void)addTopBorder
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    label.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:label];
}

- (void)addBottomBorder
{
    int yMax = self.frame.size.height;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, yMax-1, self.frame.size.width, 1)];
    label.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:label];
}

- (void)addImageAsTopBorder:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, image.size.height)];
    imageView.image = image;
    [self addSubview:imageView];
}

- (void)addImageAsBottomBorder:(UIImage *)image
{
    int yMax = self.frame.size.height;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, yMax-image.size.height, self.frame.size.width, image.size.height)];
    imageView.image = image;
    [self addSubview:imageView];
}

- (UIImage *)noiseImage
{
    CGImageRef noise = CGGenerateNoiseImage(self.frame.size, 0.01);
    return [UIImage imageWithCGImage:noise];
}

- (void)drawNoiseOnView
{
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.layer.contents = (id)[self noiseImage].CGImage;
}

- (UIImage *)getImageOfView
{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
    {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    }
    else
    {
        UIGraphicsBeginImageContext(self.bounds.size);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    [self.layer renderInContext:context];

    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return img;
}

- (void)fadeInView
{
    self.alpha = 0;
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha = 1;
        
    }];
}

- (void)fadeOutView
{
    self.alpha = 1;
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha = 0;
    }];
}


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Private helper methods

CGImageRef CGGenerateNoiseImage(CGSize size, CGFloat factor)
{
    NSUInteger bits = fabs(size.width) * fabs(size.height);
    char *rgba = (char *)malloc(bits);
    srand(124);
    
    for(int i = 0; i < bits; i++)
    {
        rgba[i] = (rand() % 256) * factor;
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapContext = CGBitmapContextCreate(rgba, fabs(size.width), fabs(size.height), 8, fabs(size.width), colorSpace, kCGImageAlphaOnly);
    CGImageRef image = CGBitmapContextCreateImage(bitmapContext);
    
    CGContextRelease(bitmapContext);
    CGColorSpaceRelease(colorSpace);
    free(rgba);
    
    return image;
}


@end
