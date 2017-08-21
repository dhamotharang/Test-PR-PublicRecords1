import civ_court;

Civil_Court.Macro_Input_File_List('_activity',Civil_Court.Layout_In_Case_Activity,dTempDataset)

export File_In_Case_Activity := dTempDataset 
															+ Civ_Court.Map_TX_Collin_Case_Activity
															+ Civ_Court.Map_FL_AlachuaNLJ_Activity
															+ Civ_Court.Map_FL_Orange_Activity
															+ Civ_Court.Map_WA_Activity
															+ Civ_Court.Map_AZ_Activity
															+ Civ_Court.Map_NY_Downstate_Activity
															+ Civ_Court.Map_NY_Upstate_Activity
															+ Civ_Court.Map_MI_Saginaw_Activity
															+ Civ_Court.Map_TX_Gregg_Activity
															+ Civ_Court.Map_CT_Activity;