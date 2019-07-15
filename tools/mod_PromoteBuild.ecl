export mod_PromoteBuild(
	 string																		pversion	
	,dataset(Layout_FilenameVersions.builds)	pFilenames
	,string																		pFilter						  = ''
	,boolean																	pDelete						  = false
	,boolean																	pIsTesting				  = false
	,unsigned1																pnGenerations			  = 3
	,boolean																	pClearSuperFirst	  = true
  ,string                                   pOddFilename        = ''
	,boolean                                  pMove2DeleteSuper   = false //used for when moving a logical file into the built superfile(mod_Promote.fNew2Built). will place previous logical file into delete superfile.
  ,boolean                                  pIncludeBuiltDelete = false
	,string																		pCleanupFilter			= ''
  ,boolean		                              pIsDeltaBuild	      = false
  ,boolean		                              pForceGenPromotion	= false
) :=
module

	//have canned promotion/rollback attributes
	//also have another flexible one to tailor to a specific application
	shared filter				:= if(pFilter = ''	,true
																					,		regexfind(pFilter,pfilenames.templatename		,nocase)
																					or	if(pfilenames.templatenamenew != '' ,regexfind(pFilter,pfilenames.templatenamenew,nocase) ,false)
												);
	shared lnames					:= pFilenames(filter);

	export new2root 						:= if(pIsTesting = false ,nothor(apply(lnames	,mod_Promote.fNew2Root					(templatename,templatenameNew,pversion,pDelete,,false				))),output(lnames(filter),all));
	export new2built						:= if(pIsTesting = false ,nothor(apply(lnames	,mod_Promote.fNew2Built					(templatename,templatenameNew,pversion,pDelete,,pMove2DeleteSuper							))),output(lnames(filter),all));
	export odd2built						:= if(pIsTesting = false ,nothor(apply(lnames	,mod_Promote.fOdd2Built					(templatename,templatenameNew,pOddFilename,pversion,pDelete,,pMove2DeleteSuper							))),output(lnames(filter),all));
	export new2qa								:= if(pIsTesting = false ,nothor(apply(lnames	,mod_Promote.fNew2QA						(templatename,templatenameNew,pversion,pDelete,,IsNewNamingConvention							))),output(lnames(filter),all));
	export new2base						  := if(pIsTesting = false ,nothor(apply(lnames	,mod_Promote.fNew2Base					(templatename,templatenameNew,pversion,pDelete,,IsNewNamingConvention,pClearSuperFirst))),output(lnames(filter),all));
	export new2qaMult						:= if(pIsTesting = false ,nothor(apply(lnames	,mod_Promote.fNew2QAMult				(templatename,templatenameNew,pversion,pDelete,,IsNewNamingConvention							))),output(lnames(filter),all));
	export built2qa 						:= if(pIsTesting = false ,nothor(apply(lnames	,mod_Promote.fBuilt2QA					(templatename,pnGenerations,pDelete,,IsNewNamingConvention,pIsDeltaBuild,pForceGenPromotion	))),output(lnames(filter),all));
	export qa2prod 							:= if(pIsTesting = false ,nothor(apply(lnames	,mod_Promote.fQA2Prod						(templatename,pDelete																				))),output(lnames(filter),all));
	export QA2BusinessHeader		:= if(pIsTesting = false ,nothor(apply(lnames	,mod_Promote.fQA2BusinessHeader	(templatename,IsNewNamingConvention													))),output(lnames(filter),all));
	export LockSuper(string		pToVersion
									,string		pFromVersion
													)		:= if(pIsTesting = false ,nothor(apply(lnames	,mod_Promote.fSuper2SuperLock		(templatename	,pToVersion	,pFromVersion											))),output(lnames(filter),all));
  export Cleanup              := if(pIsTesting = false ,nothor(apply(lnames	,mod_Promote._fVersionIntegrityCheck	(templatename,pDelete	,pIncludeBuiltDelete,pCleanupFilter,pForceGenPromotion))),output(lnames(filter),all));
end;