e_mail_success := FileServices.sendemail('faisal.humayun@lexis-nexis.com','DL ' + drivers.Version_Development + ' DKC Succeeded','at ' + thorlib.WUID()); 
e_mail_failure := FileServices.sendemail('faisal.humayun@lexis-nexis.com','DL ' + drivers.Version_Development + ' DKC Failed!',failmessage+'at ' + thorlib.WUID()); 

//* Usage: proc_dl_dkc('edata12', '/dl_data_16') 
Drivers.proc_dl_dkc_function('edata12','/dl_data_74') : success(e_mail_success), failure(e_mail_failure);