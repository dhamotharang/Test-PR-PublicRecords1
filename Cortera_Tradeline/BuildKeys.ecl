IMPORT dx_Cortera_Tradeline, RoxieKeyBuild, Std, VersionControl;

EXPORT BuildKeys(string pversion=(string8)Std.Date.Today(), boolean pDeltaBuild = false) := function
	
	dBase_Linkid := Cortera_Tradeline.Files().Base.Tradeline.Built(status<>'D');
		
	RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_Cortera_Tradeline.Key_LinkIds.Key
																						 ,dBase_Linkid(ultid <> 0)
																						 ,dx_Cortera_Tradeline.Keynames().LinkIds.QA
																						 ,dx_Cortera_Tradeline.Keynames(pversion,false).LinkIds.New
																						 ,BuildLinkIdsKey); 
																					 
	return SEQUENTIAL(
			PARALLEL(
				BuildLinkIdsKey
			),
			$.Promote(pversion,'key',pIsDeltaBuild:=pDeltaBuild).BuildFiles.New2Built
	);
end;