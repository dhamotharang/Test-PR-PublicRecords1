//EXPORT LeadIntegrity_Vault.BWR_Run_LI_Controller
// *****************************************************************************************************************
//**  ExtraPrefix: 		typically for customer test or qc test to create their own super files 
//**                	without overwriting the developer's work - example: '::CT' '::QC' '::DEV'
//**
//**  version: 	is a parameter entered at runtime, which identifies the version of the build. 
//**            Use (YYYY) Current Year  (MM) Current Month  (DD) 15of Month
//**           	Format YYYYMMDD Sample: '20180815'.
//**
//**  ProcToRun:
//** 	      						(1) Run All LeadIntegrity Append ("Default")
//**              (2) Restart LeadIntegrity Append @ 02_of_15 
//**              (3) Restart LeadIntegrity Append @ 03_of_15 
//**              (4) Restart LeadIntegrity Append @ 04_of_15 
//**              (5) Restart LeadIntegrity Append @ 05_of_15 
//**              (6) Restart LeadIntegrity Append @ 06_of_15 
//**              (7) Restart LeadIntegrity Append @ 07_of_15 
//**              (8) Restart LeadIntegrity Append @ 08_of_15 
//**              (9) Restart LeadIntegrity Append @ 09_of_15 
//**             (10) Restart LeadIntegrity Append @ 10_of_15 
//**             (11) Restart LeadIntegrity Append @ 11_of_15 
//**             (12) Restart LeadIntegrity Append @ 12_of_15 
//**             (13) Restart LeadIntegrity Append @ 13_of_15 
//**             (14) Restart LeadIntegrity Append @ 14_of_15 
//**             (15) Restart LeadIntegrity Append @ 15_of_15 
// *****************************************************************************************************************
IMPORT LeadIntegrity_Vault;

#CONSTANT('ExtraPrefix','');      

STRING8  Build_Period := '20180815';
unsigned1 LIProcToRun 	:= 1;

#workunit('name', 'LeadIntegrity Append');

//Run on thor400_44_scoring_eclcc
LeadIntegrity_Vault.fn_Run_LI_Controller(Build_Period,LIProcToRun)
			: SUCCESS(fileservices.SendEMail(LeadIntegrity_Vault.Constants.TeamEmailList, 'Lead Integrity Append Completed- ' + build_period + workunit, workunit)),
	      FAILURE(fileservices.SendEMail(LeadIntegrity_Vault.Constants.TeamEmailList, 'Lead Integrity Append Failure- ' + build_period + workunit, workunit + '\n' + FAILMESSAGE));
