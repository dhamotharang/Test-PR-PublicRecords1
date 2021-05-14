IMPORT dx_Cortera_Tradeline, RoxieKeyBuild, Std, VersionControl;

EXPORT BuildKeys(string pversion=(string8)Std.Date.Today(), boolean pDeltaBuild = false) := function
	
	dBase_Linkid := Cortera_Tradeline.Files().Base.Tradeline.Built(status<>'D');
	dDelta_rid   := if(pDeltaBuild, 
											project(dBase_Linkid(dt_effective_last <> 0), transform(dx_cortera_tradeline.layouts.layout_delta_rid, self := left)),
											dataset([], dx_cortera_tradeline.layouts.Layout_Delta_Rid)						
										 );
		
	RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_Cortera_Tradeline.Key_LinkIds.Key
																						 ,dBase_Linkid(ultid <> 0)
																						 ,dx_Cortera_Tradeline.Keynames().LinkIds.QA
																						 ,dx_Cortera_Tradeline.Keynames(pversion,false).LinkIds.New
																						 ,BuildLinkIdsKey); 
																					 
	RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_Cortera_Tradeline.Key_Delta_Rid
																						 ,dDelta_rid
																						 ,dx_Cortera_Tradeline.Keynames().Delta_Rid.QA
																						 ,dx_Cortera_Tradeline.Keynames(pversion,false).Delta_Rid.New
																						 ,BuildTDelta_RidKey);
	return SEQUENTIAL(
			PARALLEL(
				BuildLinkIdsKey,
				BuildTDelta_RidKey
			),
			$.Promote(pversion,'key',pIsDeltaBuild:=pDeltaBuild).BuildFiles.New2Built
	);
end;