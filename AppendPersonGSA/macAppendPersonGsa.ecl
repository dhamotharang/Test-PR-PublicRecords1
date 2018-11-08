EXPORT macAppendPersonGsa(dIn, inLexid,
  appendPrefix = '\'\'', UseIndexThreshold=20000000) := FUNCTIONMACRO
  IMPORT GSA, hipie_ecl;
  
  LOCAL rSearch := {RECORDOF(dIn) OR {INTEGER _searchDid}};
  LOCAL dSearch := PROJECT(dIn, TRANSFORM(rSearch,
    SELF._searchDid := (INTEGER)LEFT.inLexid,
    SELF := LEFT));
  LOCAL dDistributed  := DISTRIBUTE(dSearch((UNSIGNED)inLexid <> 0), HASH32(inLexid));
  LOCAL dupLexid      := DEDUP(SORT(dDistributed, inLexid, LOCAL), inLexid, LOCAL);
  
  LOCAL dPersonGsa := hipie_ecl.macJoinKey(dupLexid, GSA.Key_GSA_DID,
    'KEYED((UNSIGNED)LEFT._searchDid=RIGHT.did)',
    'LEFT.did = (UNSIGNED)RIGHT._searchDid',
    UseIndexThreshold,,TRUE,1,,,,TRUE);
  LOCAL rOut := RECORD
    RECORDOF(dIn);
    INTEGER #EXPAND(appendPrefix + 'hasGsa'):= 0;
    STRING #EXPAND(appendPrefix + 'Name'); //100%
    STRING #EXPAND(appendPrefix + 'Classification');//100%         
    STRING #EXPAND(appendPrefix + 'CTType');  //100% 				 
    STRING #EXPAND(appendPrefix + 'Description');		//85%
    STRING #EXPAND(appendPrefix + 'ActionDate');				//99% 
    STRING #EXPAND(appendPrefix + 'TermDate');//10%
    STRING #EXPAND(appendPrefix + 'TermDateIndefinite');//90%
    STRING #EXPAND(appendPrefix + 'CTCode');		//68%			 
    STRING #EXPAND(appendPrefix + 'AgencyComponent');			 //99%
  END;
  
  LOCAL dOut := JOIN(dDistributed, dPersonGsa,
    (UNSIGNED)LEFT.inLexid = (UNSIGNED)RIGHT.inLexid,
    TRANSFORM(rOut,
      SELF := LEFT,
      SELF.#EXPAND(appendPrefix + 'Name') := RIGHT.name,
      SELF.#EXPAND(appendPrefix + 'Classification') := RIGHT.Classification,
      SELF.#EXPAND(appendPrefix + 'CTType') := RIGHT.CTType,
      SELF.#EXPAND(appendPrefix + 'Description') := RIGHT.Description,
      SELF.#EXPAND(appendPrefix + 'ActionDate') := RIGHT.ActionDate,
      SELF.#EXPAND(appendPrefix + 'TermDate') := RIGHT.TermDate,
      SELF.#EXPAND(appendPrefix + 'TermDateIndefinite') := RIGHT.TermDateIndefinite,
      SELF.#EXPAND(appendPrefix + 'CTCode') := RIGHT.CTCode,
      SELF.#EXPAND(appendPrefix + 'AgencyComponent') := RIGHT.AgencyComponent,
      SELF.#EXPAND(appendPrefix + 'hasGsa') := (INTEGER)((UNSIGNED)RIGHT.inLexid <> 0)),
    LEFT OUTER)
    + PROJECT(dIn((UNSIGNED)inLexid = 0), TRANSFORM(rOut,
        SELF := LEFT, SELF := []));
  RETURN dOut;
ENDMACRO;