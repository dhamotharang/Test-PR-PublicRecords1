import DriversV2, doxie;

//base := DriversV2.Files_DL_Conv_Points_Base.Base_Conviction;	
//Due to failed job - Sort Skew while running the DL Build

base := distribute(DriversV2.Files_DL_Conv_Points_Base.Base_Conviction,random());			   

export Key_DL_Conviction_DLCPKey := index(base,
						                  {DLCP_Key},
						                  {base},
						                  '~thor_data400::key::dl2::'+doxie.Version_SuperKey+'::Conviction_DLCP_Key');

