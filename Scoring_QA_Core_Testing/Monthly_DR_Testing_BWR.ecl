#Workunit('name','Monthly_DR_Check');

import riskwise, scoring_project_macros, scoring_qa_core_testing, risk_indicators, Phone_Shell, Data_Services;

NeutralRoxie := 'http://aroxievip.sc.seisint.com:9876';
FCRARoxie := 'http://afcraroxievip.sc.seisint.com:9876';


Threads_1 := 2;
Records_1 := 5;
//Records_1 := 25000;   //Most NonFCRA and Shells e.g. 25,000
Records_2 := 5;
//Records_2 := 10000;   //Allows the 12 FP v3 scores to be run at a lower count bc they take so long.  e.g 10,000.
Records_3 := 5;
//Records_3 := 50000;   //Allows FCRA Products to have higher size. e.g 50,000
Records_4 := 5;
//Records_4 := 100000;   //e.g 100,000
Name := 'Monthly_DR_Check';



SEQUENTIAL(Scoring_QA_Core_Testing.Monthly_DR_Core_Testing_Macro(NeutralRoxie, FCRARoxie, Threads_1, Records_1, Records_2, Records_3, Name))
:SUCCESS(FileServices.SendEmail(Scoring_Project_DailyTracking.email_distribution.SOCIO_Daily_Monitoring_Success_List,'Monthly_DR_Test completed','The Completed workunit is:' + workunit)),
FAILURE(FileServices.SendEmail(Scoring_Project_DailyTracking.email_distribution.SOCIO_Daily_Monitoring_Success_List,'Monthly_DR_Test failed','The Failed workunit is:'   + workunit + FailMessage));