EXPORT Constants := MODULE
IMPORT _control;

//***********************************************************************************************
//** ExtraPrefix - typically for customer test or qc test to create their own super files 
//**                without overwriting the developer's work - example: '::CT' '::QC'
//***********************************************************************************************
	EXPORT ExtraPrefix		:= '' : STORED('ExtraPrefix'); 

  
 EXPORT AR_EmailAddresses := 'RIS-BI-AnalyticsRepository@lexisnexis.com,Vault.Logistics@risk.lexisnexis.com';
 EXPORT DF_EmailAddresses := 'a&rdata.engineering.support@lexisnexisrisk.com';
 EXPORT DO_EmailAddresses := 'InsDataOps@lexisnexis.com';
 EXPORT PRD_EmailAddresses := 'RIS-BI-AnalyticsRepository@lexisnexis.com,Vault.Logistics@risk.lexisnexis.com,a&rdata.engineering.support@lexisnexisrisk.com,InsDataOps@lexisnexis.com';
 EXPORT DEV_EmailAddresses := 'melissa.newport@lexisnexisrisk.com,sanjay.narla@lexisnexisrisk.com';
	EXPORT TeamEmailList := if (_control.ThisEnvironment.name='Prod',PRD_EmailAddresses,DEV_EmailAddresses);
	
	

END;
