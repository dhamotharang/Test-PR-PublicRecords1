export Email_Notification_Lists(string filedate) := 
module

	export SprayCompletion	:= 
	fileservices.sendemail('Charles.Pettola@lexisnexis.com; Wenhong.Ma@lexisnexis.com; Abednego.Escobal@lexisnexisrisk.com',
			'IDM Daily Spray Completed ' + filedate,'Sample records are in WUID:' + workunit);
	export BuildSuccess			:= 
	fileservices.sendemail('Charles.Pettola@lexisnexis.com; Wenhong.Ma@lexisnexis.com; Abednego.Escobal@lexisnexisrisk.com',
			'Avenger Full Build Process Completed ' + filedate,
			'Sample records are in WUID:' + workunit);
	export BuildFailure			:= fileservices.sendemail('Charles.Pettola@lexisnexis.com; Wenhong.Ma@lexisnexis.com; Abednego.Escobal@lexisnexisrisk.com',
			'Avenger Full Build Process Completed ' + filedate,failmessage);
	export Buildstats		:= 'Wenhong.Ma@lexisnexis.com';

end;

