/*--LIBRARY--*/
// This library performs penalty calculations based on date of birth.
// All logic for performing the calculation should be based here.
import doxie,ut,AutoStandardI,lib_stringlib;
export LIB_PenaltyI_DOB(AutoStandardI.LIBIN.PenaltyI_DOB.full args) := MODULE/*,LIBRARY*/(AutoStandardI.LIBOUT.PenaltyI_DOB(args))
	EXPORT UNSIGNED val := FUNCTION
		temp_dob_val0 := AutoStandardI.InterfaceTranslator.dob_val.val(args);
		temp_agehigh_val := AutoStandardI.InterfaceTranslator.agehigh_val.val(args);
		temp_agelow_val := AutoStandardI.InterfaceTranslator.agelow_val.val(args);

		temp_dob_val := (unsigned8) if(temp_dob_val0 < 1300,(string) temp_dob_val0,((((string)temp_dob_val0) + '0000')[1..8]));
		Dob_field := (args.dob_field + '0000')[1..8];

		
		find_year_low :=  doxie.DOBTools(temp_dob_val).find_year_low(temp_agehigh_val);   
		find_year_high := doxie.DOBTools(temp_dob_val).find_year_high(temp_agelow_val);

		find_month := doxie.DOBTools(temp_dob_val).find_month;
		find_day := 	doxie.DOBTools(temp_dob_val).find_day;

		RETURN MAP ( find_month = 0 or ((unsigned8)dob_field div 100) % 100 = find_month => 0,
					(unsigned8)dob_field=0 => 1,
					dob_field[5..6] = '00' => 1,	// like a null
					dob_field[5..6] = '01' and dob_field[7..8] IN ['00','01'] => 1,	// like a null
					10 ) +
					MAP ( find_day = 0 or (unsigned8)dob_field % 100 = find_day => 0,
					(unsigned8)dob_field=0 => 1,
					dob_field[7..8] IN ['00','01'] => 1,	// like a null
					10 ) +
					MAP ( ( find_year_high = 0 or find_year_high >= (unsigned8)dob_field div 10000 ) and 
						( find_year_low = 0 or find_year_low <= (unsigned8)dob_field div 10000 )  => 0,
					(unsigned8)dob_field=0 => 3,
					10 ) + 
					MAP ((temp_AgeLow_val <> 0 or temp_AgeHigh_val <> 0) and (unsigned8)dob_field=0 => 2,   //only penalize more if age range requested and field is empty        
					(temp_AgeLow_val = 0 or 
							map(((unsigned8)dob_field div 100) % 100 = 0 
									=> ((unsigned8)dob_field div 10000)*10000 + 101, 
						(unsigned8)dob_field % 100 = 0 
						=> ((unsigned8)dob_field div 100)*100 + 1, 
						(unsigned8)dob_field) <= 
						(unsigned8)(StringLib.getdateYYYYMMDD())-temp_AgeLow_val*10000) 
						and
					(temp_AgeHigh_val = 0 or 
						map(((unsigned8)dob_field div 100) % 100 = 0 
								=> ((unsigned8)dob_field div 10000)*10000 + 1231, 
						(unsigned8)dob_field % 100 = 0
								=> ((unsigned8)dob_field div 100)*100 + 
										 ut.Month_Days((unsigned8)dob_field div 100),
						(unsigned8)dob_field) >
							 (unsigned8)(StringLib.getdateYYYYMMDD())-(temp_AgeHigh_val+1)*10000) 
			 => 0,
			10);
	END;
END;