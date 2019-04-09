import data_services;
file_in_charge_crim  := dataset(data_services.foreign_prod+ 'thor_200::in::crim::hd::arrest_charge',
										layout_in_charge,
										CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(2000)))(stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID'
										    );
												
file_in_charge_cw :=  dataset(data_services.foreign_prod+'thor_200::in::crim::hd::arrest_charge_cw',
								      layout_in_charge,
								      CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)))  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID');// and StateCode in _include_states);
											
proj_chg_cw       := Project(file_in_charge_cw,transform(hygenics_crim.layout_in_charge,self.sourcename := trim(left.sourcename)+'_CW'; self := left;));

file_in_charge_ie :=  dataset(data_services.foreign_prod+'thor_200::in::crim::hd::arrest_charge_ie',
								      layout_in_charge,
								      CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)))  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID');// and StateCode in _include_states);
											
proj_chg_ie       := Project(file_in_charge_ie,transform(hygenics_crim.layout_in_charge,self.sourcename := trim(left.sourcename)+'_IE'; self := left;));


export file_in_charge_arrests := file_in_charge_crim + proj_chg_cw + proj_chg_ie: INDEPENDENT;												