//
//  ViewController.m
//  ios_sqlite_MachineTest3
//
//  Created by Student 01 on 21/11/17.
//  Copyright © 2017 mohiniw. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.patientNameText.text=self.pName;
    self.doctorNameText.text=self.DName;
    self.wardNumberText.text=self.WNumber;
    
    NSString *selectQuery=@"select * from hospitalTable";
    [[HosDb sharedObject]getAllTasks:selectQuery];
    
    self.patientNameArray=[ HosDb sharedObject].patientMutableArray;
    self.DoctorNameArray=[ HosDb sharedObject].doctorMutableArray;
    self.wardNumberArray=[ HosDb sharedObject].wardNumberMutableArray;
    

    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.patientNameText.text=self.pName;
    self.doctorNameText.text=self.DName;
    self.wardNumberText.text=self.WNumber;
    
    
    NSString *selectQuery=@"select * from hospitalTable";
    [[ HosDb sharedObject]getAllTasks:selectQuery];
    self.patientNameArray=[ HosDb sharedObject].patientMutableArray;
   self.DoctorNameArray=[ HosDb sharedObject].doctorMutableArray;
    self.wardNumberArray=[ HosDb sharedObject].wardNumberMutableArray;
    
    
    if(self.patientNameArray.count >0)
    {
        self.myTableView.delegate=self;
        self.myTableView.dataSource=self;
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.patientNameArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"myCell";
    hospitalTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil)
    {
       NSArray *cellObjects=[[NSBundle mainBundle]loadNibNamed:@"myCell" owner:self options:nil];
       cell=(hospitalTableViewCell *)[cellObjects objectAtIndex:0];
    }
    
    cell.patientLabel.text=[self.patientNameArray objectAtIndex:indexPath.row];
    cell.doctorLabel.text=[self.DoctorNameArray objectAtIndex:indexPath.row];
    cell.wardLabel.text=[self.wardNumberArray objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   hospitalTableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    self.patientNameText.text=cell.patientLabel.text;
    self.doctorNameText.text=cell.doctorLabel.text;
    self.wardNumberText.text=cell.wardLabel.text;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)insertBtn:(id)sender
{
    NSString *insertQuery=[NSString stringWithFormat:@"insert into hospitalTable(patientName,doctorName,wardNumber) values('%@','%@','%@')",self.patientNameText.text,self.doctorNameText.text,self.wardNumberText.text];
    BOOL isSuccess=[[HosDb sharedObject] executeQuery:insertQuery];
    if(isSuccess)
    {
        NSLog(@"Record inserted Successfully");
        NSString *selectQuery=@"select * from hospitalTable";
        [[ HosDb sharedObject]getAllTasks:selectQuery];
        self.patientNameArray=[ HosDb sharedObject].patientMutableArray;
        self.DoctorNameArray=[ HosDb sharedObject].doctorMutableArray;
        self.wardNumberArray=[HosDb sharedObject].wardNumberMutableArray;

        
        if(self.patientNameArray.count>0)
        {
            [self.myTableView reloadData];
        }
        self.patientNameText.text=@"";
        self.doctorNameText.text=@"";
        self.wardNumberText.text=@"";
        
        [self.patientNameText becomeFirstResponder];
    }
    else
    {
        NSLog(@"inserted Failed!!!");
    }
    
}


@end
