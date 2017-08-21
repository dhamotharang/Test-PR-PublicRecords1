import VersionControl,tools;
export Send_Email(
	
	 string		pversion
	,string   keyword

) :=
module
	shared lemails	:= 'Sudhir.Kasavajjala@lexisnexis.com; Darren.Knowles@lexisnexis.com';


	export BuildSuccess	:= tools.fun_SendEmail(
													 lemails
													,'Vickers Insider '+keyword+' Job Succeeded ' + pversion
													,workunit
												);

	export BuildFailure	:= tools.fun_SendEmail(
													lemails,
													'Vickers Insider '+keyword+'  Job  Failed' + pversion,
													workunit + '\n' + failmessage);
		
	

	
	
end;
