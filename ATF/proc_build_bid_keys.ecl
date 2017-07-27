import AutoKeyB2, RoxieKeyBuild,ut,atf,standard;

export proc_build_bid_keys(string filedate, boolean isFCRA = false) := function

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(ATF.key_atf_bid(),'~thor_data400::key::atf::firearms::bid','~thor_data400::key::atf::firearms::'+filedate+'::bid',B1);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(ATF.key_ATF_id_bid(),'~thor_data400::key::atf::firearms::bid::atfid','~thor_data400::key::atf::firearms::'+filedate+'::bid::atfid',B2);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::atf::firearms::bid','~thor_data400::key::atf::firearms::'+filedate+'::bid',M1);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::atf::firearms::bid::atfid','~thor_data400::key::atf::firearms::'+filedate+'::bid::atfid',M2);

ut.MAC_SK_Move_v2('~thor_data400::key::atf::firearms::bid','Q',MQ1,2);
ut.MAC_SK_Move_v2('~thor_data400::key::atf::firearms::bid::atfid','Q',MQ2,2);

c := ATF.atf_autokey_constants(filedate); 

ak_keyname  := c.bid_str_autokeyname;
ak_logical  := c.bid_ak_logical;
ak_dataset  := c.bid_ak_dataset;
ak_skipSet  := c.ak_skipSet;
ak_typeStr  := c.ak_typeStr;

AutoKeyB2.MAC_Build (ak_dataset,fname,mname,lname,
                     best_ssn,
                     zero,
                     blank,
                     prim_name,
                     prim_range,
                     st,
                     p_city_name,
                     z5,
                     sec_range,
                     zero,
                     zero,zero,zero,
                     zero,zero,zero,
                     zero,zero,zero,
                     zero,
                     did_out6,
                     Company_Name, // compname which is string thus "blank"
                     zero,
                     zero,
                     prim_name,prim_range,st,p_city_name,z5,sec_range,
                     bdid6, // bdid_out
                     ak_keyname,
                     ak_logical,
                     BAK,false,
                     ak_skipSet,true,ak_typeStr,
                     true,,,zero);

AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname, MAK,, ak_skipSet)

return sequential(
									parallel(B1,B2)
									,parallel(M1,M2)
									,parallel(MQ1,MQ2)
									,BAK
									,MAK
									);

end;