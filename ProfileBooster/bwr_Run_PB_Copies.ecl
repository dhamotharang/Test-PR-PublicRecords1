//EXPORT bwr_Run_PB_Copies
//*******************************************************************************************************************************************************
//** ProfileBooster.bwr_Run_PB_Copies - Copy ProfileBooster files to Boca from Alpha
//** Parameters:
//**  ExtraPrefix:  typically for customer test or qc test to create their own super files
//**                without overwriting the developer's work - example: '::CT' '::QC' '::DEV'
//**
//**  version:      is a parameter entered at runtime, which identifies the version of the build.
//**                Use (YYYY) Current Year  (MM) Current Month  (DD) 15of Month
//**                Format YYYYMMDD Sample: '20200815'.
//**
//**  Dali:         identifies  where the file should be copied from 'Dev' or 'Prod'
//**
//**  ProcToRun:
//**              (1) Run All Market Magnifier Copies ("Default")
//**              (2) Restart copies @ 02_of_05
//**              (3) Restart copies @ 03_of_05
//**              (4) Restart copies @ 04_of_05
//**              (5) Restart copies @ 05_of_05
//**              (6) Run Proc_Copy_ProfileBooster_FromAlpha
//*******************************************************************************************************************************************************
//** MUST RUN FROM HTHOR
//*******************************************************************************************************************************************************

IMPORT ProfileBooster;

#CONSTANT('ExtraPrefix','');

STRING8   version     := '20200915';
string    dali        := 'Prod';
unsigned1 ProcToRun   := 1;

#workunit('name', 'profile booster Copies');
//#workunit('cluster', 'hthor_eclcc');
ProfileBooster.Proc_Copy_ProfileBooster_FromAlpha(Version,dali,ProcToRun)
            : SUCCESS(fileservices.SendEMail(ProfileBooster.Constants.QC_email_target, 'ProfileBooster Copies Completed- ' + workunit, workunit)),
              FAILURE(fileservices.SendEMail(ProfileBooster.Constants.QC_email_target, 'ProfileBooster Copies Failure- ' + workunit, workunit + '\n' + FAILMESSAGE));
