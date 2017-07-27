import doxie,RoxieKeybuild;

export build_header_key_prep(string filedate=version_build,boolean pFastHeader = false) := function

rid_rec := record
	unsigned6 rid;
	unsigned6 did;
	unsigned6 first_seen;
	unsigned3 dt_nonglb_last_seen;
end;
rid1:=project(index(doxie.key_Header_rid(pFastHeader,false),'~thor_data400::key::header::'+filedate+'::rid'+SF_suffix(pFastHeader)),rid_rec);
Srid1:=project(index(Key_Rid_SrcID_Prep(pFastHeader,false),'~thor_data400::key::header::'+filedate+'::rid_srid'+SF_suffix(pFastHeader)),Layout_RID_SrcID);

rid2:=project(index(doxie.key_Header_rid(~pFastHeader,false),'~thor_data400::key::header.rid'+SF_suffix(~pFastHeader)+'_qa'),rid_rec);
Srid2:=project(index(Key_Rid_SrcID_Prep(~pFastHeader,false),'~thor_data400::key::header_rid_srid'+SF_suffix(~pFastHeader)+'_qa'),Layout_RID_SrcID);

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.key_Header_rid(,true,rid1 + rid2),'~thor_data400::key::header.rid','~thor_data400::key::header::'+filedate+'::rid',rid_only);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(header.Key_Rid_SrcID_Prep(,true,Srid1 + Srid2),'~thor_data400::key::header_rid_srid','~thor_data400::key::header::'+filedate+'::rid_srid',bld_rid_srid_key);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.rid','~thor_data400::key::header::'+filedate+'::rid',mv_rid);
RoxieKeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header_rid_srid','~thor_data400::key::header::'+filedate+'::rid_srid',mv_rid_srid_key);


return parallel(
								sequential(
												rid_only
												,mv_rid
												)
								,sequential(
												bld_rid_srid_key
												,mv_rid_srid_key
												)
								);

end;