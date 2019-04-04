import data_services;
Offense_doc 	 :=  dataset(data_services.foreign_prod+ 'thor_200::in::crim::hd::doc_offense',
								           layout_in_offense,
								           CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(6000)))  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID');// and StateCode in _include_states);


Offense_doc_CW := dataset(data_services.foreign_prod+'thor_200::in::crim::hd::doc_offense_cw', hygenics_crim.layout_in_offense,
										    	CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)))
												  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID' ) ;

proj_off_cw         := Project(Offense_doc_CW,transform(hygenics_crim.layout_in_offense,self.sourcename := trim(left.sourcename)+'_CW'; self := left;));


Offense_doc_IE := dataset(data_services.foreign_prod+'thor_200::in::crim::hd::doc_offense_IE', hygenics_crim.layout_in_offense,
										    	CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)))
												  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID' ) ;

proj_off_IE         := Project(Offense_doc_IE,transform(hygenics_crim.layout_in_offense,self.sourcename := trim(left.sourcename)+'_IE'; self := left;));


all_together        := Offense_doc+proj_off_cw+proj_off_IE;

export file_in_offense_doc := all_together;