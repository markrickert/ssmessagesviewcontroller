//
//  SSMessagesViewController.m
//  Messages
//
//  Created by Sam Soffes on 3/10/10.
//  Copyright 2010-2011 Sam Soffes. All rights reserved.
//

#import "SSMessagesViewController.h"
#import "SSMessageTableViewCell.h"
#import "SSMessageTableViewCellBubbleView.h"
#import "SSTextField.h"

CGFloat kInputHeight = 40.0f;

@implementation SSMessagesViewController

@synthesize tableHeaderView = _tableHeaderView;
@synthesize tableView = _tableView;
@synthesize tableViewContentOffset;
@synthesize inputBackgroundView = _inputBackgroundView;
@synthesize textField = _textField;
@synthesize cameraButton = _cameraButton;
@synthesize sendButton = _sendButton;
@synthesize leftBackgroundImage = _leftBackgroundImage;
@synthesize rightBackgroundImage = _rightBackgroundImage;

#pragma mark NSObject

- (void)dealloc {
	self.leftBackgroundImage = nil;
	self.rightBackgroundImage = nil;
	[_tableView release];
	[_inputBackgroundView release];
	[_textField release];
	[_sendButton release];
	[super dealloc];
}

#pragma mark UIViewController

- (void)viewDidLoad {
	self.view.backgroundColor = [UIColor colorWithRed:0.859f green:0.886f blue:0.929f alpha:1.0f];
	
	CGSize size = self.view.frame.size;
	
	// Table view
	_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, size.width, size.height - kInputHeight) style:UITableViewStylePlain];
	_tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	_tableView.backgroundColor = self.view.backgroundColor;
	_tableView.dataSource = self;
	_tableView.delegate = self;
	_tableView.separatorColor = self.view.backgroundColor;
	[self.view addSubview:_tableView];
    
    tableViewContentOffset = CGPointZero;
    
    // Table header view
    if(_tableHeaderView) {
        [_tableView setTableHeaderView:_tableHeaderView];
    }
	
	// Input
	_inputBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, size.height - kInputHeight, size.width, kInputHeight)];
	_inputBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
	_inputBackgroundView.image = [UIImage imageNamed:@"SSMessagesViewControllerInputBackground.png"];
	_inputBackgroundView.userInteractionEnabled = YES;
	[self.view addSubview:_inputBackgroundView];
	
    // Camera button
    _cameraButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    _cameraButton.frame = CGRectMake(6.0f, 7.0f, 26.0f, 26.0f);
    [_cameraButton setBackgroundImage:[UIImage imageNamed:@"SSMessagesViewControllerCameraButton.png"] forState:UIControlStateNormal];
    [_inputBackgroundView addSubview:_cameraButton];
    
	// Text field
	_textField = [[SSTextField alloc] initWithFrame:CGRectMake(38.0f, 0.0f, size.width - 114.0f, kInputHeight)];
	_textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	_textField.backgroundColor = [UIColor whiteColor];
	_textField.background = [[UIImage imageNamed:@"SSMessagesViewControllerTextFieldBackground.png"] stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	_textField.delegate = self;
	_textField.font = [UIFont systemFontOfSize:15.0f];
	_textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	_textField.textEdgeInsets = UIEdgeInsetsMake(4.0f, 12.0f, 0.0f, 12.0f);
    [_textField setPlaceholder:@"Meddelande"];
	[_inputBackgroundView addSubview:_textField];
	
	// Send button
	_sendButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
	_sendButton.frame = CGRectMake(size.width - 77.0f, 8.0f, 71.0f, 27.0f);
	_sendButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
	_sendButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
	_sendButton.titleLabel.shadowOffset = CGSizeMake(0.0f, -1.0f);
	[_sendButton setBackgroundImage:[[UIImage imageNamed:@"SSMessagesViewControllerSendButtonBackgroundGreen.png"] stretchableImageWithLeftCapWidth:12 topCapHeight:0] forState:UIControlStateNormal];
	[_sendButton setTitle:@"Skicka" forState:UIControlStateNormal];
	[_sendButton setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.4f] forState:UIControlStateNormal];
	[_sendButton setTitleShadowColor:[UIColor colorWithRed:0.455f green:0.671f blue:0.22f alpha:1.0f] forState:UIControlStateNormal];
	[_inputBackgroundView addSubview:_sendButton];
	
	self.leftBackgroundImage = [[UIImage imageNamed:@"SSMessageTableViewCellBackgroundClear.png"] stretchableImageWithLeftCapWidth:24 topCapHeight:14];
	self.rightBackgroundImage = [[UIImage imageNamed:@"SSMessageTableViewCellBackgroundGreen.png"] stretchableImageWithLeftCapWidth:17 topCapHeight:14];
}


#pragma mark SSMessagesViewController

// This method is intended to be overridden by subclasses
- (SSMessageStyle)messageStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	return SSMessageStyleLeft;
}


// This method is intended to be overridden by subclasses
- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath {
	return nil;
}

- (NSString *)detailTextForRowAtIndexPath:(NSIndexPath *)indexPath {
	return nil;
}

- (UIColor *)detailTextColorForRowAtIndexPath:(NSIndexPath *)indexPath {
	return nil;
}

- (UIColor *)detailBackgroundColorForRowAtIndexPath:(NSIndexPath *)indexPath {
	return nil;
}


#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellIdentifier = @"cellIdentifier";
    
	SSMessageTableViewCell *cell = (SSMessageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  if (cell == nil) {
		cell = [[[SSMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
		[cell setBackgroundImage:self.leftBackgroundImage forMessageStyle:SSMessageStyleLeft];
		[cell setBackgroundImage:self.rightBackgroundImage forMessageStyle:SSMessageStyleRight];
	}
	
  cell.messageStyle = [self messageStyleForRowAtIndexPath:indexPath];
	cell.messageText = [self textForRowAtIndexPath:indexPath];
	cell.detailText = [self detailTextForRowAtIndexPath:indexPath];
	cell.detailTextColor = [self detailTextColorForRowAtIndexPath:indexPath];
	cell.detailBackgroundColor = [self detailBackgroundColorForRowAtIndexPath:indexPath];
    
    NSDataDetector *dataDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink | NSTextCheckingTypePhoneNumber error:nil];
    
    NSArray *matches = [dataDetector matchesInString:cell.messageText options:0 range:NSMakeRange(0, [cell.messageText length])];
    
    [cell setLinks:matches];
    
    if([matches count] > 0)
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;

  return cell;
}


#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return [SSMessageTableViewCellBubbleView cellHeightForText:[self textForRowAtIndexPath:indexPath]];
}


#pragma mark UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	[UIView beginAnimations:@"beginEditing" context:_inputBackgroundView];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.25f];
	_tableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 166.0f, 0.0f);
	_tableView.scrollIndicatorInsets = _tableView.contentInset;
	_inputBackgroundView.frame = CGRectMake(0.0f, 160.0f, self.view.frame.size.width, kInputHeight);
	[_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[UIView commitAnimations];
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
	[UIView beginAnimations:@"endEditing" context:_inputBackgroundView];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.25f];
	_tableView.contentInset = UIEdgeInsetsZero;
	_tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
	_inputBackgroundView.frame = CGRectMake(0.0f, _tableView.frame.size.height, self.view.frame.size.width, kInputHeight);
	[_sendButton setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.4f] forState:UIControlStateNormal];
	[UIView commitAnimations];
}

@end
