export Send_Spray_Completion_Email(string sourcefile, string thor_filename, string superfilename, string srctype,  string filedate) := 
function
	return fileservices.sendemail('skasavajjala@seisint.com; kevin.reeder@lexisnexis.com',
				'Ingenix_NatlProf' + ': ' + trim(srctype) + ' ' + trim(sourcefile) + ' ' + filedate + ' segment spray completed',
				'Unix source file: ' + sourcefile + '\r\nThor destination file: ' + thor_filename + 
				'\r\nSpray successful and added to superfile: ' + superfilename + '\r\nworkunit: ' + workunit);

end;