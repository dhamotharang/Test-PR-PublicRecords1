import ut;
export file_in_other_doc 		:=  dataset(ut.foreign_prod+ 'thor_200::in::crim::hd::doc_other',
								layout_in_other,
								CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4000)))  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID');
