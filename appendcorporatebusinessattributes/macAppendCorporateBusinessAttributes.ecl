EXPORT macAppendCorporateBusinessAttributes(dIn, InUltId, InOrgId, InSeleId, InProxId, InState,
  appendPrefix = '\'\'', UseIndexThreshold=20000000) := FUNCTIONMACRO
  
  IMPORT AppendCorporateBusinessAttributes, ecl;
   
  LOCAL dDistributed    := DISTRIBUTE(dIn((UNSIGNED)InUltId <> 0), HASH32(InUltId));
  LOCAL rSearch := {RECORDOF(dIn) OR {INTEGER _searchUlt,INTEGER _searchOrg,INTEGER _searchSele,INTEGER _searchProx, STRING _searchState}};
  LOCAL dSearch := PROJECT(dDistributed, TRANSFORM(rSearch,
    SELF._searchUlt   := (INTEGER)LEFT.InUltId,
    SELF._searchOrg   := (INTEGER)LEFT.InOrgId,
    SELF._searchSele  := (INTEGER)LEFT.InSeleId,
    SELF._searchProx  := (INTEGER)LEFT.InProxId,
    SELF._searchState  := (STRING)LEFT.InState,
    SELF := LEFT));
  LOCAL dDeduped        := DEDUP(SORT(dSearch, InUltId, InSeleId, InProxId, LOCAL), InUltId, InSeleId, InProxId, LOCAL);
  
  LOCAL dBipCorpProx := ecl.macJoinKey(dDeduped, AppendCorporateBusinessAttributes.Keys.CorpBusinessKey,
    'KEYED((UNSIGNED)LEFT._searchUlt = RIGHT.UltId) AND	WILD(RIGHT.OrgId) AND	KEYED((UNSIGNED)LEFT._searchSele = RIGHT.SeleId AND LEFT._searchProx = RIGHT.ProxId) AND LEFT._searchState = RIGHT.corp_state_origin', 
    'LEFT.UltID = (UNSIGNED)RIGHT._searchUlt AND LEFT.SeleId = (UNSIGNED)RIGHT._searchSele AND LEFT.ProxId = (UNSIGNED)RIGHT._searchProx AND LEFT.corp_state_origin = RIGHT._searchState',
   	UseIndexThreshold,,true,25000); 
  
  //Use the most recent record
  LOCAL dCorpProxDup := DEDUP(SORT(DISTRIBUTE(dBipCorpProx, HASH32(InUltId)), InUltId, InSeleId, InProxId, -corp_process_date, LOCAL), InUltId, InSeleId, InProxId, LOCAL);
  
  LOCAL dCorpNotFound := JOIN(dSearch, dCorpProxDup, 
		(UNSIGNED)LEFT.InUltID = (UNSIGNED)RIGHT.InUltID AND 
		(UNSIGNED)LEFT.InSeleID = (UNSIGNED)RIGHT.InSeleID AND 
		(UNSIGNED)LEFT.InProxId = (UNSIGNED)RIGHT.InProxid,
    TRANSFORM({RECORDOF(LEFT)},
      SELF := LEFT), 
		LEFT ONLY, 
		HASH);
  LOCAL dSeleDeduped        := DEDUP(SORT(DISTRIBUTE(dCorpNotFound, HASH32(InUltId)), InUltId, InSeleId, LOCAL), InUltId, InSeleId, LOCAL);  
  LOCAL dBipCorpSele := ecl.macJoinKey(dSeleDeduped, AppendCorporateBusinessAttributes.Keys.CorpBusinessKey,
    'KEYED((UNSIGNED)LEFT._searchUlt = RIGHT.UltId) AND WILD(RIGHT.OrgId) AND	KEYED((UNSIGNED)LEFT._searchSele = RIGHT.SeleId) AND LEFT._searchState = RIGHT.corp_state_origin', 
    'LEFT.UltID = (UNSIGNED)RIGHT._searchUlt AND LEFT.SeleId = (UNSIGNED)RIGHT._searchSele AND LEFT.corp_state_origin = RIGHT._searchState', 
    UseIndexThreshold,,true,25000); 
      
  //Use the most recent record
  LOCAL dCorpSeleDup := DEDUP(SORT(DISTRIBUTE(dBipCorpSele, HASH32(InUltId)), InUltId, InSeleId, -corp_process_date, LOCAL), InUltId, InSeleId, LOCAL);
    
  LOCAL rOut := RECORD
    RECORDOF(dIn);
    STRING #EXPAND(appendPrefix + 'CorporateKey'); //100%
    STRING #EXPAND(appendPrefix + 'CorporateState'); //100%
    STRING #EXPAND(appendPrefix + 'CorporateProcessDate'); //100%
    STRING #EXPAND(appendPrefix + 'LegalName'); //100%
    STRING #EXPAND(appendPrefix + 'CorporateFilingDescription'); //16%
    STRING #EXPAND(appendPrefix + 'CorporateStatus');//94%
    STRING #EXPAND(appendPrefix + 'CorporateStatusDate');//28%
    STRING #EXPAND(appendPrefix + 'CorporateStatusComment');//18%
    STRING #EXPAND(appendPrefix + 'CorporateIncorporationDate');//78%
    STRING #EXPAND(appendPrefix + 'CorporateIncorporationState');//100%
    STRING #EXPAND(appendPrefix + 'CorporateFederalTaxID');//5%
    STRING #EXPAND(appendPrefix + 'OrganizationStructureDescription');//80%
    STRING #EXPAND(appendPrefix + 'ProfitIndicator');//27% (corp_for_profit_ind)
    STRING #EXPAND(appendPrefix + 'RegisteredAgentName');//77%
    STRING #EXPAND(appendPrefix + 'BipLevel');
  END;
  
  //Get the Prox hits
  LOCAL dCorpProxOut := JOIN(dDistributed,dCorpProxDup,
    (UNSIGNED)LEFT.InUltId = (UNSIGNED)RIGHT.InUltId
    AND (UNSIGNED)LEFT.InSeleId = (UNSIGNED)RIGHT.InSeleId
    AND (UNSIGNED)LEFT.InProxId = (UNSIGNED)RIGHT.InProxId,
    TRANSFORM(rOut,
      SELF.#EXPAND(appendPrefix + 'CorporateKey') := RIGHT.corp_key; //100%
      SELF.#EXPAND(appendPrefix + 'CorporateState') := RIGHT.corp_state_origin; //100%
      SELF.#EXPAND(appendPrefix + 'CorporateProcessDate') := RIGHT.corp_process_date; //100%
      SELF.#EXPAND(appendPrefix + 'LegalName') := RIGHT.corp_legal_name; //100%
      SELF.#EXPAND(appendPrefix + 'CorporateFilingDescription') := RIGHT.corp_filing_desc; //16%
      SELF.#EXPAND(appendPrefix + 'CorporateStatus') := RIGHT.corp_status_desc; //94%
      SELF.#EXPAND(appendPrefix + 'CorporateStatusDate') := RIGHT.corp_status_date; //28%
      SELF.#EXPAND(appendPrefix + 'CorporateStatusComment') := RIGHT.corp_status_comment; //18%
      SELF.#EXPAND(appendPrefix + 'CorporateIncorporationDate') := RIGHT.corp_inc_date; //78%
      SELF.#EXPAND(appendPrefix + 'CorporateIncorporationState') := RIGHT.	corp_inc_state; //100%
      SELF.#EXPAND(appendPrefix + 'CorporateFederalTaxID') := RIGHT.corp_fed_tax_id; //5%
      SELF.#EXPAND(appendPrefix + 'OrganizationStructureDescription') := RIGHT.corp_orig_org_structure_desc;//80%
      SELF.#EXPAND(appendPrefix + 'ProfitIndicator') := RIGHT.corp_for_profit_ind; //27% (corp_for_profit_ind)
      SELF.#EXPAND(appendPrefix + 'RegisteredAgentName') := RIGHT.corp_ra_name; //77%
      SELF.#EXPAND(appendPrefix + 'BipLevel') := 'Prox';
      SELF := LEFT),
    LIMIT(0),KEEP(100), LOCAL);
  
  //Get the Sele hits for the records that were not already found by Prox
  LOCAL dProxCorpNotFound := DISTRIBUTE(JOIN(dDistributed, dCorpProxOut, 
		(UNSIGNED)LEFT.InUltID = (UNSIGNED)RIGHT.InUltID AND 
		(UNSIGNED)LEFT.InSeleID = (UNSIGNED)RIGHT.InSeleID AND 
		(UNSIGNED)LEFT.InProxId = (UNSIGNED)RIGHT.InProxid,
    TRANSFORM({RECORDOF(LEFT)},
      SELF := LEFT), 
		LEFT ONLY, 
		HASH), HASH32(InUltId));    
  LOCAL dCorpSeleOut := JOIN(dProxCorpNotFound,dCorpSeleDup,
    (UNSIGNED)LEFT.InUltId = (UNSIGNED)RIGHT.InUltId
    AND (UNSIGNED)LEFT.InSeleId = (UNSIGNED)RIGHT.InSeleId,
    TRANSFORM(rOut,
      SELF.#EXPAND(appendPrefix + 'CorporateKey') := RIGHT.corp_key; //100%
      SELF.#EXPAND(appendPrefix + 'CorporateState') := RIGHT.corp_state_origin; //100%
      SELF.#EXPAND(appendPrefix + 'CorporateProcessDate') := RIGHT.corp_process_date; //100%
      SELF.#EXPAND(appendPrefix + 'LegalName') := RIGHT.corp_legal_name; //100%
      SELF.#EXPAND(appendPrefix + 'CorporateFilingDescription') := RIGHT.corp_filing_desc; //16%
      SELF.#EXPAND(appendPrefix + 'CorporateStatus') := RIGHT.corp_status_desc; //94%
      SELF.#EXPAND(appendPrefix + 'CorporateStatusDate') := RIGHT.corp_status_date; //28%
      SELF.#EXPAND(appendPrefix + 'CorporateStatusComment') := RIGHT.corp_status_comment; //18%
      SELF.#EXPAND(appendPrefix + 'CorporateIncorporationDate') := RIGHT.corp_inc_date; //78%
      SELF.#EXPAND(appendPrefix + 'CorporateIncorporationState') := RIGHT.	corp_inc_state; //100%
      SELF.#EXPAND(appendPrefix + 'CorporateFederalTaxID') := RIGHT.corp_fed_tax_id; //5%
      SELF.#EXPAND(appendPrefix + 'OrganizationStructureDescription') := RIGHT.corp_orig_org_structure_desc;//80%
      SELF.#EXPAND(appendPrefix + 'ProfitIndicator') := RIGHT.corp_for_profit_ind; //27% (corp_for_profit_ind)
      SELF.#EXPAND(appendPrefix + 'RegisteredAgentName') := RIGHT.corp_ra_name; //77%
      SELF.#EXPAND(appendPrefix + 'BipLevel') := 'Sele';
      SELF := LEFT),
    LIMIT(0),KEEP(100), LOCAL);
  
  //Combine the Hits
  LOCAL dCorpFinal := dCorpProxOut + dCorpSeleOut;
  
  //Get the no Hit and empty records
  LOCAL dNoHit := JOIN(dDistributed, dCorpFinal,
    (UNSIGNED)LEFT.InUltId = (UNSIGNED)RIGHT.InUltId
    AND (UNSIGNED)LEFT.InSeleId = (UNSIGNED)RIGHT.InSeleId
    AND (UNSIGNED)LEFT.InProxId = (UNSIGNED)RIGHT.InProxId, 
    TRANSFORM(rOut, SELF := LEFT, SELF := []), LEFT ONLY)
    + PROJECT(dIn((UNSIGNED)InUltId = 0), TRANSFORM(rOut,
        SELF := LEFT, SELF := []));
  
  //Combine results
  LOCAL dOut := DISTRIBUTE(dCorpFinal + dNoHit);
  RETURN dOut;
ENDMACRO;