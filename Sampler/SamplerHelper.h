//
//  SamplerHelper.h
//  Sampler
//
//  Created by SongH on 2015. 2. 2..
//  Copyright (c) 2015년 song. All rights reserved.
//

#import <Foundation/Foundation.h>

#define lstr(s) NSLocalizedString(s, nil)

@interface SamplerHelper : NSObject
+ (SamplerHelper *)sharedInstance;
@end
