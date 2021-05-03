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
//    - (wait couple days for it to finish)
// 7.  Copy your output file back to alpha dev
// *****************************************************************************************************************
//**  ExtraPrefix:  typically for customer test or qc test to create their own super files
//**                without overwriting the developer's work - example: '::CT' '::QC' '::DEV'
//**
//**  version:      is a parameter entered at runtime, which identifies the version of the build.
//**                Use (YYYY) Current Year  (MM) Current Month  (DD) 15of Month
//**                Format YYYYMMDD Sample: '20180815'.
//**
//**  PBProcToRun:
//**              (1) Run All ProfileBooster Append ("Default")
//**              (2) Restart ProfileBooster Append @ 02_of_05
//**              (3) Restart ProfileBooster Append @ 03_of_05
//**              (4) Restart ProfileBooster Append @ 04_of_05
//**              (5) Restart ProfileBooster Append @ 05_of_05

IMPORT ProfileBooster;

#CONSTANT('ExtraPrefix','');

STRING8  version := '20200915';
unsigned1 PBProcToRun   := 1;

#workunit('name', 'profilebooster Append');

//Run on thor400_44
ProfileBooster.Proc_Run_PB_Append(version,PBProcToRun)
            : SUCCESS(fileservices.SendEMail(ProfileBooster.Constants.TeamEmailList, 'ProfileBooster Append Completed- ' + workunit, workunit)),
              FAILURE(fileservices.SendEMail(ProfileBooster.Constants.TeamEmailList, 'ProfileBooster Append Failure- ' + workunit, workunit + '\n' + FAILMESSAGE));





