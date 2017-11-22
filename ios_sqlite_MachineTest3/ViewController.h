//
//  ViewController.h
//  ios_sqlite_MachineTest3
//
//  Created by Student 01 on 21/11/17.
//  Copyright © 2017 mohiniw. All rights reserved.
//
//For some Hospital insert patient name,DoctorName,ward number. Display all information in table view. 
#import <UIKit/UIKit.h>
#import "HosDb.h"
#import "hospitalTableViewCell.h"
@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *patientNameLb;
@property (weak, nonatomic) IBOutlet UILabel *doctorNameLb;

@property (weak, nonatomic) IBOutlet UILabel *wardNumberLb;

@property (weak, nonatomic) IBOutlet UITextField *patientNameText;
@property (weak, nonatomic) IBOutlet UITextField *doctorNameText;

@property (weak, nonatomic) IBOutlet UITextField *wardNumberText;

- (IBAction)insertBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property NSArray *patientNameArray;
@property NSArray *DoctorNameArray;
@property NSArray *wardNumberArray;

@property NSString *DName;
@property NSString *pName;
@property NSString *WNumber;
@end

