EXPORT Chase_Relatives_macro (STRING neutralroxieIP, STRING fcra_roxieIP, INTEGER no_of_threads, INTEGER no_of_recs_to_run, STRING filetag) := FUNCTION

IMPORT sghatti, RiskWise, ut, Scoring_Project_Macros, Gateway, Scoring_Project_PIP, Scoring_Project_ISS; 

Timeout := 120;
Retry_time := 3;
roxieIP := neutralroxieIP;
gateway_ip := neutralroxieIP;

//***** NONFCRA **********************************************************************************************************************
Chase_BNK4_xml_inFile_name := Scoring_Project_PIP.Input_Sample_Names.BC10_Scores_Chase_BNK4_infile;;  //  '~Scoring_Project::in::BC1O_XML_Chase_bnk4_20140416';
Chase_BNK4_xml_outfile_name := '~ScoringQA::out::NONFCRA::BNK4_xml_chase_BD3605_0_' + ut.GetDate + '_' + filetag;

Chase_BNK4_batch_inFile_name := Scoring_Project_PIP.Input_Sample_Names.BC10_Scores_Chase_BNK4_infile;  //  '~Scoring_Project::in::BC1O_XML_Chase_bnk4_20140416';
Chase_BNK4_batch_outFile_name := '~ScoringQA::out::NONFCRA::BNK4_batch_chase_BD3605_0_' + ut.GetDate + '_' + filetag;

Chase_PIO2_xml_inFile_name := Scoring_Project_PIP.Input_Sample_Names.PRIO_Scores_Chase_PIO2_infile;  //  '~Scoring_Project::in::PRIO_XML_Chase_pi02_20140415';
Chase_PIO2_xml_outFile_name := '~ScoringQA::out::NONFCRA::PI02_xml_chase_FP3710_0_' + ut.GetDate + '_' + filetag;

Chase_PIO2_batch_inFile_name := Scoring_Project_PIP.Input_Sample_Names.PRIO_Scores_Chase_PIO2_infile;  //  '~Scoring_Project::in::PRIO_XML_Chase_pi02_20140415';
Chase_PIO2_batch_outFile_name := '~ScoringQA::out::NONFCRA::PI02_batch_chase_FP3710_0_' + ut.GetDate + '_' + filetag;

Chase_CBBL_inFile_name := Scoring_Project_PIP.Input_Sample_Names.CBBL_Scores_XML_Chase_infile;  // '~Scoring_Project::in::cbbl_xml_chase_20140827';
Chase_CBBL_outfile_name := '~ScoringQA::out::NONFCRA::cbbl_xml_chase_' + ut.GetDate + '_' + filetag;

Chase_CBBL_inFile_name_FPScore_ONLY := Scoring_Project_PIP.Input_Sample_Names.Chase_CBBL_fpscore_only_infile;  // ONLY FOR FP SCORE.  ATTRIBUTES WILL BE WRONG. June, July, Aug Sample.  18,483 Sample size
Chase_CBBL_outfile_name_FPScore_ONLY := '~ScoringQA::out::NONFCRA::cbbl_xml_chase_FPScore_ONLY_' + ut.GetDate + '_' + filetag;

chase_BIID_batch_infile_name := Scoring_Project_PIP.Input_Sample_Names.BIP_Chase_BIID_infile_name;  //  '~scoring_project::in::biid_batch_chase_generic_20141016';
chase_BIID_batch_outfile_name := '~ScoringQA::out::NONFCRA::businessinstantid_batch_Chase_' + ut.GetDate + '_' + filetag;

// ****************************************************************************************************************
Chase_BNK4_xml := Scoring_Project_Macros.Chase_BNK4_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_BNK4_xml_inFile_name,Chase_BNK4_xml_outfile_name,no_of_recs_to_run);
Chase_BNK4_batch := Scoring_Project_Macros.Chase_BNK4_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_BNK4_batch_inFile_name,Chase_BNK4_batch_outFile_name,no_of_recs_to_run);
Chase_PIO2_XML := Scoring_Project_Macros.Chase_PIO2_XML_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_PIO2_xml_inFile_name,Chase_PIO2_xml_outfile_name,no_of_recs_to_run);
Chase_PIO2_batch := Scoring_Project_Macros.Chase_PIO2_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_PIO2_batch_inFile_name,Chase_PIO2_batch_outfile_name,no_of_recs_to_run);
Chase_CBBL := Scoring_Project_Macros.Chase_CBBL_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_CBBL_inFile_name,Chase_CBBL_outfile_name,no_of_recs_to_run);
Chase_CBBL_FPScore_ONLY := Scoring_Project_Macros.Chase_CBBL_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,Chase_CBBL_inFile_name_FPScore_ONLY,Chase_CBBL_outfile_name_FPScore_ONLY,no_of_recs_to_run);
chase_BIID_batch := Scoring_Project_Macros.Chase_BIID_BATCH_Macro(roxieIP, gateway_ip,no_of_threads,Timeout,Retry_time,chase_BIID_batch_infile_name,chase_BIID_batch_outfile_name,no_of_recs_to_run);


// ****************************************************************************************************************

Return Sequential(Chase_CBBL, Chase_CBBL_FPScore_ONLY, Chase_BNK4_xml, Chase_BNK4_batch, Chase_PIO2_XML, Chase_PIO2_batch, chase_BIID_batch);


END;