IMPORT AutoStandardI;
EXPORT macAppendAdditionalBusinessEntities (
	InData, InUltid, InSeleId, InProxid, InCompanyName,
	Inprimaryrange, Inpredirectional,Inprimaryname, Inaddresssuffix, Inpostdirectional, 
	Inunitdesignation, Insecondaryrange, Inpostalcity, Invanitycity, Instate, Inzip, Inzip4, 
	Inlatitude, Inlongitude, Incounty, JurisdictionState,
	UseIndexThreshold=5000000, appendPrefix = '\'\'', InFullAddress = '',
  _DataRestrictionMask = AutoStandardI.Constants.DataRestrictionMask_default, _GLBPurpose = AutoStandardI.Constants.GLBPurpose_default, _DPPAPurpose = '0',
  returnInactive = false, addUltBusiness = false) := FUNCTIONMACRO
  
IMPORT AppendCleanAddress, BIPV2, BipV2_Best, Business, hipie_ecl;
  LOCAL _bipModule := MODULE
    EXPORT STRING DataRestrictionMask := (STRING)_DataRestrictionMask;
		EXPORT UNSIGNED1 DPPAPurpose      := (UNSIGNED)_DPPAPurpose;
		EXPORT UNSIGNED1 GLBPurpose       := (UNSIGNED)_GLBPurpose;
    EXPORT BOOLEAN ignoreFares        := FALSE;
    EXPORT BOOLEAN ignoreFidelity     := FALSE;
    EXPORT BOOLEAN AllowAll           := FALSE;
    EXPORT BOOLEAN AllowGLB           := FALSE;
    EXPORT BOOLEAN AllowDPPA          := FALSE;
    EXPORT BOOLEAN IncludeMinors      := FALSE;
    EXPORT BOOLEAN lnbranded 					:= FALSE; 
  END;
  LOCAL bipModule := MODULE(PROJECT(_bipModule,BIPV2.mod_sources.iParams,OPT)) END;
  
  LOCAL JurisdictionStateSet := [JurisdictionState];
  LOCAL addAllBusiness := (BOOLEAN)addUltBusiness AND COUNT(JurisdictionStateSet)=1;

  LOCAL ExpandedBipRec := RECORD
    RECORDOF(InData);
    INTEGER1 #EXPAND(appendPrefix + 'IsUltInput') := 1;
    INTEGER1 #EXPAND(appendPrefix + 'IsSeleInput') := 1;
    INTEGER1 #EXPAND(appendPrefix + 'IsProxInput') := 1;  
    #IF((BOOLEAN)addUltBusiness) INTEGER1 #EXPAND(appendPrefix + 'IsNewBusinessHierarchy') := 0; #END
  END;
	
  LOCAL _InData := PROJECT(InData, TRANSFORM(ExpandedBipRec,    
    SELF.#EXPAND(appendPrefix + 'IsUltInput')  := IF((UNSIGNED)LEFT.InProxId = (UNSIGNED)LEFT.InUltId, 1, 0),
    SELF.#EXPAND(appendPrefix + 'IsSeleInput') := IF((UNSIGNED)LEFT.InProxId = (UNSIGNED)LEFT.InSeleId, 1, 0),
    SELF.#EXPAND(appendPrefix + 'IsProxInput') := 1,
    SELF := LEFT));
  LOCAL dDistributed  := DISTRIBUTE(_InData((UNSIGNED)InUltId <> 0), HASH32(InUltId));
  LOCAL dupData    := DEDUP(SORT(dDistributed, InUltId, InSeleId, InProxId, LOCAL), InUltId, InSeleId, InProxId, LOCAL);
	
  LOCAL ExpandedProxFromUlt := hipie_ecl.macJoinKey(dupData, BipV2_Best.Key_LinkIds.key,
    'KEYED((INTEGER)LEFT.' + #TEXT(inUltID) + ' = (INTEGER)RIGHT.UltId) AND WILD(RIGHT.OrgId) AND KEYED((INTEGER)RIGHT.SELEID != 0 AND (INTEGER)RIGHT.PROXID != 0)', 
    '(INTEGER)LEFT.UltId=(INTEGER)RIGHT.' + #TEXT(inUltID) + ' AND (INTEGER)LEFT.SELEID != 0 AND (INTEGER)LEFT.PROXID != 0', 
    UseIndexThreshold,,,,true,2000);
  LOCAL dExpandedProxFromUlt:= JOIN(_InData, ExpandedProxFromUlt, 
		(INTEGER)LEFT.InUltID = (INTEGER)RIGHT.UltId AND 
		(INTEGER)LEFT.InProxId = (INTEGER)RIGHT.ProxId,
    TRANSFORM({RECORDOF(RIGHT)},
      SELF.#EXPAND(appendPrefix + 'IsUltInput')   := RIGHT.#EXPAND(appendPrefix + 'IsUltInput'),
			SELF.#EXPAND(appendPrefix + 'IsSeleInput')  := RIGHT.#EXPAND(appendPrefix + 'IsSeleInput'),
			SELF.#EXPAND(appendPrefix + 'IsProxInput')  := 0,
      SELF := RIGHT), //LEFT side is always empty for RIGHT ONLY join
		RIGHT ONLY, 
		HASH)(isActive OR (BOOLEAN) returnInactive);
  LOCAL dExpandedAllUlt := JOIN(PULL(BipV2_Best.Key_LinkIds.key), dupData, 
    (INTEGER)LEFT.UltId=(INTEGER)RIGHT.inUltId,
    TRANSFORM(RECORDOF(ExpandedProxFromUlt),
      SELF := LEFT,
      SELF.#EXPAND(appendPrefix + 'IsUltInput')   := 0,
			SELF.#EXPAND(appendPrefix + 'IsSeleInput')  := 0,
			SELF.#EXPAND(appendPrefix + 'IsProxInput')  := 0,
      #IF((BOOLEAN)addUltBusiness) SELF.#EXPAND(appendPrefix + 'IsNewBusinessHierarchy') := 1, #END
			SELF := []),//RIGHT side is always empty for LEFT ONLY join 
    SMART,
    LEFT ONLY)(isActive AND SeleId != 0 AND ProxId != 0 AND Company_Address[1].Company_St = JurisdictionStateSet[1]); //For now only return Active Businesses with the Uber option
  
  LOCAL dExpanded       := dExpandedProxFromUlt + IF((BOOLEAN)addAllBusiness, dExpandedAllUlt);
  LOCAL dExpandedFilter := Business.macApplyBusinessRestrictions(dExpanded,bipModule);	
	
  //Only keep records within the state(s) jurisdiction
  LOCAL _dExpandedFinal  := PROJECT(dExpandedFilter(Company_Address[1].Company_St IN JurisdictionStateSet AND (Company_Address[1].company_prim_range <> '' OR Company_Address[1].company_prim_name <> '')),
    TRANSFORM(ExpandedBipRec, 
      SELF.InUltId := (TYPEOF(LEFT.InUltID))LEFT.UltID,
			SELF.InSeleId := (TYPEOF(LEFT.InSeleID))LEFT.SeleId,
			SELF.InProxId := (TYPEOF(LEFT.InProxID))LEFT.Proxid,
			SELF.InCompanyName := REGEXREPLACE('[^[:print:]]',LEFT.Company_Name[1].Company_name, ''), 
			SELF.Inprimaryrange := LEFT.Company_Address[1].company_prim_range,
			SELF.Inpredirectional := LEFT.Company_Address[1].company_predir,
			SELF.Inprimaryname := LEFT.Company_Address[1].company_prim_name,
			SELF.Inaddresssuffix := LEFT.Company_Address[1].company_addr_suffix,
			SELF.Inpostdirectional := LEFT.Company_Address[1].company_postdir,
			SELF.Inunitdesignation := LEFT.Company_Address[1].company_unit_desig,
			SELF.Insecondaryrange := LEFT.Company_Address[1].company_sec_range,
			SELF.Inpostalcity := LEFT.Company_Address[1].company_p_city_name,
			SELF.Invanitycity := LEFT.Company_Address[1].address_v_city_name,
			SELF.Instate := LEFT.Company_Address[1].company_st,
			SELF.Inzip := LEFT.Company_Address[1].company_zip5,
			SELF.Inzip4 := LEFT.Company_Address[1].company_zip4,
			//  SELF.Inlatitude := LEFT.Company_Address[1].company_latitude,
			//  SELF.Inlongitude := LEFT.Company_Address[1].company_longitude,
			SELF.Incounty := hipie_ecl.Counties.CountyStCountyNameDCT[LEFT.Company_Address[1].company_st,LEFT.Company_Address[1].county_name].fips,                        
			SELF.#EXPAND(appendPrefix + 'IsUltInput')   := LEFT.#EXPAND(appendPrefix + 'IsUltInput'),
			SELF.#EXPAND(appendPrefix + 'IsSeleInput')  := LEFT.#EXPAND(appendPrefix + 'IsSeleInput'),
			SELF.#EXPAND(appendPrefix + 'IsProxInput')  := LEFT.#EXPAND(appendPrefix + 'IsProxInput'),
      #IF((BOOLEAN)addUltBusiness) SELF.#EXPAND(appendPrefix + 'IsNewBusinessHierarchy') := LEFT.#EXPAND(appendPrefix + 'IsNewBusinessHierarchy'), #END
      #IF(#TEXT(InFullAddress) != '')
        SELF.InFullAddress := TRIM(' ' + TRIM(SELF.InPrimaryRange)) + TRIM(' ' + TRIM(SELF.Inpredirectional)) + TRIM(' ' + TRIM(SELF.Inprimaryname)) + TRIM(' ' + TRIM(SELF.Inaddresssuffix)) +TRIM(' ' + TRIM(SELF.Inpostdirectional)) + 
                IF(SELF.InUnitDesignation <> '' OR SELF.InSecondaryRange <> '', TRIM(' ' + TRIM(SELF.Inunitdesignation)) + TRIM(' ' + TRIM(SELF.Insecondaryrange)), '') + 
                IF(SELF.InVanityCity <> '', TRIM('<BR/>' + TRIM(SELF.Invanitycity)), '') + IF(SELF.InState <> '', TRIM(', ' + TRIM(SELF.Instate)), '') + IF(SELF.InZip <> '', TRIM(' ' + TRIM(SELF.Inzip)), '') + IF(SELF.InZip4 <> '', TRIM('-' + TRIM(SELF.InZip4)), ''),
      #END
			SELF := []));
 
  //Currently the BIP key does not have a latitude or longitude so we need to get it from the address cleaner
  //Once the BIP key returns the lat and long we will need to go back and remove this extra code and get the lat
  //and long directly from the BIP key
  LOCAL dExpandedFinal  := DISTRIBUTE(_dExpandedFinal, HASH32(InUltId, InSeleID));
  LOCAL DupNewBusiness := DEDUP(SORT(dExpandedFinal, InUltID, InSeleID, InProxID #IF((BOOLEAN)addUltBusiness) ,-#EXPAND(appendPrefix + 'IsNewBusinessHierarchy') #END , LOCAL),
    InUltID, InSeleID, InProxID, LOCAL);
  LOCAL NewBusinessEntitiesWithLatLong := AppendCleanAddress.macAppendAddressLatitudeLongitude(DupNewBusiness,InPrimaryRange,InPreDirectional,InPrimaryName,InAddressSuffix,InPostDirectional,
		InUnitDesignation,InSecondaryRange,Invanitycity,InState,InZip,CleanAddrLatitude,CleanAddrLongitude,CleanAddrGeoMatchCode, 0);
  
  LOCAL NewBusinessEntities := PROJECT(NewBusinessEntitiesWithLatLong, 
    TRANSFORM(ExpandedBipRec,
      SELF.InLatitude   := (TYPEOF(SELF.InLatitude))LEFT.CleanAddrLatitude,
      SELF.InLongitude  := (TYPEOF(SELF.InLongitude))LEFT.CleanAddrLongitude,
      SELF := LEFT));
      
  RETURN _InData + NewBusinessEntities;
ENDMACRO;
