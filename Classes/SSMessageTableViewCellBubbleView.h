//
//  SSMessageTableViewCellBubbleView.h
//  Messages
//
//  Created by Sam Soffes on 3/10/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "SSMessageTableViewCell.h"




@interface SSMessageTableViewCellBubbleView : UIView {

@private
	
	NSString *_messageText;
	NSString *_detailText;
	UIColor *_detailTextColor;
	UIColor *_detailBackgroundColor;
	UIImage *_leftBackgroundImage;
	UIImage *_rightBackgroundImage;
	SSMessageStyle _messageStyle;
    UIImage *_userImg;
    UIImage *_buddyImg;
}

@property (nonatomic, copy) NSString *messageText;
@property (nonatomic, copy) NSString *detailText;
@property (nonatomic, retain) UIColor *detailTextColor;
@property (nonatomic, retain) UIColor *detailBackgroundColor;
@property (nonatomic, retain) UIImage *leftBackgroundImage;
@property (nonatomic, retain) UIImage *rightBackgroundImage;
@property (nonatomic, retain) UIImage *userImg;
@property (nonatomic, retain) UIImage *buddyImg;
@property (nonatomic, assign) SSMessageStyle messageStyle;

+ (CGSize)textSizeForText:(NSString *)text;
+ (CGSize)bubbleSizeForText:(NSString *)text;
+ (CGFloat)cellHeightForText:(NSString *)text;

@end
