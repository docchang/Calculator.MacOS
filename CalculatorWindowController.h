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
	IBOutlet CalculatorBrain* brain;
	
	IBOutlet NSTextField *display;
	IBOutlet NSTextField *displaywaitingOperation;
	IBOutlet NSTextField *displayMemory;

	BOOL userIsInTheMiddleOfTypingANumber;
}

@property(readonly) CalculatorBrain *brain;

- (IBAction)digitPressed:(NSButton *)sender;		//digits
- (IBAction)operationPressed:(NSButton *)sender;	//operations
- (IBAction)memPressed:(NSButton *)sender;			//memory operations

@end
