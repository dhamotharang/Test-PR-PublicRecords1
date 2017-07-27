export File_Tag_History := dataset('~thor_data400::in::ecrash::historical::tag'
															,FLAccidents_Ecrash.Layout_Tag_History
															,csv(terminator('\n'),maxlength(500000),separator(','), quote('')))(vin != 'VIN');