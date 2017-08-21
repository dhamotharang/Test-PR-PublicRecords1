export mod_RollbackInput(
	 dataset(Layout_FilenameVersions.inputs)	pFilenames
	,string																		pFilter						= ''
	,boolean																	pDelete						= false
	,boolean																	pIsTesting				= false
) :=
module

	shared filter							:= if(pFilter = ''	,true,regexfind(pFilter,pfilenames.templatename,nocase));
	shared lnames							:= global(pFilenames(filter),few);

	shared delInputs(string pversion = '')	:= if(pDelete, Cleanup_Input_Files(
																								 pversion			:= pversion
																								,pFilenames		:= lnames				
																								,pIsTesting		:= pIsTesting		
																							));
	

	export build2Sprayed	:= sequential(if(pIsTesting = false ,if(pDelete ,delInputs(				),nothor(apply(lnames, mod_Rollback.build2Sprayed	(templatename	)))),output(lNames,all)));
	export Using2Sprayed	:= sequential(if(pIsTesting = false ,if(pDelete ,delInputs('Using'),nothor(apply(lnames, mod_Rollback.Using2Sprayed	(templatename	)))),output(lNames,all)));
	export Used2Sprayed		:= sequential(if(pIsTesting = false ,if(pDelete ,delInputs('Used'	),nothor(apply(lnames, mod_Rollback.Used2Sprayed	(templatename	)))),output(lNames,all)));

	export Sprayed2Root		:= if(pIsTesting = false ,nothor(apply(lnames, mod_Rollback.Sprayed2Root	(templatename					))),output(lNames,all));
	export Delete2Used		:= if(pIsTesting = false ,nothor(apply(lnames, mod_Rollback.Delete2Used		(templatename					))),output(lNames,all));

end;