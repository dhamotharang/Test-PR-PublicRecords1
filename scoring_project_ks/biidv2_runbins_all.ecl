import ut,Scoring_Project_Macros, scoring_project_ks;

date_in :=  ut.GetDate + '_1';


// businessinstantid_batch_generic:=Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_BusinessInstantId_Global_Layout;		
// businessinstantid_xml_generic:=Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_BusinessInstantId_Global_Layout;			
businessinstantidv2_xml_generic:=Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_BusinessInstantIdv2_Layout;


// scoring_project_ks.bwr_mac_get_score_details_test( 'nonfcra','businessinstantid_batch_generic', 'bvi', date_in , ret54);
// scoring_project_ks.bwr_mac_get_score_details_test( 'nonfcra','businessinstantid_batch_generic', 'bnap', date_in , ret55);
// scoring_project_ks.bwr_mac_get_score_details_test( 'nonfcra','businessinstantid_batch_generic', 'bnas', date_in , ret56);
// scoring_project_ks.bwr_mac_get_score_details_test( 'nonfcra','businessinstantid_batch_generic', 'bnat', date_in , ret57);
scoring_project_ks.bwr_mac_get_score_details_test( 'nonfcra','businessinstantidv2_xml_generic', 'bvi', date_in , ret1);
scoring_project_ks.bwr_mac_get_score_details_test( 'nonfcra','businessinstantidv2_xml_generic', 'rep1_cvi', date_in , ret2);
scoring_project_ks.bwr_mac_get_score_details_test( 'nonfcra','businessinstantidv2_xml_generic', 'bus2exec_index_rep1', date_in , ret3);

// scoring_project_ks.bwr_mac_get_score_details_test( 'nonfcra','businessinstantid_xml_generic', 'bvi', date_in , ret58);
// scoring_project_ks.bwr_mac_get_score_details_test( 'nonfcra','businessinstantid_xml_generic', 'bnap', date_in , ret59);
// scoring_project_ks.bwr_mac_get_score_details_test( 'nonfcra','businessinstantid_xml_generic', 'bnas', date_in , ret60);
// scoring_project_ks.bwr_mac_get_score_details_test( 'nonfcra','businessinstantid_xml_generic', 'bnat', date_in , ret61);

// scoring_project_ks.bwr_mac_get_score_details_test( 'nonfcra','businessinstantid_batch_Chase', 'bvi', date_in , ret62);
// scoring_project_ks.bwr_mac_get_score_details_test( 'nonfcra','businessinstantid_batch_Chase', 'bnap', date_in , ret63);
// scoring_project_ks.bwr_mac_get_score_details_test( 'nonfcra','businessinstantid_batch_Chase', 'bnas', date_in , ret64);
// scoring_project_ks.bwr_mac_get_score_details_test( 'nonfcra','businessinstantid_batch_Chase', 'bnat', date_in , ret65);




// sequential( ret54 , ret55 , ret56 , ret57 , ret58 , ret59, ret60, ret61, ret62, ret63, ret64 , ret65);
sequential( ret1 , ret2 , ret3);								

EXPORT biidv2_runbins_all := 'todo';