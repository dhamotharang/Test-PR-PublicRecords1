IMPORT dx_Gong, Data_Services;
EXPORT Key_FCRA_Business_Header_Phone_Table_Filtered_V2 := dx_Gong.key_phone_table(Data_Services.data_env.iFCRA) : DEPRECATED('Use dx_gong.dx_Gong.key_phone_table instead');
		