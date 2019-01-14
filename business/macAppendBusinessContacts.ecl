IMPORT AutoStandardI;
EXPORT macAppendBusinessContacts(dIn, InUltid, InOrgId, InSeleId, 
  returnCurrentOnly = 'TRUE', returnExecutivesOnly = 'FALSE', 
  appendPrefix = '\'\'', 
  ApplicationType = '\'\'', _DataRestrictionMask = AutoStandardI.Constants.DataRestrictionMask_default, 
  _GLBPurpose = AutoStandardI.Constants.GLBPurpose_default, _DPPAPurpose = '0',
  UseIndexThreshold=10000000) := FUNCTIONMACRO
IMPORT BIPV2, ut, BIPV2_Suppression, ecl;
  LOCAL _contactsModule := MODULE
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
  LOCAL contactsModule := MODULE(PROJECT(_contactsModule,BIPV2.mod_sources.iParams,OPT)) END;
 
  LOCAL dDistributed    := DISTRIBUTE(dIn((UNSIGNED)InUltId <> 0), HASH32(InUltId));
  LOCAL rSearch := {RECORDOF(dIn) OR {INTEGER _searchUlt,INTEGER _searchOrg,INTEGER _searchSele}};
  LOCAL dSearch := PROJECT(dDistributed, TRANSFORM(rSearch,
    SELF._searchUlt := (INTEGER)LEFT.InUltId,
    SELF._searchOrg := (INTEGER)LEFT.InOrgId,
    SELF._searchSele := (INTEGER)LEFT.InSeleId,
    SELF := LEFT));
  LOCAL dDeduped        := DEDUP(SORT(dSearch, InUltId, InOrgId, InSeleId, LOCAL), InUltId, InOrgId, InSeleId, LOCAL);
  
  LOCAL bipContacts := ecl.macJoinKey(dDeduped, Business.Keys.Key_Contacts,
    'KEYED((UNSIGNED)LEFT._searchUlt = RIGHT.UltId) AND	WILD(RIGHT.OrgId) AND	KEYED((UNSIGNED)LEFT._searchSele = RIGHT.SeleId)', 
    'LEFT.UltID = (UNSIGNED)RIGHT._searchUlt AND LEFT.SeleID = (UNSIGNED)RIGHT._searchSele', 
    UseIndexThreshold,,,,true,10000,true,true); 
    
  //Business.Keys.Key_Contacts is the same as BIPV2_Build.key_contact_linkids.Key
  //We can't call BIPV2_Build.key_contact_linkids.kFetch as we need to be able to handle mini-batch for large input datasets
  //Suppressions and restrictions similar to BIPV2_Build.key_contact_linkids.kFetch are applied below
  //If additional suppressions and restrictions are ever added to kFetch please contact
  //Julie Dobrosevic or Jo Prichard
  LOCAL dContactsRestricted :=bipContacts(BIPV2.mod_sources.isPermitted(contactsModule).bySource(source, vl_id));		
	//This macro handles the suppression for Contacts
  BIPV2_Suppression.mac_contacts(dContactsRestricted, LOCAL dContacts, LOCAL dContactsDirty);
  
  LOCAL dContactsFiltered := IF(returnExecutivesOnly, dContacts(executive_ind), dContacts);
    
  LOCAL rContactsFinal :=
  RECORD
    RECORDOF(dIn);
    UNSIGNED6 #EXPAND(appendPrefix + 'LexID');
    STRING    #EXPAND(appendPrefix + 'Title');
    STRING    #EXPAND(appendPrefix + 'FirstName');
    STRING    #EXPAND(appendPrefix + 'MiddleName');
    STRING    #EXPAND(appendPrefix + 'LastName');
    STRING    #EXPAND(appendPrefix + 'Suffix');
    STRING    #EXPAND(appendPrefix + 'JobTitle');
    STRING    #EXPAND(appendPrefix + 'ContactType');//?
    BOOLEAN   #EXPAND(appendPrefix + 'IsExecutive');
    INTEGER   #EXPAND(appendPrefix + 'ExecutiveOrder');//?
    UNSIGNED  #EXPAND(appendPrefix + 'DateFirstSeen');
    UNSIGNED  #EXPAND(appendPrefix + 'DateLastSeen');
    BOOLEAN   #EXPAND(appendPrefix + 'isCurrent');
    BOOLEAN   #EXPAND(appendPrefix + 'ContactAppended');
    BOOLEAN   #EXPAND(appendPrefix + 'ContactIdentified');
  END;
  
  LOCAL rContactsFinal tContactsAppendCurrentFlag(dContactsFiltered pIn) :=
  TRANSFORM
    SELF.#EXPAND(appendPrefix + 'LexID')          := pIn.contact_did;
    SELF.#EXPAND(appendPrefix + 'Title')          := pIn.contact_name.title;
    SELF.#EXPAND(appendPrefix + 'FirstName')      := pIn.contact_name.fname;
    SELF.#EXPAND(appendPrefix + 'MiddleName')      := pIn.contact_name.mname;
    SELF.#EXPAND(appendPrefix + 'LastName')       := pIn.contact_name.lname;
    SELF.#EXPAND(appendPrefix + 'Suffix')         := pIn.contact_name.name_suffix;
    SELF.#EXPAND(appendPrefix + 'JobTitle')       := pIn.contact_job_title_derived;
    SELF.#EXPAND(appendPrefix + 'ContactType')    := pIn.contact_type_derived;
    SELF.#EXPAND(appendPrefix + 'isExecutive')    := pIn.executive_ind;
    SELF.#EXPAND(appendPrefix + 'ExecutiveOrder') := pIn.executive_ind_order;
    SELF.#EXPAND(appendPrefix + 'DateFirstSeen')  := pIn.dt_first_seen_contact;
    SELF.#EXPAND(appendPrefix + 'DateLastSeen')   := pIn.dt_last_seen_contact;
    STRING8 vCurrentDate := ut.GetDate;     
    // Treat executives as current if date last seen is greater than current date - 2 years
    SELF.#EXPAND(appendPrefix + 'isCurrent') := IF((UNSIGNED4) pIn.dt_last_seen_contact != 0, 
                          (UNSIGNED4) pIn.dt_last_seen_contact >= (UNSIGNED4)ut.date_math(vCurrentDate,-730),
                          FALSE);
    SELF.#EXPAND(appendPrefix + 'ContactAppended')  := TRUE;
    SELF.#EXPAND(appendPrefix + 'ContactIdentified'):= pIn.contact_did <> 0;
    SELF.InUltID    := (TYPEOF(SELF.InUltID))pIn.UltID;
    SELF.InOrgID    := (TYPEOF(SELF.InOrgID))pIn.OrgID;
    SELF.InSeleID   := (TYPEOF(SELF.InSeleID))pIn.SeleID;
    SELF            := pIn;
    SELF            := [];
  END;
  
  LOCAL dContactsOut := PROJECT(dContactsFiltered,tContactsAppendCurrentFlag(LEFT));
  
  LOCAL dCurrentContacts := IF(returnCurrentOnly, dContactsOut(#EXPAND(appendPrefix + 'isCurrent')), dContactsOut);
  
  LOCAL dContactsDedup := DEDUP(DEDUP(SORT(DISTRIBUTE(dCurrentContacts,HASH32(InUltId)),
    InUltId, InOrgId, InSeleId, #EXPAND(appendPrefix + 'LexID'), #EXPAND(appendPrefix + 'LastName'), #EXPAND(appendPrefix + 'FirstName'), #EXPAND(appendPrefix + 'MiddleName'),#EXPAND(appendPrefix + 'Suffix'),
    #EXPAND(appendPrefix + 'ExecutiveOrder'), -#EXPAND(appendPrefix + 'DateLastSeen'), LOCAL),
      InUltId, InOrgId, InSeleId, #EXPAND(appendPrefix + 'LexID'), #EXPAND(appendPrefix + 'LastName'), #EXPAND(appendPrefix + 'FirstName'), 
      UT.NNEQ(LEFT.#EXPAND(appendPrefix + 'MiddleName'),RIGHT.#EXPAND(appendPrefix + 'MiddleName')), #EXPAND(appendPrefix + 'Suffix'), LOCAL),
        InUltId, InOrgId, InSeleId,KEEP(100),LOCAL);
   
  LOCAL dOut := JOIN(dDistributed,dContactsDedup,
    LEFT.InUltId = RIGHT.InUltId AND
    // LEFT.InOrgId = RIGHT.InOrgId AND
    LEFT.InSeleId = RIGHT.InSeleId,
    TRANSFORM(rContactsFinal,
      SELF  := LEFT,
      SELF  := RIGHT),
    LEFT OUTER,
    LIMIT(0),KEEP(100),
    LOCAL) 
      + PROJECT(dIn((UNSIGNED)InUltId = 0), TRANSFORM(rContactsFinal,
        SELF := LEFT, SELF := []));
    
  RETURN dOut;
ENDMACRO;