import hygenics_soff, lib_date, ut, lib_fileservices,Std;

EXPORT Check_Upload_Date (string filedate):= function

  ds_check_inputs := hygenics_soff.File_In_SO_Defendant(StateCode='IN');	
	ds_check_IN			:= hygenics_soff.File_In_SO_Defendant(StateCode='IN' and LIB_Date.DaysApart(RecordUploadDate,(STRING8)Std.Date.Today() )<=60);					

	email_notice 		:= if(count(ds_check_IN) = 0 and count(ds_check_inputs) != 0
												,fileservices.SendEmail('Charles.Pettola@lexisnexis.com;Jennifer.Butts@lexisnexis.com;Darren.Knowles@lexisnexis.com;Joseph.Lezcano@lexisnexis.com;Vesa.Niemela@lexisnexis.com;Neha.Merchant@lexisnexis.com;Valerie.Minnis@lexisnexis.com;Jennifer.Stewart@lexisnexis.com;Judy.Tao@lexisnexis.com', 'Sex Offender Build v.' + filedate + ': Indiana Records Excluded', 'Indiana records were excluded from the build, because they were older than 60 days.')
											,if(count(ds_check_IN) > 0 and count(ds_check_inputs) != 0
												,fileservices.SendEmail('Charles.Pettola@lexisnexis.com;Jennifer.Butts@lexisnexis.com;Darren.Knowles@lexisnexis.com;Joseph.Lezcano@lexisnexis.com;Vesa.Niemela@lexisnexis.com;Neha.Merchant@lexisnexis.com;Valerie.Minnis@lexisnexis.com;Jennifer.Stewart@lexisnexis.com;Judy.Tao@lexisnexis.com', 'Sex Offender Build v.' + filedate + ': Indiana Records Included', '')
												,fileservices.SendEmail('Charles.Pettola@lexisnexis.com;darren.knowles@lexisnexis.com;jtao@seisint.com', 'Sex Offender Build v.' + filedate + ': Indiana Records Not Provided', 'Indiana records were not provided.  Please contact the vendor.')));

return email_notice;

end;