export File_Vin_History := dataset('~thor_data400::in::ecrash::historical::vin'
																			,FLAccidents_Ecrash.Layout_Vin_History
																			,csv(terminator('\n'),maxlength(10000),separator(','), quote('')));