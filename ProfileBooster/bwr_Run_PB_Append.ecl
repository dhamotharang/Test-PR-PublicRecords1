//EXPORT bwr_Run_PB_Append := 'todo';
// *****************************************************************************************************************
// RUN THIS SCRIPT ON 400 WAY THOR TO OPTIMIZE PERFORMANCE
// IF YOU'RE RUNNING A FILE LESS THAN 1 MILLION RECORDS, JUST RUN THE BATCH SERVICE INSTEAD OF THIS THOR JOB
// 1.  COPY ALL PUBLIC RECORD KEYS THAT PROFILE BOOSTER USES TO THE thor400_44_eclcc CLUSTER
//   -  ProfileBooster.bwr_Transfer_Needed_Keys
// 2.  MAKE SURE Data_Services.foreign_prod IS SANDBOXED to the following 
//   - export foreign_prod := '~';  // this ensures that you are reading in the data locally
// 3.  MAKE SURE YOU SANDBOX doxie.Version_SuperKey to the following:
//   - export Version_SuperKey := 'pb';
//	  - (wait couple days for it to finish)
// 7.  Copy your output file back to alpha dev
// *****************************************************************************************************************
//**  ExtraPrefix: 		typically for customer test or qc test to create their own super files 
//**                	without overwriting the developer's work - example: '::CT' '::QC' '::DEV'
//**
//**  version: 	is a parameter entered at runtime, which identifies the version of the build. 
//**            Use (YYYY) Current Year  (MM) Current Month  (DD) 15of Month
//**           	Format YYYYMMDD Sample: '20180815'.
//**
//**  PBProcToRun:
//** 	      						(1) Run All ProfileBooster Append ("Default")
//**              (2) Restart ProfileBooster Append @ 02_of_15 
//**              (3) Restart ProfileBooster Append @ 03_of_15 
//**              (4) Restart ProfileBooster Append @ 04_of_15 
//**              (5) Restart ProfileBooster Append @ 05_of_15 
//**              (6) Restart ProfileBooster Append @ 06_of_15 
//**              (7) Restart ProfileBooster Append @ 07_of_15 
//**              (8) Restart ProfileBooster Append @ 08_of_15 
//**              (9) Restart ProfileBooster Append @ 09_of_15 
//**             (10) Restart ProfileBooster Append @ 10_of_15 
//**             (11) Restart ProfileBooster Append @ 11_of_15 
//**             (12) Restart ProfileBooster Append @ 12_of_15 
//**             (13) Restart ProfileBooster Append @ 13_of_15 
//**             (14) Restart ProfileBooster Append @ 14_of_15 
//**             (15) Restart ProfileBooster Append @ 15_of_15 
IMPORT ProfileBooster;

#CONSTANT('ExtraPrefix','');      

STRING8  version := '20180915';
unsigned1 PBProcToRun 	:= 1;

#workunit('name', 'profilebooster Append');

//Run on thor400_44
ProfileBooster.Proc_Run_PB_Append(version,PBProcToRun)
			: SUCCESS(fileservices.SendEMail(ProfileBooster.Constants.TeamEmailList, 'ProfileBooster Append Completed- ' + workunit, workunit)),
	      FAILURE(fileservices.SendEMail(ProfileBooster.Constants.TeamEmailList, 'ProfileBooster Append Failure- ' + workunit, workunit + '\n' + FAILMESSAGE));



				
				
