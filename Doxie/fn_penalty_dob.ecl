import ut;

export fn_penalty_dob(
	string dob_field_unformatted,
	unsigned8 Dob_val_unformatted,
	unsigned1 AgeLow_val = 0,
	unsigned1 AgeHigh_val = 0
) :=
FUNCTION

Dob_val := (unsigned8) if(dob_val_unformatted < 1300,(string) dob_val_unformatted,((((string)Dob_val_unformatted) + '0000')[1..8]));
Dob_field := (dob_field_unformatted + '0000')[1..8];

find_year_low :=  doxie.DOBTools(dob_val).find_year_low(agehigh_val);   
find_year_high := doxie.DOBTools(dob_val).find_year_high(agelow_val);

find_month := doxie.DOBTools(dob_val).find_month;
find_day := 	doxie.DOBTools(dob_val).find_day;

RETURN MAP ( find_month = 0 or ((unsigned8)dob_field div 100) % 100 = find_month => 0,
      (unsigned8)dob_field=0 => 1,
			dob_field[5..6] IN ['00','01'] => 1,	// like a null
      10 ) +
			MAP ( find_day = 0 or (unsigned8)dob_field % 100 = find_day => 0,
      (unsigned8)dob_field=0 => 1,
			dob_field[7..8] IN ['00','01'] => 1,	// like a null
      10 ) +
			MAP ( ( find_year_high = 0 or find_year_high >= (unsigned8)dob_field div 10000 ) and 
        ( find_year_low = 0 or find_year_low <= (unsigned8)dob_field div 10000 )  => 0,
      (unsigned8)dob_field=0 => 3,
      10 ) + 
			MAP ((AgeLow_val <> 0 or AgeHigh_val <> 0) and (unsigned8)dob_field=0 => 2,   //only penalize more if age range requested and field is empty        
			(AgeLow_val = 0 or 
          map(((unsigned8)dob_field div 100) % 100 = 0 
	            => ((unsigned8)dob_field div 10000)*10000 + 101, 
		    (unsigned8)dob_field % 100 = 0 
			  => ((unsigned8)dob_field div 100)*100 + 1, 
		    (unsigned8)dob_field) <= 
		    (unsigned8)(StringLib.getdateYYYYMMDD())-AgeLow_val*10000) 
				and
			(AgeHigh_val = 0 or 
				map(((unsigned8)dob_field div 100) % 100 = 0 
						=> ((unsigned8)dob_field div 10000)*10000 + 1231, 
		    (unsigned8)dob_field % 100 = 0
						=> ((unsigned8)dob_field div 100)*100 + 
	               ut.Month_Days((unsigned8)dob_field div 100),
				(unsigned8)dob_field) >
	         (unsigned8)(StringLib.getdateYYYYMMDD())-(AgeHigh_val+1)*10000) 
	 => 0,
	10);
	
END;