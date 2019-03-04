EXPORT macComputeBusinessIntraGeoradiusAssociations(dIn, inGeohash, inRadiusBox, inRadiusBoxSmall, inBuildingAddress, inAddress,
  inUltID, inProxID, inProxEntityContextUID, inRecID, inBusinessName, inBusinessPhone,
  appendPrefix = '\'\'', inLegalName = '', inDbaName = '', inMailingAddress = '', inAppendFields = '',
  inThresholdDistance = 0.5, inMaxBusinessAtLocation = 50, inEditDistanceThreshold = 2,
  maxGeoBoxCount = 200, leftSideGeohashMax = 4, rightSideGeohashMax = 10) := FUNCTIONMACRO
  IMPORT #EXPAND(HIPIE.HIPIEConfig.SaltVersion) as SALT;
  IMPORT SALT38, ComputeBusinessIntraGeoradiusAssociations;

  // Get Global Counts per physical address geohash
  LOCAL tGeohash := TABLE(dIn, {inGeohash, geohashCount := COUNT(GROUP)}, inGeohash, MERGE);
  LOCAL dGeohash := JOIN(dIn, tGeohash, LEFT.inGeohash=RIGHT.inGeohash, LOOKUP, HASH);

  // Get Global Counts per geohash box
  LOCAL tGeohashBox := TABLE(dIn, {geohashBox := inGeohash[1..6], geohashBoxCount := COUNT(GROUP)}, inGeohash[1..6], MERGE);
  LOCAL dGeohashBox := JOIN(dGeohash, tGeohashBox, LEFT.inGeohash[1..6]=RIGHT.geohashBox, LOOKUP, HASH);

  // Calculate high frequency addresses 
  LOCAL tAddresses := TABLE(dGeohashBox, {inBuildingAddress, addressBusinessesCount := COUNT(GROUP)}, inBuildingAddress, MERGE);
  LOCAL dFinalGeoHash := JOIN(dGeohashBox, tAddresses(addressBusinessesCount>inMaxBusinessAtLocation), LEFT.inBuildingAddress=RIGHT.inBuildingAddress, LOOKUP, LEFT ONLY);

  LOCAL rIntermediateGeoHash := RECORD
    RECORDOF(dFinalGeoHash);
    STRING AssociatedGeoBlock;  
  END;

  // Producing an intermediate level dataset with one row per input\geobox combination to avoid doing a top level, geohash[1..4] distribution, 
  // which will produce too large a skew due to densely populated geohashes.
  LOCAL dFinalGeoHashNorm := NORMALIZE(dFinalGeoHash, COUNT(LEFT.inRadiusBox), 
    TRANSFORM(rIntermediateGeoHash,
      SELF.AssociatedGeoBlock := LEFT.inRadiusBox[COUNTER];
      SELF := LEFT));
  
  LOCAL appendedFieldsRecord := ComputeBusinessIntraGeoradiusAssociations.macComputeAppendFieldsRecord(inAppendFields, appendPrefix);
  LOCAL appendFieldsTransform := ComputeBusinessIntraGeoradiusAssociations.macComputeAppendFieldsTransform(inAppendFields, appendPrefix);

  // Limit it to addresses with a limited number of businesses at the address to avoid paycorp explosion.
  // Using the optional Small geobox for locations within densely populated areas so that we only measure a smaller radius in those locations. 
  // In the future it will be useful to implement this as a scaled radius but it would be overkill right now for this.
  LOCAL dOut := JOIN(DISTRIBUTE(dFinalGeoHash(geohashCount<leftSideGeohashMax AND (INTEGER)inProxID != 0), HASH32(inGeohash[1..6])), 
    DISTRIBUTE(dFinalGeoHashNorm(geohashCount<rightSideGeohashMax), HASH32(AssociatedGeoBlock)), 
      LEFT.inGeohash[1..6]=RIGHT.AssociatedGeoBlock AND 
      ((LEFT.geohashBoxCount < maxGeoBoxCount AND RIGHT.inGeohash[1..6] IN LEFT.inRadiusBox) 
       OR (LEFT.geohashBoxCount >= maxGeoBoxCount AND RIGHT.inGeohash[1..8] IN LEFT.inRadiusBoxSmall)), 
      TRANSFORM({RECORDOF(dIn),
          #IF(inAppendFields != '') #EXPAND(appendedFieldsRecord) #END
          STRING #EXPAND(appendPrefix + 'ProxEntityLocation'),
          REAL #EXPAND(appendPrefix + 'GeoDistance'),
          INTEGER #EXPAND(appendPrefix + 'EditDistanceMatch'),
          INTEGER #EXPAND(appendPrefix + 'ExactCompanyNameMatch'),
          INTEGER #EXPAND(appendPrefix + 'PhoneNumberMatch'),
          #IF(#TEXT(inMailingAddress)!='') INTEGER #EXPAND(appendPrefix + 'DifferentLocationMailingAddressMatch'), #END
          INTEGER #EXPAND(appendPrefix + 'MatchingUlt'),
          STRING #EXPAND(appendPrefix + 'PinColor')},
        #IF(inAppendFields != '') #EXPAND(appendFieldsTransform); #END
        SELF.#EXPAND(appendPrefix + 'GeoDistance') := (REAL) SALT.MOD_LL.DistanceE(LEFT.inGeohash, RIGHT.inGeohash);
        #IF(#TEXT(inMailingAddress)!= '')
          SELF.#EXPAND(appendPrefix + 'DifferentLocationMailingAddressMatch') := (INTEGER)
                     (LEFT.inRecID != RIGHT.inRecID AND LEFT.inGeohash != RIGHT.inGeohash AND 
                      (
                      ( LEFT.inMailingAddress != '' AND RIGHT.inAddress != '' AND 
                        LEFT.inMailingAddress = RIGHT.inAddress) 
                      OR 
                        ( LEFT.inMailingAddress != '' AND RIGHT.inAddress != '' AND 
                          LEFT.inMailingAddress = RIGHT.inAddress)
                      ));
        #END
        SELF.#EXPAND(appendPrefix + 'PhoneNumberMatch') := (INTEGER)(LEFT.inRecID != RIGHT.inRecID AND LEFT.inBusinessPhone != '' AND LEFT.inBusinessPhone = RIGHT.inBusinessPhone); 

        // Consider stripping INC LLC CORP etc.. from the names and then doing the compare. If there is already a clean business name function somewhere use that.
        // or
        // string Clean_alt_legal_name := Std.StRIGHT.FindReplace(RIGHT.alt_legal_name, 'INC', ''); 
        SELF.#EXPAND(appendPrefix + 'ExactCompanyNameMatch') :=  (INTEGER)(LEFT.inRecID != RIGHT.inRecID AND (
          #IF(#TEXT(inLegalName) != '')
            (LEFT.inLegalName != '' AND TRIM(LEFT.inLegalName)=TRIM(RIGHT.inLegalName)) OR 
            (LEFT.inLegalName != '' AND TRIM(LEFT.inLegalName)=TRIM(RIGHT.inBusinessName)) OR 
            (LEFT.inBusinessName != '' AND TRIM(LEFT.inBusinessName)=TRIM(RIGHT.inLegalName)) OR 
          #END
          #IF(#TEXT(inDbaName) != '')
            (LEFT.inDbaName != '' AND TRIM(LEFT.inDbaName)=TRIM(RIGHT.inDbaName)) OR 
            (LEFT.inDbaName != '' AND TRIM(LEFT.inDbaName)=TRIM(RIGHT.inBusinessName)) OR 
            (LEFT.inBusinessName != '' AND TRIM(LEFT.inBusinessName)=TRIM(RIGHT.inDbaName)) OR 
          #END
          #IF(#TEXT(inDbaName) != '' AND #TEXT(inLegalName) != '')
            (LEFT.inDbaName != '' AND TRIM(LEFT.inDbaName)=TRIM(RIGHT.inLegalName)) OR
            (LEFT.inLegalName != '' AND TRIM(LEFT.inLegalName)=TRIM(RIGHT.inDbaName)) OR
          #END
          (LEFT.inBusinessName != '' AND TRIM(LEFT.inBusinessName)=TRIM(RIGHT.inBusinessName))));  

        SELF.#EXPAND(appendPrefix + 'EditDistanceMatch') := (INTEGER)(NOT (BOOLEAN)SELF.#EXPAND(appendPrefix + 'ExactCompanyNameMatch') AND LEFT.inRecID != RIGHT.inRecID AND (
          #IF(#TEXT(inLegalName) != '')
            (LEFT.inLegalName != '' AND SALT38.utWithinEditN(LEFT.inLegalName,RIGHT.inLegalName,inEditDistanceThreshold)) OR 
            (LEFT.inLegalName != '' AND SALT38.utWithinEditN(LEFT.inLegalName,RIGHT.inBusinessName,inEditDistanceThreshold)) OR 
            (LEFT.inBusinessName != '' AND SALT38.utWithinEditN(LEFT.inBusinessName,RIGHT.inLegalName,inEditDistanceThreshold)) OR
          #END
          #IF(#TEXT(inDbaName) != '')
            (LEFT.inDbaName != '' AND SALT38.utWithinEditN(LEFT.inDbaName,RIGHT.inDbaName,inEditDistanceThreshold)) OR 
            (LEFT.inDbaName != '' AND SALT38.utWithinEditN(LEFT.inDbaName,RIGHT.inBusinessName,inEditDistanceThreshold)) OR 
            (LEFT.inBusinessName != '' AND SALT38.utWithinEditN(LEFT.inBusinessName,RIGHT.inDbaName,inEditDistanceThreshold)) OR 
          #END
          #IF(#TEXT(inDbaName) != '' AND #TEXT(inLegalName) != '') 
            (LEFT.inLegalName != '' AND SALT38.utWithinEditN(LEFT.inLegalName,RIGHT.inDbaName,inEditDistanceThreshold)) OR 
            (LEFT.inDbaName != '' AND SALT38.utWithinEditN(LEFT.inDbaName,RIGHT.inLegalName,inEditDistanceThreshold)) OR 
          #END
          (LEFT.inBusinessName != '' AND SALT38.utWithinEditN(LEFT.inBusinessName,RIGHT.inBusinessName,inEditDistanceThreshold))));  
          
        SELF.#EXPAND(appendPrefix + 'MatchingUlt') := (INTEGER)(LEFT.inUltID=RIGHT.inUltID);
        SELF.#EXPAND(appendPrefix + 'PinColor') := IF(LEFT.inProxEntityContextUID=RIGHT.inProxEntityContextUID, 'orange',
          IF(#IF(#TEXT(inMailingAddress) != '')(BOOLEAN) SELF.#EXPAND(appendPrefix + 'DifferentLocationMailingAddressMatch') OR #END 
            (BOOLEAN) SELF.#EXPAND(appendPrefix + 'PhoneNumberMatch') OR 
            (BOOLEAN) SELF.#EXPAND(appendPrefix + 'ExactCompanyNameMatch') OR 
            (BOOLEAN) SELF.#EXPAND(appendPrefix + 'EditDistanceMatch'), 'red', 
          IF(RIGHT.inProxID=0, 'grey',
          'green')));
        SELF.#EXPAND(appendPrefix + 'ProxEntityLocation') := LEFT.inProxEntityContextUID + ' ' +LEFT.inGeohash;                    
        SELF := LEFT),
      LOCAL);
    
  RETURN DISTRIBUTE(dOut((REAL)#EXPAND(appendPrefix + 'GeoDistance') <= inThresholdDistance));
ENDMACRO;