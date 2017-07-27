export proc_preprocess(string filetype,string filedate) := function

infile := dataset('~thor_data400::temp::ecrash::'+filetype
													,FLAccidents_Ecrash.Layout_Infiles.payload
													,csv(heading(1),maxlength(20000),terminator(x'E2809D0A'), separator('')));													

a := project(infile,transform(FLAccidents_Ecrash.Layout_Infiles.payload,
self.line :=regexreplace('NULL',regexreplace(x'E2809D',left.line,''),'')))(regexfind('[0-9]',line));


// b := dataset('~thor_data400::in::ecrash::'+filedate+'::'+filetype
													// ,FLAccidents_Ecrash.Layout_Infiles.+filetype
													// ,csv(maxlength(10000),terminator('\r\n'), separator(',')));	


return
sequential(
	output(a,,'~thor_data400::in::ecrash::'+filedate+'::'+filetype,csv(terminator('\r\n'), separator(',')),overwrite),
	 fileservices.addSuperFile('~thor_data400::in::ecrash::'+filetype,'~thor_data400::in::ecrash::'+filedate+'::'+filetype));
	 
	 end;


