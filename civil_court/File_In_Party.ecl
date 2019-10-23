import civ_court;

Civil_Court.Macro_Input_File_List('_party',Civil_Court.Layout_In_Party,dTempDataset)

export File_In_Party := dTempDataset 
					  + Civ_Court.Map_TX_Collin_Party
					  + Civ_Court.map_TX_Harris_Party
					  //+ Civ_Court.map_FL_Brevard_Party
					  + Civ_Court.Map_OH_Hardin_Party
					  + Civ_Court.Map_MI_Kent_Party
					  + Civ_Court.Map_OH_Butler_Party
					  + Civ_Court.Map_OH_Hancock_Party
					  + Civ_Court.Map_FL_Pasco_Party
						+ Civ_Court.Map_FL_AlachuaLTE_Party
						+ Civ_Court.Map_FL_AlachuaNLJ_Party
						+ Civ_Court.Map_FL_Lake_Party
						+ Civ_Court.Map_AK_Party
						+ Civ_Court.Map_PA_Bucks_Party
						+ Civ_Court.Map_GA_Hall_Party
						+ Civ_Court.Map_CA_Fresno_Party
						+ Civ_Court.Map_CA_Kern_Party
						+ Civ_Court.Map_CA_LosAngeles_Party
						+ Civ_Court.Map_CA_Marin_Party
						+ Civ_Court.Map_FL_Orange_Party
						+ Civ_Court.Map_UT_Party
						+ Civ_Court.Map_WA_Party
						+ Civ_Court.Map_AZ_Party
						+ Civ_Court.Map_MS_Harrison_Party
						+ Civ_Court.Map_IA_Party
						+ Civ_Court.Map_MD_Party
						+ Civ_Court.Map_NJ_Party
						+ Civ_Court.Map_NY_Downstate_Party
						+ Civ_Court.Map_NY_Upstate_Party
						+ Civ_Court.Map_OH_Greene_Party
						+ Civ_Court.Map_MI_Saginaw_Party
						+ Civ_Court.Map_TX_Gregg_Party
						+ Civ_Court.map_TX_Denton_Party
						+ Civ_Court.Map_CT_Party
						+ Civ_Court.Map_CA_Santa_Barbara_Party
						+ Civ_Court.Map_CA_San_Bernardino_Party
						+ Civ_Court.Map_CA_Stanislaus_Party;