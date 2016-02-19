//
//  CommonObject.m
//  Sampler
//
//  Created by song on 2016. 2. 17..
//  Copyright © 2016년 song. All rights reserved.
//

#import "CommonObject.h"

@implementation CommonObject


	+ (instancetype)objectWithFrame:(CGRect)frame; {
		CommonObject * instance = [[CommonObject alloc] initWithFrame:frame];
		return instance;
	}


	- (instancetype) initWithFrame:(CGRect)frame {
		if ([super initWithFrame:frame]) {
			UILongPressGestureRecognizer * longTab = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
			longTab.delegate = self;
			[self addGestureRecognizer:longTab];
			self.layer.borderWidth = 0.0f;
			self.layer.borderColor = [UIColor redColor].CGColor;
		}
		return self;
	}

	- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer {
		
		if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
			self.layer.borderWidth = 0.0f;
		}
		else if(gestureRecognizer.state == UIGestureRecognizerStateChanged && self.layer.borderWidth > 0.0f) {
			CGPoint touchPoint = [gestureRecognizer locationInView:self.superview];
			CGRect newRect = CGRectMake(touchPoint.x - originPoint.x, touchPoint.y - originPoint.y, self.frame.size.width, self.frame.size.height);
			self.frame = newRect;
		}
		else if (gestureRecognizer.state == UIGestureRecognizerStateBegan){
			self.layer.borderWidth = 10.0f;
			originPoint = [gestureRecognizer locationInView:self];
		}
	}
@end

@implementation SampleView


@end
