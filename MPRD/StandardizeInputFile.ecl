IMPORT  ut, _validate, lib_stringlib, MPRD;

EXPORT StandardizeInputFile  (string filedate, boolean pUseProd = false):= MODULE
	EXPORT invalid_dates:=['','0000-00-00','\\N'];
	EXPORT invalid_values:=['\\N','|','\\','','0000-00-00'];

	EXPORT Individual	:= FUNCTION
		input := MPRD.InFile_Preprocessor(filedate,pUseProd).Prepped_Individual;

		MPRD.layouts.individual_base tMapping(MPRD.layouts.individual_in L, INTEGER C) := TRANSFORM , SKIP(l.full_name = '' AND l.first_name ='' AND l.last_name = '' AND l.prac_company1_name='')
			SELF.src    												:= 'QN';
			SELF.Date_vendor_first_reported     := (UNSIGNED)filedate;
			SELF.Date_vendor_last_reported      := (UNSIGNED)filedate;
			SELF.clean_prac_phone1 							:= IF(ut.CleanPhone(L.prac_phone1) [1] NOT IN ['0','1'],ut.CleanPhone(L.prac_phone1), '') ;
			SELF.clean_bill_phone1 							:= IF(ut.CleanPhone(L.bill_phone1) [1] NOT IN ['0','1'],ut.CleanPhone(L.bill_phone1), '') ;
			SELF.name_in												:= TRIM(Stringlib.StringToUpperCase(L.name_in), LEFT, RIGHT);
			SELF.prac_company1_in								:= TRIM(Stringlib.StringToUpperCase(L.prac_company1_in), LEFT, RIGHT);
			SELF.prac_company1_name							:= TRIM(Stringlib.StringToUpperCase(L.prac_company1_name), LEFT, RIGHT);
			SELF.clean_prac1_company_name				:= IF(L.prac_company1_name<> '', ut.CleanCompany(L.prac_company1_name), '');
			SELF.group_key											:= TRIM(L.group_key, LEFT, RIGHT);
			SELF.full_name											:= TRIM(Stringlib.StringToUpperCase(L.full_name), LEFT, RIGHT);
			SELF.pre_name												:= TRIM(Stringlib.StringToUpperCase(L.pre_name), LEFT, RIGHT);
			SELF.first_name											:= TRIM(Stringlib.StringToUpperCase(L.first_name), LEFT, RIGHT);
			SELF.middle_name										:= TRIM(Stringlib.StringToUpperCase(L.middle_name), LEFT, RIGHT);
			SELF.last_name											:= TRIM(Stringlib.StringToUpperCase(L.last_name), LEFT, RIGHT);
			SELF.maturity_suffix								:= TRIM(Stringlib.StringToUpperCase(L.maturity_suffix), LEFT, RIGHT);
			SELF.orig_adresss                   := CHOOSE(C,l.prac1_primary_address,l.prac1_secondary_address,l.bill1_primary_address,l.bill1_secondary_address);
			SELF.orig_city                      := CHOOSE(C,l.prac1_city,l.prac1_city,l.bill1_city,l.bill1_city);
			SELF.orig_state                     := CHOOSE(C,l.prac1_state,l.prac1_state,l.bill1_state,l.bill1_state);
			SELF.orig_zip                       := CHOOSE(C,l.prac1_zip,l.prac1_zip,l.bill1_zip,l.bill1_zip);
			SELF.date_of_death									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.date_of_death,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.birthdate											:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.birthdate,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.dea_num1_exp										:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.dea_num1_exp,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic1_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic1_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic1_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic1_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic2_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic2_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic2_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic2_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic3_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic3_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic3_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic3_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.sanc1_date											:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.sanc1_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.last_update_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.last_update_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.abms_start_eff_date						:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.abms_start_eff_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.abms_end_eff_date							:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.abms_end_eff_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.dea_num1_deact_date						:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.dea_num1_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.npi_deact_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.npi_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.sanc1_rein_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.sanc1_rein_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.medicare_optout_eff_date				:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.medicare_optout_eff_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.medicare_optout_end_date				:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.medicare_optout_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.normed_addr_rec_type           := CHOOSE(C,'1','2','3','4');
			SELF.Prepped_addr1                  := TRIM(Stringlib.StringToUpperCase(CHOOSE(C,SELF.orig_adresss)), LEFT, RIGHT);
			SELF.Prepped_addr2                  := TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(
																							TRIM(SELF.orig_city) + IF(SELF.orig_city <> '',',','')
																							+ ' '+ SELF.orig_state	+ ' '+SELF.orig_zip[..5])),LEFT,RIGHT);
			SELF.medschool1                     := TRIM(Stringlib.StringToUpperCase(l.medschool1),LEFT,RIGHT);
			SELF.provider_id                    := TRIM(Stringlib.StringToUpperCase(l.provider_id),LEFT,RIGHT);
			SELF.date_first_seen                := '0';
			SELF.date_last_seen                 := '0';
			SELF.clean_birthdate                := IF(l.birthdate NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.birthdate,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic1_begin_date          := IF(l.lic1_begin_date NOT IN invalid_dates, _validate.date.fCorrectedDateString(TRIM(stringlib.stringfilterout(l.lic1_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic1_end_date            := IF(l.lic1_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic1_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic2_begin_date          := IF(l.lic2_begin_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic2_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic2_end_date            := IF(l.lic2_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic2_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic3_begin_date          := IF(l.lic3_begin_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic3_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic3_end_date            := IF(l.lic3_end_date NOT IN invalid_dates ,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic3_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_sanc1_date               := IF(l.sanc1_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.sanc1_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_date_of_death            := IF(l.date_of_death NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.date_of_death,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_last_update_date         := IF(l.last_update_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.last_update_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_abms_start_eff_date      := IF(l.abms_start_eff_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.abms_start_eff_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_abms_end_eff_date        := IF(l.abms_end_eff_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.abms_end_eff_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_dea_num1_deact_date      := IF(l.dea_num1_deact_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.dea_num1_deact_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_npi_deact_date           := IF(l.npi_deact_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.npi_deact_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_sanc1_rein_date          := IF(l.sanc1_rein_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.sanc1_rein_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_dea_num1_exp             := IF(l.dea_num1_exp  NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.dea_num1_exp,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_medicare_optout_eff_date	:= IF(l.medicare_optout_eff_date NOT IN invalid_dates,_validate.Date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.medicare_optout_eff_date,'-.>$!%*@+?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_medicare_optout_end_date	:= IF(l.medicare_optout_end_date NOT IN invalid_dates,_validate.Date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.medicare_optout_end_date,'-.>$!%*@+?&\''),LEFT,RIGHT),false),'0');
			SELF.record_type										:= 'C';
			SELF.isTest													:= IF(l.isTest = true, true, false);
			SELF  															:=  L;
			SELF 																:= [];
		END;

		std_input := NORMALIZE(input, 4, tMapping(LEFT, COUNTER))(normed_addr_rec_type='1' OR Prepped_addr1<>'' AND first_name<>'',last_name<>'');
		return std_input;
	END;

	EXPORT Facility	:= FUNCTION
		input := MPRD.InFile_Preprocessor(filedate,pUseProd).Prepped_facility;

		MPRD.layouts.facility_base tMapping(MPRD.layouts.facility_in L, C) := TRANSFORM
			SELF.src    												:= 'QN';
			SELF.Date_vendor_first_reported 		:= (UNSIGNED)filedate;
			SELF.Date_vendor_last_reported 			:= (UNSIGNED)filedate;
			SELF.clean_phone 									  := IF(ut.CleanPhone(L.prac_phone1) [1] NOT IN ['0','1'],ut.CleanPhone(L.prac_phone1), '') ;
			SELF.prac_company1_in								:= TRIM(Stringlib.StringToUpperCase(L.prac_company1_in), LEFT, RIGHT);
			SELF.prac_company1_name							:= TRIM(Stringlib.StringToUpperCase(L.prac_company1_name), LEFT, RIGHT);
			SELF.name_in												:= TRIM(Stringlib.StringToUpperCase(L.name_in), LEFT, RIGHT);
			SELF.clean_prac1_company_name			  := IF(L.prac_company1_name<> '', ut.CleanCompany(L.prac_company1_name), '');
			SELF.dba_in													:= TRIM(Stringlib.StringToUpperCase(L.dba_in), LEFT, RIGHT);
			SELF.dba_name												:= TRIM(Stringlib.StringToUpperCase(L.dba_name), LEFT, RIGHT);
			SELF.bill_company1_in								:= TRIM(Stringlib.StringToUpperCase(L.bill_company1_in), LEFT, RIGHT);
			SELF.dea_num1_exp										:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.dea_num1_exp,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic1_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic1_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic1_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic1_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic2_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic2_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic2_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic2_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic3_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic3_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic3_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic3_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.medicare_fac_num_term_date			:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.medicare_fac_num_term_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.last_update_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.last_update_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.sanc1_date											:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.sanc1_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.dea_num1_deact_date						:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.dea_num1_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.npi_deact_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.npi_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.sanc1_rein_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.sanc1_rein_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.clia_cert_eff_date							:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.clia_cert_eff_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.clia_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.clia_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.clean_dba_name									:= IF(L.dba_name<> '', ut.CleanCompany(L.dba_name), '');
			SELF.group_key											:= TRIM(L.group_key, LEFT, RIGHT);
			SELF.orig_adresss                   := CHOOSE(C,l.prac1_primary_address,IF(l.prac1_secondary_address ='\\N','',l.prac1_secondary_address),l.bill1_primary_address,IF(l.bill1_secondary_address='\\N','',l.bill1_secondary_address));
			SELF.orig_city                      := CHOOSE(C,l.prac1_city,l.prac1_city,l.bill1_city,l.bill1_city);
			SELF.orig_state                     := CHOOSE(C,l.prac1_state,l.prac1_state,l.bill1_state,l.bill1_state);
			SELF.orig_zip                       := CHOOSE(C,l.prac1_zip,l.prac1_zip,l.bill1_zip,l.bill1_zip);
			SELF.normed_addr_rec_type           := CHOOSE(C,'1','2','3','4');
			SELF.Prepped_addr1                  := TRIM(Stringlib.StringToUpperCase(CHOOSE(C,SELF.orig_adresss)), LEFT, RIGHT);
			SELF.Prepped_addr2                  := TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(
																							TRIM(SELF.orig_city) + IF(SELF.orig_city <> '',',','')
																							+ ' '+ SELF.orig_state	+ ' '+SELF.orig_zip[..5])),LEFT,RIGHT);
			SELF.date_first_seen                :='0';
			SELF.date_last_seen                 :='0';
			SELF.clean_lic1_begin_date          := IF(l.lic1_begin_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic1_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic1_end_date            := IF(l.lic1_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic1_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic2_begin_date          := IF(l.lic2_begin_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic2_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic2_end_date            := IF(l.lic1_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic2_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic3_begin_date          := IF(l.lic3_begin_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic3_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic3_end_date            := IF(l.lic3_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic3_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_last_update_date         := IF(l.last_update_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.last_update_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_sanc1_date               := IF(l.sanc1_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.sanc1_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_dea_num1_deact_date      := IF(l.dea_num1_deact_date  NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.dea_num1_deact_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_npi_deact_date           := IF(l.npi_deact_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.npi_deact_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_sanc1_rein_date          := IF(l.sanc1_rein_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.sanc1_rein_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_clia_cert_eff_date       := IF(l.clia_cert_eff_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.clia_cert_eff_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_clia_end_date            := IF(l.clia_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.clia_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_dea_num1_exp             := IF(l.dea_num1_exp  NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.dea_num1_exp,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_medicare_fac_num_term_date:=IF(l.medicare_fac_num_term_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.medicare_fac_num_term_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.record_type										:= 'C';
			SELF.isTest													:= IF(l.isTest = true, true, false);
			SELF  :=  L;
			SELF := [];
		END;

		std_input := NORMALIZE(input, 4, tMapping(LEFT, COUNTER))(normed_addr_rec_type='1' OR Prepped_addr1<>'' );
		return std_input;
	END;

	EXPORT Choice_Point	:= FUNCTION
		input := MPRD.InFile_Preprocessor(filedate,pUseProd).Prepped_choice_point;

		MPRD.layouts.choice_point_base tMapping(MPRD.layouts.choice_point_in L, C) := TRANSFORM
			SELF.src  												  := 'QN';
			SELF.Date_vendor_first_reported     := (UNSIGNED)filedate;
			SELF.Date_vendor_last_reported      := (UNSIGNED)filedate;
			SELF.clean_prac1_Phone 							:= IF(ut.CleanPhone(L.prac_phone1) [1] NOT IN ['0','1'],ut.CleanPhone(L.prac_phone1), '') ;
			SELF.clean_prac2_Phone 							:= IF(ut.CleanPhone(L.prac_phone2) [1] NOT IN ['0','1'],ut.CleanPhone(L.prac_phone2), '') ;
			SELF.clean_prac3_Phone 							:= IF(ut.CleanPhone(L.prac_phone3) [1] NOT IN ['0','1'],ut.CleanPhone(L.prac_phone3), '') ;
			SELF.clean_bill1_Phone 							:= IF(ut.CleanPhone(L.bill_phone1) [1] NOT IN ['0','1'],ut.CleanPhone(L.prac_phone1), '') ;
			SELF.clean_bill2_Phone 							:= IF(ut.CleanPhone(L.bill_phone2) [1] NOT IN ['0','1'],ut.CleanPhone(L.prac_phone2), '') ;
			SELF.clean_bill3_Phone 							:= IF(ut.CleanPhone(L.bill_phone3) [1] NOT IN ['0','1'],ut.CleanPhone(L.prac_phone3), '') ;
			SELF.name_in												:= TRIM(Stringlib.StringToUpperCase(L.name_in), LEFT, RIGHT);
			SELF.prac_company1_in								:= TRIM(Stringlib.StringToUpperCase(L.prac_company1_in), LEFT, RIGHT);
			SELF.prac_company1_name							:= TRIM(Stringlib.StringToUpperCase(L.prac_company1_name), LEFT, RIGHT);
			SELF.clean_prac_company1_name				:= IF(L.prac_company1_name<> '', ut.CleanCompany(L.prac_company1_name), '');
			SELF.prac_company2_in								:= TRIM(Stringlib.StringToUpperCase(L.prac_company2_in), LEFT, RIGHT);
			SELF.prac_company2_name							:= TRIM(Stringlib.StringToUpperCase(L.prac_company2_name), LEFT, RIGHT);
			SELF.clean_prac_company2_name				:= IF(L.prac_company1_name<> '', ut.CleanCompany(L.prac_company2_name), '');
			SELF.prac_company3_in								:= TRIM(Stringlib.StringToUpperCase(L.prac_company3_in), LEFT, RIGHT);
			SELF.prac_company3_name							:= TRIM(Stringlib.StringToUpperCase(L.prac_company3_name), LEFT, RIGHT);
			SELF.clean_prac_company3_name				:= IF(L.prac_company1_name<> '', ut.CleanCompany(L.prac_company3_name), '');
			SELF.bill_company1_in								:= TRIM(Stringlib. StringToUpperCase(L.bill_company1_in), LEFT, RIGHT);
			SELF.bill_company1_name							:= TRIM(Stringlib.StringToUpperCase(L.bill_company1_name), LEFT, RIGHT);
			SELF.clean_bill_company1_name				:= IF(L.prac_company1_name<> '', ut.CleanCompany(L.bill_company1_name), '');
			SELF.bill_company2_in								:= TRIM(Stringlib.StringToUpperCase(L.bill_company2_in), LEFT, RIGHT);
			SELF.bill_company2_name							:= TRIM(Stringlib.StringToUpperCase(L.bill_company2_name), LEFT, RIGHT);
			SELF.clean_bill_company2_name				:= IF(L.prac_company1_name<> '', ut.CleanCompany(L.bill_company2_name), '');
			SELF.bill_company3_in								:= TRIM(Stringlib.StringToUpperCase(L.bill_company3_in), LEFT, RIGHT);
			SELF.bill_company3_name							:= TRIM(Stringlib.StringToUpperCase(L.bill_company3_name), LEFT, RIGHT);
			SELF.clean_bill_company3_name				:= IF(L.prac_company1_name<> '', ut.CleanCompany(L.bill_company3_name), '');
			SELF.group_key											:= TRIM(L.group_key, LEFT, RIGHT);
			SELF.full_name											:= TRIM(Stringlib.StringToUpperCase(L.full_name), LEFT, RIGHT);
			SELF.pre_name												:= TRIM(Stringlib.StringToUpperCase(L.pre_name), LEFT, RIGHT);
			SELF.first_name											:= TRIM(Stringlib.StringToUpperCase(L.first_name), LEFT, RIGHT);
			SELF.middle_name										:= TRIM(Stringlib.StringToUpperCase(L.middle_name), LEFT, RIGHT);
			SELF.last_name											:= TRIM(Stringlib.StringToUpperCase(L.last_name), LEFT, RIGHT);
			SELF.preferred_name								  := TRIM(Stringlib.StringToUpperCase(L.preferred_name), LEFT, RIGHT);
			SELF.maturity_suffix								:= TRIM(Stringlib.StringToUpperCase(L.maturity_suffix), LEFT, RIGHT);
			SELF.medschool1                     := TRIM(Stringlib.StringToUpperCase(l.medschool1),LEFT,RIGHT);
			SELF.medschool2                     := TRIM(Stringlib.StringToUpperCase(l.medschool2),LEFT,RIGHT);
			SELF.medschool3                     := TRIM(Stringlib.StringToUpperCase(l.medschool3),LEFT,RIGHT);
			SELF.date_of_death									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.date_of_death,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.birthdate											:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.birthdate,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.dea_num1_exp										:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.dea_num1_exp,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.dea_num2_exp										:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.dea_num2_exp,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.dea_num3_exp										:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.dea_num3_exp,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.dea_num4_exp										:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.dea_num4_exp,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.dea_num5_exp										:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.dea_num5_exp,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.dea_num6_exp										:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.dea_num6_exp,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.dea_num7_exp										:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.dea_num7_exp,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.dea_num8_exp										:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.dea_num8_exp,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.dea_num9_exp										:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.dea_num9_exp,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.dea_num10_exp										:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.dea_num10_exp,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic1_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic1_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic1_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic1_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic2_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic2_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic2_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic2_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic3_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic3_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic3_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic3_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic4_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic4_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic4_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic4_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic5_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic5_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic5_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic5_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.sanc1_date											:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.sanc1_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.sanc2_date											:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.sanc2_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.sanc3_date											:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.sanc3_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.sanc4_date											:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.sanc4_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.sanc5_date											:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.sanc5_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.sanc6_date											:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.sanc6_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.sanc7_date											:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.sanc7_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.sanc8_date											:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.sanc8_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.sanc9_date											:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.sanc9_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.sanc10_date										:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.sanc10_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.last_update_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.last_update_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.dea_num1_deact_date						:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.dea_num1_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.dea_num2_deact_date						:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.dea_num2_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.dea_num3_deact_date						:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.dea_num3_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.dea_num4_deact_date						:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.dea_num4_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.dea_num5_deact_date						:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.dea_num5_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.dea_num6_deact_date						:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.dea_num6_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.dea_num7_deact_date						:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.dea_num7_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.dea_num8_deact_date						:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.dea_num8_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.dea_num9_deact_date						:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.dea_num9_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.dea_num10_deact_date						:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.dea_num10_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.npi_deact_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.npi_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.sanc1_rein_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.sanc1_rein_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.sanc2_rein_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.sanc2_rein_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.sanc3_rein_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.sanc3_rein_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.sanc4_rein_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.sanc4_rein_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.sanc5_rein_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.sanc5_rein_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.sanc6_rein_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.sanc6_rein_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.sanc7_rein_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.sanc7_rein_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.sanc8_rein_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.sanc8_rein_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.sanc9_rein_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.sanc9_rein_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.sanc10_rein_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.sanc10_rein_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.orig_adresss                   := TRIM(Stringlib.StringToUpperCase(CHOOSE(C,
																							         L.prac1_primary_address,L.prac1_secondary_address,
																							    	   L.prac2_primary_address,L.prac2_secondary_address,
																								       L.prac3_primary_address,L.prac3_secondary_address,
																								       L.bill1_primary_address,L.bill1_secondary_address,
																								       L.bill2_primary_address,L.bill2_secondary_address,
																								       L.bill3_primary_address,L.bill3_secondary_address)), LEFT, RIGHT);
			SELF.orig_city                      := TRIM(Stringlib.StringToUpperCase(CHOOSE(C,
																											l.prac1_city,l.prac1_city,
																											l.prac2_city,l.prac2_city,
																											l.prac3_city,l.prac3_city,
																											l.bill1_city,l.bill1_city,
																											l.bill2_city,l.bill2_city,
																											l.bill3_city,l.bill3_city)),LEFT, RIGHT);
			SELF.orig_state                     := TRIM(Stringlib.StringToUpperCase(CHOOSE(C,
																											 l.prac1_state,l.prac1_state,
																											 l.prac2_state,l.prac2_state,
																											 l.prac3_state,l.prac3_state,
																											 l.bill1_state,l.bill1_state,
																											 l.bill2_state,l.bill2_state,
																											 l.bill3_state,l.bill3_state)),LEFT,RIGHT);
			SELF.orig_zip                       := CHOOSE(C,l.prac1_zip,l.prac1_zip,l.prac2_zip,l.prac2_zip,l.prac3_zip,l.prac3_zip,l.bill1_zip,l.bill1_zip,l.bill2_zip,l.bill2_zip,l.bill3_zip,l.bill3_zip);
			SELF.normed_addr_rec_type           := CHOOSE(C,'1','2','3','4','5','6','7','8','9','10','11','12');
			SELF.Prepped_addr1                  := TRIM(Stringlib.StringToUpperCase(CHOOSE(C,SELF.orig_adresss)), LEFT, RIGHT);
			SELF.Prepped_addr2                  := TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(
																						TRIM(SELF.orig_city) + IF(SELF.orig_city <> '',',','')
																						+ ' '+ SELF.orig_state	+ ' '+SELF.orig_zip[..5])),LEFT,RIGHT);
			SELF.provider_id                    := TRIM(Stringlib.StringToUpperCase(l.provider_id),LEFT,RIGHT);
			SELF.date_first_seen                := '0';
			SELF.date_last_seen                 := '0';
			SELF.clean_birthdate                := IF(l.birthdate NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.birthdate,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic1_begin_date          := IF(l.lic1_begin_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic1_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic1_end_date            := IF(l.lic1_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic1_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic2_begin_date          := IF(l.lic2_begin_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic2_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic2_end_date            := IF(l.lic2_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic2_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic3_begin_date          := IF(l.lic3_begin_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic3_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic3_end_date            := IF(l.lic3_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic3_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic4_begin_date          := IF(l.lic4_begin_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic4_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic4_end_date            := IF(l.lic4_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic4_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic5_begin_date          := IF(l.lic5_begin_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic5_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic5_end_date            := IF(l.lic5_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic5_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_sanc1_date               := IF(l.sanc1_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.sanc1_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');;
			SELF.clean_sanc2_date               := IF(l.sanc2_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.sanc2_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_sanc3_date               := IF(l.sanc3_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.sanc3_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_sanc4_date               := IF(l.sanc4_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.sanc4_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_sanc5_date               := IF(l.sanc5_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.sanc5_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_sanc6_date               := IF(l.sanc6_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.sanc6_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_sanc7_date               := IF(l.sanc7_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.sanc7_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_sanc8_date               := IF(l.sanc8_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.sanc8_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_sanc9_date               := IF(l.sanc9_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.sanc9_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_sanc10_date              := IF(l.sanc10_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.sanc10_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_sanc1_rein_date          := IF(l.sanc1_rein_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.sanc1_rein_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_sanc2_rein_date          := IF(l.sanc2_rein_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.sanc2_rein_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_sanc3_rein_date          := IF(l.sanc3_rein_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.sanc3_rein_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_sanc4_rein_date          := IF(l.sanc4_rein_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.sanc4_rein_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_sanc5_rein_date          := IF(l.sanc5_rein_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.sanc5_rein_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_sanc6_rein_date          := IF(l.sanc6_rein_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.sanc6_rein_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_sanc7_rein_date          := IF(l.sanc7_rein_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.sanc7_rein_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_sanc8_rein_date          := IF(l.sanc8_rein_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.sanc8_rein_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_sanc9_rein_date          := IF(l.sanc9_rein_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.sanc9_rein_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_sanc10_rein_date         := IF(l.sanc10_rein_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.sanc10_rein_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_date_of_death            := IF(l.date_of_death NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.date_of_death,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_last_update_date         := IF(l.last_update_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.last_update_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_dea_num1_deact_date      := IF(l.dea_num1_deact_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.dea_num1_deact_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_dea_num2_deact_date      := IF(l.dea_num2_deact_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.dea_num2_deact_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_dea_num3_deact_date      := IF(l.dea_num3_deact_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.dea_num3_deact_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_dea_num4_deact_date      := IF(l.dea_num4_deact_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.dea_num4_deact_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_dea_num5_deact_date      := IF(l.dea_num5_deact_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.dea_num5_deact_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_dea_num6_deact_date      := IF(l.dea_num6_deact_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.dea_num6_deact_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_dea_num7_deact_date      := IF(l.dea_num7_deact_date  NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.dea_num7_deact_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_dea_num8_deact_date      := IF(l.dea_num8_deact_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.dea_num8_deact_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_dea_num9_deact_date      := IF(l.dea_num9_deact_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.dea_num9_deact_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_dea_num10_deact_date     := IF(l.dea_num10_deact_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.dea_num10_deact_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_npi_deact_date           := IF(l.npi_deact_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.npi_deact_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_dea_num1_exp             := IF(l.dea_num1_exp  NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.dea_num1_exp,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_dea_num2_exp             := IF(l.dea_num2_exp  NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.dea_num2_exp,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_dea_num3_exp             := IF(l.dea_num3_exp  NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.dea_num3_exp,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_dea_num4_exp             := IF(l.dea_num4_exp NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.dea_num4_exp,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_dea_num5_exp             := IF(l.dea_num5_exp NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.dea_num5_exp,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_dea_num6_exp             := IF(l.dea_num6_exp  NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.dea_num6_exp,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_dea_num7_exp             := IF(l.dea_num7_exp  NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.dea_num7_exp,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_dea_num8_exp             := IF(l.dea_num8_exp NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.dea_num8_exp,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_dea_num9_exp             := IF(l.dea_num9_exp NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.dea_num9_exp,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_dea_num10_exp            := IF(l.dea_num10_exp NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.dea_num10_exp,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.isTest													:= IF(l.isTest = true, true, false);
			SELF.record_type										:= 'C';
			SELF  															:= L;
			SELF 																:= [];
		END;

		std_input := NORMALIZE(input, 12, tMapping(LEFT, COUNTER))(normed_addr_rec_type='1' OR Prepped_addr1<>'' AND first_name<>'',last_name<>'');
		return std_input;
	END;

	EXPORT Basc_Claims	:= FUNCTION
		input := MPRD.InFile_Preprocessor(filedate,pUseProd).Prepped_basc_claims;

		MPRD.Layouts.basc_claims_base tMapping(MPRD.Layouts.basc_claims_in L, INTEGER C) := TRANSFORM
			SELF.src    := 'QN';
			SELF.Date_vendor_first_reported     := (UNSIGNED)filedate;
			SELF.Date_vendor_last_reported      := (UNSIGNED)filedate;
			SELF.clean_prac_phone1 							:= IF(ut.CleanPhone(L.prac_phone1) [1] NOT IN ['0','1'],ut.CleanPhone(L.prac_phone1), '') ;
			SELF.clean_bill_phone1 							:= IF(ut.CleanPhone(L.bill_phone1) [1] NOT IN ['0','1'],ut.CleanPhone(L.bill_phone1), '') ;
			SELF.name_in												:= TRIM(Stringlib.StringToUpperCase(L.name_in), LEFT, RIGHT);
			SELF.prac_company1_in								:= TRIM(Stringlib.StringToUpperCase(L.prac_company1_in), LEFT, RIGHT);
			SELF.prac_company1_name							:= TRIM(Stringlib.StringToUpperCase(L.prac_company1_name), LEFT, RIGHT);
			SELF.clean_prac1_company_name				:= IF(L.prac_company1_name<> '', ut.CleanCompany(L.prac_company1_name), '');
			SELF.group_key											:= TRIM(L.group_key, LEFT, RIGHT);
			SELF.full_name											:= TRIM(Stringlib.StringToUpperCase(L.full_name), LEFT, RIGHT);
			SELF.pre_name												:= TRIM(Stringlib.StringToUpperCase(L.pre_name), LEFT, RIGHT);
			SELF.first_name											:= TRIM(Stringlib.StringToUpperCase(L.first_name), LEFT, RIGHT);
			SELF.middle_name										:= TRIM(Stringlib.StringToUpperCase(L.middle_name), LEFT, RIGHT);
			SELF.last_name											:= TRIM(Stringlib.StringToUpperCase(L.last_name), LEFT, RIGHT);
			SELF.maturity_suffix								:= TRIM(Stringlib.StringToUpperCase(L.maturity_suffix), LEFT, RIGHT);
			SELF.lic1_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic1_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic1_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic1_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.last_update_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.last_update_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.npi_deact_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.npi_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);

			SELF.orig_adresss                   := CHOOSE(C,l.prac1_primary_address,l.prac1_secondary_address,l.bill1_primary_address,l.bill1_secondary_address);
			SELF.orig_city                      := CHOOSE(C,l.prac1_city,l.prac1_city,l.bill1_city,l.bill1_city);
			SELF.orig_state                     := CHOOSE(C,l.prac1_state,l.prac1_state,l.bill1_state,l.bill1_state);
			SELF.orig_zip                       := CHOOSE(C,l.prac1_zip,l.prac1_zip,l.bill1_zip,l.bill1_zip);
			SELF.normed_addr_rec_type           := CHOOSE(C,'1','2','3','4');
			SELF.Prepped_addr1                  := IF((Stringlib.StringToUpperCase(SELF.orig_adresss) <> '\\N'),
																							TRIM(Stringlib.StringToUpperCase(CHOOSE(C,SELF.orig_adresss)), LEFT, RIGHT),'');
			SELF.Prepped_addr2                  := TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(
																							TRIM(SELF.orig_city) + IF(SELF.orig_city <> '',',','')
																							+ ' '+ SELF.orig_state	+ ' '+SELF.orig_zip[..5])),LEFT,RIGHT);
			SELF.date_first_seen                := '0';
			SELF.date_last_seen                 := '0';
			SELF.clean_lic1_begin_date          := IF(l.lic1_begin_date NOT IN invalid_dates, _validate.date.fCorrectedDateString(TRIM(stringlib.stringfilterout(l.lic1_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic1_end_date            := IF(l.lic1_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic1_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_last_update_date         := IF(l.last_update_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.last_update_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_npi_deact_date           := IF(l.npi_deact_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.npi_deact_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.isTest													:= IF(l.isTest = true, true, false);
			SELF.record_type										:= 'C';
			SELF  															:= L;
			SELF 																:= [];
		END;

		std_input := NORMALIZE(input, 4, tMapping(LEFT, COUNTER))(normed_addr_rec_type='1' OR Prepped_addr1<>'' AND first_name<>'',last_name<>'');
		return std_input;
	END;

	EXPORT Claims_Address_Master	:= FUNCTION
		input := MPRD.InFile_Preprocessor(filedate,pUseProd).Prepped_claims_address_master;

		MPRD.Layouts.claims_address_master_base tMapping(MPRD.layouts.claims_address_master_in L, INTEGER C) := TRANSFORM
			SELF.src    := 'QN';
			SELF.Date_vendor_first_reported     := (UNSIGNED)filedate;
			SELF.Date_vendor_last_reported      := (UNSIGNED)filedate;
			SELF.service_company 							  := TRIM(Stringlib.StringToUpperCase(L.service_company), LEFT, RIGHT);
			SELF.clean_service_company					:= IF(L.service_company<> '', ut.CleanCompany(L.service_company), '');
			SELF.clean_service_name2					  := IF(L.service_name2<> '', ut.CleanCompany(L.service_name2), '');
			SELF.orig_adresss                   := CHOOSE(C,l.primary_address,IF(l.secondary_address ='\\N','',l.secondary_address));
			SELF.orig_city                      := CHOOSE(C,l.city,l.city);
			SELF.orig_state                     := CHOOSE(C,l.state,l.state);
			SELF.orig_zip                       := CHOOSE(C,l.zip,l.zip,l.zip,l.zip);
			SELF.latest_clm_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.latest_clm_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.earliest_clm_date							:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.earliest_clm_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.insert_date										:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.insert_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.normed_addr_rec_type           := CHOOSE(C,'1','2');
			SELF.Prepped_addr1                  := TRIM(Stringlib.StringToUpperCase(CHOOSE(C,SELF.orig_adresss)), LEFT, RIGHT);
			SELF.Prepped_addr2                  := TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(
																							TRIM(SELF.orig_city) + IF(SELF.orig_city <> '',',','')
																							+ ' '+ SELF.orig_state	+ ' '+SELF.orig_zip[..5])),LEFT,RIGHT);
			SELF.date_first_seen                := '0';
			SELF.date_last_seen                 := '0';
			SELF.clean_latest_clm_Date          := IF(l.latest_clm_Date NOT IN invalid_dates, _validate.date.fCorrectedDateString(TRIM(stringlib.stringfilterout(l.latest_clm_Date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_earliest_clm_Date        := IF(l.earliest_clm_Date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.earliest_clm_Date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.isTest													:= IF(l.isTest = true, true, false);
			SELF.record_type										:= 'C';
			SELF  															:= L;
			SELF 																:= [];
		END;

		std_input := NORMALIZE(input, 2, tMapping(LEFT, COUNTER))(normed_addr_rec_type='1' OR Prepped_addr1<>'');
		return std_input;
	END;

	EXPORT npi_extension	:= FUNCTION
		input := MPRD.InFile_Preprocessor(filedate,pUseProd).Prepped_npi_extension;

		MPRD.Layouts.npi_extension_base tMapping(MPRD.layouts.npi_extension_in L, INTEGER C) := TRANSFORM, SKIP(l.other_first_name = '' AND l.other_middle_name ='' AND l.other_last_name = ''AND  l.authorized_first_name = '' AND l.authorized_middle_name ='' AND l.authorized_last_name = '')
			SELF.src   												  := 'QN';
			SELF.Date_vendor_first_reported     := (UNSIGNED)filedate;
			SELF.Date_vendor_last_reported      := (UNSIGNED)filedate;
			SELF.other_name_in									:= TRIM(Stringlib.StringToUpperCase(L.other_name_in), LEFT, RIGHT);
			SELF.other_fullname									:= TRIM(Stringlib.StringToUpperCase(L.other_fullname), LEFT, RIGHT);
			SELF.other_pre_name									:= TRIM(Stringlib.StringToUpperCase(L.other_pre_name	), LEFT, RIGHT);
			SELF.other_first_name								:= TRIM(Stringlib.StringToUpperCase(L.other_first_name), LEFT, RIGHT);
			SELF.other_middle_name							:= TRIM(Stringlib.StringToUpperCase(L.other_middle_name), LEFT, RIGHT);
			SELF.other_last_name								:= TRIM(Stringlib.StringToUpperCase(L.other_last_name), LEFT, RIGHT);
			SELF.other_maturity_suffix					:= TRIM(Stringlib.StringToUpperCase(L.other_maturity_suffix), LEFT, RIGHT);
			SELF.parent_org_lbn_in							:= TRIM(Stringlib.StringToUpperCase(L.parent_org_lbn_in), LEFT, RIGHT);
			SELF.authorized_name_in							:= TRIM(Stringlib.StringToUpperCase(L.authorized_name_in), LEFT, RIGHT);
			SELF.authorized_fullname						:= TRIM(Stringlib.StringToUpperCase(L.authorized_fullname), LEFT, RIGHT);
			SELF.authorized_pre_name						:= TRIM(Stringlib.StringToUpperCase(L.authorized_pre_name	), LEFT, RIGHT);
			SELF.authorized_first_name					:= TRIM(Stringlib.StringToUpperCase(L.authorized_first_name), LEFT, RIGHT);
			SELF.authorized_middle_name					:= TRIM(Stringlib.StringToUpperCase(L.authorized_middle_name), LEFT, RIGHT);
			SELF.authorized_last_name						:= TRIM(Stringlib.StringToUpperCase(L.authorized_last_name), LEFT, RIGHT);
			SELF.authorized_maturity_suffix			:= TRIM(Stringlib.StringToUpperCase(L.authorized_maturity_suffix), LEFT, RIGHT);
			SELF.normed_name_rec_type           := CHOOSE(C,'1','2');
			SELF.first_name                     := CHOOSE(C,TRIM(Stringlib.StringToUpperCase(L.other_first_name), LEFT, RIGHT),TRIM(Stringlib.StringToUpperCase(L.authorized_first_name), LEFT, RIGHT));
			SELF.middle_name                    := CHOOSE(C,TRIM(Stringlib.StringToUpperCase(L.other_middle_name), LEFT, RIGHT),TRIM(Stringlib.StringToUpperCase(L.authorized_middle_name), LEFT, RIGHT));
			SELF.last_name                      := CHOOSE(C,TRIM(Stringlib.StringToUpperCase(L.other_last_name), LEFT, RIGHT),TRIM(Stringlib.StringToUpperCase(L.authorized_last_name), LEFT, RIGHT));
			SELF.maturity_suffix                := CHOOSE(C,TRIM(Stringlib.StringToUpperCase(L.other_maturity_suffix), LEFT, RIGHT),TRIM(Stringlib.StringToUpperCase(L.authorized_maturity_suffix), LEFT, RIGHT));
			SELF.date_last_seen                 := '0';
			SELF.lic1_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic1_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic1_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic1_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic2_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic2_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic2_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic2_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic3_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic3_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic3_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic3_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic4_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic4_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic4_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic4_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic5_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic5_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic5_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic5_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic6_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic6_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic6_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic6_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic7_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic7_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic7_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic7_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic8_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic8_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic8_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic8_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic9_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic9_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic9_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic9_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic10_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic10_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic10_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic10_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic11_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic11_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic11_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic11_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic12_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic12_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic12_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic12_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic13_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic13_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic13_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic13_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic14_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic14_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic14_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic14_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic15_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic15_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic15_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic15_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.npi_deact_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.npi_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.npi_enum_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.npi_enum_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.npi_react_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.npi_react_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.clean_lic1_begin_date      		:= IF(l.lic1_begin_date NOT IN invalid_dates, _validate.date.fCorrectedDateString(TRIM(stringlib.stringfilterout(l.lic1_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic1_end_date        		:= IF(l.lic1_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic1_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic2_begin_date      		:= IF(l.lic2_begin_date NOT IN invalid_dates, _validate.date.fCorrectedDateString(TRIM(stringlib.stringfilterout(l.lic2_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic2_end_date        		:= IF(l.lic2_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic2_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic3_begin_date      		:= IF(l.lic3_begin_date NOT IN invalid_dates, _validate.date.fCorrectedDateString(TRIM(stringlib.stringfilterout(l.lic3_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic3_end_date        		:= IF(l.lic3_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic3_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic4_begin_date      		:= IF(l.lic4_begin_date NOT IN invalid_dates, _validate.date.fCorrectedDateString(TRIM(stringlib.stringfilterout(l.lic4_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic4_end_date        		:= IF(l.lic4_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic4_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic5_begin_date      		:= IF(l.lic5_begin_date NOT IN invalid_dates, _validate.date.fCorrectedDateString(TRIM(stringlib.stringfilterout(l.lic5_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic5_end_date        		:= IF(l.lic5_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic5_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic6_begin_date      		:= IF(l.lic6_begin_date NOT IN invalid_dates, _validate.date.fCorrectedDateString(TRIM(stringlib.stringfilterout(l.lic6_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic6_end_date        		:= IF(l.lic6_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic6_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic7_begin_date      		:= IF(l.lic7_begin_date NOT IN invalid_dates, _validate.date.fCorrectedDateString(TRIM(stringlib.stringfilterout(l.lic7_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic7_end_date        		:= IF(l.lic7_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic7_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic8_begin_date      		:= IF(l.lic8_begin_date NOT IN invalid_dates, _validate.date.fCorrectedDateString(TRIM(stringlib.stringfilterout(l.lic8_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic8_end_date        		:= IF(l.lic8_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic8_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic9_begin_date      		:= IF(l.lic9_begin_date NOT IN invalid_dates, _validate.date.fCorrectedDateString(TRIM(stringlib.stringfilterout(l.lic9_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic9_end_date        		:= IF(l.lic9_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic9_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic10_begin_date      		:= IF(l.lic10_begin_date NOT IN invalid_dates, _validate.date.fCorrectedDateString(TRIM(stringlib.stringfilterout(l.lic10_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic10_end_date        		:= IF(l.lic10_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic10_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic11_begin_date      		:= IF(l.lic11_begin_date NOT IN invalid_dates, _validate.date.fCorrectedDateString(TRIM(stringlib.stringfilterout(l.lic11_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic11_end_date        		:= IF(l.lic11_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic11_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic12_begin_date      		:= IF(l.lic12_begin_date NOT IN invalid_dates, _validate.date.fCorrectedDateString(TRIM(stringlib.stringfilterout(l.lic12_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic12_end_date        		:= IF(l.lic12_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic12_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic13_begin_date      		:= IF(l.lic13_begin_date NOT IN invalid_dates, _validate.date.fCorrectedDateString(TRIM(stringlib.stringfilterout(l.lic13_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic13_end_date        		:= IF(l.lic13_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic13_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic14_begin_date      		:= IF(l.lic14_begin_date NOT IN invalid_dates, _validate.date.fCorrectedDateString(TRIM(stringlib.stringfilterout(l.lic14_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic14_end_date        		:= IF(l.lic14_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic14_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic15_begin_date      		:= IF(l.lic15_begin_date NOT IN invalid_dates, _validate.date.fCorrectedDateString(TRIM(stringlib.stringfilterout(l.lic15_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic15_end_date        		:= IF(l.lic15_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic15_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_npi_deact_date        		:= IF(l.npi_deact_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.npi_deact_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_npi_enum_date						:= IF(l.npi_enum_date NOT IN invalid_dates,_validate.Date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.npi_enum_date,'-.>$!%*@=?&\''), LEFT,RIGHT),false),'0');
			SELF.clean_npi_react_date						:= IF(l.npi_react_date NOT IN invalid_dates,_validate.Date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.npi_react_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.isTest													:= IF(l.isTest = true, true, false);
			SELF.record_type										:= 'C';
			SELF  															:= L;
			SELF 																:= [];
		END;

		std_input := NORMALIZE(input, 2, tMapping(LEFT, COUNTER))(normed_name_rec_type='2' OR  first_name<>'',last_name<>'');
		return std_input;
	END;

	EXPORT npi_extension_facility := FUNCTION
		input := MPRD.InFile_Preprocessor(filedate,pUseProd).Prepped_npi_extension_facility;

		MPRD.Layouts.npi_extension_facility_base tMapping(MPRD.layouts.npi_extension_facility_in L, INTEGER C) := TRANSFORM
			SELF.src    												:= 'QN';
			SELF.Date_vendor_first_reported     := (UNSIGNED)filedate;
			SELF.Date_vendor_last_reported      := (UNSIGNED)filedate;
			SELF.other_name_in									:= TRIM(Stringlib.StringToUpperCase(L.other_name_in), LEFT, RIGHT);
			SELF.other_fullname									:= TRIM(Stringlib.StringToUpperCase(L.other_fullname), LEFT, RIGHT);
			SELF.other_pre_name									:= TRIM(Stringlib.StringToUpperCase(L.other_pre_name	), LEFT, RIGHT);
			SELF.other_first_name								:= TRIM(Stringlib.StringToUpperCase(L.other_first_name), LEFT, RIGHT);
			SELF.other_middle_name							:= TRIM(Stringlib.StringToUpperCase(L.other_middle_name), LEFT, RIGHT);
			SELF.other_last_name								:= TRIM(Stringlib.StringToUpperCase(L.other_last_name), LEFT, RIGHT);
			SELF.other_maturity_suffix					:= TRIM(Stringlib.StringToUpperCase(L.other_maturity_suffix), LEFT, RIGHT);
			SELF.parent_org_lbn_in							:= TRIM(Stringlib.StringToUpperCase(L.parent_org_lbn_in), LEFT, RIGHT);
			SELF.authorized_name_in							:= TRIM(Stringlib.StringToUpperCase(L.authorized_name_in), LEFT, RIGHT);
			SELF.authorized_fullname						:= TRIM(Stringlib.StringToUpperCase(L.authorized_fullname), LEFT, RIGHT);
			SELF.authorized_pre_name						:= TRIM(Stringlib.StringToUpperCase(L.authorized_pre_name	), LEFT, RIGHT);
			SELF.authorized_first_name					:= TRIM(Stringlib.StringToUpperCase(L.authorized_first_name), LEFT, RIGHT);
			SELF.authorized_middle_name					:= TRIM(Stringlib.StringToUpperCase(L.authorized_middle_name), LEFT, RIGHT);
			SELF.authorized_last_name						:= TRIM(Stringlib.StringToUpperCase(L.authorized_last_name), LEFT, RIGHT);
			SELF.authorized_maturity_suffix			:= TRIM(Stringlib.StringToUpperCase(L.authorized_maturity_suffix), LEFT, RIGHT);
			SELF.normed_name_rec_type           := CHOOSE(C,'1','2');
			SELF.first_name                     := CHOOSE(C,TRIM(Stringlib.StringToUpperCase(L.other_first_name), LEFT, RIGHT),TRIM(Stringlib.StringToUpperCase(L.authorized_first_name), LEFT, RIGHT));
			SELF.middle_name                    := CHOOSE(C,TRIM(Stringlib.StringToUpperCase(L.other_middle_name), LEFT, RIGHT),TRIM(Stringlib.StringToUpperCase(L.authorized_middle_name), LEFT, RIGHT));
			SELF.last_name                      := CHOOSE(C,TRIM(Stringlib.StringToUpperCase(L.other_last_name), LEFT, RIGHT),TRIM(Stringlib.StringToUpperCase(L.authorized_last_name), LEFT, RIGHT));
			SELF.maturity_suffix                := CHOOSE(C,TRIM(Stringlib.StringToUpperCase(L.other_maturity_suffix), LEFT, RIGHT),TRIM(Stringlib.StringToUpperCase(L.authorized_maturity_suffix), LEFT, RIGHT));
			SELF.date_last_seen                 := '0';
			SELF.lic1_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic1_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic1_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic1_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic2_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic2_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic2_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic2_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic3_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic3_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic3_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic3_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic4_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic4_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic4_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic4_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic5_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic5_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic5_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic5_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic6_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic6_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic6_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic6_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic7_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic7_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic7_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic7_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic8_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic8_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic8_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic8_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic9_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic9_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic9_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic9_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic10_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic10_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic10_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic10_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic11_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic11_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic11_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic11_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic12_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic12_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic12_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic12_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic13_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic13_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic13_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic13_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic14_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic14_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic14_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic14_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic15_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic15_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic15_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic15_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.npi_deact_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.npi_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.npi_enum_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.npi_enum_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.npi_react_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.npi_react_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.clean_lic1_begin_date          := IF(l.lic1_begin_date NOT IN invalid_dates, _validate.date.fCorrectedDateString(TRIM(stringlib.stringfilterout(l.lic1_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic1_end_date        		:= IF(l.lic1_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic1_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic2_begin_date      		:= IF(l.lic2_begin_date NOT IN invalid_dates, _validate.date.fCorrectedDateString(TRIM(stringlib.stringfilterout(l.lic2_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic2_end_date        		:= IF(l.lic2_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic2_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic3_begin_date      		:= IF(l.lic3_begin_date NOT IN invalid_dates, _validate.date.fCorrectedDateString(TRIM(stringlib.stringfilterout(l.lic3_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic3_end_date        		:= IF(l.lic3_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic3_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic4_begin_date      		:= IF(l.lic4_begin_date NOT IN invalid_dates, _validate.date.fCorrectedDateString(TRIM(stringlib.stringfilterout(l.lic4_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic4_end_date        		:= IF(l.lic4_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic4_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic5_begin_date      		:= IF(l.lic5_begin_date NOT IN invalid_dates, _validate.date.fCorrectedDateString(TRIM(stringlib.stringfilterout(l.lic5_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic5_end_date        		:= IF(l.lic5_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic5_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic6_begin_date      		:= IF(l.lic6_begin_date NOT IN invalid_dates, _validate.date.fCorrectedDateString(TRIM(stringlib.stringfilterout(l.lic6_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic6_end_date        		:= IF(l.lic6_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic6_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic7_begin_date      		:= IF(l.lic7_begin_date NOT IN invalid_dates, _validate.date.fCorrectedDateString(TRIM(stringlib.stringfilterout(l.lic7_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic7_end_date        		:= IF(l.lic7_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic7_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic8_begin_date      		:= IF(l.lic8_begin_date NOT IN invalid_dates, _validate.date.fCorrectedDateString(TRIM(stringlib.stringfilterout(l.lic8_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic8_end_date        		:= IF(l.lic8_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic8_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic9_begin_date      		:= IF(l.lic9_begin_date NOT IN invalid_dates, _validate.date.fCorrectedDateString(TRIM(stringlib.stringfilterout(l.lic9_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic9_end_date        		:= IF(l.lic9_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic9_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic10_begin_date     		:= IF(l.lic10_begin_date NOT IN invalid_dates, _validate.date.fCorrectedDateString(TRIM(stringlib.stringfilterout(l.lic10_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic10_end_date       		:= IF(l.lic10_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic10_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic11_begin_date     		:= IF(l.lic11_begin_date NOT IN invalid_dates, _validate.date.fCorrectedDateString(TRIM(stringlib.stringfilterout(l.lic11_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic11_end_date        		:= IF(l.lic11_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic11_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic12_begin_date      		:= IF(l.lic12_begin_date NOT IN invalid_dates, _validate.date.fCorrectedDateString(TRIM(stringlib.stringfilterout(l.lic12_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic12_end_date        		:= IF(l.lic12_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic12_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic13_begin_date      		:= IF(l.lic13_begin_date NOT IN invalid_dates, _validate.date.fCorrectedDateString(TRIM(stringlib.stringfilterout(l.lic13_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic13_end_date        		:= IF(l.lic13_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic13_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic14_begin_date      		:= IF(l.lic14_begin_date NOT IN invalid_dates, _validate.date.fCorrectedDateString(TRIM(stringlib.stringfilterout(l.lic14_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic14_end_date        		:= IF(l.lic14_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic14_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic15_begin_date      		:= IF(l.lic15_begin_date NOT IN invalid_dates, _validate.date.fCorrectedDateString(TRIM(stringlib.stringfilterout(l.lic15_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic15_end_date        		:= IF(l.lic15_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic15_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_npi_deact_date        		:= IF(l.npi_deact_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.npi_deact_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_npi_enum_date        		:= IF(l.npi_enum_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.npi_enum_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_npi_react_date        		:= IF(l.npi_react_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.npi_react_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.isTest													:= IF(l.isTest = true, true, false);
			SELF.record_type										:= 'C';
			SELF  															:=  L;
			SELF 																:= [];
		END;

		std_input := NORMALIZE(input, 2, tMapping(LEFT, COUNTER))(normed_name_rec_type='2' OR  first_name<>'',last_name<>'');;
		return std_input;
	END;

	EXPORT basc_deceased	:= FUNCTION
		input := MPRD.InFile_Preprocessor(filedate,pUseProd).Prepped_basc_deceased;

		MPRD.layouts.basc_deceased_base tMapping(MPRD.layouts.basc_deceased_in L, INTEGER C) := TRANSFORM
			SELF.src    												:= 'QN';
			SELF.Date_vendor_first_reported     := (UNSIGNED)filedate;
			SELF.Date_vendor_last_reported      := (UNSIGNED)filedate;
			SELF.group_key											:= TRIM(L.group_key, LEFT, RIGHT);
			SELF.full_name											:= IF(L.full_name NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.full_name), LEFT, RIGHT),'');
			SELF.pre_name												:= IF(L.pre_name NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.pre_name), LEFT, RIGHT),'');
			SELF.first_name											:= IF(L.first_name NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.first_name), LEFT, RIGHT),'');
			SELF.middle_name										:= IF(L.middle_name NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.middle_name), LEFT, RIGHT),'');
			SELF.last_name											:= IF(L.last_name NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.last_name), LEFT, RIGHT),'');
			SELF.maturity_suffix								:= IF(L.maturity_suffix NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.maturity_suffix), LEFT, RIGHT),'');
			SELF.other_suffix								    := IF(L.other_suffix NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.other_suffix), LEFT, RIGHT),'');
			SELF.date_of_death									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.date_of_death,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.birthdate											:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.birthdate,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.incomplete_date_of_death				:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.incomplete_date_of_death,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.incomplete_birthdate						:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.incomplete_birthdate,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.date_first_seen                := '0';
			SELF.date_last_seen                 := '0';
			SELF.clean_birthdate                := IF(l.birthdate NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.birthdate,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_incomplete_birthdate     := IF(l.incomplete_birthdate NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.incomplete_birthdate,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_date_of_death            := IF(l.date_of_death NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.date_of_death,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_incomplete_date_of_death := IF(l.incomplete_date_of_death NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.incomplete_date_of_death,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.isTest													:= IF(l.isTest = true, true, false);
			SELF.record_type										:= 'C';
			SELF  															:= L;
			SELF 																:= [];
		END;

		std_input := PROJECT(input, tMapping(LEFT, COUNTER));
		return std_input;
	END;

	EXPORT basc_addr	:= FUNCTION
		input := MPRD.Files(filedate,pUseProd).basc_addr_file;

		MPRD.layouts.basc_addr_base tMapping(MPRD.layouts.basc_addr_in L, C) := TRANSFORM
			SELF.src    												:= 'QN';
			SELF.Date_vendor_first_reported 		:= (UNSIGNED)filedate;
			SELF.Date_vendor_last_reported 			:= (UNSIGNED)filedate;
			SELF.clean_phone 									  := IF(ut.CleanPhone(L.prac_phone1) [1] NOT IN ['0','1'],ut.CleanPhone(L.prac_phone1), '');
			SELF.prac_company1_in								:= TRIM(Stringlib.StringToUpperCase(L.prac_company1_in), LEFT, RIGHT);
			SELF.prac_company1_name							:= TRIM(Stringlib.StringToUpperCase(L.prac_company1_name), LEFT, RIGHT);
			SELF.clean_prac1_company_name			  := IF(L.prac_company1_name<> '', ut.CleanCompany(L.prac_company1_name), '');
			SELF.name_in												:= TRIM(Stringlib.StringToUpperCase(L.name_in), LEFT, RIGHT);
			SELF.dba_in													:= TRIM(Stringlib.StringToUpperCase(L.dba_in), LEFT, RIGHT);
			SELF.dba_name												:= TRIM(Stringlib.StringToUpperCase(L.dba_name), LEFT, RIGHT);
			SELF.clean_dba_name									:= IF(L.dba_name<> '', ut.CleanCompany(L.dba_name), '');
			SELF.bill_company1_in								:= TRIM(Stringlib.StringToUpperCase(L.bill_company1_in), LEFT, RIGHT);
			SELF.group_key											:= TRIM(L.group_key, LEFT, RIGHT);
			SELF.orig_adresss                   := CHOOSE(C,l.prac1_primary_address,IF(l.prac1_secondary_address ='\\N','',l.prac1_secondary_address),l.bill1_primary_address,IF(l.bill1_secondary_address='\\N','',l.bill1_secondary_address));
			SELF.orig_city                      := CHOOSE(C,l.prac1_city,l.prac1_city,l.bill1_city,l.bill1_city);
			SELF.orig_state                     := CHOOSE(C,l.prac1_state,l.prac1_state,l.bill1_state,l.bill1_state);
			SELF.orig_zip                       := CHOOSE(C,l.prac1_zip,l.prac1_zip,l.bill1_zip,l.bill1_zip);
			SELF.normed_addr_rec_type           := CHOOSE(C,'1','2','3','4');
			SELF.Prepped_addr1                  := TRIM(Stringlib.StringToUpperCase(CHOOSE(C,SELF.orig_adresss)), LEFT, RIGHT);
			SELF.Prepped_addr2                  := TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(
																					TRIM(SELF.orig_city) + IF(SELF.orig_city <> '',',','')
																					+ ' '+ SELF.orig_state	+ ' '+SELF.orig_zip[..5])),LEFT,RIGHT);
			SELF.date_first_seen                := '0';
			SELF.date_last_seen                 := '0';
			SELF.dea_num1_exp										:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.dea_num1_exp,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic1_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic1_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic1_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic1_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic2_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic2_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic2_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic2_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic3_begin_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic3_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.lic3_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic3_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.medicare_fac_num_term_date			:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.medicare_fac_num_term_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.last_update_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.last_update_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.sanc1_date											:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.sanc1_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.dea_num1_deact_date						:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.dea_num1_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.npi_deact_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.npi_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.sanc1_rein_date								:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.sanc1_rein_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.clia_cert_eff_date							:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.clia_cert_eff_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.clia_end_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.clia_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.clean_lic1_begin_date          := IF(l.lic1_begin_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic1_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic1_end_date            := IF(l.lic1_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic1_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic2_begin_date          := IF(l.lic2_begin_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic2_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic2_end_date            := IF(l.lic1_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic2_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic3_begin_date          := IF(l.lic3_begin_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic3_begin_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_lic3_end_date            := IF(l.lic3_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.lic3_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_last_update_date         := IF(l.last_update_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.last_update_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_sanc1_date               := IF(l.sanc1_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.sanc1_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_dea_num1_deact_date      := IF(l.dea_num1_deact_date  NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.dea_num1_deact_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_npi_deact_date           := IF(l.npi_deact_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.npi_deact_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_sanc1_rein_date          := IF(l.sanc1_rein_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.sanc1_rein_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_clia_cert_eff_date       := IF(l.clia_cert_eff_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.clia_cert_eff_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_clia_end_date            := IF(l.clia_end_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.clia_end_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_dea_num1_exp             := IF(l.dea_num1_exp  NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.dea_num1_exp,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_medicare_fac_num_term_date:=IF(l.medicare_fac_num_term_date  NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.medicare_fac_num_term_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.record_type										:= 'C';
			SELF  															:= L;
			SELF 																:= [];
		END;

		std_input := NORMALIZE(input, 4, tMapping(LEFT, COUNTER))(normed_addr_rec_type='1' OR Prepped_addr1<>'' );
		return std_input;
	END;

	EXPORT client_data	:= FUNCTION
		input := MPRD.Files(filedate,pUseProd).client_data_file;

		MPRD.layouts.client_data_base tMapping(MPRD.layouts.client_data_in L, INTEGER C) := TRANSFORM
			SELF.src    												:= 'QN';
			SELF.Date_vendor_first_reported     := (UNSIGNED)filedate;
			SELF.Date_vendor_last_reported      := (UNSIGNED)filedate;
			SELF.clean_prac_phone 							:= IF(ut.CleanPhone(L.prac_phone) [1] NOT IN ['0','1'],ut.CleanPhone(L.prac_phone), '') ;
			SELF.group_key											:= TRIM(L.group_key, LEFT, RIGHT);
			SELF.full_name											:= TRIM(Stringlib.StringToUpperCase(L.full_name), LEFT, RIGHT);
			SELF.first_name											:= TRIM(Stringlib.StringToUpperCase(L.first_name), LEFT, RIGHT);
			SELF.middle_name										:= TRIM(Stringlib.StringToUpperCase(L.middle_name), LEFT, RIGHT);
			SELF.last_name											:= TRIM(Stringlib.StringToUpperCase(L.last_name), LEFT, RIGHT);
			SELF.maturity_suffix								:= TRIM(Stringlib.StringToUpperCase(L.maturity_suffix), LEFT, RIGHT);
			SELF.orig_adresss                   := CHOOSE(C,l.prac_primary_address,l.prac_secondary_address);
			SELF.orig_city                      := CHOOSE(C,l.prac_city,l.prac_city);
			SELF.orig_state                     := CHOOSE(C,l.prac_state,l.prac_state);
			SELF.orig_zip                       := CHOOSE(C,l.prac_zip,l.prac_zip);
			SELF.normed_addr_rec_type           := CHOOSE(C,'1','2');
			SELF.Prepped_addr1                  := TRIM(Stringlib.StringToUpperCase(CHOOSE(C,SELF.orig_adresss)), LEFT, RIGHT);
			SELF.Prepped_addr2                  := TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(
																					TRIM(SELF.orig_city) + IF(SELF.orig_city <> '',',','')
																					+ ' '+ SELF.orig_state	+ ' '+SELF.orig_zip[..5])),LEFT,RIGHT);
			SELF.medschool                     	:= TRIM(Stringlib.StringToUpperCase(l.medschool),LEFT,RIGHT);
			SELF.provider_id                    := TRIM(Stringlib.StringToUpperCase(l.provider_id),LEFT,RIGHT);
			SELF.date_first_seen                := '0';
			SELF.date_last_seen                 := '0';
			SELF.date_of_death									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.date_of_death,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.birthdate											:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.birthdate,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.load_date											:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.load_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.clean_birthdate                := IF(l.birthdate NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.birthdate,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_medschool_year           := IF(l.medschool_year   NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.medschool_year   ,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_load_date               	:= IF(l.load_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.load_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_date_of_death            := IF(l.date_of_death NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.date_of_death,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.record_type										:= 'C';
			SELF  															:= L;
			SELF 																:= [];
		END;

		std_input := NORMALIZE(input, 2, tMapping(LEFT, COUNTER))(normed_addr_rec_type='1' OR Prepped_addr1<>'');
		return std_input;
	END;

	EXPORT office_attributes	:= FUNCTION
	  input := MPRD.InFile_Preprocessor(filedate,pUseProd).Prepped_office_attributes;

	  mprd.layouts.office_attributes_base tMapping(MPRD.layouts.office_attributes_in L) := TRANSFORM
			SELF.oh_m_start_in    := IF(L.oh_m_start_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_m_start_in), LEFT, RIGHT),'');
			SELF.oh_m_start       := IF(L.oh_m_start NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_m_start), LEFT, RIGHT),'');
			SELF.oh_m_end_in      := IF(L.oh_m_end_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_m_end_in), LEFT, RIGHT),'');
			SELF.oh_m_end         := IF(L.oh_m_end NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_m_end), LEFT, RIGHT),'');
			SELF.oh_m_lunch_in    := IF(L.oh_m_lunch_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_m_lunch_in), LEFT, RIGHT),'');
			SELF.oh_m_lunch       := IF(L.oh_m_lunch NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_m_lunch), LEFT, RIGHT),'');
			SELF.oh_m_dur_in      := IF(L.oh_m_dur_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_m_dur_in), LEFT, RIGHT),'');
			SELF.oh_m_dur         := IF(L.oh_m_dur NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_m_dur), LEFT, RIGHT),'');
			SELF.oh_tu_start_in   := IF(L.oh_tu_start_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_tu_start_in), LEFT, RIGHT),'');
			SELF.oh_tu_start      := IF(L.oh_tu_start NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_tu_start), LEFT, RIGHT),'');
			SELF.oh_tu_end_in     := IF(L.oh_tu_end_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_tu_end_in), LEFT, RIGHT),'');
			SELF.oh_tu_end        := IF(L.oh_tu_end NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_tu_end), LEFT, RIGHT),'');
			SELF.oh_tu_lunch_in   := IF(L.oh_tu_lunch_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_tu_lunch_in), LEFT, RIGHT),'');
			SELF.oh_tu_lunch      := IF(L.oh_tu_lunch NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_tu_lunch), LEFT, RIGHT),'');
			SELF.oh_tu_dur_in     := IF(L.oh_tu_dur_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_tu_dur_in), LEFT, RIGHT),'');
			SELF.oh_tu_dur        := IF(L.oh_tu_dur NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_tu_dur), LEFT, RIGHT),'');
			SELF.oh_w_start_in    := IF(L.oh_w_start_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_w_start_in), LEFT, RIGHT),'');
			SELF.oh_w_start       := IF(L.oh_w_start NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_w_start), LEFT, RIGHT),'');
			SELF.oh_w_end_in      := IF(L.oh_w_end_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_w_end_in), LEFT, RIGHT),'');
			SELF.oh_w_end         := IF(L.oh_w_end NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_w_end), LEFT, RIGHT),'');
			SELF.oh_w_lunch_in    := IF(L.oh_w_lunch_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_w_lunch_in), LEFT, RIGHT),'');
			SELF.oh_w_lunch       := IF(L.oh_w_lunch NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_w_lunch), LEFT, RIGHT),'');
			SELF.oh_w_dur_in      := IF(L.oh_w_dur_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_w_dur_in), LEFT, RIGHT),'');
			SELF.oh_w_dur         := IF(L.oh_w_dur NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_w_dur), LEFT, RIGHT),'');
			SELF.oh_th_start_in   := IF(L.oh_th_start_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_th_start_in), LEFT, RIGHT),'');
			SELF.oh_th_start      := IF(L.oh_th_start NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_th_start), LEFT, RIGHT),'');
			SELF.oh_th_end_in     := IF(L.oh_th_end_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_th_end_in), LEFT, RIGHT),'');
			SELF.oh_th_end        := IF(L.oh_th_end NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_th_end), LEFT, RIGHT),'');
			SELF.oh_th_lunch_in   := IF(L.oh_th_lunch_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_th_lunch_in), LEFT, RIGHT),'');
			SELF.oh_th_lunch      := IF(L.oh_th_lunch NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_th_lunch), LEFT, RIGHT),'');
			SELF.oh_th_dur_in     := IF(L.oh_th_dur_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_th_dur_in), LEFT, RIGHT),'');
			SELF.oh_th_dur        := IF(L.oh_th_dur NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_th_dur), LEFT, RIGHT),'');
			SELF.oh_f_start_in    := IF(L.oh_f_start_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_f_start_in), LEFT, RIGHT),'');
			SELF.oh_f_start       := IF(L.oh_f_start NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_f_start), LEFT, RIGHT),'');
			SELF.oh_f_end_in      := IF(L.oh_f_end_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_f_end_in), LEFT, RIGHT),'');
			SELF.oh_f_end         := IF(L.oh_f_end NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_f_end), LEFT, RIGHT),'');
			SELF.oh_f_lunch_in    := IF(L.oh_f_lunch_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_f_lunch_in), LEFT, RIGHT),'');
			SELF.oh_f_lunch       := IF(L.oh_f_lunch NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_f_lunch), LEFT, RIGHT),'');
			SELF.oh_f_dur_in      := IF(L.oh_f_dur_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_f_dur_in), LEFT, RIGHT),'');
			SELF.oh_f_dur         := IF(L.oh_f_dur NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_f_dur), LEFT, RIGHT),'');
			SELF.oh_sa_start_in   := IF(L.oh_sa_start_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_sa_start_in), LEFT, RIGHT),'');
			SELF.oh_sa_start      := IF(L.oh_sa_start NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_sa_start), LEFT, RIGHT),'');
			SELF.oh_sa_end_in     := IF(L.oh_sa_end_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_sa_end_in), LEFT, RIGHT),'');
			SELF.oh_sa_end        := IF(L.oh_sa_end NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_sa_end), LEFT, RIGHT),'');
			SELF.oh_sa_lunch_in   := IF(L.oh_sa_lunch_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_sa_lunch_in), LEFT, RIGHT),'');
			SELF.oh_sa_lunch      := IF(L.oh_sa_lunch NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_sa_lunch), LEFT, RIGHT),'');
			SELF.oh_sa_dur_in     := IF(L.oh_sa_dur_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_sa_dur_in), LEFT, RIGHT),'');
			SELF.oh_sa_dur        := IF(L.oh_sa_dur NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_sa_dur), LEFT, RIGHT),'');
			SELF.oh_su_start_in   := IF(L.oh_su_start_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_su_start_in), LEFT, RIGHT),'');
			SELF.oh_su_start      := IF(L.oh_su_start NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_su_start), LEFT, RIGHT),'');
			SELF.oh_su_end_in     := IF(L.oh_su_end_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_su_end_in), LEFT, RIGHT),'');
			SELF.oh_su_end        := IF(L.oh_su_end NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_su_end), LEFT, RIGHT),'');
			SELF.oh_su_lunch_in   := IF(L.oh_su_lunch_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_su_lunch_in), LEFT, RIGHT),'');
			SELF.oh_su_lunch      := IF(L.oh_su_lunch NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_su_lunch), LEFT, RIGHT),'');
			SELF.oh_su_dur_in     := IF(L.oh_su_dur_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_su_dur_in), LEFT, RIGHT),'');
			SELF.oh_su_dur        := IF(L.oh_su_dur NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_su_dur), LEFT, RIGHT),'');
			SELF.isTest						:= IF(l.isTest = true, true, false);
     	SELF 									:=  L;
    END;

    std_input :=PROJECT(input, tMapping(LEFT));
		return std_input;
	END;

	EXPORT office_attributes_facility	:= FUNCTION
		input := MPRD.InFile_Preprocessor(filedate,pUseProd).Prepped_office_attributes_facility;

		mprd.layouts.office_attributes_facility_base tMapping(MPRD.layouts.office_attributes_facility_in L) := TRANSFORM
			SELF.oh_m_start_in    := IF(L.oh_m_start_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_m_start_in), LEFT, RIGHT),'');
			SELF.oh_m_start       := IF(L.oh_m_start NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_m_start), LEFT, RIGHT),'');
			SELF.oh_m_end_in      := IF(L.oh_m_end_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_m_end_in), LEFT, RIGHT),'');
			SELF.oh_m_end         := IF(L.oh_m_end NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_m_end), LEFT, RIGHT),'');
			SELF.oh_m_lunch_in    := IF(L.oh_m_lunch_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_m_lunch_in), LEFT, RIGHT),'');
			SELF.oh_m_lunch       := IF(L.oh_m_lunch NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_m_lunch), LEFT, RIGHT),'');
			SELF.oh_m_dur_in      := IF(L.oh_m_dur_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_m_dur_in), LEFT, RIGHT),'');
			SELF.oh_m_dur         := IF(L.oh_m_dur NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_m_dur), LEFT, RIGHT),'');
			SELF.oh_tu_start_in   := IF(L.oh_tu_start_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_tu_start_in), LEFT, RIGHT),'');
			SELF.oh_tu_start      := IF(L.oh_tu_start NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_tu_start), LEFT, RIGHT),'');
			SELF.oh_tu_end_in     := IF(L.oh_tu_end_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_tu_end_in), LEFT, RIGHT),'');
			SELF.oh_tu_end        := IF(L.oh_tu_end NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_tu_end), LEFT, RIGHT),'');
			SELF.oh_tu_lunch_in   := IF(L.oh_tu_lunch_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_tu_lunch_in), LEFT, RIGHT),'');
			SELF.oh_tu_lunch      := IF(L.oh_tu_lunch NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_tu_lunch), LEFT, RIGHT),'');
			SELF.oh_tu_dur_in     := IF(L.oh_tu_dur_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_tu_dur_in), LEFT, RIGHT),'');
			SELF.oh_tu_dur        := IF(L.oh_tu_dur NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_tu_dur), LEFT, RIGHT),'');
			SELF.oh_w_start_in    := IF(L.oh_w_start_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_w_start_in), LEFT, RIGHT),'');
			SELF.oh_w_start       := IF(L.oh_w_start NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_w_start), LEFT, RIGHT),'');
			SELF.oh_w_end_in      := IF(L.oh_w_end_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_w_end_in), LEFT, RIGHT),'');
			SELF.oh_w_end         := IF(L.oh_w_end NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_w_end), LEFT, RIGHT),'');
			SELF.oh_w_lunch_in    := IF(L.oh_w_lunch_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_w_lunch_in), LEFT, RIGHT),'');
			SELF.oh_w_lunch       := IF(L.oh_w_lunch NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_w_lunch), LEFT, RIGHT),'');
			SELF.oh_w_dur_in      := IF(L.oh_w_dur_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_w_dur_in), LEFT, RIGHT),'');
			SELF.oh_w_dur         := IF(L.oh_w_dur NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_w_dur), LEFT, RIGHT),'');
			SELF.oh_th_start_in   := IF(L.oh_th_start_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_th_start_in), LEFT, RIGHT),'');
			SELF.oh_th_start      := IF(L.oh_th_start NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_th_start), LEFT, RIGHT),'');
			SELF.oh_th_end_in     := IF(L.oh_th_end_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_th_end_in), LEFT, RIGHT),'');
			SELF.oh_th_end        := IF(L.oh_th_end NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_th_end), LEFT, RIGHT),'');
			SELF.oh_th_lunch_in   := IF(L.oh_th_lunch_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_th_lunch_in), LEFT, RIGHT),'');
			SELF.oh_th_lunch      := IF(L.oh_th_lunch NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_th_lunch), LEFT, RIGHT),'');
			SELF.oh_th_dur_in     := IF(L.oh_th_dur_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_th_dur_in), LEFT, RIGHT),'');
			SELF.oh_th_dur        := IF(L.oh_th_dur NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_th_dur), LEFT, RIGHT),'');
			SELF.oh_f_start_in    := IF(L.oh_f_start_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_f_start_in), LEFT, RIGHT),'');
			SELF.oh_f_start       := IF(L.oh_f_start NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_f_start), LEFT, RIGHT),'');
			SELF.oh_f_end_in      := IF(L.oh_f_end_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_f_end_in), LEFT, RIGHT),'');
			SELF.oh_f_end         := IF(L.oh_f_end NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_f_end), LEFT, RIGHT),'');
			SELF.oh_f_lunch_in    := IF(L.oh_f_lunch_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_f_lunch_in), LEFT, RIGHT),'');
			SELF.oh_f_lunch       := IF(L.oh_f_lunch NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_f_lunch), LEFT, RIGHT),'');
			SELF.oh_f_dur_in      := IF(L.oh_f_dur_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_f_dur_in), LEFT, RIGHT),'');
			SELF.oh_f_dur         := IF(L.oh_f_dur NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_f_dur), LEFT, RIGHT),'');
			SELF.oh_sa_start_in   := IF(L.oh_sa_start_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_sa_start_in), LEFT, RIGHT),'');
			SELF.oh_sa_start      := IF(L.oh_sa_start NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_sa_start), LEFT, RIGHT),'');
			SELF.oh_sa_end_in     := IF(L.oh_sa_end_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_sa_end_in), LEFT, RIGHT),'');
			SELF.oh_sa_end        := IF(L.oh_sa_end NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_sa_end), LEFT, RIGHT),'');
			SELF.oh_sa_lunch_in   := IF(L.oh_sa_lunch_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_sa_lunch_in), LEFT, RIGHT),'');
			SELF.oh_sa_lunch      := IF(L.oh_sa_lunch NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_sa_lunch), LEFT, RIGHT),'');
			SELF.oh_sa_dur_in     := IF(L.oh_sa_dur_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_sa_dur_in), LEFT, RIGHT),'');
			SELF.oh_sa_dur        := IF(L.oh_sa_dur NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_sa_dur), LEFT, RIGHT),'');
			SELF.oh_su_start_in   := IF(L.oh_su_start_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_su_start_in), LEFT, RIGHT),'');
			SELF.oh_su_start      := IF(L.oh_su_start NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_su_start), LEFT, RIGHT),'');
			SELF.oh_su_end_in     := IF(L.oh_su_end_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_su_end_in), LEFT, RIGHT),'');
			SELF.oh_su_end        := IF(L.oh_su_end NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_su_end), LEFT, RIGHT),'');
			SELF.oh_su_lunch_in   := IF(L.oh_su_lunch_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_su_lunch_in), LEFT, RIGHT),'');
			SELF.oh_su_lunch      := IF(L.oh_su_lunch NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_su_lunch), LEFT, RIGHT),'');
			SELF.oh_su_dur_in     := IF(L.oh_su_dur_in NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_su_dur_in), LEFT, RIGHT),'');
			SELF.oh_su_dur        := IF(L.oh_su_dur NOT IN invalid_values,TRIM(Stringlib.StringToUpperCase(L.oh_su_dur), LEFT, RIGHT),'');
			SELF.isTest						:= IF(l.isTest = true, true, false);
     	SELF  								:=  L;
		END;

    std_input :=PROJECT(input, tMapping(LEFT));
		return std_input;
	END;

	EXPORT lic_xref	:= FUNCTION
		input := MPRD.Files(filedate,pUseProd).lic_xref_file;

		mprd.layouts.lic_xref_base tMapping(MPRD.layouts.lic_xref_in L) := TRANSFORM
			SELF.middle_name			:='';
			SELF.maturity_suffix	:='';
			SELF.first_name 			:= TRIM(Stringlib.StringToUpperCase(L.first_name), LEFT, RIGHT);
	    SELF.last_name  			:= TRIM(Stringlib.StringToUpperCase(L.last_name), LEFT, RIGHT);
	    SELF  								:= L;
			SELF  								:=[];
    END;

    std_input := PROJECT(input, tMapping(LEFT));
		return std_input;
	END;

	EXPORT addr_name_xref	:= FUNCTION
		input := MPRD.Files(filedate,pUseProd).addr_name_xref_file;

		mprd.layouts.address_name_xref_base tMapping(MPRD.layouts.address_name_xref_in L) := TRANSFORM
			SELF.middle_name				:= '';
			SELF.maturity_suffix		:= '';
			SELF.preferred_name 		:= TRIM(Stringlib.StringToUpperCase(L.preferred_name), LEFT, RIGHT);
			SELF.first_name 				:= TRIM(Stringlib.StringToUpperCase(L.preferred_name), LEFT, RIGHT);
	    SELF.last_name  				:= TRIM(Stringlib.StringToUpperCase(L.last_name), LEFT, RIGHT);
	    SELF  									:= L;
			SELF  									:=[];
    END;

    std_input :=PROJECT(input, tMapping(LEFT));
		return std_input;
	END;

	EXPORT group_practice := FUNCTION
		input := MPRD.Files(filedate,pUseProd).group_practice_file;

		mprd.layouts.group_practice_base tMapping(MPRD.layouts.group_practice_in L, C) := TRANSFORM
			SELF.src    												:= 'QN';
			SELF.Date_vendor_first_reported     := (UNSIGNED)filedate;
			SELF.Date_vendor_last_reported      := (UNSIGNED)filedate;
			SELF.clean_prac_phone1 							:= IF(ut.CleanPhone(L.prac_phone1) [1] NOT IN ['0','1'],ut.CleanPhone(L.prac_phone1), '') ;
			SELF.clean_prac_fax1 								:= IF(ut.CleanPhone(L.prac_fax1) [1] NOT IN ['0','1'],ut.CleanPhone(L.prac_fax1), '') ;
			SELF.clean_prac_fax2 								:= IF(ut.CleanPhone(L.prac_fax2) [1] NOT IN ['0','1'],ut.CleanPhone(L.prac_fax2), '') ;
			SELF.group_name											:= TRIM(Stringlib.StringToUpperCase(L.group_name), LEFT, RIGHT);
			SELF.clean_group_name								:= IF(L.group_name<> '', ut.CleanCompany(L.group_name), '');
			SELF.group_affiliation							:= TRIM(L.group_affiliation, LEFT, RIGHT);
			SELF.prac1_key											:= TRIM(L.prac1_key, LEFT, RIGHT);
			SELF.prac1_rectype									:= TRIM(L.prac1_rectype, LEFT, RIGHT);
			SELF.taxonomy												:= TRIM(L.taxonomy, LEFT, RIGHT);
			SELF.date_first_seen                :='0';
			SELF.date_last_seen                 :='0';
			SELF.first_created_date	:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.first_created_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.last_load_date			:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.last_load_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.clean_first_created_date       := IF(l.first_created_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.first_created_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_last_load_date 		      := IF(l.last_load_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.last_load_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.prac1_primary_address					:= TRIM(Stringlib.StringToUpperCase(L.prac1_primary_address), LEFT, RIGHT);
			SELF.prac1_secondary_address				:= TRIM(Stringlib.StringToUpperCase(L.prac1_secondary_address), LEFT, RIGHT);
			SELF.prac1_city											:= TRIM(Stringlib.StringToUpperCase(L.prac1_city), LEFT, RIGHT);
			SELF.prac1_state										:= TRIM(Stringlib.StringToUpperCase(L.prac1_state), LEFT, RIGHT);
			SELF.prac1_zip											:= TRIM(Stringlib.StringToUpperCase(L.prac1_zip), LEFT, RIGHT);
			SELF.normed_addr_rec_type           := CHOOSE(C,'1','2');
			SELF.Prepped_addr1                  := TRIM(Stringlib.StringToUpperCase(CHOOSE(C,SELF.prac1_primary_address,SELF.prac1_secondary_address)), LEFT, RIGHT);
			SELF.Prepped_addr2                  := TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(
																							TRIM(SELF.prac1_city) + IF(SELF.prac1_city <> '',',','')
																							+ ' ' + SELF.prac1_state	+ ' ' + SELF.prac1_zip[..5])),LEFT,RIGHT);
			SELF.record_type	:= 'C';
			SELF  :=  L;
			SELF := [];
		END;

		std_input := NORMALIZE(input, 2, tMapping(LEFT, COUNTER));
		return std_input;
	END;

	EXPORT	aci_schedule	:=	FUNCTION
		input	:= MPRD.Files(filedate,pUseProd).aci_schedule_file;

		mprd.layouts.aci_schedule_base tMapping(MPRD.layouts.aci_schedule_in L)	:= TRANSFORM
			SELF.state													:= TRIM(Stringlib.StringToUpperCase(L.state), LEFT, RIGHT);
			SELF.provider_type_code							:= TRIM(Stringlib.StringToUpperCase(L.provider_type_code), LEFT, RIGHT);
			SELF.provider_type									:= TRIM(Stringlib.StringToUpperCase(L.provider_type), LEFT, RIGHT);
			SELF.board_name											:= TRIM(Stringlib.StringToUpperCase(L.board_name), LEFT, RIGHT);
			SELF.primary_source									:= TRIM(Stringlib.StringToUpperCase(L.primary_source), LEFT, RIGHT);
			SELF.secondary_source								:= TRIM(Stringlib.StringToUpperCase(L.secondary_source), LEFT, RIGHT);
			SELF.tertiary_source								:= TRIM(Stringlib.StringToUpperCase(L.tertiary_source), LEFT, RIGHT);
			SELF.reporting_method								:= TRIM(Stringlib.StringToUpperCase(L.reporting_method), LEFT, RIGHT);
			SELF.timeframe											:= TRIM(Stringlib.StringToUpperCase(L.timeframe), LEFT, RIGHT);
			SELF.monitor_frequency							:= TRIM(Stringlib.StringToUpperCase(L.monitor_frequency), LEFT, RIGHT);
			SELF.followup_method								:= TRIM(Stringlib.StringToUpperCase(L.followup_method), LEFT, RIGHT);
			SELF																:= L;
			SELF																:= [];
		END;

    std_input :=PROJECT(input, tMapping(LEFT));
		return std_input;
	END;

	EXPORT business_activities_lu	:= FUNCTION
		input	:= MPRD.Files(filedate,pUseProd).business_activities_lu_file;

		mprd.layouts.business_activities_lu_base tMapping(MPRD.layouts.business_activities_lu_in L)	:= TRANSFORM
			SELF.dea_bus_act_ind							:= TRIM(Stringlib.StringToUpperCase(L.dea_bus_act_ind), LEFT, RIGHT);
			SELF.dea_bus_subcode							:= TRIM(Stringlib.StringToUpperCase(L.dea_bus_subcode), LEFT, RIGHT);
			SELF.dea_bus_act_descr						:= TRIM(Stringlib.StringToUpperCase(L.dea_bus_act_descr), LEFT, RIGHT);
			SELF															:= L;
			SELF															:= [];
		END;

	  std_input :=PROJECT(input, tMapping(LEFT));
		return std_input;
	END;

	EXPORT cms_ecp := FUNCTION
		input := MPRD.InFile_Preprocessor(filedate,pUseProd).Prepped_cms_ecp;

		mprd.layouts.cms_ecp_base tMapping(MPRD.layouts.cms_ecp_in L, C) := TRANSFORM
			SELF.src    												:= 'QN';
			SELF.Date_vendor_first_reported     := (UNSIGNED)filedate;
			SELF.Date_vendor_last_reported      := (UNSIGNED)filedate;
			SELF.date_first_seen                :='0';
			SELF.date_last_seen                 :='0';
			SELF.filecode												:= TRIM(Stringlib.StringToUpperCase(L.filecode), LEFT, RIGHT);
			SELF.ecp_provider_name							:= TRIM(Stringlib.StringToUpperCase(L.ecp_provider_name),LEFT,RIGHT);
			SELF.clean_ecp_provider_name				:= IF(L.ecp_provider_name<>'',ut.CleanCompany(L.ecp_provider_name),'');
			SELF.ecp_site_name									:= TRIM(Stringlib.StringToUpperCase(L.ecp_site_name), LEFT, RIGHT);
			SELF.clean_ecp_site_name						:= IF(L.ecp_site_name<> '', ut.CleanCompany(L.ecp_site_name), '');
			SELF.ecp_org_name										:= TRIM(Stringlib.StringToUpperCase(L.ecp_org_name), LEFT, RIGHT);
			SELF.clean_ecp_org_name							:= IF(L.ecp_org_name<> '', ut.CleanCompany(L.ecp_org_name), '');
			SELF.poc_name_fqhc									:= TRIM(Stringlib.StringToUpperCase(L.poc_name_fqhc), LEFT, RIGHT);
			SELF.clean_poc_name_fqhc						:= IF(L.poc_name_fqhc<> '', ut.CleanCompany(L.poc_name_fqhc), '');
			SELF.poc_name_pp										:= TRIM(Stringlib.StringToUpperCase(L.poc_name_pp), LEFT, RIGHT);
			SELF.clean_poc_name_pp							:= IF(L.poc_name_pp<> '', ut.CleanCompany(L.poc_name_pp), '');
			SELF.poc_name_opa										:= TRIM(Stringlib.StringToUpperCase(L.poc_name_opa), LEFT, RIGHT);
			SELF.clean_poc_name_opa							:= IF(L.poc_name_opa<> '', ut.CleanCompany(L.poc_name_opa), '');
			SELF.poc_name_ihs										:= TRIM(Stringlib.StringToUpperCase(L.poc_name_ihs), LEFT, RIGHT);
			SELF.clean_poc_name_ihs							:= IF(L.poc_name_ihs<> '', ut.CleanCompany(L.poc_name_ihs), '');
			SELF.poc_name_bl										:= TRIM(Stringlib.StringToUpperCase(L.poc_name_bl), LEFT, RIGHT);
			SELF.clean_poc_name_bl							:= IF(L.poc_name_bl<> '', ut.CleanCompany(L.poc_name_bl), '');
			SELF.poc_name_dental								:= TRIM(Stringlib.StringToUpperCase(L.poc_name_dental), LEFT, RIGHT);
			SELF.clean_poc_name_dental					:= IF(L.poc_name_dental<> '', ut.CleanCompany(L.poc_name_dental), '');
			SELF.clean_poc_phone_fqhc						:= IF(ut.CleanPhone(L.poc_phone_fqhc)[1] NOT IN ['0','1'],ut.CleanPhone(L.poc_phone_fqhc), '');
			SELF.clean_poc_phone_ch							:= IF(ut.CleanPhone(L.poc_phone_ch)[1] NOT IN ['0','1'],ut.CleanPhone(L.poc_phone_ch), '');
			SELF.clean_poc_phone_rw							:= IF(ut.CleanPhone(L.poc_phone_rw)[1] NOT IN ['0','1'],ut.CleanPhone(L.poc_phone_rw), '');
			SELF.clean_poc_phone_tb							:= IF(ut.CleanPhone(L.poc_phone_tb)[1] NOT IN ['0','1'],ut.CleanPhone(L.poc_phone_tb), '');
			SELF.clean_poc_phone_std						:= IF(ut.CleanPhone(L.poc_phone_std)[1] NOT IN ['0','1'],ut.CleanPhone(L.poc_phone_std), '');
			SELF.clean_poc_phone_pp							:= IF(ut.CleanPhone(L.poc_phone_pp)[1] NOT IN ['0','1'],ut.CleanPhone(L.poc_phone_pp), '');
			SELF.clean_poc_phone_opa						:= IF(ut.CleanPhone(L.poc_phone_opa)[1] NOT IN ['0','1'],ut.CleanPhone(L.poc_phone_opa), '');
			SELF.clean_poc_phone_ihs						:= IF(ut.CleanPhone(L.poc_phone_ihs)[1] NOT IN ['0','1'],ut.CleanPhone(L.poc_phone_ihs), '');
			SELF.clean_poc_phone_bl							:= IF(ut.CleanPhone(L.poc_phone_bl)[1] NOT IN ['0','1'],ut.CleanPhone(L.poc_phone_bl), '');
			SELF.clean_poc_phone_dental					:= IF(ut.CleanPhone(L.poc_phone_dental)[1] NOT IN ['0','1'],ut.CleanPhone(L.poc_phone_dental), '');
			SELF.ecp_site_addr1									:= TRIM(Stringlib.StringToUpperCase(L.ecp_site_addr1), LEFT, RIGHT);
			SELF.ecp_site_addr2									:= TRIM(Stringlib.StringToUpperCase(L.ecp_site_addr2), LEFT, RIGHT);
			SELF.ecp_site_city									:= TRIM(Stringlib.StringToUpperCase(L.ecp_site_city), LEFT, RIGHT);
			SELF.ecp_site_state									:= TRIM(Stringlib.StringToUpperCase(L.ecp_site_state), LEFT, RIGHT);
			SELF.ecp_site_zip										:= TRIM(Stringlib.StringToUpperCase(L.ecp_site_zip), LEFT, RIGHT);
			SELF.ecp_org_addr1									:= TRIM(Stringlib.StringToUpperCase(L.ecp_org_addr1), LEFT, RIGHT);
			SELF.ecp_org_addr2									:= TRIM(Stringlib.StringToUpperCase(L.ecp_org_addr2), LEFT, RIGHT);
			SELF.ecp_org_city										:= TRIM(Stringlib.StringToUpperCase(L.ecp_org_city), LEFT, RIGHT);
			SELF.ecp_org_state									:= TRIM(Stringlib.StringToUpperCase(L.ecp_org_state), LEFT, RIGHT);
			SELF.ecp_org_zip										:= TRIM(Stringlib.StringToUpperCase(L.ecp_org_zip), LEFT, RIGHT);
			SELF.normed_addr_rec_type           := CHOOSE(C,'1','2','3','4');
			SELF.Prepped_addr1                  := TRIM(Stringlib.StringToUpperCase(CHOOSE(C,SELF.ecp_site_addr1,SELF.ecp_site_addr2,SELF.ecp_org_addr1,SELF.ecp_org_addr2)), LEFT, RIGHT);
			SELF.Prepped_addr2                  := CHOOSE(C,
																							TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(
																							TRIM(SELF.ecp_site_city) + IF(SELF.ecp_site_city <> '',',','')
																							+ ' ' + SELF.ecp_site_state	+ ' ' + SELF.ecp_site_zip[..5])),LEFT,RIGHT),
																							TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(
																							TRIM(SELF.ecp_site_city) + IF(SELF.ecp_site_city <> '',',','')
																							+ ' ' + SELF.ecp_site_state	+ ' ' + SELF.ecp_site_zip[..5])),LEFT,RIGHT),
																							TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(
																							TRIM(SELF.ecp_org_city) + IF(SELF.ecp_org_city <> '',',','')
																							+ ' ' + SELF.ecp_org_state	+ ' ' + SELF.ecp_org_zip[..5])),LEFT,RIGHT),
																							TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(
																							TRIM(SELF.ecp_org_city) + IF(SELF.ecp_org_city <> '',',','')
																							+ ' ' + SELF.ecp_org_state	+ ' ' + SELF.ecp_org_zip[..5])),LEFT,RIGHT));
			SELF.isTest													:= IF(l.isTest = true, true, false);
			SELF.record_type										:= 'C';
			SELF  															:= L;
			SELF 																:= [];
		END;

		std_input := NORMALIZE(input, 4, tMapping(LEFT, COUNTER));
		return std_input;
	END;

	EXPORT opi	:= FUNCTION
		input	:= MPRD.InFile_Preprocessor(filedate,pUseProd).Prepped_opi;

		mprd.layouts.opi_base tMapping(MPRD.layouts.opi_in L)	:= TRANSFORM
			SELF.npi													:= TRIM(Stringlib.StringToUpperCase(L.npi), LEFT, RIGHT);
			SELF.opi													:= TRIM(Stringlib.StringToUpperCase(L.opi), LEFT, RIGHT);
			SELF.opi_state										:= TRIM(Stringlib.StringToUpperCase(L.opi_state), LEFT, RIGHT);
			SELF.opi_type_code								:= TRIM(Stringlib.StringToUpperCase(L.opi_type_code), LEFT, RIGHT);
			SELF.isTest												:= IF(l.isTest = true, true, false);
			SELF															:= L;
			SELF															:= [];
		END;

	  std_input :=PROJECT(input, tMapping(LEFT));
		return std_input;
	END;

	EXPORT opi_facility	:= FUNCTION
		input	:= MPRD.InFile_Preprocessor(filedate,pUseProd).Prepped_opi_facility;

		mprd.layouts.opi_facility_base tMapping(MPRD.layouts.opi_facility_in L)	:= TRANSFORM
			SELF.npi													:= TRIM(Stringlib.StringToUpperCase(L.npi), LEFT, RIGHT);
			SELF.opi													:= TRIM(Stringlib.StringToUpperCase(L.opi), LEFT, RIGHT);
			SELF.opi_state										:= TRIM(Stringlib.StringToUpperCase(L.opi_state), LEFT, RIGHT);
			SELF.opi_type_code								:= TRIM(Stringlib.StringToUpperCase(L.opi_type_code), LEFT, RIGHT);
			SELF.isTest												:= IF(l.isTest = true, true, false);
			SELF															:= L;
			SELF															:= [];
		END;

	  std_input :=PROJECT(input, tMapping(LEFT));
		return std_input;
	END;

	EXPORT abms_cert_lu	:= FUNCTION
		input	:= MPRD.Files(filedate,pUseProd).abms_cert_lu_file;

		mprd.layouts.abms_cert_lu_base tMapping(MPRD.layouts.abms_cert_lu_in L)	:= TRANSFORM
			SELF.cert_desc										:= TRIM(Stringlib.StringToUpperCase(L.cert_desc), LEFT, RIGHT);
			SELF.cert_code										:= TRIM(Stringlib.StringToUpperCase(L.cert_code), LEFT, RIGHT);
			SELF.board_name										:= TRIM(Stringlib.StringToUpperCase(L.board_name), LEFT, RIGHT);
			SELF.cert_type										:= TRIM(Stringlib.StringToUpperCase(L.cert_type), LEFT, RIGHT);
			SELF.cert_id											:= TRIM(Stringlib.StringToUpperCase(L.cert_id), LEFT, RIGHT);
			SELF.taxonomy											:= TRIM(Stringlib.StringToUpperCase(L.taxonomy), LEFT, RIGHT);
			SELF															:= L;
			SELF															:= [];
		END;

	  std_input :=PROJECT(input, tMapping(LEFT));
		return std_input;
	END;

	EXPORT abms_cooked	:= FUNCTION
		input	:= MPRD.Files(filedate,pUseProd).abms_cooked_file;

		mprd.layouts.abms_cooked_base tMapping(MPRD.layouts.abms_cooked_in L)	:= TRANSFORM
			SELF.board_certified							:= TRIM(Stringlib.StringToUpperCase(L.board_certified), LEFT, RIGHT);
			SELF.cert_type_ind								:= TRIM(Stringlib.StringToUpperCase(L.cert_type_ind), LEFT, RIGHT);
			SELF.occurence_type								:= TRIM(Stringlib.StringToUpperCase(L.occurence_type), LEFT, RIGHT);
			SELF.duration_type								:= TRIM(Stringlib.StringToUpperCase(L.duration_type), LEFT, RIGHT);
			SELF.cert_date										:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.cert_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.exp_date											:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.exp_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.rev_date											:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.rev_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.clean_cert_date			 	      := IF(l.cert_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.cert_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_exp_date			 		      := IF(l.exp_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.exp_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.clean_rev_date			 		      := IF(l.rev_date NOT IN invalid_dates,_validate.date.fCorrectedDateString((STRING)TRIM(stringlib.stringfilterout(l.rev_date,'-.>$!%*@=?&\''),LEFT,RIGHT),false),'0');
			SELF.src    											:= 'QN';
			SELF.Date_vendor_first_reported   := (UNSIGNED)filedate;
			SELF.Date_vendor_last_reported    := (UNSIGNED)filedate;
			SELF.date_first_seen              :='0';
			SELF.date_last_seen               :='0';
			SELF.isTest												:= IF(l.isTest = true, true, false);
			SELF															:= L;
			SELF															:= [];
		END;

	  std_input :=PROJECT(input, tMapping(LEFT));
		return std_input;
	END;

END;
