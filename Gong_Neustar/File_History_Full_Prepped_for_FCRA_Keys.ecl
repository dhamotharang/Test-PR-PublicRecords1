allowedBellId := ['LSS','LSI','LSP','NEU'];

export File_History_Full_Prepped_for_FCRA_Keys := 
	File_History_Full_Prepped_for_Keys(bell_id in allowedBellId)
	//: PERSIST('~thor40_241::persist::full_prepped_for_fcra_keys');
	: PERSIST('~thor_data400::persist::neustar::gong_history_full_prepped_for_fcra_keys');