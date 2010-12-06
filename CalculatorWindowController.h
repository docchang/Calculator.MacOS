//
//  CalculatorWindowController.h
//  Calculator
//
//  Created by Dominic Chang on 12/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CalculatorBrain.h"

@interface CalculatorWindowController : NSWindowController {
	
	IBOutlet NSTextField *display;
	IBOutlet NSTextField *displaywaitingOperation;
	IBOutlet NSTextField *displayMemory;

@private
	IBOutlet CalculatorBrain* brain;
	BOOL userIsInTheMiddleOfTypingANumber;
}

- (IBAction)digitPressed:(NSButton *)sender;		//digits
- (IBAction)operationPressed:(NSButton *)sender;	//operations
- (IBAction)memPressed:(NSButton *)sender;			//memory operations

@end
