IMPORT  ut, _validate, lib_stringlib, HMS;

EXPORT StandardizeInputFile (string filedate, boolean pUseProd = false):= MODULE

	EXPORT msrc := 'S8';
	EXPORT invalid_dates:=['','0000-00-00','\\N'];

	SHARED fn_scale_gk(string gk) := function
		unsigned6 max_pid := 281474976710655;  //max unsigned6
		new_gk
			:=
				(unsigned6)
					((unsigned8)( hash64(hashmd5(gk)) ) % max_pid)
				;
		return new_gk;
	end;


	EXPORT Individual := FUNCTION
		baseFile	:= HMS.Files(filedate,pUseProd).individual;

		HMS.layouts.individual_base tMapping(layouts.individual_in L) := TRANSFORM, SKIP(L.hms_piid = 'hms_piid')
			SELF.pid                            := fn_scale_gk(L.hms_piid);
			SELF.src    												:= msrc;
			SELF.date_vendor_first_reported     := (unsigned)filedate;
			SELF.date_vendor_last_reported      := (unsigned)filedate;
			SELF.date_first_seen                := 0;
			SELF.date_last_seen                 := 0;

			SELF.first													:= TRIM(Stringlib.StringToUpperCase(L.first), LEFT, RIGHT);
			SELF.middle													:= TRIM(Stringlib.StringToUpperCase(L.middle), LEFT, RIGHT);
			SELF.last													:= TRIM(Stringlib.StringToUpperCase(L.last), LEFT, RIGHT);

			SELF.clean_npi_enumeration_date     := if(L.npi_enumeration_date not in invalid_dates,_validate.date.fCorrectedDateString((string)trim(stringlib.stringfilterout(L.npi_enumeration_date,'-.>$!%*@=?&\''),left,right),false),'0');
			SELF.clean_npi_deactivation_date    := if(L.npi_deactivation_date not in invalid_dates,_validate.date.fCorrectedDateString((string)trim(stringlib.stringfilterout(L.npi_deactivation_date,'-.>$!%*@=?&\''),left,right),false),'0');
			SELF.clean_npi_reactivation_date    := if(L.npi_enumeration_date not in invalid_dates,_validate.date.fCorrectedDateString((string)trim(stringlib.stringfilterout(L.npi_enumeration_date,'-.>$!%*@=?&\''),left,right),false),'0');
			SELF.clean_date_born     						:= if(L.date_born not in invalid_dates,_validate.date.fCorrectedDateString((string)trim(stringlib.stringfilterout(L.date_born,'-.>$!%*@=?&\''),left,right),false),'0');
			SELF.clean_date_died     						:= if(L.date_died not in invalid_dates,_validate.date.fCorrectedDateString((string)trim(stringlib.stringfilterout(L.date_died,'-.>$!%*@=?&\''),left,right),false),'0');

			SELF.clean_dob                      := if(L.date_born not in invalid_dates,_validate.date.fCorrectedDateString((string)trim(stringlib.stringfilterout(L.date_born,'-.>$!%*@=?&\''),left,right),false),'0');
			SELF.record_type										:= 'C';
			SELF  															:=  L;
			SELF 																:= [];
		END;

		dStd := PROJECT(baseFile, tMapping(LEFT));

		return dStd;
	END;

	EXPORT Address	:= FUNCTION
		baseFile	:= Files(filedate,pUseProd).individual_addresses;

		/*==================================
    |  Remove addresses that have no spaces.  These are bad addresses coming from HMS
		+===================================*/

		hasspace := REGEXFIND('\\s', TRIM(baseFile.address1));

		badAddresses := baseFile(hasspace=FALSE);
		goodAddresses := baseFile(hasspace=TRUE);

		HMS.layouts.individual_addresses_base tMapping(layouts.individual_addresses_in L) := TRANSFORM, SKIP(L.hms_piid = 'hms_piid')
			SELF.pid                            := fn_scale_gk(L.hms_piid);
			SELF.src    												:= msrc;

			SELF.date_vendor_first_reported     := (unsigned)filedate;
			SELF.date_vendor_last_reported      := (unsigned)filedate;
			SELF.date_first_seen                := 0;
			SELF.date_last_seen                 := 0;

			SELF.prepped_addr1      := TRIM(StringLib.StringCleanSpaces(Stringlib.StringToUpperCase(
																	TRIM(L.address1) + ' ' + TRIM(L.address2)
																	)));

			SELF.prepped_addr2      := TRIM(StringLib.StringCleanSpaces(
																		TRIM(L.city) + if(L.city <> '',',','')
																		+ ' ' + L.state
																		+ ' ' + L.ADDR_zip
																	));
			SELF.clean_company_name 		:= if(L.firm_name<> '', ut.CleanCompany(L.firm_name), '');

			SELF.type								:= L.type;

			SELF.record_type				:= 'C';
			SELF  									:=  L;
			SELF 										:= [];
		END;

		return PROJECT(baseFile, tMapping(LEFT));
	END;

	EXPORT DEA	:= FUNCTION
		baseFile	:= Files(filedate,pUseProd).individual_dea;

		HMS.layouts.individual_dea_base tMapping(layouts.individual_dea_in L) := TRANSFORM, SKIP(L.hms_piid = 'hms_piid')
			SELF.pid                            := fn_scale_gk(L.hms_piid);
			SELF.src    												:= msrc;

			SELF.date_vendor_first_reported     := (unsigned)filedate;
			SELF.date_vendor_last_reported      := (unsigned)filedate;
			SELF.date_first_seen                := 0;
			SELF.date_last_seen                 := 0;

			SELF.hms_piid			:= TRIM(L.hms_piid, LEFT, RIGHT);
			SELF.dea_num			:= TRIM(Stringlib.StringToUpperCase(L.dea_num), LEFT, RIGHT);
			SELF.dea_bac			:= TRIM(Stringlib.StringToUpperCase(L.dea_bac), LEFT, RIGHT);
			SELF.dea_expire		:= TRIM(Stringlib.StringToUpperCase(stringlib.stringfilterout(L.dea_expire,'-')), LEFT, RIGHT);

			SELF.clean_dea_expire		:= _validate.date.fCorrectedDateString((string)SELF.dea_expire,false);

			SELF.record_type										:= 'C';
			SELF  :=  L;
			SELF  :=  [];
		END;

		RETURN NORMALIZE(baseFile, 2, tMapping(LEFT));
	END;

	EXPORT Sanction	:= FUNCTION
		baseFile	:= Files(filedate,pUseProd).individual_sanctions;

		HMS.layouts.individual_sanctions_base tMapping(Layouts.individual_sanctions_in L) := TRANSFORM, SKIP(L.hms_piid = 'hms_piid')
			SELF.pid                            := fn_scale_gk(L.hms_piid);
			SELF.src    													:= msrc;

			SELF.date_vendor_first_reported     	:= (unsigned)filedate;
			SELF.date_vendor_last_reported      	:= (unsigned)filedate;
			SELF.date_first_seen                	:= 0;
			SELF.date_last_seen                 	:= 0;

			SELF.clean_offense_date								:= TRIM(Stringlib.StringToUpperCase(stringlib.stringfilterout(L.offense_date, '-')), LEFT, RIGHT);
			SELF.clean_action_date								:= TRIM(Stringlib.StringToUpperCase(stringlib.stringfilterout(L.action_date, '-')), LEFT, RIGHT);
			SELF.clean_sanction_period_start_date	:= TRIM(Stringlib.StringToUpperCase(stringlib.stringfilterout(L.sanction_period_start_date, '-')), LEFT, RIGHT);
			SELF.clean_sanction_period_end_date		:= TRIM(Stringlib.StringToUpperCase(stringlib.stringfilterout(L.sanction_period_end_date, '-')), LEFT, RIGHT);

			SELF.record_type										:= 'C';
			SELF  :=  L;
			SELF  :=  [];
		END;

		RETURN PROJECT(baseFile, tMapping(LEFT));
	END;

	EXPORT GSA_Sanctions	:= FUNCTION
		baseFile	:= Files(filedate,pUseProd).individual_gsa_sanctions;

		HMS.layouts.individual_gsa_sanctions_base tMapping(Layouts.individual_gsa_sanctions_in L) := TRANSFORM, SKIP(L.hms_piid = 'hms_piid')
			SELF.pid                            := fn_scale_gk(L.hms_piid);
			SELF.src    													:= msrc;

			SELF.date_vendor_first_reported     	:= (unsigned)filedate;
			SELF.date_vendor_last_reported      	:= (unsigned)filedate;
			SELF.date_first_seen                	:= 0;
			SELF.date_last_seen                 	:= 0;

			SELF.gsa_first					:= TRIM(Stringlib.StringToUpperCase(L.gsa_first), LEFT, RIGHT);
			SELF.gsa_middle					:= TRIM(Stringlib.StringToUpperCase(L.gsa_middle), LEFT, RIGHT);
			SELF.gsa_last						:= TRIM(Stringlib.StringToUpperCase(L.gsa_last), LEFT, RIGHT);
			SELF.gsa_suffix					:= TRIM(Stringlib.StringToUpperCase(L.gsa_suffix), LEFT, RIGHT);
			SELF.gsa_city						:= TRIM(Stringlib.StringToUpperCase(L.gsa_city), LEFT, RIGHT);
			SELF.gsa_state					:= TRIM(Stringlib.StringToUpperCase(L.gsa_state), LEFT, RIGHT);
			SELF.clean_action_date	:= L.action_date[7..10]+L.action_date[1..2]+L.action_date[4..5];
			SELF.clean_date					:= TRIM(Stringlib.StringToUpperCase(L.date), LEFT, RIGHT);
			SELF.agency							:= TRIM(Stringlib.StringToUpperCase(L.agency), LEFT, RIGHT);

			SELF.record_type										:= 'C';
			SELF  :=  L;
			SELF  :=  [];

		END;

		RETURN PROJECT(baseFile, tMapping(LEFT));
	END;

	EXPORT State_CSR	:= FUNCTION
		baseFile	:= Files(filedate,pUseProd).individual_state_csr;

		HMS.layouts.individual_state_csr_base tMapping(Layouts.individual_state_csr_in L) := TRANSFORM, SKIP(L.hms_piid = 'hms_piid')
			SELF.pid                              := fn_scale_gk(L.hms_piid);
			SELF.src    													:= msrc;

			SELF.date_vendor_first_reported     	:= (unsigned)filedate;
			SELF.date_vendor_last_reported      	:= (unsigned)filedate;
			SELF.date_first_seen                	:= 0;
			SELF.date_last_seen                 	:= 0;

			SELF.csr_state												:= TRIM(Stringlib.StringToUpperCase(L.csr_state), LEFT, RIGHT);
			SELF.clean_csr_expire_date						:= TRIM(Stringlib.StringToUpperCase(stringlib.stringfilterout(L.csr_expire_date, '-')), LEFT, RIGHT);
			SELF.clean_csr_issue_date							:= TRIM(Stringlib.StringToUpperCase(stringlib.stringfilterout(L.csr_issue_date, '-')), LEFT, RIGHT);

			SELF.record_type	  									:= 'C';
			SELF  :=  L;
			SELF  :=  [];
		END;

		RETURN PROJECT(baseFile, tMapping(LEFT));
	END;

	EXPORT State_Licenses	:= FUNCTION
		baseFile	:= Files(filedate,pUseProd).individual_state_licenses;

		HMS.layouts.individual_state_licenses_base tMapping(Layouts.individual_state_licenses_in L) := TRANSFORM, SKIP(L.hms_piid = 'hms_piid')
			SELF.src    													:= msrc;

			SELF.date_vendor_first_reported     	:= (unsigned)filedate;
			SELF.date_vendor_last_reported      	:= (unsigned)filedate;
			SELF.date_first_seen                	:= 0;
			SELF.date_last_seen                 	:= 0;

			SELF.clean_state_license_expire				:= TRIM(Stringlib.StringToUpperCase(stringlib.stringfilterout(L.state_license_expire, '-')), LEFT, RIGHT);
			SELF.clean_state_license_issued				:= TRIM(Stringlib.StringToUpperCase(stringlib.stringfilterout(L.state_license_issued, '-')), LEFT, RIGHT);

			SELF.record_type						  				:= 'C';
			SELF  :=  L;
			SELF  :=  [];
		END;

		RETURN PROJECT(baseFile, tMapping(LEFT));
	END;

	EXPORT State_License_Types := FUNCTION
		baseFile	:= Files(filedate,pUseProd).state_license_types;

		HMS.layouts.state_license_types_base tMapping(Layouts.state_license_types_in L) := TRANSFORM
			SELF.src    													:= msrc;

			SELF.date_vendor_first_reported     	:= (unsigned)filedate;
			SELF.date_vendor_last_reported      	:= (unsigned)filedate;
			SELF.date_first_seen                	:= 0;
			SELF.date_last_seen                 	:= 0;

			SELF.record_type						  				:= 'C';
			SELF  :=  L;
			SELF  :=  [];
		END;

		RETURN PROJECT(baseFile, tMapping(LEFT));
	END;

	EXPORT Individual_Address_Faxes := FUNCTION
		baseFile	:= Files(filedate,pUseProd).individual_address_faxes;

		HMS.layouts.individual_address_faxes_base tMapping(Layouts.individual_address_faxes_in L) := TRANSFORM
			SELF.pid                              := fn_scale_gk(L.hms_piid);
			SELF.src    													:= msrc;

			SELF.date_vendor_first_reported     	:= (unsigned)filedate;
			SELF.date_vendor_last_reported      	:= (unsigned)filedate;
			SELF.date_first_seen                	:= 0;
			SELF.date_last_seen                 	:= 0;

			SELF.record_type						  				:= 'C';
			SELF  :=  L;
			SELF  :=  [];
		END;

		RETURN PROJECT(baseFile, tMapping(LEFT));
	END;

	EXPORT Individual_Address_Phones := FUNCTION
		baseFile	:= Files(filedate,pUseProd).individual_address_phones;

		HMS.layouts.individual_address_phones_base tMapping(Layouts.individual_address_phones_in L) := TRANSFORM
			SELF.pid                              := fn_scale_gk(L.hms_piid);
			SELF.src    													:= msrc;
			SELF.clean_phone 						:= if(ut.CleanPhone(L.phone) [1] not in ['0','1'],ut.CleanPhone(L.phone), '') ;

			SELF.date_vendor_first_reported     	:= (unsigned)filedate;
			SELF.date_vendor_last_reported      	:= (unsigned)filedate;
			SELF.date_first_seen                	:= 0;
			SELF.date_last_seen                 	:= 0;

			SELF.record_type						  				:= 'C';
			SELF  :=  L;
			SELF  :=  [];
		END;

		RETURN PROJECT(baseFile, tMapping(LEFT));
	END;

	EXPORT Individual_Certifications := FUNCTION
		baseFile	:= Files(filedate,pUseProd).individual_certifications;

		HMS.layouts.individual_certifications_base tMapping(Layouts.individual_certifications_in L) := TRANSFORM
			SELF.pid                            := fn_scale_gk(L.hms_piid);
			SELF.src    													:= msrc;

			SELF.date_vendor_first_reported     	:= (unsigned)filedate;
			SELF.date_vendor_last_reported      	:= (unsigned)filedate;
			SELF.date_first_seen                	:= 0;
			SELF.date_last_seen                 	:= 0;

			SELF.record_type						  				:= 'C';
			SELF  :=  L;
			SELF  :=  [];
		END;

		RETURN PROJECT(baseFile, tMapping(LEFT));
	END;

	EXPORT Individual_Covered_Recipients := FUNCTION
		baseFile	:= Files(filedate,pUseProd).individual_covered_recipients;

		HMS.layouts.individual_covered_recipients_base tMapping(Layouts.individual_covered_recipients_in L) := TRANSFORM
			SELF.src    													:= msrc;

			SELF.date_vendor_first_reported     	:= (unsigned)filedate;
			SELF.date_vendor_last_reported      	:= (unsigned)filedate;
			SELF.date_first_seen                	:= 0;
			SELF.date_last_seen                 	:= 0;

			SELF.record_type						  				:= 'C';
			SELF  :=  L;
			SELF  :=  [];
		END;

		RETURN PROJECT(baseFile, tMapping(LEFT));
	END;

	EXPORT Individual_Education := FUNCTION
		baseFile	:= Files(filedate,pUseProd).individual_education;

		HMS.layouts.individual_education_base tMapping(Layouts.individual_education_in L) := TRANSFORM
			SELF.src    													:= msrc;

			SELF.date_vendor_first_reported     	:= (unsigned)filedate;
			SELF.date_vendor_last_reported      	:= (unsigned)filedate;
			SELF.date_first_seen                	:= 0;
			SELF.date_last_seen                 	:= 0;

			SELF.record_type						  				:= 'C';
			SELF  :=  L;
			SELF  :=  [];
		END;

		RETURN PROJECT(baseFile, tMapping(LEFT));
	END;

	EXPORT Individual_Languages := FUNCTION
		baseFile	:= Files(filedate,pUseProd).individual_languages;

		HMS.layouts.individual_languages_base tMapping(Layouts.individual_languages_in L) := TRANSFORM
			SELF.src    													:= msrc;

			SELF.date_vendor_first_reported     	:= (unsigned)filedate;
			SELF.date_vendor_last_reported      	:= (unsigned)filedate;
			SELF.date_first_seen                	:= 0;
			SELF.date_last_seen                 	:= 0;

			SELF.record_type						  				:= 'C';
			SELF  :=  L;
			SELF  :=  [];
		END;

		RETURN PROJECT(baseFile, tMapping(LEFT));
	END;

	EXPORT Individual_Specialty := FUNCTION
		baseFile	:= Files(filedate,pUseProd).individual_specialty;

		HMS.layouts.individual_specialty_base tMapping(Layouts.individual_specialty_in L) := TRANSFORM
			SELF.src    													:= msrc;

			SELF.date_vendor_first_reported     	:= (unsigned)filedate;
			SELF.date_vendor_last_reported      	:= (unsigned)filedate;
			SELF.date_first_seen                	:= 0;
			SELF.date_last_seen                 	:= 0;

			SELF.record_type						  				:= 'C';
			SELF  :=  L;
			SELF  :=  [];
		END;

		RETURN PROJECT(baseFile, tMapping(LEFT));
	END;

	EXPORT Piid_Migration := FUNCTION
		baseFile	:= Files(filedate,pUseProd).piid_migration;

		HMS.layouts.piid_migration_base tMapping(Layouts.piid_migration_in L) := TRANSFORM
			SELF.src    													:= msrc;

			SELF.date_vendor_first_reported     	:= (unsigned)filedate;
			SELF.date_vendor_last_reported      	:= (unsigned)filedate;
			SELF.date_first_seen                	:= 0;
			SELF.date_last_seen                 	:= 0;

			SELF.record_type						  				:= 'C';
			SELF  :=  L;
			SELF  :=  [];
		END;

		RETURN PROJECT(baseFile, tMapping(LEFT));
	END;

END;
