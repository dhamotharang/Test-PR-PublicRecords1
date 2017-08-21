IMPORT ut;

EXPORT proc_build_all(STRING versionDate) := function

  #workunit('name','PhoneMart Monthly Build - ' + versionDate);

	email := FileServices.sendemail('cathy.tio@lexisnexis.com,harry.gist@lexisnexis.com','PhoneMart build ' + versionDate + ' completed', 'PhoneMart monthly build ' + versionDate + ' completed at ' + thorlib.WUID());
	
	buildBase	:=	proc_build_base;
	
	clear_input := SEQUENTIAL(fileservices.startsuperfiletransaction(),
														fileservices.clearsuperfile('~thor_data400::in::phonemart::cms'),
														fileservices.clearsuperfile('~thor_data400::in::phonemart::csd'),
														fileservices.clearsuperfile('~thor_data400::in::phonemart::indv'),
														fileservices.finishsuperfiletransaction()
														);
	RETURN SEQUENTIAL(
		PhoneMart.spray_files(versionDate),
		PhoneMart.proc_build_base(versionDate),
		proc_build_keys(versionDate),
		PARALLEL(
			PhoneMart.sample_phonemart_base,
			PhoneMart.strata_phonemart(versionDate),
			clear_input
		),
		email
	);
END;
