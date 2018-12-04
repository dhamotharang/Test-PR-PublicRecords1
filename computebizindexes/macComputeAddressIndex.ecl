EXPORT macComputeAddressIndex(dIn, InPrimaryName, InPrimaryRange, InSecondaryRange, InCity, InState, InZip, InJobId, keyName)  := FUNCTIONMACRO
IMPORT doxie;
			
	LOCAL dInWithCityCode := PROJECT(dIn(PhysicalAddressZip <> ''), 
		TRANSFORM({RECORDOF(LEFT),	UNSIGNED CityCode},
			SELF.CityCode	:= doxie.Make_CityCodes(LEFT.InCity).tho,
			SELF						:= LEFT));

  LOCAL strKeyName      := '~biz::key::'+ (STRING)keyName + 'address::' + (STRING)InJobId;
	LOCAL KeyAddress 			:= INDEX(dInWithCityCode, 
		{InPrimaryName,InPrimaryRange,InState,CityCode,InZip,InSecondaryRange}, 
		{dInWithCityCode}, 
    strKeyName);
		
	RETURN KeyAddress;
ENDMACRO;