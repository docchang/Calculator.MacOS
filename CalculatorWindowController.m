//
//  CalculatorWindowController.m
//  Calculator
//
//  Created by Dominic Chang on 12/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.


#import "CalculatorWindowController.h"

@implementation CalculatorWindowController

@synthesize brain;

- (IBAction)digitPressed:(NSButton *)sender{
	NSString *digit = sender.title; //	[display setStringValue:digit];		
	NSString *displayText = [display stringValue];

	//prevent unnecessary leading zeros "00000"
	if ([@"0" isEqual:digit] && [@"0" isEqual:displayText]){
		userIsInTheMiddleOfTypingANumber = NO;
		return;
	}
	
	if (userIsInTheMiddleOfTypingANumber) {	
		//if it's not a decimal or decimal is pressed but no decimal exist in the display value
		if (![@"." isEqual:digit] || ([@"." isEqual:digit] && [displayText rangeOfString:@"."].location == NSNotFound)){			
			displayText = [displayText stringByAppendingString:digit];
		}
	} else {
		displayText = digit;		 	
		userIsInTheMiddleOfTypingANumber = YES; 
		[self.brain notwaitingForOperand]; //reset not waiting for operand
	}
	[display setStringValue:displayText];
}

- (IBAction)operationPressed:(NSButton *)sender{
	
	//getting the NSString of the operation: +, -, *, /, =, sqrt, etc...
	NSString *operation = sender.title;
	
	if (userIsInTheMiddleOfTypingANumber || [@"=" isEqual:operation]) {		
		self.brain.operand = [display doubleValue];
		userIsInTheMiddleOfTypingANumber = NO;
	}
	
	double result = [self.brain performOperation:operation];
	
	if ( isnan(result) || isinf(result) ) {
		[display setStringValue: @"Overflow"];
	} else {
		if ([@"=" isEqual:operation]){
			[displaywaitingOperation setStringValue:@""];
		}else {
			[displaywaitingOperation setStringValue:self.brain.waitingOperation];
		}
		[display setStringValue: [NSString stringWithFormat:@"%2.15g", result]];
	}
}

- (IBAction)memPressed:(NSButton *)sender{
	NSString *operation = sender.title; //Operation: MC, M+, M-, MR
	double displayValue = [display doubleValue];
	NSString *displayMemoryText = [displayMemory stringValue];
	
	if ([@"M+" isEqual:operation]) {
		[self.brain memAdd:displayValue];
		[displayMemory setStringValue: @"M"];
	}else if ([@"M-" isEqual:operation]) {
		[self.brain memSub:displayValue];
		[displayMemory setStringValue: @"M"];
	}else if ([@"MR" isEqual:operation]) {
		self.brain.operand = self.brain.memOperand;
		[display setStringValue: [NSString stringWithFormat:@"%2.15g", self.brain.memOperand]];
	}else if ([@"M" isEqual:displayMemoryText] && [@"MC" isEqual:operation]){
		[self.brain memClear];
		[displayMemory setStringValue: @""];
	}
}

@end
