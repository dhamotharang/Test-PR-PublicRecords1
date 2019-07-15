//EXPORT bwr_Run_PB_Copies 
//*******************************************************************************************************************************************************
//** ProfileBooster.bwr_Run_PB_Copies - Copy ProfileBooster files to Boca from Alpha
//** Parameters:
//**  ExtraPrefix: 		typically for customer test or qc test to create their own super files 
//**                	without overwriting the developer's work - example: '::CT' '::QC' '::DEV'
//**
//**  version: 	is a parameter entered at runtime, which identifies the version of the build. 
//**            Use (YYYY) Current Year  (MM) Current Month  (DD) 15of Month
//**           	Format YYYYMMDD Sample: '20180815'.
//**
//**  Dali:			identifies  where the file should be copied from 'Dev' or 'Prod'
//**
//**  ProcToRun:
//** 							      (1) Run All Market Magnifier Copies ("Default")
//**              (2) Restart copies @ 02_of_15 
//**              (3) Restart copies @ 03_of_15 
//**              (4) Restart copies @ 04_of_15 
//**              (5) Restart copies @ 05_of_15 
//**              (6) Restart copies @ 06_of_15 
//**              (7) Restart copies @ 07_of_15 
//**              (8) Restart copies @ 08_of_15 
//**              (9) Restart copies @ 09_of_15 
//**             (10) Restart copies @ 10_of_15 
//**             (11) Restart copies @ 11_of_15 
//**             (12) Restart copies @ 12_of_15 
//**             (13) Restart copies @ 13_of_15 
//**             (14) Restart copies @ 14_of_15 
//**             (15) Restart copies @ 15_of_15 
//**             (16) Run Proc_Copy_ProfileBooster_FromAlpha
//*******************************************************************************************************************************************************
//** MUST RUN FROM HTHOR
//*******************************************************************************************************************************************************

IMPORT ProfileBooster;

#CONSTANT('ExtraPrefix','');      

STRING8   version 	  := '20180915';
string    dali        := 'Prod';
unsigned1 ProcToRun 	:= 1;

#workunit('name', 'profile booster Copies');
//#workunit('cluster', 'hthor_eclcc');
ProfileBooster.Proc_Copy_ProfileBooster_FromAlpha(Version,dali,ProcToRun)
			: SUCCESS(fileservices.SendEMail(ProfileBooster.Constants.TeamEmailList, 'ProfileBooster Copies Completed- ' + workunit, workunit)),
	    FAILURE(fileservices.SendEMail(ProfileBooster.Constants.TeamEmailList, 'ProfileBooster Copies Failure- ' + workunit, workunit + '\n' + FAILMESSAGE));
