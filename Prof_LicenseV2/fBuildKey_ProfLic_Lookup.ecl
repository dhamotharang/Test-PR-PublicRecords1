IMPORT Prof_LicenseV2, ut, roxiekeybuild;

EXPORT fBuildKey_ProfLic_Lookup(STRING filedate) := FUNCTION

	RoxieKeybuild.Mac_SK_BuildProcess_v2_local(Prof_LicenseV2.Key_LicenseType_lookup(),
													'~thor_data400::key::prolicv2::@version@::professional_license_type_lookup',
													'~thor_data400::key::prolicv2::'+ filedate +'::professional_license_type_lookup',
													liclookup);
													
	RoxieKeybuild.Mac_SK_BuildProcess_v2_local(Prof_LicenseV2.Key_LicenseType_lookup(true),
													'~thor_data400::key::prolicv2::fcra::@version@::professional_license_type_lookup',
													'~thor_data400::key::prolicv2::fcra::'+ filedate +'::professional_license_type_lookup',
													liclookup2);
													
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::prolicv2::@version@::professional_license_type_lookup',
										  '~thor_data400::key::prolicv2::'+ filedate +'::professional_license_type_lookup', mv_b_liclookup,2);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::prolicv2::fcra::@version@::professional_license_type_lookup',
										  '~thor_data400::key::prolicv2::fcra::'+ filedate +'::professional_license_type_lookup', mv_b_liclookup2,2);
				
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::prolicv2::@version@::professional_license_type_lookup','Q',lictype,2);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::prolicv2::fcra::@version@::professional_license_type_lookup','Q',lictype2,2);

												
		built_and_moved := SEQUENTIAL(PARALLEL(liclookup, liclookup2),
																	PARALLEL(mv_b_liclookup, mv_b_liclookup2),
																	PARALLEL(lictype,lictype2));
	RETURN built_and_moved;
END;