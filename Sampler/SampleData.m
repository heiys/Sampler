//
//  SampleData.m
//  Sampler
//
//  Created by Song Hur on 2014. 11. 25..
//  Copyright (c) 2014년 song. All rights reserved.
//

#import "SampleData.h"

@implementation SampleData

+(SampleData *)sampleWithDict:(NSDictionary *)dict;
{
	return [[self alloc] initWithDictionary:dict];
}

- (id)initWithDictionary:(NSDictionary *)dict
{
	if ((self = [super init]))
	{
 		[self setValuesForKeysWithDictionary:dict];
		return self;
	}
	return	nil;
}

- (void)setId:(NSString *)dataId
{
	_dataId = [dataId isKindOfClass:[NSString class]] ? dataId : nil;
}

- (void)setType:(NSString *)dataType
{
	_dataType = [dataType isKindOfClass:[NSString class]] ? dataType : nil;
}

- (void)setTitle:(NSString *)dataName
{
	_dataName = [dataName isKindOfClass:[NSString class]] ? dataName : nil;
}

- (id)initWithCoder:(NSCoder *)decoder
{
	if (self = [super init])
	{
		self.dataId = [decoder decodeObjectForKey:@"_dataId"];
		self.dataType = [decoder decodeObjectForKey:@"_dataType"];
		self.dataName = [decoder decodeObjectForKey:@"_dataName"];

	}
	return self;
}
- (void)encodeWithCoder:(NSCoder *)encoder
{
	[encoder encodeObject:_dataId forKey:@"_dataId"];
	[encoder encodeObject:_dataType forKey:@"_dataType"];
	[encoder encodeObject:_dataName forKey:@"_dataName"];
}
@end

@implementation SampleLabelData

+(SampleLabelData *)sampleWithDict:(NSDictionary *)dict;
{
	SampleLabelData * data = [[self alloc] initWithDictionary:dict];
	return data;
}

- (void)setData:(NSMutableDictionary *)attributedStr
{
	_attributedStr = [attributedStr isKindOfClass:[NSDictionary class]] ? attributedStr : nil;
}

- (id)initWithCoder:(NSCoder *)decoder
{
	if (self = [super init])
	{
		_attributedStr = [decoder decodeObjectForKey:@"_attributedStr"];
	}
	return self;
}
- (void)encodeWithCoder:(NSCoder *)encoder
{
	[super encodeWithCoder:encoder];
	[encoder encodeObject:_attributedStr forKey:@"_attributedStr"];
}
@end
