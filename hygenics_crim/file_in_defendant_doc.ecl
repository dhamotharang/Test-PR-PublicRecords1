import data_services, lib_date,ut;

defendant_file     :=  dataset(data_services.foreign_prod+ 'thor_200::in::crim::hd::doc_defendant',
														layout_in_defendant,
														CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(6000)))  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID');

defendant_crimwise :=  dataset(data_services.foreign_prod+'thor_200::in::crim::hd::doc_defendant_cw', hygenics_crim.layout_in_defendant,
														CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)))
														(stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID');

proj_def_cw        := Project(defendant_crimwise,transform(hygenics_crim.layout_in_defendant,self.sourcename := trim(left.sourcename)+'_CW'; self := left;));

defendant_IE       := dataset(data_services.foreign_prod+'thor_200::in::crim::hd::doc_defendant_ie', hygenics_crim.layout_in_defendant,
														CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)))
														(stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID' and nametype<>'B' and name not in ['UNKNOWN', 'RESTRICTED', 'EXPUNGED', 'EXPUNGED EXPUNGED', 'NONAME'] and regexfind('[0-9][0-9]+', name[1..2], 0)='') ;

proj_def_IE        := Project(defendant_IE,transform(hygenics_crim.layout_in_defendant,self.sourcename := trim(left.sourcename)+'_IE'; self := left;));


file_in_defendant_all := defendant_file(name<>'AKA')+ proj_def_cw+proj_def_IE;
// return arrests only and exclude bad sources from HD.
//Added 60 Day Restriction to INDIANA Sourced Data///////////////////////////////////////////////////////////////////

	ds_filter 	:= file_in_defendant_all(statecode<>'IN'); 
	ds_IN				:= file_in_defendant_all(statecode='IN' and LIB_Date.DaysApart(recorduploaddate,_functions.GetDate )<=60);
											
filtered_rec	:= ds_filter + ds_IN : INDEPENDENT;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	
export file_in_defendant_doc 
	:= filtered_rec(~(StateCode in ['MI'] and (docnumber = '601387' or stateidnumber ='2602558W') and lastname = 'ANDERSON' and firstname ='VALERIE')) /*(StateCode in _include_states)and defendantstatus='DEFENDANT')(sourcetype in _control.keep_sourcetypes and sourcename not in _control.discard_sourcenames)*/;
//added filter to remove the expunged record.