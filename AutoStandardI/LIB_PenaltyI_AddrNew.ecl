// ****************************************************
// PLEASE USE this attribute at very limited discretion.  It is a clone of 
// AutoStandardI.LIB_PenaltyI_Addr for the most part.
// it is only being used as a soltion for the Judgements and Liens Batch service 
// timeout issue (102185 bug) due to the new address cleaner that was introduced on 4/24/2012 at midnight
// THIS should not be used by any service which uses a non cleaned input address
// WARNING Some fields from input are not mapped
// We have attempted to not call the interfacetranslator module in order to obtain cleaned
// address values.  We are using those input values which are passed into the module because
// they have already been cleaned.  If successful in prod this model can be used for other
// services which preclean the input address data before hitting roxie.
// ***************************
import ut, doxie, STD;

export LIB_PenaltyI_AddrNEW(LIBIN.PenaltyI_Addr.full args) := MODULE/*,LIBRARY*/(LIBOUT.PenaltyI_Addr(args))
	EXPORT UNSIGNED val := function	
		temp_city_value := args.city;
		temp_state_value := args.state;
		//temp_zip_value := args.z5;  
		temp_zip_value := ut.fn_GetZipSet(args.city, args.state, args.z5,	'', ziplib.CityToZip5(args.state, args.city), 0);
		//SELF.zip_value := ut.fn_GetZipSet(l.city_value, l.state_value, l.zip_val,	'', ziplib.CityToZip5(l.state_value, l.city_value), l.zipradius_value);
    temp_zip_val := args.z5;
		temp_city_zip_value  := ziplib.CityToZip5(args.state, args.city);
		temp_zip_value_cleaned := args.z5;
		temp_pname_value := args.prim_name;
		temp_prange_value := args.prim_range;
		temp_addr_suffix_value := args.suffix;   
		
		temp_other_city_value := ''; //InterfaceTranslator.other_city_value.val(args);
		temp_input_city_value := ''; //InterfaceTranslator.input_city_value.val(args);
		temp_zipradius_value :=  map(
				// StrictMatch_value.val(in_mod) => 0,
				// this line below equates to the above line
				args.OnlyExactMatches OR args.StrictMatch => 0,				
				args.zipradius != 0 => args.zipradius,
				args.mileradius);
		                         //InterfaceTranslator.zipradius_value.val(args);														 
		temp_prev_state_value1 := ''; //InterfaceTranslator.prev_state_val1.val(args);
		temp_prev_state_value2 := ''; //InterfaceTranslator.prev_state_val2.val(args);
		
		temp_county_value := ''; //InterfaceTranslator.county_value.val(args);
		temp_predir_value := args.predir;
		temp_postdir_value := args.postdir;
		
		temp_pname_wild := false; //InterfaceTranslator.pname_wild.val(args);
		temp_pname_wild_val := ''; //InterfaceTranslator.pname_wild_val.val(args);
		
		temp_sec_range_value := args.sec_range;
		temp_addr_range := false; //InterfaceTranslator.addr_range.val(args);
		temp_prange_beg_value := 0; //InterfaceTranslator.prange_beg_value.val(args);
		temp_prange_end_value := 0; //InterfaceTranslator.prange_end_value.val(args);
		temp_addr_wild := false; //InterfaceTranslator.addr_wild.val(args); // may need to change this later to make
		                         // it work with wilds
		temp_prange_wild_value := ''; //InterfaceTranslator.prange_wild_value.val(args);
		
		

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
					STD.Str.WildMatch(doxie.StripOrdinal(args.pname_field), temp_pname_wild_val, TRUE)=> 0,
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