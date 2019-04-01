import data_services;

 alias         :=  dataset(data_services.foreign_prod+'thor_200::in::crim::hd::aoc_alias',
								           layout_in_alias,
								           CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)))  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID' and trim(SourceName, left, right)<>'NORTH_CAROLINA_ADMINISTRATIVE_OFFICE_OF_THE_COURTS');// and StateCode in _include_states);
//output(count(alias));

alias_sc    := alias(sourcename ='SOUTH_CAROLINA_ADMINISTRATOR_OF_THE_COURTS' and not(regexfind('^([0-9]|[?])',akaname,0)<> '' or akaname ='.'));
alias_nonSC := alias(sourcename <> 'SOUTH_CAROLINA_ADMINISTRATOR_OF_THE_COURTS' and not(regexfind('^([0-9]|[?])',akaname,0)<> '' or akaname ='.'));
temp_alias  := alias_sc+alias_nonSC;

 alias_cw      :=  dataset(data_services.foreign_prod+'thor_200::in::crim::hd::aoc_alias_cw',
								   layout_in_alias,
								   CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)))  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID' and trim(SourceName, left, right)<>'NORTH_CAROLINA_ADMINISTRATIVE_OFFICE_OF_THE_COURTS');// and StateCode in _include_states);
proj_alias_cw  := Project(alias_cw,transform(hygenics_crim.layout_in_alias,self.sourcename := trim(left.sourcename)+'_CW'; self := left;));

alias_ie       :=  dataset(data_services.foreign_prod+'thor_200::in::crim::hd::aoc_alias_ie',
								   layout_in_alias,
								   CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)))  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID' and trim(SourceName, left, right)<>'NORTH_CAROLINA_ADMINISTRATIVE_OFFICE_OF_THE_COURTS');// and StateCode in _include_states);
proj_alias_ie  :=  Project(alias_ie,transform(hygenics_crim.layout_in_alias,self.sourcename := trim(left.sourcename)+'_IE'; self := left;));

export file_in_alias := temp_alias(regexfind('^AKA |[:/ ]AKA[:/ ]|AKA[0-9]+ AKA[0-9]+|[(]AKA',akaname,0)= ''  )+proj_alias_cw + proj_alias_ie:INDEPENDENT;