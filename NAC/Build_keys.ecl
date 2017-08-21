import AutoKeyB2, RoxieKeyBuild,ut,standard,promotesupers;

export Build_keys(string filedate='dummy') := function

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(key_did,'~thor::NAC::key::did','~thor::NAC::key::'+filedate+'::did',B1);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(key_CaseId,'~thor::NAC::key::CaseId','~thor::NAC::key::'+filedate+'::CaseId',B2);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(key_PrepRecSeq,'~thor::NAC::key::PrepRecSeq','~thor::NAC::key::'+filedate+'::PrepRecSeq',B3);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(key_Collisions,'~thor::NAC::key::Collisions','~thor::NAC::key::'+filedate+'::Collisions',B4);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(key_SCCM,'~thor::NAC::key::SCCM','~thor::NAC::key::'+filedate+'::SCCM',B5);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor::NAC::key::did','~thor::NAC::key::'+filedate+'::did',M1);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor::NAC::key::CaseId','~thor::NAC::key::'+filedate+'::CaseId',M2);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor::NAC::key::PrepRecSeq','~thor::NAC::key::'+filedate+'::PrepRecSeq',M3);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor::NAC::key::Collisions','~thor::NAC::key::'+filedate+'::Collisions',M4);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor::NAC::key::SCCM','~thor::NAC::key::'+filedate+'::SCCM',M5);

promotesupers.Mac_SK_Move_v2('~thor::NAC::key::did','Q',MQ1,2);
promotesupers.Mac_SK_Move_v2('~thor::NAC::key::CaseId','Q',MQ2,2);
promotesupers.Mac_SK_Move_v2('~thor::NAC::key::PrepRecSeq','Q',MQ3,2);
promotesupers.Mac_SK_Move_v2('~thor::NAC::key::Collisions','Q',MQ4,2);
promotesupers.Mac_SK_Move_v2('~thor::NAC::key::SCCM','Q',MQ5,2);

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
									parallel(B1,B2,B3,B4,B5)
									,parallel(M1,M2,M3,M4,M5)
									,parallel(MQ1,MQ2,MQ3,MQ4,MQ5)
									,BAK
									,MAK
									);

end;