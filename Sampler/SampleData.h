//
//  SampleData.h
//  Sampler
//
//  Created by Song Hur on 2014. 11. 25..
//  Copyright (c) 2014년 song. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
	kLabelDataType = 0
} DataType;

@interface SampleData : NSObject <NSCoding>
@property (nonatomic) NSString * dataType;
@property (nonatomic) NSString * dataId;
@property (nonatomic) NSString * dataName;

+(SampleData *)sampleWithDict:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
@end

@interface SampleLabelData : SampleData
+(SampleLabelData *)sampleWithDict:(NSDictionary *)dict;
@property (nonatomic) NSMutableDictionary * attributedStr;
@end