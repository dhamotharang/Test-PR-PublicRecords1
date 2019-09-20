import data_services,lib_stringlib;

filter_these := ['AKA','NO','REMOVE','AGE'];
file_in_alias_counties1 := dataset(data_services.foreign_prod+ 'thor_200::in::crim::HD::county_alias',
											hygenics_crim.layout_in_alias,
											CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(2000)))  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID');// and StateCode in _include_states);
// output(file_in_alias_counties1(recordid ='OHCUYAHOGACOMMONPLEAS85452'));
											
alias_cw      :=  dataset(data_services.foreign_prod+'thor_200::in::crim::hd::county_alias_cw',
								   layout_in_alias,
								   CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)))  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID' and trim(SourceName, left, right)<>'NORTH_CAROLINA_ADMINISTRATIVE_OFFICE_OF_THE_COURTS');// and StateCode in _include_states);
proj_alias_cw  := Project(alias_cw,transform(hygenics_crim.layout_in_alias,self.sourcename := trim(left.sourcename)+'_CW'; self := left;));

alias_ie       :=  dataset(data_services.foreign_prod+'thor_200::in::crim::hd::county_alias_ie',
								   layout_in_alias,
								   CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)))  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID' and trim(SourceName, left, right)<>'NORTH_CAROLINA_ADMINISTRATIVE_OFFICE_OF_THE_COURTS');// and StateCode in _include_states);
proj_alias_ie  :=  Project(alias_ie,transform(hygenics_crim.layout_in_alias,self.sourcename := trim(left.sourcename)+'_IE'; self := left;));

allakas        := proj_alias_ie+proj_alias_cw+ file_in_alias_counties1;
									
filter_invalid := allakas(trim(akaname) <>'AKA' and regexfind(' DOB[: ]',akaname,0)='' and
                                          akaname+akalastname+akafirstname+akamiddlename <> '' and
																					length(trim(akaname+akalastname+akafirstname+akamiddlename,left,right)) >= 2);										
alias_counties := filter_invalid;
 
	hygenics_crim.layout_in_alias  removeAKA(alias_counties l):= transform

		self.akaname     :=   MAP(regexfind('^LIC#[A-Z]+[0-9]+',trim(l.akaname)) => 'REMOVE',
		                          regexfind('^(AKA[, ])(.*)( AKA)[ ]*$',trim(l.akaname)) => trim(regexreplace('^(AKA[, ])(.*)( AKA)[ ]*$',trim(l.akaname),'$2'),left),
		                          regexfind('^(AKA[, ])(.*)',trim(l.akaname)) => trim(regexreplace('^(AKA[, ])(.*)',trim(l.akaname),'$2'),left),
		                          regexfind('^(.*)(, AKA)[ ]*$',trim(l.akaname)) => regexreplace('^(.*)(, AKA)[ ]*$',trim(l.akaname),'$1'),	
														  regexfind('^(.*)( AKA)[ ]*$',trim(l.akaname)) => regexreplace('^(.*)( AKA)[ ]*$',trim(l.akaname),'$1'),
															
														  regexfind('[: ,-;/]AKA[: ,-;/]',trim(l.akaname)) => 'REMOVE',
                              l.sourcename='OHIO_CUYAHOGA_COMMON_PLEAS_COURT' => lib_stringlib.stringlib.stringfilterout(l.akaname,'/'),                                                                    

															l.akaname);
															
    self.akalastname    :=  Map(
		                        //regexfind('^AKA (.*)',l.akalastname) => regexreplace('^AKA (.*)',l.akalastname,'$1'),
		                        //regexfind('(.*) AKA[ ]*$',l.akalastname) => regexreplace('(.*) AKA[ ]*$',l.akalastname,'$1') ,
														l.akalastname IN ['AKA','AKA:','/'] => '',
		                        l.akalastname);		
														
														
    //we need to set the middle names to blank so the cleaner logic (which uses FML format for alias) will work. akaname has the name is LFM format. 															
    self.akamiddlename := MAP(l.akamiddlename IN ['/','AKA']=>'',l.akamiddlename); 
		self.akafirstname  := MAP(l.akafirstname  IN ['/','AKA']=>'',l.akafirstname); 
		self 			   := l;
	end;

	filtered_alias_counties := project(alias_counties, removeAKA(left)); 	
	
 // output(count(filtered_alias_counties(fixedaka<> '' )));
 // output(filtered_alias_counties(akaname = 'REMOVE' ));
 // output(filtered_alias_counties(akaname = ''   and akafirstname = '' and akamiddlename = '') );
 
	filtered_alias_counties1 :=  filtered_alias_counties(akaname not in filter_these and regexfind('^AKA |[: ,-;/]AKA[: ,-;/]|AKA[0-9]+ AKA[0-9]+|[(]AKA|[)]AKA',akaname,0)= '');		
	EXPORT file_in_alias_counties  :=filtered_alias_counties1(akaname <> '' or akalastname <> '' or akafirstname <> '' or  akamiddlename <> '');
	 