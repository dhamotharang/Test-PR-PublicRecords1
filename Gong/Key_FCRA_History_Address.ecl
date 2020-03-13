//gong key based on some address fields
Import dx_Gong, data_services;

export Key_FCRA_History_Address := dx_Gong.Key_History_Address(data_services.data_env.iFCRA);
