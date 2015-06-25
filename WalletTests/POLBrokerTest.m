//
//  POLBrokerTest.m
//  Wallet
//
//  Created by Pawel Walicki on 6/6/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "POLBroker.h"
#import "POLMoney.h"

@interface POLBrokerTest : XCTestCase

@property(nonatomic,strong) POLBroker *emptyBroker;
@property(nonatomic, strong) POLMoney *oneDollar;

@end

@implementation POLBrokerTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.emptyBroker = [[POLBroker alloc] init];
    self.oneDollar = [[POLMoney alloc] initWithAmount:1 currency:@"USD"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    self.emptyBroker = nil;
    self.oneDollar = nil;
}


- (void) testSimpleReduction{
    
    
    POLMoney *sum =  [[POLMoney dollarWithAmount:5] plus:[POLMoney dollarWithAmount:5]];
    
    POLMoney *reduced = [self.emptyBroker reduce:sum toCurrency:@"USD"];
    
    XCTAssertEqualObjects(sum, reduced, @"Conversion to same currency should be a NOP");
    
}

// $10 == €5 2:1

-(void) testReduction{
    
    
    [self.emptyBroker addRate:2 fromCurrency:@"EUR" toCurrency:@"USD"];
    
    
    POLMoney *dollars = [POLMoney dollarWithAmount:10];
    POLMoney *euros = [POLMoney euroWithAmount:5];
    
    POLMoney *converted = [self.emptyBroker reduce:dollars toCurrency:@"EUR"];
    
    XCTAssertEqualObjects(converted, euros, @"$10 == €5 2:1");
    
    
}

-(void) testThathNoRateRaiseException{
    
    XCTAssertThrows([self.emptyBroker reduce:self.oneDollar toCurrency:@"EUR"], @"No rate should cause exception");
    
}

-(void) testThatNilConversionDoesNotChangeMoney{
    
    XCTAssertEqualObjects(self.oneDollar, [self.emptyBroker reduce:self.oneDollar toCurrency:@"USD"], @"A nil conversion should have no effect");
    
}

@end
