import Drivers, Doxie_Files, ut, doxie, autokey, autokeyB2, RoxieKeyBuild;

export Proc_Build_DL_Keys(string filedate) := function


/*
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(DriversV2.Key_DL_DID,
                                           '~thor_data400::key::dl::@version@::did','~thor_data400::key::dl::'+filedate+'::did',
                                           bld_did_key);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(DriversV2.Key_DL_Number,
										   '~thor_data400::key::dl::@version@::dl_number','~thor_data400::key::dl::'+filedate+'::dl_number',
										   bld_dl_num_key);
*/
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(DriversV2.Key_DL_Seq,
										   '~thor_data400::key::dl2::@version@::DL_Seq','~thor_data400::key::dl2::'+filedate+'::DL_Seq',
										   bld_dl_seq_key);

//start dl autokeys
dl_base     := File_DL_base_for_Autokeys;

// Holds the type string for lookups
type_str    := DriversV2.Constants.autokey_typeStr;

// holds logical base name for a autokeys.
logicalname := DriversV2.Constants.autokey_logical(filedate);

// holds key base name for autokeys 
keyname     := DriversV2.Constants.autokey_keyname;

skip_set    := DriversV2.Constants.autokey_skipSet;

AutokeyB2.MAC_Build(dl_base,fname,mname,lname,
					ssn,
					dob,
					zero,
					prim_name, prim_range, st, p_city_name, zip5, sec_range,
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
					logicalname,bld_auto_keys,false,skip_set,true,type_str,
					true,,,zero,,,,,,,,true);
Build_Uber_Keys:=DriversV2.Proc_Build_DL_Uberkeys(filedate);					 
//end dl autokeys 
// Move DID, dl_number & seq keys to built
/*
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::dl::@version@::did','~thor_data400::key::dl::'+filedate+'::did',mv_did);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::dl::@version@::dl_number','~thor_data400::key::dl::'+filedate+'::dl_number',mv_dl_num);
*/
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::dl2::@version@::dl_seq','~thor_data400::key::dl2::'+filedate+'::dl_seq',mv_seq);

// Move DID, dl_number & seq to QA
/*
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::dl::@version@::did', 'Q', mv_did_key);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::dl::@version@::dl_number', 'Q', mv_dl_num_key);
*/
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::dl2::@version@::dl_seq', 'Q', mv_seq_key);

// Move autokeys to QA
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::dl2::autokey::@version@::payload', 'Q', mv_fdids_key);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::dl2::autokey::@version@::SSN2','Q',mv_autokey_ssn2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::dl2::autokey::@version@::Address','Q',mv_autokey_addr);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::dl2::autokey::@version@::Name','Q',mv_autokey_name);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::dl2::autokey::@version@::StName','Q',mv_autokey_stnam);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::dl2::autokey::@version@::CityStName','Q',mv_autokey_city);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::dl2::autokey::@version@::Zip','Q',mv_autokey_zip);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::dl2::autokey::@version@::SSN','Q',mv_autokey_ssn);


Build_dl_Keys := sequential(
							 parallel(bld_dl_seq_key, bld_auto_keys),
							 mv_seq,
							 parallel(mv_seq_key, mv_fdids_key, mv_autokey_ssn2, 
														mv_autokey_addr, mv_autokey_name, mv_autokey_stnam,
														mv_autokey_city, mv_autokey_zip)						
														
							);
Build_All:=	sequential(	Build_dl_Keys,
						Build_Uber_Keys);
																		
return Build_All;														

end;
