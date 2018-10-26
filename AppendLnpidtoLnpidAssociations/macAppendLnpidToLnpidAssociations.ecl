EXPORT macAppendLnpidToLnpidAssociations(dIn, inLnpid = '', inAssociateThreshold = 10, appendPrefix = '\'\'',
  inLexid = '', inName = '', UseIndexThreshold=10000000) := FUNCTIONMACRO
	IMPORT AppendLnpidToLnpidAssociations;
  LOCAL dDistributed  := DISTRIBUTE(dIn((UNSIGNED)inLnpid <> 0), HASH32(inLnpid));
  LOCAL dupLnpid      := DEDUP(SORT (dDistributed, inLnpid, LOCAL), inLnpid, LOCAL);
	
  LOCAL rJoin := RECORD
    dIn.inLnpid;
    AppendLnpidToLnpidAssociations.Layouts.LnpidToLnpidAssocRec;
  END;
  
  LOCAL AppendAssociatesSmall := JOIN(dupLnpid, AppendLnpidToLnpidAssociations.Keys.LnpidToLnpidAssocKey, 
    KEYED((UNSIGNED)LEFT.inLnpid = RIGHT.Person_LNPID) AND
		RIGHT.Assoc_Count <= (INTEGER)inAssociateThreshold,
    TRANSFORM(rJoin, 
      SELF := RIGHT,
      SELF := LEFT), 
    LIMIT(10000,SKIP));
    
	LOCAL AppendAssociatesLarge := JOIN(PULL(AppendLnpidToLnpidAssociations.Keys.LnpidToLnpidAssocKey), dupLnpid, 
    LEFT.Person_LNPID = (UNSIGNED)RIGHT.inLnpid AND
		LEFT.Assoc_Count <= (INTEGER)inAssociateThreshold,
    TRANSFORM(rJoin, 
      SELF := LEFT,
      SELF := RIGHT), 
    SMART, MANY, ATMOST(10000));
	
	LOCAL AppendAssociates := MAP(COUNT(dupLnpid) > UseIndexThreshold => AppendAssociatesLarge, AppendAssociatesSmall);
  
  LOCAL rOut := RECORD
    RECORDOF(dIn);
    UNSIGNED8 #EXPAND(appendPrefix + 'PersonLnpid');
    UNSIGNED8 #EXPAND(appendPrefix + 'PersonLexid');
    STRING    #EXPAND(appendPrefix + 'PersonName');
    UNSIGNED8 #EXPAND(appendPrefix + 'AssociateLnpid');
    UNSIGNED8 #EXPAND(appendPrefix + 'AssociateLexid');
    STRING    #EXPAND(appendPrefix + 'AssociateName');
    STRING    #EXPAND(appendPrefix + 'Relationship');
    STRING10  #EXPAND(appendPrefix + 'PrimaryRange');
    STRING2   #EXPAND(appendPrefix + 'PreDirection');
    STRING28  #EXPAND(appendPrefix + 'PrimaryName');
    STRING4   #EXPAND(appendPrefix + 'AddressSuffix');
    STRING2   #EXPAND(appendPrefix + 'PostDirection');
    STRING8   #EXPAND(appendPrefix + 'SecondaryRange');
    STRING25  #EXPAND(appendPrefix + 'City');
    STRING2   #EXPAND(appendPrefix + 'State');
    STRING5   #EXPAND(appendPrefix + 'Zip');
    STRING    #EXPAND(appendPrefix + 'AddressKey');
    INTEGER1 	#EXPAND(appendPrefix + 'HasActiveExclusion');
    INTEGER1 	#EXPAND(appendPrefix + 'HasActiveRevocation');
    INTEGER1 	#EXPAND(appendPrefix + 'HasReinstatedExclusion');
    INTEGER1 	#EXPAND(appendPrefix + 'HasReinstatedRevocation');
    INTEGER1 	#EXPAND(appendPrefix + 'HasBankruptcy');
    INTEGER1 	#EXPAND(appendPrefix + 'HasCriminalHistory');
    INTEGER1  #EXPAND(appendPrefix + 'HasRelativeConvictions');
    INTEGER1 	#EXPAND(appendPrefix + 'HasRelativeBankruptcy');			
    INTEGER1 	#EXPAND(appendPrefix + 'IsDeceased');			
    INTEGER2 	#EXPAND(appendPrefix + 'Score');	
    UNSIGNED4	#EXPAND(appendPrefix + 'AssociationCount');	
    UNSIGNED4	#EXPAND(appendPrefix + 'BadAssociationCount');	
  END;
  
  LOCAL dOut := JOIN(dIn, AppendAssociates,
    (UNSIGNED)LEFT.inLnpid = (UNSIGNED)RIGHT.inLnpid,
    TRANSFORM(rOut,
      SELF.#EXPAND(appendPrefix + 'PersonLnpid')    := IF((UNSIGNED)RIGHT.Person_LNPID <> 0, (UNSIGNED)RIGHT.Person_LNPID, (UNSIGNED)LEFT.inLnpid),
      SELF.#EXPAND(appendPrefix + 'PersonLexid')    := #IF(#TEXT(inLexid)!= '') IF((UNSIGNED)RIGHT.Person_Lexid <> 0, (UNSIGNED)RIGHT.Person_Lexid, (UNSIGNED)LEFT.inLexid) #ELSE (UNSIGNED)RIGHT.Person_Lexid  #END,
      SELF.#EXPAND(appendPrefix + 'PersonName')     := #if(#TEXT(inName) != '')  IF(RIGHT.Person_Name <> '', RIGHT.Person_Name, LEFT.inName)   #ELSE RIGHT.Person_Name   #END,
      SELF.#EXPAND(appendPrefix + 'AssociateLnpid') := RIGHT.Assoc_LNPID,
      SELF.#EXPAND(appendPrefix + 'AssociateLexid') := RIGHT.Assoc_Lexid,
      SELF.#EXPAND(appendPrefix + 'AssociateName')  := RIGHT.Assoc_Name,
      SELF.#EXPAND(appendPrefix + 'Relationship')   := RIGHT.relationship,
      SELF.#EXPAND(appendPrefix + 'PrimaryRange')   := RIGHT.prim_range,
      SELF.#EXPAND(appendPrefix + 'PreDirection')   := RIGHT.predir,
      SELF.#EXPAND(appendPrefix + 'PrimaryName')    := RIGHT.prim_name,
      SELF.#EXPAND(appendPrefix + 'AddressSuffix')  := RIGHT.addr_suffix,
      SELF.#EXPAND(appendPrefix + 'PostDirection')  := RIGHT.postdir,
      SELF.#EXPAND(appendPrefix + 'SecondaryRange') := RIGHT.sec_range,
      SELF.#EXPAND(appendPrefix + 'City')           := RIGHT.v_city_name,
      SELF.#EXPAND(appendPrefix + 'State')          := RIGHT.st,
      SELF.#EXPAND(appendPrefix + 'Zip')            := RIGHT.zip,
      SELF.#EXPAND(appendPrefix + 'AddressKey')     := RIGHT.addr_key,
      SELF.#EXPAND(appendPrefix + 'HasActiveExclusion')       := IF(RIGHT.hasactiveexclusion = 'Y', 1, 0),
      SELF.#EXPAND(appendPrefix + 'HasActiveRevocation')      := IF(RIGHT.hasactiverevocation = 'Y', 1, 0),
      SELF.#EXPAND(appendPrefix + 'HasReinstatedExclusion')   := IF(RIGHT.hasreinstatedexclusion = 'Y', 1, 0),
      SELF.#EXPAND(appendPrefix + 'HasReinstatedRevocation')  := IF(RIGHT.hasreinstatedrevocation = 'Y', 1, 0),
      SELF.#EXPAND(appendPrefix + 'HasBankruptcy')            := IF(RIGHT.hasbackruptcy = 'Y', 1, 0),
      SELF.#EXPAND(appendPrefix + 'HasCriminalHistory')       := IF(RIGHT.hascriminalhistory = 'Y', 1, 0),
      SELF.#EXPAND(appendPrefix + 'HasRelativeConvictions')   := IF(RIGHT.hasrelativeconvictions = 'Y', 1, 0),
      SELF.#EXPAND(appendPrefix + 'HasRelativeBankruptcy')    := IF(RIGHT.hasrelativebankruptcy = 'Y', 1, 0),
      SELF.#EXPAND(appendPrefix + 'IsDeceased')               := IF(RIGHT.hasdeceased = 'Y', 1, 0),
      SELF.#EXPAND(appendPrefix + 'Score')                    := RIGHT.score,
      SELF.#EXPAND(appendPrefix + 'AssociationCount')         := RIGHT.assoc_count,
      SELF.#EXPAND(appendPrefix + 'BadAssociationCount')      := RIGHT.bad_assoc_count,
      SELF := LEFT),
    LEFT OUTER);
      
  RETURN dOut;
ENDMACRO;