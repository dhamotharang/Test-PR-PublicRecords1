import data_services;
alias_arrests1:= dataset(data_services.foreign_prod+ 'thor_200::in::crim::hd::arrest_alias',
											hygenics_crim.layout_in_alias,
											CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(2000)))(stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID'
											          ) ;
filter_these := ['AKA','NO','REMOVE','AGE'];

alias_cw      :=  dataset(data_services.foreign_prod+'thor_200::in::crim::hd::arrest_alias_cw',
								   layout_in_alias,
								   CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)))  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID' and trim(SourceName, left, right)<>'NORTH_CAROLINA_ADMINISTRATIVE_OFFICE_OF_THE_COURTS');// and StateCode in _include_states);
proj_alias_cw  := Project(alias_cw,transform(hygenics_crim.layout_in_alias,self.sourcename := trim(left.sourcename)+'_CW'; self := left;));

alias_ie      :=  dataset(data_services.foreign_prod+'thor_200::in::crim::hd::arrest_alias_ie',
								   layout_in_alias,
								   CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)))  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID' and trim(SourceName, left, right)<>'NORTH_CAROLINA_ADMINISTRATIVE_OFFICE_OF_THE_COURTS');// and StateCode in _include_states);
proj_alias_ie  := Project(alias_ie,transform(hygenics_crim.layout_in_alias,self.sourcename := trim(left.sourcename)+'_IE'; self := left;));

alias_arrests  := proj_alias_ie+proj_alias_cw+alias_arrests1;

filter_invalid := alias_arrests(trim(akaname) <>'AKA' and
                                          akaname+akalastname+akafirstname+akamiddlename <> '' and
																					length(trim(akaname+akalastname+akafirstname+akamiddlename,left,right)) >= 2 and 
																					regexfind('PIN#|DOB[ /:]|[(]AKA',akaname,0) ='' 

																					);
																
hygenics_crim.layout_in_alias  removeAKA(alias_arrests l):= transform

		self.akaname     :=   MAP(regexfind('^(AKA[, ])(.*)( AKA)[ ]*$',trim(l.akaname)) => trim(regexreplace('^(AKA[, ])(.*)( AKA)[ ]*$',trim(l.akaname),'$2'),left),
		                          regexfind('^(AKA[,: ])(.*)',trim(l.akaname)) => trim(regexreplace('^(AKA[,: ])(.*)',trim(l.akaname),'$2'),left),
		                          regexfind('^(.*)(, AKA)[ ]*$',trim(l.akaname)) => regexreplace('^(.*)(, AKA)[ ]*$',trim(l.akaname),'$1'),	
														  regexfind('^(.*)([- {/]AKA)[ ]*$',trim(l.akaname)) => regexreplace('^(.*)([- {/]AKA)[ ]*$',trim(l.akaname),'$1'),
														  regexfind('[: ,-;*/]AKA[: ,-;/]',trim(l.akaname)) => 'REMOVE',
				                      l.akaname);
															
    self.akalastname    :=  Map(
		                        l.akalastname IN ['AKA','AKA:'] => '',
														l.akalastname[1..4] ='AKA ' =>l.akalastname[5..] ,
		                        l.akalastname);		
		self.akafirstname    :=  Map(
		                        l.akafirstname IN ['AKA','AKA:'] and (l.akalastname ='' or l.akamiddlename ='')=> '',
		                        l.akafirstname);														
														
        //we need to set the middle names to blank so the cleaner logic (which uses FML format for alias) will work. akaname has the name is LFM format. 															
    self.akamiddlename := MAP(l.akamiddlename IN ['AKA','AKA:','{AKA'] =>'',l.akamiddlename); 
		self 			   := l;
	end;

	filtered_alias := project(filter_invalid, removeAKA(left)); 

//Set_pty_nm:=['ANTHONY;LEWIS TONY AKA LOUIS                            ','SEXYCHOCOLAT E-AKA DANIELS                              ','SEXYCHOCOLAT E-AKA DANIELS                              ','SEXYCHOCOLAT E-AKA DANIELS                              ','KENNETH WAYNE *AKA NIGHT WILLIAMS                       ','TONY AKA LOPEZ                                          ','KENNETH WAYNE *AKA NIGHT WILLIAMS                       ','TONY AKA LOPEZ                                          ','TONY AKA LOPEZ                                          '];

//output( filtered_alias   (akaname ='Set_pty_nm'));
 
EXPORT file_in_alias_arrests := 	filtered_alias(akaname not in filter_these);	
 
 	
	
 