export mod_PromoteBuild(
	 string																		pversion	
	,dataset(Layout_FilenameVersions.builds)	pFilenames
	,string																		pFilter						= ''
	,boolean																	pDelete						= false
	,boolean																	pIsTesting				= false
	,unsigned1																pnGenerations			= 3
	,boolean																	pClearSuperFirst	= true
) :=
module
	//have canned promotion/rollback attributes
	//also have another flexible one to tailor to a specific application
	shared filter				:= if(pFilter = ''	,true
																					,		regexfind(pFilter,pfilenames.templatename		,nocase)
																					or	regexfind(pFilter,pfilenames.templatenamenew,nocase)
												);
	shared lnames					:= global(pFilenames(filter),few);
	export new2built						:= if(pIsTesting = false ,nothor(apply(lnames	,mod_Promote.fNew2Built					(templatename,pversion,pDelete					))),output(lnames(filter),all));
	export built2qa 						:= if(pIsTesting = false ,nothor(apply(lnames	,mod_Promote.fBuilt2QA					(templatename,pnGenerations,pDelete			))),output(lnames(filter),all));
	export qa2prod 							:= if(pIsTesting = false ,nothor(apply(lnames	,mod_Promote.fQA2Prod						(templatename,pDelete										))),output(lnames(filter),all));
	export QA2BusinessHeader		:= if(pIsTesting = false ,nothor(apply(lnames	,mod_Promote.fQA2BusinessHeader	(templatename														))),output(lnames(filter),all));
	export LockSuper(string		pToVersion
									,string		pFromVersion
													)		:= if(pIsTesting = false ,nothor(apply(lnames	,mod_Promote.fSuper2SuperLock		(templatename	,pToVersion	,pFromVersion	))),output(lnames(filter),all));
end;
