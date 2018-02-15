#WORKUNIT('priority','high');  

#workunit('name', 'KS Report');

import scoring_project_ks, zz_bbraaten2, zz_asinha;


runbins_all1 := scoring_project_ks.bwr_runbins_all ;
	
ks_test := scoring_project_ks.bwr_ks_test ;
	
sequential(runbins_all1,ks_test)  : WHEN(CRON('05 13 * * *')), 
 FAILURE(FileServices.SendEmail( 'Apaar.Sinha@lexisnexis.com,suman.burjukindi@lexisnexis.com,Benjamin.Karnatz@lexisnexis.com, Nathan.Koubsky@lexisnexis.com,jayson.alayay@lexisnexis.com, Karthik.Reddy@lexisnexis.com,Bridgett.Braaten@lexisnexis.com,Venkat.Arani@lexisnexis.com','KS-report failed','The failed workunit is:' + workunit + FailMessage));

 

// EXPORT BWR_KS_Report := 'todo';