IMPORT tools;
EXPORT mac_Append_CleanAddresses( 
	in_file, 
	in_cache
	)
:= FUNCTIONMACRO

	in_file T_Cache(in_file L, in_cache R) := TRANSFORM
		SELF.record_id := L.record_id;
		SELF := R;
	END;

	in_file T_PREP(in_file L) := TRANSFORM
		SELF.record_id := L.record_id;
		SELF := L;
	END;

	in_file T_Clean( in_file L ) := TRANSFORM 
				SELF.record_id := L.record_id,
				v_address_1 := stringlib.stringfilterout( tools.AID_Helpers.fRawFixLine1( trim(L.Street_1) + ' ' +  trim(L.Street_2)),'.?<&>*@!\\$=+%~\'');
				v_address_2 := tools.AID_Helpers.fRawFixLineLast( stringlib.stringtouppercase(trim(L.city) + if(L.state != '', ', ', '') + trim(L.state)  + ' ' + trim(L.zip)[1..5]));

	//*********************************************  CleanAddress182  **************************************************//
				Clean_Address_182 :=  address.CleanAddress182(v_address_1, v_address_2 );
	//******************************************************************************************************************//				
				SELF.clean_address.prim_range := Clean_Address_182[1..10]       ; //prim_range
				SELF.clean_address.predir := Clean_Address_182[11..12]          ; //predir
				SELF.clean_address.prim_name := Clean_Address_182[13..40]       ; //prim_name
				SELF.clean_address.addr_suffix := Clean_Address_182[41..44]     ; //addr_suffix
				SELF.clean_address.postdir := Clean_Address_182[45..46]         ; //postdir
				SELF.clean_address.unit_desig := Clean_Address_182[47..56]      ; //unit_desig
				SELF.clean_address.sec_range := Clean_Address_182[57..64]       ; //sec_range
				SELF.clean_address.p_city_name := Clean_Address_182[65..89]     ; //p_city_name
				SELF.clean_address.v_city_name := Clean_Address_182[90..114]    ; //v_city_name
				SELF.clean_address.st := Clean_Address_182[115..116]            ; //st
				SELF.clean_address.zip := Clean_Address_182[117..121]           ; //zip
				SELF.clean_address.zip4 := Clean_Address_182[122..125]          ; //zip4
				SELF.clean_address.cart := Clean_Address_182[126..129]          ; //cart
				SELF.clean_address.cr_sort_sz := Clean_Address_182[130]         ; //cr_sort_sz
				SELF.clean_address.lot := Clean_Address_182[131..134]           ; //lot
				SELF.clean_address.lot_order := Clean_Address_182[135]          ; //lot_order
				SELF.clean_address.dbpc := Clean_Address_182[136..137]          ; //dpbc
				SELF.clean_address.chk_digit := Clean_Address_182[138]          ; //chk_digit
				SELF.clean_address.rec_type := Clean_Address_182[139..140]      ; //record_type
				SELF.clean_address.fips_state := Clean_Address_182[141..142]    ; //ace_fips_state
				SELF.clean_address.fips_county := Clean_Address_182[143..145]   ; //county
				SELF.clean_address.geo_lat := Clean_Address_182[146..155]       ; //geo_lat
				SELF.clean_address.geo_long := Clean_Address_182[156..166]      ; //geo_long
				SELF.clean_address.msa := Clean_Address_182[167..170]           ; //msa
				SELF.clean_address.geo_blk := Clean_Address_182[171..177]       ; //geo_blk
				SELF.clean_address.geo_match := Clean_Address_182[178]          ; //geo_match
				SELF.clean_address.err_stat := Clean_Address_182[179..182]      ; //err_stat	
				SELF := L;
	END;

	//*********************************************  Valid Input Addresses **************************************************//
    validAddresses := in_file( street_1 <> '' and  ( ( city <> '' and (State <> '' or Zip <> '' ) ) OR ( State <> '' and Zip  <> '' )));

	//*********************************************  Invalid or Empty Input Addresses **************************************************//
    invalidOrEmptyAddresses := join(in_file, validAddresses, left.record_id = right.record_id, left only);

    //*********************************************  Find in Cache **************************************************//

	cachedAddresses := JOIN(
		distribute(validAddresses,HASH32( State, City, Zip, Street_1, Street_2  )),
		distribute(in_cache,HASH32( State, City, Zip, Street_1, Street_2  )),
		LEFT.state = RIGHT.state and  
		LEFT.city = RIGHT.city  and  
		LEFT.zip = RIGHT.zip and 
		LEFT.street_1 = RIGHT.street_1 and  
        LEFT.street_2 = RIGHT.street_2, 
        T_Cache(Left, Right),
		INNER,
		KEEP(1),
		LOCAL
	);

	//*********************************************  Not Found  **************************************************//
    cleanedAddresses := JOIN(
		distribute(validAddresses, hash32(record_Id)),
		distribute(cachedAddresses, hash32(record_Id)),
		LEFT.record_id = RIGHT.record_id,
		T_Clean(Left),
        LEFT ONLY,
		LOCAL		
	);
    
	//*********************************************  Merged All Addresses  **************************************************//
	srt_mergedAddresses := SORT(cachedAddresses + cleanedAddresses + invalidOrEmptyAddresses, record_id );    
	ddp_mergedAddresses := DEDUP(srt_mergedAddresses, record_id);

	//*********************************************  Output Addresses  **************************************************//
    prepOuputAddresses := PROJECT(ddp_mergedAddresses, TRANSFORM(FraudGovPlatform.Layouts.Temp.CleanAddressSlim, 
        SELF.address_1 := tools.AID_Helpers.fRawFixLine1( trim(LEFT.clean_address.prim_range) + ' ' +  trim(LEFT.clean_address.predir) + ' ' + trim(LEFT.clean_address.prim_name) +' '+ trim(LEFT.clean_address.addr_suffix) +' '+ trim(LEFT.clean_address.postdir) +' '+ trim(LEFT.clean_address.unit_desig) +' '+trim(LEFT.clean_address.sec_range));
        SELF.address_2 := tools.AID_Helpers.fRawFixLineLast( stringlib.stringtouppercase(trim(LEFT.clean_address.v_city_name) + if(LEFT.clean_address.v_city_name != '' and (LEFT.clean_address.st !='' or LEFT.clean_address.zip !=''), ', ', '') + trim(LEFT.clean_address.st) + ' ' + trim(LEFT.clean_address.zip)));
        SELF := LEFT;
    ));
	
	RETURN (prepOuputAddresses);

ENDMACRO;