EXPORT macAppendBusinessGsa(dIn, InUltID, InOrgId, InSeleId, InProxId,
  appendPrefix = '\'\'', UseIndexThreshold=20000000) := FUNCTIONMACRO
  IMPORT AppendBusinessGSA, ecl;
  
  LOCAL dDistributed    := DISTRIBUTE(dIn((UNSIGNED)InUltId <> 0), HASH32(InUltId, InSeleId));
  LOCAL rSearch := {RECORDOF(dIn) OR {INTEGER _searchUlt,INTEGER _searchOrg,INTEGER _searchSele,INTEGER _searchProx}};
  LOCAL dSearch := PROJECT(dDistributed, TRANSFORM(rSearch,
    SELF._searchUlt   := (INTEGER)LEFT.InUltId,
    SELF._searchOrg   := (INTEGER)LEFT.InOrgId,
    SELF._searchSele  := (INTEGER)LEFT.InSeleId,
    SELF._searchProx  := (INTEGER)LEFT.InProxId,
    SELF := LEFT));
  LOCAL dDeduped        := DEDUP(SORT(dSearch, InUltId, InSeleId, InProxId, LOCAL), InUltId, InSeleId, InProxId, LOCAL);
  
  LOCAL dBipGsaProx := ecl.macJoinKey(dDeduped, AppendBusinessGSA.Keys.GsaBusinessKey,
    'KEYED(LEFT._searchUlt = RIGHT.UltId) AND	WILD(RIGHT.OrgId) AND	KEYED(LEFT._searchSele = RIGHT.SeleId AND LEFT._searchProx = RIGHT.ProxId)', 
    'LEFT.UltID = RIGHT._searchUlt AND LEFT.SeleId = RIGHT._searchSele AND LEFT.ProxId = RIGHT._searchProx',
    UseIndexThreshold,,true,25000); 
  LOCAL dGsaProxDup := DEDUP(SORT(DISTRIBUTE(dBipGsaProx, HASH32(InUltId, InSeleId)), InUltId, InSeleId, InProxId, LOCAL), InUltId, InSeleId, InProxId, LOCAL);
  
  LOCAL dGsaNotFound := JOIN(dSearch, dGsaProxDup, 
    (UNSIGNED)LEFT.InUltID = (UNSIGNED)RIGHT.InUltID AND 
    (UNSIGNED)LEFT.InSeleID = (UNSIGNED)RIGHT.InSeleID AND 
    (UNSIGNED)LEFT.InProxId = (UNSIGNED)RIGHT.InProxid,
    TRANSFORM({RECORDOF(LEFT)},
      SELF := LEFT), 
    LEFT ONLY, 
    HASH);
  LOCAL dSeleDeduped        := DEDUP(SORT(DISTRIBUTE(dGsaNotFound, HASH32(InUltId, InSeleId)), InUltId, InSeleId, LOCAL), InUltId, InSeleId, LOCAL);  
  LOCAL dBipGsaSele := ecl.macJoinKey(dSeleDeduped, AppendBusinessGSA.Keys.GsaBusinessKey, 
    'KEYED(LEFT._searchUlt = RIGHT.UltId) AND	WILD(RIGHT.OrgId) AND	KEYED(LEFT._searchSele = RIGHT.SeleId)', 
    'LEFT.UltID = RIGHT._searchUlt AND LEFT.SeleId = RIGHT._searchSele', 
    UseIndexThreshold,,true,25000); 
  LOCAL dGsaSeleDup := DEDUP(SORT(DISTRIBUTE(dBipGsaSele, HASH32(InUltId, InSeleId)), InUltId, InSeleId, LOCAL), InUltId, InSeleId, LOCAL);
    
  LOCAL rOut := RECORD
    RECORDOF(dIn);
    INTEGER  #EXPAND(appendPrefix + 'HasGsa') := 0;    
    STRING #EXPAND(appendPrefix + 'Classification');//100%
    STRING #EXPAND(appendPrefix + 'CTType');		//100%					 				 
    STRING #EXPAND(appendPrefix + 'Description');		//36%
    STRING #EXPAND(appendPrefix + 'ActionDate');		//99%		 
    STRING #EXPAND(appendPrefix + 'TermDate');//32%
    STRING #EXPAND(appendPrefix + 'TermDateIndefinite');//71%
    STRING #EXPAND(appendPrefix + 'CTCode');	//67%	
    STRING #EXPAND(appendPrefix + 'Agencycomponent');//99%
    STRING #EXPAND(appendPrefix + 'ExclusionType');//100%
    STRING #EXPAND(appendPrefix + 'SamNumber');//100%
    STRING #EXPAND(appendPrefix + 'BipLevel');
  END;
  
  LOCAL dGsaProxOut := JOIN(dDistributed,dGsaProxDup,
    (UNSIGNED)LEFT.InUltId = (UNSIGNED)RIGHT.InUltId
    AND (UNSIGNED)LEFT.InSeleId = (UNSIGNED)RIGHT.InSeleId
    AND (UNSIGNED)LEFT.InProxId = (UNSIGNED)RIGHT.InProxId,
    TRANSFORM(rOut,
      SELF.#EXPAND(appendPrefix + 'Classification') := RIGHT.Classification;
      SELF.#EXPAND(appendPrefix + 'CTType') := RIGHT.CTType;							 				 
      SELF.#EXPAND(appendPrefix + 'Description') := RIGHT.Description;		
      SELF.#EXPAND(appendPrefix + 'ActionDate') := RIGHT.ActionDate;				 
      SELF.#EXPAND(appendPrefix + 'TermDate') := RIGHT.TermDate;
      SELF.#EXPAND(appendPrefix + 'TermDateIndefinite') := RIGHT.TermDateIndefinite;
      SELF.#EXPAND(appendPrefix + 'CTCode') := RIGHT.CTCode;		
      SELF.#EXPAND(appendPrefix + 'Agencycomponent') := RIGHT.Agencycomponent;
      SELF.#EXPAND(appendPrefix + 'ExclusionType') := RIGHT.ExclusionType;
      SELF.#EXPAND(appendPrefix + 'SamNumber') := RIGHT.SAM_number;
      SELF.#EXPAND(appendPrefix + 'BipLevel') := 'Prox';
      SELF.#EXPAND(appendPrefix + 'HasGsa') := 1,
      SELF := LEFT),
    LIMIT(0),KEEP(100),LOCAL);

  //Get the Sele hits for the records that were not already found by Prox  
  LOCAL dGsaProxNotFound := DISTRIBUTE(JOIN(dDistributed, dGsaProxOut,
		(UNSIGNED)LEFT.InUltID = (UNSIGNED)RIGHT.InUltID AND 
		(UNSIGNED)LEFT.InSeleID = (UNSIGNED)RIGHT.InSeleID AND 
		(UNSIGNED)LEFT.InProxId = (UNSIGNED)RIGHT.InProxid,
    TRANSFORM({RECORDOF(LEFT)},
      SELF := LEFT), 
		LEFT ONLY, 
		HASH), HASH32(InUltId, InSeleId));  
  LOCAL dGsaSeleOut := JOIN(dGsaProxNotFound,dGsaSeleDup,
    (UNSIGNED)LEFT.InUltId = (UNSIGNED)RIGHT.InUltId
    AND (UNSIGNED)LEFT.InSeleId = (UNSIGNED)RIGHT.InSeleId,
    TRANSFORM(rOut,      
      SELF.#EXPAND(appendPrefix + 'Classification') := RIGHT.Classification;
      SELF.#EXPAND(appendPrefix + 'CTType') := RIGHT.CTType;							 				 
      SELF.#EXPAND(appendPrefix + 'Description') := RIGHT.Description;		
      SELF.#EXPAND(appendPrefix + 'ActionDate') := RIGHT.ActionDate;				 
      SELF.#EXPAND(appendPrefix + 'TermDate') := RIGHT.TermDate;
      SELF.#EXPAND(appendPrefix + 'TermDateIndefinite') := RIGHT.TermDateIndefinite;
      SELF.#EXPAND(appendPrefix + 'CTCode') := RIGHT.CTCode;		
      SELF.#EXPAND(appendPrefix + 'Agencycomponent') := RIGHT.Agencycomponent;
      SELF.#EXPAND(appendPrefix + 'ExclusionType') := RIGHT.ExclusionType;
      SELF.#EXPAND(appendPrefix + 'SamNumber') := RIGHT.SAM_number;
      SELF.#EXPAND(appendPrefix + 'BipLevel') := 'Sele';
      SELF. #EXPAND(appendPrefix + 'HasGsa') := 1,
      SELF := LEFT),
    LIMIT(0),KEEP(100), LOCAL);
    
  //Combine the Hits
  LOCAL dGsaFinal := dGsaProxOut + dGsaSeleOut;
  
  //Get the no Hit and empty records
  LOCAL dNoHit := JOIN(dDistributed, dGsaFinal,
    (UNSIGNED)LEFT.InUltId = (UNSIGNED)RIGHT.InUltId
    AND (UNSIGNED)LEFT.InSeleId = (UNSIGNED)RIGHT.InSeleId
    AND (UNSIGNED)LEFT.InProxId = (UNSIGNED)RIGHT.InProxId, 
    TRANSFORM(rOut, SELF := LEFT, SELF := []), LEFT ONLY)
    + PROJECT(dIn((UNSIGNED)InUltId = 0), TRANSFORM(rOut,
        SELF := LEFT, SELF := []));
        
  //Combine results
  LOCAL dOut := DISTRIBUTE(dGsaFinal + dNoHit);
  RETURN dOut;
ENDMACRO;
  
