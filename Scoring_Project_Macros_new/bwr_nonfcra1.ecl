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
no_of_threads := 1;
Timeout := 120;
Retry_time := 3;
no_of_recs_to_run := 5;
//***** UNIQUE OUPUT FILE TAG *********
filetag := 'test';  // i.e. vehicles_cert_130



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





Chase_BNK4_xml := Scoring_Project_Macros_new.Chase_BNK4_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_BNK4_xml_inFile_name,Chase_BNK4_xml_outfile_name,no_of_recs_to_run);


Chase_BNK4_batch := Scoring_Project_Macros_new.Chase_BNK4_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_BNK4_batch_inFile_name,Chase_BNK4_batch_outFile_name,no_of_recs_to_run);

Chase_PIO2_XML := Scoring_Project_Macros_new.Chase_PIO2_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_PIO2_xml_inFile_name,Chase_PIO2_xml_outfile_name,no_of_recs_to_run);

Chase_PIO2_batch := Scoring_Project_Macros_new.Chase_PIO2_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_PIO2_batch_inFile_name,Chase_PIO2_batch_outfile_name,no_of_recs_to_run);


Chase_CBBL := Scoring_Project_Macros_new.Chase_CBBL_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_CBBL_inFile_name,Chase_CBBL_outfile_name,no_of_recs_to_run);


Paro_IT60_XML := Scoring_Project_Macros_new.Paro_IT60_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Paro_it60_XML_infile_name,Paro_it60_outfile_name,no_of_recs_to_run);


Paro_IT60_BATCH := Scoring_Project_Macros_new.Paro_IT60_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Paro_it60_BATCH_infile_name,Paro_it60_BATCH_outfile_name,no_of_recs_to_run);


Paro_IT61_XML := Scoring_Project_Macros_new.Paro_IT61_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Paro_it61_XML_infile_name,Paro_it61_outfile_name,no_of_recs_to_run);


Paro_IT61_BATCH := Scoring_Project_Macros_new.Paro_IT61_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Paro_it61_BATCH_infile_name,Paro_it61_BATCH_outfile_name,no_of_recs_to_run);



/* 
   chase_bnk4_batch := sghatti.Chase_BNK4_Batch_Cust_Rec ;
   chase_bnk4 := sghatti.Chase_BNK4_Cust_Rec ;
   chase_cbbl := sghatti.Chase_Cbbl_Cust_Rec ;
   chase_poi2_batch := sghatti.Chase_PIO2_Batch_Cust_Rec ;
   chase_poi2 := sghatti.Chase_PIO2_Cust_Rec ;
   
   
   Paro_it61_batch := sghatti.Paro_IT61_Custom_Score_Batch;
   Paro_it60     	:= sghatti.Paro_IT60_Cust_Rec ;
   Paro_it60_batch := sghatti.Paro_IT60_Custom_Score_Batch;
   
   paro_it61_new := sghatti.Paro_IT61_Cust_Rec_new_input;
   
   
 
*/
 a:= sequential(Chase_BNK4_xml,Chase_BNK4_batch,Chase_PIO2_XML,Chase_PIO2_batch,Chase_CBBL,Paro_IT60_XML,Paro_IT60_BATCH,
                Paro_IT61_XML,Paro_IT61_BATCH);
		 
		 


a;