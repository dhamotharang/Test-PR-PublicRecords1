import RiskWise;
import sghatti;
import ut ;

//Here are the URLs to run data collections for testing non-FCRA OSS roxie
// cert130 OSS - roxiecertossvip.sc.seisint.com:9876
// cert128 702 - roxiestaging.sc.seisint.com:9876

// staging_roxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert
// QA_roxieIP := RiskWise.shortcuts.QA_neutral_roxieIP; //  QA Roxie --- 'http://roxieqavip.br.seisint.com:9876'; 


// cert130_OSS_roxieIP := 'http://roxiecertossvip.sc.seisint.com:9876';

// fcra_roxieIP := riskwise.shortcuts.staging_fcra_roxieip ;//staging
// fcra_roxieIP := RiskWise.Shortcuts.prod_batch_fcra; //prod batch
fcra_roxieIP := RiskWise.Shortcuts.Dev196; //prod batch
// neutralroxieIP := RiskWise.shortcuts.QA_neutral_roxieIP;
// neutralroxieIP := RiskWise.shortcuts.prod_batch_neutral;//prod neutral
neutralroxieIP := RiskWise.shortcuts.Dev196;//prod neutral

no_of_threads := 20;

Timeout := 120;
Retry_time := 3;
no_of_recs_to_run := 5;

filetag := 'test'; 

RV_Attributes_V3_BATCH_infile_name :=  '~scoring_project::in::riskview_xml_generic_version3_20140528';
RV_Attributes_V3_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_generic_attributes_v3_' + filetag + '_' +  ut.GetDate  ;


RV_Attributes_V4_BATCH_infile_name :=  '~scoring_project::in::riskview_xml_generic_version4_20140528';
RV_Attributes_V4_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_generic_attributes_v4_' + filetag + '_' +  ut.GetDate  ;

RV_Attributes_V2_BATCH_infile_name :=  '~scoring_project::in::riskview_xml_generic_version4_20140528';
RV_Attributes_V2_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_generic_attributes_v2_' + filetag + '_' +  ut.GetDate  ;


 RV_Scores_V4_BATCH_infile_name :=  '~scoring_project::in::riskview_xml_generic_version4_20140528';
   RV_Scores_V4_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_generic_allflagships_v4_' + filetag + '_' +  ut.GetDate  ;
   
   
   RV_Scores_V3_BATCH_infile_name :=  '~scoring_project::in::riskview_xml_generic_version3_20140528';
   RV_Scores_V3_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_generic_allflagships_v3_' + filetag + '_' +  ut.GetDate  ;
   
   



Regional_Acceptance_RVA1008_1_infile_name := '~scoring_project::in::riskview_xml_regionalacceptance_rva1008_1_20140301' ;
Regional_Acceptance_RVA1008_1_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_RegionalAcceptance_RVA1008_1_v4_' + filetag + '_' +  ut.GetDate  ;

Experian_RVA_30_XML_infile_name := '~sghatti::in::Experian_RVA_batch_data' ;
Experian_RVA_30_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_Experian_attributes_v3_' + filetag + '_' +  ut.GetDate  ;

Experian_RVA_30_BATCH_infile_name := '~sghatti::in::Experian_RVA_batch_data' ;
Experian_RVA_30_BATCH_outfile_name := '~ScoringQA::out::FCRA::RiskView_batch_Experian_attributes_v3_' + filetag + '_' +  ut.GetDate  ;



Experian_RVA_30_XML := Scoring_Project_Macros_new.Experian_RVA_30_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,Experian_RVA_30_XML_infile_name,Experian_RVA_30_XML_outfile_name,no_of_recs_to_run);

Experian_RVA_30_BATCH := Scoring_Project_Macros_new.Experian_RVA_30_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,Experian_RVA_30_BATCH_infile_name,Experian_RVA_30_BATCH_outfile_name,no_of_recs_to_run);

Regional_Acceptance_RVA1008_1 := Scoring_Project_Macros_new.Regional_Acceptance_RVA1008_1_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,Regional_Acceptance_RVA1008_1_infile_name,Regional_Acceptance_RVA1008_1_outfile_name,no_of_recs_to_run);


RV_Scores_V4_BATCH := Scoring_Project_Macros_new.RV_Scores_V4_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Scores_V4_BATCH_infile_name,RV_Scores_V4_BATCH_outfile_name,no_of_recs_to_run);

RV_Scores_V3_BATCH := Scoring_Project_Macros_new.RV_Scores_V3_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Scores_V3_BATCH_infile_name,RV_Scores_V3_BATCH_outfile_name,no_of_recs_to_run);

 
RV_Attributes_V3_BATCH := Scoring_Project_Macros_new.RV_Attributes_V3_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V3_BATCH_infile_name,RV_Attributes_V3_BATCH_outfile_name,no_of_recs_to_run);

RV_Attributes_V4_BATCH := Scoring_Project_Macros_new.RV_Attributes_V4_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V4_BATCH_infile_name,RV_Attributes_V4_BATCH_outfile_name,no_of_recs_to_run);

RV_Attributes_V2_BATCH := Scoring_Project_Macros_new.RV_Attributes_V2_BATCH_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V2_BATCH_infile_name,RV_Attributes_V2_BATCH_outfile_name,no_of_recs_to_run);

/* 
experian_batch := sghatti.Experian_RVA_30_Batch_Cust_Rec;
   experian := sghatti.Experian_RVA_30_Cust_Rec;
   
   Regional := sghatti.Regional_Acceptance_RVA1008_1;
   
   
   best_buy_1 := sghatti.Best_Buy_CDS_CDN1109_1_Cust_Rec;
   RVScores_batch_30 := sghatti.RVScores_batch_30;		 //batch 30
   RVScores_batch_40 := sghatti.RVScores_batch_40;		 //batch 40 
   
   


   RVAttributes_batch_20 := sghatti.RVAttributes_batch_20;		 //batch 20
		 RVAttributes_batch_30 := sghatti.RVAttributes_batch_30;		 //batch 30
		 RVAttributes_batch_40 := sghatti.RVAttributes_batch_40;		 //batch 40	
		 

*/


a:= sequential(Experian_RVA_30_XML,Experian_RVA_30_BATCH,Regional_Acceptance_RVA1008_1,RV_Attributes_V3_BATCH,RV_Attributes_V4_BATCH,
               RV_Scores_V4_BATCH,RV_Scores_V3_BATCH,RV_Attributes_V2_BATCH);



a;