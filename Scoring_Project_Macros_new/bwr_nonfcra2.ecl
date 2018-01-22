import sghatti,RiskWise,ut ; 

//Here are the URLs to run data collections for testing non-FCRA OSS roxie
// cert130 OSS - roxiecertossvip.sc.seisint.com:9876
// cert128 702 - roxiestaging.sc.seisint.com:9876

//******** Uncomment roxie to run ************
// roxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert
roxieIP := RiskWise.shortcuts.QA_neutral_roxieIP; //  QA Roxie --- 'http://roxieqavip.br.seisint.com:9876'; 

// roxieIP := 'http://roxiecertossvip.sc.seisint.com:9876';  // OSS VIP

//**** RUNTIME SETTINGS ******
gateway_ip := '';
no_of_threads := 20;
Timeout := 120;
Retry_time := 3;
no_of_recs_to_run := 0;
//***** UNIQUE OUPUT FILE TAG *********
// filetag := 'TESTING';  // i.e. vehicles_cert_130


li_v3_attributes_xml_infile_name     := '~Scoring_Project::in::LeadIntegrity_XML_Generic_MSN1210_1_20140411'; 
li_v3_attributes_xml_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_xml_generic_attributes_v3'+ '_'  + ut.GetDate  ;

li_v3_attributes_batch_infile_name     := '~Scoring_Project::in::LeadIntegrity_XML_Generic_MSN1210_1_20140411'; 
li_v3_attributes_batch_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_batch_generic_attributes_v3'+ '_'  + ut.GetDate  ;

li_v4_scores_xml_infile_name    := '~Scoring_Project::in::LeadIntegrity_XML_Generic_MSN1210_1_20140411'; 
li_v4_scores_xml_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_xml_generic_msn1106_0_v4'+ '_' + ut.GetDate ;

li_v4_scores_batch_infile_name     := '~Scoring_Project::in::LeadIntegrity_XML_Generic_MSN1210_1_20140411'; 
li_v4_scores_batch_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_batch_generic_msn1106_0_v4'+ '_'  + ut.GetDate  ;

li_v4_attributes_xml_infile_name    := '~Scoring_Project::in::LeadIntegrity_XML_Generic_MSN1210_1_20140411'; 
li_v4_attributes_xml_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_xml_generic_attributes_v4'+ '_'  + ut.GetDate  ;

li_v4_attributes_batch_infile_name     := '~Scoring_Project::in::LeadIntegrity_XML_Generic_MSN1210_1_20140411'; 
li_v4_attributes_batch_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_batch_generic_attributes_v4'+ '_'  + ut.GetDate  ;


CapitalOne_batch_infile_name :=  '~nkoubsky::in::capone_ita3batch_20131126';
CapitalOne_batch_outfile_name := '~ScoringQA::out::NONFCRA::ITA_batch_CapitalOne_attributes_v3'+ '_'  + ut.GetDate  ;


bbuy_infile_name := '~scoring_project::in::chargebackdefender_xml_bestbuy_cdn1109_1_20140319';
bbuy_outFile_Name := '~ScoringQA::out::FCRA::ChargebackDefender_xml_BestBuy_CDN1109_1'  + '_' + ut.GetDate;


bestbuy := Scoring_Project_Macros_new.BestBuy_CDS_CDN1109_1_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,bbuy_infile_name,bbuy_outFile_Name,no_of_recs_to_run);




LI_v3_attributes_xml := Scoring_Project_Macros_new.LI_Attributes_V3_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,li_v3_attributes_xml_infile_name,li_v3_attributes_xml_outfile_name,no_of_recs_to_run);
LI_v3_attributes_batch := Scoring_Project_Macros_new.LI_Attributes_V3_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,li_v3_attributes_batch_infile_name,li_v3_attributes_batch_outfile_name,no_of_recs_to_run);
LI_v4_scores_xml := Scoring_Project_Macros_new.LI_Scores_V4_XML(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,li_v4_scores_xml_infile_name,li_v4_scores_xml_outfile_name,no_of_recs_to_run);
LI_v4_attributes_xml := Scoring_Project_Macros_new.LI_Attributes_V4_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,li_v4_attributes_xml_infile_name,li_v4_attributes_xml_outfile_name,no_of_recs_to_run);
LI_v4_scores_batch := Scoring_Project_Macros_new.LI_Scores_V4_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,li_v4_scores_batch_infile_name,li_v4_scores_batch_outfile_name,no_of_recs_to_run);
LI_v4_attributes_batch := Scoring_Project_Macros_new.LI_Attributes_V4_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,li_v4_attributes_batch_infile_name,li_v4_attributes_batch_outfile_name,no_of_recs_to_run);



CapitalOne_batch_ITA:= Scoring_Project_Macros_new.CapitalOne_ITA_V3_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,CapitalOne_batch_infile_name,CapitalOne_batch_outfile_name,no_of_recs_to_run);
		 
a:= sequential(bestbuy,LI_v3_attributes_xml,LI_v3_attributes_batch,LI_v4_attributes_xml,LI_v4_attributes_batch,CapitalOne_batch_ITA,

              LI_v4_scores_xml,LI_v4_scores_batch);
/* 
   
   LIScores := sghatti.LIScores; //version41
   
   lia_30_batch := sghatti.LIA_30_Batch ;
   lia_40_batch := sghatti.LIA_40_Batch ;
   ita_30_batch := sghatti.ITA_30_batch ;
   
   
   li_40_batch := sghatti.LIScores_40_Batch ;
   
   
   LIAttributes30 := sghatti.LIattributes_30 ;  //version 30
   LIAttributes := sghatti.LIattributes ;  //version 41		
   		 

   		
*/


a ;