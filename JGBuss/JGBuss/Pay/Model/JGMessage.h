//
//  JGMessage.h
//  JGBuss
//
//  Created by apple on 16/4/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AVIMTextMessage.h"

typedef enum {
    XMGMessageTypeMe = 0,
    XMGMessageTypeOther = 1
} JGMessageType;

@interface JGMessage : AVIMTextMessage

@property (nonatomic, assign) JGMessageType type;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
/** 是否隐藏时间 */
@property (nonatomic, assign, getter=isHideTime) BOOL hideTime;



@end
