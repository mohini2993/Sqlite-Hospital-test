//
//  HosDb.m
//  ios_sqlite_MachineTest3
//
//  Created by Student 01 on 22/11/17.
//  Copyright © 2017 mohiniw. All rights reserved.
//

#import "HosDb.h"

@implementation HosDb

+(instancetype)sharedObject
{
   HosDb static *obj;
    if(obj==nil)
    {
        obj=[[HosDb alloc]init];
        
    }
    return obj;
}
-(NSString *)getDatabasepath
{
    NSString *dbpath;
    NSArray *pathDir=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
    dbpath=  [pathDir objectAtIndex:0];
    dbpath=[dbpath stringByAppendingString:@"/sqliteHospitalDatabase.db"];
    return dbpath;
}
-(BOOL)executeQuery:(NSString *)query
{
    BOOL success=0;
    const char *CQuery=[query UTF8String];
    NSString *dbPath=[self getDatabasepath];
    sqlite3_stmt *stmt;
    const char *pathOfDatabase=[dbPath UTF8String];
    if(sqlite3_open(pathOfDatabase, &HospitalDatabase)==SQLITE_OK)
    {
        if(sqlite3_prepare_v2(HospitalDatabase, CQuery, -1, &stmt, nil)!=SQLITE_OK)
        {
            NSLog(@"Database not able to Open %s",sqlite3_errmsg(HospitalDatabase));
        }
        else
        {
            
            if(sqlite3_step(stmt)==SQLITE_DONE)
            {
                success=1;
            }
        }
    }
    else
    {
        NSLog(@"Database not able to Open %s",sqlite3_errmsg(HospitalDatabase));
    }
    sqlite3_close(HospitalDatabase);
    sqlite3_finalize(stmt);
    return success;
}
-(void)createDatabase
{
    
    NSString *createQuery=@"create table if not exists hospitalTable(patientName text,doctorName text,wardNumber text)";
    BOOL createSuccess=[self executeQuery:createQuery];
    if(createSuccess==YES)
    {
        NSLog(@"Database Sucessfully created");
    }
    else
    {
        NSLog(@"Database not created");
    }
    
}
-(void)getAllTasks:(NSString *)query
{
    self.patientMutableArray=[[NSMutableArray alloc]init];
    self.doctorMutableArray=[[NSMutableArray alloc]init];
    self.wardNumberMutableArray=[[NSMutableArray alloc]init];
    const char *CQuery=[query UTF8String];
    NSString *dbPath=[self getDatabasepath];
    sqlite3_stmt *stmt;
    const char *pathOfDatabase=[dbPath UTF8String];
    if(sqlite3_open(pathOfDatabase, &HospitalDatabase)==SQLITE_OK)
    {
        if(sqlite3_prepare_v2(HospitalDatabase, CQuery, -1, &stmt, nil)!=SQLITE_OK)
        {
            NSLog(@"Database not able to prepare stmt %s",sqlite3_errmsg(HospitalDatabase));
        }
        else
        {
            
            while(sqlite3_step(stmt)==SQLITE_ROW)
            {
                const unsigned char *patientName=sqlite3_column_text(stmt, 0);
                NSString *patient= [NSString stringWithFormat:@"%s",patientName];
                const unsigned char *doctorName=sqlite3_column_text(stmt, 1);
                NSString *doctor=[NSString stringWithFormat:@"%s",doctorName];
                const unsigned char *wardNumber=sqlite3_column_text(stmt, 2);
                NSString *wName= [NSString stringWithFormat:@"%s",wardNumber];
                
                [self.patientMutableArray addObject:patient];
                [self.doctorMutableArray addObject:doctor];
                [self.wardNumberMutableArray addObject:wName];
            }
        }
    }
    else
    {
        NSLog(@"Database not able to Open %s",sqlite3_errmsg(HospitalDatabase));
    }
    sqlite3_finalize(stmt);
    sqlite3_close(HospitalDatabase);
    
    
    NSLog(@"Patient Name Array contains %@",self.patientMutableArray);
    NSLog(@"Doctor Name Array contains %@",self.doctorMutableArray);
    NSLog(@"Ward Number Array contains %@",self.wardNumberMutableArray);
}

@end
