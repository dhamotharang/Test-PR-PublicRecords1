IMPORT _Validate, tools, ut;

// This is simply to do the mapping.  The name cleaning will be done in the
// Make_IRS5500_Company_Base.  Anything that has "//DUP" afterwords simply means that that
// particular field is mapped into another attribute.  These will all be address-type attributes.
// They were duplicated because I want to show all parts, even though they're contained elsewhere.
// Don't forget to make sure the current_input matches the layout you're currently bringing in.

EXPORT Standardize_Input := MODULE

  Upper(STRING pInput) := FUNCTION
	  RETURN StringLib.StringToUpperCase(pInput);
	END;

	bad_terms := ['NA', 'N/A', '4', 'NO'];

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- map fields
	// -- do any conversions/validations
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fPreProcess(DATASET(IRS5500.Layout_Raw_In.Current_Input) pRawFileInput, STRING4 pFormYear) := FUNCTION

		IRS5500.Layout_in tPreProcess(IRS5500.Layout_Raw_In.Current_Input L) := TRANSFORM
			plan_year_start            := StringLib.StringFindReplace(L.FORM_PLAN_YEAR_BEGIN_DATE, '-', '');
			plan_year_end              := StringLib.StringFindReplace(L.FORM_TAX_PRD, '-', '');
			the_eff_date               := StringLib.StringFindReplace(L.PLAN_EFF_DATE, '-', '');
			trimmed_admin_date         := TRIM(L.ADMIN_SIGNED_DATE, LEFT);
			the_admin_signed_date      := trimmed_admin_date[1..4] + trimmed_admin_date[6..7] +
			                                 trimmed_admin_date[9..10];
			trimmed_spons_date         := TRIM(L.SPONS_SIGNED_DATE, LEFT);
			the_spons_signed_date      := trimmed_spons_date[1..4] + trimmed_spons_date[6..7] +
			                                 trimmed_spons_date[9..10];
			trimmed_dfe_date           := TRIM(L.DFE_SIGNED_DATE, LEFT);
			the_dfe_signed_date        := trimmed_dfe_date[1..4] + trimmed_dfe_date[6..7] +
			                                 trimmed_dfe_date[9..10];
			the_date_received          := StringLib.StringFindReplace(L.DATE_RECEIVED, '-', '');
			the_spons_dfe_dba_name     := ut.CleanSpacesAndUpper(L.SPONS_DFE_DBA_NAME);
			the_spons_dfe_care_of_name := ut.CleanSpacesAndUpper(L.SPONS_DFE_CARE_OF_NAME);
			the_admin_name             := ut.CleanSpacesAndUpper(L.ADMIN_NAME);
			the_admin_care_of_name     := ut.CleanSpacesAndUpper(L.ADMIN_CARE_OF_NAME);
			the_last_rpt_spons_name    := ut.CleanSpacesAndUpper(L.LAST_RPT_SPONS_NAME);

			SELF.form_date 											:= pFormYear;
			SELF.document_locator_number 				:= ut.CleanSpacesAndUpper(L.ACK_ID);
			SELF.ein 														:= L.SPONS_DFE_EIN;
			SELF.plan_number 										:= L.SPONS_DFE_PN;
      SELF.form_plan_year_begin_date			:= IF(_Validate.Date.fIsValid(plan_year_start),
			                                          plan_year_start,
																								'');
      SELF.form_tax_prd										:= IF(_Validate.Date.fIsValid(plan_year_end),
			                                          plan_year_end,
																								'');
      SELF.type_plan_entity_ind						:= L.TYPE_PLAN_ENTITY_CD;
			SELF.type_dfe_plan_entity						:= ut.CleanSpacesAndUpper(L.TYPE_DFE_PLAN_ENTITY_CD);
			SELF.ext_application_filed_ind			:= L.F5558_APPLICATION_FILED_IND;
			SELF.plan_name 											:= ut.CleanSpacesAndUpper(L.PLAN_NAME);
			SELF.plan_eff_date 									:= IF(_Validate.Date.fIsValid(the_eff_date),
			                                          the_eff_date,
																								'');
			SELF.sponsor_dfe_name 							:= ut.CleanSpacesAndUpper(L.SPONSOR_DFE_NAME);
			SELF.spons_dfe_dba_name 						:= MAP(the_spons_dfe_dba_name IN bad_terms      => '',
			                                           (UNSIGNED)the_spons_dfe_dba_name = 0     => '',
			                                           the_spons_dfe_dba_name = 'SAME'          => SELF.sponsor_dfe_name,
			                                           the_spons_dfe_dba_name = 'SAME AS ABOVE' => SELF.sponsor_dfe_name,
			                                           the_spons_dfe_dba_name);
			SELF.spons_dfe_care_of_name 				:= MAP(the_spons_dfe_care_of_name IN bad_terms  => '',
			                                           (UNSIGNED)the_spons_dfe_care_of_name = 0 => '',
			                                           the_spons_dfe_care_of_name = 'SAME'      => SELF.sponsor_dfe_name,
			                                           the_spons_dfe_care_of_name);
			SELF.spons_dfe_mail_str_address 		:= ut.CleanSpacesAndUpper(L.SPONS_DFE_MAIL_US_ADDRESS1);
			SELF.spons_dfe_loc_01_addr 					:= ut.CleanSpacesAndUpper(L.SPONS_DFE_LOC_US_ADDRESS1);
			SELF.spons_dfe_loc_02_addr 					:= ut.CleanSpacesAndUpper(L.SPONS_DFE_LOC_US_ADDRESS2);
			SELF.spons_dfe_foreign_route_cd 		:= ut.CleanSpacesAndUpper(L.SPONS_DFE_MAIL_FORGN_POSTAL_CD);
			SELF.spons_dfe_foreign_mail_cntry	 	:= Upper(L.SPONS_DFE_MAIL_FOREIGN_CNTRY);
			SELF.spons_dfe_city 								:= ut.CleanSpacesAndUpper(L.SPONS_DFE_MAIL_US_CITY);
			SELF.spons_dfe_state 								:= Upper(L.SPONS_DFE_MAIL_US_STATE);
			SELF.spons_dfe_zip_code 						:= TRIM(L.SPONS_DFE_MAIL_US_ZIP, LEFT, RIGHT);
			SELF.admin_name 										:= MAP(the_admin_name IN bad_terms  => '',
			                                           (UNSIGNED)the_admin_name = 0 => '',
			                                           the_admin_name = 'SAME'      => SELF.sponsor_dfe_name,
			                                           the_admin_name);
			SELF.admin_care_of_name 						:= MAP(the_admin_care_of_name IN bad_terms  => '',
			                                           (UNSIGNED)the_admin_care_of_name = 0 => '',
			                                           the_admin_care_of_name = 'SAME' and
																								    the_admin_name = 'SAME'           => SELF.sponsor_dfe_name,
			                                           the_admin_care_of_name = 'SAME'      => SELF.admin_name,
			                                           the_admin_care_of_name);
			SELF.admn_str_address 							:= ut.CleanSpacesAndUpper(L.ADMIN_US_ADDRESS1);
			SELF.admin_foreign_route_cd 				:= ut.CleanSpacesAndUpper(L.ADMIN_FOREIGN_POSTAL_CD);
			SELF.admin_foreign_mailing_cntry 		:= Upper(L.ADMIN_FOREIGN_CNTRY);
			SELF.admin_city 										:= ut.CleanSpacesAndUpper(L.ADMIN_US_CITY);
			SELF.admin_state 										:= Upper(L.ADMIN_US_STATE);
			SELF.admin_zip_code 								:= TRIM(L.ADMIN_US_ZIP, LEFT, RIGHT);
			SELF.last_rpt_spons_name 						:= MAP(the_last_rpt_spons_name IN bad_terms  => '',
			                                           (UNSIGNED)the_last_rpt_spons_name = 0 => '',
			                                           the_last_rpt_spons_name = 'SAME'      => SELF.sponsor_dfe_name,
			                                           the_last_rpt_spons_name);
			SELF.admin_signed_date 							:= IF(_Validate.Date.fIsValid(the_admin_signed_date),
			                                          the_admin_signed_date,
																								'');
			SELF.admin_signed_name 							:= ut.CleanSpacesAndUpper(L.ADMIN_SIGNED_NAME);
			SELF.spons_signed_date 							:= IF(_Validate.Date.fIsValid(the_spons_signed_date),
			                                          the_spons_signed_date,
																								'');
			SELF.spons_signed_name 							:= ut.CleanSpacesAndUpper(L.SPONS_SIGNED_NAME);
			SELF.type_pension_bnft_code 				:= ut.CleanSpacesAndUpper(L.TYPE_PENSION_BNFT_CODE);
			SELF.type_welfare_bnft_code 				:= ut.CleanSpacesAndUpper(L.TYPE_WELFARE_BNFT_CODE);
			SELF.SPONS_DFE_MAIL_US_ADDRESS1			:= ut.CleanSpacesAndUpper(L.SPONS_DFE_MAIL_US_ADDRESS1); //DUP
			SELF.SPONS_DFE_MAIL_US_ADDRESS2			:= ut.CleanSpacesAndUpper(L.SPONS_DFE_MAIL_US_ADDRESS2);
			SELF.SPONS_DFE_MAIL_US_CITY					:= ut.CleanSpacesAndUpper(L.SPONS_DFE_MAIL_US_CITY); //DUP
			SELF.SPONS_DFE_MAIL_US_STATE				:= Upper(L.SPONS_DFE_MAIL_US_STATE); //DUP
			SELF.SPONS_DFE_MAIL_US_ZIP					:= TRIM(L.SPONS_DFE_MAIL_US_ZIP, LEFT, RIGHT); //DUP
			SELF.SPONS_DFE_MAIL_FOREIGN_ADDR1		:= ut.CleanSpacesAndUpper(L.SPONS_DFE_MAIL_FOREIGN_ADDR1);
			SELF.SPONS_DFE_MAIL_FOREIGN_ADDR2		:= ut.CleanSpacesAndUpper(L.SPONS_DFE_MAIL_FOREIGN_ADDR2);
			SELF.SPONS_DFE_MAIL_FOREIGN_CITY		:= ut.CleanSpacesAndUpper(L.SPONS_DFE_MAIL_FOREIGN_CITY);
			SELF.SPONS_DFE_MAIL_FORGN_PROV_ST		:= ut.CleanSpacesAndUpper(L.SPONS_DFE_MAIL_FORGN_PROV_ST);
			SELF.SPONS_DFE_MAIL_FOREIGN_CNTRY		:= Upper(L.SPONS_DFE_MAIL_FOREIGN_CNTRY); //DUP
			SELF.SPONS_DFE_MAIL_FORGN_POSTAL_CD	:= ut.CleanSpacesAndUpper(L.SPONS_DFE_MAIL_FORGN_POSTAL_CD); //DUP
			SELF.SPONS_DFE_LOC_US_ADDRESS1			:= ut.CleanSpacesAndUpper(L.SPONS_DFE_LOC_US_ADDRESS1); //DUP
			SELF.SPONS_DFE_LOC_US_ADDRESS2			:= ut.CleanSpacesAndUpper(L.SPONS_DFE_LOC_US_ADDRESS2); //DUP
			SELF.SPONS_DFE_LOC_US_CITY					:= ut.CleanSpacesAndUpper(L.SPONS_DFE_LOC_US_CITY);
			SELF.SPONS_DFE_LOC_US_STATE					:= Upper(L.SPONS_DFE_LOC_US_STATE);
			SELF.SPONS_DFE_LOC_US_ZIP						:= TRIM(L.SPONS_DFE_LOC_US_ZIP, LEFT, RIGHT);
			SELF.SPONS_DFE_LOC_FOREIGN_ADDRESS1	:= ut.CleanSpacesAndUpper(L.SPONS_DFE_LOC_FOREIGN_ADDRESS1);
			SELF.SPONS_DFE_LOC_FOREIGN_ADDRESS2	:= ut.CleanSpacesAndUpper(L.SPONS_DFE_LOC_FOREIGN_ADDRESS2);
			SELF.SPONS_DFE_LOC_FOREIGN_CITY			:= ut.CleanSpacesAndUpper(L.SPONS_DFE_LOC_FOREIGN_CITY);
			SELF.SPONS_DFE_LOC_FORGN_PROV_ST		:= ut.CleanSpacesAndUpper(L.SPONS_DFE_LOC_FORGN_PROV_ST);
			SELF.SPONS_DFE_LOC_FOREIGN_CNTRY		:= Upper(L.SPONS_DFE_LOC_FOREIGN_CNTRY);
			SELF.SPONS_DFE_LOC_FORGN_POSTAL_CD	:= ut.CleanSpacesAndUpper(L.SPONS_DFE_LOC_FORGN_POSTAL_CD);
			SELF.ADMIN_US_ADDRESS1							:= ut.CleanSpacesAndUpper(L.ADMIN_US_ADDRESS1); //DUP
			SELF.ADMIN_US_ADDRESS2							:= ut.CleanSpacesAndUpper(L.ADMIN_US_ADDRESS2);
			SELF.ADMIN_US_CITY									:= ut.CleanSpacesAndUpper(L.ADMIN_US_CITY); //DUP
			SELF.ADMIN_US_STATE									:= Upper(L.ADMIN_US_STATE); //DUP
			SELF.ADMIN_US_ZIP										:= TRIM(L.ADMIN_US_ZIP, LEFT, RIGHT); //DUP
			SELF.ADMIN_FOREIGN_ADDRESS1					:= ut.CleanSpacesAndUpper(L.ADMIN_FOREIGN_ADDRESS1);
			SELF.ADMIN_FOREIGN_ADDRESS2					:= ut.CleanSpacesAndUpper(L.ADMIN_FOREIGN_ADDRESS2);
			SELF.ADMIN_FOREIGN_CITY							:= ut.CleanSpacesAndUpper(L.ADMIN_FOREIGN_CITY);
			SELF.ADMIN_FOREIGN_PROV_STATE				:= ut.CleanSpacesAndUpper(L.ADMIN_FOREIGN_PROV_STATE);
			SELF.ADMIN_FOREIGN_CNTRY						:= Upper(L.ADMIN_FOREIGN_CNTRY); //DUP
			SELF.ADMIN_FOREIGN_POSTAL_CD				:= ut.CleanSpacesAndUpper(L.ADMIN_FOREIGN_POSTAL_CD); //DUP
			SELF.DFE_SIGNED_DATE 								:= IF(_Validate.Date.fIsValid(the_dfe_signed_date),
			                                          the_dfe_signed_date,
																								'');
			SELF.DFE_SIGNED_NAME 								:= ut.CleanSpacesAndUpper(L.DFE_SIGNED_NAME);
			SELF.FILING_STATUS									:= ut.CleanSpacesAndUpper(L.FILING_STATUS);
			SELF.DATE_RECEIVED									:= IF(_Validate.Date.fIsValid(the_date_received),
			                                          the_date_received,
																								'');
			SELF.VALID_ADMIN_SIGNATURE					:= ut.CleanSpacesAndUpper(L.VALID_ADMIN_SIGNATURE);
			SELF.VALID_DFE_SIGNATURE						:= ut.CleanSpacesAndUpper(L.VALID_DFE_SIGNATURE);
			SELF.VALID_SPONSOR_SIGNATURE				:= ut.CleanSpacesAndUpper(L.VALID_SPONSOR_SIGNATURE);

			// Fields for 2012 onward
			SELF.preparer_str_address						:= ut.CleanSpacesAndUpper(L.PREPARER_US_ADDRESS1);
			SELF.preparer_foreign_route_cd			:= ut.CleanSpacesAndUpper(L.PREPARER_FOREIGN_POSTAL_CD);
			SELF.preparer_frgn_mailing_cntry		:= ut.CleanSpacesAndUpper(L.PREPARER_FOREIGN_CNTRY);
			SELF.preparer_city									:= ut.CleanSpacesAndUpper(L.PREPARER_US_CITY);
			SELF.preparer_state									:= ut.CleanSpacesAndUpper(L.PREPARER_US_STATE);
			SELF.preparer_zip_code							:= TRIM(L.PREPARER_US_ZIP, LEFT, RIGHT);
			SELF.PREPARER_NAME							    := ut.CleanSpacesAndUpper(L.PREPARER_NAME);
			SELF.PREPARER_FIRM_NAME					    := ut.CleanSpacesAndUpper(L.PREPARER_FIRM_NAME);
			SELF.PREPARER_US_ADDRESS1				    := ut.CleanSpacesAndUpper(L.PREPARER_US_ADDRESS1); //DUP
			SELF.PREPARER_US_ADDRESS2				    := ut.CleanSpacesAndUpper(L.PREPARER_US_ADDRESS2);
			SELF.PREPARER_US_CITY						    := ut.CleanSpacesAndUpper(L.PREPARER_US_CITY); //DUP
			SELF.PREPARER_US_STATE					    := ut.CleanSpacesAndUpper(L.PREPARER_US_STATE); //DUP
			SELF.PREPARER_US_ZIP						    := TRIM(L.PREPARER_US_ZIP, LEFT, RIGHT); //DUP
			SELF.PREPARER_FOREIGN_ADDRESS1	    := ut.CleanSpacesAndUpper(L.PREPARER_FOREIGN_ADDRESS1);
			SELF.PREPARER_FOREIGN_ADDRESS2	    := ut.CleanSpacesAndUpper(L.PREPARER_FOREIGN_ADDRESS2);
			SELF.PREPARER_FOREIGN_CITY			    := ut.CleanSpacesAndUpper(L.PREPARER_FOREIGN_CITY);
			SELF.PREPARER_FOREIGN_PROV_STATE    := ut.CleanSpacesAndUpper(L.PREPARER_FOREIGN_PROV_STATE);
			SELF.PREPARER_FOREIGN_CNTRY			    := ut.CleanSpacesAndUpper(L.PREPARER_FOREIGN_CNTRY); //DUP
			SELF.PREPARER_FOREIGN_POSTAL_CD			:= ut.CleanSpacesAndUpper(L.PREPARER_FOREIGN_POSTAL_CD); //DUP

			SELF																:= L;
			SELF 																:= [];
		END;
		
		RETURN PROJECT(pRawFileInput, tPreProcess(LEFT));

	END;

	EXPORT fAll(DATASET(IRS5500.Layout_Raw_In.Current_Input) pRawFileInput, STRING pFormYear) := FUNCTION

		RETURN fPreProcess(pRawFileInput, pFormYear);

	END;

END;
