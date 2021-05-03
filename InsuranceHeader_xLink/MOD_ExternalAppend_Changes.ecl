EXPORT MOD_ExternalAppend_Changes := MODULE
 
  // macro to perform external linking on records with previously appended DIDs that experienced a change
  EXPORT MAC_MEOW_xIDL_Batch_ChangeID(infile,Input_AppendedDID,Output_AppendedDID = '',Ref,Input_SNAME = '',Input_FNAME = '',Input_MNAME = '',Input_LNAME = '',Input_DERIVED_GENDER = '',Input_PRIM_RANGE = '',Input_PRIM_NAME = '',Input_SEC_RANGE = '',Input_CITY = '',Input_ST = '',Input_ZIP = '',Input_SSN5 = '',Input_SSN4 = '',Input_DOB = '',Input_PHONE = '',Input_DL_STATE = '',Input_DL_NBR = '',Input_SRC = '',Input_SOURCE_RID = '',Input_DT_FIRST_SEEN = '',Input_DT_LAST_SEEN = '',Input_DT_EFFECTIVE_FIRST = '',Input_DT_EFFECTIVE_LAST = '',Input_MAINNAME = '',Input_FULLNAME = '',Input_ADDR1 = '',Input_LOCALE = '',Input_ADDRESS = '',Input_fname2 = '',Input_lname2 = '',Input_VIN = '',OutFile,AsIndex = 'true',In_disableForce = 'false',RawResults = 'false',DoClean = 'true') := MACRO
    IMPORT InsuranceHeader_xLink;
    #UNIQUENAME(keyChanges)
    #UNIQUENAME(potentialChangeRecs)
    %keyChanges% := InsuranceHeader_xLink.Process_xIDL_Layouts().KeyChangeID;
    // dedup because Change ID key from multiple incremental builds could include duplicate DIDs
    %potentialChangeRecs% := DEDUP(SORT(DISTRIBUTE(JOIN(infile, %keyChanges%, KEYED(LEFT.Input_AppendedDID = RIGHT.DID), TRANSFORM(LEFT)), HASH(Ref)), Ref, LOCAL), Ref, LOCAL);
 
    #UNIQUENAME(OutFileXlink)
    InsuranceHeader_xLink.MAC_MEOW_xIDL_Batch(%potentialChangeRecs%,Ref,,Input_SNAME,Input_FNAME,Input_MNAME,Input_LNAME,Input_DERIVED_GENDER,Input_PRIM_RANGE,Input_PRIM_NAME,Input_SEC_RANGE,Input_CITY,Input_ST,Input_ZIP,Input_SSN5,Input_SSN4,Input_DOB,Input_PHONE,Input_DL_STATE,Input_DL_NBR,Input_SRC,Input_SOURCE_RID,Input_DT_FIRST_SEEN,Input_DT_LAST_SEEN,Input_DT_EFFECTIVE_FIRST,Input_DT_EFFECTIVE_LAST,Input_MAINNAME,Input_FULLNAME,Input_ADDR1,Input_LOCALE,Input_ADDRESS,Input_fname2,Input_lname2,Input_VIN,%OutFileXlink%,AsIndex,,,In_disableForce,DoClean);
 
    #IF(RawResults)
      OutFile := %OutFileXlink%;
    #ELSE
      #UNIQUENAME(joinResults)
      %joinResults% := JOIN(%potentialChangeRecs%, %OutFileXlink%, LEFT.Ref = RIGHT.Reference, TRANSFORM(RECORDOF(LEFT), SELF.Output_AppendedDID := IF(RIGHT.Resolved AND ~RIGHT.Ambiguous, SORT(RIGHT.Results, -weight)[1].DID, 0), SELF := LEFT));
      OutFile := %joinResults%(Output_AppendedDID > 0);
    #END
 
  ENDMACRO;
 
  // macro to create changes table/key/key build definition
  EXPORT MAC_BuildChanges(inUpdateRecs, srcField, srcRIDField, DIDFieldInitial, DIDFieldUpdate, outChanges, keyname_access = '', keyname_build = '', outChangeKeyDef = '', outChangeKeyBuild = '') := MACRO
    IMPORT SALT311;
 
    #UNIQUENAME(Layout_Changes)
    %Layout_Changes% := RECORD
      SALT311.UIDType DID1;
      SALT311.UIDType DID2;
      inUpdateRecs.srcField;
      inUpdateRecs.srcRIDField;
      BOOLEAN reversed;
    END;
 
    #UNIQUENAME(inUpdateRecs_withChanges)
    %inUpdateRecs_withChanges% := inUpdateRecs(DIDFieldInitial > 0 AND DIDFieldInitial <> DIDFieldUpdate);
 
    #UNIQUENAME(actualChanges)
    %actualChanges% := PROJECT(%inUpdateRecs_withChanges%,
                                 TRANSFORM(%Layout_Changes%,
                                           SELF.DID1 := LEFT.DIDFieldInitial,
                                           SELF.DID2 := LEFT.DIDFieldUpdate,
                                           SELF.srcField := LEFT.srcField,
                                           SELF.srcRIDField := LEFT.srcRIDField,
                                           SELF.reversed := FALSE));
 
    #UNIQUENAME(actualChangesReverse)
    %actualChangesReverse% := PROJECT(%actualChanges%(DID2 > 0),
                                        TRANSFORM(%Layout_Changes%,
                                                  SELF.DID1 := LEFT.DID2,
                                                  SELF.DID2 := LEFT.DID1,
                                                  SELF.reversed := TRUE,
                                                  SELF := LEFT));
 
    outChanges := %actualChanges% & %actualChangesReverse%;
 
    #IF (#TEXT(outChangeKeyDef) <> '')
      outChangeKeyDef := INDEX(outChanges, {DID1}, {outChanges}, keyname_access);
    #END
    #IF (#TEXT(outChangeKeyBuild) <> '' AND #TEXT(outChangeKeyDef) <> '')
      outChangeKeyBuild := BUILDINDEX(outChangeKeyDef, keyname_build, OVERWRITE);
    #END
 
  ENDMACRO;
 
  // macro to perform fetch using full source payload and change key- fetch will effectively apply incremental changes
  EXPORT MAC_Fetch(inSourceKey, inSourceChanges, inSearch, sourceDIDField, sourceField, sourceRIDField, inDIDField, inUniqID, outFile) := MACRO
    // just in case the input has multiple entity IDs with the same unique ID
    #UNIQUENAME(inSearch_Dedup)
    %inSearch_Dedup% := DEDUP(inSearch, inUniqID, inDIDField, ALL);
 
    #UNIQUENAME(Layout_Output)
    %Layout_Output% := RECORD
      inSearch.inUniqID;
      RECORDOF(inSourceKey);
    END;
 
    #UNIQUENAME(Layout_Fetch)
    %Layout_Fetch% := RECORD
      inSearch.inDIDField;
      inSearch.inUniqID;
      RECORDOF(inSourceChanges) change;
    END;
 
    // just a fetch from the payload by DID- if there are no changes, this is all we need
    #UNIQUENAME(mainKeyFetch)
    %mainKeyFetch% := JOIN(%inSearch_Dedup%,
                           inSourceKey,
                           KEYED(LEFT.inDIDField = RIGHT.sourceDIDField),
                           TRANSFORM(%Layout_Output%, SELF.inUniqID := LEFT.inUniqID, SELF := RIGHT));
 
    // change records
    #UNIQUENAME(changeFetch)
    %changeFetch% := JOIN(%inSearch_Dedup%,
                          inSourceChanges,
                          KEYED(LEFT.inDIDField = RIGHT.DID1),
                          TRANSFORM(%Layout_Fetch%, SELF.change := RIGHT, SELF := LEFT));
 
    // extra records (aka records added to cluster)
    #UNIQUENAME(extraSourcekeyFetch)
    %extraSourcekeyFetch% := JOIN(%changeFetch%(change.reversed),
                                  inSourceKey,
                                  KEYED(LEFT.change.DID2 = RIGHT.sourceDIDField) AND LEFT.change.sourceField = RIGHT.sourceField AND LEFT.change.sourceRIDField = RIGHT.sourceRIDField,
                                  TRANSFORM(%Layout_Output%, SELF.inUniqID := LEFT.inUniqID, SELF.sourceDIDField := LEFT.change.DID1, SELF := RIGHT));
 
    // get rid of unwanted records
    #UNIQUENAME(filterBad)
    %filterBad% := JOIN(%mainKeyFetch%,
                        %changeFetch%(~change.reversed),
                        LEFT.sourceDIDField = RIGHT.inDIDField AND LEFT.sourceField = RIGHT.change.sourceField AND LEFT.sourceRIDField = RIGHT.change.sourceRIDField,
                        TRANSFORM(LEFT),
                        LEFT ONLY);
 
    // add extra records
    outFile := %filterBad% & %extraSourcekeyFetch%;
 
  ENDMACRO;
 
END;
