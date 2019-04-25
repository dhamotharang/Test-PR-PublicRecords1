import sghatti ;

// Here are the URLs to run data collections for testing non-FCRA OSS roxie
// cert130 OSS - roxiecertossvip.sc.seisint.com:9876
// cert128 702 - roxiestaging.sc.seisint.com:9876

staging_roxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert
QA_roxieIP := RiskWise.shortcuts.QA_neutral_roxieIP; //  QA Roxie --- 'http://roxieqavip.br.seisint.com:9876'; 
cert130_OSS_roxieIP := 'http://roxiecertossvip.sc.seisint.com:9876';
dev_196 := RiskWise.shortcuts.Dev196;
prod := RiskWise.shortcuts.prod_batch_neutral;

// RoxieIP := staging_roxieIP;
RoxieIP := QA_roxieIP;
// RoxieIP := cert130_OSS_roxieIP;
// RoxieIP := prod;

gateway_ip := '';
no_of_threads := 50;
Timeout := 120;
Retry_time := 1;
no_of_recs_to_run := 10000;

		CapitalOne_batch_infile_name :=  '~nkoubsky::in::capone_ita3batch_20131126';
		CapitalOne_batch_outfile_name := '~sghatti::out::nonFcra_ITA_CapitalOne_v3_BATCH_cert130_OSS_'  + ut.GetDate  ;


		li_v3_attributes_xml_infile_name     := '~nmontpetit::in::ge_cap_100302_pii'; 
		li_v3_attributes_xml_outFile_name := '~sghatti::out::nonFcra_LIAttributes_v3_XML_cert130_OSS_'  + ut.GetDate  ;

		li_v3_attributes_batch_infile_name     := '~nmontpetit::in::ge_cap_100302_pii'; 
		li_v3_attributes_batch_outFile_name := '~sghatti::out::nonFcra_LIAttributes_v3_BATCH_cert130_OSS_'  + ut.GetDate  ;

		li_v4_scores_xml_infile_name    := '~nmontpetit::in::ge_cap_100302_pii'; 
		li_v4_scores_xml_outFile_name := '~sghatti::out::nonFcra_LIScores_v4_msn1106_0_XML_cert130_OSS_' + ut.GetDate ;

		li_v4_scores_batch_infile_name     := '~nmontpetit::in::ge_cap_100302_pii'; 
		li_v4_scores_batch_outFile_name := '~sghatti::out::nonFcra_LIScores_v4_msn1106_0_BATCH_cert130_OSS_'  + ut.GetDate  ;

		li_v4_attributes_xml_infile_name    := '~nmontpetit::in::ge_cap_100302_pii'; 
		li_v4_attributes_xml_outFile_name := '~sghatti::out::nonFcra_LIAttributes_v4_XML_cert130_OSS_'  + ut.GetDate  ;

		li_v4_attributes_batch_infile_name     := '~nmontpetit::in::ge_cap_100302_pii'; 
		li_v4_attributes_batch_outFile_name := '~sghatti::out::nonFcra_LIAttributes_v4_BATCH_cert130_OSS_'  + ut.GetDate  ;

		iid_xml_infile_name_25000 := '~nmontpetit::in::ge_cap_100302_pii';
		iid_xml_outfile_name := '~sghatti::out::RiskProcessing_Instant_Id_XML_cert130_OSS_' + ut.GetDate;

		iid_batch_infile_name_25000 := '~nmontpetit::in::ge_cap_100302_pii';
		iid_batch_outfile_name := '~sghatti::out::RiskProcessing_Instant_ID_BATCH_cert130_OSS_' + ut.GetDate;

		bbuy_infile_name := 'sghatti::in::Best_buy_CDS_CDN1109_1_data';
		bbuy_outFile_Name := '~sghatti::out::Best_Buy_Custom_Chargeback_Defender_Score_cert130_OSS_' + ut.GetDate;


		biid_xml_inFile_name := 'sghatti::in::Business_IID';
		biid_xml_outFile_name := '~sghatti::out::Business_Instant_ID_Cust_Rec_cert130_OSS_' + ut.GetDate;


		biid_batch_inFile_name := 'sghatti::in::Business_IID';
		biid_batch_outFile_name := '~sghatti::out::Business_Instant_ID_Batch_Cust_Rec_cert130_OSS_' + ut.GetDate;

		Chase_BNK4_xml_inFile_name := '~sghatti::in::Chase_BNK4_data';
		Chase_BNK4_xml_outfile_name := '~sghatti::out::Chase_BNK4_cust_rec_cert130_OSS_' + ut.GetDate;

		Chase_BNK4_batch_inFile_name := '~sghatti::in::Chase_BNK4_data';
		Chase_BNK4_batch_outFile_name := '~sghatti::out::Chase_BNK4_batch_cert130_OSS_' + ut.GetDate;


		Chase_PIO2_xml_inFile_name := '~sghatti::in::Chase_PIO2_data';
		// Chase_PIO2_xml_outFile_name := '~sghatti::out::Chase_PI02_cust_rec_cert128_702_' + ut.GetDate;
		Chase_PIO2_xml_outFile_name := '~sghatti::out::Chase_PI02_cust_rec_cert130_OSS_' + ut.GetDate;

		Chase_PIO2_batch_inFile_name := '~sghatti::in::Chase_PIO2_data';
		Chase_PIO2_batch_outFile_name := '~sghatti::out::Chase_PI02_Batch_Cust_Rec_cert130_OSS_' + ut.GetDate;

		Chase_CBBL_inFile_name:='~sghatti::in::Chase_CBBL_data';
		Chase_CBBL_outfile_name := '~sghatti::out::Chase_CBBL_Cust_Rec_cert130_OSS_' + ut.GetDate;

		FP_XML_infile_name    := '~nmontpetit::in::ge_cap_100302_pii'; 
		FP_XML_outfile_name := '~sghatti::out::nonFcra_FPScoresAttributes_v2_cert130_OSS_'  + ut.GetDate ;

		FP_BATCH_infile_name := '~nmontpetit::in::ge_cap_100302_pii'; 
		FP_BATCH_outfile_name := '~sghatti::out::nonFcra_FPScoresAttributes_v2_BATCH_cert130_OSS_' + ut.GetDate;


		Paro_it60_XML_infile_name:='~sghatti::in::Paro_IT60';
		Paro_it60_outfile_name := '~sghatti::out::Paro_IT60_cert130_OSS_' + ut.GetDate;

		Paro_it60_BATCH_infile_name := '~sghatti::in::Paro_IT60';
		Paro_it60_BATCH_outfile_name := '~sghatti::out::Paro_IT60_batch_score_cert130_OSS_' + ut.GetDate;

		Paro_it61_XML_infile_name:='~sghatti::in::Paro_IT61';
		Paro_it61_outfile_name := '~sghatti::out::Paro_IT61_cert130_OSS_' + ut.GetDate;


		Paro_it61_BATCH_infile_name := '~sghatti::in::Paro_IT61';
		Paro_it61_BATCH_outfile_name := '~sghatti::out::Paro_IT61_batch_score_cert130_OSS_' + ut.GetDate;





		// (ROXIE_IP,Gateway, Threads, Timeout, Retry, Input_file_name,Output_file_name, records_ToRun)

		Chase_BNK4_xml := Scoring_Project_Macros.Chase_BNK4_XML_Macro(RoxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_BNK4_xml_inFile_name,Chase_BNK4_xml_outfile_name,no_of_recs_to_run);
		// Chase_BNK4_xml;

		Chase_BNK4_batch := Scoring_Project_Macros.Chase_BNK4_BATCH_Macro(RoxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_BNK4_batch_inFile_name,Chase_BNK4_batch_outFile_name,no_of_recs_to_run);
		// Chase_BNK4_batch;


		Chase_PIO2_XML := Scoring_Project_Macros.Chase_PIO2_XML_Macro(RoxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_PIO2_xml_inFile_name,Chase_PIO2_xml_outfile_name,no_of_recs_to_run);
		// Chase_PIO2_XML;

		Chase_PIO2_batch := Scoring_Project_Macros.Chase_PIO2_BATCH_Macro(RoxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_PIO2_batch_inFile_name,Chase_PIO2_batch_outfile_name,no_of_recs_to_run);
		// Chase_PIO2_batch;

		Chase_CBBL := Scoring_Project_Macros.Chase_CBBL_Macro(RoxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_CBBL_inFile_name,Chase_CBBL_outfile_name,no_of_recs_to_run);
		// Chase_CBBL;

		FP_ScoresAttributes_XML := Scoring_Project_Macros.FP_Scores_and_Attributes_XML_Macro(RoxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,FP_XML_infile_name,FP_XML_outfile_name,no_of_recs_to_run);
		// FP_ScoresAttributes_XML;

		FP_ScoresAttributes_BATCH := Scoring_Project_Macros.FP_Scores_and_Attributes_BATCH_Macro(RoxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,FP_BATCH_infile_name,FP_BATCH_outfile_name,no_of_recs_to_run);
		// FP_ScoresAttributes_BATCH;

		Paro_IT60_XML := Scoring_Project_Macros.Paro_IT60_XML_Macro(RoxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Paro_it60_XML_infile_name,Paro_it60_outfile_name,no_of_recs_to_run);
		// Paro_IT60_XML;

		Paro_IT60_BATCH := Scoring_Project_Macros.Paro_IT60_BATCH_Macro(RoxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Paro_it60_BATCH_infile_name,Paro_it60_BATCH_outfile_name,no_of_recs_to_run);
		// Paro_IT60_BATCH;

		Paro_IT61_XML := Scoring_Project_Macros.Paro_IT61_XML_Macro(RoxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Paro_it61_XML_infile_name,Paro_it61_outfile_name,no_of_recs_to_run);
		// Paro_IT61_XML;

		Paro_IT61_BATCH := Scoring_Project_Macros.Paro_IT61_BATCH_Macro(RoxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Paro_it61_BATCH_infile_name,Paro_it61_BATCH_outfile_name,no_of_recs_to_run);
		// Paro_IT61_BATCH;


		Sequential(Paro_IT61_BATCH,  Paro_IT61_XML, Paro_IT60_BATCH, Paro_IT60_XML, FP_ScoresAttributes_BATCH,
		FP_ScoresAttributes_XML, Chase_CBBL, Chase_PIO2_batch, Chase_PIO2_XML, Chase_BNK4_batch, Chase_BNK4_xml)
		// : WHEN(CRON('0 5 * * *')), //every day at 5.10 AM
			 // FAILURE(FileServices.SendEmail( 'suman.burjukindi@lexisnexis.com','CRON job failed','The failed workunit is:' + workunit + FailMessage));
