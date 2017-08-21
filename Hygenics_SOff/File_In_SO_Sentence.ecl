export File_In_SO_Sentence :=  dataset('~thor200_144::in::sex_offender::hd::sentence',
											Layout_In_SO_Sentence,
											CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(2000))) (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID');// and StateCode in _include_states);