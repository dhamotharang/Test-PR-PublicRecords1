import data_services;

addresshistory    :=  dataset(data_services.foreign_prod+'thor_200::in::crim::hd::aoc_address_history',
								layout_in_addresshistory,
								CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)))  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID' and trim(SourceName, left, right)<>'NORTH_CAROLINA_ADMINISTRATIVE_OFFICE_OF_THE_COURTS');// and StateCode in _include_states);

addresshistory_cw :=  dataset(data_services.foreign_prod+'thor_200::in::crim::hd::aoc_address_history_cw',
								      layout_in_addresshistory,
								      CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)))  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID');// and StateCode in _include_states);
											
proj_addrhist_cw       := Project(addresshistory_cw,transform(hygenics_crim.layout_in_addresshistory,self.sourcename := trim(left.sourcename)+'_CW'; self := left;));

export file_in_addresshistory := addresshistory + proj_addrhist_cw : INDEPENDENT;