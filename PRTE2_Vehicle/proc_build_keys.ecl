import _control, AutoKeyB, AutoKeyB2, RoxieKeyBuild, PRTE, STD, prte2, tools,doxie, AutoStandardI,doxie_build, PRTE,PRTE2_Common, dops, orbit3;

//EXPORT proc_build_keys(string filedate) := function

EXPORT proc_build_keys (string filedate, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION
	     is_running_in_prod 			:= PRTE2_Common.Constants.is_running_in_prod;
	     doDOPS := is_running_in_prod AND NOT skipDOPS;

//Hole File
Roxiekeybuild.MAC_SF_BuildProcess(files.wildcard_public, Constants.SuperKeyName_wildcard + doxie_build.buildstate, Constants.key_wildcard+filedate+ '::wildcard_' + doxie_build.buildstate, data_file);


//Build Indexes
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Keys.addr,								Constants.SuperKeyName +'vehicles_address',		Constants.key_prefix+filedate+'::vehicles_address',	addr_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.BDID,								Constants.SuperKeyName +'bdid',								Constants.key_prefix+filedate+'::BDID',							bdid_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Keys.BocaShell_Vehicles,	Constants.SuperKeyName +'bocashell_did',			Constants.key_prefix+filedate+'::bocashell_did',		bocashell_did_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.DID,								Constants.SuperKeyName +'did',								Constants.key_prefix+filedate+'::DID',							did_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.DL_Number,					Constants.SuperKeyName +'dl_number',					Constants.key_prefix+filedate+'::DL_Number',				dl_number_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.Lic_Plate,					Constants.SuperKeyName +'Lic_Plate',					Constants.key_prefix+filedate+'::Lic_Plate',				lic_plate_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.Lic_Plate_Blur,			Constants.SuperKeyName +'lic_plate_blur',			Constants.key_prefix+filedate+'::lic_plate_blur',		lic_plate_blur_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.linkids.Key,				Constants.SuperKeyName +'linkids', 						Constants.key_prefix+filedate+'::linkids',					linkids_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.MAIN,								Constants.SuperKeyName +'MAIN_Key',						Constants.key_prefix+filedate+'::MAIN_Key',					main_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Keys.MFD_Srch,						Constants.SuperKeyName +'mfd_srch',						Constants.key_prefix+filedate+'::mfd_srch',					mfdSrch_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.Party,							Constants.SuperKeyName +'Party_Key',					Constants.key_prefix+filedate+'::Party_Key',				party_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.reverse_Lic_Plate,	Constants.SuperKeyName +'reverse_Lic_Plate',	Constants.key_prefix+filedate+'::reverse_Lic_Plate',reverse_lic_plate_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Keys.Source_Rec_ID,			Constants.SuperKeyName +'source_rec_id',			Constants.key_prefix+filedate+'::source_rec_id',		source_recID_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.Title_Number,				Constants.SuperKeyName +'Title_Number',				Constants.key_prefix+filedate+'::Title_Number',			title_number_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.VIN,								Constants.SuperKeyName +'VIN',								Constants.key_prefix+filedate+'::VIN',							vin_key);


//Wildcard Keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.modelindex_public,		Constants.key_prefix_wc +'keymodelindex_public', 	Constants.key_prefix_model+filedate+'::keymodelindex_public',	wildcard1_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.nameindex_public,			Constants.key_prefix_wc +'keynameindex_public', 	Constants.key_prefix_model+filedate+'::keynameindex_public',	wildcard2_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.wc_vehicle_bodystyle,	Constants.key_prefix_wc +'bodystyle', 						Constants.key_prefix_wc+filedate+'::bodystyle',								wildcard3_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.wc_vehicle_make,			Constants.key_prefix_wc +'make', 									Constants.key_prefix_wc+filedate+'::make',										wildcard4_key);


build_roxie_keys	:=	parallel(addr_key, bdid_key, bocashell_did_key,	did_key, dl_number_key, 
															 lic_plate_key, lic_plate_blur_key, linkids_key, main_key, mfdSrch_key,
															 party_key,	reverse_lic_plate_key, source_recId_key,
															 title_number_key, vin_key,   
															 wildcard1_key, wildcard2_key, wildcard3_key, wildcard4_key
																);


// -- Move Keys to Built
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.SuperKeyName+ 'vehicles_address', 		Constants.key_prefix+filedate+'::vehicles_address', 	mv_addr_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.SuperKeyName+ 'BDID', 								Constants.key_prefix+filedate+'::BDID', 							mv_bdid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.SuperKeyName+ 'bocashell_did', 				Constants.key_prefix+filedate+'::bocashell_did', 			mv_bocashell_did_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.SuperKeyName+ 'DID', 									Constants.key_prefix+filedate+'::DID',	 							mv_did_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.SuperKeyName+ 'DL_Number', 						Constants.key_prefix+filedate+'::DL_Number', 					mv_dl_number_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.SuperKeyName+ 'Lic_Plate', 						Constants.key_prefix+filedate+'::Lic_Plate', 					mv_lic_plate_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.SuperKeyName+ 'lic_plate_blur', 			Constants.key_prefix+filedate+'::lic_plate_blur', 		mv_lic_plate_blur_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.SuperKeyName+ 'linkids', 							Constants.key_prefix+filedate+'::linkids', 						mv_linkids_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.SuperKeyName+ 'MAIN_Key', 						Constants.key_prefix+filedate+'::MAIN_Key', 					mv_main_Key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.SuperKeyName+ 'mfd_srch', 						Constants.key_prefix+filedate+'::mfd_srch',	 					mv_mfdSrch_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.SuperKeyName+ 'Party_Key', 						Constants.key_prefix+filedate+'::Party_Key', 					mv_party_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.SuperKeyName+ 'reverse_Lic_Plate', 		Constants.key_prefix+filedate+'::reverse_Lic_Plate',	mv_reverse_lic_plate_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.SuperKeyName+ 'source_rec_id',				Constants.key_prefix+filedate+'::source_rec_id', 			mv_source_recID_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.SuperKeyName+ 'Title_Number', 				Constants.key_prefix+filedate+'::Title_Number', 			mv_title_number_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.SuperKeyName+ 'VIN', 									Constants.key_prefix+filedate+'::VIN', 								mv_vin_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.SuperKeyName_wc +'keymodelindex_public', 	Constants.key_prefix_model+filedate+'::keymodelindex_public',	mv_wildcard1_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.SuperKeyName_wc +'keynameindex_public', 	Constants.key_prefix_model+filedate+'::keynameindex_public',	mv_wildcard2_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.SuperKeyName_wc +'bodystyle', 						Constants.key_prefix_wc+filedate+'::bodystyle',								mv_wildcard3_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.SuperKeyName_wc +'make', 									Constants.key_prefix_wc+filedate+'::make',										mv_wildcard4_key);


Move_keys	:=	parallel(mv_addr_key, mv_bdid_key, mv_bocashell_did_key,	mv_did_key, mv_dl_number_key, 
											 mv_lic_plate_key, mv_lic_plate_blur_key, mv_linkids_key, mv_main_key, mv_mfdSrch_key,
											 mv_party_key,	mv_reverse_lic_plate_key, mv_source_recId_key,
											 mv_title_number_key, mv_vin_key,   
											 mv_wildcard1_key, mv_wildcard2_key, mv_wildcard3_key, mv_wildcard4_key
											);

//-- Move Keys to QA
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName	+'vehicles_address',	'Q',	mv_addr_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName	+'BDID',  						'Q',	mv_bdid_qa, 2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName	+'bocashell_did',			'Q',	mv_bocashell_did_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName	+'DID', 							'Q', 	mv_did_qa, 2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName	+'DL_Number',  				'Q',	mv_dl_number_qa, 2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName	+'Lic_Plate', 				'Q',	mv_lic_plate_qa, 2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName	+'lic_plate_blur',		'Q',	mv_lic_plate_blur_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName	+'linkids',						'Q',	mv_linkids_qa, 2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName	+'MAIN_Key',  				'Q', 	mv_main_qa, 2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName	+'mfd_srch', 					'Q',	mv_mfdSrch_qa, 2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName	+'PARTY_Key', 				'Q',	mv_party_qa, 2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName	+'reverse_Lic_Plate', 'Q',	mv_reverse_lic_plate_qa, 2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName	+'source_rec_id', 		'Q',	mv_source_recid_qa, 2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName	+'Title_Number',			'Q',	mv_title_number_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName	+'VIN', 							'Q',	mv_vin_qa, 2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName_wc	+'keymodelindex_public','Q',	mv_wildcard1_qa, 2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName_wc	+'keynameindex_public',	'Q',	mv_wildcard2_qa, 2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName_wc	+'bodystyle',						'Q',	mv_wildcard3_qa, 2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName_wc	+'make',								'Q',	mv_wildcard4_qa, 2);

To_qa	:=	parallel(mv_addr_qa, mv_BDID_qa, mv_bocashell_did_qa, mv_DID_qa, mv_DL_Number_qa,
									 mv_Lic_Plate_qa, mv_lic_plate_blur_qa, mv_linkids_qa, mv_MAIN_qa, mv_MFDSrch_qa,
									 mv_Party_qa, mv_reverse_Lic_Plate_qa, mv_Source_RecID_qa,
      						 mv_VIN_qa,  mv_Title_Number_qa,   
									 mv_wildcard1_qa, mv_wildcard2_qa, mv_wildcard3_qa, mv_wildcard4_qa 
									 );



autokeys(string filedate) := function
AutoKeyB2.MAC_Build(file_SearchAutokey_Party,
										person_name.fname,person_name.mname,person_name.lname,
									  Append_ssn,
										zero,
										zero,
										person_addr.prim_name,person_addr.prim_range,person_addr.st,person_addr.v_city_name,person_addr.zip5,person_addr.sec_range,
										zero,
										zero,zero,zero,
										zero,zero,zero,
										zero,zero,zero,
										lookup_bit,
										Append_DID,
										Append_Clean_CName,
										Append_FEIN,
										zero,
										company_addr.prim_name,company_addr.prim_range,company_addr.st,company_addr.v_city_name,company_addr.zip5,company_addr.sec_range,
										Append_BDID,
										constants.ak_keyname,
										constants.ak_logical(filedate),
										outaction,false,
										constants.ak_skipSet,true,constants.str_typeStr,
										true,,,zero); 

AutoKeyB2.MAC_AcceptSK_to_QA(constants.ak_keyname, mymove,,constants.ak_skipSet);
r := sequential(outaction,mymove);
 
return r;
end;


//---------- making DOPS optional and only in PROD build -------------------------------													
		notifyEmail 				:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
		NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD');						
		updatedops   		 		:= PRTE.UpdateVersion('VehicleV2Keys',filedate,notifyEmail,l_inloc:='B',l_inenvment:='N',l_includeboolean := 'N');
		PerformUpdateOrNot 	:= IF(doDOPS,updatedops,NoUpdate);
		//--------------------------------------------------------------------------------------
key_validation :=  output(dops.ValidatePRCTFileLayout(filedate, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,Constants.dops_name, 'N'), named(Constants.dops_name+'Validation'));

create_orbit_build := Orbit3.proc_Orbit3_CreateBuild('PRTE - VehicleV2', filedate, 'N', true, true, false,  _control.MyInfo.EmailAddressNormal);
																

// -- Actions
buildKey	:=	sequential( data_file
											   ,build_roxie_keys
												 ,Move_keys
												 ,to_qa
												 ,autokeys(filedate)
                         ,PerformUpdateOrNot
												 ,key_validation
												 ,create_orbit_build								 
											);
									
return	buildKey;
end;

