import data_services;
offense_counties := dataset(data_services.foreign_prod+ 'thor_200::in::crim::HD::county_offense',
										        layout_in_offense,
										        CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(2000)))  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID');// and StateCode in _include_states);
										
Offense_counties_CW := dataset(data_services.foreign_prod+'thor_200::in::crim::hd::county_offense_cw', hygenics_crim.layout_in_offense,
										    			 CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)))
												    	 (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID' ) ;

proj_off_cw         := Project(Offense_counties_CW,transform(hygenics_crim.layout_in_offense,self.sourcename := trim(left.sourcename)+'_CW'; self := left;));

Offense_counties_IE := dataset(data_services.foreign_prod+'thor_200::in::crim::hd::county_offense_IE', hygenics_crim.layout_in_offense,
										    			 CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)))
												    	 (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID' ) ;

proj_off_IE         := Project(Offense_counties_IE,transform(hygenics_crim.layout_in_offense,self.sourcename := trim(left.sourcename)+'_IE'; self := left;));

all_together        := offense_counties+proj_off_cw+proj_off_IE;								
export file_in_offense_counties := all_together(regexfind('CIVIL',casetype,0) ='' and 
                                                casetype not in ['FUGITIVE','SEARCH WARRANT','WARRANT','JUVENILE'] and 
                                                casestatus not in ['FUGITIVE','SEARCH WARRANT','WARRANT','JUVENILE'])+
																	 all_together(regexfind('CIVIL INFRACTION',casetype,0) <> '' or regexfind('CIVIL TRAFFIC',casetype,0) <> '')
																	 :INDEPENDENT;

                 
