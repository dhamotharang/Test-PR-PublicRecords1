export Send_Email(string filedate):= module
							
	export build_success := fileservices.sendemail(
													'Jose.Bello@lexisnexis.com'
													,'FL_DOR Build Succeeded ' + filedate
													,'Sample records are in WUID:' + workunit);
	export build_failure := fileservices.sendemail(
													'Jose.Bello@lexisnexis.com'
													,'FL_DOR '+filedate+' Build FAILED'
													,workunit+ ' ' + FAILMESSAGE);

	export build_extracts_success := fileservices.sendemail(
													'Jose.Bello@lexisnexis.com'
													,'FL_DOR Extracts Succeeded ' + filedate
													,'Sample records are in WUID: ' + workunit);
	export build_extracts_failure := fileservices.sendemail(
													'Jose.Bello@lexisnexis.com'
													,'FL_DOR '+filedate+' Extracts FAILED'
													,workunit+ ' ' + FAILMESSAGE);
end;