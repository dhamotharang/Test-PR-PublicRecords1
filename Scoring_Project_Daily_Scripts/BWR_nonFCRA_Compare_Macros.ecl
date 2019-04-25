       
import Scoring_Project_Macros, Scoring_Project_PIP;
test1 :=		Scoring_Project_PIP.Generic_Tracking_Report('scoringqa::out::nonfcra::ita_batch_capitalone_attributes_v3_', scoring_project_Macros.Global_Output_Layouts.NONFCRA_ITA_BATCH_CapitalOne_attributes_v3_Global_Layout, 'Capone ITA v3', 'acctno');
test2 :=		Scoring_Project_PIP.Generic_Tracking_Report('scoringqa::out::nonfcra::leadintegrity_xml_generic_attributes_v4_', scoring_project_Macros.Global_Output_Layouts.NONFCRA_LeadIntegrity_Attributes_V4_Global_Layout, 'Leadintegrity v4', 'accountnumber');
test3 :=		Scoring_Project_PIP.Generic_Tracking_Report('scoringqa::out::nonfcra::pi02_xml_chase_fp3710_0_', scoring_project_Macros.Global_Output_Layouts.NONFCRA_Chase_PIO2_Global_Layout, 'Chase PI02', 'acctno');
test4 :=		Scoring_Project_PIP.Generic_Tracking_Report('scoringqa::out::nonfcra::fraudpoint_xml_american_express_fp1109_0_v201_', scoring_project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V201_AmericanExpress_Global_Layout, 'FPV201', 'acctno');
test5 :=		Scoring_Project_PIP.Generic_Tracking_Report('scoringqa::out::nonfcra::cbbl_xml_chase_', scoring_project_Macros.Global_Output_Layouts.NONFCRA_Chase_CBBL_Global_Layout, 'Chase CBBL', 'acctNo');
test6 :=		Scoring_Project_PIP.Generic_Tracking_Report('scoringqa::out::nonfcra::bnk4_xml_chase_bd3605_0_',scoring_project_Macros.Global_Output_Layouts.NONFCRA_Chase_BNK4_Global_Layout, 'Chase BNK4', 'acctNo');
test7 :=		Scoring_Project_PIP.Generic_Tracking_Report('ScoringQA::out::NONFCRA::Profile_Booster_Batch_CapitalOne_attributes_v1_',scoring_project_Macros.Global_Output_Layouts.ProfileBooster_layout, 'Proflie Booster', 'AcctNo');
test8 :=		Scoring_Project_PIP.Generic_Tracking_Report('scoringqa::out::nonfcra::businessinstantid_xml_generic_',scoring_project_Macros.Global_Output_Layouts.Temp_Legacy_BusinessInstantId_Layout, 'BIID Generic', 'AcctNo');
test9 := 	Scoring_Project_Macros.IID_Run_Compare;


sequential(test1,test7,test2,test3,test4,test5,test6,test8,test9);
FileServices.SendEmail('Bridgett.braaten@lexisnexis.com; Matthew.Ludewig@lexisnexisrisk.com', 'Cert nonFCRA Tracking Reports:', WORKUNIT);

EXPORT BWR_nonFCRA_Compare_Macros := 'todo';