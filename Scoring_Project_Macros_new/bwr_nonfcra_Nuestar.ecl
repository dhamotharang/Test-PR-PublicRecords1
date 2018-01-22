EXPORT bwr_nonfcra_Nuestar := FUNCTION

IMPORT sghatti, RiskWise, ut, Scoring_Project_Macros; 


//******** Uncomment roxie to run ************
// roxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert
// roxieIP := RiskWise.shortcuts.QA_neutral_roxieIP; //  QA Roxie --- 'http://roxieqavip.br.seisint.com:9876';
roxieIP := RiskWise.shortcuts.Dev196;  
// roxieIP := 'http://roxiecertossvip.sc.seisint.com:9876';  // OSS VIP

//**** RUNTIME SETTINGS ******
gateway_ip := '';
no_of_threads := 1;
Timeout := 120;
Retry_time := 3;
no_of_recs_to_run := 25000;
//***** UNIQUE OUPUT FILE TAG *********
filetag := 'nuestar_baseline_final';  // i.e. vehicles_cert_130


Chase_BNK4_xml_inFile_name := '~Scoring_Project::in::BC1O_XML_Chase_bnk4_20140416';
Chase_BNK4_xml_outfile_name := '~ScoringQA::out::NONFCRA::BNK4_xml_chase_BD3605_0_' + filetag + '_' + ut.GetDate ;

Chase_BNK4_batch_inFile_name := '~Scoring_Project::in::BC1O_XML_Chase_bnk4_20140416';
Chase_BNK4_batch_outFile_name := '~ScoringQA::out::NONFCRA::BNK4_batch_chase_BD3605_0_' + filetag + '_' + ut.GetDate ;


Chase_PIO2_xml_inFile_name := '~Scoring_Project::in::PRIO_XML_Chase_pi02_20140415';
Chase_PIO2_xml_outFile_name := '~ScoringQA::out::NONFCRA::PI02_xml_chase_FP3710_0_' + filetag + '_' + ut.GetDate ;

Chase_PIO2_batch_inFile_name := '~Scoring_Project::in::PRIO_XML_Chase_pi02_20140415';
Chase_PIO2_batch_outFile_name := '~ScoringQA::out::NONFCRA::PI02_batch_chase_FP3710_0_' + filetag + '_' + ut.GetDate ;

Chase_CBBL_inFile_name:='~sghatti::in::Chase_CBBL_data';
Chase_CBBL_outfile_name := '~ScoringQA::out::NONFCRA::cbbl_xml_chase_' + filetag + '_' + ut.GetDate ;

Paro_it60_XML_infile_name:='~sghatti::in::Paro_IT60';
Paro_it60_outfile_name := '~ScoringQA::out::NONFCRA::IT60_xml_paro_' + filetag + '_' + ut.GetDate ;

Paro_it60_BATCH_infile_name := '~sghatti::in::Paro_IT60';
Paro_it60_BATCH_outfile_name := '~ScoringQA::out::NONFCRA::IT60_batch_paro_' + filetag + '_' + ut.GetDate ;

Paro_it61_XML_infile_name:='~nkoubsky::in::new_it61_xml_input_20140108_csv';
Paro_it61_outfile_name := '~ScoringQA::out::NONFCRA::IT61_xml_paro_' + filetag + '_' + ut.GetDate ;

Paro_it61_BATCH_infile_name := '~sghatti::in::Paro_IT61';
Paro_it61_BATCH_outfile_name := '~ScoringQA::out::NONFCRA::IT61_batch_paro_' + filetag + '_' + ut.GetDate ;

li_v3_attributes_xml_infile_name     := '~Scoring_Project::in::LeadIntegrity_XML_Generic_MSN1210_1_20140411'; 
li_v3_attributes_xml_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_xml_generic_attributes_v3_' + filetag + '_' + ut.GetDate  ;

li_v3_attributes_batch_infile_name     := '~Scoring_Project::in::LeadIntegrity_XML_Generic_MSN1210_1_20140411'; 
li_v3_attributes_batch_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_batch_generic_attributes_v3_' + filetag + '_' + ut.GetDate  ;

li_v4_scores_xml_infile_name    := '~Scoring_Project::in::LeadIntegrity_XML_Generic_MSN1210_1_20140411'; 
li_v4_scores_xml_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_xml_generic_msn1106_0_v4_' + filetag + '_' + ut.GetDate ;

li_v4_scores_batch_infile_name     := '~Scoring_Project::in::LeadIntegrity_XML_Generic_MSN1210_1_20140411'; 
li_v4_scores_batch_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_batch_generic_msn1106_0_v4_' + filetag + '_' + ut.GetDate  ;

li_v4_attributes_xml_infile_name    := '~Scoring_Project::in::LeadIntegrity_XML_Generic_MSN1210_1_20140411'; 
li_v4_attributes_xml_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_xml_generic_attributes_v4_' + filetag + '_' + ut.GetDate  ;

li_v4_attributes_batch_infile_name     := '~Scoring_Project::in::LeadIntegrity_XML_Generic_MSN1210_1_20140411'; 
li_v4_attributes_batch_outFile_name := '~ScoringQA::out::NONFCRA::leadintegrity_batch_generic_attributes_v4_' + filetag + '_' + ut.GetDate  ;

CapitalOne_batch_infile_name :=  '~nkoubsky::in::capone_ita3batch_20131126';
CapitalOne_batch_outfile_name := '~ScoringQA::out::NONFCRA::ITA_batch_CapitalOne_attributes_v3_' + filetag + '_' + ut.GetDate  ;

CapitalOne_batch_infile_name_new :=  '~scoring_project::in::ita_batch_logs';
CapitalOne_batch_outfile_name_new := '~ScoringQA::out::NONFCRA::ITA_batch_CapitalOne_attributes_v3_newinput_' + filetag + '_' + ut.GetDate  ;

bbuy_infile_name := '~scoring_project::in::chargebackdefender_xml_bestbuy_cdn1109_1_20140319';
bbuy_outFile_Name := '~ScoringQA::out::FCRA::ChargebackDefender_xml_BestBuy_CDN1109_1_' + filetag + '_' + ut.GetDate;

chase_BIID_batch_infile_name := '~nkoubsky::in::chase_biid_batch_input_20140130_csv';
chase_BIID_batch_outfile_name := '~ScoringQA::out::NONFCRA::businessinstantid_batch_Chase_' + filetag + '_' + ut.GetDate;
//******NEW IID INPUT
iid_xml_infile_new := '~Scoring_Project::in::InstantID_Generic_Soat_Logs';
iid_xml_outfile_new := '~ScoringQA::out::NONFCRA::NEW_instantid_xml_generic_' + filetag + '_' + ut.GetDate;

iid_batch_infile_new := '~Scoring_Project::in::InstantID_Generic_Soat_Logs';
iid_batch_outfile_new := '~ScoringQA::out::NONFCRA::NEW_instantid_batch_generic_' + filetag + '_' + ut.GetDate;
//*********
iid_xml_infile_name_25000 := ut.foreign_prod + 'Scoring_Project::in::InstantID_XML_Generic_Version0_20140408';
iid_xml_outfile_name := '~ScoringQA::out::NONFCRA::instantid_xml_generic_' + filetag + '_' + ut.GetDate;

iid_batch_infile_name_25000 := ut.foreign_prod + 'Scoring_Project::in::InstantID_XML_Generic_Version0_20140408';
iid_batch_outfile_name := '~ScoringQA::out::NONFCRA::instantid_batch_generic_' + filetag + '_' + ut.GetDate;

biid_xml_inFile_name := '~sghatti::in::new_BIID_XML_Input_20140108_csv';
biid_xml_outFile_name := '~ScoringQA::out::NONFCRA::businessinstantid_xml_generic_' + filetag + '_' + ut.GetDate;

biid_batch_inFile_name := 'sghatti::in::Business_IID';
biid_batch_outFile_name := '~ScoringQA::out::NONFCRA::businessinstantid_batch_generic_' + filetag + '_' + ut.GetDate;
 
FP_XML_infile_name    := '~Scoring_Project::in::FraudPoint_XML_Generic_FP1109_0_20140408'; 
FP_XML_outfile_name := '~ScoringQA::out::NONFCRA::fraudpoint_xml_generic_fp1109_0_v2_' + filetag + '_' + ut.GetDate ;

FP_BATCH_infile_name := '~Scoring_Project::in::FraudPoint_XML_Generic_FP1109_0_20140408'; 
FP_BATCH_outfile_name := '~ScoringQA::out::NONFCRA::fraudpoint_batch_generic_fp1109_0_v2_' + filetag + '_' + ut.GetDate;

 



bestbuy := Scoring_Project_Macros_new.BestBuy_CDS_CDN1109_1_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,bbuy_infile_name,bbuy_outFile_Name,no_of_recs_to_run);

LI_v3_attributes_xml := Scoring_Project_Macros_new.LI_Attributes_V3_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,li_v3_attributes_xml_infile_name,li_v3_attributes_xml_outfile_name,no_of_recs_to_run);
LI_v3_attributes_batch := Scoring_Project_Macros_new.LI_Attributes_V3_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,li_v3_attributes_batch_infile_name,li_v3_attributes_batch_outfile_name,no_of_recs_to_run);
LI_v4_scores_xml := Scoring_Project_Macros_new.LI_Scores_V4_XML(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,li_v4_scores_xml_infile_name,li_v4_scores_xml_outfile_name,no_of_recs_to_run);
LI_v4_attributes_xml := Scoring_Project_Macros_new.LI_Attributes_V4_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,li_v4_attributes_xml_infile_name,li_v4_attributes_xml_outfile_name,no_of_recs_to_run);
LI_v4_scores_batch := Scoring_Project_Macros_new.LI_Scores_V4_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,li_v4_scores_batch_infile_name,li_v4_scores_batch_outfile_name,no_of_recs_to_run);
LI_v4_attributes_batch := Scoring_Project_Macros_new.LI_Attributes_V4_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,li_v4_attributes_batch_infile_name,li_v4_attributes_batch_outfile_name,no_of_recs_to_run);

CapitalOne_batch_ITA:= Scoring_Project_Macros_new.CapitalOne_ITA_V3_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,CapitalOne_batch_infile_name,CapitalOne_batch_outfile_name,no_of_recs_to_run);
CapitalOne_batch_ITA_new:= Scoring_Project_Macros_new.CapitalOne_ITA_V3_BATCH_Macro_new(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,CapitalOne_batch_infile_name_new,CapitalOne_batch_outfile_name_new,no_of_recs_to_run);

Chase_BNK4_xml := Scoring_Project_Macros_new.Chase_BNK4_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_BNK4_xml_inFile_name,Chase_BNK4_xml_outfile_name,no_of_recs_to_run);
Chase_BNK4_batch := Scoring_Project_Macros_new.Chase_BNK4_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_BNK4_batch_inFile_name,Chase_BNK4_batch_outFile_name,no_of_recs_to_run);

Chase_PIO2_XML := Scoring_Project_Macros_new.Chase_PIO2_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_PIO2_xml_inFile_name,Chase_PIO2_xml_outfile_name,no_of_recs_to_run);
Chase_PIO2_batch := Scoring_Project_Macros_new.Chase_PIO2_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_PIO2_batch_inFile_name,Chase_PIO2_batch_outfile_name,no_of_recs_to_run);

Chase_CBBL := Scoring_Project_Macros_new.Chase_CBBL_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_CBBL_inFile_name,Chase_CBBL_outfile_name,no_of_recs_to_run);

Paro_IT60_XML := Scoring_Project_Macros_new.Paro_IT60_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Paro_it60_XML_infile_name,Paro_it60_outfile_name,no_of_recs_to_run);
Paro_IT60_BATCH := Scoring_Project_Macros_new.Paro_IT60_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Paro_it60_BATCH_infile_name,Paro_it60_BATCH_outfile_name,no_of_recs_to_run);

Paro_IT61_XML := Scoring_Project_Macros_new.Paro_IT61_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Paro_it61_XML_infile_name,Paro_it61_outfile_name,no_of_recs_to_run);
Paro_IT61_BATCH := Scoring_Project_Macros_new.Paro_IT61_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Paro_it61_BATCH_infile_name,Paro_it61_BATCH_outfile_name,no_of_recs_to_run);

FP_ScoresAttributes_XML := Scoring_Project_Macros_new.FP_Scores_and_Attributes_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,FP_XML_infile_name,FP_XML_outfile_name,no_of_recs_to_run);
FP_ScoresAttributes_BATCH := Scoring_Project_Macros_new.FP_Scores_and_Attributes_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,FP_BATCH_infile_name,FP_BATCH_outfile_name,no_of_recs_to_run);

chase_BIID_batch := Scoring_Project_Macros_new.Chase_BIID_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,chase_BIID_batch_infile_name,chase_BIID_batch_outfile_name,no_of_recs_to_run);

instant_id_xml_new := Scoring_Project_Macros_new.Instant_ID_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,iid_xml_infile_new,iid_xml_outfile_new,no_of_recs_to_run);
instant_id_batch_new := Scoring_Project_Macros_new.Instant_ID_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,iid_batch_infile_new,iid_batch_outfile_new,no_of_recs_to_run);

instant_id_xml := Scoring_Project_Macros_new.Instant_ID_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,iid_xml_infile_name_25000,iid_xml_outfile_name,no_of_recs_to_run);
instant_id_batch := Scoring_Project_Macros_new.Instant_ID_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,iid_batch_infile_name_25000,iid_batch_outfile_name,no_of_recs_to_run);

BIID_XML := Scoring_Project_Macros_new.Business_Instant_Id_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,biid_xml_inFile_name,biid_xml_outFile_name,no_of_recs_to_run);
BIID_batch := Scoring_Project_Macros_new.Business_Instant_Id_Batch_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,biid_batch_inFile_name,biid_batch_outFile_name,no_of_recs_to_run);

 
// ****************************************************************************************************************


RETURN sequential(
										// Chase_BNK4_xml,
										// Chase_BNK4_batch,
										// Chase_PIO2_XML,
										// Chase_PIO2_batch,
										// Chase_CBBL,
										// Paro_IT60_XML,
										// Paro_IT60_BATCH,
										// Paro_IT61_XML,
										// Paro_IT61_BATCH,
										// bestbuy,
										// LI_v3_attributes_xml,
										// LI_v3_attributes_batch,
										LI_v4_attributes_xml,
										// LI_v4_attributes_batch,
										CapitalOne_batch_ITA,
										CapitalOne_batch_ITA_new,
										// LI_v4_scores_xml,
										// LI_v4_scores_batch,
										// FP_ScoresAttributes_XML,
										// FP_ScoresAttributes_BATCH,
										// chase_BIID_batch,
										// instant_id_xml,
										// instant_id_batch,
										instant_id_xml_new,
										// instant_id_batch_new,
										BIID_XML
										// BIID_batch
										);
END;