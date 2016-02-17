//
//  SamplerHelper.m
//  Sampler
//
//  Created by SongH on 2015. 2. 2..
//  Copyright (c) 2015년 song. All rights reserved.
//

#import "SamplerHelper.h"

@implementation SamplerHelper

+ (SamplerHelper *)sharedInstance
{
	static SamplerHelper * instance;

	if (instance != nil)
		return instance;
	static dispatch_once_t once;
	
	dispatch_once(&once, ^{
		instance = [SamplerHelper new];
	});
	return instance;
}

@end
