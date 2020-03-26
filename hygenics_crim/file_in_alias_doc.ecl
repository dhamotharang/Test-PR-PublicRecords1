import data_services;

file_alias :=  dataset(data_services.foreign_prod+ 'thor_200::in::crim::hd::doc_alias',
							          	layout_in_alias,
								          CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)))  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID');// and StateCode in _include_states);


alias_cw      :=  dataset(data_services.foreign_prod+'thor_200::in::crim::hd::doc_alias_cw',
								          layout_in_alias,
								          CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)))  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID' and trim(SourceName, left, right)<>'NORTH_CAROLINA_ADMINISTRATIVE_OFFICE_OF_THE_COURTS');// and StateCode in _include_states);
proj_alias_cw  := Project(alias_cw,transform(hygenics_crim.layout_in_alias,self.sourcename := trim(left.sourcename)+'_CW'; self := left;));

alias_ie       :=  dataset(data_services.foreign_prod+'thor_200::in::crim::hd::doc_alias_ie',
								   layout_in_alias,
								   CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)))  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID' and trim(SourceName, left, right)<>'NORTH_CAROLINA_ADMINISTRATIVE_OFFICE_OF_THE_COURTS');// and StateCode in _include_states);
proj_alias_ie  :=  Project(alias_ie,transform(hygenics_crim.layout_in_alias,self.sourcename := trim(left.sourcename)+'_IE'; self := left;));


allakas        := proj_alias_ie+ proj_alias_cw+ file_alias;		

export file_in_alias_doc := allakas;