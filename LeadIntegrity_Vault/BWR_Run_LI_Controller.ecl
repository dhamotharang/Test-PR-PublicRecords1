//EXPORT LeadIntegrity_Vault.BWR_Run_LI_Controller
// *****************************************************************************************************************
//**  ExtraPrefix:      typically for customer test or qc test to create their own super files
//**                    without overwriting the developer's work - example: '::CT' '::QC' '::DEV'
//**
//**  version:  is a parameter entered at runtime, which identifies the version of the build.
//**            Use (YYYY) Current Year  (MM) Current Month  (DD) 15of Month
//**            Format YYYYMMDD Sample: '20200815'.
//**
//**  ProcToRun:
//**              (1) Run All LeadIntegrity Append ("Default")
//**              (2) Restart LeadIntegrity Append @ 02_of_05
//**              (3) Restart LeadIntegrity Append @ 03_of_05
//**              (4) Restart LeadIntegrity Append @ 04_of_05
//**              (5) Restart LeadIntegrity Append @ 05_of_05
// *****************************************************************************************************************
IMPORT LeadIntegrity_Vault;

#CONSTANT('ExtraPrefix','');

STRING8  Build_Period := '20200915';
unsigned1 LIProcToRun := 1;

#workunit('name', 'LeadIntegrity Append');

//Run on thor400_44_scoring_eclcc
LeadIntegrity_Vault.fn_Run_LI_Controller(Build_Period,LIProcToRun)
            : SUCCESS(fileservices.SendEMail(LeadIntegrity_Vault.Constants.TeamEmailList, 'Lead Integrity Append Completed- ' + build_period + workunit, workunit)),
              FAILURE(fileservices.SendEMail(LeadIntegrity_Vault.Constants.TeamEmailList, 'Lead Integrity Append Failure- ' + build_period + workunit, workunit + '\n' + FAILMESSAGE));
