//
//  SSMessageTableViewCellBubbleView.m
//  Messages
//
//  Created by Sam Soffes on 3/10/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "SSMessageTableViewCellBubbleView.h"

#define kFont [UIFont systemFontOfSize:15.0]
#define kDetailFont [UIFont systemFontOfSize:11.0]
static UILineBreakMode kLineBreakMode = UILineBreakModeWordWrap;
static CGFloat kMaxWidth = 223.0f; // TODO: Make dynamic
static CGFloat kPaddingTop = 4.0f;
static CGFloat kTextMarginTop = -2.0f;
static CGFloat kPaddingBottom = 8.0f;
static CGFloat kMarginTop = 2.0f;
static CGFloat kMarginBottom = 2.0f;

@implementation SSMessageTableViewCellBubbleView

@synthesize messageText = _messageText;
@synthesize messageTextView = _messageTextView;
@synthesize detailText = _detailText;
@synthesize detailTextColor = _detailTextColor;
@synthesize detailBackgroundColor = _detailBackgroundColor;
@synthesize leftBackgroundImage = _leftBackgroundImage;
@synthesize rightBackgroundImage = _rightBackgroundImage;
@synthesize messageStyle = _messageStyle;

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
	return CGSizeMake(textSize.width + 35.0f, textSize.height + kPaddingTop + kPaddingBottom);
}


+ (CGFloat)cellHeightForText:(NSString *)text {
	return [self bubbleSizeForText:text].height + kMarginTop + kMarginBottom;
}


#pragma mark NSObject

- (void)dealloc {
	[_messageText release];
	[_detailText release];
	[_detailTextColor release];
	[_detailBackgroundColor release];
	[_leftBackgroundImage release];
	[_rightBackgroundImage release];
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
	//Bubble
	UIImage *bubbleImage = _messageStyle == SSMessageStyleLeft ? _leftBackgroundImage : _rightBackgroundImage;
	CGSize bubbleSize = [[self class] bubbleSizeForText:_messageText];
	CGRect bubbleFrame = CGRectMake((_messageStyle == SSMessageStyleRight ? self.frame.size.width - bubbleSize.width : 0.0f), kMarginTop, bubbleSize.width, bubbleSize.height);
	
	//Message
	CGSize textSize = [[self class] textSizeForText:_messageText];
	CGFloat textX = (CGFloat)bubbleImage.leftCapWidth - 12.0f + ((_messageStyle == SSMessageStyleRight) ? bubbleFrame.origin.x : 0.0f);
	CGRect textFrame = CGRectMake(textX, kTextMarginTop, textSize.width + 20, textSize.height + 10);

	//DetailLabel
	if(_detailText) {
		CGSize detailTextSize = [[self class] textSizeForText:_detailText withFont:kDetailFont];
		CGFloat textX = (_messageStyle == SSMessageStyleLeft ? bubbleFrame.size.width : bubbleFrame.origin.x - detailTextSize.width);
		CGRect detailFrame = CGRectMake(textX, textFrame.origin.y + textFrame.size.height - detailTextSize.height, detailTextSize.width, detailTextSize.height);
		
		//Background
		int detailTextPadding = 3;
		CGRect detailBackgroundFrame;
		if(_messageStyle == SSMessageStyleLeft)
			detailBackgroundFrame = CGRectMake(detailFrame.origin.x - 10, detailFrame.origin.y - detailTextPadding, detailFrame.size.width + 10 + detailTextPadding, detailFrame.size.height + (detailTextPadding * 2));
		else
			detailBackgroundFrame = CGRectMake(detailFrame.origin.x - detailTextPadding, detailFrame.origin.y - detailTextPadding, detailFrame.size.width + (10 * 2) + detailTextPadding, detailFrame.size.height + (detailTextPadding * 2));			

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
    
    // Draw UITextView
    _messageTextView = [[UITextView alloc] initWithFrame:textFrame];
    [_messageTextView setFont:kFont];
    [_messageTextView setText:_messageText];
    [_messageTextView setEditable:NO];
    [_messageTextView setScrollEnabled:NO];
    [_messageTextView setBackgroundColor:[UIColor clearColor]];
    [_messageTextView setDataDetectorTypes:UIDataDetectorTypeLink | UIDataDetectorTypePhoneNumber];
    [_messageTextView setTextAlignment:(_messageStyle == SSMessageStyleRight) ? UITextAlignmentRight : UITextAlignmentLeft];
    
    [self addSubview:_messageTextView];
    
}

@end
