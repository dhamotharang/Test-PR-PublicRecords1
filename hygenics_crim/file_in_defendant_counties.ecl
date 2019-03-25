import data_services,lib_date,STD;
defendant_file := dataset(data_services.foreign_prod+ 'thor_200::in::crim::HD::county_defendant',
										layout_in_defendant,
										CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4000)))  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID');

/* defendantstatus for ca_santa_barbara is now BLANK -- removing filter									
ca_santa_barbara := defendant_file(sourcename ='CALIFORNIA_SANTA_BARBARA_COUNTY' and 
                                   defendantstatus in ['CURRENTLY KNOWN AS','AKA','ALSO KNOWN AS','DEFENDANT TRUE NAME']);
Others           := defendant_file(sourcename <> 'CALIFORNIA_SANTA_BARBARA_COUNTY');	
file_in_defendant_all := ca_santa_barbara +Others;		
*/
defendant_crimwise :=  dataset(data_services.foreign_prod+'thor_200::in::crim::hd::county_defendant_cw', hygenics_crim.layout_in_defendant,
														CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)))
														(stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID');

proj_def_cw           := Project(defendant_crimwise,transform(hygenics_crim.layout_in_defendant,self.sourcename := trim(left.sourcename)+'_CW'; self := left;));

defendant_IE  := dataset(data_services.foreign_prod+'thor_200::in::crim::hd::county_defendant_ie', hygenics_crim.layout_in_defendant,
														CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)))
														(stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID' and nametype<>'B' and name not in ['UNKNOWN', 'RESTRICTED', 'EXPUNGED', 'EXPUNGED EXPUNGED', 'NONAME'] and regexfind('[0-9][0-9]+', name[1..2], 0)='') ;

proj_def_IE           := Project(defendant_IE,transform(hygenics_crim.layout_in_defendant,self.sourcename := trim(left.sourcename)+'_IE'; self := left;));

file_in_offense_all 	:= hygenics_crim.file_in_offense_counties;
file_in_defendant_all := defendant_file(name<>'AKA')+ proj_def_cw+proj_def_IE;

//Added 60 Day Restriction to INDIANA Sourced Data///////////////////////////////////////////////////////////////////

	ds_filter 	:= file_in_defendant_all(statecode<>'IN'); 
	ds_IN				:= file_in_defendant_all(statecode='IN' and LIB_Date.DaysApart(recorduploaddate,(string)STD.date.today() )<=60);
											
file_in_defendant_all_fltred	:= ds_filter + ds_IN;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	layout_in_defendant findComp(file_in_defendant_all_fltred l):= transform
		 self.name 		:= Map(hygenics_crim._functions.is_company(l.name)=1 and l.dob='' and l.gender[1] not in ['F','M'] and l.height='' and l.weight='' => '', 
							           regexfind('[-/@* (]JUV[-/*@  )]|JUVENILE|[-/@* (]JUV$',l.name) => '',
												 regexfind('IN, THE M',l.name) => '',
												 regexfind('([A-Za-z ,/]+ )(1)$',l.name) => regexreplace('([A-Za-z ,/]+ )(1)$',l.name,'$1') ,
												 regexfind('^AKA[:, ]+(.*)',l.lastname) => regexreplace('^AKA[:, ]+(.*)',l.name,'$1') ,
												 regexfind('(.*) AKA[ ]*$',l.lastname) => regexreplace('(.*) AKA[, ]+(.*)',l.name,'$1 $2') ,
												 l.lastname ='AKA' and regexfind('^AKA[,]* (.*)',l.name) =>regexreplace('^AKA[,]* (.*)',l.name,'$1'), 
												 l.lastname ='AKA' and regexfind('(.*) AKA[ ]*$',l.name) => regexreplace('(.*) AKA[ ]*$',l.name,'$1'),
												 l.name);
    self.lastname    := Map(regexfind('^AKA (.*)[ ]*',l.lastname) => regexreplace('^AKA (.*)[ ]*',l.lastname,'$1'),
		                        regexfind('(.*) AKA[ ]*$',l.lastname) => regexreplace('(.*) AKA[ ]*$',l.lastname,'$1') ,
														l.lastname IN ['AKA','AKA:'] => '',
		                        l.lastname);
		self.nametype := '';                     
		self 			:= l;
	end;

	remove_companies 	:= project(file_in_defendant_all_fltred(), findComp(left));
	remove_comp			:= remove_companies(name<>'' and regexfind('[(]AKA',firstname,0) ='' and regexfind('^["]*AKA[":,/]|^A.K.A',name,0)='' and regexfind('[(]AKA',firstname,0) ='');			
	
	// Remove offender orphan records whose offenses have been filtered out
	Filtered_Offense_Sources := ['NEVADA_CLARK_COUNTY_DISTRICT_COURTS','GEORGIA_COBB_COUNTY','FLORIDA_OKALOOSA_COUNTY','TEXAS_GREGG_COUNTY','DISTRICT_OF_COLUMBIA_SUPERIOR_COURT'];
	
	fltrdSrc_off      	:= file_in_offense_all(sourcename IN Filtered_Offense_Sources);
	not_fltrdSrc_off		:= file_in_offense_all(sourcename NOT IN Filtered_Offense_Sources);

	fltrdSrc_def				:= remove_comp(sourcename IN Filtered_Offense_Sources);
	not_fltrdSrc_def		:= remove_comp(sourcename NOT IN Filtered_Offense_Sources);

	hygenics_crim.layout_in_defendant noCivil(fltrdSrc_off l, fltrdSrc_def r):= transform	
		self := r;
	end;

  fltrdSrc_def_off_mat 			:= join(fltrdSrc_off, fltrdSrc_def,
													left.recordid = right.recordid and
													left.statecode = right.statecode,
													noCivil(left, right));
  fltrdSrc_def_off_match 		:= dedup(sort(fltrdSrc_def_off_mat, statecode, recordid), record);													
													
	all_def := not_fltrdSrc_def + fltrdSrc_def_off_match;
export file_in_defendant_counties :=all_def():persist('~thor200_144::persist::in::crim::county_defendant_filtered');										