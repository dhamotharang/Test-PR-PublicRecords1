IMPORT  ut, _validate, lib_stringlib, Enclarity_Facility_Sanctions;

EXPORT StandardizeInputFile (string pVersion, boolean pUseProd = false):= MODULE

	SHARED fn_scale_gk(string38 gk) := function
		unsigned6 max_pid := 281474976710655;  //max unsigned6
		new_gk
			:=
				(unsigned6)
					((unsigned8)( hash64(hashmd5(gk)) ) % max_pid)
				;
		return new_gk;
	end;

	EXPORT Facility_Sanctions	:= FUNCTION
		baseFile	:= Enclarity_Facility_Sanctions.Filecode_Control(pversion,).Get_level;

		enclarity_facility_sanctions.layouts.base.facility_sanctions tMapping(Enclarity_Facility_Sanctions.Layouts.base.facility_sanctions L) := TRANSFORM
			SELF.pid                  	    := fn_scale_gk(l.group_key);
			SELF.src												:= '64';
			SELF.record_type								:= 'C';
			SELF.Date_vendor_first_reported	:= (unsigned)pVersion;
			SELF.Date_vendor_last_reported	:= (unsigned)pVersion;
			SELF.Date_first_seen						:= '0';
			SELF.Date_last_seen							:= '0';
			SELF.group_key									:= TRIM(L.group_key, LEFT, RIGHT);
			SELF.sanc1_state								:= TRIM(Stringlib.StringToUpperCase(L.sanc1_state), LEFT, RIGHT);
			SELF.lic1_num										:= TRIM(Stringlib.StringToUpperCase(L.lic1_num), LEFT, RIGHT);
			SELF.lic1_type									:= TRIM(Stringlib.StringToUpperCase(L.lic1_type), LEFT, RIGHT);
			prep_lic1_begin_date						:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic1_begin_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			prep_lic1_end_date							:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.lic1_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			prep_npi_deact_date							:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.npi_deact_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			prep_last_update_date						:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.last_update_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			prep_sanc1_date									:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.sanc1_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			prep_sanc1_rein_date						:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.sanc1_rein_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			prep_clia_cert_eff_date					:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.clia_cert_eff_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			prep_clia_end_date							:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.clia_end_date,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			prep_sanc1_order_date_ef				:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.sanc1_order_date_ef,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			prep_added_date_ef							:= TRIM(Stringlib.StringCleanSpaces(stringlib.stringfilterout(L.added_date_ef,'-&#.^!$+<>@=%?*/:;[]#\\')),LEFT, RIGHT);
			SELF.clean_lic1_begin_date			:= _validate.date.fCorrectedDateString(prep_lic1_begin_date);
			SELF.clean_lic1_end_date				:= _validate.date.fCorrectedDateString(prep_lic1_end_date);
			SELF.clean_npi_deact_date				:= _validate.date.fCorrectedDateString(prep_npi_deact_date);
			SELF.clean_last_update_date			:= _validate.date.fCorrectedDateString(prep_last_update_date);
			SELF.clean_sanc1_date						:= _validate.date.fCorrectedDateString(prep_sanc1_date);
			SELF.clean_sanc1_rein_date			:= _validate.date.fCorrectedDateString(prep_sanc1_rein_date);
			SELF.clean_clia_cert_eff_date		:= _validate.date.fCorrectedDateString(prep_clia_cert_eff_date);
			SELF.clean_clia_end_date				:= _validate.date.fCorrectedDateString(prep_clia_end_date);
			SELF.clean_sanc1_order_date_ef	:= _validate.date.fCorrectedDateString(prep_sanc1_order_date_ef);
			SELF.clean_added_date_ef				:= _validate.date.fCorrectedDateString(ut.ConvertDate(TRIM(L.added_date_ef),'%m/%d/%Y','%Y%m%d'));
			SELF  													:=  L;
			SELF  													:=  [];
		END;

		newBase	:= PROJECT(baseFile, tMapping(LEFT));

		RETURN newBase;
	END;
END;
