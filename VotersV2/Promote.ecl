import tools;

lay_inputs	:= tools.Layout_FilenameVersions.Inputs;

export Promote(
	 string								pversion					= 	''
	,string								pFilter						= 	''
	,boolean							pDelete						= 	false
	,boolean							pIsTesting				= 	false
	,dataset(lay_inputs)	pInputFilenames 	= 	Filenames	(pversion).Input.dAll_filenames																		
																							
) :=
module
	
	export inputfiles					:= tools.mod_PromoteInput(pversion,pInputFilenames,pFilter,pDelete,pIsTesting);
	
end;