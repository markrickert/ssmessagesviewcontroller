//
//  SSMessageTableViewCellBubbleView.m
//  Messages
//
//  Created by Sam Soffes on 3/10/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "SSMessageTableViewCellBubbleView.h"


#define IMAGE_WIDTH     40
#define IMAGE_HEIGHT    40
#define IMAGE_PADDING   3


#define kFont [UIFont systemFontOfSize:15.0]
#define kDetailFont [UIFont systemFontOfSize:11.0]


static UILineBreakMode kLineBreakMode = UILineBreakModeWordWrap;
static CGFloat kMaxWidth = 223.0f - (IMAGE_WIDTH + (2*IMAGE_PADDING)); // TODO: Make dynamic
static CGFloat kPaddingTop = 4.0f;
static CGFloat kPaddingBottom = 8.0f;
static CGFloat kMarginTop = 2.0f;
static CGFloat kMarginBottom = 2.0f;

@implementation SSMessageTableViewCellBubbleView

@synthesize messageText = _messageText;
@synthesize detailText = _detailText;
@synthesize detailTextColor = _detailTextColor;
@synthesize detailBackgroundColor = _detailBackgroundColor;
@synthesize leftBackgroundImage = _leftBackgroundImage;
@synthesize rightBackgroundImage = _rightBackgroundImage;
@synthesize messageStyle = _messageStyle;
@synthesize userImg = _userImg;
@synthesize buddyImg = _buddyImg;

#pragma mark Class Methods

+ (CGSize)textSizeForText:(NSString *)text {
	CGSize maxSize = CGSizeMake(kMaxWidth - 35.0f, 1000.0f);
	return [text sizeWithFont:kFont constrainedToSize:maxSize lineBreakMode:kLineBreakMode];
}

+ (CGSize)textSizeForText:(NSString *)text withFont:(UIFont *)font {
	CGSize maxSize = CGSizeMake(kMaxWidth - 35.0f, 1000.0f);
	return [text sizeWithFont:font constrainedToSize:maxSize lineBreakMode:kLineBreakMode];
}


+ (CGSize)bubbleSizeForText:(NSString *)text {
	CGSize textSize = [self textSizeForText:text];
	return CGSizeMake(textSize.width + 35.0f+IMAGE_PADDING+IMAGE_WIDTH, textSize.height + kPaddingTop + kPaddingBottom);
}


+ (CGFloat)cellHeightForText:(NSString *)text {
    if ([self bubbleSizeForText:text].height > IMAGE_HEIGHT+IMAGE_PADDING) {
        return [self bubbleSizeForText:text].height + kMarginTop + kMarginBottom;
    }else{
        return IMAGE_HEIGHT+IMAGE_PADDING + kMarginTop + kMarginBottom;
    }
	
}


#pragma mark NSObject

- (void)dealloc {
	[_messageText release];
	[_detailText release];
	[_detailTextColor release];
	[_detailBackgroundColor release];
	[_leftBackgroundImage release];
	[_rightBackgroundImage release];
    [_userImg release];
	[super dealloc];
}


#pragma mark UIView

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		self.backgroundColor = [UIColor clearColor];
	}
	return self;
}


- (void)drawRect:(CGRect)frame {
    
    //user avatar image view
    
    CGRect imgFrame = CGRectMake(0, 0, IMAGE_WIDTH, IMAGE_HEIGHT);
    imgFrame.origin.y = kPaddingTop;

    UIImage *userPic;
    
    if (_messageStyle == SSMessageStyleLeft) {
        imgFrame.origin.x = IMAGE_PADDING;
        userPic  = self.buddyImg;
    }else{
        imgFrame.origin.x = self.frame.size.width - (IMAGE_PADDING+IMAGE_WIDTH);
        userPic  = self.userImg;
    }
    
    
	//Bubble
	UIImage *bubbleImage = _messageStyle == SSMessageStyleLeft ? _leftBackgroundImage : _rightBackgroundImage;
	CGSize bubbleSize = [[self class] bubbleSizeForText:_messageText];
	CGRect bubbleFrame = CGRectMake((_messageStyle == SSMessageStyleRight ? self.frame.size.width - bubbleSize.width : 0.0f+ imgFrame.size.width), kMarginTop, bubbleSize.width - imgFrame.size.width, bubbleSize.height);
	
	//Message
	CGSize textSize = [[self class] textSizeForText:_messageText];
	CGFloat textX = (CGFloat)bubbleImage.leftCapWidth - 3.0f + ((_messageStyle == SSMessageStyleRight) ? bubbleFrame.origin.x : 0.0f+IMAGE_WIDTH+IMAGE_PADDING);
	CGRect textFrame = CGRectMake(textX, kPaddingTop + kMarginTop, textSize.width, textSize.height);

	//DetailLabel
	if(_detailText) {
		CGSize detailTextSize = [[self class] textSizeForText:_detailText withFont:kDetailFont];
		CGFloat textX = (_messageStyle == SSMessageStyleLeft ? bubbleFrame.size.width : bubbleFrame.origin.x - detailTextSize.width);
		CGRect detailFrame = CGRectMake(textX, textFrame.origin.y + textFrame.size.height - detailTextSize.height, detailTextSize.width, detailTextSize.height);
		
		//Background
		int detailTextPadding = 3;
		CGRect detailBackgroundFrame;
		if(_messageStyle == SSMessageStyleLeft){
            detailBackgroundFrame = CGRectMake(detailFrame.origin.x - 10 +IMAGE_PADDING, detailFrame.origin.y - detailTextPadding, detailFrame.size.width + 10 + detailTextPadding, detailFrame.size.height + (detailTextPadding * 2));
            
        }else{
            detailBackgroundFrame = CGRectMake(detailFrame.origin.x - detailTextPadding, detailFrame.origin.y - detailTextPadding, detailFrame.size.width + (10 * 2) + detailTextPadding, detailFrame.size.height + (detailTextPadding * 2));	
        }
			
					

		if(_detailTextColor == nil)_detailTextColor = [UIColor blackColor];
		if(_detailBackgroundColor == nil)_detailBackgroundColor = [UIColor whiteColor];

		CGContextRef context = UIGraphicsGetCurrentContext();
		CGContextSetFillColorWithColor(context, [_detailBackgroundColor CGColor]);
		CGContextFillRect(context, detailBackgroundFrame);
		
		// DRAW TEXT
		[_detailTextColor set];
		[_detailText drawInRect:detailFrame withFont:kDetailFont];
	}

	[[UIColor blackColor] set];
	[bubbleImage drawInRect:bubbleFrame];
    [userPic drawInRect:imgFrame];
	[_messageText drawInRect:textFrame withFont:kFont lineBreakMode:kLineBreakMode alignment:(_messageStyle == SSMessageStyleRight) ? UITextAlignmentRight : UITextAlignmentLeft];
}

@end
