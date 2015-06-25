//
//  POLWalletText.m
//  Wallet
//
//  Created by Pawel Walicki on 6/6/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "POLBroker.h"
#import "POLMoney.h"
#import "POLWallet.h"


@interface POLWalletTest : XCTestCase

@end

@implementation POLWalletTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void) testAdditionWithReduction{
    
    POLBroker *broker = [[POLBroker alloc] init];
    [broker addRate:2 fromCurrency:@"EUR" toCurrency:@"USD"];
    
    POLWallet *wallet = [[POLWallet alloc] initWithAmount:40 currency:@"EUR"];
    [wallet plus: [POLMoney dollarWithAmount:20]];
    
    POLMoney *reduced = [broker reduce:wallet toCurrency:@"USD"];
    
    XCTAssertEqualObjects(reduced, [POLMoney dollarWithAmount:100], @"€40 + $20 = $100 2:1");
    
}

@end

