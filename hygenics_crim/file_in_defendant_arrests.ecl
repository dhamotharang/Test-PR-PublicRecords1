import  ut,lib_date,data_services,STD;

 file_in_defendant_arrests_raw   :=  dataset(data_services.foreign_prod+ 'thor_200::in::crim::hd::arrest_defendant',
								layout_in_defendant,
								CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(6000))) (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID' 
								                      );

a := file_in_defendant_arrests_raw(sourcename = 'IDAHO_ADA_COUNTY_ARRESTS' and name not in ['F','I','M','']);
b := file_in_defendant_arrests_raw(sourcename <> 'IDAHO_ADA_COUNTY_ARRESTS');


file_in_defendant_CW  := dataset(data_services.foreign_prod+'thor_200::in::crim::hd::arrest_defendant_cw', hygenics_crim.layout_in_defendant,
														CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)))
														(stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID' and nametype<>'B' and name not in ['UNKNOWN', 'RESTRICTED', 'EXPUNGED', 'EXPUNGED EXPUNGED', 'NONAME'] and regexfind('[0-9][0-9]+', name[1..2], 0)='') ;

proj_def_cw           := Project(file_in_defendant_CW,transform(hygenics_crim.layout_in_defendant,self.sourcename := trim(left.sourcename)+'_CW'; self := left;));

file_in_defendant_IE  := dataset(data_services.foreign_prod+'thor_200::in::crim::hd::arrest_defendant_ie', hygenics_crim.layout_in_defendant,
														CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)))
														(stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID' and nametype<>'B' and name not in ['UNKNOWN', 'RESTRICTED', 'EXPUNGED', 'EXPUNGED EXPUNGED', 'NONAME'] and regexfind('[0-9][0-9]+', name[1..2], 0)='') ;

proj_def_IE           := Project(file_in_defendant_IE,transform(hygenics_crim.layout_in_defendant,self.sourcename := trim(left.sourcename)+'_IE'; self := left;));

c := a+b+proj_def_cw+proj_def_IE;

//Added 60 Day Restriction to INDIANA Sourced Data///////////////////////////////////////////////////////////////////

	ds_filter 	:= c(statecode<>'IN'); 
	ds_IN				:= c(statecode='IN' and LIB_Date.DaysApart(recorduploaddate,(string)STD.date.today() )<=60);
											
filtered_recs	:= ds_filter + ds_IN;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////


	layout_in_defendant findAKA(filtered_recs l):= transform
		 self.name 		:= Map(
							           regexfind('[-/@* (]JUV[-/*@  )]|JUVENILE|[-/@* (]JUV$',l.name) => '',
												 regexfind('([A-Za-z ,/]+ )(1)$',l.name) => regexreplace('([A-Za-z ,/]+ )(1)$',l.name,'$1') ,
												 regexfind('^AKA[, ]+(.*)',l.lastname) => regexreplace('^AKA[, ]+(.*)',l.name,'$1') ,
												 regexfind('(.*) AKA[ ]*$',l.lastname) => regexreplace('(.*) AKA[, ]+(.*)',l.name,'$1 $2') ,
												 l.lastname ='AKA' and regexfind('^AKA[,]* (.*)',l.name) =>regexreplace('^AKA[,]* (.*)',l.name,'$1'), 
												 l.lastname ='AKA' and regexfind('(.*) AKA[ ]*$',l.name) => regexreplace('(.*) AKA[ ]*$',l.name,'$1'),
												 l.name);
    self.lastname    := Map(regexfind('^AKA (.*)',l.lastname) => regexreplace('^AKA (.*)',l.lastname,'$1'),
		                        regexfind('(.*) AKA[ ]*$',l.lastname) => regexreplace('(.*) AKA[ ]*$',l.lastname,'$1') ,
														l.lastname ='AKA' => '',
		                        l.lastname);
		                     
		self 			:= l;
	end;

	remove_AKA 	:= project(filtered_recs, findAKA(left));
export file_in_defendant_arrests := remove_AKA( regexfind('[0-9]',name + lastname+firstname+ middlename )= false):INDEPENDENT;





