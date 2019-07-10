#workunit('name', 'SOCIO_v5_Daily_Monitoring');
IMPORT RiskWise,scoring_project_pip,Scoring_Project_Macros,Scoring_Project_DailyTracking, sghatti, Gateway, ut, std, Scoring_Project_KS;

//roxieIP                           := 'http://dev156vip.hpcc.risk.regn.net:9876';
//roxieIP                           := 'http://dev154vip.hpcc.risk.regn.net:9876';
//roxieIP                           := 'http://10.173.101.101:9876'; //cert 101
roxieIP                             := RiskWise.shortcuts.staging_neutral_roxieIP; //Hitting the 128/130 Vip  
gateway_ip                          := '';
no_of_threads                       := 2;
Timeout                             := 15;
Retry_time                          := 3;
no_of_recs_to_run                   := 50000;
filetag                             := (String8)std.date.Today()+'_1'; //change this to _2,_3,_4 etc to run multiple times in a day without overwriting previous versions
//SOCIO_Monitoring_v5_infile 		    := '~vidyapatil::sociodevtesting::inputdatasampleMA.csv'; 
SOCIO_Monitoring_v5_infile          := '~scoringqa::in::socio_v5';
SOCIO_Monitoring_v5_outfile 				:= '~ScoringQA::Out::Socioeconomic_v5_Batch_' + filetag;
SOCIO_Monitoring_v5_new							:= Scoring_Project_Macros.SOCIO_Monitoring_v5_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,SOCIO_Monitoring_v5_infile,SOCIO_Monitoring_v5_outfile,no_of_recs_to_run);
SOCIO_Runbins                       := Scoring_Project_KS.bwr_SOCIO_runbins;
SOCIO_KS_Test                       := Scoring_Project_KS.bwr_SOCIO_ks_test;
SOCIO_Attributes_Report					    := Scoring_Project_Macros.SOCIO_Attributes_Report;


//SOCIO_Monitoring_v5_new;
//SOCIO_Runbins;
//SOCIO_KS_Test;
//SOCIO_Attributes_Report;

//SEQUENTIAL(SOCIO_Monitoring_v5_new)
SEQUENTIAL(SOCIO_Runbins,SOCIO_KS_Test,SOCIO_Attributes_Report);
//:WHEN(CRON('0 5 * * *')), //runs everday at 1am EST
//:WHEN(CRON('0 8 * * *')),   //runs everday at 4am EST
//:WHEN(CRON('0 18 * * *')),//runs everday at 2pm EST
//SUCCESS(FileServices.SendEmail('daniel.harkins@lexisnexisrisk.com','SOCIO_v5_Daily_Monitoring_Completed','The Completed workunit is:' + workunit)),
//FAILURE(FileServices.SendEmail('daniel.harkins@lexisnexisrisk.com','SOCIO_v5_Daily_Monitoring job failed','The Failed workunit is:'   + workunit + FailMessage));