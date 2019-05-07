import data_services;
addresshistory    :=  dataset(data_services.foreign_prod+ 'thor_200::in::crim::HD::county_address_history',
												layout_in_addresshistory,
												CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(2000)))  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID');//and StateCode ~in _include_states);
												
addresshistory_cw :=  dataset(data_services.foreign_prod+'thor_200::in::crim::hd::county_address_history_cw',
								      layout_in_addresshistory,
								      CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)))  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID');// and StateCode in _include_states);
											
proj_addrhist_cw       := Project(addresshistory_cw,transform(hygenics_crim.layout_in_addresshistory,self.sourcename := trim(left.sourcename)+'_CW'; self := left;));

addresshistory_ie :=  dataset(data_services.foreign_prod+'thor_200::in::crim::hd::county_address_history_ie',
								      layout_in_addresshistory,
								      CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)))  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID');// and StateCode in _include_states);
											
proj_addrhist_ie       := Project(addresshistory_ie,transform(hygenics_crim.layout_in_addresshistory,self.sourcename := trim(left.sourcename)+'_IE'; self := left;));

export file_in_addresshistory_counties := (addresshistory + proj_addrhist_cw + proj_addrhist_ie)(trim(street)+trim(city)+trim(orig_zip) NOT IN _functions.StreetAddressToFilter);