import ut,tools;

export fLogicalKeyRenaming(

	 dataset(ut.Layout_Superkeynames.InputLayout)	pAll_superkeynames
	,boolean 										                  pIsTesting 			    = true
	,string											                  pVersion			      = ''

) := tools.fun_RenameFiles(pAll_superkeynames ,pIsTesting ,pVersion) : DEPRECATED('Use tools.fun_RenameFiles instead');


