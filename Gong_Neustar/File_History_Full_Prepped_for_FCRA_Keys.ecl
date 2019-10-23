import std;
allowedBellId := ['LSS','LSI','LSP','NEU'];

Gong_Neustar.macRecordSuppression(File_History_PreProcess_for_Keys(bell_id in allowedBellId), Suppressed, phone10, true) ;

export File_History_Full_Prepped_for_FCRA_Keys := 
	Suppressed
	: PERSIST('~thor_data400::persist::neustar::gong_history_full_prepped_for_fcra_keys');
	