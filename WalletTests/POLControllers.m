//
//  POLControllers.m
//  Wallet
//
//  Created by Pawel Walicki on 6/6/15.
//  Copyright (c) 2015 Pawel Walicki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "POLWaletTableViewController.h"
#import "POLWallet.h"

@interface POLControllers : XCTestCase

@property(nonatomic,strong) POLWaletTableViewController *walletVC;
@property(nonatomic,strong) POLWallet *wallet;

@end

@implementation POLControllers

- (void)setUp {
    [super setUp];
    
    self.wallet = [[POLWallet alloc] initWithAmount:1 currency:@"USD"];
    [self.wallet plus:[POLMoney euroWithAmount:1]];
    
    self.walletVC = [[POLWaletTableViewController alloc] initWithModel:self.wallet];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    self.walletVC = nil;
    self.wallet = nil;
}



-(void)testCountCurrencies {
    
    POLWallet *wallet = [[POLWallet alloc] initWithAmount:1 currency:@"EUR"];
    
    [wallet plus:[POLMoney dollarWithAmount:1]];
    
    NSInteger numberOfCurrencies = wallet.countCurrencies;
    
    XCTAssertEqual(numberOfCurrencies, 2);
}


-(void)testCountEuros {
    
    
    POLWallet *wallet = [[POLWallet alloc] initWithAmount:1 currency:@"EUR"];
    
    [wallet plus:[POLMoney euroWithAmount:1]];
    
    NSInteger numberOfEuros = wallet.countEuros;
    
    XCTAssertEqual(numberOfEuros, 2);
}


-(void)testCountDollars {
    
    POLWallet *wallet = [[POLWallet alloc] initWithAmount:1 currency:@"USD"];
    
    [wallet plus:[POLMoney dollarWithAmount:1]];
    
    NSInteger numberOfDollars = wallet.countDollars;
    
    XCTAssertEqual(numberOfDollars, 2);
}
@end
