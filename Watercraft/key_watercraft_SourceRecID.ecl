import data_services, doxie;

in_sh 		:= watercraft.File_Base_Search_Dev;
export key_watercraft_SourceRecID := index(in_sh,{source_rec_id},{state_origin,watercraft_key,sequence_key},
																					 data_services.data_location.prefix() + 'thor_data400::key::watercraft_Source_Rec_Id_'+doxie.Version_SuperKey);