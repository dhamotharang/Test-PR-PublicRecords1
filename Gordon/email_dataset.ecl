/*
/*
lib_fileservices.fileservices.sprayVariable(
	'10.150.64.208', 
	'c:\\gjs_spray\\email.csv', 
	8192, 
	'\\,', 
	'\\n,\\r\\n', 
	'"', 
	'thor_mtkg',
	'gjs::emailvar');

r := record
	   varstring from;
	   varstring to;
	end;

email_dataset := dataset('gjs::emailvar', r, csv);//(separator(','), terminator(['\r', '\r\n', '\n\r']), quote('"')));
*/
r := record
	   varstring from;
	   varstring to;
	end;

export email_dataset := dataset('gjs::emailvardedup', r, thor);