export file_in_other
		:=  dataset('~thor_400::in::crim::hd::aoc_other',
								layout_in_other,
								CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4000)))  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID');

