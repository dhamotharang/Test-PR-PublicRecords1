export mod_PromoteInput(
	 string																		pversion	
	,dataset(Layout_FilenameVersions.inputs)	pFilenames
	,string																		pFilter						= ''
	,boolean																	pDelete						= false
	,boolean																	pIsTesting				= false
	,boolean 																	pClearSprayed			= false
) :=
module
	shared filter				:= if(pFilter = ''	,true
																					,		regexfind(pFilter,pfilenames.templatename		,nocase)
												);
												
	shared lnames					:= global(pFilenames(filter),few);
	
	export Root2Sprayed		:= if(pIsTesting = false ,nothor(apply(lNames, mod_Promote.Root2Sprayed	(templatename,pClearSprayed					))),output(lNames,all));
	export Sprayed2Using	:= if(pIsTesting = false ,nothor(apply(lNames, mod_Promote.Sprayed2Using(templatename												))),output(lNames,all));
	export Using2Used			:= if(pIsTesting = false ,nothor(apply(lNames, mod_Promote.Using2Used		(templatename,pDelete								))),output(lNames,all));
	export New2Sprayed		:= if(pIsTesting = false ,nothor(apply(lNames, mod_Promote.New2Sprayed	(templatename,pversion,pClearSprayed))),output(lNames,all));
end;
