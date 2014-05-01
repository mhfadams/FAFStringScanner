//
//  FAFStringScannerMainTests.m
//  FAFStringScannerTester
//
//  Created by Manoah F Adams on 2014-05-01.
//  Copyright 2014 Manoah F. Adams. All rights reserved.
//

#import "FAFStringScannerMainTests.h"
#import "FAFStringScanner.h"


@implementation FAFStringScannerMainTests

- (void) setUp 
{ 
    // Create data structures here.
	NSLog(@"SET UP");

	
} 

- (void) tearDown 
{ 
    // Release data structures here. 
	NSLog(@"TEAR DOWN");
} 



- (void) test_readRemainder
{
	FAFStringScanner* scanner = [[FAFStringScanner alloc] initWithString:@"BEGIN: A sample string :END"];
	
	NSString* result = [scanner readRemainder];
	STAssertEqualObjects(result, @"BEGIN: A sample string :END", @"readRemainder returned wrong value");
	
	[scanner release];
}

- (void) test_readBalanced_parenthesis
{
	FAFStringScanner* scanner = [[FAFStringScanner alloc] initWithString:@"(Happy days are here again)"];
	
	NSString* result = [scanner readBalanced];
	STAssertEqualObjects(result, @"(Happy days are here again)", @"readRemainder returned wrong value");
	
	[scanner release];
}

- (void) test_readBalanced_bracket
{
	FAFStringScanner* scanner = [[FAFStringScanner alloc] initWithString:@"[Happy days are here again]"];
	
	NSString* result = [scanner readBalanced];
	STAssertEqualObjects(result, @"[Happy days are here again]", @"readRemainder returned wrong value");
	
	[scanner release];
}

- (void) test_readBalanced_brace
{
	FAFStringScanner* scanner = [[FAFStringScanner alloc] initWithString:@"{Happy days are here again}"];
	
	NSString* result = [scanner readBalanced];
	STAssertEqualObjects(result, @"{Happy days are here again}", @"readRemainder returned wrong value");
	
	[scanner release];
}

- (void) test_readBalanced_quote
{
	FAFStringScanner* scanner = [[FAFStringScanner alloc] initWithString:@"\"Happy days are here again\""];
	
	NSString* result = [scanner readBalanced];
	STAssertEqualObjects(result, @"\"Happy days are here again\"", @"readRemainder returned wrong value");
	
	[scanner release];
}

- (void) test_readBalanced_all
{
	FAFStringScanner* scanner = [[FAFStringScanner alloc] initWithString:@"{([\"Happy {days are here again\"[)}"];
	
	NSString* result = [scanner readBalanced];
	STAssertEqualObjects(result, @"{([\"Happy {days are here again\"[)}", @"readRemainder returned wrong value");
	
	[scanner release];
}



@end
