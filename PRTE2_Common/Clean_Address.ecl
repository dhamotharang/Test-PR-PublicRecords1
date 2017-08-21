IMPORT Address,STD;

EXPORT Clean_Address := MODULE

		EXPORT Common_Layout := RECORD
				STRING  prim_range;
				STRING  predir;
				STRING  prim_name;
				STRING  addr_suffix;
				STRING  postdir;
				STRING  unit_desig;
				STRING  sec_range;
				STRING  p_city_name;
				STRING	v_city_name;
				STRING  st;
				STRING	zip5;
				STRING	zip4;
				STRING  Clean_streetaddr1;
				STRING	Clean_CityStZipString;
				STRING  err_stat;
		END;
		
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

		EXPORT GenerateUnitDesc(STRING1 digitString) := FUNCTION
				RETURN MAP( digitString IN ['1','5','9'] => 'APT',
												 digitString IN ['2','6'] => 'UNIT',
												 digitString IN ['3','7'] => 'STE',
												 digitString IN ['4','8'] => 'LOT',
												 'APT'); 

		END;

		// ---------------------------------------------------------------------------------------------------------------------------
		// standardizeAddr1CSZ() and randomizeUnitDesig()
		// This will pro-actively standardize CT addresses - we discovered that addresses have mixed 'APT' and 'STE' and 'LOT', etc
		// ---------------------------------------------------------------------------------------------------------------------------
		EXPORT randomizeUnitDesig(Address.Layout_Clean182_fips FIPS) := FUNCTION
				// Address.Layout_Clean182_fips 
				boolean wasErr := (FIPS.err_stat[1] = 'E');
				// Look at the prim_range[1] select the proper unit_desig and re-do the clean and return that this new clean address.
				// However, if the incoming FIPS have a solid error condition, we won't mess further but just return that original FIPS
				digitString := FIPS.prim_range[1];
				hasSecRange := FIPS.sec_range != '';
				newUnitD := GenerateUnitDesc(digitString);
				filteredUnitD := IF(hasSecRange, newUnitD, ''); //If no second range, we don't need the unit.
	
				NEWFIPS := ROW(FIPS, TRANSFORM(address.Layout_Clean182_fips,
																						SELF.unit_desig := filteredUnitD;
																						SELF := LEFT));
				RETURN IF(wasErr, FIPS, NEWFIPS);
		END;

		// ---------------------------------------------------------------------------------------------------------------------------
		// Easy Spreadsheet clean address - in and out are both in format of: address1,city,state,zip
		// ---------------------------------------------------------------------------------------------------------------------------
		// ************** Shared Base Clean function *********************************************************************************
		SHARED STDED_Layout baseClean (STRING address1, STRING address2, STRING City='', STRING State='', STRING Zip='') := FUNCTION
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
		// HERE FIPS has been updated, and InRecord contains all the "orig_" values.  Merge these to a new record.
		SHARED STDED_Layout updateValuesChanged (STDED_Layout InRecord, Address.Layout_Clean182_fips FIPS) := FUNCTION
				addr1		:= 	Address.Addr1FromComponents(FIPS.prim_range,FIPS.predir,FIPS.prim_name,FIPS.addr_suffix,FIPS.postdir,FIPS.unit_desig,FIPS.sec_range);
				addr2 	:= 	Address.Addr2FromComponents(FIPS.v_city_name, FIPS.st, FIPS.Zip);
				RETURN ROW(TRANSFORM(STDED_Layout,
									SELF.addr1 := addr1;
									SELF.addr2 := addr2;
									SELF.city := FIPS.v_city_name;
									SELF.state := FIPS.st;
									SELF.zip := FIPS.zip+FIPS.zip4;
									SELF.orig_addr1 := InRecord.orig_addr1;
									SELF.orig_addr2 := InRecord.orig_addr2;
									SELF.orig_city := InRecord.orig_city;
									SELF.orig_state := InRecord.orig_state;
									SELF.orig_zip := InRecord.orig_zip;													
									SELF.wasErr := (FIPS.err_stat[1] = 'E');
									SELF.errorCode := FIPS.err_stat;
									SELF := FIPS;
									));
		END;
		//****************************************************************************************************************************

		// ---------------------------------------------------------------------------------------------------------------------------
		// WARNING! This will pro-actively standardize CT addresses - 
		// Why? we discovered that sometimes the same addresses in different CT Product data have mixed 'APT' and 'STE' and 'LOT', etc
		EXPORT STDED_Layout standardizeAddr1CSZ (STRING60	inAddr1,																									
																			 STRING25	City,
																			 STRING2	State,
																			 STRING10	Zip ) 								:= FUNCTION	
				// clean address with a # doesn't seem to work well.																			 
				address1 		:= STD.Str.FindReplace(inAddr1, '#', ' APT ');
				addr2				:= Address.Addr2FromComponents(City, State, Zip); 		
				StdClean		:= baseClean(address1,addr2,City, State, Zip);		// Returns a FIPS record inside the layout
				TmpFips	:= PROJECT( StdClean, TRANSFORM(Address.Layout_Clean182_fips, SELF := LEFT) );
				FIPS := randomizeUnitDesig(TmpFips); 
				retVal := updateValuesChanged(StdClean, FIPS);
				return retVal;
		END;
		
		// ---------------------------------------------------------------------------------------------------------------------------
		// Input = addr1 and C,S,Z
		EXPORT STDED_Layout cleanAddr1CSZ (STRING60	inAddr1,																									
																			 STRING25	City,
																			 STRING2	State,
																			 STRING5	Zip ) 								:= FUNCTION	
				// clean address with a # doesn't seem to work well.			4204 41ST AVE N # 57 returns 4204 41ST AVE N (drops the 57 completely)
				address1 		:= STD.Str.FindReplace(inAddr1, '#', ' APT ');
				addr2				:= Address.Addr2FromComponents(City, State, Zip); 		
				RETURN baseClean(address1, addr2, City, State, Zip);								 
		END;
		// ---------------------------------------------------------------------------------------------------------------------------
		// Input = addr1 and addr2
		EXPORT STDED_Layout cleanAddr1Addr2(STRING	inAddr1,STRING	addr2) := FUNCTION	
				// clean address with a # doesn't seem to work well.			4204 41ST AVE N # 57 returns 4204 41ST AVE N (drops the 57 completely)
				address1 		:= STD.Str.FindReplace(inAddr1, '#', ' APT ');		// This isn't perfect, ONLY do the replace if the address held "#"
				// Also - check from time to time - they may correct the problem that existed in cleaning when it saw: 123 Main St # 12
				RETURN baseClean(address1, addr2);																					 
		END;
		// ---------------------------------------------------------------------------------------------------------------------------


		// Ensure that something precedes unit number if one was provided (address cleaner seems to work better with a unit designation)
		SHARED CalculateUnitDesignation(STRING UnitNumber, STRING UnitDesignation) := FUNCTION
				RETURN MAP(TRIM(UnitNumber, LEFT, RIGHT) <> '' AND TRIM(UnitDesignation, LEFT, RIGHT) <> '' => UnitDesignation,
																	 TRIM(UnitNumber, LEFT, RIGHT) <> '' AND TRIM(UnitDesignation, LEFT, RIGHT) = '' AND UnitNumber[1] <> '#' => 'APT',
																	 '');																	 
		END;																	 
		
		EXPORT Address.Layout_Clean182_fips FromLine(STRING60	AddressLine1,																									
																								 STRING25	City,
																								 STRING2	State,
																								 STRING5	Zip5,
																								 STRING4	Zip4='' ) 			:= FUNCTION				
				// Clean the customer's input address
				AddressLine2				:= Address.Addr2FromComponentsWithZip4(City, State, Zip5, Zip4); 		
				CleanedAddress			:= Address.CleanAddress182(AddressLine1, AddressLine2);																					 
																												
				RETURN Address.CleanAddressFieldsFips(CleanedAddress).addressrecord;
		END;
		
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
				
				UnitDesignation_USE := CalculateUnitDesignation(UnitNumber,UnitDesignation);
				
				// Clean the customer's input address
				AddressLine1				:= Address.Addr1FromComponents(HouseNumber, StreetPreDirection, StreetName,
																													 StreetSuffix, StreetPostDirection, UnitDesignation_USE, UnitNumber); 

				RETURN FromLine(AddressLine1,City, State, Zip5, Zip4);
		END;

END;