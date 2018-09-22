import _control, doxie, tools, BIPV2, VersionControl, PRTE, Roxiekeybuild, wk_ut;

export Build_Keys (string 		pversion
									 ,boolean 	pIsTesting 				= false
									 ,boolean		pShouldUpdateDOPS	= true
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
		
	export update_dops_WAFKeys :=	iff(pShouldUpdateDOPS, 
																		PRTE.UpdateVersion(
																			'BIPV2WAFKeys'											//	Package name
																			,pversion														//	Package version
																			,_control.MyInfo.EmailAddressNormal	//	Who to email with specifics
																			,'B'																//  inloc - 'B' - Boca, 'A' - Alpharetta
																			,'N'																//	N = Non-FCRA, F = FCRA
																			,'N'                                //	N = Do not also include boolean, Y = Include boolean, too
																		)
																 );
	
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,sequential(
				 full_build
				,update_dops_WAFKeys
		 )
		,output('No Valid version parameter passed, skipping PRTE2_BIPV2_WAF.Build_Keys atribute')
	);

end;

