import ut;
EXPORT File_Transunion_Update_In := 
						DATASET('~thor_data400::in::transunionptrak_update',
						Transunion_PTrak.Layout_Transunion_Update_In , 
						FLAT);