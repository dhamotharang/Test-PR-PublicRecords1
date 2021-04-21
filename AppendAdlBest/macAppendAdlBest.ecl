EXPORT macAppendAdlBest(dIn, inLexID, inAccountNumber = '', 
  appendPrefix = '\'\'', 
  InDPPA = '', InGLB = '', InDRM = '', InDPM = '', InIndustryClass = '',
  InAppends = 'BEST_ALL, BEST_EDA, HHID_PLUS', InVerify = 'BEST_ALL',
  inDeduped = TRUE, InIncludeRanking = FALSE, InMaxResultsPerAcct = 1,
  InPatriotProcess = FALSE,  
  // IncludeMinors = FALSE, InGLBData = FALSE, InSSNMask = '',
  // InApplicationType = '', InAllowAll = 1, inAppendThreshold = '', 
  InRoxie = '\'\'',ParallelNodes = 50, BatchSize = 100, ParallelRequests = 2) := FUNCTIONMACRO
  
  IMPORT DidVille;
  
  LOCAL rOut := RECORD
    RECORDOF(dIn);
    STRING #EXPAND(appendPrefix + 'Title'):= '';
    STRING #EXPAND(appendPrefix + 'FirstName'):= '';
    STRING #EXPAND(appendPrefix + 'MiddleName'):= '';
    STRING #EXPAND(appendPrefix + 'LastName'):= '';
    STRING #EXPAND(appendPrefix + 'NameSuffix'):= '';
    STRING #EXPAND(appendPrefix + 'Address'):= '';
    STRING #EXPAND(appendPrefix + 'City'):= '';
    STRING #EXPAND(appendPrefix + 'State'):= '';
    STRING #EXPAND(appendPrefix + 'Zip'):= '';
    STRING #EXPAND(appendPrefix + 'Zip4'):= '';
    STRING #EXPAND(appendPrefix + 'AddressDate'):= '';
  END;
  
	LOCAL rAdlIn      := DidVille.Layout_Did_InBatchRaw;
  LOCAL rAdlOut     := DidVille.Layout_Did_OutBatch_Raw;
  LOCAL ServiceIP   := #IF ( #TEXT(InRoxie) <> '') 	(STRING) TRIM(InRoxie)  #ELSE 'http://roxieqavip.br.seisint.com:9876' #END;
	LOCAL ServiceName := 'didville.did_batch_service_raw';
  
  //Dedup to only send the same Lexid once
  LOCAL dDupIn := DEDUP(SORT(DISTRIBUTE(dIn((INTEGER)inLexid <> 0), HASH64(inLexid)), inLexid, LOCAL), inLexid, LOCAL);
  
	LOCAL rAdlIn xFormInBatch (dIn L, INTEGER C) := TRANSFORM
			SELF.AcctNo :=  #IF(#TEXT(inAccountNumber)<>'')(TYPEOF(SELF.Acctno))L.inAccountNumber #ELSE(TYPEOF(SELF.Acctno))C #END;
			SELF.DID    :=  (TYPEOF(SELF.DID))L.inLexID;
			SELF := [];
		END;
		
  LOCAL dAdlSoapIn := PROJECT (dDupIn, xFormInBatch (LEFT, COUNTER));
																			
  LOCAL rAdlSoapOut := RECORD
    (rAdlOut)
    STRING errorcode;
  END;
  
  STRING optionValue := '<DPPAPurpose>'+(STRING)inDPPA+'</DPPAPurpose><GLBPurpose>'+(STRING)inGLB+'</GLBPurpose><DataRestrictionMask>'+(STRING)inDRM+'</DataRestrictionMask><DataPermissionMask>'+(STRING)inDPM+'</DataPermissionMask><IndustryClass>'+(STRING)InIndustryClass+'</IndustryClass>'
    +'<Appends>'+(STRING)inAppends+'</Appends><Verify>'+(STRING)InVerify+'</Verify><Deduped>'+(STRING)inDeduped+'</Deduped><IncludeRanking>'+(STRING)inIncludeRanking+'</IncludeRanking><PatriotProcess>'+(STRING)inPatriotProcess+'</PatriotProcess><Max_Results_Per_Acct>'+(STRING)InMaxResultsPerAcct+'</Max_Results_Per_Acct>';
  STRING options := optionValue + '<did_batch_in><Row>';	
  
  LOCAL rAdlSoapOut xFormSoapError(dAdlSoapIn le) := TRANSFORM
    SELF.errorcode := FAILCODE +'  '+ FAILMESSAGE;
    SELF := [];
  END;

  LOCAL dAdlSoapOut := SOAPCALL(dAdlSoapIn, 
    ServiceIP,
    ServiceName, 
    {dAdlSoapIn},
    DATASET(rAdlSoapOut),
    onFail(xFormSoapError(LEFT)),
    HEADING(options,'</Row></did_batch_in>'),
    PARALLEL(ParallelRequests), 
    MERGE(BatchSize));
    
  //JOIN back to make sure to return the same amount of records as came in
   LOCAL dOut := JOIN(dIn, dAdlSoapOut,
    (INTEGER)LEFT.inLexid = (INTEGER)RIGHT.DID,
    TRANSFORM(rOut,      
      SELF.#EXPAND(appendPrefix + 'Title'):= RIGHT.best_title;
      SELF.#EXPAND(appendPrefix + 'FirstName'):= RIGHT.best_fname;
      SELF.#EXPAND(appendPrefix + 'MiddleName'):= RIGHT.best_mname;
      SELF.#EXPAND(appendPrefix + 'LastName'):= RIGHT.best_lname;
      SELF.#EXPAND(appendPrefix + 'NameSuffix'):= RIGHT.best_name_suffix;
      SELF.#EXPAND(appendPrefix + 'Address'):= RIGHT.best_addr1;
      SELF.#EXPAND(appendPrefix + 'City'):= RIGHT.best_city;
      SELF.#EXPAND(appendPrefix + 'State'):= RIGHT.best_state;
      SELF.#EXPAND(appendPrefix + 'Zip'):= RIGHT.best_zip;
      SELF.#EXPAND(appendPrefix + 'Zip4'):= RIGHT.best_zip4;
      SELF.#EXPAND(appendPrefix + 'AddressDate'):= RIGHT.best_addr_date,
      SELF := LEFT),
    LEFT OUTER);
    
  RETURN dOut;
  
ENDMACRO;
