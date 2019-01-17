IMPORT HIPIEBIZ, Address, STD, NID, doxie, ut, Relavator;
EXPORT OfficerRecords(DATASET(HIPIEBIZ.Layouts.OfficerInput) dIn,
                      HIPIEBIZ.Options.SearchParams inOptions) := FUNCTION
	
	//By Address
	dAddress								:= dIn(OfficerZip <> '' or OfficerCity <> '' or OfficerState <> '' or OfficerAddress <> '');
	dCleanAddress						:= Address.mac_CleanAddress(dAddress,OfficerAddress,,,OfficerCity,OfficerState,OfficerZip,'OfficerClean');
	dCleanAddressCityCodes	:= PROJECT(dCleanAddress(OfficerCleanPrimaryRange <> '' AND OfficerCleanPrimaryRange <> ''),/*(OfficerCleanZip <> '' or OfficerCleanVanityCity <> ''), */
		TRANSFORM({RECORDOF(LEFT), SET OF UNSIGNED OfficerCityCodes},
			SELF.OfficerCityCodes	:= IF(LEFT.OfficerCleanVanityCity	<>'',doxie.Make_CityCodes(LEFT.OfficerCleanVanityCity).rox,[])  
				+ ut.ZipToCities(LEFT.OfficerCleanZip).set_codes,
			SELF						:= LEFT));
			
	dByAddress	:= JOIN(dCleanAddressCityCodes, HIPIEBIZ.Keys(inOptions).KeyOfficerAddress,
		KEYED(LEFT.OfficerCleanPrimaryName 	= RIGHT.ReportedOfficerCleanPrimaryName OR LEFT.OfficerCleanPrimaryName='') AND
		KEYED(LEFT.OfficerCleanPrimaryRange	=	RIGHT.ReportedOfficerCleanPrimaryRange OR LEFT.OfficerCleanPrimaryRange='') AND
		KEYED(LEFT.OfficerCleanState 				= RIGHT.ReportedOfficerCleanState OR LEFT.OfficerCleanState='') AND
		KEYED(RIGHT.CityCode	IN	LEFT.OfficerCityCodes OR LEFT.OfficerCleanVanityCity='') AND
		KEYED(LEFT.OfficerCleanZip						= RIGHT.ReportedOfficerCleanZip OR LEFT.OfficerCleanZip='') AND
		KEYED(LEFT.OfficerCleanSecondaryRange=RIGHT.ReportedOfficerCleanSecondaryRange OR LEFT.OfficerCleanSecondaryRange=''),
		TRANSFORM(HIPIEBIZ.Layouts.rOfficers,
			SELF	:= LEFT,
			SELF	:= RIGHT,
			SELF	:= []),
		LIMIT(0), KEEP(1000));
	
	//By Name
	dOfficerName := JOIN(dIn(OfficerName <> ''), dCleanAddress(OfficerName <> ''),
		LEFT.seq = RIGHT.seq,
		TRANSFORM(RECORDOF(RIGHT),
			SELF := LEFT,
			SELF := RIGHT),
		LEFT OUTER,
		LIMIT(0), KEEP(1));
	
	dCleanOfficerName	:= PROJECT(dOfficerName,
		TRANSFORM({RECORDOF(LEFT), STRING OfficerFirstName, STRING OfficerMiddleName, STRING OfficerLastName, STRING OfficerNameSuffix},
			ROName := Address.CleanNameFields(Address.CleanPerson73(LEFT.OfficerName)).CleanNameRecord;
			SELF.OfficerFirstName		:= ROName.fname,
			SELF.OfficerMiddleName	:= ROName.mname,
			SELF.OfficerLastName		:= ROName.lname,
			SELF.OfficerNameSuffix	:= ROName.name_suffix,
			SELF.OfficerState				:= STD.str.ToUpperCase(STD.str.CleanSpaces(regexreplace('[-~^ *&%#@!_<>?|/]+',LEFT.OfficerState,' '))),
			SELF														:= LEFT));

	BOOLEAN pfe(string20 l, string20 r) := NID.mod_PFirstTools.SubLinPFR(l,r);
		
	dByName	:= JOIN(dCleanOfficerName,	HIPIEBIZ.Keys(inOptions).KeyOfficerName,
		KEYED(RIGHT.OfficerPhoneticLastName=metaphonelib.DMetaPhone1(LEFT.OfficerLastName)[1..6]) AND
		KEYED(RIGHT.OfficerLastName=LEFT.OfficerLastName) AND
		KEYED(pfe(RIGHT.OfficerPreferredFirstName,LEFT.OfficerFirstName) OR
			RIGHT.OfficerPreferredFirstName=(STRING1)LEFT.OfficerFirstName OR 
			RIGHT.OfficerPreferredFirstName[1..length(trim(LEFT.OfficerFirstName))]=(STRING20)LEFT.OfficerFirstName OR
			LENGTH(TRIM(LEFT.OfficerFirstName))<2) AND
		KEYED(RIGHT.OfficerMiddleName[1..LENGTH(TRIM(LEFT.OfficerMiddleName))] = LEFT.OfficerMiddleName) AND
		(LEFT.OfficerState = RIGHT.ReportedOfficerCleanState OR LEFT.OfficerState=''),
		TRANSFORM(HIPIEBIZ.Layouts.rOfficers,
			SELF	:= LEFT,
			SELF	:= RIGHT,
			SELF	:= []),
		LIMIT(0), KEEP(1000));
  
	//By SSN
	dCleanSSN	:= PROJECT(dIn(SSN <> ''),
		TRANSFORM(RECORDOF(LEFT),
			SELF.SSN	:= STD.str.CleanSpaces(regexreplace('[-~^ *&%#@!_<>?|/]+',LEFT.SSN,'')),
			SELF			:= LEFT));
			
	dBySSN := JOIN(dCleanSSN, HIPIEBIZ.Keys(inOptions).KeyOfficerTaxID,
		KEYED(LEFT.SSN 	= RIGHT.ReportedOfficerSSN[1..LENGTH(TRIM(LEFT.SSN))]),
		TRANSFORM(HIPIEBIZ.Layouts.rOfficers,
			SELF	:= LEFT,
			SELF	:= RIGHT,
      SELF  := []),
		LIMIT(0), KEEP(1000));
		
	macJoin(dIn1, dIn2) := FUNCTIONMACRO
		dOut := JOIN(dIn1, dIn2,
			LEFT.BizRecId = RIGHT.BizRecId,
			TRANSFORM(LEFT),
			LIMIT(0), KEEP(1));
		RETURN dOut;
	ENDMACRO;
	
	boolean searchName := exists(dCleanOfficerName);
	boolean searchAddress := exists(dCleanAddressCityCodes);
	boolean searchSSN := exists(dCleanSSN);
	SearchCount := (integer)searchName + (integer)searchAddress + (integer)searchSSN;
	
	dJoin1			:= MAP(searchName => dByName,
		searchAddress => dByAddress,
		dBySSN);
	dJoin2			:= MAP(searchName and searchAddress => dByAddress,
		dBySSN);
	dJoin3			:= macJoin(dJoin1, dJoin2);
	dBIZOfficerRecords	:= CASE(SearchCount, 
		3 => macJoin(dJoin3, dBySSN),
		2 => dJoin3,
		dJoin1);//we were searching with only one search criteria 
	
	dOfficerInt	:= DEDUP(SORT(dBIZOfficerRecords, BizRecId, -ReportedOfficerEntityContextUID), BizRecId);

	dOfficerOut	:= JOIN(dOfficerInt, HIPIEBIZ.Keys(inOptions).KeyPayload, 
		KEYED(LEFT.BizRecId = RIGHT.BizRecId),
		TRANSFORM(HIPIEBIZ.Layouts.SearchOutput,
			SELF := RIGHT,
			SELF := LEFT),
		LIMIT(0), KEEP(1));
		
	// output(dByName, named('dByOfficerName'));
	// output(dByAddress, named('dByOfficerAddress'));
	// output(dBySSN, named('dByOfficerSSN'));
	RETURN dOfficerOut;
END;