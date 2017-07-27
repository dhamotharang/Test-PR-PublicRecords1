import ut;
EXPORT File_CP_Transunion_Clean_Normalized_Out
					:= dataset('~thor_data400::in::transunion_CP_clean_normalized',
								Transunion_PTrak.Layout_CP_Tucs_Out.Layout_CP_Tucs_Final_Out, 
								flat);