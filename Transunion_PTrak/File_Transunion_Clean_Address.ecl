import ut;
EXPORT File_Transunion_Clean_Address := 
						DATASET(SuperFileList.CleanAddress,
						Transunion_PTrak.Layout_Transunion_Out.NormCleanAddressRec , 
						FLAT);