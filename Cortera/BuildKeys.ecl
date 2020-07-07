IMPORT dx_Cortera, Std, VersionControl, RoxieKeyBuild;

EXPORT BuildKeys(string pversion=(string8)Std.Date.Today()) := function

	//VersionControl.macBuildNewLogicalKeyWithName(Cortera.Key_LinkIds.Key,	Cortera.keynames(pversion,false).LinkIds.New, BuildLinkIdsKey,,,,false);
	//VersionControl.macBuildNewLogicalKeyWithName(Cortera.Key_Header_Link_Id,	Cortera.keynames(pversion,false).Hdr_Link_Id.New, BuildHdrKey,,,,false);
	//VersionControl.macBuildNewLogicalKeyWithName(Cortera.Key_Attributes_Link_Id,	Cortera.keynames(pversion,false).Attr_Link_Id.New, BuildAttrKey,,,,false);
	//VersionControl.macBuildNewLogicalKeyWithName(Cortera.key_executive_link_id,	Cortera.keynames(pversion,false).Executive_Link_Id.New, BuildExecutiveKey,,,,false);
	
	RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_Cortera.Key_LinkIds.Key
																						 ,Cortera.Files().Base.Header.Built
																						 ,dx_Cortera.Keynames().LinkIds.QA
																						 ,dx_Cortera.Keynames(pversion,false).LinkIds.New
																						 ,BuildLinkIdsKey); 
	
	RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_Cortera.Key_Header_Link_Id
																						 ,Cortera.Files().Base.Header.Built(Link_id<>0)
																						 ,dx_Cortera.Keynames().Hdr_Link_Id.QA
																						 ,dx_Cortera.Keynames(pversion,false).Hdr_Link_Id.New
																						 ,BuildHdr_Link_IdKey);
																						 
	RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_Cortera.Key_Attributes_Link_Id
																						 ,Cortera.Files().Base.Attributes.Built
																						 ,dx_Cortera.Keynames().Attr_Link_Id.QA
																						 ,dx_Cortera.Keynames(pversion,false).Attr_Link_Id.New
																						 ,BuildAttr_Link_IdKey);
																						 
	RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_Cortera.Key_Executive_Link_Id
																						 ,project(Cortera.Files().Base.Executives.Built(Link_id<>0),dx_Cortera.Layouts.Layout_ExecLinkID) 
																						 ,dx_Cortera.Keynames().Executive_Link_Id.QA
																						 ,dx_Cortera.Keynames(pversion,false).Executive_Link_Id.New
																						 ,BuildExec_Link_IdKey);
		
	
	return SEQUENTIAL(
			PARALLEL(
				BuildLinkIdsKey,
				BuildHdr_Link_IdKey,
				BuildAttr_Link_IdKey,
				BuildExec_Link_IdKey
			),
			Cortera.Promote(pversion).BuildFiles.New2Built
	);
end;