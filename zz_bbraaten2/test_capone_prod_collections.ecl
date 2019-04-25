
// EXPORT Prod_Capone_Macro_Call := 'todo';

#workunit('name', 'Daily Data Collection Capone Prod');

Capone has migrated to RV v5 as of 3/24 - oked by product.

import RiskWise,Scoring_Project_Macros;
import sghatti;
import ut, scoring_project_pip ;

fcra_roxieIP := RiskWise.shortcuts.prod_batch_fcra;
// fcra_roxieIP := riskwise.shortcuts.staging_fcra_roxieip ;
neutralroxieIP := RiskWise.shortcuts.prod_batch_neutral;
// neutralroxieIP :=RiskWise.shortcuts.QA_neutral_roxieIP;
roxieIP := RiskWise.shortcuts.prod_batch_neutral;
// roxieIP := RiskWise.shortcuts.QA_neutral_roxieIP;

no_of_threads := 30;

Timeout := 15;
Retry_time := 3;
no_of_recs_to_run := 0;

filetag := ut.GetDate  +'_2'; 
// filetag :=   20170215 + '_test2'; 

message:=output('Daily Data Collection Capone Prod_failed');

//input files
// RV_Attributes_V2_BATCH_CapOne_infile 						:= scoring_project_pip.Input_Sample_Names.RV_Attributes_V2_BATCH_CapOne_infile;
RV_Attributes_V3_BATCH_CapOne_infile 						:= zz_bbraaten2.test_input_samples.RV_Attributes_V3_BATCH_CapOne_infile;
RV_Attributes_V5_BATCH_CapOne_infile 						:= zz_bbraaten2.test_input_samples.RV_Attributes_V2_BATCH_CapOne_infile;
ITA_Attributes_V3_BATCH_CapOne_infile 					:= zz_bbraaten2.test_input_samples.ITA_Attributes_V3_BATCH_CapOne_infile;



//output files
// RV_Attributes_V2_BATCH_CapOne_outfile						:= '~ScoringQA::out::FCRA::RiskView_Batch_Prod_Capitalone_attributes_V2_' + filetag ;
RV_Attributes_V3_BATCH_CapOne_outfile 					:= '~ScoringQA::out::FCRA::RiskView_Batch_Prod_Capitalone_attributes_V3_' + filetag ;
RV_Attributes_V5_BATCH_CapOne_outfile 					:= '~ScoringQA::out::FCRA::RiskView_Batch_Prod_Capitalone_attributes_V5_' + filetag ;
ITA_Attributes_V3_BATCH_CapOne_outfile 					:= '~ScoringQA::out::NONFCRA::ITA_batch_Prod_CapitalOne_attributes_v3_' + filetag ;

//Macros
// CapitalOne_RVAttributes_V2 											:= scoring_project_pip.CapitalOne_RVAttributes_V2_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V2_BATCH_CapOne_infile,RV_Attributes_V2_BATCH_CapOne_outfile,no_of_recs_to_run):RECOVERY(message,10);
CapitalOne_RVAttributes_V3 											:= scoring_project_pip.CapitalOne_RVAttributes_V3_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V3_BATCH_CapOne_infile,RV_Attributes_V3_BATCH_CapOne_outfile,no_of_recs_to_run):RECOVERY(message,10);
CapitalOne_RVAttributes_V5 											:= scoring_project_pip.CapitalOne_RVAttributes_V5_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V5_BATCH_CapOne_infile,RV_Attributes_V5_BATCH_CapOne_outfile,no_of_recs_to_run):RECOVERY(message,10);
CapitalOne_batch_ITA_new												:= scoring_project_pip.CapitalOne_ITA_V3_BATCH_Macro_new(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,ITA_Attributes_V3_BATCH_CapOne_infile,ITA_Attributes_V3_BATCH_CapOne_outfile,no_of_recs_to_run):RECOVERY(message,10);

sequential(
					 CapitalOne_RVAttributes_V2,
					 CapitalOne_RVAttributes_V3,
					 CapitalOne_RVAttributes_V5,
					 CapitalOne_batch_ITA_new,
					 Scoring_Project_Macros.Prod_Capone_Daily_Tracking
					 
					 ) : WHEN(CRON('05 16 * * *')), 
// FAILURE(FileServices.SendEmail( Scoring_Project_DailyTracking.email_distribution.Daily_Data_collections_fail_list,'Daily Data Collection FCRA Macro#1 jobs failed','The failed workunit is:' + workunit + FailMessage));




EXPORT test_capone_prod_collections := 'todo';