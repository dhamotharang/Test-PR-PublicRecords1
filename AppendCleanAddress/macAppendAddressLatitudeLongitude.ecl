EXPORT macAppendAddressLatitudeLongitude(inData,InPrimaryRange,InPreDirectional,InPrimaryName,InAddressSuffix,InPostDirectional,
		InUnitDesignation,InSecondaryRange,InCity,InState,Inzip,InLatitude,InLongitude,InGeoMatchCode, InGeoMatchCodeThreshold) := FUNCTIONMACRO
	IMPORT Address;
  
	LOCAL rCleaned := RECORD
		INTEGER _seq;
		STRING AddressLine1;
		STRING AddressLine2;
		RECORDOF(inData);
	END;
	
	LOCAL dInClean := PROJECT(inData, TRANSFORM(rCleaned,
		SELF._seq	:= COUNTER,
		SELF.AddressLine1	:= TRIM(TRIM(LEFT.Inprimaryrange)) + TRIM(' ' + TRIM(LEFT.Inpredirectional)) + TRIM(' ' + TRIM(LEFT.Inprimaryname)) + TRIM(' ' + TRIM(LEFT.Inaddresssuffix)) + TRIM(' ' + TRIM(LEFT.Inpostdirectional));              
		SELF.AddressLine2	:= TRIM(TRIM(LEFT.Inunitdesignation)) + TRIM(' ' + TRIM(LEFT.Insecondaryrange)); 
		SELF	:= LEFT));
		
	LOCAL dCleaned := AppendCleanAddress.mac_CleanAddress(dInClean, 20000000, AddressLine1,, AddressLine2, InCity, InState, InZip, '_prefix');
	
	LOCAL rOut := RECORD
		RECORDOF(inData);
		REAL InLatitude;
		REAL InLongitude;
		STRING InGeoMatchCode;
	END;
	
	LOCAL rOut appendLatitudeLongitude(dInClean L, dCleaned R) := TRANSFORM
		SELF.InLatitude := IF((INTEGER)R._prefixGeoMatchCode <= (INTEGER)InGeoMatchCodeThreshold,(REAL)R._prefixLatitude, 0);
		SELF.InLongitude := IF((INTEGER)R._prefixGeoMatchCode <= (INTEGER)InGeoMatchCodeThreshold,(REAL)R._prefixLongitude, 0);	
		SELF.InGeoMatchCode := R._prefixGeoMatchCode;	
		SELF := L;
	END;

	LOCAL dOut := JOIN(dInClean, dCleaned,
		LEFT._seq = RIGHT._seq,
		appendLatitudeLongitude(LEFT, RIGHT),
		LIMIT(0), KEEP(1), LEFT OUTER);
  RETURN dOut;

ENDMACRO;