import lib_fileservices;
export fun_FilterSuperkeys(
	 dataset(lib_fileservices.FsLogicalFileNameRecord)	pInput								//dataset of superfilenames/superkeynames(all versions)
	,string 																						pVersionSelect = 'qa'	//version to select(building, built, qa, prod, father, grandfather, delete)
) :=
function 
	regex := 	'^(.*)::' + pVersionSelect + '::(.*)$' + '|'
					+	'^(.*)_' 	+ pVersionSelect + '$'       + '|'
          + '^(.*)::' + pVersionSelect + '$'
					;
					
	return pInput(regexfind(regex, name,nocase));
end;
