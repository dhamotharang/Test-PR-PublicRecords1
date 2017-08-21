import ut, doxie, autokey, sexoffender, AutoStandardI;

export SexOffender_Functions := MODULE

	export fetch_by_zip(boolean noFail = true) :=
	FUNCTION

		SexOffender.MAC_Header_Field_Declare();

		i := sexoffender.key_sexoffender_zip_type;

		AutoKey.layout_fetch xt(i r) := TRANSFORM
																						SELF := r;
																		END;
																		
		f_raw := i(zip_value<>[],
							 keyed(alt_zip IN zip_value),
							 keyed(alt_type='S' OR
										 (includeHistorical AND alt_type = 'H') OR
										 (includeRelatives AND alt_type = 'R') OR
										 (includeNonRegistered AND alt_type NOT IN ['S','H','R'])) AND
										 ~(excludeRegistered AND alt_type='S'),
							 keyed(yob>=(unsigned2)find_year_low AND 
										 yob<=IF((unsigned2)find_year_high != 0, (unsigned2)find_year_high, (unsigned2)0xFFFF)),
							 find_month=0 or (dob div 100) % 100=find_month,
							 find_day=0 or dob % 100=find_day);

		f := project(f_raw, xt(LEFT));
				
		AutoKey.mac_Limits(f,f_ret)	
								
		rec := doxie.layout_references;					
							
		return if(((not exists(f_ret(error_code=0))) and f_ret[1].error_code>0), 
							fail(rec, f_ret[1].error_code, doxie.ErrorCodes(f_ret[1].error_code)),
							project(f_ret, rec));						
																
	END;

	export boolean isSORestricted(string32 applicationType, string16 sspk) := 
	FUNCTION
			appType := TRIM(stringlib.StringToUpperCase(applicationType));
			return appType<>AutoStandardI.Constants.APPLICATION_TYPE_LE and sspk[1..5]='C2ORP';
	end;

END;