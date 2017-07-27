allowedBellId := ['LSS','LSI','LSP'];

export File_History_Full_Prepped_for_FCRA_Keys := 
	File_History_Full_Prepped_for_Keys(bell_id in allowedBellId)
	//: PERSIST('~thor40_241::persist::full_prepped_for_fcra_keys');
	: PERSIST('~thor_data400::persist::gong_history_full_prepped_for_fcra_keys');