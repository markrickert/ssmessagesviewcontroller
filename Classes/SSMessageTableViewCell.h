//
//  SSMessageTableViewCell.h
//  Messages
//
//  Created by Sam Soffes on 3/10/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

typedef enum {
	SSMessageStyleLeft = 0,
	SSMessageStyleRight = 1
} SSMessageStyle;

@class SSMessageTableViewCellBubbleView;

@interface SSMessageTableViewCell : UITableViewCell {

@private
	
	SSMessageTableViewCellBubbleView *_bubbleView;
    NSArray *links;
}

@property (nonatomic, copy) NSString *messageText;
@property (nonatomic, copy) NSString *detailText;
@property (nonatomic, copy) UIColor *detailTextColor;
@property (nonatomic, copy) UIColor *detailBackgroundColor;
@property (nonatomic, assign) SSMessageStyle messageStyle;
@property (nonatomic, retain) NSArray *links;

- (void)setBackgroundImage:(UIImage *)backgroundImage forMessageStyle:(SSMessageStyle)messsageStyle;

@end
