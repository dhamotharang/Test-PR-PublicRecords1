IMPORT dx_Cortera, Std, VersionControl, RoxieKeyBuild;

EXPORT BuildKeys(string pversion=(string8)Std.Date.Today()) := function

	//VersionControl.macBuildNewLogicalKeyWithName(Cortera.Key_LinkIds.Key,	Cortera.keynames(pversion,false).LinkIds.New, BuildLinkIdsKey,,,,false);
	//VersionControl.macBuildNewLogicalKeyWithName(Cortera.Key_Header_Link_Id,	Cortera.keynames(pversion,false).Hdr_Link_Id.New, BuildHdrKey,,,,false);
	//VersionControl.macBuildNewLogicalKeyWithName(Cortera.Key_Attributes_Link_Id,	Cortera.keynames(pversion,false).Attr_Link_Id.New, BuildAttrKey,,,,false);
	//VersionControl.macBuildNewLogicalKeyWithName(Cortera.key_executive_link_id,	Cortera.keynames(pversion,false).Executive_Link_Id.New, BuildExecutiveKey,,,,false);
	
	hdr_base 							:= Cortera.Files().Base.Header.Built;
	file_key_hdr_Link_Id	:= DEDUP(SORT(DISTRIBUTE(hdr_base(link_id<>0),HASH64(link_id)),link_id,-processdate,LOCAL),link_id,LOCAL);
	file_key_LinkIds			:= hdr_base(COUNTRY='US');
	file_key_exec_Link_Id	:= project(Cortera.Files().Base.Executives.Built(Link_id<>0),dx_Cortera.Layouts.Layout_ExecLinkID);
	
	
	RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_Cortera.Key_LinkIds.Key
																						 ,file_key_LinkIds
																						 ,dx_Cortera.Keynames().LinkIds.QA
																						 ,dx_Cortera.Keynames(pversion,false).LinkIds.New
																						 ,BuildLinkIdsKey); 
	
	RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_Cortera.Key_Header_Link_Id
																						 ,file_Key_hdr_Link_Id
																						 ,dx_Cortera.Keynames().Hdr_Link_Id.QA
																						 ,dx_Cortera.Keynames(pversion,false).Hdr_Link_Id.New
																						 ,BuildHdr_Link_IdKey);
																						 
	RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_Cortera.Key_Attributes_Link_Id
																						 ,Cortera.Files().Base.Attributes.Built
																						 ,dx_Cortera.Keynames().Attr_Link_Id.QA
																						 ,dx_Cortera.Keynames(pversion,false).Attr_Link_Id.New
																						 ,BuildAttr_Link_IdKey);
																						 
	RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_Cortera.Key_Executive_Link_Id
																						 ,file_key_exec_Link_Id 
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
			Cortera.Promote(pversion,'key').BuildFiles.New2Built
	);
end;