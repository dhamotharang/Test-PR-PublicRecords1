export mod_RollbackBuild(
	 string																		pversion	
	,dataset(Layout_FilenameVersions.builds)	pFilenames
	,string																		pFilter						= ''
	,boolean																	pDelete						= false
	,boolean																	pIsTesting				= false
	,boolean																	pNotFilter				= false		//Negate the filter?
) :=
module

	//have canned promotion/rollback attributes
	//also have another flexible one to tailor to a specific application
	shared filter				:= if(pFilter = ''	,true
																					,		regexfind(pFilter,pfilenames.templatename		,nocase)
																					or	regexfind(pFilter,pfilenames.templatenamenew,nocase)
												);

	shared fullfilter := if(pNotFilter	,not(filter),filter);
												
	shared lnames					:= pFilenames(fullfilter);

	shared ldeletebuiltfile := if(pDelete, Cleanup_Build_Files(
																					 pversion			:= pversion			
																					,pFilenames		:= lnames				
																					,pIsTesting		:= pIsTesting		
																				)
															);

	export Father2QA			:= sequential(if(pIsTesting = false ,nothor(apply(lnames, mod_Rollback.Father2QA		(templatename,pDelete,,IsNewNamingConvention))),output(lnames,all)),ldeletebuiltfile);
	export Father2Prod		:= sequential(if(pIsTesting = false ,nothor(apply(lnames, mod_Rollback.Father2Prod	(templatename,pDelete												))),output(lnames,all)),ldeletebuiltfile);
	export QA2Built				:= sequential(if(pIsTesting = false ,nothor(apply(lnames, mod_Rollback.QA2Built			(templatename,pDelete												))),output(lnames,all)),ldeletebuiltfile);

	export Prod2QA				:= if(pIsTesting = false ,nothor(apply(lnames, mod_Rollback.Prod2QA					(templatename,pDelete												))),output(lnames,all));
	export Father2Root		:= if(pIsTesting = false ,nothor(apply(lnames, mod_Rollback.Father2Root			(templatename,pDelete												))),output(lnames,all));
	export Built2Building	:= if(pIsTesting = false ,nothor(apply(lnames, mod_Rollback.Built2Building	(templatename,pDelete												))),output(lnames,all));
	export BusinessHeader	:= if(pIsTesting = false ,nothor(apply(lnames, mod_Rollback.fBusinessHeader	(templatename																))),output(lnames,all));
	export ClearSuper			:= if(pIsTesting = false ,nothor(apply(lnames, mod_Rollback.fClearSuper			(templatename,pversion											))),output(lnames,all));
	export ClearBuilt			:= sequential(if(pIsTesting = false ,nothor(apply(lnames, mod_Rollback.fClearSuper			(templatename,'built'											  ))),output(lnames,all)),ldeletebuiltfile);
	
end;