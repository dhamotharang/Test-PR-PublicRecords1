// USER INSTRUCTION - This is user attribute - SNARRA
// 1) DLV2 Base file 
// 2) DLV2 Key build.

import  DriversV2, header, ut, STRATA, lib_fileservices, doxie_build, Roxiekeybuild, orbit_report;

export parameter_date(string filedate) := function
	
//***** DLv2 Build - DL build base file
step1 := DriversV2.Proc_Build_DL_Base;


//***** DLv2 Key build 
step2 := DriversV2.Proc_Build_dl_search(filedate);


e_mail_success := fileServices.sendemail('snarra@seisint.com','Build is successful','see wid for more details');
  
e_mail_fail := fileservices.sendemail('snarra@seisint.com','DLv2 base file or DL2 Roxie Build FAILED',
									  failmessage);
				
email_notify := sequential(step1, step2) : 
                success(e_mail_success), 
                FAILURE(e_mail_fail);

return email_notify;

end;
