export Get_SourceFileName_In(string src_type,string sourcefile) :=
	'~thor_data400::in::Ingenix_NatlProf' + '_' + trim(src_type) + '_' + trim(sourcefile); 