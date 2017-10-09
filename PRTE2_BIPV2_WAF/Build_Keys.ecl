import doxie, tools, BIPV2, VersionControl, Roxiekeybuild, wk_ut;

export Build_Keys (string 		pversion
									 ,boolean 	pIsTesting = false
									) :=
module

	VersionControl.macBuildNewLogicalKeyWithName(PRTE2_BIPV2_WAF.Key_BIPV2_WAF.key,	'~prte::key::BIPV2_WAF::'+pversion+'::proxid::efr', BuildWAFKey);
	
													  
	export full_build :=
	
	sequential(
						  PARALLEL(Mod_Corps().BuildAll,Mod_UCC().BuildAll,Mod_Vehicle().BuildAll,Mod_PropertyV2().BuildAll,Mod_BizContacts().BuildAll)
						 ,BuildWAFKey
						 //,Promote(pversion).BuildKeyFiles.New2Built
						 //,Promote(pversion).BuildKeyFiles.Built2QA
						): success(output('PRTE2_BIPV2_WAF Build completed successfully')), failure(output('PRTE2_BIPV2_WAF Build failed'));
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping PRTE2_BIPV2_WAF.Build_Keys atribute')
	);

end;

