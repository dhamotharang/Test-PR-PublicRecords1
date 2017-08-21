import ut;
export file_in_other_arrests := dataset(ut.foreign_prod+ 'thor_200::in::crim::hd::arrest_other',
										layout_in_other,
										CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(2000)))  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID');