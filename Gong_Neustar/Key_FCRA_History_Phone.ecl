IMPORT dx_Gong, Data_Services;
EXPORT key_fcra_history_phone := dx_Gong.key_history_phone(Data_Services.data_env.iFCRA) : DEPRECATED('Use dx_gong.key_history_phone instead');
