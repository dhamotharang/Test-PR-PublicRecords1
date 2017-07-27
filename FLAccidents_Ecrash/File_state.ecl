export File_state := dataset('~thor_data400::in::ecrash::state'
															,FLAccidents_Ecrash.Layout_state
															,csv(terminator('\n'),maxlength(10000),separator(','), quote('"')))(STATE_ABBR != 'STATE_ABBR');