IMPORT  ut, _validate, lib_stringlib, Enclarity;

EXPORT StandardizeInputFile (string filedate, boolean pUseProd = false):= MODULE

	SHARED fn_scale_gk(string38 gk) := function
		unsigned6 max_pid := 281474976710655;  //max unsigned6
		new_gk
			:=
				(unsigned6)
					((unsigned8)( hash64(hashmd5(gk)) ) % max_pid)
				;
		return new_gk;
	end;

	EXPORT Facility	:= FUNCTION
		baseFile	:= Files(filedate,pUseProd).facility_input;

		enclarity.layouts.facility_base tMapping(layouts.facility_input L, integer C) := TRANSFORM, SKIP(L.group_key = 'group_key')
			SELF.pid                      :=fn_scale_gk(l.group_key);
			SELF.src											:= '64';
			SELF.record_type							:= 'C';
			SELF.Dt_vendor_first_reported	:= (unsigned)filedate;
			SELF.Dt_vendor_last_reported	:= (unsigned)filedate;
			SELF.Dt_first_seen						:= 0;
			SELF.Dt_last_seen							:= 0;

			SELF.group_key							:= TRIM(L.group_key, LEFT, RIGHT);
			SELF.dept_group_key					:= TRIM(L.dept_group_key, LEFT, RIGHT);
			SELF.prac_company_name			:= TRIM(Stringlib.StringToUpperCase(L.prac_company_name), LEFT, RIGHT);
			SELF.addr_key								:= TRIM(L.addr_key, LEFT, RIGHT);

			SELF.normed_addr_rec_type     := CHOOSE(C,'P','S');
			SELF.Prepped_addr1            := TRIM(Stringlib.StringToUpperCase(
																							CHOOSE(C
																											,L.addr_primary_address
																											,L.addr_secondary_address
																											)
																						), LEFT, RIGHT);
			SELF.Prepped_addr2            := TRIM(Stringlib.StringToUpperCase(
																							StringLib.StringCleanSpaces(	trim(L.addr_city) + if(L.addr_city <> '',',','')
																		+ ' '+ L.addr_state
																		+ ' '+ L.addr_zip
																		)),left,right);

			SELF.pv_addr_ind						:= TRIM(Stringlib.StringToUpperCase(L.pv_addr_ind), LEFT, RIGHT);
			SELF.phone1									:= TRIM(L.phone1, LEFT, RIGHT);
			SELF.fax1										:= TRIM(L.fax1, LEFT, RIGHT);
			SELF.last_verified_date			:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.last_verified_date,'-')),LEFT, RIGHT);
			SELF.dea_num								:= TRIM(Stringlib.StringToUpperCase(L.dea_num), LEFT, RIGHT);
			SELF.dea_num_exp						:= TRIM(Stringlib.StringToUpperCase(stringlib.stringfilterout(L.dea_num_exp,'-')), LEFT, RIGHT);
			SELF.dea_bus_act_ind				:= TRIM(L.dea_bus_act_ind, LEFT, RIGHT);
			SELF.lic_num_in							:= TRIM(L.lic_num_in, LEFT, RIGHT);
			SELF.lic_type								:= TRIM(Stringlib.StringToUpperCase(L.lic_type), LEFT, RIGHT);
			SELF.lic_status							:= TRIM(Stringlib.StringToUpperCase(L.lic_status), LEFT, RIGHT);
			SELF.lic_begin_date					:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic_begin_date, '-')),LEFT, RIGHT);
			SELF.lic_end_date						:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic_end_date,'-')),LEFT, RIGHT);
			SELF.lic_src_ind						:= TRIM(Stringlib.StringToUpperCase(L.lic_src_ind), LEFT, RIGHT);
			SELF.npi_num								:= TRIM(L.npi_num, LEFT, RIGHT);
			SELF.taxonomy								:= TRIM(L.taxonomy, LEFT, RIGHT);
			SELF.type1									:= TRIM(Stringlib.StringToUpperCase(L.type1), LEFT, RIGHT);
			SELF.classification					:= TRIM(Stringlib.StringToUpperCase(L.classification), LEFT, RIGHT);
			SELF.specialization					:= TRIM(Stringlib.StringToUpperCase(L.specialization), LEFT, RIGHT);
			SELF.medicare_fac_num				:= TRIM(L.medicare_fac_num, LEFT, RIGHT);
			SELF.oig_flag								:= TRIM(Stringlib.StringToUpperCase(L.oig_flag), LEFT, RIGHT);
			SELF.sanc1_date							:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.sanc1_date,'-')),LEFT, RIGHT);
			SELF.sanc1_code							:= TRIM(Stringlib.StringToUpperCase(L.sanc1_code), LEFT, RIGHT);
			SELF.clia_status_code				:= TRIM(Stringlib.StringToUpperCase(L.clia_status_code), LEFT, RIGHT);
			SELF.clia_num				        := TRIM(Stringlib.StringToUpperCase(L.clia_num), LEFT, RIGHT);
			SELF.clia_end_date					:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.clia_end_date,'-')),LEFT, RIGHT);
			SELF.clia_cert_type_code		:= TRIM(Stringlib.StringToUpperCase(L.clia_cert_type_code), LEFT, RIGHT);
			SELF.clia_cert_eff_date			:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.clia_cert_eff_date,'-')),LEFT, RIGHT);
			SELF.ncpdp_id               := TRIM(Stringlib.StringToUpperCase(L.ncpdp_id), LEFT, RIGHT);
			SELF.tin1                   := TRIM(Stringlib.StringToUpperCase(L.tin1), LEFT, RIGHT);
			SELF.clean_last_verify_date	:= (unsigned)_validate.date.fCorrectedDateString((string)SELF.last_verified_date,false);
			SELF.clean_lic_begin_date		:= (unsigned)_validate.date.fCorrectedDateString((string)SELF.lic_begin_date,false);
			SELF.clean_lic_end_date			:= (unsigned)_validate.date.fCorrectedDateString((string)SELF.lic_end_date,false);
			SELF.clean_sanc1_date				:= (unsigned)_validate.date.fCorrectedDateString((string)SELF.sanc1_date,false);
			SELF.clean_dea_num_exp			:= (unsigned)_validate.date.fCorrectedDateString((string)SELF.dea_num_exp,false);
			SELF.clean_phone 						:= if(ut.CleanPhone(L.phone1) [1] not in ['0','1'],ut.CleanPhone(L.phone1), '') ;
			SELF.clean_fax   						:= if(ut.CleanPhone(L.fax1) [1] not in ['0','1'],ut.CleanPhone(L.fax1), '') ;
			SELF.clean_company_name 		:= if(L.prac_company_name<> '', ut.CleanCompany(L.prac_company_name), '');
			SELF.clean_clia_end_date	    := (unsigned)_validate.date.fCorrectedDateString((string)SELF.clia_end_date,false);
			SELF.clean_clia_cert_eff_date	:= (unsigned)_validate.date.fCorrectedDateString((string)SELF.clia_cert_eff_date,false);
			SELF  :=  L;
			SELF  :=  [];
		END;

		dStd := NORMALIZE(baseFile, 2, tMapping(LEFT, counter))(normed_addr_rec_type='P' or Prepped_addr1<>'');

		return dStd;
	END;

	EXPORT Individual	(dataset(Layouts.individual_input) baseFile):=function

		enclarity.layouts.individual_base tMapping(layouts.individual_input L) := TRANSFORM, SKIP((L.group_key = 'group_key')
																																															OR (L.orig_fullname = '' AND
																																																	L.first_name    = '' AND
																																																	L.last_name     = ''))
			SELF.pid                      :=fn_scale_gk(l.group_key);
			SELF.src											:= '64';
			SELF.record_type							:= 'C';
			SELF.Dt_vendor_first_reported	:= (unsigned)filedate;
			SELF.Dt_vendor_last_reported	:= (unsigned)filedate;
			SELF.Dt_first_seen						:= 0;
			SELF.Dt_last_seen							:= 0;

			SELF.group_key							:= TRIM(L.group_key, LEFT, RIGHT);
			SELF.orig_fullname					:= TRIM(Stringlib.StringToUpperCase(L.orig_fullname), LEFT, RIGHT);
			SELF.prefix_name						:= TRIM(Stringlib.StringToUpperCase(L.prefix_name), LEFT, RIGHT);
			SELF.first_name							:= TRIM(Stringlib.StringToUpperCase(L.first_name), LEFT, RIGHT);
			SELF.middle_name						:= TRIM(Stringlib.StringToUpperCase(L.middle_name), LEFT, RIGHT);
			SELF.last_name							:= TRIM(Stringlib.StringToUpperCase(L.last_name), LEFT, RIGHT);
			SELF.suffix_name						:= TRIM(Stringlib.StringToUpperCase(L.suffix_name), LEFT, RIGHT);
			SELF.suffix_other						:= TRIM(Stringlib.StringToUpperCase(L.suffix_other), LEFT, RIGHT);
			SELF.oig_flag								:= TRIM(Stringlib.StringToUpperCase(L.oig_flag), LEFT, RIGHT);
			SELF.opm_flag								:= TRIM(Stringlib.StringToUpperCase(L.opm_flag), LEFT, RIGHT);
			SELF.state_restrict_flag		:= TRIM(Stringlib.StringToUpperCase(L.state_restrict_flag), LEFT, RIGHT);
			SELF.provider_status				:= TRIM(Stringlib.StringToUpperCase(L.provider_status), LEFT, RIGHT);
			SELF.birth_year							:= TRIM(L.birth_year, LEFT, RIGHT);
			SELF.gender									:= TRIM(Stringlib.StringToUpperCase(L.gender), LEFT, RIGHT);
			SELF.upin										:= TRIM(L.upin, LEFT, RIGHT);
			SELF.clean_dob							:= IF(L.birth_year <> '',_validate.date.fCorrectedDateString((string)SELF.birth_year + '0000',false), '');
			SELF  :=  L;
			SELF  :=  [];
		END;

		dStd := PROJECT(baseFile, tMapping(LEFT));

		return dStd;
	END;

	EXPORT Associate	:= FUNCTION
		baseFile	:= Files(filedate,pUseProd).associate_input;
		enclarity.layouts.associate_base tMapping(layouts.associate_input L, integer C) := TRANSFORM, SKIP(L.group_key = 'group_key')
			SELF.pid                      :=fn_scale_gk(l.group_key);
			SELF.src											:= '64';
			SELF.record_type							:= 'C';
			SELF.Dt_vendor_first_reported	:= (unsigned)filedate;
			SELF.Dt_vendor_last_reported	:= (unsigned)filedate;
			SELF.Dt_first_seen						:= 0;
			SELF.Dt_last_seen							:= 0;

			SELF.group_key									:= TRIM(L.group_key, LEFT, RIGHT);
			SELF.prac_addr_confidence_score	:= TRIM(L.prac_addr_confidence_score, LEFT, RIGHT);
			SELF.bill_addr_confidence_score	:= TRIM(L.bill_addr_confidence_score, LEFT, RIGHT);
			SELF.addr_key										:= TRIM(L.addr_key, LEFT, RIGHT);

			SELF.Prepped_addr1            := TRIM(Stringlib.StringToUpperCase(L.address), LEFT, RIGHT);
			SELF.Prepped_addr2            := TRIM(Stringlib.StringToUpperCase(
																								StringLib.StringCleanSpaces(	trim(L.addr_city) + if(L.addr_city <> '',',','')
																		+ ' '+ L.addr_state
																		+ ' '+ L.addr_zip
																		)),left,right);

			SELF.addr_phone									:= TRIM(L.addr_phone, LEFT, RIGHT);
			SELF.sloc_phone									:= TRIM(L.sloc_phone, LEFT, RIGHT);
			SELF.sloc_group_key							:= TRIM(L.sloc_group_key, LEFT, RIGHT);
			SELF.billing_group_key					:= TRIM(L.billing_group_key, LEFT, RIGHT);
			SELF.bill_npi										:= TRIM(L.bill_npi, LEFT, RIGHT);
			SELF.bill_tin										:= TRIM(L.bill_tin, LEFT, RIGHT);
			SELF.cam_latest									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.cam_latest,'-')),LEFT, RIGHT);
			SELF.cam_earliest								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.cam_earliest,'-')),LEFT, RIGHT);
			SELF.pgk_works_for							:= TRIM(Stringlib.StringToUpperCase(L.pgk_works_for), LEFT, RIGHT);
			SELF.pgk_is_affiliated_to				:= TRIM(Stringlib.StringToUpperCase(L.pgk_is_affiliated_to), LEFT, RIGHT);
			SELF.clean_cam_latest						:= (unsigned)_validate.date.fCorrectedDateString((string)SELF.cam_latest,false);
			SELF.clean_cam_earliest					:= (unsigned)_validate.date.fCorrectedDateString((string)SELF.cam_earliest,false);
			SELF.clean_phone 								:= if(ut.CleanPhone(L.addr_phone) [1] not in ['0','1'],ut.CleanPhone(L.addr_phone), '') ;
			SELF.clean_sloc_phone					  := if(ut.CleanPhone(L.sloc_phone) [1] not in ['0','1'],ut.CleanPhone(L.sloc_phone), '') ;

			SELF.Prepped_name							:= Stringlib.StringToUpperCase(
																					CHOOSE(C, L.orig_fullname, L.sloc_bname, L.legal_business_name, L.doing_business_as)
																					);
			SELF.clean_company_name 			:= if(ut.CleanCompany(SELF.prepped_name) <> '', ut.CleanCompany(SELF.prepped_name), datalib.companyclean(SELF.prepped_name));
			SELF.normed_name_rec_type			:= (string)C;//associate file has up to four name fields, 1->orig_fullname, 2->sloc_bname, 3->legal_business_name, 4->doing_business_as

			SELF  :=  L;
			SELF  :=  [];
		END;

		RETURN NORMALIZE(baseFile, 4, tMapping(LEFT, COUNTER))(normed_name_rec_type='1' or Prepped_name<>'');
	END;

	EXPORT Address	:= FUNCTION
		baseFile	:= Files(filedate,pUseProd).address_input;

		enclarity.layouts.address_base tMapping(layouts.address_input L, integer C) := TRANSFORM, SKIP(L.group_key = 'group_key')
			SELF.pid                      :=fn_scale_gk(l.group_key);
			SELF.src											:= '64';
			SELF.record_type							:= 'C';
			SELF.Dt_vendor_first_reported	:= (unsigned)filedate;
			SELF.Dt_vendor_last_reported	:= (unsigned)filedate;
			SELF.Dt_first_seen						:= 0;
			SELF.Dt_last_seen							:= 0;

			SELF.group_key								:= TRIM(L.group_key, LEFT, RIGHT);
			SELF.addr_key									:= TRIM(L.addr_key, LEFT, RIGHT);

			SELF.normed_addr_rec_type     := CHOOSE(C,'P','S');
			SELF.Prepped_addr1            := TRIM(Stringlib.StringToUpperCase(
																							CHOOSE(C
																											,L.addr_primary_address
																											,L.addr_secondary_address
																											)
																						), LEFT, RIGHT);
			SELF.Prepped_addr2            := TRIM(Stringlib.StringToUpperCase(
																								StringLib.StringCleanSpaces(
																					trim(L.addr_city) + if(L.addr_city <> '',',','')
																					+ ' '+ L.addr_state
																					+ ' '+ L.addr_zip
																					)),left,right);

			SELF.prac_addr_ind						:= TRIM(Stringlib.StringToUpperCase(L.prac_addr_ind), LEFT, RIGHT);
			SELF.bill_addr_ind						:= TRIM(Stringlib.StringToUpperCase(L.bill_addr_ind), LEFT, RIGHT);
			SELF.phone1										:= TRIM(L.phone1, LEFT, RIGHT);
			SELF.prac1_phone_ind					:= TRIM(Stringlib.StringToUpperCase(L.prac1_phone_ind), LEFT, RIGHT);
			SELF.bill1_phone_ind					:= TRIM(Stringlib.StringToUpperCase(L.bill1_phone_ind), LEFT, RIGHT);
			SELF.phone1_last_contact_date	:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.phone1_last_contact_date,'-')),LEFT, RIGHT);
			SELF.phone2										:= TRIM(L.phone2, LEFT, RIGHT);
			SELF.prac2_phone_ind					:= TRIM(Stringlib.StringToUpperCase(L.prac2_phone_ind), LEFT, RIGHT);
			SELF.bill2_phone_ind					:= TRIM(Stringlib.StringToUpperCase(L.bill2_phone_ind), LEFT, RIGHT);
			SELF.phone2_last_contact_date	:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.phone2_last_contact_date,'-')),LEFT, RIGHT);
			SELF.phone3										:= TRIM(L.phone3, LEFT, RIGHT);
			SELF.prac3_phone_ind					:= TRIM(Stringlib.StringToUpperCase(L.prac3_phone_ind), LEFT, RIGHT);
			SELF.bill3_phone_ind					:= TRIM(Stringlib.StringToUpperCase(L.bill3_phone_ind), LEFT, RIGHT);
			SELF.phone3_last_contact_date	:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.phone3_last_contact_date,'-')),LEFT, RIGHT);
			SELF.fax1											:= TRIM(L.fax1, LEFT, RIGHT);
			SELF.prac1_fax_ind						:= TRIM(Stringlib.StringToUpperCase(L.prac1_fax_ind), LEFT, RIGHT);
			SELF.bill1_fax_ind						:= TRIM(Stringlib.StringToUpperCase(L.bill1_fax_ind), LEFT, RIGHT);
			SELF.fax2											:= TRIM(L.fax2, LEFT, RIGHT);
			SELF.prac2_fax_ind						:= TRIM(Stringlib.StringToUpperCase(L.prac2_fax_ind), LEFT, RIGHT);
			SELF.bill2_fax_ind						:= TRIM(Stringlib.StringToUpperCase(L.bill2_fax_ind), LEFT, RIGHT);
			SELF.fax3											:= TRIM(L.fax3, LEFT, RIGHT);
			SELF.prac3_fax_ind						:= TRIM(Stringlib.StringToUpperCase(L.prac3_fax_ind), LEFT, RIGHT);
			SELF.bill3_fax_ind						:= TRIM(Stringlib.StringToUpperCase(L.bill3_fax_ind), LEFT, RIGHT);
			SELF.prac_company_name				:= TRIM(Stringlib.StringToUpperCase(L.prac_company_name), LEFT, RIGHT);
			SELF.last_verified_date				:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.last_verified_date,'-')),LEFT, RIGHT);
			SELF.addr_conf_score					:= L.addr_conf_score;
			SELF.addr_rectype							:= TRIM(Stringlib.StringToUpperCase(L.addr_rectype), LEFT, RIGHT);
			SELF.primary_location					:= TRIM(Stringlib.StringToUpperCase(L.primary_location), LEFT, RIGHT);
			SELF.clean_last_verify_date					:= (unsigned)_validate.date.fCorrectedDateString((string)SELF.last_verified_date,false);
			SELF.clean_phone_last_contact_date	:= (unsigned)_validate.date.fCorrectedDateString((string)SELF.phone1_last_contact_date,false);
			SELF.clean_phone							:= if(ut.CleanPhone(L.phone1) [1] not in ['0','1'],ut.CleanPhone(L.phone1), '') ;
			SELF.clean_fax   						  := if(ut.CleanPhone(L.fax1) [1] not in ['0','1'],ut.CleanPhone(L.fax1), '') ;
			SELF.clean_company_name 			:= if(ut.CleanCompany(L.prac_company_name)<> '', ut.CleanCompany(L.prac_company_name), datalib.companyclean(L.prac_company_name));
			SELF  :=  L;
			SELF  :=  [];
		END;

		RETURN NORMALIZE(baseFile, 2, tMapping(LEFT, counter))(normed_addr_rec_type='P' or Prepped_addr1<>'');
	END;

	EXPORT DEA	:= FUNCTION
		baseFile	:= Files(filedate,pUseProd).dea_input;

		enclarity.layouts.dea_base tMapping(layouts.dea_input L, integer C) := TRANSFORM, SKIP(L.group_key = 'group_key')
			SELF.pid                      :=fn_scale_gk(l.group_key);
			SELF.src											:= '64';
			SELF.record_type							:= 'C';
			SELF.Dt_vendor_first_reported	:= (unsigned)filedate;
			SELF.Dt_vendor_last_reported	:= (unsigned)filedate;
			SELF.Dt_first_seen						:= 0;
			SELF.Dt_last_seen							:= 0;

			SELF.group_key								:= TRIM(L.group_key, LEFT, RIGHT);
			SELF.dea_num									:= TRIM(Stringlib.StringToUpperCase(L.dea_num), LEFT, RIGHT);
			SELF.dea_num_exp							:= TRIM(Stringlib.StringToUpperCase(stringlib.stringfilterout(L.dea_num_exp,'-')), LEFT, RIGHT);
			SELF.dea_bus_act_ind					:= TRIM(L.dea_bus_act_ind, LEFT, RIGHT);
			SELF.dea_bus_act_ind_sub			:= TRIM(Stringlib.StringToUpperCase(L.dea_bus_act_ind_sub), LEFT, RIGHT);
			SELF.dea_drug_schedule				:= TRIM(Stringlib.StringToUpperCase(L.dea_drug_schedule), LEFT, RIGHT);
			SELF.dea_num_deact_date				:= TRIM(Stringlib.StringToUpperCase(stringlib.stringfilterout(L.dea_num_deact_date,'-')), LEFT, RIGHT);
			SELF.addr_key									:= TRIM(L.addr_key, LEFT, RIGHT);

			SELF.normed_addr_rec_type     := CHOOSE(C,'P','S');
			SELF.Prepped_addr1            := TRIM(Stringlib.StringToUpperCase(
																							CHOOSE(C
																											,L.addr_primary_address
																											,L.addr_secondary_address
																											)
																						), LEFT, RIGHT);
			SELF.Prepped_addr2            := TRIM(Stringlib.StringToUpperCase(
																							StringLib.StringCleanSpaces(
																		trim(L.addr_city) + if(L.addr_city <> '',',','')
																		+ ' '+ L.addr_state
																		+ ' '+ L.addr_zip
																		)),left,right);

			SELF.clean_dea_num_exp				:= _validate.date.fCorrectedDateString((string)SELF.dea_num_exp,false);
			SELF.clean_dea_num_deact_date	:= _validate.date.fCorrectedDateString((string)SELF.dea_num_deact_date,false);
			SELF  :=  L;
			SELF  :=  [];
		END;

		RETURN NORMALIZE(baseFile, 2, tMapping(LEFT, counter))(normed_addr_rec_type='P' or Prepped_addr1<>'');
	END;

	EXPORT License	:= FUNCTION
		baseFile	:= Files(filedate,pUseProd).license_input;

		enclarity.layouts.license_base tMapping(layouts.license_input L, integer C) := TRANSFORM, SKIP(L.group_key = 'group_key')
			SELF.pid                      :=fn_scale_gk(l.group_key);
			SELF.src											:= '64';
			SELF.record_type							:= 'C';
			SELF.Dt_vendor_first_reported	:= (unsigned)filedate;
			SELF.Dt_vendor_last_reported	:= (unsigned)filedate;
			SELF.Dt_first_seen						:= 0;
			SELF.Dt_last_seen							:= 0;

			SELF.group_key							:= TRIM(L.group_key, LEFT, RIGHT);
			SELF.orig_fullname					:= TRIM(Stringlib.StringToUpperCase(L.orig_fullname), LEFT, RIGHT);
			SELF.prefix_name						:= TRIM(Stringlib.StringToUpperCase(L.prefix_name), LEFT, RIGHT);
			SELF.first_name							:= TRIM(Stringlib.StringToUpperCase(L.first_name), LEFT, RIGHT);
			SELF.middle_name						:= TRIM(Stringlib.StringToUpperCase(L.middle_name), LEFT, RIGHT);
			SELF.last_name							:= TRIM(Stringlib.StringToUpperCase(L.last_name), LEFT, RIGHT);
			SELF.suffix_name						:= TRIM(Stringlib.StringToUpperCase(L.suffix_name), LEFT, RIGHT);
			SELF.suffix_other						:= TRIM(Stringlib.StringToUpperCase(L.suffix_other), LEFT, RIGHT);
			SELF.lic_num_in							:= TRIM(L.lic_num_in, LEFT, RIGHT);
			SELF.lic_state							:= TRIM(Stringlib.StringToUpperCase(L.lic_state), LEFT, RIGHT);
			SELF.lic_num								:= TRIM(L.lic_num, LEFT, RIGHT);
			SELF.lic_type								:= TRIM(Stringlib.StringToUpperCase(L.lic_type), LEFT, RIGHT);
			SELF.lic_status							:= TRIM(Stringlib.StringToUpperCase(L.lic_status), LEFT, RIGHT);
			SELF.lic_begin_date					:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic_begin_date, '-')),LEFT, RIGHT);
			SELF.lic_end_date						:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic_end_date,'-')),LEFT, RIGHT);
			SELF.addr_key								:= TRIM(L.addr_key, LEFT, RIGHT);

			SELF.normed_addr_rec_type     := CHOOSE(C,'P','S');
			SELF.Prepped_addr1            := TRIM(Stringlib.StringToUpperCase(
																							CHOOSE(C
																											,L.addr_primary_address
																											,L.addr_secondary_address
																											)
																						), LEFT, RIGHT);
			SELF.Prepped_addr2            := TRIM(Stringlib.StringToUpperCase(
																								StringLib.StringCleanSpaces(
																			trim(L.addr_city) + if(L.addr_city <> '',',','')
																		+ ' '+ L.addr_state
																		+ ' '+ L.addr_zip
																		)),left,right);

			SELF.clean_lic_begin_date		:= _validate.date.fCorrectedDateString((string)SELF.lic_begin_date,false);
			SELF.clean_lic_end_date			:= _validate.date.fCorrectedDateString((string)SELF.lic_end_date,false);
			SELF  :=  L;
			SELF  :=  [];
		END;

		RETURN NORMALIZE(baseFile, 2, tMapping(LEFT, counter))(normed_addr_rec_type='P' or Prepped_addr1<>'');
	END;

	EXPORT Taxonomy	:= FUNCTION
		baseFile	:= Files(filedate,pUseProd).taxonomy_input;

		enclarity.layouts.taxonomy_base tMapping(layouts.taxonomy_input L) := TRANSFORM, SKIP(L.group_key = 'group_key')
			SELF.src											:= '64';
			SELF.record_type							:= 'C';
			SELF.Dt_vendor_first_reported	:= (unsigned)filedate;
			SELF.Dt_vendor_last_reported	:= (unsigned)filedate;
			SELF.Dt_first_seen						:= 0;
			SELF.Dt_last_seen							:= 0;

			SELF.group_key							:= TRIM(L.group_key, LEFT, RIGHT);
			SELF.taxonomy								:= TRIM(L.taxonomy, LEFT, RIGHT);
			SELF.type1									:= TRIM(Stringlib.StringToUpperCase(L.type1), LEFT, RIGHT);
			SELF.classification					:= TRIM(Stringlib.StringToUpperCase(L.classification), LEFT, RIGHT);
			SELF.specialization					:= TRIM(Stringlib.StringToUpperCase(L.specialization), LEFT, RIGHT);
			SELF  :=  L;
			SELF  :=  [];
		END;

		RETURN PROJECT(baseFile, tMapping(LEFT));
	END;

	EXPORT NPI	:= FUNCTION
		baseFile	:= Files(filedate,pUseProd).npi_input;

		enclarity.layouts.npi_base tMapping(layouts.npi_input L, integer C) := TRANSFORM, SKIP(L.group_key = 'group_key')
			SELF.pid                      :=fn_scale_gk(l.group_key);
			SELF.src											:= '64';
			SELF.record_type							:= 'C';
			SELF.Dt_vendor_first_reported	:= (unsigned)filedate;
			SELF.Dt_vendor_last_reported	:= (unsigned)filedate;
			SELF.Dt_first_seen						:= 0;
			SELF.Dt_last_seen							:= 0;

			SELF.group_key								:= TRIM(L.group_key, LEFT, RIGHT);
			SELF.npi_num									:= TRIM(Stringlib.StringToUpperCase(L.npi_num), LEFT, RIGHT);
			SELF.taxonomy									:= TRIM(Stringlib.StringToUpperCase(L.taxonomy), LEFT, RIGHT);
			SELF.type1										:= TRIM(Stringlib.StringToUpperCase(L.type1), LEFT, RIGHT);
			SELF.classification						:= TRIM(Stringlib.StringToUpperCase(L.classification), LEFT, RIGHT);
			SELF.specialization						:= TRIM(Stringlib.StringToUpperCase(L.specialization), LEFT, RIGHT);
			SELF.taxonomy_primary_ind			:= TRIM(Stringlib.StringToUpperCase(L.taxonomy_primary_ind), LEFT, RIGHT);
			SELF.last_name								:= TRIM(Stringlib.StringToUpperCase(L.last_name), LEFT, RIGHT);
			SELF.first_name								:= TRIM(Stringlib.StringToUpperCase(L.first_name), LEFT, RIGHT);
			SELF.middle_name							:= TRIM(Stringlib.StringToUpperCase(L.middle_name), LEFT, RIGHT);
			SELF.other_last_name					:= TRIM(Stringlib.StringToUpperCase(L.other_last_name), LEFT, RIGHT);
			SELF.other_first_name					:= TRIM(Stringlib.StringToUpperCase(L.other_first_name), LEFT, RIGHT);
			SELF.other_middle_name				:= TRIM(Stringlib.StringToUpperCase(L.other_middle_name), LEFT, RIGHT);
			SELF.other_name_type					:= TRIM(Stringlib.StringToUpperCase(L.other_name_type), LEFT, RIGHT);
			SELF.company_name							:= TRIM(Stringlib.StringToUpperCase(L.company_name), LEFT, RIGHT);
			SELF.other_company_name				:= TRIM(Stringlib.StringToUpperCase(L.other_company_name), LEFT, RIGHT);
			SELF.other_company_name_type	:= TRIM(Stringlib.StringToUpperCase(L.other_company_name_type), LEFT, RIGHT);
			SELF.parent_organization_name	:= TRIM(Stringlib.StringToUpperCase(L.parent_organization_name), LEFT, RIGHT);
			SELF.addr_key									:= TRIM(L.addr_key, LEFT, RIGHT);

			SELF.normed_addr_rec_type     := CHOOSE(C,'P','S');
			SELF.Prepped_addr1            := TRIM(Stringlib.StringToUpperCase(
																							CHOOSE(C
																											,L.addr_primary_address
																											,L.addr_secondary_address
																											)
																						), LEFT, RIGHT);
			SELF.Prepped_addr2            := TRIM(Stringlib.StringToUpperCase(
																							StringLib.StringCleanSpaces(
																			trim(L.addr_city) + if(L.addr_city <> '',',','')
																		+ ' '+ L.addr_state
																		+ ' '+ L.addr_zip
																		)),left,right);

			SELF.phone1										:= TRIM(L.phone1, LEFT, RIGHT);
			SELF.npi_type									:= TRIM(Stringlib.StringToUpperCase(L.npi_type), LEFT, RIGHT);
			SELF.npi_sole_proprietor			:= TRIM(Stringlib.StringToUpperCase(L.npi_sole_proprietor), LEFT, RIGHT);
			SELF.clean_phone							:= if(ut.CleanPhone(L.phone1) [1] not in ['0','1'],ut.CleanPhone(L.phone1), '') ;
			SELF.npi_deact_date						:= TRIM(Stringlib.StringToUpperCase(stringlib.stringfilterout(L.npi_deact_date,'-')), LEFT, RIGHT);
			SELF.clean_npi_deact_date			:= _validate.date.fCorrectedDateString((string)SELF.npi_deact_date,false);
					 npi_enum_date            := TRIM(Stringlib.StringToUpperCase(stringlib.stringfilterout(L.npi_enum_date, '/')), LEFT, RIGHT);
			SELF.npi_enum_date						:= npi_enum_date[5..8]+npi_enum_date[1..2]+npi_enum_date[3..4];
			SELF.clean_npi_enum_date			:= _validate.date.fCorrectedDateString((string)SELF.npi_enum_date,false);
			SELF  :=  L;
			SELF  :=  [];
		END;

		RETURN NORMALIZE(baseFile, 2, tMapping(LEFT, counter))(normed_addr_rec_type='P' or Prepped_addr1<>'');
	END;

	EXPORT Medschool	:= FUNCTION
		baseFile	:= Files(filedate,pUseProd).medschool_input;

		enclarity.layouts.medschool_base tMapping(enclarity.layouts.medschool_input L) := TRANSFORM, SKIP(L.group_key = 'group_key')
			SELF.pid                      :=fn_scale_gk(l.group_key);
			SELF.src											:= '64';
			SELF.record_type							:= 'C';
			SELF.Dt_vendor_first_reported	:= (unsigned)filedate;
			SELF.Dt_vendor_last_reported	:= (unsigned)filedate;
			SELF.Dt_first_seen						:= 0;
			SELF.Dt_last_seen							:= 0;

			SELF.group_key							:= TRIM(L.group_key, LEFT, RIGHT);
			SELF.medschool							:= TRIM(Stringlib.StringToUpperCase(L.medschool), LEFT, RIGHT);
			SELF.medschool_year					:= TRIM(L.medschool_year, LEFT, RIGHT);
			SELF  :=  L;
			SELF  :=  [];
		END;

		RETURN PROJECT(baseFile, tMapping(LEFT));
	END;

	EXPORT Tax_codes	:= FUNCTION
		baseFile	:= Files(filedate,pUseProd).tax_codes_input;

		enclarity.layouts.tax_codes_base tMapping(enclarity.layouts.tax_codes_input L) := TRANSFORM
			SELF.src											:= '64';
			SELF.record_type							:= 'C';
			SELF.Dt_vendor_first_reported	:= (unsigned)filedate;
			SELF.Dt_vendor_last_reported	:= (unsigned)filedate;
			SELF.Dt_first_seen						:= 0;
			SELF.Dt_last_seen							:= 0;

			SELF.taxonomy								:= TRIM(L.taxonomy, LEFT, RIGHT);
			SELF.type1									:= TRIM(Stringlib.StringToUpperCase(L.type1), LEFT, RIGHT);
			SELF.classification					:= TRIM(Stringlib.StringToUpperCase(L.classification), LEFT, RIGHT);
			SELF.specialization					:= TRIM(Stringlib.StringToUpperCase(L.specialization), LEFT, RIGHT);
			SELF.effect_date						:= ut.ConvertDate(L.effect_date);
			SELF.deact_date							:= ut.ConvertDate(L.deact_date);
			SELF.last_mod_date					:= ut.ConvertDate(L.last_mod_date);
			SELF.clean_effect_date			:= _validate.date.fCorrectedDateString((string)SELF.effect_date,false);
			SELF.clean_deact_date				:= _validate.date.fCorrectedDateString((string)SELF.deact_date,false);
			SELF.clean_last_mod_date		:= _validate.date.fCorrectedDateString((string)SELF.last_mod_date,false);
			SELF  :=  L;
			SELF  :=  [];
		END;

		RETURN PROJECT(baseFile, tMapping(LEFT));
	END;

	EXPORT Prov_ssn	:= FUNCTION
		baseFile	:= Files(filedate,pUseProd).prov_ssn_input;

		enclarity.layouts.prov_ssn_base tMapping(enclarity.layouts.prov_ssn_input L) := TRANSFORM, SKIP(L.group_key = 'group_key')
			SELF.pid                      :=fn_scale_gk(l.group_key);
			SELF.src											:= '64';
			SELF.record_type							:= 'C';
			SELF.Dt_vendor_first_reported	:= (unsigned)filedate;
			SELF.Dt_vendor_last_reported	:= (unsigned)filedate;
			SELF.Dt_first_seen						:= 0;
			SELF.Dt_last_seen							:= 0;

			SELF.group_key							:= TRIM(L.group_key, LEFT, RIGHT);
			SELF.ssn										:= if(length(regexreplace('[^0-9]',l.SSN,''))=9,l.SSN,'');
			SELF.clean_ssn              := if((unsigned)SELF.SSN > 0,if(SELF.SSN in ut.Set_BadSSN ,'',SELF.SSN), '');
			SELF  :=  L;
			SELF  :=  [];
		END;

		RETURN PROJECT(baseFile, tMapping(LEFT));
	END;

	EXPORT Specialty:= FUNCTION
		baseFile	:= Files(filedate,pUseProd).specialty_input;

		enclarity.layouts.specialty_base tMapping(layouts.specialty_input L) := TRANSFORM, SKIP(L.group_key = 'group_key')
			SELF.pid                      :=fn_scale_gk(l.group_key);
			SELF.src											:= '64';
			SELF.record_type							:= 'C';
			SELF.Dt_vendor_first_reported	:= (unsigned)filedate;
			SELF.Dt_vendor_last_reported	:= (unsigned)filedate;
			SELF.Dt_first_seen						:= 0;
			SELF.Dt_last_seen							:= 0;

			SELF.group_key							:= TRIM(L.group_key, LEFT, RIGHT);
			SELF.spec_code							:= TRIM(L.spec_code, LEFT, RIGHT);
			SELF.spec_desc							:= TRIM(Stringlib.StringToUpperCase(L.spec_desc), LEFT, RIGHT);
			SELF  :=  L;
			SELF  :=  [];
		END;

		RETURN PROJECT(baseFile, tMapping(LEFT));
	END;

	EXPORT Sanc_prov_type:= FUNCTION
		baseFile	:= Files(filedate,pUseProd).sanc_prov_type_input;

		enclarity.layouts.sanc_prov_type_base tMapping(enclarity.layouts.sanc_prov_type_input L) := TRANSFORM
			SELF.src											:= '64';
			SELF.record_type							:= 'C';
			SELF.Dt_vendor_first_reported	:= (unsigned)filedate;
			SELF.Dt_vendor_last_reported	:= (unsigned)filedate;
			SELF.Dt_first_seen						:= 0;
			SELF.Dt_last_seen							:= 0;

			SELF.prov_type_code					:= TRIM(L.prov_type_code, LEFT, RIGHT);
			SELF.prov_type_desc					:= TRIM(Stringlib.StringToUpperCase(L.prov_type_desc), LEFT, RIGHT);
			SELF  :=  L;
			SELF  :=  [];
		END;

		tempBase	:= PROJECT(baseFile, tMapping(LEFT));
		newBase		:= table(tempBase,{tempBase, cnt := count(group)}, prov_type_code, few) (cnt = 1); //do not accept ANY duplications
		RETURN project(newBase,enclarity.Layouts.sanc_prov_type_base);
	END;

	EXPORT Sanc_codes:= FUNCTION
		baseFile	:= Files(filedate,pUseProd).sanc_codes_input;

		enclarity.layouts.sanc_codes_base tMapping(enclarity.layouts.sanc_codes_input L) := TRANSFORM
			SELF.src											:= '64';
			SELF.record_type							:= 'C';
			SELF.Dt_vendor_first_reported	:= (unsigned)filedate;
			SELF.Dt_vendor_last_reported	:= (unsigned)filedate;
			SELF.Dt_first_seen						:= 0;
			SELF.Dt_last_seen							:= 0;

			SELF.sanc_code							:= TRIM(Stringlib.StringToUpperCase(L.sanc_code), LEFT, RIGHT);
			SELF.sanc_desc							:= TRIM(Stringlib.StringToUpperCase(L.sanc_desc), LEFT, RIGHT);
			SELF  :=  L;
			SELF  :=  [];
		END;

		tempBase	:= PROJECT(baseFile, tMapping(LEFT));
		newBase		:= table(tempBase,{tempBase, cnt := count(group)}, sanc_code, few) (cnt = 1); //do not accept ANY duplications
		RETURN project(newBase, enclarity.Layouts.sanc_codes_base);

	END;

	EXPORT Prov_birthdate	:= FUNCTION
		baseFile	:= Files(filedate,pUseProd).prov_birthdate_input;

		enclarity.layouts.prov_birthdate_base tMapping(layouts.prov_birthdate_input L) := TRANSFORM, SKIP(L.group_key = 'group_key')
			SELF.pid                      :=fn_scale_gk(l.group_key);
			SELF.src											:= '64';
			SELF.record_type							:= 'C';
			SELF.Dt_vendor_first_reported	:= (unsigned)filedate;
			SELF.Dt_vendor_last_reported	:= (unsigned)filedate;
			SELF.Dt_first_seen						:= 0;
			SELF.Dt_last_seen							:= 0;

			SELF.group_key							:= TRIM(L.group_key, LEFT, RIGHT);
			SELF.date_of_birth					:= TRIM(L.date_of_birth, LEFT, RIGHT);
			SELF.clean_date_of_birth		:= _validate.date.fCorrectedDateString((string)SELF.date_of_birth,false);
			SELF  :=  L;
			SELF  :=  [];
		END;

		RETURN PROJECT(baseFile, tMapping(LEFT));
	END;

	EXPORT Sanction	:= FUNCTION
		baseFile	:= Files(filedate,pUseProd).sanction_input;

		STRING fGetSancDesc(STRING SancDescIn)	:=		MAP(SancDescIn = 'Letter or Reprimand  And or Reprimand with other r' =>
																											'Letter or Reprimand with other restrictions'
																									,SancDescIn = 'License Reinstatements/Removal of License Restrict' =>
																											'License Reinstatements/Removal of Lic Restrictions'
																									,SancDescIn = 'License Revocation/Susptension/Surrender/Terminatio' =>
																											'License Revocation/Susp/Surrender/Term/Inactive'
																									,SancDescIn <> '' => SancDescIn
																									,'');

		enclarity.layouts.sanction_base tMapping(Layouts.sanction_input L) := TRANSFORM, SKIP(L.group_key = 'group_key')
			SELF.pid                      :=fn_scale_gk(l.group_key);
			SELF.src											:= '64';
			SELF.record_type							:= 'C';
			SELF.Dt_vendor_first_reported	:= (unsigned)filedate;
			SELF.Dt_vendor_last_reported	:= (unsigned)filedate;
			SELF.Dt_first_seen						:= 0;
			SELF.Dt_last_seen							:= 0;

			SELF.group_key							:= TRIM(L.group_key, LEFT, RIGHT);
			SELF.sanc1_date							:= TRIM(Stringlib.StringToUpperCase(stringlib.stringfilterout(L.sanc1_date,'-')), LEFT, RIGHT);
			SELF.sanc1_code							:= TRIM(Stringlib.StringToUpperCase(L.sanc1_code), LEFT, RIGHT);
			SELF.sanc1_state						:= TRIM(Stringlib.StringToUpperCase(L.sanc1_state), LEFT, RIGHT);
			SELF.sanc1_lic_num					:= TRIM(Stringlib.StringToUpperCase(L.sanc1_lic_num), LEFT, RIGHT);
			SELF.sanc1_prof_type				:= TRIM(Stringlib.StringToUpperCase(L.sanc1_prof_type), LEFT, RIGHT);
			SELF.sanc1_rein_date				:= TRIM(Stringlib.StringToUpperCase(stringlib.stringfilterout(L.sanc1_rein_date, '-')), LEFT, RIGHT);
			SELF.clean_sanc1_date				:= _validate.date.fCorrectedDateString((string)SELF.sanc1_date,false);
			SELF.clean_sanc1_rein_date	:= _validate.date.fCorrectedDateString((string)SELF.sanc1_rein_date,false);
			SELF.Enc_derived_rein_flag	:= TRIM(L.Enc_derived_rein_flag, LEFT, RIGHT);
			SELF.Enc_derived_rein_date 	:= IF(L.Enc_derived_rein_flag = 'Y', SELF.clean_sanc1_rein_date, '0');
			temp_sanc1_desc							:= TRIM(L.sanc1_desc, LEFT, RIGHT);
			SELF.sanc1_desc							:= Stringlib.StringToUpperCase(fGetSancDesc(temp_sanc1_desc));
			SELF  :=  L;
			SELF  :=  [];
		END;

		newBase	:= PROJECT(baseFile, tMapping(LEFT));

		RETURN newBase;
	END;

	EXPORT Collapse	:= FUNCTION
		baseFile	:= Files(filedate,pUseProd).Collapse_input;

		enclarity.layouts.Collapse_base tMapping(layouts.Collapse_input L) := TRANSFORM
			SELF  :=  L;
		END;

		RETURN PROJECT(baseFile, tMapping(LEFT));
	END;

	EXPORT Split	:= FUNCTION
		baseFile	:= Files(filedate,pUseProd).Split_input;

		enclarity.layouts.Split_base tMapping(layouts.Split_input L) := TRANSFORM
			SELF  :=  L;
		END;

		RETURN PROJECT(baseFile, tMapping(LEFT));
	END;

	EXPORT Drop	:= FUNCTION
		baseFile	:= Files(filedate,pUseProd).Drop_input;

		enclarity.layouts.Drop_base tMapping(layouts.Drop_input L) := TRANSFORM, SKIP(L.group_key = 'group_key')
			SELF  :=  L;
		END;

		RETURN PROJECT(baseFile, tMapping(LEFT));
	END;

END;
