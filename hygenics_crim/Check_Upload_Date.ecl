import hygenics_soff, lib_date, ut, lib_fileservices,hygenics_crim;

EXPORT Check_Upload_Date (string filedate):= function

	file_aoc 					:=  dataset('~thor_200::in::crim::hd::aoc_defendant', hygenics_crim.layout_in_defendant, CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)));
	//file_arr 				:=  dataset('~thor_200::in::crim::hd::arrest_defendant', hygenics_crim.layout_in_defendant, CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(6000)));
	//file_cty 				:=  dataset('~thor_200::in::crim::hd::county_defendant', hygenics_crim.layout_in_defendant, CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4000)));
	file_doc 					:=  dataset('~thor_200::in::crim::hd::doc_defendant', hygenics_crim.layout_in_defendant, CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(6000)));

	aoc_recs					:= file_aoc(statecode='IN');
	//arr_recs				:= file_arr(statecode='IN');
	//cty_recs				:= file_cty(statecode='IN');
	doc_recs					:= file_doc(statecode='IN');

	check_aoc_IN			:= file_aoc(statecode='IN' and LIB_Date.DaysApart(RecordUploadDate,hygenics_crim._functions.GetDate )<=60);	
	check_doc_IN			:= file_doc(statecode='IN' and LIB_Date.DaysApart(RecordUploadDate,hygenics_crim._functions.GetDate )<=60);				

email_notice 		:= if(count(check_aoc_IN) = 0 and count(aoc_recs) != 0 and count(check_doc_IN) = 0 and count(doc_recs) != 0
												,fileservices.SendEmail('Jennifer.Butts@lexisnexis.com;Joseph.Lezcano@lexisnexis.com;Vesa.Niemela@lexisnexis.com;Charles.Pettola@lexisnexis.com;Dane.Clarke@lexisnexisrisk.com;Julia.Nemtsan@LexisNexisRisk.com;Valerie.Minnis@lexisnexis.com;Jennifer.Stewart@lexisnexis.com;Alan.Betancourt@lexisnexisrisk.com;Judy.Tao@lexisnexis.com', 'Criminal Build v.' + filedate + ': Indiana AOC and DOC Records Excluded', 'Indiana AOC and DOC records were excluded from the build, because they were older than 60 days.')
										,if(count(check_aoc_IN) = 0 and count(aoc_recs) != 0 and count(check_doc_IN) > 0 and count(doc_recs) != 0
												,fileservices.SendEmail('Jennifer.Butts@lexisnexis.com;Joseph.Lezcano@lexisnexis.com;Vesa.Niemela@lexisnexis.com;Charles.Pettola@lexisnexis.com;Dane.Clarke@lexisnexisrisk.com;Julia.Nemtsan@LexisNexisRisk.com;Valerie.Minnis@lexisnexis.com;Jennifer.Stewart@lexisnexis.com;Alan.Betancourt@lexisnexisrisk.com;Judy.Tao@lexisnexis.com', 'Criminal Build v.' + filedate + ': Indiana AOC Records Excluded', 'Indiana AOC records were excluded from the build, because they were older than 60 days.  Indiana DOC records were not and were included in the build.')
										,if(count(check_aoc_IN) > 0 and count(aoc_recs) != 0 and count(check_doc_IN) = 0 and count(doc_recs) != 0
												,fileservices.SendEmail('Jennifer.Butts@lexisnexis.com;Joseph.Lezcano@lexisnexis.com;Vesa.Niemela@lexisnexis.com;Charles.Pettola@lexisnexis.com;Dane.Clarke@lexisnexisrisk.com;Julia.Nemtsan@LexisNexisRisk.com;Valerie.Minnis@lexisnexis.com;Jennifer.Stewart@lexisnexis.com;Alan.Betancourt@lexisnexisrisk.com;Judy.Tao@lexisnexis.com', 'Criminal Build v.' + filedate + ': Indiana DOC Records Excluded', 'Indiana DOC records were excluded from the build, because they were older than 60 days.  Indiana AOC records were not and were included in the build.')
										,if(count(check_aoc_IN) > 0 and count(aoc_recs) != 0 and count(check_doc_IN) > 0 and count(doc_recs) != 0
												,fileservices.SendEmail('jtao@seisint.com', 'Criminal Build v.' + filedate + ': Indiana AOC and DOC Records Included', '')
												,fileservices.SendEmail('Charles.Pettola@lexisnexis.com;jtao@seisint.com', 'Criminal Build v.' + filedate + ': Indiana Records Not Provided', 'Indiana records were not provided.  Please contact the vendor.')))));

return email_notice;

end;