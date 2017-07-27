import ut;
EXPORT File_Transunion_Clean_Normalized_Out 
					:= dataset('~thor_data400::in::transunionptrak_clean_normalized',
								Transunion_PTrak.Layout_Transunion_Out.LayoutTransunionBaseOut, 
								flat);