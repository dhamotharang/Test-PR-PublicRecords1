import lib_fileservices;

export fFilterSuperKeys(

	 dataset(lib_fileservices.FsLogicalFileNameRecord)	pInput								//dataset of superfilenames/superkeynames(all versions)
	,string 																						pVersionSelect = 'qa'	//version to select(building, built, qa, prod, father, grandfather, delete)

) :=
function 
	
	return pInput(regexfind('^(.*)::' + pVersionSelect + '::(.*)$', name,nocase));

end;