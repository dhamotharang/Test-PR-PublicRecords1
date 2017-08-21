import data_services;
file_Charge := 		
                dataset(data_services.foreign_prod+ 'thor_200::in::crim::hd::doc_charge',
								layout_in_charge,
								CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)))  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID');// and StateCode in _include_states);

file_in_charge_cw :=  dataset(data_services.foreign_prod+'thor_200::in::crim::hd::doc_charge_cw',
								      layout_in_charge,
								      CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)))  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID');// and StateCode in _include_states);
proj_chg_cw       := Project(file_in_charge_cw,transform(hygenics_crim.layout_in_charge,self.sourcename := trim(left.sourcename)+'_CW'; self := left;));

export file_in_charge_doc:= file_charge + proj_chg_cw;	