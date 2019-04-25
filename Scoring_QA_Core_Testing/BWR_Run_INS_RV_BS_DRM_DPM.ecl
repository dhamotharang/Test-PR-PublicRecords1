
import RiskWise,Scoring_Project_Macros,sghatti,scoring_project_pip,ut;
fcra_roxieIP := riskwise.shortcuts.staging_fcra_roxieip ;
neutralroxieIP := RiskWise.shortcuts.QA_neutral_roxieIP;
no_of_threads := 2;
Timeout := 15;
Retry_time := 3;
no_of_recs_to_run := 0;
DRM_in_all := '000001000000110000000000000000';
DPM_in_all := '000000000000000000000000000000';
filetag := ut.GetDate  +'_1'; 

infile_DHDB := '~scoring_project::in::lien_judgement_change_sample_ins_dhdb';//bs 41, RV v3 & RV v4
infile_life := '~scoring_project::in::lien_judgement_change_sample_ins_life';  //BS 41 only

///////////////DHDB/////////////////
outfile_v3_DHDB := '~ScoringQA::out::FCRA::RiskView_v3_Scores_Attributes_INS_DHDB_' + filetag ;
macrocall_v3_DHDB	:= Scoring_QA_Core_Testing.RV_Scores_Attributes_V3_XML_DRM_DPM_In(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,infile_DHDB,outfile_v3_DHDB, no_of_recs_to_run, DRM_in_all, DPM_in_all);


outfile_v4_DHDB := '~ScoringQA::out::FCRA::RiskView_v4_Scores_Attributes_INS_DHDB_' + filetag ;
macrocall_v4_DHDB	:= Scoring_QA_Core_Testing.RV_Scores_Attributes_V4_XML_DRM_DPM_In(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,infile_DHDB,outfile_v4_DHDB, no_of_recs_to_run, DRM_in_all, DPM_in_all);


bocashell_41_file_out_DHDB :='~ScoringQA::out::FCRA::BocaShell_41_INS_DHDB_' + filetag ;
macrocall_bocashell_41_DHDB := Scoring_QA_Core_Testing.BocaShell_41_FCRA_cert_MACRO_DRM_DPM( fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,infile_DHDB,bocashell_41_file_out_DHDB,no_of_recs_to_run, DRM_in_all, DPM_in_all);

///////////////life/////////////////
bocashell_41_file_out_Life :='~ScoringQA::out::FCRA::BocaShell_41_INS_LIFE_' + filetag ;
macrocall_bocashell_41_life := Scoring_QA_Core_Testing.BocaShell_41_FCRA_cert_MACRO_DRM_DPM( fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,infile_life,bocashell_41_file_out_Life,no_of_recs_to_run, DRM_in_all, DPM_in_all);

sequential(macrocall_v3_DHDB, 
					 macrocall_v4_DHDB, 
				 	 macrocall_bocashell_41_DHDB,
					 macrocall_bocashell_41_life
					 );
EXPORT BWR_Run_INS_RV_BS_DRM_DPM := 'todo';