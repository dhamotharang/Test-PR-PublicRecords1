IMPORT AutoStandardI;
EXPORT macAppendBIPBest(InData, InUltid, InSeleId, InProxid, InPrefix, UseIndexThreshold=10000000,
  _DataRestrictionMask =  AutoStandardI.Constants.DataRestrictionMask_default, _GLBPurpose = AutoStandardI.Constants.GLBPurpose_default, _DPPAPurpose = '0') := FUNCTIONMACRO
IMPORT BipV2_Best,Business,BIPV2,hipie_ecl;
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
  
  LOCAL BIPAppendRec := RECORD
    RECORDOF(InData);
    STRING #EXPAND(InPrefix + 'UltCompanyName');
    STRING9 #EXPAND(InPrefix + 'UltFein');
		STRING10 #EXPAND(InPrefix + 'UltPrimaryRange');
		STRING2 #EXPAND(InPrefix + 'UltPreDirectional');
		STRING28 #EXPAND(InPrefix + 'UltPrimaryName');
		STRING4 #EXPAND(InPrefix + 'UltAddressSuffix');
		STRING2 #EXPAND(InPrefix + 'UltPostDirectional');
		STRING10 #EXPAND(InPrefix + 'UltUnitDesignation');
		STRING8 #EXPAND(InPrefix + 'UltSecondaryRange');
		STRING25 #EXPAND(InPrefix + 'UltPostalCity');
		STRING25 #EXPAND(InPrefix + 'UltVanityCity');
		STRING2 #EXPAND(InPrefix + 'UltState');
		STRING5 #EXPAND(InPrefix + 'UltZip');
		STRING4 #EXPAND(InPrefix + 'UltZip4');
		STRING18 #EXPAND(InPrefix + 'UltCounty');
    STRING10 #EXPAND(InPrefix + 'UltPhone');
    INTEGER4 #EXPAND(InPrefix + 'UltDateFirstSeen');
    INTEGER4 #EXPAND(InPrefix + 'UltDateLastSeen');
    UNSIGNED4 #EXPAND(InPrefix + 'UltIncorporationDate');
		STRING8 #EXPAND(InPrefix + 'UltSIC');
		STRING6 #EXPAND(InPrefix + 'UltNAICS');
    STRING #EXPAND(InPrefix + 'SeleCompanyName'); 
    STRING9 #EXPAND(InPrefix + 'SeleFein');
		STRING10 #EXPAND(InPrefix + 'SelePrimaryRange');
		STRING2 #EXPAND(InPrefix + 'SelePreDirectional');
		STRING28 #EXPAND(InPrefix + 'SelePrimaryName');
		STRING4 #EXPAND(InPrefix + 'SeleAddressSuffix');
		STRING2 #EXPAND(InPrefix + 'SelePostDirectional');
		STRING10 #EXPAND(InPrefix + 'SeleUnitDesignation');
		STRING8 #EXPAND(InPrefix + 'SeleSecondaryRange');
		STRING25 #EXPAND(InPrefix + 'SelePostalCity');
		STRING25 #EXPAND(InPrefix + 'SeleVanityCity');
		STRING2 #EXPAND(InPrefix + 'SeleState');
		STRING5 #EXPAND(InPrefix + 'SeleZip');
		STRING4 #EXPAND(InPrefix + 'SeleZip4');
		STRING18 #EXPAND(InPrefix + 'SeleCounty');
    STRING10 #EXPAND(InPrefix + 'SelePhone');
    INTEGER4 #EXPAND(InPrefix + 'SeleDateFirstSeen');
    INTEGER4 #EXPAND(InPrefix + 'SeleDateLastSeen');
		UNSIGNED4 #EXPAND(InPrefix + 'SeleIncorporationDate');
    STRING8 #EXPAND(InPrefix + 'SeleSIC');
		STRING6 #EXPAND(InPrefix + 'SeleNAICS');
    BOOLEAN #EXPAND(InPrefix + 'SeleIsActive');
    BOOLEAN #EXPAND(InPrefix + 'SeleIsDefunct');
    STRING #EXPAND(InPrefix + 'ProxCompanyName'); 
		STRING9 #EXPAND(InPrefix + 'ProxFein');
    STRING10 #EXPAND(InPrefix + 'ProxPrimaryRange');
		STRING2 #EXPAND(InPrefix + 'ProxPreDirectional');
		STRING28 #EXPAND(InPrefix + 'ProxPrimaryName');
		STRING4 #EXPAND(InPrefix + 'ProxAddressSuffix');
		STRING2 #EXPAND(InPrefix + 'ProxPostDirectional');
		STRING10 #EXPAND(InPrefix + 'ProxUnitDesignation');
		STRING8 #EXPAND(InPrefix + 'ProxSecondaryRange');
		STRING25 #EXPAND(InPrefix + 'ProxPostalCity');
		STRING25 #EXPAND(InPrefix + 'ProxVanityCity');
		STRING2 #EXPAND(InPrefix + 'ProxState');
		STRING5 #EXPAND(InPrefix + 'ProxZip');
		STRING4 #EXPAND(InPrefix + 'ProxZip4');
		STRING18 #EXPAND(InPrefix + 'ProxCounty');
    STRING10 #EXPAND(InPrefix + 'ProxPhone');
    INTEGER4 #EXPAND(InPrefix + 'ProxDateFirstSeen');
    INTEGER4 #EXPAND(InPrefix + 'ProxDateLastSeen');
    UNSIGNED4 #EXPAND(InPrefix + 'ProxIncorporationDate');
    STRING8 #EXPAND(InPrefix + 'ProxSIC');
		STRING6 #EXPAND(InPrefix + 'ProxNAICS');
  END;
	
  LOCAL dDistributed  := DISTRIBUTE(InData((UNSIGNED)InUltId <> 0), HASH32(InUltId));
  LOCAL rSearch := {RECORDOF(InData) OR {INTEGER _searchUlt,INTEGER _searchSele,INTEGER _searchProx}};
  LOCAL dSearch := PROJECT(dDistributed, TRANSFORM(rSearch,
    SELF._searchUlt := (INTEGER)LEFT.InUltId,
    SELF._searchSele := (INTEGER)LEFT.InSeleId,
    SELF._searchProx := (INTEGER)LEFT.InProxId,
    SELF := LEFT));
  LOCAL dupUltData    := DEDUP(SORT(dSearch, InUltId, LOCAL), InUltId, LOCAL);
  LOCAL dupSeleData   := DEDUP(SORT(dSearch, InUltId, InSeleId, LOCAL), InUltId, InSeleId, LOCAL);
  LOCAL dupProxData   := DEDUP(SORT(dSearch, InUltId, InSeleId, InProxId, LOCAL), InUltId, InSeleId, InProxId, LOCAL);
  
  //Ult
  LOCAL BipUlt := hipie_ecl.macJoinKey(dupUltData, BipV2_Best.Key_LinkIds.key,
    'KEYED(LEFT._searchUlt = (INTEGER)RIGHT.ULTID) AND WILD(RIGHT.OrgID) AND KEYED((INTEGER)RIGHT.SELEID = 0 AND (INTEGER)RIGHT.PROXID = 0)', 
    'RIGHT._searchUlt = (INTEGER)LEFT.ULTID AND (INTEGER)LEFT.SELEID = 0 AND (INTEGER)LEFT.PROXID = 0', 
    UseIndexThreshold,,,,,,true,true);
  LOCAL dBipUlt := Business.macApplyBusinessRestrictions(BipUlt,bipModule);		
	//Sele
  LOCAL BipSele := hipie_ecl.macJoinKey(dupSeleData, BipV2_Best.Key_LinkIds.key, 
    'KEYED(LEFT._searchUlt = (INTEGER)RIGHT.ULTID) AND WILD(RIGHT.OrgID) AND KEYED(LEFT._searchSele != 0 AND LEFT._searchSele = (INTEGER)RIGHT.SELEID AND (INTEGER)RIGHT.PROXID = 0)', 
    'RIGHT._searchUlt = (INTEGER)LEFT.ULTID AND RIGHT._searchSele != 0 AND RIGHT._searchSele = (INTEGER)LEFT.SELEID AND (INTEGER)LEFT.PROXID = 0', 
    UseIndexThreshold,,,,,,true,true);
  LOCAL dBipSele := Business.macApplyBusinessRestrictions(BipSele,bipModule);		
  //Prox
  LOCAL BipProx := hipie_ecl.macJoinKey(dupProxData, BipV2_Best.Key_LinkIds.key,
    'KEYED(LEFT._searchUlt = (INTEGER)RIGHT.ULTID) AND  WILD(RIGHT.OrgID) AND KEYED(RIGHT.SELEID != 0 AND LEFT._searchSele = (INTEGER)RIGHT.SeleID AND LEFT._searchProx = (INTEGER)RIGHT.PROXID)',
    'RIGHT._searchUlt = (INTEGER)LEFT.ULTID AND LEFT.SELEID != 0 AND RIGHT._searchSele = (INTEGER)LEFT.SeleID AND RIGHT._searchProx = (INTEGER)LEFT.PROXID', 
    UseIndexThreshold,,,,,,true,true);
  LOCAL dBipProx := Business.macApplyBusinessRestrictions(BipProx,bipModule);		  
  
  LOCAL BipAppendUlt:= JOIN(dDistributed, dBipUlt, 
    (UNSIGNED)LEFT.InUltId = (UNSIGNED)RIGHT.InUltId,
		 TRANSFORM(BIPAppendRec, 
      SELF.#EXPAND(InPrefix + 'UltCompanyName') :=  REGEXREPLACE('[^[:print:]]',RIGHT.Company_Name[1].Company_name, ''); 
      SELF.#EXPAND(InPrefix + 'UltFein') := RIGHT.Company_Fein[1].Company_fein;
			SELF.#EXPAND(InPrefix + 'UltPrimaryRange') := RIGHT.Company_Address[1].company_prim_range;
			SELF.#EXPAND(InPrefix + 'UltPreDirectional') := RIGHT.Company_Address[1].company_predir;
			SELF.#EXPAND(InPrefix + 'UltPrimaryName') := RIGHT.Company_Address[1].company_prim_name;
			SELF.#EXPAND(InPrefix + 'UltAddressSuffix') := RIGHT.Company_Address[1].company_addr_suffix;
			SELF.#EXPAND(InPrefix + 'UltPostDirectional') := RIGHT.Company_Address[1].company_postdir;
			SELF.#EXPAND(InPrefix + 'UltUnitDesignation') := RIGHT.Company_Address[1].company_unit_desig;
			SELF.#EXPAND(InPrefix + 'UltSecondaryRange') := RIGHT.Company_Address[1].company_sec_range;
			SELF.#EXPAND(InPrefix + 'UltPostalCity') := RIGHT.Company_Address[1].company_p_city_name;
			SELF.#EXPAND(InPrefix + 'UltVanityCity') := RIGHT.Company_Address[1].address_v_city_name;
			SELF.#EXPAND(InPrefix + 'UltState') := RIGHT.Company_Address[1].company_st;
			SELF.#EXPAND(InPrefix + 'UltZip') := RIGHT.Company_Address[1].company_zip5;
			SELF.#EXPAND(InPrefix + 'UltZip4') := RIGHT.Company_Address[1].company_zip4;
			SELF.#EXPAND(InPrefix + 'UltCounty') := RIGHT.Company_Address[1].county_name;
      SELF.#EXPAND(InPrefix + 'UltPhone') := RIGHT.Company_Phone[1].company_phone;
			SELF.#EXPAND(InPrefix + 'UltDateFirstSeen') := MIN(RIGHT.Company_Name, dt_first_seen);
			SELF.#EXPAND(InPrefix + 'UltDateLastSeen') := MAX(RIGHT.Company_Name, dt_last_seen);
      SELF.#EXPAND(InPrefix + 'UltIncorporationDate') := MIN(RIGHT.Company_incorporation_date, company_incorporation_date);
			SELF.#EXPAND(InPrefix + 'UltSIC') := RIGHT.sic_code[1].company_sic_code1[1..4];
			SELF.#EXPAND(InPrefix + 'UltNAICS') := RIGHT.naics_code[1].company_naics_code1;
      SELF := LEFT, SELF := []), 
    LEFT OUTER);
      
  LOCAL BipAppendSele := JOIN(BipAppendUlt, dBipSele, 
    (UNSIGNED)LEFT.InUltId = (UNSIGNED)RIGHT.InUltId AND
    (UNSIGNED)LEFT.InSeleId = (UNSIGNED)RIGHT.InSeleId,
		 TRANSFORM(BIPAppendRec,      
			SELF.#EXPAND(InPrefix + 'SeleCompanyName') := REGEXREPLACE('[^[:print:]]',RIGHT.Company_Name[1].Company_name, '');
      SELF.#EXPAND(InPrefix + 'SeleFein') := RIGHT.Company_Fein[1].company_fein;
			SELF.#EXPAND(InPrefix + 'SelePrimaryRange') := RIGHT.Company_Address[1].company_prim_range;
			SELF.#EXPAND(InPrefix + 'SelePreDirectional') := RIGHT.Company_Address[1].company_predir;
			SELF.#EXPAND(InPrefix + 'SelePrimaryName') := RIGHT.Company_Address[1].company_prim_name;
			SELF.#EXPAND(InPrefix + 'SeleAddressSuffix') := RIGHT.Company_Address[1].company_addr_suffix;
			SELF.#EXPAND(InPrefix + 'SelePostDirectional') := RIGHT.Company_Address[1].company_postdir;
			SELF.#EXPAND(InPrefix + 'SeleUnitDesignation') := RIGHT.Company_Address[1].company_unit_desig;
			SELF.#EXPAND(InPrefix + 'SeleSecondaryRange') := RIGHT.Company_Address[1].company_sec_range;
			SELF.#EXPAND(InPrefix + 'SelePostalCity') := RIGHT.Company_Address[1].company_p_city_name;
			SELF.#EXPAND(InPrefix + 'SeleVanityCity') := RIGHT.Company_Address[1].address_v_city_name;
			SELF.#EXPAND(InPrefix + 'SeleState') := RIGHT.Company_Address[1].company_st;
			SELF.#EXPAND(InPrefix + 'SeleZip') := RIGHT.Company_Address[1].company_zip5;
			SELF.#EXPAND(InPrefix + 'SeleZip4') := RIGHT.Company_Address[1].company_zip4;
			SELF.#EXPAND(InPrefix + 'SeleCounty') := RIGHT.Company_Address[1].county_name;		
      SELF.#EXPAND(InPrefix + 'SelePhone') := RIGHT.Company_Phone[1].company_phone;
			SELF.#EXPAND(InPrefix + 'SeleDateFirstSeen') := MIN(RIGHT.Company_Name, dt_first_seen);
			SELF.#EXPAND(InPrefix + 'SeleDateLastSeen') := MAX(RIGHT.Company_Name, dt_last_seen);   
      SELF.#EXPAND(InPrefix + 'SeleIncorporationDate') := MIN(RIGHT.Company_Incorporation_Date, company_incorporation_date);
			SELF.#EXPAND(InPrefix + 'SeleSIC') := RIGHT.sic_code[1].company_sic_code1[1..4];
			SELF.#EXPAND(InPrefix + 'SeleNAICS') := RIGHT.naics_code[1].company_naics_code1;
      SELF.#EXPAND(InPrefix + 'SeleIsActive') := RIGHT.isactive;
      SELF.#EXPAND(InPrefix + 'SeleIsDefunct') := RIGHT.isdefunct;
			SELF := LEFT, SELF := []), 
    LEFT OUTER);

  LOCAL dOut := JOIN(BipAppendSele, dBipProx, 
    (UNSIGNED)LEFT.InUltId = (UNSIGNED)RIGHT.InUltId AND
    (UNSIGNED)LEFT.InSeleId = (UNSIGNED)RIGHT.InSeleId AND
    (UNSIGNED)LEFT.InProxId = (UNSIGNED)RIGHT.InProxId,
		TRANSFORM(BIPAppendRec, 
      SELF.#EXPAND(InPrefix + 'ProxCompanyName') := REGEXREPLACE('[^[:print:]]',RIGHT.Company_Name[1].Company_name, '');
      SELF.#EXPAND(InPrefix + 'ProxFein') := RIGHT.Company_fein[1].company_fein;
			SELF.#EXPAND(InPrefix + 'ProxPrimaryRange') := RIGHT.Company_Address[1].company_prim_range;
			SELF.#EXPAND(InPrefix + 'ProxPreDirectional') := RIGHT.Company_Address[1].company_predir;
			SELF.#EXPAND(InPrefix + 'ProxPrimaryName') := RIGHT.Company_Address[1].company_prim_name;
			SELF.#EXPAND(InPrefix + 'ProxAddressSuffix') := RIGHT.Company_Address[1].company_addr_suffix;
			SELF.#EXPAND(InPrefix + 'ProxPostDirectional') := RIGHT.Company_Address[1].company_postdir;
			SELF.#EXPAND(InPrefix + 'ProxUnitDesignation') := RIGHT.Company_Address[1].company_unit_desig;
			SELF.#EXPAND(InPrefix + 'ProxSecondaryRange') := RIGHT.Company_Address[1].company_sec_range;
			SELF.#EXPAND(InPrefix + 'ProxPostalCity') := RIGHT.Company_Address[1].company_p_city_name;
			SELF.#EXPAND(InPrefix + 'ProxVanityCity') := RIGHT.Company_Address[1].address_v_city_name;
			SELF.#EXPAND(InPrefix + 'ProxState') := RIGHT.Company_Address[1].company_st;
			SELF.#EXPAND(InPrefix + 'ProxZip') := RIGHT.Company_Address[1].company_zip5;
			SELF.#EXPAND(InPrefix + 'ProxZip4') := RIGHT.Company_Address[1].company_zip4;
			SELF.#EXPAND(InPrefix + 'ProxCounty') := RIGHT.Company_Address[1].county_name;	
      SELF.#EXPAND(InPrefix + 'ProxPhone') := RIGHT.Company_Phone[1].company_phone;
			SELF.#EXPAND(InPrefix + 'ProxDateFirstSeen') := MIN(RIGHT.Company_Name, dt_first_seen);
			SELF.#EXPAND(InPrefix + 'ProxDateLastSeen') := MAX(RIGHT.Company_Name, dt_last_seen);
      SELF.#EXPAND(InPrefix + 'ProxIncorporationDate') := MIN(RIGHT.Company_incorporation_date, company_incorporation_date);
			SELF.#EXPAND(InPrefix + 'ProxSIC') := RIGHT.sic_code[1].company_sic_code1[1..4];
			SELF.#EXPAND(InPrefix + 'ProxNAICS') := RIGHT.naics_code[1].company_naics_code1;                             
			SELF := LEFT), 
    LEFT OUTER)
    + PROJECT(InData((UNSIGNED)InUltId = 0), TRANSFORM(BIPAppendRec,
        SELF := LEFT, SELF := []));
  RETURN dOut;                             
ENDMACRO;
