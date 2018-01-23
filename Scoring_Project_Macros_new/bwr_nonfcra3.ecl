 
import sghatti,RiskWise,ut ;

//Here are the URLs to run data collections for testing non-FCRA OSS roxie
// cert130 OSS - roxiecertossvip.sc.seisint.com:9876
// cert128 702 - roxiestaging.sc.seisint.com:9876

//******** Uncomment roxie to run ************
// roxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert
// roxieIP := RiskWise.shortcuts.QA_neutral_roxieIP; //  QA Roxie --- 'http://roxieqavip.br.seisint.com:9876'; 
roxieIP := RiskWise.shortcuts.Dev196;  
// roxieIP := 'http://roxiecertossvip.sc.seisint.com:9876';  // OSS VIP

//**** RUNTIME SETTINGS ******
gateway_ip := '';
no_of_threads := 20;
Timeout := 120;
Retry_time := 3;
no_of_recs_to_run :=0;
//***** UNIQUE OUPUT FILE TAG *********
filetag := 'Test';  // i.e. vehicles_cert_130


 chase_BIID_batch_infile_name := '~nkoubsky::in::chase_biid_batch_input_20140130_csv';
chase_BIID_batch_outfile_name := '~ScoringQA::out::NONFCRA::businessinstantid_batch_Chase_' + filetag + '_' + ut.GetDate;

iid_xml_infile_name_25000 := '~Scoring_Project::in::InstantID_XML_Generic_Version0_20140408';
iid_xml_outfile_name := '~ScoringQA::out::NONFCRA::instantid_xml_generic_' + filetag + '_' + ut.GetDate;

iid_batch_infile_name_25000 := '~Scoring_Project::in::InstantID_XML_Generic_Version0_20140408';
iid_batch_outfile_name := '~ScoringQA::out::NONFCRA::instantid_batch_generic_' + filetag + '_' + ut.GetDate;



biid_xml_inFile_name := '~sghatti::in::new_BIID_XML_Input_20140108_csv';
biid_xml_outFile_name := '~ScoringQA::out::NONFCRA::businessinstantid_xml_generic_' + filetag + '_' + ut.GetDate;


biid_batch_inFile_name := 'sghatti::in::Business_IID';
biid_batch_outFile_name := '~ScoringQA::out::NONFCRA::businessinstantid_batch_generic_' + filetag + '_' + ut.GetDate;
 
 FP_XML_infile_name    := '~Scoring_Project::in::FraudPoint_XML_Generic_FP1109_0_20140408'; 
FP_XML_outfile_name := '~ScoringQA::out::NONFCRA::fraudpoint_xml_generic_fp1109_0_v2_' + filetag + '_' + ut.GetDate ;

FP_BATCH_infile_name := '~Scoring_Project::in::FraudPoint_XML_Generic_FP1109_0_20140408'; 
FP_BATCH_outfile_name := '~ScoringQA::out::NONFCRA::fraudpoint_batch_generic_fp1109_0_v2_' + filetag + '_' + ut.GetDate;

 
 
 FP_ScoresAttributes_XML := Scoring_Project_Macros_new.FP_Scores_and_Attributes_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,FP_XML_infile_name,FP_XML_outfile_name,no_of_recs_to_run);
FP_ScoresAttributes_BATCH := Scoring_Project_Macros_new.FP_Scores_and_Attributes_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,FP_BATCH_infile_name,FP_BATCH_outfile_name,no_of_recs_to_run);

chase_BIID_batch := Scoring_Project_Macros_new.Chase_BIID_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,chase_BIID_batch_infile_name,chase_BIID_batch_outfile_name,no_of_recs_to_run);


 instant_id_xml := Scoring_Project_Macros_new.Instant_ID_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,iid_xml_infile_name_25000,iid_xml_outfile_name,no_of_recs_to_run);


instant_id_batch := Scoring_Project_Macros_new.Instant_ID_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,iid_batch_infile_name_25000,iid_batch_outfile_name,no_of_recs_to_run);


BIID_XML := Scoring_Project_Macros_new.Business_Instant_Id_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,biid_xml_inFile_name,biid_xml_outFile_name,no_of_recs_to_run);


BIID_batch := Scoring_Project_Macros_new.Business_Instant_Id_Batch_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,biid_batch_inFile_name,biid_batch_outFile_name,no_of_recs_to_run);

 
 
 
 
 a:= sequential(FP_ScoresAttributes_XML,FP_ScoresAttributes_BATCH,chase_BIID_batch,instant_id_xml,instant_id_batch,BIID_XML,BIID_batch);
 
    		 
/*    fp_batch := sghatti.FP_Attributes_and_Scores_Batch_V2;
      
      FpScoreAttribute := sghatti.FPScoreAttribute;  //version 20
   	   Chase_BIID := sghatti.Chase_BIID_batch ;
      
      
      biid_new := sghatti.BIID_Cust_Rec_new_input;
      
      BIID_batch := sghatti.Business_Instant_ID_Batch_Cust_Rec ;
      
      
      instant_id := sghatti.Instant_ID;
      instant_id_batch := sghatti.Instant_ID_Batch;
*/
 


a ;