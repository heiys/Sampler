//
//  CommonObject.h
//  Sampler
//
//  Created by song on 2016. 2. 17..
//  Copyright © 2016년 song. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum ObjectType {
	ObjTypeView = 0,
	ObjTypeImageView = 1,
	ObjTypeButton = 2,
	ObjTypeLabel = 3
} ObjectType;

@interface CommonObject : UIView <UIGestureRecognizerDelegate> {
	CGPoint originPoint;
}
@end
