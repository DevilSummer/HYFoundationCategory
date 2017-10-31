//
//  ViewController.m
//  HYFoundationCategory
//
//  Created by ocean on 2017/10/30.
//  Copyright © 2017年 ocean. All rights reserved.
//

#import "ViewController.h"
#import "NSDictionary+HYCategory.h"
#import "NSObject+HYCategory.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    //todo NSNull 和 nil 
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setObject:[NSNull null] forKey:@"key"];

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNull null] forKey:@"key"];
    
    id value = [dict objectForKey:@"key"];
    if (![NSObject hy_isNull:value]) {
        NSLog(@"不为空");
    } else {
        NSLog(@"为空");
    }
    
    id value2 = [dict objectForKey:@"key2"];
    if (![NSObject hy_isNull:value2]) {
        NSLog(@"不为空");
    } else {
        NSLog(@"为空");
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
