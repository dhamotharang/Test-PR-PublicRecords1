import ut;
EXPORT File_Transunion_Cash_Address := 
						DATASET(SuperFileList.CashAddress,
						Transunion_PTrak.Layout_Transunion_Out.NormCleanAddressRec , 
						FLAT);