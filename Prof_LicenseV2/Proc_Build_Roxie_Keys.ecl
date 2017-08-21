import Prof_License, RoxieKeyBuild;

export Proc_Build_Roxie_Keys(string filedate) := function

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Prof_LicenseV2.key_proflic_did(),
											   '~thor_Data400::key::prolicv2::@version@::prolicense_did',
											   '~thor_data400::key::prolicv2::'+ filedate +'::did',
											   b);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Prof_LicenseV2.key_proflic_licensenum,
											   '~thor_data400::key::prolicv2::@version@::proflic_licensenum',
											   '~thor_data400::key::prolicV2::'+ filedate +'::licensenum',
											   c);
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Prof_LicenseV2.key_proflic_bdid,
											   '~thor_data400::key::prolicv2::@version@::proflic_bdid',
											   '~thor_data400::key::prolicv2::'+ filedate +'::bdid',
											   d);
												 
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Prof_LicenseV2.key_proflic_did(true),
											   '~thor_data400::key::ProlicV2::fcra::@version@::prolicense_did',
											   '~thor_data400::key::prolicV2::fcra::'+ filedate +'::did',
											   p);
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Prof_LicenseV2.key_proflic_lnpid(),
											   '~thor_Data400::key::prolicv2::@version@::prolicense_lnpid',
											   '~thor_data400::key::prolicv2::'+ filedate +'::lnpid',
											   lnpid);												 
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Prof_LicenseV2.key_addr_proflic,
											   '~thor_data400::key::prolicv2::@version@::cbrs.addr_proflic',
											   '~thor_data400::key::prolicv2::'+ filedate +'::cbrs.addr',
											   kap);
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Prof_LicenseV2.Key_Proflic_LinkIDs.key,
											   '~thor_data400::key::prolicv2::@version@::LinkIds',
											   '~thor_data400::key::prolicv2::'+ filedate +'::LinkIds',
											   LinkIds);
												 
	RoxieKeybuild.Mac_SK_BuildProcess_v2_local(Prof_LicenseV2.Key_LicenseType_lookup(),
													'~thor_data400::key::prolicv2::@version@::professional_license_type_lookup',
													'~thor_data400::key::prolicv2::'+ filedate +'::professional_license_type_lookup',
													liclookup);
													
	RoxieKeybuild.Mac_SK_BuildProcess_v2_local(Prof_LicenseV2.Key_LicenseType_lookup(true),
													'~thor_data400::key::prolicv2::fcra::@version@::professional_license_type_lookup',
													'~thor_data400::key::prolicv2::fcra::'+ filedate +'::professional_license_type_lookup',
													liclookup2);

											
													
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::prolicv2::@version@::prolicense_did',
										  '~thor_data400::key::prolicv2::'+ filedate +'::did', mv_b_did,2);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::prolicv2::@version@::proflic_licensenum',
										  '~thor_data400::key::prolicV2::'+ filedate +'::licensenum', mv_b_licnum,2);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::prolicv2::@version@::proflic_bdid',
										  '~thor_data400::key::prolicv2::'+ filedate +'::bdid', mv_b_bdid,2); 
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::prolicV2::fcra::@version@::prolicense_did',
										  '~thor_data400::key::prolicv2::fcra::'+ filedate +'::did', mv_b_fcradid,2);
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::prolicv2::@version@::prolicense_lnpid',
										  '~thor_data400::key::prolicv2::'+ filedate +'::lnpid', mv_b_lnpid,2);	
											
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::prolicv2::@version@::cbrs.addr_proflic',
										  '~thor_data400::key::prolicv2::'+ filedate +'::cbrs.addr', mv_b_cbrs_addr,2);
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::prolicv2::@version@::LinkIds',
										  '~thor_data400::key::prolicv2::'+ filedate +'::LinkIds', mv_b_LinkIds,2);
											
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::prolicv2::@version@::professional_license_type_lookup',
										  '~thor_data400::key::prolicv2::'+ filedate +'::professional_license_type_lookup', mv_b_liclookup,2);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::prolicv2::fcra::@version@::professional_license_type_lookup',
										  '~thor_data400::key::prolicv2::fcra::'+ filedate +'::professional_license_type_lookup', mv_b_liclookup2,2);
	


	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::prolicv2::@version@::prolicense_did','Q',e,2);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::prolicv2::@version@::proflic_licensenum','Q',f,2);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::prolicv2::@version@::proflic_bdid','Q',g,2); 
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::prolicv2::fcra::@version@::prolicense_did','Q',h,2);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::prolicv2::@version@::cbrs.addr_proflic','Q', kap2,2); 
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::prolicv2::@version@::LinkIds','Q', LinkIds2,2);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::prolicv2::@version@::prolicense_lnpid','Q',lnpid2,2);
	
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::prolicv2::@version@::professional_license_type_lookup','Q',lictype,2);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::prolicv2::fcra::@version@::professional_license_type_lookup','Q',lictype2,2);


	/* **ROXIE KEY NOTIFICATION EMAIL********************************************************************************************************** */	
	/*
	email := fileservices.sendemail('giri.rajulapalli@lexisnexis.com',
									 
									'PROFESSIONAL LICENSES: BUILD SUCCESS '+ filedate ,
									'keys: 1) thor_data400::key::prolicv2::qa::proflic_licensenum(thor_data400::key::prolicv2::'+ filedate +'::licensenum),\n' +
									'      2) thor_data400::key::prolicv2::qa::proflic_bdid(thor_data400::key::prolicv2::'+ filedate +'::bdid),\n' +
									'      3) thor_data400::key::prolicv2::qa::prolicense_did(thor_data400::key::prolicv2::'+ filedate +'::did),\n' +
									'      4) thor_data400::key::prolicv2::qa::cbrs.addr_proflic(thor_data400::key::prolicv2::'+ filedate +'::cbrs.addr),\n' +
									'      5) thor_data400::key::prolicv2::qa::LinkIds(thor_data400::key::prolicv2::'+ filedate +'::LinkIds),\n' +
									'      have been built and ready to be deployed to QA.'); 
				
	*/
	/* ***************************************************************************************************************************************** */

			

	build_roxieKeys :=  sequential(parallel(b,c,d,p,lnpid,kap,LinkIds,liclookup,liclookup2),
   									 parallel(mv_b_did, mv_b_licnum, mv_b_bdid, mv_b_fcradid, mv_b_lnpid,mv_b_cbrs_addr,mv_b_LinkIds,mv_b_liclookup,mv_b_liclookup2),
   									 parallel(e,f,g,h,kap2,LinkIds2,lnpid2,lictype,lictype2));

	return build_roxieKeys;

end;