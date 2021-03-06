import VotersV2, ut, doxie, autokey, AutokeyB2, RoxieKeyBuild;

export Proc_Build_Voters_Keys(string filedate) := function

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(VotersV2.Key_Voters_DID,
                       '~thor_data400::key::voters::@version@::did','~thor_data400::key::voters::'+filedate+'::did',
                       bld_did_key);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Key_Voters_VTID,
											 '~thor_data400::key::voters::@version@::VTID','~thor_data400::key::voters::'+filedate+'::VTID',
											 bld_VTID_key);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Key_Voters_History_VTID,
											 '~thor_data400::key::voters::@version@::History_VTID','~thor_data400::key::voters::'+filedate+'::History_VTID',
											 bld_History_VTID_key);


//start voters autokeys
voters_base := VotersV2.File_Voters_Base;

Layout_Autokeys := Layouts_Voters.Layout_Voters_Autokeys;

//capture all phones
Layout_Autokeys NormWorkPhone(voters_base l, unsigned c) := transform
	self.phone := choose(c,l.phone,l.work_phone);
	self := l;
end;

// Normalize the work_phone 
Voters_Norm_base := NORMALIZE(voters_base
												  ,if(trim(left.phone,left,right) <> trim(left.work_phone,left,right) and 
												      trim(left.work_phone,left,right) <> '', 2,1)
												  ,NormWorkPhone(left,counter));

// holds logical base name for a autokeys.
logicalname := VotersV2.Constants(filedate).autokey_logical;

// holds key base name for autokeys 
keyname     := VotersV2.Constants(filedate).autokey_keyname;

skip_set := ['B','F','Q'];

AutokeyB2.MAC_Build(Voters_Norm_base,fname,mname,lname,
										ssn,
										dob,
										phone,
										prim_name, prim_range, st, p_city_name, zip, sec_range,
										zero,
										zero,zero,zero,
										zero,zero,zero,
										zero,zero,zero,
										zero,				 
										did,
										blank,
						        zero,
						        zero,
						        blank,blank,blank,blank,blank,blank,
						        zero,
										keyname,
										logicalname,bld_auto_keys,false,skip_set,true,,
										true); 

//end voters autokeys 
// Move DID, Source VTID & Vote History VTID keys to build
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::voters::@version@::did','~thor_data400::key::voters::'+filedate+'::did',mv_did);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::voters::@version@::vtid','~thor_data400::key::voters::'+filedate+'::vtid',mv_vtid);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::voters::@version@::History_VTID','~thor_data400::key::voters::'+filedate+'::History_VTID',mv_vh_vtid);

// Move DID, source VTID, Vote History VTID keys to QA
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::voters::@version@::did', 'Q', mv_did_key);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::voters::@version@::VTID', 'Q', mv_vtid_key);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::voters::@version@::History_VTID', 'Q', mv_vhist_vtid_key);

// Move autokeys to QA
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::voters::autokey::@version@::payload', 'Q', mv_fdids_key);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::voters::autokey::@version@::Address','Q',mv_autokey_addr);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::voters::autokey::@version@::Name','Q',mv_autokey_name);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::voters::autokey::@version@::StName','Q',mv_autokey_stnam);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::voters::autokey::@version@::CityStName','Q',mv_autokey_city);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::voters::autokey::@version@::Zip','Q',mv_autokey_zip);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::voters::autokey::@version@::SSN2','Q',mv_autokey_ssn2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::voters::autokey::@version@::Phone2','Q',mv_autokey_phone2);


Build_Voters_Keys := sequential(parallel(bld_did_key, bld_VTID_key, bld_History_VTID_key,
																				 bld_auto_keys),
																parallel(mv_did, mv_vtid, mv_vh_vtid),
								                parallel(mv_did_key, mv_vtid_key, mv_vhist_vtid_key, 
																         mv_fdids_key, mv_autokey_ssn2, mv_autokey_addr,
																				 mv_autokey_name, mv_autokey_stnam, mv_autokey_city,
																				 mv_autokey_zip, mv_autokey_phone2));


return Build_Voters_Keys;														

end;
