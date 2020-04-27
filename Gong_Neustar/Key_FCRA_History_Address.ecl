IMPORT dx_Gong, Data_Services;
EXPORT Key_FCRA_History_Address := dx_Gong.key_history_address(Data_Services.data_env.iFCRA) : DEPRECATED('Use dx_gong.key_history_address instead');
