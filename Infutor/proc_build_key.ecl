import  RoxieKeyBuild,ut,autokey,infutor;

export proc_build_key(string filedate) := function

SuperKeyName       	:= infutor.cluster +'Key::infutor::@version@::';
BaseKeyName 		:= infutor.cluster +'Key::infutor::'+filedate;
	
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Infutor.key_infutor_did,SuperKeyName+'tracker.did',BaseKeyName+'::tracker.did',key1);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Infutor.key_infutor_id,SuperKeyName+'tracker.id',BaseKeyName+'::tracker.id',key2);
//key using header to replace doxie.key_header for knowx searches
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_DID_payload,'','~thor_data400::key::header::'+filedate+'::adl.infutor.knowx',hdr_if_knowx);

Keys := parallel(key1,key2,hdr_if_knowx) ; 

RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'tracker.did',BaseKeyName+'::tracker.did',mv1,Qa);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'tracker.id',BaseKeyName+'::tracker.id',mv2,Qa);
//key using header to replace doxie.key_header for knowx searches
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::header.adl.infutor.knowx','~thor_data400::key::header::'+filedate+'::adl.infutor.knowx',mv_hdr_if_knowx);

mv_keys := parallel(mv1,mv2,mv_hdr_if_knowx); 

RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'tracker.did','Q',toq1,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'tracker.id','Q',toq2,2);
//key using header to replace doxie.key_header for knowx searches
ut.MAC_SK_Move_v2('~thor_data400::key::header.adl.infutor.knowx', 'Q', mv_hdr_if_knowx_qa);

to_qa := parallel(toq1, toq2,mv_hdr_if_knowx_qa); 

// Build Autokeys

autokeys := Infutor.proc_build_autokey(filedate);

buildKey :=sequential(parallel(Keys,autokeys),Mv_keys,to_qa);

return buildKey ;

end;

