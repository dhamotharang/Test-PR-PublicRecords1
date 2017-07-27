export File_service := dataset('~thor_data400::in::ecrash::service'
															,FLAccidents_Ecrash.Layout_service
															,csv(terminator('\n'),maxlength(10000),separator(','), quote('"')))(SERVICE_ID != 'SERVICE_ID');