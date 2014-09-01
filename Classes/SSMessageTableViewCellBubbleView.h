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
    UITextView *_messageTextView;
	NSString *_detailText;
	UIColor *_detailTextColor;
	UIColor *_detailBackgroundColor;
	UIImage *_leftBackgroundImage;
	UIImage *_rightBackgroundImage;
	SSMessageStyle _messageStyle;
}

@property (nonatomic, copy) NSString *messageText;
@property (nonatomic, retain) UITextView *messageTextView;
@property (nonatomic, copy) NSString *detailText;
@property (nonatomic, retain) UIColor *detailTextColor;
@property (nonatomic, retain) UIColor *detailBackgroundColor;
@property (nonatomic, retain) UIImage *leftBackgroundImage;
@property (nonatomic, retain) UIImage *rightBackgroundImage;
@property (nonatomic, assign) SSMessageStyle messageStyle;

+ (CGSize)textSizeForText:(NSString *)text;
+ (CGSize)bubbleSizeForText:(NSString *)text;
+ (CGFloat)cellHeightForText:(NSString *)text;

@end
