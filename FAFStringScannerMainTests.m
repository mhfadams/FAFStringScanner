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
	STAssertEqualObjects(result, @"(Happy days are here again)", @"readBalanced returned wrong value");
	
	[scanner release];
}

- (void) test_readBalanced_bracket
{
	FAFStringScanner* scanner = [[FAFStringScanner alloc] initWithString:@"[Happy days are here again]"];
	
	NSString* result = [scanner readBalanced];
	STAssertEqualObjects(result, @"[Happy days are here again]", @"readBalanced returned wrong value");
	
	[scanner release];
}

- (void) test_readBalanced_brace
{
	FAFStringScanner* scanner = [[FAFStringScanner alloc] initWithString:@"{Happy days are here again}"];
	
	NSString* result = [scanner readBalanced];
	STAssertEqualObjects(result, @"{Happy days are here again}", @"readBalanced returned wrong value");
	
	[scanner release];
}

- (void) test_readBalanced_quote
{
	FAFStringScanner* scanner = [[FAFStringScanner alloc] initWithString:@"\"Happy days are here again\""];
	
	NSString* result = [scanner readBalanced];
	STAssertEqualObjects(result, @"\"Happy days are here again\"", @"readBalanced returned wrong value");
	
	[scanner release];
}

- (void) test_readBalanced_quote_with_escapes
{
	NSString* input = @"\"Happy days \\\"are\\\" here again\"";
	FAFStringScanner* scanner = [[FAFStringScanner alloc] initWithString:input];
	
	NSString* result = [scanner readBalanced];
	STAssertEqualObjects(result, input, @"readBalanced could not handle escaped quote.");
	
	[scanner release];
}

- (void) test_unescape_quotes
{
	NSString* input = @"Happy days \\\"are\\\" here again";
	
	NSString* result = [FAFStringScanner unescapeString:input];
	STAssertEqualObjects(result, @"Happy days \"are\" here again", @"unescapeString could not handle escaped quote.");
	
}

- (void) test_readBalanced_mixed
{
	FAFStringScanner* scanner = [[FAFStringScanner alloc] initWithString:@"{([\"Happy {days are here again\"[)}"];
	
	NSString* result = [scanner readBalanced];
	STAssertEqualObjects(result, @"{([\"Happy {days are here again\"[)}", @"readBalanced returned wrong value");
	
	[scanner release];
}

- (void) test_isAtEnd
{
	FAFStringScanner* scanner = [[FAFStringScanner alloc] initWithString:@"Happy days are here again"];
	
	[scanner advance:6];
	STAssertFalse([scanner isAtEnd], nil);
	[scanner advance:18];
	STAssertFalse([scanner isAtEnd], nil);
	[scanner advance:2];
	STAssertTrue([scanner isAtEnd], [scanner readCharacter]);
	
	[scanner release];
}

- (void) test_advance
{
	FAFStringScanner* scanner = [[FAFStringScanner alloc] initWithString:@"Happy days are here again."];
	
	int loc = [scanner scanLocation];
	[scanner advance:1];
	STAssertTrue( ([scanner scanLocation] == loc + 1) , @"Scanner did not advance by 1");
	
	loc = [scanner scanLocation];
	[scanner advance:24];
	STAssertTrue( ([scanner scanLocation] == loc + 24) , @"Scanner did not advance by 24");
	
	//loc = [scanner scanLocation];
	//[scanner advance:20];
	//STAssertTrue( ([scanner scanLocation] == loc) , @"Scanner errored on advance overflow.");
	
	[scanner advance: -50];
	STAssertTrue( ([scanner scanLocation] == 0) , @"Scanner errored on advance underflow.");
	
	[scanner release];
}

- (void) test_readCharacter
{
	FAFStringScanner* scanner = [[FAFStringScanner alloc] initWithString:@"Happy days are here again."];
	
	STAssertEqualObjects( [scanner readCharacter] , @"H" , @"Scanner failed at beginning of string.");
	
	[scanner advance:5];
	STAssertEqualObjects( [scanner readCharacter] , @"d" , @"Scanner failed in middle of string.");
	
	[scanner advance:18];
	STAssertEqualObjects( [scanner readCharacter] , @"." , @"Scanner failed at end of string.");
	
	NSString* result = [scanner readCharacter];
	STAssertNil( result , @"Scanner failed to return nil after end of string (%@).", result);
	
	[scanner release];
}

- (void) test_nextCharacter
{
	FAFStringScanner* scanner = [[FAFStringScanner alloc] initWithString:@"Happy days are here again."];
	
	STAssertEqualObjects( [scanner nextCharacter] , @"H" , @"Scanner failed at beginning of string.");
	
	[scanner advance:6];
	STAssertEqualObjects( [scanner nextCharacter] , @"d" , @"Scanner failed in middle of string.");
	
	[scanner advance:19];
	STAssertEqualObjects( [scanner nextCharacter] , @"." , @"Scanner failed at end of string.");
	
	
	[scanner release];
}

- (void) test_prevCharacter
{
	FAFStringScanner* scanner = [[FAFStringScanner alloc] initWithString:@"Happy days are here again."];
	
	[scanner advance:1];
	STAssertEqualObjects( [scanner prevCharacter] , @"H" , @"Scanner failed at beginning of string.");
	
	[scanner advance:7];
	STAssertEqualObjects( [scanner prevCharacter] , @"a" , @"Scanner failed in middle of string.");
	
	//[scanner advance:20];
	//STAssertEqualObjects( [scanner prevCharacter] , @"n" , @"Scanner failed at end of string.");
	
	
	[scanner release];
}



- (void) test_readUntilString
{
	FAFStringScanner* scanner = [[FAFStringScanner alloc] initWithString:@"Happy days are here again."];
	
	STAssertEqualObjects( [scanner readUntilString:@"days"] , @"Happy " , @"Scanner failed at beginning of string.");
	
	STAssertEqualObjects( [scanner readUntilString:@"asdasdasd"] , @"Happy days are here again." , @"Scanner failed at end of string.");
	
	STAssertEqualObjects( [scanner readUntilString:@"Happy"] , @"" , @"Scanner failed to return empty string.");
	
	STAssertEqualObjects( [scanner readUntilString:@"ys"] , @"Happy da" , @"Scanner returned too soon.");
	
	[scanner release];
}

- (void) test_readUntilStringAdvancingPast
{
	FAFStringScanner* scanner = [[FAFStringScanner alloc] initWithString:@"Happy days are\n here\n\nagain."];
	
	STAssertEqualObjects( [scanner readUntilStringAdvancingPast:@"days"] , @"Happy " , @"Scanner failed.");
	
	STAssertEqualObjects( [scanner readUntilStringAdvancingPast:@"\n"] , @" are" , @"Scanner failed given on newline.");
	
	STAssertEqualObjects( [scanner readUntilStringAdvancingPast:@"\n"] , @" here" , @"Scanner stopped at second match.");
	
	
	[scanner release];
}


- (void) test_lineCounting
{
	FAFStringScanner* scanner = [[FAFStringScanner alloc] initWithString:@"Happy days are here again.\nBut there are yet more days to come.\nHowever, this should be the last line."];
	
	[scanner readUntilStringAdvancingTo:@"again."];
	STAssertTrue([scanner lineCount] == 1, @"Scanner failed at beginning of string.");
	
	[scanner readUntilStringAdvancingTo:@"days to come."];
	STAssertTrue([scanner lineCount] == 2 , @"Scanner failed in middle of string.");
	
	[scanner readUntilStringAdvancingTo:@"last line."];
	STAssertTrue([scanner lineCount] == 3 , @"Scanner failed at end of string.");
	
	[scanner release];
}






@end
