//
//  DetailViewController.h
//  MyStuff
//
//  Created by Prasong on 4/08/2014.
//  Copyright (c) 2014 Prasong Techapanyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyWhatsit.h"
@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) MyWhatsit *detailItem;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *locationField;
-(IBAction)changeDetail:(id)sender;

@end

