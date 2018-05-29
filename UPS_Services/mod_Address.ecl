import iesp, Address;

// NOTE - 
// When streetIsPrimRange do not set the StreetAddress1 and StreetAddress2 values in response
// addresses.  There is at least one special hack (and others may be added
// later!) which override the default behavior of the cleaner.
//
// If values are returned in the StreetAddress fields and field values are
// later accessed through AutoStandard.InterfaceTranslator, the address will
// be re-parsed resulting in undesirable results.  The values returned by
// this module are expected to be the final parsed values used throughout
// UPS Services.

export mod_Address(iesp.share.t_Address inAddr, boolean isCanada = false) := MODULE

	shared enoughToClean(iesp.share.t_Address inp) :=
    (if (isCanada, inp.PostalCode, inp.Zip5) <> '')	OR
    (inp.City <> '' AND inp.State <> '' );

	inStreetAddrType1 := TRIM(TRIM(inAddr.StreetAddress1) + ' ' + TRIM(inAddr.StreetAddress2));
	inStreetAddrType2 := TRIM(TRIM(inAddr.StreetNumber) + ' ' + 
	                          TRIM(inAddr.StreetPreDirection) + ' ' + 
														   TRIM(inAddr.StreetName) + ' ' +  
                            TRIM(inAddr.StreetSuffix) + ' ' +  
                            TRIM(inAddr.StreetPostDirection) + ' ' +  
                            TRIM(inAddr.UnitDesignation) + ' ' +  
                            TRIM(inAddr.UnitNumber) 
													    );
														
	shared inStreetAddr := if(TRIM(inStreetAddrType1) <> '',inStreetAddrType1,inStreetAddrType2);
	
	inZip5 := TRIM(inAddr.Zip5, LEFT, RIGHT);
	shared useZip5 := MAP(LENGTH(inZip5) = 5 => inZip5,
												LENGTH(inZip5) = 4 => '0' + inZip5,
												LENGTH(inZip5) = 3 => '00' + inZip5,
												LENGTH(inZip5) = 2 => '000' + inZip5,
												'');  // if inZip5 was not given, it's '0' so force to empty string

	shared inCityStateZip := inAddr.City + ', ' + inAddr.State + ' ' + useZip5;

	// per bugzilla 38155, if only a one to six digit numeric value is given as
	// the street address, force it into the primray range field.  Default
	// behavior of the cleaner is to place this value into the primary name.
	shared streetIsPrimRange := REGEXFIND('^\\d{1,6}$', inStreetAddr);
	shared useStreetAddr := IF(streetIsPrimRange, '', inStreetAddr);
  shared CountryCode := if (isCanada , address.Components.Country.CA,address.Components.Country.US); 
	// the address cleaner is only useful if we have a city/state or a zip code
	// included with the input.  If neither are input, the cleaner does not even
	// attempt to parse the street address and returns an empty response.  In
	// these cases, we'll use a bogus city/state/zip to force a parse of the
	// street, but will exclude the artificial data from the response.
	export multi() := function
		enough  := enoughToClean(inAddr);
		fakeCityStateZip := if(CountryCode =address.Components.Country.CA ,'NOREALCITY, BC XXXXX','NOREALCITY, NY 00000');
		clnAddr := Address.GetCleanAddress(	useStreetAddr, 
																				if(enough, inCityStateZip, fakeCityStateZip),
																				CountryCode).results;
								
		iesp.share.t_Address MA() := transform
			self.StreetName := clnAddr.prim_name;
			self.StreetNumber:= if(streetIsPrimRange, inStreetAddr, clnAddr.prim_range);
			self.StreetPreDirection := clnAddr.predir;
			self.StreetPostDirection := clnAddr.postdir;
			self.StreetSuffix := clnAddr.suffix;
			self.UnitDesignation := clnAddr.unit_desig;
			self.UnitNumber := clnAddr.sec_range;
			self.StreetAddress1 := useStreetAddr;
			self.StreetAddress2 := '';
			self.City  := if(enough, clnAddr.v_city, inAddr.city);
			self.state := if(enough, clnAddr.state,  inAddr.state);
			self.zip5 := if(enough, clnAddr.zip,    useZip5);
			self.zip4 := if(enough, clnAddr.zip4,   '');
			self.county := '';
			self.postalcode := clnAddr.postal_code;
			self.statecityzip := '';
		end;
		
		r := DATASET([MA()])[1];								
					
		return r;
	end;
	
	// given our inputs, which is the better parsing method?
	export iesp.share.t_Address bestparser() := FUNCTION
		raw_resp := multi();	

		// sometimes, we get a street address input along the lines of "3688 JONES
		// BLVD 400".  Without a unit designation (APT, UNIT, STE, etc.), the 
		// address cleaner really doesn't do a good job, and outputs "JONES BLVD 
		// 400" as the primary name.  We'll attempt to catch these and correct
		// them in most cases.

		secRangeRegex:= '^(.+)\\s+(AVE|BLVD|CIR|HWY|PKWY|PL|RD|ST|TER|TRCE|TRL|WAY)\\s+(\\d+)\\s*$';

		hasStealthSecRange := raw_resp.StreetName <> '' AND
													raw_resp.StreetSuffix = '' AND
													raw_resp.UnitNumber = '' AND
													REGEXFIND(secRangeRegex, raw_resp.StreetName);

		primNameFromRegex := REGEXFIND(secRangeRegex, raw_resp.StreetName, 1);
		suffixFromRegex := REGEXFIND(secRangeRegex, raw_resp.StreetName, 2);
		secRangeFromRegex := REGEXFIND(secRangeRegex, raw_resp.StreetName, 3);

		iesp.share.t_Address MA() := transform
			self.StreetName := if(hasStealthSecRange, primNameFromRegex, raw_resp.StreetName);
			self.StreetNumber:= raw_resp.StreetNumber;
			self.StreetPreDirection := raw_resp.StreetPreDirection;
			self.StreetPostDirection := raw_resp.StreetPostDirection;
			self.StreetSuffix := if(hasStealthSecRange, suffixFromRegex, raw_resp.StreetSuffix);
			self.UnitDesignation := raw_resp.UnitDesignation;
			self.UnitNumber := if(hasStealthSecRange, secRangeFromRegex, raw_resp.UnitNumber);
			self.StreetAddress1 := raw_resp.StreetAddress1;
			self.StreetAddress2 := raw_resp.StreetAddress2;
			self.City  := raw_resp.City;
			self.state := raw_resp.State;
			self.zip5 := raw_resp.Zip5;
			self.zip4 := raw_resp.Zip4;
			self.county := raw_resp.County;
			self.postalcode := raw_resp.PostalCode;
			self.statecityzip := raw_resp.StateCityZip;
		end;
		
		fixed_resp := DATASET([MA()])[1];		

		return fixed_resp;	
	END;

END;