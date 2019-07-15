//EXPORT BWR_LeadIntegrity_Service := 'todo';

//EXPORT BWR_Copy_LeadIntegerity_From_Alpha := 'todo';
//*******************************************************************************************************************************************************
//** BWR_Copy_LeadIntegerity_From_Alpha - Copy Lead Integerity file to Boca from Alpha
//** Parameters:
//**  version: 	is a parameter entered at runtime, which identifies the version of the build. 
//**           	Format YYYYMM Sample: '201609'.
//**  Dali:			idetifies where the file should be copied from 'Dev' or 'Prod'
//**  ProcToRun:
//** 							(1) Run All Market Magnifier Copies ("Default")
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
//*******************************************************************************************************************************************************
//** MUST RUN FROM HTHOR
//*******************************************************************************************************************************************************

IMPORT LeadIntegrity;
IMPORT LeadIntegrity_Vault; //.fn_LeadIntegrity_Service;

STRING6   version 	  := '201801';
string    dali        := 'Dev';
unsigned1 ProcToRun 	:= 1;

#workunit('name', 'LeadIntegrity MarketMagnifier Copies');
#workunit('cluster', 'hthor');
LeadIntegrity_Vault.fn_LeadIntegrity_Service('~foreign::prod_esp.br.seisint.com::' +'in::marketmagnifier::leadintegrity::201801_01_of_15')
			: SUCCESS(fileservices.SendEMail(LeadIntegrity.Constants.TeamEmailList, 'LeadIntegrity Copies Completed- ' + workunit, workunit)),
	      FAILURE(fileservices.SendEMail(LeadIntegrity.Constants.TeamEmailList, 'LeadIntegrity Copies Failure- ' + workunit, workunit + '\n' + FAILMESSAGE));