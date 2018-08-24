import AutoKeyB2, RoxieKeyBuild,ut,standard, promoteSupers, Std;

base := NAC_V2.Files('').Base2;



export Build_keys(string filedate='dummy') := function

payload := Nac_V2.To_Payload(base);

lfn := nac_v2.Superfile_List().sfPayload + '::' + filedate;
build_payload := IF(NOT Std.File.FileExists(lfn),
	SEQUENTIAL(
		OUTPUT(payload,,lfn, compressed),
		nac_v2.Promote_Superfiles(nac_v2.Superfile_List('').sfPayload, lfn),
	));


RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(key_did,'~thor::NAC2::key::did','~thor::NAC2::key::'+filedate+'::did',B1);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(key_CaseId,'~thor::NAC2::key::CaseId','~thor::NAC2::key::'+filedate+'::CaseId',B2);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(key_PrepRecSeq,'~thor::NAC2::key::PrepRecSeq','~thor::NAC2::key::'+filedate+'::PrepRecSeq',B3);
//RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(key_Collisions,'~thor::NAC2::key::Collisions','~thor::NAC2::key::'+filedate+'::Collisions',B4);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(key_SCCM,'~thor::NAC2::key::SCCM','~thor::NAC2::key::'+filedate+'::SCCM',B5);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(key_SC,'~thor::NAC2::key::SC','~thor::NAC2::key::'+filedate+'::SC',B6);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(key_Exception,'~thor::NAC2::key::exception','~thor::NAC2::key::'+filedate+'::exception',B7);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor::NAC2::key::did','~thor::NAC2::key::'+filedate+'::did',M1);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor::NAC2::key::CaseId','~thor::NAC2::key::'+filedate+'::CaseId',M2);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor::NAC2::key::PrepRecSeq','~thor::NAC2::key::'+filedate+'::PrepRecSeq',M3);
//RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor::NAC2::key::Collisions','~thor::NAC2::key::'+filedate+'::Collisions',M4);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor::NAC2::key::SCCM','~thor::NAC2::key::'+filedate+'::SCCM',M5);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor::NAC2::key::SC','~thor::NAC2::key::'+filedate+'::SC',M6);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor::NAC2::key::exception','~thor::NAC2::key::'+filedate+'::exception',M7);

RoxieKeybuild.MAC_SK_Move_v2('~thor::NAC2::key::did','Q',MQ1,3);
RoxieKeybuild.MAC_SK_Move_v2('~thor::NAC2::key::CaseId','Q',MQ2,3);
RoxieKeybuild.MAC_SK_Move_v2('~thor::NAC2::key::PrepRecSeq','Q',MQ3,3);
//RoxieKeybuild.MAC_SK_Move_v2('~thor::NAC2::key::Collisions','Q',MQ4,2);
RoxieKeybuild.MAC_SK_Move_v2('~thor::NAC2::key::SCCM','Q',MQ5,3);
RoxieKeybuild.MAC_SK_Move_v2('~thor::NAC2::key::SC','Q',MQ6,3);
RoxieKeybuild.MAC_SK_Move_v2('~thor::NAC2::key::exception','Q',MQ7,3);

c := Autokey_constants(filedate); 

ak_keyname  := c.str_autokeyname;
ak_logical  := c.ak_logical;
ak_dataset  := c.ak_dataset;
ak_skipSet  := c.ak_skipSet;
ak_typeStr  := c.ak_typeStr;

AutoKeyB2.MAC_Build (ak_dataset
										,fname,mname,lname
										,clean_ssn
										,clean_dob
										,blank
										,prim_name,prim_range,st,v_city_name,zip,sec_range
										,zero
										,zero,zero,zero
										,zero,zero,zero
										,zero,zero,zero
										,zero
										,did
										,blank
										,zero
										,zero
										,blank,blank,blank,blank,blank,blank
										,zero
										,ak_keyname
										,ak_logical
										,BAK
										,false
										,ak_skipSet,true,ak_typeStr
										,true,,,zero
										 );

AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname, MAK,, ak_skipSet);

return sequential(
									build_payload,
									parallel(B1,B2,B3,B5,B6,B7)							//
									,parallel(M1,M2,M3,M5,M6,M7)						//
									,parallel(MQ1,MQ2,MQ3,MQ5,MQ6,MQ7)				//
									,BAK
									,MAK
									);

end;