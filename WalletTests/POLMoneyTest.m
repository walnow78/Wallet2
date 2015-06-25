//
//  POLMoneyTest.m
//  Wallet
//
//  Created by Pawel Walicki on 6/6/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

@import Foundation;
#import <XCTest/XCTest.h>
#import "POLMoney.h"

@interface POLMoneyTests : XCTestCase

@end

@implementation POLMoneyTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void) testThatInitDoesNotRaiseException{
    
    
    XCTAssertNoThrow([POLMoney dollarWithAmount:3]);
    XCTAssertNoThrow([POLMoney euroWithAmount:3]);
    
}


-(void) testCurrency{
    
    POLMoney *dollars = [POLMoney dollarWithAmount:1];
    
    XCTAssertEqualObjects(@"USD", [dollars currency]);
    
    POLMoney *euros = [POLMoney euroWithAmount:1];
    
    XCTAssertEqualObjects(@"EUR", [euros currency]);
    
}


-(void) testMultiplication{
    
    
    POLMoney *five = [POLMoney euroWithAmount:5];
    POLMoney *product = [five times: 2];
    XCTAssertEqualObjects(product, [POLMoney euroWithAmount:10]);
    
    
    POLMoney *fiveUSD = [POLMoney dollarWithAmount:5];
    POLMoney *productUSD = [fiveUSD times:2];
    
    XCTAssertEqualObjects(productUSD, [POLMoney dollarWithAmount:10]);
    
}

-(void) testEquality{
    
    POLMoney *five = [POLMoney euroWithAmount:5];
    POLMoney *otherFive = [POLMoney euroWithAmount:5];
    
    XCTAssertEqualObjects(five, otherFive);
    
    POLMoney *seven = [POLMoney euroWithAmount:7];
    
    XCTAssertNotEqualObjects(seven, five);
    
}

-(void) testHash{
    
    POLMoney *a = [POLMoney euroWithAmount:5];
    POLMoney *b = [POLMoney euroWithAmount:5];
    
    XCTAssertEqual([a hash], [b hash]);
    
    XCTAssertEqual([[POLMoney dollarWithAmount:1] hash], [[POLMoney dollarWithAmount:1] hash]);
    
}

-(void) testAmountStorage{
    
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    
    
    POLMoney *euro = [POLMoney euroWithAmount:2];
    XCTAssertEqual(2, [[euro performSelector:@selector(amount)]integerValue]);
    
    POLMoney *dollar = [POLMoney dollarWithAmount:2];
    XCTAssertEqual(2, [[dollar performSelector:@selector(amount)]integerValue]);
    
#pragma clan diagnostic pop
    
}

-(void) testDifferentCurrenties{
    
    POLMoney *euro = [POLMoney euroWithAmount:1];
    POLMoney *dollar = [POLMoney dollarWithAmount:1];
    
    XCTAssertNotEqualObjects(euro, dollar);
    
}

-(void) testSimpleAddition{
    
    XCTAssertEqualObjects([[POLMoney dollarWithAmount:5] plus:[POLMoney dollarWithAmount:5]], [POLMoney dollarWithAmount:10]);
}


-(void) testThatHashIsAmount{
    
    POLMoney *one = [POLMoney dollarWithAmount:1];
    XCTAssertEqual([one hash], 1, @"The must hash must be the same as the amount");
    
}

-(void) testDescription{
    
    POLMoney *one = [POLMoney dollarWithAmount:1];
    NSString *description = @"<POLMoney: USD 1>";
    
    XCTAssertEqualObjects(description, [one description], @"Description must match templete");
    
}





@end
