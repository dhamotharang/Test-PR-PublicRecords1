import Prof_License, RoxieKeyBuild;

export Proc_Build_Roxie_Bid_Keys(string filedate) := function

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Prof_LicenseV2.key_proflic_did_Bid(),
											   '~thor_Data400::key::prolicv2::@version@::bid::prolicense_did',
											   '~thor_data400::key::prolicv2::'+ filedate +'::bid::did',
											   b);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Prof_LicenseV2.key_proflic_licensenum_bid,
											   '~thor_data400::key::prolicv2::@version@::bid::proflic_licensenum',
											   '~thor_data400::key::prolicV2::'+ filedate +'::bid::licensenum',
											   c);
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Prof_LicenseV2.key_proflic_bid,
											   '~thor_data400::key::prolicv2::@version@::proflic_bid',
											   '~thor_data400::key::prolicv2::'+ filedate +'::bid',
											   d);
												 
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Prof_LicenseV2.key_proflic_did_bid(true),
											   '~thor_data400::key::ProlicV2::fcra::@version@::bid::prolicense_did',
											   '~thor_data400::key::prolicV2::fcra::'+ filedate +'::bid::did',
											   p);
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Prof_LicenseV2.key_addr_proflic_bid,
											   '~thor_data400::key::prolicv2::@version@::bid::cbrs.addr_proflic',
											   '~thor_data400::key::prolicv2::'+ filedate +'::bid::cbrs.addr',
											   kap);

	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::prolicv2::@version@::bid::prolicense_did',
										  '~thor_data400::key::prolicv2::'+ filedate +'::bid::did', mv_b_did,2);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::prolicv2::@version@::bid::proflic_licensenum',
										  '~thor_data400::key::prolicV2::'+ filedate +'::bid::licensenum', mv_b_licnum,2);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::prolicv2::@version@::proflic_bid',
										  '~thor_data400::key::prolicv2::'+ filedate +'::bid', mv_b_bid,2); 
  RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::prolicV2::fcra::@version@::bid::prolicense_did',
										  '~thor_data400::key::prolicv2::fcra::'+ filedate +'::bid::did', mv_b_fcradid,2);
											
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::prolicv2::@version@::bid::cbrs.addr_proflic',
										  '~thor_data400::key::prolicv2::'+ filedate +'::bid::cbrs.addr', mv_b_cbrs_addr,2);

	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::prolicv2::@version@::bid::prolicense_did','Q',e,2);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::prolicv2::@version@::bid::proflic_licensenum','Q',f,2);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::prolicv2::@version@::proflic_bid','Q',g,2); 
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::prolicv2::fcra::@version@::bid::prolicense_did','Q',h,2);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::prolicv2::@version@::bid::cbrs.addr_proflic','Q', kap2,2); 

			

	build_roxieKeys :=  sequential(parallel(b,c,d,p,kap),
									 parallel(mv_b_did, mv_b_licnum, mv_b_bid, mv_b_fcradid, mv_b_cbrs_addr),
									 parallel(e,f,g,h,kap2));
	return build_roxieKeys;

end;
