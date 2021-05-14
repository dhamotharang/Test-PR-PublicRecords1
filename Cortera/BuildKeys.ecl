IMPORT dx_Cortera, Std, VersionControl, RoxieKeyBuild;

EXPORT BuildKeys(string pversion=(string8)Std.Date.Today(), boolean pDeltaBuild = false) := function

 hdr_base              := Cortera.Files().Base.Header.Built;
 file_key_hdr_Link_Id  := DEDUP(SORT(DISTRIBUTE(hdr_base(link_id<>0),HASH64(link_id)),link_id,-processdate,LOCAL),link_id,LOCAL);
 file_key_LinkIds      := hdr_base(COUNTRY='US');
 file_key_Attributes   := Cortera.Files().Base.Attributes.Built;
 file_key_exec_Link_Id := project(Cortera.Files().Base.Executives.Built(Link_id<>0),dx_Cortera.Layouts.Layout_ExecLinkID);
  
 dHdrDelta_rid         := if(pDeltaBuild, 
                             project(hdr_base(delta_ind not in [0,1]), transform(dx_Cortera.Layouts.Layout_Delta_Rid, self := left)),
                             dataset([], dx_cortera.layouts.Layout_Delta_Rid)      
                            );
														
 dAttrDelta_rid        := if(pDeltaBuild, 
                             project(file_key_Attributes(delta_ind not in [0,1]), transform(dx_Cortera.Layouts.Layout_Delta_Rid, self := left)),
                             dataset([], dx_cortera.layouts.Layout_Delta_Rid)      
                            );
														
 dExecDelta_rid        := if(pDeltaBuild, 
                             project(file_key_exec_Link_Id(delta_ind not in [0,1]), transform(dx_Cortera.Layouts.Layout_Delta_Rid, self := left)),
                             dataset([], dx_cortera.layouts.Layout_Delta_Rid)      
                            );
          
 dbld_version          := dataset([{pversion}], dx_Cortera.Layouts.Layout_Version);
 
 
 RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_Cortera.Key_LinkIds.Key
                       ,file_key_LinkIds
                       ,dx_Cortera.Keynames().LinkIds.QA
                       ,dx_Cortera.Keynames(pversion,false).LinkIds.New
                       ,BuildLinkIdsKey);
											 
 RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_Cortera.Key_Delta_Rid_Hdr
                       ,dHdrDelta_rid
                       ,dx_Cortera.Keynames().Hdr_Delta_Rid.QA
                       ,dx_Cortera.Keynames(pversion,false).Hdr_Delta_Rid.New
                       ,BuildHdr_Delta_RidKey);
 
 RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_Cortera.Key_Header_Link_Id
                       ,file_Key_hdr_Link_Id
                       ,dx_Cortera.Keynames().Hdr_Link_Id.QA
                       ,dx_Cortera.Keynames(pversion,false).Hdr_Link_Id.New
                       ,BuildHdr_Link_IdKey);
                       
 RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_Cortera.Key_Attributes_Link_Id
                       ,file_key_Attributes
                       ,dx_Cortera.Keynames().Attr_Link_Id.QA
                       ,dx_Cortera.Keynames(pversion,false).Attr_Link_Id.New
                       ,BuildAttr_Link_IdKey);
                       
 RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_Cortera.Key_Delta_Rid_Attributes
                       ,dAttrDelta_rid
                       ,dx_Cortera.Keynames().Attr_Delta_Rid.QA
                       ,dx_Cortera.Keynames(pversion,false).Attr_Delta_Rid.New
                       ,BuildAttr_Delta_RidKey);
									 
 RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_Cortera.Key_Executive_Link_Id
                       ,file_key_exec_Link_Id 
                       ,dx_Cortera.Keynames().Executive_Link_Id.QA
                       ,dx_Cortera.Keynames(pversion,false).Executive_Link_Id.New
                       ,BuildExec_Link_IdKey);
                       
 RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_Cortera.Key_Delta_Rid_Executive
                       ,dExecDelta_rid
                       ,dx_Cortera.Keynames().Executive_Delta_Rid.QA
                       ,dx_Cortera.Keynames(pversion,false).Executive_Delta_Rid.New
                       ,BuildExec_Delta_RidKey);
                      
 RoxieKeyBuild.Mac_SK_BuildProcess_v3_local(dx_Cortera.Key_Build_Version
                       ,dBld_version
                       ,dx_Cortera.Keynames().Bld_Version.QA
                       ,dx_Cortera.Keynames(pversion,false).Bld_Version.New
                       ,Build_Bld_VersionKey);
  

 return SEQUENTIAL(
   PARALLEL(
    BuildLinkIdsKey,
		BuildHdr_Delta_RidKey,
    BuildHdr_Link_IdKey,
    BuildAttr_Link_IdKey,
		BuildAttr_Delta_RidKey,
    BuildExec_Link_IdKey,
    BuildExec_Delta_RidKey,
    Build_Bld_VersionKey
   ),
   Cortera.Promote(pversion,'key').BuildFiles.New2Built
 );
end;