/*--LIBRARY--*/
// This library performs penalty calculations based on address.
// All logic for performing the calculation should be based here.
import doxie, ut, AutoStandardI, STD;

export LIB_PenaltyI_Addr(AutoStandardI.LIBIN.PenaltyI_Addr.full args) := MODULE/*,LIBRARY*/(AutoStandardI.LIBOUT.PenaltyI_Addr(args))
	EXPORT UNSIGNED val := FUNCTION
		temp_city_value := AutoStandardI.InterfaceTranslator.city_value.val(args);
		temp_other_city_value := AutoStandardI.InterfaceTranslator.other_city_value.val(args);
		temp_input_city_value := AutoStandardI.InterfaceTranslator.input_city_value.val(args);
		temp_zipradius_value := AutoStandardI.InterfaceTranslator.zipradius_value.val(args);
		temp_state_value := AutoStandardI.InterfaceTranslator.state_value.val(args);
		temp_prev_state_value1 := AutoStandardI.InterfaceTranslator.prev_state_val1.val(args);
		temp_prev_state_value2 := AutoStandardI.InterfaceTranslator.prev_state_val2.val(args);
		temp_zip_value := AutoStandardI.InterfaceTranslator.zip_value.val(args);
		temp_zip_val := AutoStandardI.InterfaceTranslator.zip_val.val(args);
		temp_city_zip_value := AutoStandardI.InterfaceTranslator.city_zip_value.val(args);
		temp_zip_value_cleaned := AutoStandardI.InterfaceTranslator.zip_value_cleaned.val(args);
		temp_county_value := AutoStandardI.InterfaceTranslator.county_value.val(args);
		temp_predir_value := AutoStandardI.InterfaceTranslator.predir_value.val(args);
		temp_postdir_value := AutoStandardI.InterfaceTranslator.postdir_value.val(args);
		temp_addr_suffix_value := AutoStandardI.InterfaceTranslator.addr_suffix_value.val(args);
		temp_pname_wild := AutoStandardI.InterfaceTranslator.pname_wild.val(args);
		temp_pname_wild_val := AutoStandardI.InterfaceTranslator.pname_wild_val.val(args);
		temp_pname_value := AutoStandardI.InterfaceTranslator.pname_value.val(args);
		temp_prange_value := AutoStandardI.InterfaceTranslator.prange_value.val(args);
		temp_sec_range_value := AutoStandardI.InterfaceTranslator.sec_range_value.val(args);
		temp_addr_range := AutoStandardI.InterfaceTranslator.addr_range.val(args);
		temp_prange_beg_value := AutoStandardI.InterfaceTranslator.prange_beg_value.val(args);
		temp_prange_end_value := AutoStandardI.InterfaceTranslator.prange_end_value.val(args);
		temp_addr_wild := AutoStandardI.InterfaceTranslator.addr_wild.val(args);
		temp_prange_wild_value := AutoStandardI.InterfaceTranslator.prange_wild_value.val(args);

		city_pen(string field) := map(
			temp_city_value='' => 0,
			field=temp_city_value => 0,
			field=temp_input_city_value => 0,
			// do not penalize if other city has been provided and we have a match
			temp_other_city_value<>'' and field=temp_other_city_value => 0,
			field='' => 3,
			temp_zipradius_value>0 => 1,
			ut.stringsimilar(field,temp_city_value)<3 => 1,
			ut.stringsimilar(field,temp_input_city_value)<3 => 1,	 
			ut.stringsimilar(field,temp_other_city_value)<3 => 1,	 
			5
		);

		p_city := MIN(
			city_pen(args.city_field),
			if(args.city2_field<>'', city_pen(args.city2_field), 999));
				
		p_state := map(
			temp_state_value='' => 0,
			args.state_field=temp_state_value => 0,
			// do not penalize if other states have been provided and we have a match
			temp_prev_state_value1<>'' and temp_prev_state_value1 = args.state_field => 0, 
			temp_prev_state_value2<>'' and temp_prev_state_value2 = args.state_field => 0, 			
			// only allow zip radius reduction of penalty if a zip was provided or could be derived from city,state
			temp_zipradius_value>0 and (temp_zip_value <> [] or temp_city_zip_value <> '') => 1,
			10);
		
		// calculation for distance from a given zip, using radius as a reducing factor
		p_zip_dist(string zip, string zip_field, integer radius) := 
					(unsigned4)(4*ut.zip_Dist(zip,zip_field) / MAX(radius,1)) + 1;

		CityZips := (SET OF STRING5)ut.ZipsWithinCity(temp_state_value,temp_city_value);
		
		p_zip := map(
			temp_zip_value=[] => 0,
			temp_zip_val = '' and ARGS.ZIP_FIELD IN CityZips => 0,
			temp_zip_val=args.zip_field => 0,
			temp_city_zip_value=args.zip_field => 0,
			temp_zip_value_cleaned=args.zip_field => 0,
			// do not penalize if other states have been provided and we have a match
			temp_prev_state_value1<>'' and temp_prev_state_value1 = args.state_field => 0, 
			temp_prev_state_value2<>'' and temp_prev_state_value2 = args.state_field => 0, 	
			(unsigned4)args.zip_field=0 => 2,
			temp_county_value <> '' AND (unsigned3) args.zip_field in temp_zip_value => 0,
			// take the lesser of the three distance penalties
			// this provides lift when the entered zip is non-existent, but the city/state produces a valid zip
			min(p_zip_dist(temp_zip_val,args.zip_field,temp_zipradius_value),
			    p_zip_dist(temp_city_zip_value,args.zip_field,temp_zipradius_value),
			    p_zip_dist(temp_zip_value_cleaned,args.zip_field,temp_zipradius_value)));
		
		p_predir	:= if(temp_predir_value=''			or args.predir_field=temp_predir_value,				0, 1);
		p_postdir	:= if(temp_postdir_value=''			or args.postdir_field=temp_postdir_value,			0, 1);
		p_suffix	:= if(temp_addr_suffix_value=''	or args.suffix_field=temp_addr_suffix_value,	0, 1);
			
		p_pname := map(
			temp_pname_wild AND args.allow_wildcard AND 
					STD.Str.WildMatch (doxie.StripOrdinal(args.pname_field), temp_pname_wild_val, TRUE)=> 0,
			temp_pname_wild and args.allow_wildcard => 10,
			temp_pname_value='' or ut.StripOrdinal(args.pname_field)=temp_pname_value => 0,
			args.pname_field='' => 8, 
			ut.stringsimilar(temp_pname_value,args.pname_field));
		
		p_prange := map(
			trim(temp_prange_value)='' => 0,
			trim(args.prange_field,left,right)=trim(temp_prange_value,left,right) => 0,
			(unsigned8)args.prange_field=(unsigned8)temp_prange_value => 1, // low penalty for fractional mismatch
			// inside the range, 0 penalty
			temp_addr_range AND (unsigned)args.prange_field >= temp_prange_beg_value AND 
					(unsigned)args.prange_field <= temp_prange_end_value => 0,
			// outside the range, 10 penalty
			temp_addr_range AND ((unsigned)args.prange_field < temp_prange_beg_value OR 
					(unsigned)args.prange_field > temp_prange_end_value) => 10,
			temp_addr_wild AND args.allow_wildcard AND temp_prange_wild_value <>'' AND 
					STD.Str.WildMatch(args.prange_field, temp_prange_wild_value, TRUE) => 0,
			temp_addr_wild AND args.allow_wildcard AND temp_prange_wild_value <>'' => 10,            
			(unsigned8)args.prange_field=0 => 2, 
			ut.stringsimilar(temp_prange_value,args.prange_field));
		
		p_srange := map(
			(unsigned8)temp_sec_range_value=0 => 0,
			(unsigned8)args.sec_range_field=(unsigned8)temp_sec_range_value => 0,
			(unsigned8)args.sec_range_field=0 => 1,
			2);
		RETURN p_city + p_state + p_zip + p_predir + p_postdir + p_suffix + p_pname + p_prange + p_srange;

	END;
END;