import header,address,lssi,doxie_build,ut,RoxieKeyBuild,business_risk;

export Proc_Didtrack_Keys(string filedate) := function

//Build keys
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.key_DidTrack_RID,'~thor_data400::key::didtrack.rid','~thor_data400::key::didtrack::'+filedate+'::rid',rid_only);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(doxie.key_DidTrack_DID,'~thor_data400::key::didtrack.did','~thor_data400::key::didtrack::'+filedate+'::did',did_only);

//Move to Built
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::didtrack.rid','~thor_data400::key::didtrack::'+filedate+'::rid',mv_rid);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::didtrack.did','~thor_data400::key::didtrack::'+filedate+'::did',mv_did);

return sequential(parallel(rid_only,did_only),parallel(mv_rid,mv_did));
end;