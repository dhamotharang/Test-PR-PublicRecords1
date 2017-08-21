export Send_Email(string filedate):= module
							
	export build_success := fileservices.sendemail(
													'Michael.Gould@lexisnexis.com,Jose.Bello@lexisnexis.com'
													,'FCRA_ExperianCred Build Succeeded ' + filedate
													,'Sample records are in WUID:' + workunit);
	export build_failure := fileservices.sendemail(
													'Michael.Gould@lexisnexis.com,Jose.Bello@lexisnexis.com'
													,'FCRA_ExperianCred '+filedate+' Build FAILED'
													,workunit+ ' ' + FAILMESSAGE);

	export build_extracts_success := fileservices.sendemail(
													'Brian.Hirsch@lexisnexis.com,Krista.Hanson@lexisnexis.com,Mike.Woodberry@lexisnexis.com,Michael.Gould@lexisnexis.com,Jose.Bello@lexisnexis.com'
													,'FCRA_ExperianCred Extracts Succeeded ' + filedate
													,'Sample records are in WUID: ' + workunit);
	export build_extracts_failure := fileservices.sendemail(
													'Michael.Gould@lexisnexis.com,Jose.Bello@lexisnexis.com'
													,'FCRA_ExperianCred '+filedate+' Extracts FAILED'
													,workunit+ ' ' + FAILMESSAGE);
end;