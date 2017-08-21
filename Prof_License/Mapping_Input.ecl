// This attribute is where we will take any additional products/sources and transform them into the
//   layout that Professional License uses for its input.  This way, they are simply added to the
//   "normal" Professional License records in the beginning of the build.
IMPORT ALC, HealthCare_Provider_Header_AsHeader, HMS_STLIC, Infogroup, MPRD, Prof_License, ut;

EXPORT Mapping_Input := MODULE

  //---------------------------------------- MPRD ---------------------------------------------------
	mprd_input := MPRD.files().individual_base.qa(filecode[1..3] = 'LIC', filecode[7] = 'P');

  // Currently there are 0 records with either lic2_type or lic3_type, so no need to normalize.
	Prof_License.Layout_proLic_in xform_mprd(MPRD.layouts.individual_base L, MPRD.layouts.taxonomy_full_lu_base R) := TRANSFORM
		the_vendor                          := 'ENC_PL_' + L.filecode[5..6] + '_' + L.filecode[7..];
		the_license_number                  := HealthCare_Provider_Header_AsHeader.Utils.CleanLicenseNumber(L.lic1_num);
		the_source_st                       := HealthCare_Provider_Header_AsHeader.Utils.CleanLicenseState(L.lic1_state);
		the_name_suffix                     := IF(L.name_suffix != '', L.name_suffix, L.maturity_suffix);

		SELF.prolic_key                     := IF(the_license_number != '',
		                                          HASH32(the_source_st + the_vendor) + the_license_number,
																							'');
		SELF.date_first_seen                := (STRING)L.Date_vendor_first_reported;
		SELF.date_last_seen                 := (STRING)L.Date_vendor_last_reported;
		SELF.license_type                   := ut.CleanSpacesAndUpper(R.classification);
		SELF.status                         := L.lic1_status;
		SELF.orig_license_number            := the_license_number;
		SELF.license_number                 := the_license_number;
		SELF.company_name                   := L.clean_prac1_company_name;
		SELF.orig_name                      := L.full_name;
		SELF.name_order                     := 'FML';
		SELF.orig_addr_1                    := ut.CleanSpacesAndUpper(L.orig_adresss);
		SELF.orig_city                      := ut.CleanSpacesAndUpper(L.orig_city);
		SELF.orig_st                        := L.orig_state;
		SELF.business_flag                  := IF(L.clean_prac1_company_name != '', 'Y', 'N');
		SELF.phone                          := L.clean_prac_phone1;
		// Due to much higher fill-rates, we're using gender to back up male_female when the field is blank.
		// NOTE: found 7000+ish gender conflicts and from what I saw, the gender field seemed correct... so,
		//       I will, for now, override the male_female with what's in gender, for those situations.
		SELF.sex                            := MAP(L.male_female = 'M' AND L.gender = '5' => 'F',
																							 L.male_female = 'F' AND L.gender = '1' => 'M',
																							 L.male_female != ''                    => L.male_female,
																							 L.gender = '1'                         => 'M',
																							 L.gender = '5'                         => 'F',
																							 '');
		SELF.dob                            := L.clean_birthdate;
		SELF.issue_date                     := L.clean_lic1_begin_date;
		SELF.expiration_date                := L.clean_lic1_end_date;
		SELF.source_st                      := the_source_st;
		SELF.vendor                         := the_vendor;

		SELF.additional_phone               := L.clean_bill_phone1;

		SELF.misc_practice_type             := ut.CleanSpacesAndUpper(R.specialization);
		SELF.misc_email                     := ut.CleanSpacesAndUpper(L.email_addr);
		SELF.misc_fax                       := L.prac_fax1;
		SELF.misc_web_site                  := ut.CleanSpacesAndUpper(L.web_site);

		SELF.education_1_school_attended    := HealthCare_Provider_Header_AsHeader.Utils.CleanMedschoolName(L.medschool1);
		SELF.education_1_dates_attended     := HealthCare_Provider_Header_AsHeader.Utils.CleanMedschoolName_Year(L.medschool1_year);

		SELF.prim_range                     := L.clean_prim_range;
		SELF.predir                         := L.clean_predir;
		SELF.prim_name                      := L.clean_prim_name;
		SELF.suffix                         := L.clean_addr_suffix;
		SELF.postdir                        := L.clean_postdir;
		SELF.unit_desig                     := L.clean_unit_desig;
		SELF.sec_range                      := L.clean_sec_range;
		SELF.p_city_name                    := L.clean_p_city_name;
		SELF.v_city_name                    := L.clean_v_city_name;
		SELF.st                             := L.clean_st;
		SELF.zip                            := L.clean_zip;
		SELF.zip4                           := L.clean_zip4;
		SELF.cart                           := L.clean_cart;
		SELF.cr_sort_sz                     := L.clean_cr_sort_sz;
		SELF.lot                            := L.clean_lot;
		SELF.lot_order                      := L.clean_lot_order;
		SELF.dpbc                           := L.clean_dbpc;
		SELF.chk_digit                      := L.clean_chk_digit;
		SELF.record_type                    := L.clean_rec_type;
		SELF.ace_fips_st                    := L.clean_fips_st;
		SELF.county                         := L.clean_fips_county;
		SELF.geo_lat                        := L.clean_geo_lat;
		SELF.geo_long                       := L.clean_geo_long;
		SELF.msa                            := L.clean_msa;
		SELF.geo_blk                        := L.clean_geo_blk;
		SELF.geo_match                      := L.clean_geo_match;
		SELF.err_stat                       := L.clean_err_stat;
		SELF.fname                          := HealthCare_Provider_Header_AsHeader.Utils.CleanNameComponent(L.fname);
		SELF.mname                          := HealthCare_Provider_Header_AsHeader.Utils.CleanNameComponent(L.mname);
		SELF.lname                          := HealthCare_Provider_Header_AsHeader.Utils.CleanNameComponent(L.lname);
		SELF.name_suffix                    := HealthCare_Provider_Header_AsHeader.Utils.CleanNameComponent(the_name_suffix);

		SELF := L;
		SELF := [];
	END;

	mprd_translated := JOIN(mprd_input, MPRD.Files().taxonomy_full_lu_Base.qa,
	                        LEFT.taxonomy = RIGHT.taxonomy,
													xform_mprd(LEFT, RIGHT),
													LEFT OUTER,
													LOOKUP);
	mprd_dedup := DEDUP(SORT(DISTRIBUTE(mprd_translated,
																			HASH64(source_st, vendor, profession_or_board, license_number,
																								company_name, orig_name)),
													 RECORD,
													 LOCAL),
											RECORD,
											LOCAL);

  EXPORT MPRD := mprd_dedup;

  //----------------------------------------- HMS ---------------------------------------------------
	hms_input := HMS_STLIC.Files().statelicense_Base.qa;

	Prof_License.Layout_proLic_in xform_hms(HMS_STLIC.layouts.statelicense_base L) := TRANSFORM
		the_gender                       := ut.CleanSpacesAndUpper(L.gender);
		has_valid_mapped_class           := LENGTH(TRIM(L.mapped_class)) = 3;
		length_of_license_class_type     := LENGTH(TRIM(L.license_class_type));
		valid_description :=
		  HMS_STLIC.LookupTables.TaxonomyLookup(hms_stlic_type_code = L.mapped_class)[1].hms_stlic_type_desc;
		valid_description_upper          := StringLib.StringToUpperCase(valid_description);
		license_class_type_upper         := StringLib.StringToUpperCase(L.license_class_type);

		SELF.prolic_key                  := IF(L.license_number != '',
		                                       HASH32(L.license_state + L.source_code) + L.license_number,
																					 '');
		SELF.date_first_seen             := (STRING)L.dt_vendor_first_reported;
		SELF.date_last_seen              := (STRING)L.dt_vendor_last_reported;
		SELF.profession_or_board         := ut.CleanSpacesAndUpper(L.mapped_pract_type);
		SELF.license_type                := MAP(has_valid_mapped_class           => valid_description_upper,
		                                        length_of_license_class_type > 8 => license_class_type_upper,
		                                        '');
		SELF.status                      := IF(ut.isNumeric(L.status),
		                                       L.mapped_status,
																					 ut.CleanSpacesAndUpper(L.status));
		SELF.orig_license_number         := L.license_number;
		SELF.license_number              := L.license_number;
		SELF.orig_name                   := ut.CleanSpacesAndUpper(L.name);
		SELF.name_order                  := 'FML';
		SELF.company_name                := L.clean_company_name;
		SELF.orig_addr_1                 := L.street1;
		SELF.orig_addr_2                 := L.street2;
		SELF.orig_addr_3                 := L.street3;
		SELF.orig_city                   := L.city;
		SELF.orig_st                     := L.address_state;
		SELF.orig_zip                    := L.orig_zip;
		SELF.county_str                  := L.orig_county;
		SELF.country_str                 := ut.CleanSpacesAndUpper(L.country);
		SELF.business_flag               := IF(L.clean_company_name != '', 'Y', 'N');
		SELF.phone                       := L.clean_phone1;
		SELF.sex                         := IF(the_gender IN HealthCare_Provider_Header_AsHeader.Constants.setGenderAllowedValues, the_gender, '');
		SELF.dob                         := L.clean_dateofbirth;
		SELF.issue_date                  := L.clean_issue_date;
		SELF.expiration_date             := L.clean_expiration_date;
		SELF.source_st                   := L.license_state;
		SELF.vendor                      := L.source_code;

		SELF.action_desc                 := ut.CleanSpacesAndUpper(L.action);
		SELF.action_effective_dt         := L.clean_action_date;

		SELF.additional_phone            := L.clean_phone;

		SELF.misc_fax                    := L.clean_fax1;

		SELF.education_1_school_attended := ut.CleanSpacesAndUpper(L.school); // There are currently no values from HMS

		SELF.suffix                      := ut.CleanSpacesAndUpper(L.suffix);

		SELF := L;
		SELF := [];
	END;

	hms_proj := PROJECT(hms_input, xform_hms(LEFT));
	hms_dedup := DEDUP(SORT(DISTRIBUTE(hms_proj,
																		 HASH64(source_st, vendor, profession_or_board, license_number,
																							 company_name, orig_name)),
													RECORD,
													LOCAL),
										 RECORD,
										 LOCAL);

  EXPORT HMS := hms_dedup;

  //----------------------------------------- ALC ---------------------------------------------------
	alc_input := ALC.Files().Base.qa;

	Prof_License.Layout_proLic_in xform_alc(ALC.Layouts.Base L) := TRANSFORM
    the_vendor        := 'ALC';
		the_license_state := CASE(L.alc_prof_type, 'NURSE' => L.reg_state_singular,
		                                                      L.license_state);
		the_full_name     := StringLib.StringCleanSpaces(L.fname + ' ' + L.lname);
		the_license_type  := CASE(L.alc_prof_type, 'ACCOUNTANT' => L.job_code_desc,
		                                           'LAWYER'     => 'LAWYER',
		                                           'PILOT'      => L.cert_type_singular_desc,
		                                                           L.license_type_singular_desc);

		SELF.prolic_key          := IF(L.license_no != '',
		                               HASH32(the_license_state + the_vendor + the_license_type +
															               the_full_name + L.custno) + L.license_no,
																					'');
		SELF.date_first_seen     := (STRING)L.dt_first_seen;
		SELF.date_last_seen      := (STRING)L.dt_last_seen;
		SELF.license_type        := the_license_type;
		SELF.status              := '';
		SELF.orig_license_number := L.license_no;
		SELF.license_number      := L.license_no;
		SELF.orig_name           := the_full_name;
		SELF.name_order          := 'FML';
		SELF.company_name        := L.company;
		SELF.orig_addr_1         := L.address1;
		SELF.orig_addr_2         := L.address2;
		SELF.orig_city           := L.city;
		SELF.orig_st             := L.state;
		SELF.orig_zip            := L.zip;
		SELF.county_str          := L.county_cd;
		SELF.country_str         := '';
		SELF.business_flag       := IF(L.company != '', 'Y', 'N');
		SELF.phone               := L.clean_phone;
		SELF.sex                 := IF(L.clean_gender IN HealthCare_Provider_Header_AsHeader.Constants.setGenderAllowedValues, L.clean_gender, '');
		SELF.dob                 := L.clean_dob;
		SELF.issue_date          := L.clean_orig_date;
		SELF.expiration_date     := L.clean_exp_date;
		SELF.source_st           := the_license_state;
		SELF.vendor              := the_vendor;

		SELF.misc_email          := L.email;
		SELF.misc_fax            := L.clean_fax;
		SELF.misc_practice_type  :=
		  CASE(L.alc_prof_type, 'DENTAL PROFESSIONAL' => L.specialty_code_singular_desc,
		                        'LAWYER'              => L.practice_area_singular_desc,
		                        'NURSE'               => L.specialty_singular_desc,
		                        'PILOT'               => L.cert_type_secondary_singular_desc,
		                                                 L.specialty);
    SELF.misc_other_id       := L.custno;
		SELF.misc_other_id_type  := 'CUSTNO';

		SELF.education_1_degree  := L.degree;

		SELF.additional_licensing_specifics :=
		  CASE(L.alc_prof_type, 'DENTAL PROFESSIONAL' => L.specialty,
		                        'PILOT'               => L.cert_lvl_singular_desc,
		                        'PROFESSIONAL'        => L.license_class_singular_desc,
		                                                 '');

    SELF.fname               := L.clean_name.fname;
    SELF.mname               := L.clean_name.mname;
    SELF.lname               := L.clean_name.lname;
    SELF.name_suffix         := L.clean_name.name_suffix;

		SELF := L;
		SELF := [];
	END;

	alc_proj := PROJECT(alc_input, xform_alc(LEFT));
	alc_dedup := DEDUP(SORT(DISTRIBUTE(alc_proj,
																		 HASH64(source_st, vendor, profession_or_board, license_number,
																							 company_name, orig_name)),
													RECORD,
													LOCAL),
										 RECORD,
										 LOCAL);

  EXPORT ALC := alc_dedup;

  //----------------------------------------- Infogroup ---------------------------------------------
	infogroup_input := Infogroup.Files().Base.qa;

	Prof_License.Layout_proLic_in xform_infogroup(Infogroup.Layouts.Base L) := TRANSFORM
    the_vendor    := 'INFOGROUP';
		the_full_name := StringLib.StringCleanSpaces(L.first_name + ' ' + L.middle_name + ' ' +
		                                                L.last_name + ' ' + L.suffix);

		SELF.prolic_key          := IF(L.license_number != '',
		                               HASH32(L.license_state + the_vendor) + L.license_number,
															     '');
		SELF.date_first_seen     := (STRING)L.dt_first_seen;
		SELF.date_last_seen      := (STRING)L.dt_last_seen;
		SELF.license_type        := L.occupation_title;
		SELF.status              := L.status_code_desc;
		SELF.orig_license_number := L.license_number;
		SELF.license_number      := L.license_number;
		SELF.orig_name           := the_full_name;
		SELF.name_order          := 'FML';
		SELF.company_name        := L.employer_name;
		SELF.orig_addr_1         := L.address;
		SELF.orig_city           := L.city;
		SELF.orig_st             := L.state;
		SELF.orig_zip            := L.zip;
		SELF.county_str          := L.county_code_desc;
		SELF.business_flag       := IF(L.employer_name != '', 'Y', 'N');
		SELF.issue_date          := IF((UNSIGNED)L.clean_year_licensed = 0, '', L.clean_year_licensed + '0000');
		SELF.expiration_date     := L.clean_exp_date;
		SELF.source_st           := L.license_state;
		SELF.vendor              := the_vendor;

		SELF.misc_practice_type  := L.specialty_title;

    SELF.fname               := L.clean_name.fname;
    SELF.mname               := L.clean_name.mname;
    SELF.lname               := L.clean_name.lname;
    SELF.name_suffix         := L.clean_name.name_suffix;

		SELF := L;
		SELF := [];
	END;

	infogroup_proj := PROJECT(infogroup_input, xform_infogroup(LEFT));
	infogroup_dedup := DEDUP(SORT(DISTRIBUTE(infogroup_proj,
																		       HASH64(source_st, vendor, profession_or_board, license_number,
																							       company_name, orig_name)),
													      RECORD,
													      LOCAL),
										       RECORD,
										       LOCAL);

  EXPORT Infogroup := infogroup_dedup;

END;
