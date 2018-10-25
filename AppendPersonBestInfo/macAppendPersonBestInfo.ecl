EXPORT macAppendPersonBestInfo(dIn, inLexid, inGlb, inDrm,
  inUseNonBlank = 'false', inMarketing = 'false', inIncludeDod = 'false', inIncludeMinors= FALSE,
  appendPrefix = '\'\'', UseIndexThreshold=10000000) := FUNCTIONMACRO
  
  IMPORT Watchdog, doxie_files, doxie, ut, hipie_ecl, Suppress;
   
  LOCAL rSearch := {RECORDOF(dIn) OR {INTEGER _searchDid}};
  LOCAL dSearch := PROJECT(dIn, TRANSFORM(rSearch,
    SELF._searchDid := (INTEGER)LEFT.inLexid,
    SELF := LEFT));
  LOCAL dDistributed  := DISTRIBUTE(dSearch((UNSIGNED)inLexid <> 0), HASH32(inLexid));
  LOCAL dupLexid      := DEDUP(SORT(dDistributed, inLexid, LOCAL), inLexid, LOCAL);
  
  LOCAL dWatchdogNonGlbNonBlankV2 := hipie_ecl.macJoinKey(dupLexid, Watchdog.key_watchdog_nonglb_nonblank_V2,
    'KEYED((UNSIGNED)LEFT._searchDid=RIGHT.did)',
    'LEFT.did = (UNSIGNED)RIGHT._searchDid',
    UseIndexThreshold,,TRUE,1,,,,TRUE);
  LOCAL dWatchdogNonGlbNonBlank := hipie_ecl.macJoinKey(dupLexid, Watchdog.key_watchdog_nonglb_nonblank,
    'KEYED((UNSIGNED)LEFT._searchDid=RIGHT.did)',
    'LEFT.did = (UNSIGNED)RIGHT._searchDid',
    UseIndexThreshold,,TRUE,1,,,,TRUE);
  LOCAL dWatchdogNonGlbV2 := hipie_ecl.macJoinKey(dupLexid, Watchdog.Key_Watchdog_nonglb_V2,
    'KEYED((UNSIGNED)LEFT._searchDid=RIGHT.did)',
    'LEFT.did = (UNSIGNED)RIGHT._searchDid',
    UseIndexThreshold,,TRUE,1,,,,TRUE);
  LOCAL dWatchdogNonGlb := hipie_ecl.macJoinKey(dupLexid, Watchdog.Key_Watchdog_nonglb,
    'KEYED((UNSIGNED)LEFT._searchDid=RIGHT.did)',
    'LEFT.did = (UNSIGNED)RIGHT._searchDid',
    UseIndexThreshold,,TRUE,1,,,,TRUE);
  
  LOCAL dWatchdog := IF((BOOLEAN)inUseNonBlank,
    IF(doxie.DataRestriction.restrictPreGLB, dWatchdogNonGlbNonBlankV2, dWatchdogNonGlbNonBlank),
    IF(doxie.DataRestriction.restrictPreGLB, dWatchdogNonGlbV2, dWatchdogNonGlb));
  
  LOCAL dWatchdogNoMinors := JOIN(dWatchdog, doxie_files.key_minors_hash, 
      LEFT.did != 0 AND KEYED(HASH32((UNSIGNED6)LEFT.did)=RIGHT.hash32_did) 
      AND KEYED(LEFT.did=RIGHT.did) AND ut.Age(RIGHT.dob) < 18,
      TRANSFORM({RECORDOF(LEFT), RECORDOF(RIGHT)}, 
        SELF := RIGHT,
        SELF := LEFT), 
      LEFT ONLY, LOOKUP);
    
  //For now No Minors no matter what
  LOCAL dWatchdogFilter := dWatchdogNoMinors; //IF ((BOOLEAN)inIncludeMinors,dWatchdog,dWatchdogNoMinors);
  Suppress.MAC_Suppress(dWatchdogFilter,LOCAL dWatchdogSuppress,'',Suppress.Constants.LinkTypes.SSN,SSN);
  Suppress.MAC_Suppress(dWatchdogSuppress,LOCAL dWatchdogClean,'',Suppress.Constants.LinkTypes.DID,DID);
  
  LOCAL rOut := RECORD
    RECORDOF(dIn);
    STRING #EXPAND(appendPrefix + 'Title'):= '';
    STRING #EXPAND(appendPrefix + 'FirstName'):= '';
    STRING #EXPAND(appendPrefix + 'MiddleName'):= '';
    STRING #EXPAND(appendPrefix + 'LastName'):= '';
    STRING #EXPAND(appendPrefix + 'NameSuffix'):= '';
    STRING #EXPAND(appendPrefix + 'PrimaryRange'):= '';
    STRING #EXPAND(appendPrefix + 'PreDirectional'):= '';
    STRING #EXPAND(appendPrefix + 'PrimaryName'):= '';
    STRING #EXPAND(appendPrefix + 'AddressSuffix'):= '';
    STRING #EXPAND(appendPrefix + 'PostDirectional'):= '';
    STRING #EXPAND(appendPrefix + 'UnitDesignation'):= '';
    STRING #EXPAND(appendPrefix + 'SecondaryRange'):= '';
    STRING #EXPAND(appendPrefix + 'City'):= '';
    STRING #EXPAND(appendPrefix + 'State'):= '';
    STRING #EXPAND(appendPrefix + 'Zip'):= '';
    STRING #EXPAND(appendPrefix + 'Zip4'):= '';
    STRING #EXPAND(appendPrefix + 'AddressFirstSeen'):= '';
    STRING #EXPAND(appendPrefix + 'AddressLastSeen'):= '';
    //Purposefully not returning SSN, DOB, etc. for now
  END;
  
  LOCAL dWithBestInfo := JOIN(dIn, dWatchdogClean,
    (UNSIGNED)LEFT.inLexid = (UNSIGNED)RIGHT.inLexid,
    TRANSFORM(rOut,
      SELF.#EXPAND(appendPrefix + 'Title') := RIGHT.title,
      SELF.#EXPAND(appendPrefix + 'FirstName') := RIGHT.fname,
      SELF.#EXPAND(appendPrefix + 'MiddleName') := RIGHT.mname,
      SELF.#EXPAND(appendPrefix + 'LastName') := RIGHT.lname,
      SELF.#EXPAND(appendPrefix + 'NameSuffix') := RIGHT.name_suffix,
      SELF.#EXPAND(appendPrefix + 'PrimaryRange') := RIGHT.prim_range,
      SELF.#EXPAND(appendPrefix + 'PreDirectional') := RIGHT.predir,
      SELF.#EXPAND(appendPrefix + 'PrimaryName') := RIGHT.prim_name,
      SELF.#EXPAND(appendPrefix + 'AddressSuffix') := RIGHT.suffix,
      SELF.#EXPAND(appendPrefix + 'PostDirectional') := RIGHT.postdir,
      SELF.#EXPAND(appendPrefix + 'UnitDesignation'):= RIGHT.unit_desig,
      SELF.#EXPAND(appendPrefix + 'SecondaryRange') := RIGHT.sec_range,
      SELF.#EXPAND(appendPrefix + 'City') := RIGHT.city_name,
      SELF.#EXPAND(appendPrefix + 'State') := RIGHT.st,
      SELF.#EXPAND(appendPrefix + 'Zip') := RIGHT.zip,
      SELF.#EXPAND(appendPrefix + 'Zip4') := RIGHT.zip4,
      SELF.#EXPAND(appendPrefix + 'AddressFirstSeen') := (STRING)RIGHT.addr_dt_first_seen,
      SELF.#EXPAND(appendPrefix + 'AddressLastSeen') := (STRING)RIGHT.addr_dt_last_seen,
      SELF := LEFT),
    LEFT OUTER);
  
  LOCAL dOut := IF((STRING) inGlb <> '' AND (STRING)inDrm <> '',
    dWithBestInfo,
    PROJECT(dIn, rOut));
    
  RETURN dOut;
ENDMACRO;
