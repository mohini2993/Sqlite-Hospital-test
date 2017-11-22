//
//  hospitalTableViewCell.h
//  ios_sqlite_MachineTest3
//
//  Created by Student 01 on 21/11/17.
//  Copyright © 2017 mohiniw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
@interface hospitalTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *patientLabel;
@property (weak, nonatomic) IBOutlet UILabel *doctorLabel;

@property (weak, nonatomic) IBOutlet UILabel *wardLabel;



@end
