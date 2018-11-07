IMPORT HIPIEBIZ, STD, ut, doxie, Address, Relavator;
EXPORT BusinessRecords(DATASET(HIPIEBIZ.Layouts.BusinessInput) dIn,
                       HIPIEBIZ.Options.SearchParams inOptions) := FUNCTION

	//By Address
	dAddress								:= dIn(BusinessZip <> '' or BusinessCity <> '' or BusinessState <> '' or BusinessAddress <> '');
	dCleanAddress						:= Address.mac_CleanAddress(dAddress,BusinessAddress,,,BusinessCity,BusinessState,BusinessZip,'BusinessClean');
	dCleanAddressCityCodes	:= PROJECT(dCleanAddress(BusinessCleanPrimaryName <> ''),/*(BusinessCleanZip <> '' or BusinessCleanVanityCity <> ''),*/ 
		TRANSFORM({RECORDOF(LEFT), SET OF UNSIGNED BusinessCityCodes},
			SELF.BusinessCityCodes	:= IF(LEFT.BusinessCleanVanityCity	<>'',doxie.Make_CityCodes(LEFT.BusinessCleanVanityCity).rox,[])  
				+ ut.ZipToCities(LEFT.BusinessCleanZip).set_codes,
			SELF						:= LEFT));
			
	dByAddress	:= JOIN(dCleanAddressCityCodes, HIPIEBIZ.Keys(inOptions).KeyBusinessAddress,
		KEYED(LEFT.BusinessCleanPrimaryName 	= RIGHT.PhysicalAddressPrimaryName OR LEFT.BusinessCleanPrimaryName='') AND
		KEYED(LEFT.BusinessCleanPrimaryRange	=	RIGHT.PhysicalAddressPrimaryRange OR LEFT.BusinessCleanPrimaryRange='') AND
		KEYED(LEFT.BusinessCleanState 				= RIGHT.PhysicalAddressState OR LEFT.BusinessCleanState='') AND
		KEYED(RIGHT.CityCode	IN	LEFT.BusinessCityCodes OR LEFT.BusinessCleanVanityCity='') AND
		KEYED(LEFT.BusinessCleanZip						= RIGHT.PhysicalAddressZip OR LEFT.BusinessCleanZip='') AND
		KEYED(LEFT.BusinessCleanSecondaryRange=RIGHT.PhysicalAddressSecondaryRange OR LEFT.BusinessCleanSecondaryRange=''),
		TRANSFORM(HIPIEBIZ.Layouts.SearchOutput,
			SELF	:= LEFT,
			SELF	:= RIGHT),
		LIMIT(0), KEEP(1000));
	
	
	//By Name
	dBusinessName := JOIN(dIn(BusinessName <> ''), dCleanAddress(BusinessName <> ''),
		LEFT.seq = RIGHT.seq,
		TRANSFORM(RECORDOF(RIGHT),
			SELF := LEFT,
			SELF := RIGHT),
		LEFT OUTER,
		LIMIT(0), KEEP(1));
	
	fRemoveCharacters(STRING toClean) := FUNCTION
    RETURN STD.str.CleanSpaces(REGEXREPLACE('[-~^ *&%#@!_<>?|/,.]+',toClean,' '));
  END;
  
	dCleanBusinessName	:= PROJECT(dBusinessName,
		TRANSFORM({RECORDOF(LEFT), STRING StrippedBusinessName},
			SELF.BusinessName		:= STD.str.CleanSpaces(LEFT.BusinessName),
			SELF.StrippedBusinessName		:= STD.str.ToUpperCase(fRemoveCharacters(LEFT.BusinessName)),
			SELF.BusinessCity 	:= STD.str.ToUpperCase(fRemoveCharacters(LEFT.BusinessCity)),
			SELF.BusinessState	:= STD.str.ToUpperCase(fRemoveCharacters(LEFT.BusinessState)),
			SELF								:= LEFT));
			
	dByBusinessName	:= JOIN(dCleanBusinessName,	HIPIEBIZ.Keys(inOptions).KeyBusinessName,
		KEYED(LEFT.StrippedBusinessName = RIGHT.CompanyName[1..LENGTH(TRIM(LEFT.StrippedBusinessName))]) AND
		(LEFT.BusinessState IN [RIGHT.PhysicalAddressState, RIGHT.MailingAddressState] OR LEFT.BusinessState='') AND
		(LEFT.BusinessCity IN [RIGHT.PhysicalAddressVanityCity, RIGHT.MailingAddressVanityCity, RIGHT.PhysicalAddressPostalCity, RIGHT.MailingAddressPostalCity] OR LEFT.BusinessCity=''),
		TRANSFORM(HIPIEBIZ.Layouts.SearchOutput,
			SELF	:= LEFT,
			SELF	:= RIGHT),
		LIMIT(0), KEEP(10000))
      + JOIN(dCleanBusinessName, HIPIEBIZ.Keys(inOptions).KeyBusinessName,
        KEYED(fRemoveCharacters(LEFT.BusinessName) = RIGHT.CompanyName),
        TRANSFORM(HIPIEBIZ.Layouts.SearchOutput,
          SELF := LEFT,
          SELF := RIGHT));
		
	//By FEIN
	dCleanFEIN	:= PROJECT(dIn(FEIN <> ''),
		TRANSFORM(RECORDOF(LEFT),
			SELF.FEIN	:= STD.str.CleanSpaces(regexreplace('[-~^ *&%#@!_<>?|/]+',LEFT.FEIN,'')),
			SELF			:= LEFT));
			
	dByFEIN	:= JOIN(dCleanFEIN, HIPIEBIZ.Keys(inOptions).KeyBusinessTaxID,
		KEYED(LEFT.FEIN 	= RIGHT.fein[1..LENGTH(TRIM(LEFT.FEIN))]),
		TRANSFORM(HIPIEBIZ.Layouts.SearchOutput,
			SELF	:= LEFT,
			SELF	:= RIGHT),
		LIMIT(0), KEEP(1000));
		
	
	macJoin(dIn1, dIn2) := FUNCTIONMACRO
		dOut := JOIN(dIn1, dIn2,
			LEFT.BizRecId = RIGHT.BizRecId,
			TRANSFORM(LEFT),
			LIMIT(0), KEEP(1));
		RETURN dOut;
	ENDMACRO;
	
	boolean searchBusinessName := exists(dCleanBusinessName);
	boolean searchAddress := exists(dCleanAddressCityCodes);
	boolean searchFEIN := exists(dCleanFEIN);
	SearchCount := (integer)searchBusinessName + (integer)searchAddress + (integer)searchFEIN;

	dJoin1			:= MAP(searchBusinessName => dByBusinessName,
		searchAddress => dByAddress,
		dByFEIN);
	dJoin2			:= MAP(searchBusinessName and searchAddress => dByAddress,
		dByFEIN);
    
	dJoin3			:= macJoin(dJoin1, dJoin2);
	dBIZBusinessRecords	:= CASE(SearchCount, 
		3 => macJoin(dJoin3, dByFEIN),
		2 => dJoin3,
		dJoin1);//we were searching with only one search criteria 
	
	dBusinessInt				:= DEDUP(SORT(dBIZBusinessRecords, BizRecId), BizRecId);
  
	dBusinessOut      	:= JOIN(dBusinessInt, HIPIEBIZ.Keys(inOptions).KeyPayload, 
		KEYED(LEFT.BizRecId = RIGHT.BizRecId),
		TRANSFORM(HIPIEBIZ.Layouts.SearchOutput,
			SELF := RIGHT,
			SELF := LEFT),
		LIMIT(0), KEEP(1));
	// output(dByBusinessName, named('dByBusinessName'));
	// output(dByAddress, named('dByAddress'));
	// output(dByFEIN, named('dByFEIN'));
	RETURN dBusinessOut;
END;