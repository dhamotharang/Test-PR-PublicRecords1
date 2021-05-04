#workunit('priority','high'); 

IMPORT SALT38, SALTRoutines, ProfileBooster, STD;


EXPORT bwr_ProfileBooster_OneMain_Step4(string IPaddr, string AbsolutePath, string NotifyList) := function

// This script takes in a file (Either as a dataset with a RECORD definition you define, or as an ECL file/index reference), 
// and then performs a full SALT profile.  It will then take that profile and infer potential data types, show the least populated fields, etc.

// For future Workunit Identification it is suggested that you update this WORKUNIT name to something specific to the file you are profiling

EmailList := If(NotifyList = '', ProfileBooster.Constants.ECL_Developers_Slim, ProfileBooster.Constants.ECL_Developers_Slim + ',' + NotifyList);
 
desprayPath := AbsolutePath  + '/' +  'LN_Output_springleaf_layout_ProfBooster.csv';
desprayPathPII := AbsolutePath +  '/' + 'LN_Output_springleaf_layout_PII.csv';
 
STD.File.DeSpray('~thor400::profilebooster::LN_Output_springleaf_layout_ProfBooster.csv', IPaddr, desprayPath): FAILURE(STD.System.Email.SendEmail(EmailList,'OneMain Step4 Despray failed', 'The failed workunit is:' + WORKUNIT + FAILMESSAGE));
STD.File.DeSpray('~thor400::profilebooster::LN_Output_springleaf_layout_PII.csv', IPaddr, desprayPathPII): FAILURE(STD.System.Email.SendEmail(EmailList,'OneMain Step4 PII Despray failed', 'The failed workunit is:' + WORKUNIT + FAILMESSAGE));	

STD.System.Email.SendEmail(EmailList, 'OneMain Step4 finished ' + WORKUNIT, 'Check Salt Results'):
FAILURE(STD.System.Email.SendEmail(EmailList,'OneMain Step4 failed', 'The failed workunit is:' + WORKUNIT + FAILMESSAGE));

RETURN 'SUCCESSFUL';

END;