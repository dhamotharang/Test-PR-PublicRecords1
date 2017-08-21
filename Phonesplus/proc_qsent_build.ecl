#workunit('name','Phonesplus v2 '+ Phonesplus.version+' ? Qsent base + keys')

import Cellphone,Phonesplus, lib_FileServices;

e_mail_success := FileServices.sendemail('qualityassurance@seisint.com;joseph.lezcano@lexisnexis.com','QSENT '+ Phonesplus.version+' weekly sample available','at ' + thorlib.WUID());
e_mail_failure := FileServices.sendemail('joseph.lezcano@lexisnexis.com','Phonesplus Build Failure',failmessage+'at ' + thorlib.WUID());

export proc_qsent_build := sequential(
			Phonesplus.Qsent_DID,
	parallel(
			  Phonesplus.proc_build_qsent_keys(Phonesplus.version),
				Phonesplus.sample_QsentBase,
			  Phonesplus.strata_popFileQsentBase
			  )
			): 
				success(e_mail_success), 
				FAILURE(e_mail_failure);