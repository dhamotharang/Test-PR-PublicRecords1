import doxie, Tools, BIPV2, dx_Infutor_NARB, RoxieKeyBuild;

export Build_Keys(string pversion) :=
module

	RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_Infutor_NARB.Key_LinkIds.Key
																						 ,Infutor_NARB.Files().Base.Built
																						 ,dx_Infutor_NARB.keynames().LinkIds.QA
																						 ,dx_Infutor_NARB.keynames(pversion,false).LinkIds.New
																				 		 ,BuildLinkIdsKey);  
	export full_build :=
	
	sequential(
			BuildLinkIdsKey
		 ,Promote(pversion).BuildFiles.New2Built
	);
		
	export All :=
	 if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Infutor_NARB.Build_Keys atribute')
	 );

end;