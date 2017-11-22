//
//  HosDb.h
//  ios_sqlite_MachineTest3
//
//  Created by Student 01 on 22/11/17.
//  Copyright © 2017 mohiniw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@interface HosDb : NSObject
{
     sqlite3 *HospitalDatabase;
}
+(instancetype)sharedObject;
-(NSString *)getDatabasepath;
-(void)createDatabase;
-(BOOL)executeQuery:(NSString *)query;
-(void)getAllTasks:(NSString *)query;
@property NSMutableArray *doctorMutableArray;
@property NSMutableArray *patientMutableArray;
@property NSMutableArray *wardNumberMutableArray;

@end
