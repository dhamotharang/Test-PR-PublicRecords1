import civ_court;

Civil_Court.Macro_Input_File_List('_matter',Civil_Court.Layout_In_Matter,dTempDataset)

export File_In_Matter := dTempDataset 
					   + Civ_Court.Map_TX_Collin_Matter
					   + Civ_Court.map_TX_Harris_Matter
					   //+ Civ_Court.map_FL_Brevard_Matter
					   + Civ_Court.Map_OH_Hardin_Matter
					   + Civ_Court.Map_MI_Kent_Matter
					   + Civ_Court.Map_OH_Butler_Matter
					   + Civ_Court.Map_OH_Butler_Matter
					   + Civ_Court.Map_OH_Hancock_Matter
					   + Civ_Court.Map_FL_Pasco_Matter
						 + Civ_Court.Map_FL_AlachuaLTE_Matter
						 + Civ_Court.Map_FL_AlachuaNLJ_Matter
						 + Civ_Court.Map_FL_Lake_Matter
						 + Civ_Court.Map_AK_Matter
						 + Civ_Court.Map_PA_Bucks_Matter
						 + Civ_Court.Map_GA_Hall_Matter
						 + Civ_Court.Map_CA_Fresno_Matter
						 + Civ_Court.Map_CA_Kern_Matter
						 + Civ_Court.Map_CA_LosAngeles_Matter
						 + Civ_Court.Map_CA_Marin_Matter
						 + Civ_Court.Map_FL_Orange_Matter
						 + Civ_Court.Map_UT_Matter
						 + Civ_Court.Map_WA_Matter
						 + Civ_Court.Map_AZ_Matter
						 + Civ_Court.Map_MS_Harrison_Matter
						 + Civ_Court.Map_IA_Matter
						 + Civ_Court.Map_MD_Matter
						 + Civ_Court.Map_NJ_Matter
						 + Civ_Court.Map_NY_Downstate_Matter
						 + Civ_Court.Map_NY_Upstate_Matter
						 + Civ_Court.Map_OH_Greene_Matter
						 + Civ_Court.Map_MI_Saginaw_Matter
						 + Civ_Court.map_TX_Gregg_Matter
						 + Civ_Court.map_TX_Denton_Matter
						 + Civ_Court.Map_CT_Matter
						 + Civ_Court.Map_CA_Santa_Barbara_Matter
						 + Civ_Court.Map_CA_San_Bernardino_Matter
						 + Civ_Court.Map_CA_Stanislaus_Matter;