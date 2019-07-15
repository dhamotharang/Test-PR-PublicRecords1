IMPORT Address,STD;

EXPORT Clean_Address := MODULE

		// ---------------------------------------------------------------------------------------------------------------------------
		EXPORT Common_Layout := RECORD
				STRING  prim_range;
				STRING  predir;
				STRING  prim_name;
				STRING  addr_suffix;
				STRING  postdir;
				STRING  unit_desig;
				STRING  sec_range;
				STRING  p_city_name;		// (Postal) THIS IS NOT used for Roxie compares
				STRING	v_city_name;		// (Vanity) THIS IS THE ADDRESS THAT IS USED FOR ROXIE COMPARES
				STRING  st;
				STRING	zip5;
				STRING	zip4;
				STRING  Clean_streetaddr1;
				STRING	Clean_CityStZipString;
				STRING  err_stat;
		END;

		// ---------------------------------------------------------------------------------------------------------------------------
		// Returning this layout gives us everything that is included in FIPS plus a lot of other useful choices.
		EXPORT STDED_Layout := RECORD
				STRING64  addr1;
				STRING		addr2;
				STRING25  city;
				STRING2 	state;
				STRING9		zip;
				STRING64  orig_addr1;
				STRING64  orig_addr2;				
				STRING25  orig_city;
				STRING2 	orig_state;
				STRING10	orig_zip;				
				BOOLEAN 	wasErr := false;
				STRING		errorCode;
				Address.Layout_Clean182_fips;
		END;

		// ************** Extended Layout Clean function *********************************************************************************
		// Useful if you want addLine1 and 2 back or other useful fields (also returns original addresses for complex jobs)
		SHARED STDED_Layout CleanExtendedLayout (STRING address1, STRING address2, STRING City='', STRING State='', STRING Zip='') := FUNCTION
				ca			:= Address.CleanAddress182(address1, address2);																					 
				FIPS		:= Address.CleanAddressFieldsFips(ca).addressrecord;
				addr1		:= Address.Addr1FromComponents(FIPS.prim_range,FIPS.predir,FIPS.prim_name,FIPS.addr_suffix,FIPS.postdir,FIPS.unit_desig,FIPS.sec_range);
				addr2 	:= Address.Addr2FromComponents(FIPS.v_city_name, FIPS.st, FIPS.Zip);
				RETURN ROW(TRANSFORM(STDED_Layout,
									SELF.addr1 := addr1;
									SELF.addr2 := addr2;
									SELF.city := FIPS.v_city_name;
									SELF.state := FIPS.st;
									SELF.zip := FIPS.zip+FIPS.zip4;
									SELF.orig_addr1 := address1;
									SELF.orig_addr2 := addr2;
									SELF.orig_city := City;
									SELF.orig_state := State;
									SELF.orig_zip := Zip;													
									SELF.wasErr := (FIPS.err_stat[1] = 'E');
									SELF.errorCode := FIPS.err_stat;
									SELF := FIPS;
									));
		END;
		//****************************************************************************************************************************

		// ---------------------------------------------------------------------------------------------------------------------------
		EXPORT Address.Layout_Clean182_fips FromLine(STRING60	AddressLine1,																									
																								 STRING25	City,
																								 STRING2	State,
																								 STRING5	Zip5,
																								 STRING4	Zip4 = '' ) 			:= FUNCTION				
				// Clean the customer's input address
				// Fix required because EG: '10300 LITTLE PATUXENT PKW # 2452' produces a clean address with blank unit_desc and blank sec_range
				// When we are generating a bunch of addresses to use this creates duplicates.
				//TODO ???? DO WE NEED THIS EVERYWHERE IN THIS MODULE????
				AddressLine1Fix			:= STD.STR.FindReplace(AddressLine1,'#',' ');
				AddressLine2				:= Address.Addr2FromComponentsWithZip4(City, State, Zip5, Zip4); 		
				CleanedAddress			:= Address.CleanAddress182(AddressLine1Fix, AddressLine2);																					 
																												
				RETURN Address.CleanAddressFieldsFips(CleanedAddress).addressrecord;
		END;

		// ---------------------------------------------------------------------------------------------------------------------------	
		EXPORT Address.Layout_Clean182_fips FromPieces(STRING10		HouseNumber,
																									 STRING2		StreetPreDirection,
																									 STRING28		StreetName,
																									 STRING4		StreetSuffix,
																									 STRING2		StreetPostDirection,
																									 STRING10		UnitDesignation,
																									 STRING8		UnitNumber,
																									 STRING25		City,
																									 STRING2		State,
																									 STRING5		Zip5,
																									 STRING4		Zip4 ) 		:= FUNCTION
				
				UnitDesignation_USE := 	STD.STR.FindReplace(UnitDesignation,'#',' ');
				// Clean the customer's input address
				AddressLine1				:= Address.Addr1FromComponents(HouseNumber, StreetPreDirection, StreetName,
																													 StreetSuffix, StreetPostDirection, UnitDesignation_USE, UnitNumber); 

				RETURN FromLine(AddressLine1,City, State, Zip5, Zip4);
		END;

		// ---------------------------------------------------------------------------------------------------------------------------
		// Input = addr1 and addr2 - an extended layout back.
		EXPORT STDED_Layout cleanAd1Ad2ExtLayout(STRING	inAddr1,STRING	addr2) := FUNCTION	
				// clean address with a # doesn't seem to work well.			4204 41ST AVE N # 57 returns 4204 41ST AVE N (drops the 57 completely)
				address1 		:= STD.Str.FindReplace(inAddr1, '#', ' APT ');		// This isn't perfect, ONLY do the replace if the address held "#"
				// Also - check from time to time - they may correct the problem that existed in cleaning when it saw: 123 Main St # 12
				RETURN CleanExtendedLayout(address1, addr2);																					 
		END;
		// Needed for existing Boca code using this name
		EXPORT STDED_Layout cleanAddr1Addr2(STRING	inAddr1,STRING	addr2) := cleanAd1Ad2ExtLayout(inAddr1,addr2);
		// ---------------------------------------------------------------------------------------------------------------------------
		EXPORT STDED_Layout FromLineExtLayout(STRING60	AddressLine1,																									
																								 STRING25	City,
																								 STRING2	State,
																								 STRING5	Zip5,
																								 STRING4	Zip4 = '' ) 			:= FUNCTION				
				AddressLine1Fix			:= STD.STR.FindReplace(AddressLine1,'#',' ');
				AddressLine2				:= Address.Addr2FromComponentsWithZip4(City, State, Zip5, Zip4);
				RETURN cleanAd1Ad2ExtLayout(AddressLine1Fix, AddressLine2);																					 
		END;

		// ---------------------------------------------------------------------------------------------------------------------------

END;