IMPORT  ut, mdr, tools,_validate, Address, Ut, lib_stringlib, _Control, business_header, MPRD,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, NID, AID;

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
			SELF.isTest													:= false;
			SELF  															:=  L;
			SELF 																:= [];
		END;

		std_input := NORMALIZE(input, 4, tMapping(LEFT, COUNTER))(normed_addr_rec_type='1' OR Prepped_addr1<>'' AND first_name<>'',last_name<>'');				
		return std_input;		
	END;

END;
