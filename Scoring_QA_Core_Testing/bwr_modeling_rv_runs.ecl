

import RiskWise,Scoring_Project_Macros,sghatti,scoring_project_pip,ut;
// fcra_roxieIP := riskwise.shortcuts.staging_fcra_roxieip ; //change for core run
// neutralroxieIP := RiskWise.shortcuts.QA_neutral_roxieIP; //change for core run

in_file := '~dvstemp::in::rv5t_dev_val_inputs_100k_file_for_rv';


no_of_threads := 2;
Timeout := 15;
Retry_time := 3;
no_of_recs_to_run := 5;
// no_of_recs_to_run := 0;
filetag := ut.GetDate  +'_Core_test_Modeling'; 
// RV_V3_Generic_infile														:= scoring_project_pip.Input_Sample_Names.RV_V3_Generic_infile;
RV_Attributes_V3_XML_Generic_outfile 						:= scoring_project_pip.Output_Sample_Names.RV_Attributes_V3_XML_Generic_outfile + filetag ;
RV_Scores_V3_XML_Generic_outfile								:= scoring_project_pip.Output_Sample_Names.RV_Scores_V3_XML_Generic_outfile + filetag ;
RV_Scores_Attribute_V3_XML											:= Scoring_QA_Core_Testing.Modeling_RV_Scores_Attributes_V3_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,in_file,RV_Scores_V3_XML_Generic_outfile, RV_Attributes_V3_XML_Generic_outfile,no_of_recs_to_run);
RV_Scores_Attribute_V3_XML;


// RV_V4_Generic_infile 														:= scoring_project_pip.Input_Sample_Names.RV_V4_Generic_infile;
RV_Attributes_V4_XML_Generic_outfile 						:= scoring_project_pip.Output_Sample_Names.RV_Attributes_V4_XML_Generic_outfile + filetag ;
RV_Scores_V4_XML_Generic_outfile 								:= scoring_project_pip.Output_Sample_Names.RV_Scores_V4_XML_Generic_outfile + filetag ;
RV_Scores_Attribute_V4_XML											:= Scoring_QA_Core_Testing.Modeling_RV_Scores_Attributes_V4_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,in_file,RV_Scores_V4_XML_Generic_outfile, RV_Attributes_V4_XML_Generic_outfile,no_of_recs_to_run);
RV_Scores_Attribute_V4_XML;


// RV_Scores_Attributes_V5_XMl_Generic_infile			:= scoring_project_pip.Input_Sample_Names.RV_V4_Generic_infile;
RV_Scores_Attributes_V5_XML_Generic_outfile 		:= scoring_project_pip.Output_Sample_Names.RV_Scores_Attributes_V5_XML_Generic_outfile + filetag ;
RV_Scores_Attributes_V5_XML 										:= Scoring_QA_Core_Testing.Modeling_RV_Scores_Attributes_V5_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,in_file,RV_Scores_Attributes_V5_XML_Generic_outfile,no_of_recs_to_run);
RV_Scores_Attributes_V5_XML;

EXPORT bwr_modeling_rv_runs := 'todo';