import _control, tools, versioncontrol;

EXPORT Filenames(string  pName    		= '',
								 string  pVersion 		= '',
								 string  pDataset_name = '',
								 boolean pUseProd 		= false
) :=
module
		export lInputTemplate				 	 := IF(pName = '',prte2._Dataset().thor_cluster_files + 'in::' + pDataset_name+ '::@version@',  
																					prte2._Dataset().thor_cluster_files + 'in::' + pDataset_name + '::@version@' + '::' + pName
																					);
		export Input   								 := tools.mod_FilenamesInput(lInputTemplate,	pversion);
																						

	                                                   
end;