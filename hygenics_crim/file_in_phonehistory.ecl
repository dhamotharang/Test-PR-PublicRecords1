export file_in_phonehistory
		:=  dataset('~thor200_144::in::crim::aoc_phonehistory',
								layout_in_phonehistory,
								CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(2000)))  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID');// and StateCode in _include_states);

