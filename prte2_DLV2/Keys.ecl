IMPORT  doxie,mdr, prte2_DLV2;

EXPORT keys := MODULE

EXPORT key_dl2_accident_dlcp_key := INDEX(FILES.Base_Accident(dlcp_key!=''),  {dlcp_key},  {FILES.Base_Accident}, Constants.KeyName_dl2 + '@version@::accident_dlcp_key');

EXPORT key_dl2_conviction_dlcp_key := INDEX(FILES.Base_Conviction(dlcp_key!=''),  
	{dlcp_key},  
	{Files.Base_Conviction}, 
	Constants.KeyName_dl2 + doxie.Version_SuperKey + '::conviction_dlcp_key');

EXPORT key_dl2_dl_did_public := INDEX(FILES.dl2_dl_number(did!=0),  
	{did},  
	{Files.dl2_dl_number}, 
	Constants.KeyName_dl2 + doxie.Version_SuperKey + '::dl_did_public');

EXPORT key_dl2_dl_number_public := INDEX(FILES.dl2_dl_number(dl_number!=''),  
	{typeof(Files.dl2_dl_number.dl_number) s_dl := Files.dl2_dl_number.dl_number},  
	{Files.dl2_dl_number}, 
	Constants.KeyName_dl2 + doxie.Version_SuperKey + '::dl_number_public');

EXPORT key_dl2_dl_seq := INDEX(FILES.File_DL_Search(dl_seq!=0),  
	{dl_seq},  
	{FILES.File_DL_Search}, 
	Constants.KeyName_dl2 + doxie.Version_SuperKey + '::dl_seq');

EXPORT key_dl2_dr_info_dlcp_key := INDEX(FILES.Base_DR_Info,  
	{dlcp_key},  
	{Files.Base_DR_Info}, 
	Constants.KeyName_dl2 + doxie.Version_SuperKey + '::dr_info_dlcp_key');

EXPORT key_dl2_suspension_dlcp_key := INDEX(FILES.Base_Suspension,  
	{dlcp_key},  
	{Files.Base_Suspension}, 
	Constants.KeyName_dl2 + doxie.Version_SuperKey + '::suspension_dlcp_key');

EXPORT Key_DL_UberWords := INDEX(FILES.UBER_WORD_IN, 
	{word},
	{cnt,id,field_specificity},
	Constants.ak_keyname+'UberWords');

EXPORT Key_DL_UberRefs :=INDEX(FILES.UBER_INV_TAB, 
	{FILES.UBER_INV_TAB},
	{},   
	Constants.ak_keyname +'UberRefs',SORTED);

EXPORT key_dl2_fra_insur_dlcp_key := INDEX(FILES.dl2_fra_insur,  
	{dlcp_key},  
	{FILES.dl2_fra_insur}, 
	Constants.KeyName_dl2 + doxie.Version_SuperKey + '::fra_insur_dlcp_key');

export Key_DL_Indicatives := index(Files.DS_Indicative, 
	{race, sex_flag, age, orig_state, randomizer}, 
	{dl_number}, 
	Constants.KeyName_dl2 + doxie.Version_SuperKey + '::dl_indicatives_public');
								
END;
