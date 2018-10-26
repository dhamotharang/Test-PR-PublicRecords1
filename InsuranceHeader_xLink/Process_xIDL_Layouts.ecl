EXPORT Process_xIDL_Layouts(BOOLEAN incremental=FALSE) := MODULE
 
IMPORT SALT37,STD,IDL_Header; /*PHACK01*/
SHARED h := File_InsuranceHeader;//The input file
SHARED h0 := PROJECT(h,TRANSFORM(recordof(left),
	isUt := IDL_Header.SourceTools.SourceIsUtility(LEFT.src);
	SELF.ssn:=IF(isUt,'',LEFT.ssn);
	SELF.ssn_ind:=IF(isUt,'',LEFT.ssn_ind);
	SELF:=LEFT));//The input file /*PHACK02*/
 
EXPORT KeyName := KeyNames().header_super; /*HACK10*/
 
EXPORT KeyName_sf := '~'+KeyPrefix+'::'+'key::InsuranceHeader_xLink'+'::'+KeySuperfile+'::DID::meow';
 
EXPORT Key := INDEX(h0,{DID},{h0},KeyName); /*PHACK03*/
// Create key to get from historic versions of higher order keys
 
EXPORT KeyIDHistoryName := KeyNames().id_history_super; /*PHACK07*/
 
EXPORT KeyIDHistoryName_sf := '~'+KeyPrefix+'::'+'key::InsuranceHeader_xLink'+'::'+KeySuperfile+'::DID::sup::RID';
 
EXPORT AssignCurrentKeyIDHistoryToSuperFile := FileServices.AddSuperFile(KeyIDHistoryName_sf,KeyIDHistoryName);
 
EXPORT ClearKeyIDHistorySuperFile := SEQUENTIAL(FileServices.CreateSuperFile(KeyIDHistoryName_sf,,TRUE),FileServices.ClearSuperFile(KeyIDHistoryName_sf));
  SHARED sIDHistInc := TABLE(h,{DID, RID, DT_EFFECTIVE_FIRST, DT_EFFECTIVE_LAST}, RID, DT_EFFECTIVE_FIRST, DT_EFFECTIVE_LAST, DID,MERGE);
SHARED sIDHistFull := InsuranceHeader_xLink.IdHistoryFull(h);
SHARED sIDHist := IF(incremental, sIDHistInc, sIDHistFull);/*PHACK09*/ 

 
EXPORT KeyIDHistory := INDEX(sIDHist,{RID},{sIDHist},KeyIDHistoryName);
 
EXPORT AssignCurrentKeyToSuperFile := FileServices.AddSuperFile(KeyName_sf,KeyName);
 
EXPORT ClearKeySuperFile := SEQUENTIAL(FileServices.CreateSuperFile(KeyName_sf,,TRUE),FileServices.ClearSuperFile(KeyName_sf));
 
EXPORT Key0Name := KeyNames().header0_super; /*PHACK08*/
 
EXPORT Key0Name_sf := '~'+KeyPrefix+'::'+'key::InsuranceHeader_xLink'+'::'+KeySuperfile+'::DID::meow::DID0';
 
EXPORT Key0 := INDEX(Relatives,{DID},{Relatives},Key0Name);
 
EXPORT AssignCurrentKey0ToSuperFile := FileServices.AddSuperFile(Key0Name_sf,Key0Name);
 
EXPORT ClearKey0SuperFile := SEQUENTIAL(FileServices.CreateSuperFile(Key0Name_sf,,TRUE),FileServices.ClearSuperFile(Key0Name_sf));
  infile := Key0;
 
EXPORT BuildAll := PARALLEL(BUILDINDEX(Key, OVERWRITE),BUILDINDEX(KeyIDHistory, OVERWRITE),BUILDINDEX(Key0, OVERWRITE));
EXPORT MAC_GenerateMergedKey(in_superfileIn, in_outfileName, in_minDate, in_replaceExisting, in_indexFields, in_payloadFields, in_keyDefName) := FUNCTIONMACRO
  childFiles := NOTHOR(STD.File.SuperFileContents(in_superFileIn, TRUE));
  Layout_modifyDate := RECORD
    RECORDOF(childFiles);
    UNSIGNED4 modifyDate;
  END;
  Layout_modifyDate xModified(childFiles L) := TRANSFORM
    //SELF.modifyDate := (UNSIGNED4)(STD.Str.FindReplace(STD.File.GetLogicalFileAttribute('~' + L.name,'modified'),'-','')[1..8]);
SELF.modifyDate   := (UNSIGNED4)L.name[STD.Str.Find(L.name,'_xlink',1) + 8..IF(STD.Str.Find(L.name,'did',1)> 0 , STD.Str.Find(L.name,'did',1), STD.Str.Find(L.name,'idl',1)) -3]; /*PHACK10*/

    SELF := L;
  END;
  childFiles_withDates := NOTHOR(PROJECT(childFiles, xModified(LEFT)));
  childFiles_use := childFiles_withDates(modifyDate >= in_minDate);
  mergeKeys := SALT37.MAC_BuildKeyMerge('childFiles_use', 'name', Config.MaxMergeFiles, in_indexFields + IF(TRIM(in_payloadFields) > '', ',' + in_payloadFields, ''), in_keyDefName);
  indexCombined := INDEX(mergeKeys,{#EXPAND(in_indexFields)},{#EXPAND(in_payloadFields)}, in_outfileName);
  RETURN IF(in_replaceExisting, BUILD(indexCombined, SORTED, OVERWRITE), BUILD(indexCombined, SORTED));
ENDMACRO;
EXPORT MergeKeyFiles(STRING superFileIn, STRING outfileName, UNSIGNED4 minDate = 0, BOOLEAN replaceExisting = FALSE) := FUNCTION
  fieldListIndex := 'DID';
  fieldListPayload := SALT37.MAC_FieldListCSVFromDataset(h,['DID'],',');
  RETURN MAC_GenerateMergedKey(superFileIn, outfileName, minDate, replaceExisting, fieldListIndex, fieldListPayload, 'Key');
END;
EXPORT MergeKeyIDHistoryFiles(STRING superFileIn, STRING outfileName, UNSIGNED4 minDate = 0, BOOLEAN replaceExisting = FALSE) := FUNCTION
  fieldListIndex := 'RID';
  fieldListPayload := SALT37.MAC_FieldListCSVFromDataset(sIDHist,['RID'],',');
  RETURN MAC_GenerateMergedKey(superFileIn, outfileName, minDate, replaceExisting, fieldListIndex, fieldListPayload, 'KeyIDHistory');
END;
EXPORT FullBuildDelta(DATASET(RECORDOF(Key)) keyPayloadExisting = Config.PayloadKey, DATASET(RECORDOF(Key)) keyPayloadNewFull = INDEX(Key,KeyName)) := FUNCTION
  snapshotExisting := SALT37.MAC_DatasetAsOf(keyPayloadExisting, RID, DID,, DT_EFFECTIVE_FIRST, DT_EFFECTIVE_LAST,, 'YYYYMMDD', TRUE);
  snapshotNewFull  := SALT37.MAC_DatasetAsOf(keyPayloadNewFull, RID, DID,, DT_EFFECTIVE_FIRST, DT_EFFECTIVE_LAST,, 'YYYYMMDD', TRUE);
  resultRecs       := SALT37.MAC_PoisonRecords(snapshotExisting, snapshotNewFull, 'DID,RID', DT_EFFECTIVE_FIRST, DT_EFFECTIVE_LAST, 'YYYYMMDD');
  RETURN resultRecs;
END;
EXPORT layout_ZIP_cases := RECORD
  TYPEOF(h.ZIP) ZIP;
  INTEGER2 Weight; // we now always store weight in _cases
END;
EXPORT id_stream_layout := RECORD
    SALT37.UIDType UniqueId;
    INTEGER2 Weight;
    UNSIGNED4 KeysUsed := 0;
    UNSIGNED4 KeysFailed := 0;
    BOOLEAN IsTruncated := FALSE;
    TYPEOF(h.did) DID; /*PHACK05*/
    TYPEOF(h.rid)  RID/*PHACK11*/ := 0; // Unique record ID for external file
END;
SHARED id_stream_layout_plus := RECORD(id_stream_layout)
  KeyIDHistory.DT_EFFECTIVE_FIRST;
  KeyIDHistory.DT_EFFECTIVE_LAST;
END;
// This function produces elements with the full hierarchy filled in - presuming that the minor-most incoming id is historic
EXPORT id_stream_historic(DATASET(id_stream_layout) id) := FUNCTION
  C := id(RID<>0,DID=0); // Only record ID supplied
  id_stream_layout_plus Load(id_stream_layout le,KeyIDHistory ri) := TRANSFORM
    SELF := ri; // The new values for that ID
    SELF := le; // Remainder of id_stream information
  END;
  J_rec0 := JOIN(C,KeyIDHistory,LEFT.RID=RIGHT.RID,Load(LEFT,RIGHT),LIMIT(Config.JoinLimit));
  J_rec := PROJECT(SALT37.MAC_DatasetAsOf(J_rec0, RID, DID, UniqueId, DT_EFFECTIVE_FIRST, DT_EFFECTIVE_LAST, , 'YYYYMMDD', FALSE), id_stream_layout);
  C0 := id(DID<>0); // DID is the minormost element
  id_stream_layout_plus Load0(id_stream_layout le,KeyIDHistory ri) := TRANSFORM
    SELF.RID := 0; // Don't want record id
    SELF := ri; // The new values for that ID
    SELF := le; // Remainder of id_stream information
  END;
  J00 := JOIN(C0,KeyIDHistory,LEFT.DID=RIGHT.RID,Load0(LEFT,RIGHT),LIMIT(Config.JoinLimit));
  J0 := PROJECT(SALT37.MAC_DatasetAsOf(J00, RID, DID, UniqueId, DT_EFFECTIVE_FIRST, DT_EFFECTIVE_LAST, , 'YYYYMMDD', FALSE), id_stream_layout);
  RETURN J_rec+J0;
END;
EXPORT Fetch_Stream(DATASET(id_stream_layout) d) := FUNCTION
    k := Key;
    DLayout := RECORD
      id_stream_layout;
      BOOLEAN did_fetch;
      RECORDOF(k) AND NOT id_stream_layout; // No HEADERSEARCH specified 
    END;
    DLayout tr(id_stream_layout le, k ri) := TRANSFORM
      SELF.did_fetch := ri.DID<>0;
      SELF.DID := IF ( SELF.did_fetch, ri.DID, le.DID ); // Copy from 'real data' if it exists
      SELF.RID := IF ( SELF.did_fetch, ri.RID, le.RID ); // Copy from 'real data' if it exists
      SELF := ri;
      SELF := le;
    END;
    J0 := JOIN( d,k,(LEFT.DID = RIGHT.DID),tr(LEFT,RIGHT), LEFT OUTER, KEEP(10000), LIMIT(0));/*PHACK06*/ // Ignore excess records without erroring
    J1 := SALT37.MAC_DatasetAsOf(J0, RID, DID, UniqueId, DT_EFFECTIVE_FIRST, DT_EFFECTIVE_LAST, , 'YYYYMMDD', FALSE);
    J  := J1(DID > 0) & JOIN(d, J1(DID > 0), LEFT.UniqueId = RIGHT.UniqueId AND LEFT.DID = RIGHT.DID, TRANSFORM(RECORDOF(RIGHT), SELF := LEFT, SELF := []), LEFT ONLY);
    RETURN J;
END;
 
EXPORT Fetch_Stream_Expanded(DATASET(id_stream_layout) d) := FUNCTION
  rd1 := Fetch_Stream(d);
  old := PROJECT(rd1(~did_fetch),id_stream_layout); // Failed to fetch
  renew_candidates := id_stream_historic(old); // See if more recent version of ID is fetchable
  renewed := Fetch_Stream(renew_candidates);
  RETURN rd1(did_fetch OR KeysFailed<>0)+renewed;
END;
 
EXPORT MAC_Fetch_Batch(infile, In_DID, In_UniqueID, asIndex = TRUE) := FUNCTIONMACRO
  IMPORT SALT37,InsuranceHeader_xLink;
  payloadKey := InsuranceHeader_xLink.Process_xIDL_Layouts().Key;
  idHistKey := InsuranceHeader_xLink.Process_xIDL_Layouts().KeyIDHistory;
  outLayout := RECORD
    infile.In_UniqueID;
    SALT37.UIDType inputDID;
    RECORDOF(payloadKey);
  END;
  outLayout emptyResult(infile le) := TRANSFORM
    SELF.In_UniqueID := le.In_UniqueID;
    SELF.inputDID := le.In_DID;
    SELF := [];
  END;
 
  outLayout xJoinHist(outLayout le, idHistKey ri) := TRANSFORM
    SELF.In_UniqueID := le.In_UniqueID;
    SELF.inputDID := le.inputDID;
    SELF := ri;
    SELF := [];
  END;
 
  outLayout xJoinPayload(outLayout le, payloadKey ri) := TRANSFORM
    SELF.In_UniqueID := le.In_UniqueID;
    SELF.inputDID := le.inputDID;
    SELF := ri;
  END;
 
  infile_emptyResult := PROJECT(infile, emptyResult(LEFT));
  JEntKeyed0 := JOIN(infile_emptyResult, payloadKey, LEFT.inputDID = RIGHT.DID, xJoinPayload(LEFT,RIGHT), LEFT OUTER, KEEP(10000), LIMIT(0));/*PHACK12*/
  JEntKeyed1 := SALT37.MAC_DatasetAsof(JEntKeyed0, RID, DID, In_UniqueID, DT_EFFECTIVE_FIRST, DT_EFFECTIVE_LAST, , 'YYYYMMDD', FALSE);
  JEntKeyed  := JEntKeyed1(DID > 0) & JOIN(infile_emptyResult, JEntKeyed1(DID > 0), LEFT.In_UniqueID = RIGHT.In_UniqueID AND LEFT.inputDID = RIGHT.DID, TRANSFORM(LEFT), LEFT ONLY);
  JEntPull0 := JOIN(infile_emptyResult, PULL(payloadKey), LEFT.inputDID = RIGHT.DID, xJoinPayload(LEFT,RIGHT), LEFT OUTER, HASH, KEEP(10000), LIMIT(0));/*PHACK12*/
  JEntPull1 := SALT37.MAC_DatasetAsof(JEntPull0, RID, DID, In_UniqueID, DT_EFFECTIVE_FIRST, DT_EFFECTIVE_LAST, , 'YYYYMMDD', TRUE);
  JEntPull  := JEntPull1(DID > 0) & JOIN(infile_emptyResult, JEntPull1(DID > 0), LEFT.In_UniqueID = RIGHT.In_UniqueID AND LEFT.inputDID = RIGHT.DID, TRANSFORM(LEFT), LEFT ONLY, HASH);
 
  resultsEnt := IF(asIndex, JEntKeyed, JEntPull);
  resultsEnt_found := resultsEnt(DID > 0);
  resultsEnt_notfound := resultsEnt(DID = 0);
 
  JRecKeyed_10 := JOIN(resultsEnt_notfound, idHistKey, LEFT.inputDID = RIGHT.RID, xJoinHist(LEFT,RIGHT), LEFT OUTER);
  JRecKeyed_11 := SALT37.MAC_DatasetAsof(JRecKeyed_10, RID, DID, In_UniqueID, DT_EFFECTIVE_FIRST, DT_EFFECTIVE_LAST, , 'YYYYMMDD', FALSE);
  JRecKeyed_1  := JRecKeyed_11(DID > 0) & JOIN(resultsEnt_notfound, JRecKeyed_11(DID > 0), LEFT.In_UniqueID = RIGHT.In_UniqueID AND LEFT.inputDID = RIGHT.RID, TRANSFORM(LEFT), LEFT ONLY);
  JRecPull_10 := JOIN(resultsEnt_notfound, PULL(idHistKey), LEFT.inputDID = RIGHT.RID, xJoinHist(LEFT,RIGHT), LEFT OUTER, HASH);
  JRecPull_11 := SALT37.MAC_DatasetAsof(JRecPull_10, RID, DID, In_UniqueID, DT_EFFECTIVE_FIRST, DT_EFFECTIVE_LAST, , 'YYYYMMDD', TRUE);
  JRecPull_1  := JRecPull_11(DID > 0) & JOIN(resultsEnt_notfound, JRecPull_11(DID > 0), LEFT.In_UniqueID = RIGHT.In_UniqueID AND LEFT.inputDID = RIGHT.RID, TRANSFORM(LEFT), LEFT ONLY, HASH);
 
  resultsIDHist := IF(asIndex, JRecKeyed_1, JRecPull_1);
  resultsIDHist_found := resultsIDHist(DID > 0);
  resultsIDHist_notfound := resultsIDHist(DID = 0);
 
  JRecKeyed_20 := JOIN(resultsIDHist_found, payloadKey, LEFT.DID = RIGHT.DID, xJoinPayload(LEFT,RIGHT), LEFT OUTER, KEEP(10000), LIMIT(0));/*PHACK12*/
  JRecKeyed_21 := SALT37.MAC_DatasetAsof(JRecKeyed_20, RID, DID, In_UniqueID, DT_EFFECTIVE_FIRST, DT_EFFECTIVE_LAST, , 'YYYYMMDD', FALSE);
  JRecKeyed_2  := JRecKeyed_21(DID > 0) & JOIN(resultsIDHist_found, JRecKeyed_21(DID > 0), LEFT.In_UniqueID = RIGHT.In_UniqueID AND LEFT.DID = RIGHT.DID, TRANSFORM(LEFT), LEFT ONLY);
  JRecPull_20 := JOIN(resultsIDHist_found, PULL(payloadKey), LEFT.DID = RIGHT.DID, xJoinPayload(LEFT,RIGHT), LEFT OUTER, HASH, KEEP(10000), LIMIT(0));/*PHACK12*/
  JRecPull_21 := SALT37.MAC_DatasetAsof(JRecPull_20, RID, DID, In_UniqueID, DT_EFFECTIVE_FIRST, DT_EFFECTIVE_LAST, , 'YYYYMMDD', TRUE);
  JRecPull_2  := JRecPull_21(DID > 0) & JOIN(resultsIDHist_found, JRecPull_21(DID > 0), LEFT.In_UniqueID = RIGHT.In_UniqueID AND LEFT.DID = RIGHT.DID, TRANSFORM(LEFT), LEFT ONLY, HASH);
 
  resultsIDHistAll := IF(asIndex, JRecKeyed_2, JRecPull_2);
  resultsAll := resultsEnt_found & resultsIDHistAll & PROJECT(resultsIDHist_notfound, TRANSFORM(outLayout, SELF.inputDID := LEFT.inputDID, SELF.In_UniqueID := LEFT.In_UniqueID, SELF := []));
 
  RETURN resultsAll;
ENDMACRO;
 
EXPORT InputLayout := RECORD
  SALT37.UIDType UniqueId; // This had better be unique or it will all break horribly
  UNSIGNED2 MaxIDs := 50; // Maximum number of candidate IDs
  UNSIGNED2 LeadThreshold := 0; // Maximum distance from best to worst (0 => no pruning)
  BOOLEAN disableForce := InsuranceHeader_xLink.Config.DOB_NotUseForce;/*HACK18*/
  h.SNAME;
  h.FNAME;
  h.MNAME;
  h.LNAME;
  h.DERIVED_GENDER;
  h.PRIM_RANGE;
  h.PRIM_NAME;
  h.SEC_RANGE;
  h.CITY;
  h.ST;
  DATASET(layout_ZIP_cases) ZIP_cases;
  h.SSN5;
  h.SSN4;
  h.DOB;
  h.PHONE;
  h.DL_STATE;
  h.DL_NBR;
  h.SRC;
  h.SOURCE_RID;
  h.DT_FIRST_SEEN;
  h.DT_LAST_SEEN;
  h.DT_EFFECTIVE_FIRST;
  h.DT_EFFECTIVE_LAST;
  SALT37.StrType MAINNAME;//Wordbag field for concept
  SALT37.StrType FULLNAME;//Wordbag field for concept
  SALT37.StrType ADDR1;//Wordbag field for concept
  SALT37.StrType LOCALE;//Wordbag field for concept
  SALT37.StrType ADDRESS;//Wordbag field for concept
  Key0.fname2;
  Key0.lname2;
// Below only used in header search (data returning) case
  BOOLEAN MatchRecords := false; // Only show records which match
  BOOLEAN FullMatch := false; // Only show DID if it has a record which fully matches
  SALT37.UIDType Entered_RID := 0; // Allow user to enter RID to pull data
  SALT37.UIDType Entered_DID := 0; // Allow user to enter DID to pull data
END;
 
EXPORT HardKeyMatch(InputLayout le) := le.FNAME <> (TYPEOF(le.FNAME))'' AND Fields.InValid_FNAME((SALT37.StrType)le.FNAME)=0 AND le.LNAME <> (TYPEOF(le.LNAME))'' AND Fields.InValid_LNAME((SALT37.StrType)le.LNAME)=0 AND le.ST <> (TYPEOF(le.ST))'' AND Fields.InValid_ST((SALT37.StrType)le.ST)=0 OR le.PRIM_RANGE <> (TYPEOF(le.PRIM_RANGE))'' AND Fields.InValid_PRIM_RANGE((SALT37.StrType)le.PRIM_RANGE)=0 AND le.PRIM_NAME <> (TYPEOF(le.PRIM_NAME))'' AND Fields.InValid_PRIM_NAME((SALT37.StrType)le.PRIM_NAME)=0 AND EXISTS(le.ZIP_cases) OR le.SSN5 <> (TYPEOF(le.SSN5))'' AND Fields.InValid_SSN5((SALT37.StrType)le.SSN5)=0 AND le.SSN4 <> (TYPEOF(le.SSN4))'' AND Fields.InValid_SSN4((SALT37.StrType)le.SSN4)=0 OR le.SSN4 <> (TYPEOF(le.SSN4))'' AND Fields.InValid_SSN4((SALT37.StrType)le.SSN4)=0 AND le.FNAME <> (TYPEOF(le.FNAME))'' AND Fields.InValid_FNAME((SALT37.StrType)le.FNAME)=0 AND le.LNAME <> (TYPEOF(le.LNAME))'' OR le.DOB <> (TYPEOF(le.DOB))'' AND Fields.InValid_DOB((SALT37.StrType)le.DOB)=0 AND le.LNAME <> (TYPEOF(le.LNAME))'' AND Fields.InValid_LNAME((SALT37.StrType)le.LNAME)=0 OR le.DOB <> (TYPEOF(le.DOB))'' AND Fields.InValid_DOB((SALT37.StrType)le.DOB)=0 AND le.FNAME <> (TYPEOF(le.FNAME))'' AND Fields.InValid_FNAME((SALT37.StrType)le.FNAME)=0 OR EXISTS(le.ZIP_cases) AND le.PRIM_RANGE <> (TYPEOF(le.PRIM_RANGE))'' AND Fields.InValid_PRIM_RANGE((SALT37.StrType)le.PRIM_RANGE)=0 OR le.SRC <> (TYPEOF(le.SRC))'' AND Fields.InValid_SRC((SALT37.StrType)le.SRC)=0 AND le.SOURCE_RID <> (TYPEOF(le.SOURCE_RID))'' AND Fields.InValid_SOURCE_RID((SALT37.StrType)le.SOURCE_RID)=0 OR le.DL_NBR <> (TYPEOF(le.DL_NBR))'' AND Fields.InValid_DL_NBR((SALT37.StrType)le.DL_NBR)=0 AND le.DL_STATE <> (TYPEOF(le.DL_STATE))'' AND Fields.InValid_DL_STATE((SALT37.StrType)le.DL_STATE)=0 OR le.PHONE <> (TYPEOF(le.PHONE))'' AND Fields.InValid_PHONE((SALT37.StrType)le.PHONE)=0 OR le.LNAME <> (TYPEOF(le.LNAME))'' AND Fields.InValid_LNAME((SALT37.StrType)le.LNAME)=0 AND le.FNAME <> (TYPEOF(le.FNAME))'' AND Fields.InValid_FNAME((SALT37.StrType)le.FNAME)=0 AND EXISTS(le.ZIP_cases) OR le.fname2 <> (TYPEOF(le.fname2))'' AND Fields.InValid_fname2((SALT37.StrType)le.fname2)=0 AND le.lname2 <> (TYPEOF(le.lname2))'' AND Fields.InValid_lname2((SALT37.StrType)le.lname2)=0;
EXPORT LayoutScoredFetch := RECORD // Nulls required for linkpaths that do not have field
  h.DID;
  INTEGER2 Weight; // Specificity attached to this match
  UNSIGNED2 Score := 0; // Chances of being correct as a percentage
  SALT37.UIDType Reference := 0;//Presently for batch
  TYPEOF(h.rid)  RID/*PHACK11*/ := 0;
  BOOLEAN ForceFailed := FALSE;
  TYPEOF(h.SNAME) SNAME := (TYPEOF(h.SNAME))'';
  INTEGER2 SNAMEWeight := 0;
  INTEGER1 SNAME_match_code := 0;
  TYPEOF(h.FNAME) FNAME := (TYPEOF(h.FNAME))'';
  INTEGER2 FNAMEWeight := 0;
  INTEGER1 FNAME_match_code := 0;
  TYPEOF(h.MNAME) MNAME := (TYPEOF(h.MNAME))'';
  INTEGER2 MNAMEWeight := 0;
  INTEGER1 MNAME_match_code := 0;
  TYPEOF(h.LNAME) LNAME := (TYPEOF(h.LNAME))'';
  INTEGER2 LNAMEWeight := 0;
  INTEGER1 LNAME_match_code := 0;
  TYPEOF(h.DERIVED_GENDER) DERIVED_GENDER := (TYPEOF(h.DERIVED_GENDER))'';
  INTEGER2 DERIVED_GENDERWeight := 0;
  INTEGER1 DERIVED_GENDER_match_code := 0;
  TYPEOF(h.PRIM_RANGE) PRIM_RANGE := (TYPEOF(h.PRIM_RANGE))'';
  INTEGER2 PRIM_RANGEWeight := 0;
  INTEGER1 PRIM_RANGE_match_code := 0;
  TYPEOF(h.PRIM_NAME) PRIM_NAME := (TYPEOF(h.PRIM_NAME))'';
  INTEGER2 PRIM_NAMEWeight := 0;
  INTEGER1 PRIM_NAME_match_code := 0;
  TYPEOF(h.SEC_RANGE) SEC_RANGE := (TYPEOF(h.SEC_RANGE))'';
  INTEGER2 SEC_RANGEWeight := 0;
  INTEGER1 SEC_RANGE_match_code := 0;
  TYPEOF(h.CITY) CITY := (TYPEOF(h.CITY))'';
  INTEGER2 CITYWeight := 0;
  INTEGER1 CITY_match_code := 0;
  TYPEOF(h.ST) ST := (TYPEOF(h.ST))'';
  INTEGER2 STWeight := 0;
  INTEGER1 ST_match_code := 0;
  DATASET(layout_ZIP_cases) ZIP_cases := DATASET([],layout_ZIP_cases);
  INTEGER2 ZIPWeight := 0;
  INTEGER1 ZIP_match_code := 0;
  TYPEOF(h.SSN5) SSN5 := (TYPEOF(h.SSN5))'';
  INTEGER2 SSN5Weight := 0;
  INTEGER1 SSN5_match_code := 0;
  TYPEOF(h.SSN4) SSN4 := (TYPEOF(h.SSN4))'';
  INTEGER2 SSN4Weight := 0;
  INTEGER1 SSN4_match_code := 0;
  UNSIGNED2 DOB_year := 0;
  UNSIGNED1 DOB_month := 0;
  UNSIGNED1 DOB_day := 0;
  INTEGER2 DOBWeight := 0;
  INTEGER1 DOB_match_code := 0;
  INTEGER2 DOBWeight_year := 0;
  INTEGER1 DOB_year_match_code := 0;
  INTEGER2 DOBWeight_month := 0;
  INTEGER1 DOB_month_match_code := 0;
  INTEGER2 DOBWeight_day := 0;
  INTEGER1 DOB_day_match_code := 0;
  TYPEOF(h.PHONE) PHONE := (TYPEOF(h.PHONE))'';
  INTEGER2 PHONEWeight := 0;
  INTEGER1 PHONE_match_code := 0;
  TYPEOF(h.DL_STATE) DL_STATE := (TYPEOF(h.DL_STATE))'';
  INTEGER2 DL_STATEWeight := 0;
  INTEGER1 DL_STATE_match_code := 0;
  TYPEOF(h.DL_NBR) DL_NBR := (TYPEOF(h.DL_NBR))'';
  INTEGER2 DL_NBRWeight := 0;
  INTEGER1 DL_NBR_match_code := 0;
  TYPEOF(h.SRC) SRC := (TYPEOF(h.SRC))'';
  INTEGER2 SRCWeight := 0;
  INTEGER1 SRC_match_code := 0;
  TYPEOF(h.SOURCE_RID) SOURCE_RID := (TYPEOF(h.SOURCE_RID))'';
  INTEGER2 SOURCE_RIDWeight := 0;
  INTEGER1 SOURCE_RID_match_code := 0;
  TYPEOF(h.DT_FIRST_SEEN) DT_FIRST_SEEN := (TYPEOF(h.DT_FIRST_SEEN))'';
  INTEGER2 DT_FIRST_SEENWeight := 0;
  INTEGER1 DT_FIRST_SEEN_match_code := 0;
  TYPEOF(h.DT_LAST_SEEN) DT_LAST_SEEN := (TYPEOF(h.DT_LAST_SEEN))'';
  INTEGER2 DT_LAST_SEENWeight := 0;
  INTEGER1 DT_LAST_SEEN_match_code := 0;
  TYPEOF(h.DT_EFFECTIVE_FIRST) DT_EFFECTIVE_FIRST := (TYPEOF(h.DT_EFFECTIVE_FIRST))'';
  INTEGER2 DT_EFFECTIVE_FIRSTWeight := 0;
  INTEGER1 DT_EFFECTIVE_FIRST_match_code := 0;
  TYPEOF(h.DT_EFFECTIVE_LAST) DT_EFFECTIVE_LAST := (TYPEOF(h.DT_EFFECTIVE_LAST))'';
  INTEGER2 DT_EFFECTIVE_LASTWeight := 0;
  INTEGER1 DT_EFFECTIVE_LAST_match_code := 0;
  SALT37.StrType MAINNAME := ''; // Concepts always a wordbag
  INTEGER2 MAINNAMEWeight := 0;
  INTEGER1 MAINNAME_match_code := 0;
  SALT37.StrType FULLNAME := ''; // Concepts always a wordbag
  INTEGER2 FULLNAMEWeight := 0;
  INTEGER1 FULLNAME_match_code := 0;
  SALT37.StrType ADDR1 := ''; // Concepts always a wordbag
  INTEGER2 ADDR1Weight := 0;
  INTEGER1 ADDR1_match_code := 0;
  SALT37.StrType LOCALE := ''; // Concepts always a wordbag
  INTEGER2 LOCALEWeight := 0;
  INTEGER1 LOCALE_match_code := 0;
  SALT37.StrType ADDRESS := ''; // Concepts always a wordbag
  INTEGER2 ADDRESSWeight := 0;
  INTEGER1 ADDRESS_match_code := 0;
  TYPEOF(Key0.fname2) fname2 := (TYPEOF(Key0.fname2))'';
  INTEGER2 fname2Weight := 0;
  INTEGER1 fname2_match_code := 0;
  TYPEOF(Key0.lname2) lname2 := (TYPEOF(Key0.lname2))'';
  INTEGER2 lname2Weight := 0;
  INTEGER1 lname2_match_code := 0;
  UNSIGNED4 keys_used; // A bitmap of the keys used
  UNSIGNED4 keys_failed; // A bitmap of the keys that failed the fetch
  UNSIGNED4 keys_poisoned := 0; // A bitmap of keys that were poisoned
END;
 
EXPORT LayoutScoredFetch update_forcefailed(LayoutScoredFetch le, BOOLEAN disableForce = FALSE) := TRANSFORM
  SELF.ForceFailed := IF(disableForce, FALSE, (((le.DOB_match_code = SALT37.MatchCode.GenerationNoMatch) OR (le.DOBWeight_year<>0 OR le.DOBWeight_month<>0 OR le.DOBWeight_day<>0) AND (le.DOBWeight_year + le.DOBWeight_month + le.DOBWeight_day < Config.DOB_Force)) AND (le.SSN5Weight=0 OR le.SSN5Weight < Config.SSN5_Force) AND (le.SSN4Weight=0 OR le.SSN4Weight < Config.SSN4_Force)));
  SELF := le;
END;
 
EXPORT LayoutScoredFetch apply_poison(LayoutScoredFetch le) := TRANSFORM
  SELF.keys_poisoned := le.keys_poisoned;
  SELF.reference := le.reference;
  SELF := [];
END;
 
EXPORT isLeftWinner(INTEGER2 l_weight,INTEGER2 r_weight, INTEGER1 l_mc=SALT37.MatchCode.NoMatch, INTEGER1 r_mc=SALT37.MatchCode.NoMatch) :=
  MAP(l_mc=r_mc => l_weight>=r_weight, // matchcodes the same; so irrelevant
      l_mc=SALT37.MatchCode.ExactMatch => TRUE, // Left (only) is exact
      r_mc=SALT37.MatchCode.ExactMatch => FALSE, // Right (only) is exact
      l_weight>=r_weight); // weight only
 
EXPORT isWeightForcedDown(INTEGER2 l_weight,INTEGER2 r_weight, INTEGER1 l_mc=SALT37.MatchCode.NoMatch, INTEGER1 r_mc=SALT37.MatchCode.NoMatch) :=
  IF((isLeftWinner(l_weight,r_weight,l_mc,r_mc) AND (l_weight < r_weight)) OR  (NOT isLeftWinner(l_weight,r_weight,l_mc,r_mc) AND (l_weight > r_weight)),true,false);

EXPORT LayoutScoredFetch combine_Zip(DATASET(LayoutScoredFetch) le) := FUNCTION
 fetchResults := project(le, transform(LayoutScoredFetch,
					 SELF.ZIP_cases := DEDUP(SORT(left.ZIP_cases, ZIP,-weight ),ZIP);
						SELF := LEFT));
		RETURN fetchResults;
END;
 
EXPORT LayoutScoredFetch combine_scores(LayoutScoredFetch le,LayoutScoredFetch ri, BOOLEAN In_disableForce = FALSE) := TRANSFORM
  BOOLEAN SNAMEWeightForcedDown := IF ( isWeightForcedDown(le.SNAMEWeight,ri.SNAMEWeight,le.SNAME_match_code,ri.SNAME_match_code),TRUE,FALSE );
  SELF.SNAMEWeight := IF ( isLeftWinner(le.SNAMEWeight,ri.SNAMEWeight,le.SNAME_match_code,ri.SNAME_match_code ), le.SNAMEWeight, ri.SNAMEWeight );
  SELF.SNAME := IF ( isLeftWinner(le.SNAMEWeight,ri.SNAMEWeight,le.SNAME_match_code,ri.SNAME_match_code ), le.SNAME, ri.SNAME );
  SELF.SNAME_match_code := IF ( isLeftWinner(le.SNAMEWeight,ri.SNAMEWeight,le.SNAME_match_code,ri.SNAME_match_code ), le.SNAME_match_code, ri.SNAME_match_code );
  BOOLEAN FNAMEWeightForcedDown := IF ( isWeightForcedDown(le.FNAMEWeight,ri.FNAMEWeight,le.FNAME_match_code,ri.FNAME_match_code),TRUE,FALSE );
  SELF.FNAMEWeight := IF ( isLeftWinner(le.FNAMEWeight,ri.FNAMEWeight,le.FNAME_match_code,ri.FNAME_match_code ), le.FNAMEWeight, ri.FNAMEWeight );
  SELF.FNAME := IF ( isLeftWinner(le.FNAMEWeight,ri.FNAMEWeight,le.FNAME_match_code,ri.FNAME_match_code ), le.FNAME, ri.FNAME );
  SELF.FNAME_match_code := IF ( isLeftWinner(le.FNAMEWeight,ri.FNAMEWeight,le.FNAME_match_code,ri.FNAME_match_code ), le.FNAME_match_code, ri.FNAME_match_code );
  BOOLEAN MNAMEWeightForcedDown := IF ( isWeightForcedDown(le.MNAMEWeight,ri.MNAMEWeight,le.MNAME_match_code,ri.MNAME_match_code),TRUE,FALSE );
  SELF.MNAMEWeight := IF ( isLeftWinner(le.MNAMEWeight,ri.MNAMEWeight,le.MNAME_match_code,ri.MNAME_match_code ), le.MNAMEWeight, ri.MNAMEWeight );
  SELF.MNAME := IF ( isLeftWinner(le.MNAMEWeight,ri.MNAMEWeight,le.MNAME_match_code,ri.MNAME_match_code ), le.MNAME, ri.MNAME );
  SELF.MNAME_match_code := IF ( isLeftWinner(le.MNAMEWeight,ri.MNAMEWeight,le.MNAME_match_code,ri.MNAME_match_code ), le.MNAME_match_code, ri.MNAME_match_code );
  BOOLEAN LNAMEWeightForcedDown := IF ( isWeightForcedDown(le.LNAMEWeight,ri.LNAMEWeight,le.LNAME_match_code,ri.LNAME_match_code),TRUE,FALSE );
  SELF.LNAMEWeight := IF ( isLeftWinner(le.LNAMEWeight,ri.LNAMEWeight,le.LNAME_match_code,ri.LNAME_match_code ), le.LNAMEWeight, ri.LNAMEWeight );
  SELF.LNAME := IF ( isLeftWinner(le.LNAMEWeight,ri.LNAMEWeight,le.LNAME_match_code,ri.LNAME_match_code ), le.LNAME, ri.LNAME );
  SELF.LNAME_match_code := IF ( isLeftWinner(le.LNAMEWeight,ri.LNAMEWeight,le.LNAME_match_code,ri.LNAME_match_code ), le.LNAME_match_code, ri.LNAME_match_code );
  BOOLEAN DERIVED_GENDERWeightForcedDown := IF ( isWeightForcedDown(le.DERIVED_GENDERWeight,ri.DERIVED_GENDERWeight,le.DERIVED_GENDER_match_code,ri.DERIVED_GENDER_match_code),TRUE,FALSE );
  SELF.DERIVED_GENDERWeight := IF ( isLeftWinner(le.DERIVED_GENDERWeight,ri.DERIVED_GENDERWeight,le.DERIVED_GENDER_match_code,ri.DERIVED_GENDER_match_code ), le.DERIVED_GENDERWeight, ri.DERIVED_GENDERWeight );
  SELF.DERIVED_GENDER := IF ( isLeftWinner(le.DERIVED_GENDERWeight,ri.DERIVED_GENDERWeight,le.DERIVED_GENDER_match_code,ri.DERIVED_GENDER_match_code ), le.DERIVED_GENDER, ri.DERIVED_GENDER );
  SELF.DERIVED_GENDER_match_code := IF ( isLeftWinner(le.DERIVED_GENDERWeight,ri.DERIVED_GENDERWeight,le.DERIVED_GENDER_match_code,ri.DERIVED_GENDER_match_code ), le.DERIVED_GENDER_match_code, ri.DERIVED_GENDER_match_code );
  BOOLEAN PRIM_RANGEWeightForcedDown := IF ( isWeightForcedDown(le.PRIM_RANGEWeight,ri.PRIM_RANGEWeight,le.PRIM_RANGE_match_code,ri.PRIM_RANGE_match_code),TRUE,FALSE );
  SELF.PRIM_RANGEWeight := IF ( isLeftWinner(le.PRIM_RANGEWeight,ri.PRIM_RANGEWeight,le.PRIM_RANGE_match_code,ri.PRIM_RANGE_match_code ), le.PRIM_RANGEWeight, ri.PRIM_RANGEWeight );
  SELF.PRIM_RANGE := IF ( isLeftWinner(le.PRIM_RANGEWeight,ri.PRIM_RANGEWeight,le.PRIM_RANGE_match_code,ri.PRIM_RANGE_match_code ), le.PRIM_RANGE, ri.PRIM_RANGE );
  SELF.PRIM_RANGE_match_code := IF ( isLeftWinner(le.PRIM_RANGEWeight,ri.PRIM_RANGEWeight,le.PRIM_RANGE_match_code,ri.PRIM_RANGE_match_code ), le.PRIM_RANGE_match_code, ri.PRIM_RANGE_match_code );
  BOOLEAN PRIM_NAMEWeightForcedDown := IF ( isWeightForcedDown(le.PRIM_NAMEWeight,ri.PRIM_NAMEWeight,le.PRIM_NAME_match_code,ri.PRIM_NAME_match_code),TRUE,FALSE );
  SELF.PRIM_NAMEWeight := IF ( isLeftWinner(le.PRIM_NAMEWeight,ri.PRIM_NAMEWeight,le.PRIM_NAME_match_code,ri.PRIM_NAME_match_code ), le.PRIM_NAMEWeight, ri.PRIM_NAMEWeight );
  SELF.PRIM_NAME := IF ( isLeftWinner(le.PRIM_NAMEWeight,ri.PRIM_NAMEWeight,le.PRIM_NAME_match_code,ri.PRIM_NAME_match_code ), le.PRIM_NAME, ri.PRIM_NAME );
  SELF.PRIM_NAME_match_code := IF ( isLeftWinner(le.PRIM_NAMEWeight,ri.PRIM_NAMEWeight,le.PRIM_NAME_match_code,ri.PRIM_NAME_match_code ), le.PRIM_NAME_match_code, ri.PRIM_NAME_match_code );
  BOOLEAN SEC_RANGEWeightForcedDown := IF ( isWeightForcedDown(le.SEC_RANGEWeight,ri.SEC_RANGEWeight,le.SEC_RANGE_match_code,ri.SEC_RANGE_match_code),TRUE,FALSE );
  SELF.SEC_RANGEWeight := IF ( isLeftWinner(le.SEC_RANGEWeight,ri.SEC_RANGEWeight,le.SEC_RANGE_match_code,ri.SEC_RANGE_match_code ), le.SEC_RANGEWeight, ri.SEC_RANGEWeight );
  SELF.SEC_RANGE := IF ( isLeftWinner(le.SEC_RANGEWeight,ri.SEC_RANGEWeight,le.SEC_RANGE_match_code,ri.SEC_RANGE_match_code ), le.SEC_RANGE, ri.SEC_RANGE );
  SELF.SEC_RANGE_match_code := IF ( isLeftWinner(le.SEC_RANGEWeight,ri.SEC_RANGEWeight,le.SEC_RANGE_match_code,ri.SEC_RANGE_match_code ), le.SEC_RANGE_match_code, ri.SEC_RANGE_match_code );
  BOOLEAN CITYWeightForcedDown := IF ( isWeightForcedDown(le.CITYWeight,ri.CITYWeight,le.CITY_match_code,ri.CITY_match_code),TRUE,FALSE );
  SELF.CITYWeight := IF ( isLeftWinner(le.CITYWeight,ri.CITYWeight,le.CITY_match_code,ri.CITY_match_code ), le.CITYWeight, ri.CITYWeight );
  SELF.CITY := IF ( isLeftWinner(le.CITYWeight,ri.CITYWeight,le.CITY_match_code,ri.CITY_match_code ), le.CITY, ri.CITY );
  SELF.CITY_match_code := IF ( isLeftWinner(le.CITYWeight,ri.CITYWeight,le.CITY_match_code,ri.CITY_match_code ), le.CITY_match_code, ri.CITY_match_code );
  BOOLEAN STWeightForcedDown := IF ( isWeightForcedDown(le.STWeight,ri.STWeight,le.ST_match_code,ri.ST_match_code),TRUE,FALSE );
  SELF.STWeight := IF ( isLeftWinner(le.STWeight,ri.STWeight,le.ST_match_code,ri.ST_match_code ), le.STWeight, ri.STWeight );
  SELF.ST := IF ( isLeftWinner(le.STWeight,ri.STWeight,le.ST_match_code,ri.ST_match_code ), le.ST, ri.ST );
  SELF.ST_match_code := IF ( isLeftWinner(le.STWeight,ri.STWeight,le.ST_match_code,ri.ST_match_code ), le.ST_match_code, ri.ST_match_code );
  SELF.ZIP_cases := le.ZIP_cases + ri.ZIP_cases; //le.ZIP_cases; // DEDUP(SORT(le.ZIP_cases + ri.ZIP_cases, ZIP,-weight ),ZIP);
  SELF.ZIPWeight := MAX(SELF.ZIP_cases,weight); // KEEP(1) means you can take the maximum value
  SELF.ZIP_match_code := IF ( isLeftWinner(le.ZIPWeight,ri.ZIPWeight,le.ZIP_match_code,ri.ZIP_match_code ), le.ZIP_match_code, ri.ZIP_match_code );
  BOOLEAN SSN5WeightForcedDown := IF ( isWeightForcedDown(le.SSN5Weight,ri.SSN5Weight,le.SSN5_match_code,ri.SSN5_match_code),TRUE,FALSE );
  SELF.SSN5Weight := IF ( isLeftWinner(le.SSN5Weight,ri.SSN5Weight,le.SSN5_match_code,ri.SSN5_match_code ), le.SSN5Weight, ri.SSN5Weight );
  SELF.SSN5 := IF ( isLeftWinner(le.SSN5Weight,ri.SSN5Weight,le.SSN5_match_code,ri.SSN5_match_code ), le.SSN5, ri.SSN5 );
  SELF.SSN5_match_code := IF ( isLeftWinner(le.SSN5Weight,ri.SSN5Weight,le.SSN5_match_code,ri.SSN5_match_code ), le.SSN5_match_code, ri.SSN5_match_code );
  BOOLEAN SSN4WeightForcedDown := IF ( isWeightForcedDown(le.SSN4Weight,ri.SSN4Weight,le.SSN4_match_code,ri.SSN4_match_code),TRUE,FALSE );
  SELF.SSN4Weight := IF ( isLeftWinner(le.SSN4Weight,ri.SSN4Weight,le.SSN4_match_code,ri.SSN4_match_code ), le.SSN4Weight, ri.SSN4Weight );
  SELF.SSN4 := IF ( isLeftWinner(le.SSN4Weight,ri.SSN4Weight,le.SSN4_match_code,ri.SSN4_match_code ), le.SSN4, ri.SSN4 );
  SELF.SSN4_match_code := IF ( isLeftWinner(le.SSN4Weight,ri.SSN4Weight,le.SSN4_match_code,ri.SSN4_match_code ), le.SSN4_match_code, ri.SSN4_match_code );
  BOOLEAN DOBWeightForcedDown_year := IF ( isWeightForcedDown(le.DOBWeight_year,ri.DOBWeight_year,le.DOB_year_match_code,ri.DOB_year_match_code),true,false );
  SELF.DOBWeight_year := IF ( isLeftWinner( le.DOBWeight_year, ri.DOBWeight_year,le.DOB_year_match_code,ri.DOB_year_match_code), le.DOBWeight_year, ri.DOBWeight_year );
  SELF.DOB_year := IF ( isLeftWinner( le.DOBWeight_year, ri.DOBWeight_year,le.DOB_year_match_code,ri.DOB_year_match_code), le.DOB_year, ri.DOB_year );
  SELF.DOB_year_match_code := IF ( isLeftWinner(le.DOBWeight_year,ri.DOBWeight_year,le.DOB_year_match_code,ri.DOB_year_match_code), le.DOB_year_match_code, ri.DOB_year_match_code );
  BOOLEAN DOBWeightForcedDown_month := IF ( isWeightForcedDown(le.DOBWeight_month,ri.DOBWeight_month,le.DOB_month_match_code,ri.DOB_month_match_code),true,false );
  SELF.DOBWeight_month := IF ( isLeftWinner( le.DOBWeight_month, ri.DOBWeight_month,le.DOB_month_match_code,ri.DOB_month_match_code), le.DOBWeight_month, ri.DOBWeight_month );
  SELF.DOB_month := IF ( isLeftWinner( le.DOBWeight_month, ri.DOBWeight_month,le.DOB_month_match_code,ri.DOB_month_match_code), le.DOB_month, ri.DOB_month );
  SELF.DOB_month_match_code := IF ( isLeftWinner(le.DOBWeight_month,ri.DOBWeight_month,le.DOB_month_match_code,ri.DOB_month_match_code), le.DOB_month_match_code, ri.DOB_month_match_code );
  BOOLEAN DOBWeightForcedDown_day := IF ( isWeightForcedDown(le.DOBWeight_day,ri.DOBWeight_day,le.DOB_day_match_code,ri.DOB_day_match_code),true,false );
  SELF.DOBWeight_day := IF ( isLeftWinner( le.DOBWeight_day, ri.DOBWeight_day,le.DOB_day_match_code,ri.DOB_day_match_code), le.DOBWeight_day, ri.DOBWeight_day );
  SELF.DOB_day := IF ( isLeftWinner( le.DOBWeight_day, ri.DOBWeight_day,le.DOB_day_match_code,ri.DOB_day_match_code), le.DOB_day, ri.DOB_day );
  SELF.DOB_day_match_code := IF ( isLeftWinner(le.DOBWeight_day,ri.DOBWeight_day,le.DOB_day_match_code,ri.DOB_day_match_code), le.DOB_day_match_code, ri.DOB_day_match_code );
  SELF.DOBWeight :=  SELF.DOBWeight_year+SELF.DOBWeight_month+SELF.DOBWeight_day;
  BOOLEAN DOBWeightForcedDown :=  DOBWeightForcedDown_year OR DOBWeightForcedDown_month OR DOBWeightForcedDown_day;
  SELF.DOB_match_code := IF ( isLeftWinner(le.DOBWeight,ri.DOBWeight,le.DOB_match_code,ri.DOB_match_code), le.DOB_match_code, ri.DOB_match_code );
  BOOLEAN PHONEWeightForcedDown := IF ( isWeightForcedDown(le.PHONEWeight,ri.PHONEWeight,le.PHONE_match_code,ri.PHONE_match_code),TRUE,FALSE );
  SELF.PHONEWeight := IF ( isLeftWinner(le.PHONEWeight,ri.PHONEWeight,le.PHONE_match_code,ri.PHONE_match_code ), le.PHONEWeight, ri.PHONEWeight );
  SELF.PHONE := IF ( isLeftWinner(le.PHONEWeight,ri.PHONEWeight,le.PHONE_match_code,ri.PHONE_match_code ), le.PHONE, ri.PHONE );
  SELF.PHONE_match_code := IF ( isLeftWinner(le.PHONEWeight,ri.PHONEWeight,le.PHONE_match_code,ri.PHONE_match_code ), le.PHONE_match_code, ri.PHONE_match_code );
  BOOLEAN DL_STATEWeightForcedDown := IF ( isWeightForcedDown(le.DL_STATEWeight,ri.DL_STATEWeight,le.DL_STATE_match_code,ri.DL_STATE_match_code),TRUE,FALSE );
  SELF.DL_STATEWeight := IF ( isLeftWinner(le.DL_STATEWeight,ri.DL_STATEWeight,le.DL_STATE_match_code,ri.DL_STATE_match_code ), le.DL_STATEWeight, ri.DL_STATEWeight );
  SELF.DL_STATE := IF ( isLeftWinner(le.DL_STATEWeight,ri.DL_STATEWeight,le.DL_STATE_match_code,ri.DL_STATE_match_code ), le.DL_STATE, ri.DL_STATE );
  SELF.DL_STATE_match_code := IF ( isLeftWinner(le.DL_STATEWeight,ri.DL_STATEWeight,le.DL_STATE_match_code,ri.DL_STATE_match_code ), le.DL_STATE_match_code, ri.DL_STATE_match_code );
  BOOLEAN DL_NBRWeightForcedDown := IF ( isWeightForcedDown(le.DL_NBRWeight,ri.DL_NBRWeight,le.DL_NBR_match_code,ri.DL_NBR_match_code),TRUE,FALSE );
  SELF.DL_NBRWeight := IF ( isLeftWinner(le.DL_NBRWeight,ri.DL_NBRWeight,le.DL_NBR_match_code,ri.DL_NBR_match_code ), le.DL_NBRWeight, ri.DL_NBRWeight );
  SELF.DL_NBR := IF ( isLeftWinner(le.DL_NBRWeight,ri.DL_NBRWeight,le.DL_NBR_match_code,ri.DL_NBR_match_code ), le.DL_NBR, ri.DL_NBR );
  SELF.DL_NBR_match_code := IF ( isLeftWinner(le.DL_NBRWeight,ri.DL_NBRWeight,le.DL_NBR_match_code,ri.DL_NBR_match_code ), le.DL_NBR_match_code, ri.DL_NBR_match_code );
  BOOLEAN SRCWeightForcedDown := IF ( isWeightForcedDown(le.SRCWeight,ri.SRCWeight,le.SRC_match_code,ri.SRC_match_code),TRUE,FALSE );
  SELF.SRCWeight := IF ( isLeftWinner(le.SRCWeight,ri.SRCWeight,le.SRC_match_code,ri.SRC_match_code ), le.SRCWeight, ri.SRCWeight );
  SELF.SRC := IF ( isLeftWinner(le.SRCWeight,ri.SRCWeight,le.SRC_match_code,ri.SRC_match_code ), le.SRC, ri.SRC );
  SELF.SRC_match_code := IF ( isLeftWinner(le.SRCWeight,ri.SRCWeight,le.SRC_match_code,ri.SRC_match_code ), le.SRC_match_code, ri.SRC_match_code );
  BOOLEAN SOURCE_RIDWeightForcedDown := IF ( isWeightForcedDown(le.SOURCE_RIDWeight,ri.SOURCE_RIDWeight,le.SOURCE_RID_match_code,ri.SOURCE_RID_match_code),TRUE,FALSE );
  SELF.SOURCE_RIDWeight := IF ( isLeftWinner(le.SOURCE_RIDWeight,ri.SOURCE_RIDWeight,le.SOURCE_RID_match_code,ri.SOURCE_RID_match_code ), le.SOURCE_RIDWeight, ri.SOURCE_RIDWeight );
  SELF.SOURCE_RID := IF ( isLeftWinner(le.SOURCE_RIDWeight,ri.SOURCE_RIDWeight,le.SOURCE_RID_match_code,ri.SOURCE_RID_match_code ), le.SOURCE_RID, ri.SOURCE_RID );
  SELF.SOURCE_RID_match_code := IF ( isLeftWinner(le.SOURCE_RIDWeight,ri.SOURCE_RIDWeight,le.SOURCE_RID_match_code,ri.SOURCE_RID_match_code ), le.SOURCE_RID_match_code, ri.SOURCE_RID_match_code );
  BOOLEAN DT_FIRST_SEENWeightForcedDown := IF ( isWeightForcedDown(le.DT_FIRST_SEENWeight,ri.DT_FIRST_SEENWeight,le.DT_FIRST_SEEN_match_code,ri.DT_FIRST_SEEN_match_code),TRUE,FALSE );
  SELF.DT_FIRST_SEENWeight := IF ( isLeftWinner(le.DT_FIRST_SEENWeight,ri.DT_FIRST_SEENWeight,le.DT_FIRST_SEEN_match_code,ri.DT_FIRST_SEEN_match_code ), le.DT_FIRST_SEENWeight, ri.DT_FIRST_SEENWeight );
  SELF.DT_FIRST_SEEN := IF ( isLeftWinner(le.DT_FIRST_SEENWeight,ri.DT_FIRST_SEENWeight,le.DT_FIRST_SEEN_match_code,ri.DT_FIRST_SEEN_match_code ), le.DT_FIRST_SEEN, ri.DT_FIRST_SEEN );
  SELF.DT_FIRST_SEEN_match_code := IF ( isLeftWinner(le.DT_FIRST_SEENWeight,ri.DT_FIRST_SEENWeight,le.DT_FIRST_SEEN_match_code,ri.DT_FIRST_SEEN_match_code ), le.DT_FIRST_SEEN_match_code, ri.DT_FIRST_SEEN_match_code );
  BOOLEAN DT_LAST_SEENWeightForcedDown := IF ( isWeightForcedDown(le.DT_LAST_SEENWeight,ri.DT_LAST_SEENWeight,le.DT_LAST_SEEN_match_code,ri.DT_LAST_SEEN_match_code),TRUE,FALSE );
  SELF.DT_LAST_SEENWeight := IF ( isLeftWinner(le.DT_LAST_SEENWeight,ri.DT_LAST_SEENWeight,le.DT_LAST_SEEN_match_code,ri.DT_LAST_SEEN_match_code ), le.DT_LAST_SEENWeight, ri.DT_LAST_SEENWeight );
  SELF.DT_LAST_SEEN := IF ( isLeftWinner(le.DT_LAST_SEENWeight,ri.DT_LAST_SEENWeight,le.DT_LAST_SEEN_match_code,ri.DT_LAST_SEEN_match_code ), le.DT_LAST_SEEN, ri.DT_LAST_SEEN );
  SELF.DT_LAST_SEEN_match_code := IF ( isLeftWinner(le.DT_LAST_SEENWeight,ri.DT_LAST_SEENWeight,le.DT_LAST_SEEN_match_code,ri.DT_LAST_SEEN_match_code ), le.DT_LAST_SEEN_match_code, ri.DT_LAST_SEEN_match_code );
  BOOLEAN DT_EFFECTIVE_FIRSTWeightForcedDown := IF ( isWeightForcedDown(le.DT_EFFECTIVE_FIRSTWeight,ri.DT_EFFECTIVE_FIRSTWeight,le.DT_EFFECTIVE_FIRST_match_code,ri.DT_EFFECTIVE_FIRST_match_code),TRUE,FALSE );
  SELF.DT_EFFECTIVE_FIRSTWeight := IF ( isLeftWinner(le.DT_EFFECTIVE_FIRSTWeight,ri.DT_EFFECTIVE_FIRSTWeight,le.DT_EFFECTIVE_FIRST_match_code,ri.DT_EFFECTIVE_FIRST_match_code ), le.DT_EFFECTIVE_FIRSTWeight, ri.DT_EFFECTIVE_FIRSTWeight );
  SELF.DT_EFFECTIVE_FIRST := IF ( isLeftWinner(le.DT_EFFECTIVE_FIRSTWeight,ri.DT_EFFECTIVE_FIRSTWeight,le.DT_EFFECTIVE_FIRST_match_code,ri.DT_EFFECTIVE_FIRST_match_code ), le.DT_EFFECTIVE_FIRST, ri.DT_EFFECTIVE_FIRST );
  SELF.DT_EFFECTIVE_FIRST_match_code := IF ( isLeftWinner(le.DT_EFFECTIVE_FIRSTWeight,ri.DT_EFFECTIVE_FIRSTWeight,le.DT_EFFECTIVE_FIRST_match_code,ri.DT_EFFECTIVE_FIRST_match_code ), le.DT_EFFECTIVE_FIRST_match_code, ri.DT_EFFECTIVE_FIRST_match_code );
  BOOLEAN DT_EFFECTIVE_LASTWeightForcedDown := IF ( isWeightForcedDown(le.DT_EFFECTIVE_LASTWeight,ri.DT_EFFECTIVE_LASTWeight,le.DT_EFFECTIVE_LAST_match_code,ri.DT_EFFECTIVE_LAST_match_code),TRUE,FALSE );
  SELF.DT_EFFECTIVE_LASTWeight := IF ( isLeftWinner(le.DT_EFFECTIVE_LASTWeight,ri.DT_EFFECTIVE_LASTWeight,le.DT_EFFECTIVE_LAST_match_code,ri.DT_EFFECTIVE_LAST_match_code ), le.DT_EFFECTIVE_LASTWeight, ri.DT_EFFECTIVE_LASTWeight );
  SELF.DT_EFFECTIVE_LAST := IF ( isLeftWinner(le.DT_EFFECTIVE_LASTWeight,ri.DT_EFFECTIVE_LASTWeight,le.DT_EFFECTIVE_LAST_match_code,ri.DT_EFFECTIVE_LAST_match_code ), le.DT_EFFECTIVE_LAST, ri.DT_EFFECTIVE_LAST );
  SELF.DT_EFFECTIVE_LAST_match_code := IF ( isLeftWinner(le.DT_EFFECTIVE_LASTWeight,ri.DT_EFFECTIVE_LASTWeight,le.DT_EFFECTIVE_LAST_match_code,ri.DT_EFFECTIVE_LAST_match_code ), le.DT_EFFECTIVE_LAST_match_code, ri.DT_EFFECTIVE_LAST_match_code );
  BOOLEAN DirectMAINNAMEWeightForcedDown := IF ( isWeightForcedDown(le.MAINNAMEWeight,ri.MAINNAMEWeight,le.MAINNAME_match_code,ri.MAINNAME_match_code),TRUE,FALSE );
  BOOLEAN MAINNAMEWeightForcedDown := FNAMEWeightForcedDown OR MNAMEWeightForcedDown OR LNAMEWeightForcedDown;
  SELF.MAINNAMEWeight := MAP (
      DirectMAINNAMEWeightForcedDown => IF ( isLeftWinner(le.MAINNAMEWeight,ri.MAINNAMEWeight,le.MAINNAME_match_code,ri.MAINNAME_match_code ), le.MAINNAMEWeight, ri.MAINNAMEWeight ),
      MAINNAMEWeightForcedDown AND (le.MAINNAME_match_code = ri.MAINNAME_match_code) => MIN(le.MAINNAMEWeight, ri.MAINNAMEWeight),
      IF ( isLeftWinner(le.MAINNAMEWeight,ri.MAINNAMEWeight,le.MAINNAME_match_code,ri.MAINNAME_match_code ), le.MAINNAMEWeight, ri.MAINNAMEWeight ));
  SELF.MAINNAME_match_code :=  MAP (
      DirectMAINNAMEWeightForcedDown => IF ( isLeftWinner(le.MAINNAMEWeight,ri.MAINNAMEWeight,le.MAINNAME_match_code,ri.MAINNAME_match_code ), le.MAINNAME_match_code, ri.MAINNAME_match_code ),
      MAINNAMEWeightForcedDown AND (le.MAINNAME_match_code = ri.MAINNAME_match_code) AND MIN(le.MAINNAMEWeight, ri.MAINNAMEWeight)=le.MAINNAMEWeight => le.MAINNAME_match_code,
      MAINNAMEWeightForcedDown AND (le.MAINNAME_match_code = ri.MAINNAME_match_code) AND MIN(le.MAINNAMEWeight, ri.MAINNAMEWeight)=ri.MAINNAMEWeight => ri.MAINNAME_match_code,
      IF ( isLeftWinner(le.MAINNAMEWeight,ri.MAINNAMEWeight,le.MAINNAME_match_code,ri.MAINNAME_match_code ), le.MAINNAME_match_code, ri.MAINNAME_match_code ));
  BOOLEAN DirectFULLNAMEWeightForcedDown := IF ( isWeightForcedDown(le.FULLNAMEWeight,ri.FULLNAMEWeight,le.FULLNAME_match_code,ri.FULLNAME_match_code),TRUE,FALSE );
  BOOLEAN FULLNAMEWeightForcedDown := MAINNAMEWeightForcedDown OR SNAMEWeightForcedDown;
  SELF.FULLNAMEWeight := MAP (
      DirectFULLNAMEWeightForcedDown => IF ( isLeftWinner(le.FULLNAMEWeight,ri.FULLNAMEWeight,le.FULLNAME_match_code,ri.FULLNAME_match_code ), le.FULLNAMEWeight, ri.FULLNAMEWeight ),
      FULLNAMEWeightForcedDown AND (le.FULLNAME_match_code = ri.FULLNAME_match_code) => MIN(le.FULLNAMEWeight, ri.FULLNAMEWeight),
      IF ( isLeftWinner(le.FULLNAMEWeight,ri.FULLNAMEWeight,le.FULLNAME_match_code,ri.FULLNAME_match_code ), le.FULLNAMEWeight, ri.FULLNAMEWeight ));
  SELF.FULLNAME_match_code :=  MAP (
      DirectFULLNAMEWeightForcedDown => IF ( isLeftWinner(le.FULLNAMEWeight,ri.FULLNAMEWeight,le.FULLNAME_match_code,ri.FULLNAME_match_code ), le.FULLNAME_match_code, ri.FULLNAME_match_code ),
      FULLNAMEWeightForcedDown AND (le.FULLNAME_match_code = ri.FULLNAME_match_code) AND MIN(le.FULLNAMEWeight, ri.FULLNAMEWeight)=le.FULLNAMEWeight => le.FULLNAME_match_code,
      FULLNAMEWeightForcedDown AND (le.FULLNAME_match_code = ri.FULLNAME_match_code) AND MIN(le.FULLNAMEWeight, ri.FULLNAMEWeight)=ri.FULLNAMEWeight => ri.FULLNAME_match_code,
      IF ( isLeftWinner(le.FULLNAMEWeight,ri.FULLNAMEWeight,le.FULLNAME_match_code,ri.FULLNAME_match_code ), le.FULLNAME_match_code, ri.FULLNAME_match_code ));
  BOOLEAN DirectADDR1WeightForcedDown := IF ( isWeightForcedDown(le.ADDR1Weight,ri.ADDR1Weight,le.ADDR1_match_code,ri.ADDR1_match_code),TRUE,FALSE );
  BOOLEAN ADDR1WeightForcedDown := PRIM_RANGEWeightForcedDown OR SEC_RANGEWeightForcedDown OR PRIM_NAMEWeightForcedDown;
  SELF.ADDR1Weight := MAP (
      DirectADDR1WeightForcedDown => IF ( isLeftWinner(le.ADDR1Weight,ri.ADDR1Weight,le.ADDR1_match_code,ri.ADDR1_match_code ), le.ADDR1Weight, ri.ADDR1Weight ),
      ADDR1WeightForcedDown AND (le.ADDR1_match_code = ri.ADDR1_match_code) => MIN(le.ADDR1Weight, ri.ADDR1Weight),
      IF ( isLeftWinner(le.ADDR1Weight,ri.ADDR1Weight,le.ADDR1_match_code,ri.ADDR1_match_code ), le.ADDR1Weight, ri.ADDR1Weight ));
  SELF.ADDR1_match_code :=  MAP (
      DirectADDR1WeightForcedDown => IF ( isLeftWinner(le.ADDR1Weight,ri.ADDR1Weight,le.ADDR1_match_code,ri.ADDR1_match_code ), le.ADDR1_match_code, ri.ADDR1_match_code ),
      ADDR1WeightForcedDown AND (le.ADDR1_match_code = ri.ADDR1_match_code) AND MIN(le.ADDR1Weight, ri.ADDR1Weight)=le.ADDR1Weight => le.ADDR1_match_code,
      ADDR1WeightForcedDown AND (le.ADDR1_match_code = ri.ADDR1_match_code) AND MIN(le.ADDR1Weight, ri.ADDR1Weight)=ri.ADDR1Weight => ri.ADDR1_match_code,
      IF ( isLeftWinner(le.ADDR1Weight,ri.ADDR1Weight,le.ADDR1_match_code,ri.ADDR1_match_code ), le.ADDR1_match_code, ri.ADDR1_match_code ));
  BOOLEAN DirectLOCALEWeightForcedDown := IF ( isWeightForcedDown(le.LOCALEWeight,ri.LOCALEWeight,le.LOCALE_match_code,ri.LOCALE_match_code),TRUE,FALSE );
  BOOLEAN LOCALEWeightForcedDown := CITYWeightForcedDown OR STWeightForcedDown;
  SELF.LOCALEWeight := MAP (
      DirectLOCALEWeightForcedDown => IF ( isLeftWinner(le.LOCALEWeight,ri.LOCALEWeight,le.LOCALE_match_code,ri.LOCALE_match_code ), le.LOCALEWeight, ri.LOCALEWeight ),
      LOCALEWeightForcedDown AND (le.LOCALE_match_code = ri.LOCALE_match_code) => MIN(le.LOCALEWeight, ri.LOCALEWeight),
      IF ( isLeftWinner(le.LOCALEWeight,ri.LOCALEWeight,le.LOCALE_match_code,ri.LOCALE_match_code ), le.LOCALEWeight, ri.LOCALEWeight ));
  SELF.LOCALE_match_code :=  MAP (
      DirectLOCALEWeightForcedDown => IF ( isLeftWinner(le.LOCALEWeight,ri.LOCALEWeight,le.LOCALE_match_code,ri.LOCALE_match_code ), le.LOCALE_match_code, ri.LOCALE_match_code ),
      LOCALEWeightForcedDown AND (le.LOCALE_match_code = ri.LOCALE_match_code) AND MIN(le.LOCALEWeight, ri.LOCALEWeight)=le.LOCALEWeight => le.LOCALE_match_code,
      LOCALEWeightForcedDown AND (le.LOCALE_match_code = ri.LOCALE_match_code) AND MIN(le.LOCALEWeight, ri.LOCALEWeight)=ri.LOCALEWeight => ri.LOCALE_match_code,
      IF ( isLeftWinner(le.LOCALEWeight,ri.LOCALEWeight,le.LOCALE_match_code,ri.LOCALE_match_code ), le.LOCALE_match_code, ri.LOCALE_match_code ));
  BOOLEAN DirectADDRESSWeightForcedDown := IF ( isWeightForcedDown(le.ADDRESSWeight,ri.ADDRESSWeight,le.ADDRESS_match_code,ri.ADDRESS_match_code),TRUE,FALSE );
  BOOLEAN ADDRESSWeightForcedDown := ADDR1WeightForcedDown OR LOCALEWeightForcedDown;
  SELF.ADDRESSWeight := MAP (
      DirectADDRESSWeightForcedDown => IF ( isLeftWinner(le.ADDRESSWeight,ri.ADDRESSWeight,le.ADDRESS_match_code,ri.ADDRESS_match_code ), le.ADDRESSWeight, ri.ADDRESSWeight ),
      ADDRESSWeightForcedDown AND (le.ADDRESS_match_code = ri.ADDRESS_match_code) => MIN(le.ADDRESSWeight, ri.ADDRESSWeight),
      IF ( isLeftWinner(le.ADDRESSWeight,ri.ADDRESSWeight,le.ADDRESS_match_code,ri.ADDRESS_match_code ), le.ADDRESSWeight, ri.ADDRESSWeight ));
  SELF.ADDRESS_match_code :=  MAP (
      DirectADDRESSWeightForcedDown => IF ( isLeftWinner(le.ADDRESSWeight,ri.ADDRESSWeight,le.ADDRESS_match_code,ri.ADDRESS_match_code ), le.ADDRESS_match_code, ri.ADDRESS_match_code ),
      ADDRESSWeightForcedDown AND (le.ADDRESS_match_code = ri.ADDRESS_match_code) AND MIN(le.ADDRESSWeight, ri.ADDRESSWeight)=le.ADDRESSWeight => le.ADDRESS_match_code,
      ADDRESSWeightForcedDown AND (le.ADDRESS_match_code = ri.ADDRESS_match_code) AND MIN(le.ADDRESSWeight, ri.ADDRESSWeight)=ri.ADDRESSWeight => ri.ADDRESS_match_code,
      IF ( isLeftWinner(le.ADDRESSWeight,ri.ADDRESSWeight,le.ADDRESS_match_code,ri.ADDRESS_match_code ), le.ADDRESS_match_code, ri.ADDRESS_match_code ));
  BOOLEAN fname2WeightForcedDown := IF ( isWeightForcedDown(le.fname2Weight,ri.fname2Weight,le.fname2_match_code,ri.fname2_match_code),TRUE,FALSE );
  SELF.fname2Weight := IF ( isLeftWinner(le.fname2Weight,ri.fname2Weight,le.fname2_match_code,ri.fname2_match_code ), le.fname2Weight, ri.fname2Weight );
  SELF.fname2 := IF ( isLeftWinner(le.fname2Weight,ri.fname2Weight,le.fname2_match_code,ri.fname2_match_code ), le.fname2, ri.fname2 );
  SELF.fname2_match_code := IF ( isLeftWinner(le.fname2Weight,ri.fname2Weight,le.fname2_match_code,ri.fname2_match_code ), le.fname2_match_code, ri.fname2_match_code );
  BOOLEAN lname2WeightForcedDown := IF ( isWeightForcedDown(le.lname2Weight,ri.lname2Weight,le.lname2_match_code,ri.lname2_match_code),TRUE,FALSE );
  SELF.lname2Weight := IF ( isLeftWinner(le.lname2Weight,ri.lname2Weight,le.lname2_match_code,ri.lname2_match_code ), le.lname2Weight, ri.lname2Weight );
  SELF.lname2 := IF ( isLeftWinner(le.lname2Weight,ri.lname2Weight,le.lname2_match_code,ri.lname2_match_code ), le.lname2, ri.lname2 );
  SELF.lname2_match_code := IF ( isLeftWinner(le.lname2Weight,ri.lname2Weight,le.lname2_match_code,ri.lname2_match_code ), le.lname2_match_code, ri.lname2_match_code );
  SELF.keys_used := le.keys_used | ri.keys_used;
  SELF.keys_failed := le.keys_failed | ri.keys_failed;
  SELF.keys_poisoned := le.keys_poisoned | ri.keys_poisoned;
  SELF.ForceFailed := IF(In_disableForce, FALSE, (((SELF.DOB_match_code = SALT37.MatchCode.GenerationNoMatch) OR (SELF.DOBWeight_year<>0 OR SELF.DOBWeight_month<>0 OR SELF.DOBWeight_day<>0) AND (SELF.DOBWeight_year + SELF.DOBWeight_month + SELF.DOBWeight_day < Config.DOB_Force)) AND (SELF.SSN5Weight=0 OR SELF.SSN5Weight < Config.SSN5_Force) AND (SELF.SSN4Weight=0 OR SELF.SSN4Weight < Config.SSN4_Force)));
  INTEGER2 Weight := MAX(0,SELF.DERIVED_GENDERWeight) + MAX(0,SELF.SSN5Weight) + MAX(0,SELF.SSN4Weight) + MAX(0,SELF.DOBWeight) + MAX(0,SELF.PHONEWeight) + MAX(0,SELF.DL_STATEWeight) + MAX(0,SELF.DL_NBRWeight) + MAX(0,SELF.SRCWeight) + MAX(0,SELF.SOURCE_RIDWeight) + MAX(SELF.MAINNAMEWeight,MAX(0,SELF.FNAMEWeight) + MAX(0,SELF.MNAMEWeight) + MAX(0,SELF.LNAMEWeight)) + MAX(0,SELF.SNAMEWeight) + MAX(0,SELF.PRIM_RANGEWeight) + MAX(0,SELF.SEC_RANGEWeight) + MAX(0,SELF.PRIM_NAMEWeight) + MAX(0,SELF.CITYWeight) + MAX(0,SELF.STWeight) + MAX(0,SELF.ZIPWeight) + MAX(0,SELF.fname2Weight) + MAX(0,SELF.lname2Weight);
  SELF.Weight := IF(Weight>0,Weight,MAX(le.Weight,ri.Weight));
  SELF := le;
END;
 
SHARED OutputLayout_Base := RECORD,MAXLENGTH(32000)
  BOOLEAN Verified := FALSE; // has found possible results
  BOOLEAN Ambiguous := FALSE; // has >= 20 dids within an order of magnitude of best
  BOOLEAN ShortList := FALSE; // has < 20 dids within an order of magnitude of best
  BOOLEAN Handful := FALSE; // has <6 IDs within two orders of magnitude of best
  BOOLEAN IsTruncated := FALSE; // more results available than were returned
  BOOLEAN Resolved := FALSE; // certain with 3 nines of accuracy
  DATASET(LayoutScoredFetch) Results;
  UNSIGNED4 keys_tried := 0;
END;
EXPORT OutputLayout := RECORD(OutputLayout_Base),MAXLENGTH(32000)
  InputLayout;
END;
EXPORT OutputLayout_Batch := RECORD(OutputLayout_Base),MAXLENGTH(32006)
  SALT37.UIDType Reference;
END;
EXPORT MAC_Add_ResolutionFlags() := MACRO
  SELF.Verified := EXISTS(SELF.results);
  SELF.Ambiguous := COUNT(SELF.results(Weight>=MAX(SELF.results,Weight)-1)) >= 20;
  SELF.ShortList := COUNT(SELF.results(Weight>=MAX(SELF.results,Weight)-1)) < 20 AND SELF.verified;
  SELF.Handful := COUNT(SELF.results(Weight>=MAX(SELF.results,Weight)-3)) < 6 AND SELF.verified;
  SELF.Resolved := COUNT(SELF.results(Weight>=MAX(SELF.results,Weight)-5)) = 1;
ENDMACRO;
EXPORT ScoreSummary(DATASET(OutputLayout_Base) ds0) := FUNCTION
  ds := PROJECT(ds0(EXISTS(Results)),TRANSFORM(LayoutScoredFetch,SELF := LEFT.Results[1]));
  R := RECORD
    SALT37.StrType Summary;
  END;
  R tosummary(ds le) := TRANSFORM
    SELF.Summary := IF(le.SNAMEWeight = 0,'','|'+IF(le.SNAMEWeight < 0,'-','')+'SNAME')+IF(le.FNAMEWeight = 0,'','|'+IF(le.FNAMEWeight < 0,'-','')+'FNAME')+IF(le.MNAMEWeight = 0,'','|'+IF(le.MNAMEWeight < 0,'-','')+'MNAME')+IF(le.LNAMEWeight = 0,'','|'+IF(le.LNAMEWeight < 0,'-','')+'LNAME')+IF(le.DERIVED_GENDERWeight = 0,'','|'+IF(le.DERIVED_GENDERWeight < 0,'-','')+'DERIVED_GENDER')+IF(le.PRIM_RANGEWeight = 0,'','|'+IF(le.PRIM_RANGEWeight < 0,'-','')+'PRIM_RANGE')+IF(le.PRIM_NAMEWeight = 0,'','|'+IF(le.PRIM_NAMEWeight < 0,'-','')+'PRIM_NAME')+IF(le.SEC_RANGEWeight = 0,'','|'+IF(le.SEC_RANGEWeight < 0,'-','')+'SEC_RANGE')+IF(le.CITYWeight = 0,'','|'+IF(le.CITYWeight < 0,'-','')+'CITY')+IF(le.STWeight = 0,'','|'+IF(le.STWeight < 0,'-','')+'ST')+IF(le.ZIPWeight = 0,'','|'+IF(le.ZIPWeight < 0,'-','')+'ZIP')+IF(le.SSN5Weight = 0,'','|'+IF(le.SSN5Weight < 0,'-','')+'SSN5')+IF(le.SSN4Weight = 0,'','|'+IF(le.SSN4Weight < 0,'-','')+'SSN4')+IF(le.DOBWeight_year+le.DOBWeight_month+le.DOBWeight_day=0,'','|'+IF(le.DOBWeight_year+le.DOBWeight_month+le.DOBWeight_day<0,'-','')+'DOB')+IF(le.PHONEWeight = 0,'','|'+IF(le.PHONEWeight < 0,'-','')+'PHONE')+IF(le.DL_STATEWeight = 0,'','|'+IF(le.DL_STATEWeight < 0,'-','')+'DL_STATE')+IF(le.DL_NBRWeight = 0,'','|'+IF(le.DL_NBRWeight < 0,'-','')+'DL_NBR')+IF(le.SRCWeight = 0,'','|'+IF(le.SRCWeight < 0,'-','')+'SRC')+IF(le.SOURCE_RIDWeight = 0,'','|'+IF(le.SOURCE_RIDWeight < 0,'-','')+'SOURCE_RID')+IF(le.DT_FIRST_SEENWeight = 0,'','|'+IF(le.DT_FIRST_SEENWeight < 0,'-','')+'DT_FIRST_SEEN')+IF(le.DT_LAST_SEENWeight = 0,'','|'+IF(le.DT_LAST_SEENWeight < 0,'-','')+'DT_LAST_SEEN')+IF(le.DT_EFFECTIVE_FIRSTWeight = 0,'','|'+IF(le.DT_EFFECTIVE_FIRSTWeight < 0,'-','')+'DT_EFFECTIVE_FIRST')+IF(le.DT_EFFECTIVE_LASTWeight = 0,'','|'+IF(le.DT_EFFECTIVE_LASTWeight < 0,'-','')+'DT_EFFECTIVE_LAST')+IF(le.MAINNAMEWeight = 0,'','|'+IF(le.MAINNAMEWeight < 0,'-','')+'MAINNAME')+IF(le.FULLNAMEWeight = 0,'','|'+IF(le.FULLNAMEWeight < 0,'-','')+'FULLNAME')+IF(le.ADDR1Weight = 0,'','|'+IF(le.ADDR1Weight < 0,'-','')+'ADDR1')+IF(le.LOCALEWeight = 0,'','|'+IF(le.LOCALEWeight < 0,'-','')+'LOCALE')+IF(le.ADDRESSWeight = 0,'','|'+IF(le.ADDRESSWeight < 0,'-','')+'ADDRESS')+IF(le.fname2Weight = 0,'','|'+IF(le.fname2Weight < 0,'-','')+'fname2')+IF(le.lname2Weight = 0,'','|'+IF(le.lname2Weight < 0,'-','')+'lname2');
  END;
  P := PROJECT(ds,tosummary(LEFT));
  RETURN SORT(TABLE(P,{Summary, Cnt := COUNT(GROUP)},Summary,FEW),-Cnt);
END;
EXPORT AdjustScoresForNonExactMatches(DATASET(LayoutScoredFetch) in_data) := FUNCTION
 
aggregateRec := RECORD
  in_data.reference;
  SNAMEWeight := MAX(GROUP,IF( in_data.SNAME_match_code=SALT37.MatchCode.ExactMatch, in_data.SNAMEWeight,0 ));
  FNAMEWeight := MAX(GROUP,IF( in_data.FNAME_match_code=SALT37.MatchCode.ExactMatch, in_data.FNAMEWeight,0 ));
  MNAMEWeight := MAX(GROUP,IF( in_data.MNAME_match_code=SALT37.MatchCode.ExactMatch, in_data.MNAMEWeight,0 ));
  LNAMEWeight := MAX(GROUP,IF( in_data.LNAME_match_code=SALT37.MatchCode.ExactMatch, in_data.LNAMEWeight,0 ));
  DERIVED_GENDERWeight := MAX(GROUP,IF( in_data.DERIVED_GENDER_match_code=SALT37.MatchCode.ExactMatch, in_data.DERIVED_GENDERWeight,0 ));
  PRIM_RANGEWeight := MAX(GROUP,IF( in_data.PRIM_RANGE_match_code=SALT37.MatchCode.ExactMatch, in_data.PRIM_RANGEWeight,0 ));
  PRIM_NAMEWeight := MAX(GROUP,IF( in_data.PRIM_NAME_match_code=SALT37.MatchCode.ExactMatch, in_data.PRIM_NAMEWeight,0 ));
  SEC_RANGEWeight := MAX(GROUP,IF( in_data.SEC_RANGE_match_code=SALT37.MatchCode.ExactMatch, in_data.SEC_RANGEWeight,0 ));
  CITYWeight := MAX(GROUP,IF( in_data.CITY_match_code=SALT37.MatchCode.ExactMatch, in_data.CITYWeight,0 ));
  STWeight := MAX(GROUP,IF( in_data.ST_match_code=SALT37.MatchCode.ExactMatch, in_data.STWeight,0 ));
  ZIPWeight := MAX(GROUP,IF( in_data.ZIP_match_code=SALT37.MatchCode.ExactMatch, in_data.ZIPWeight,0 ));
  SSN5Weight := MAX(GROUP,IF( in_data.SSN5_match_code=SALT37.MatchCode.ExactMatch, in_data.SSN5Weight,0 ));
  SSN4Weight := MAX(GROUP,IF( in_data.SSN4_match_code=SALT37.MatchCode.ExactMatch, in_data.SSN4Weight,0 ));
  DOBWeight := MAX(GROUP,IF( in_data.DOB_year_match_code=SALT37.MatchCode.ExactMatch AND in_data.DOB_month_match_code=SALT37.MatchCode.ExactMatch AND in_data.DOB_day_match_code=SALT37.MatchCode.ExactMatch, in_data.DOBWeight,0 ));
  PHONEWeight := MAX(GROUP,IF( in_data.PHONE_match_code=SALT37.MatchCode.ExactMatch, in_data.PHONEWeight,0 ));
  DL_STATEWeight := MAX(GROUP,IF( in_data.DL_STATE_match_code=SALT37.MatchCode.ExactMatch, in_data.DL_STATEWeight,0 ));
  DL_NBRWeight := MAX(GROUP,IF( in_data.DL_NBR_match_code=SALT37.MatchCode.ExactMatch, in_data.DL_NBRWeight,0 ));
  SRCWeight := MAX(GROUP,IF( in_data.SRC_match_code=SALT37.MatchCode.ExactMatch, in_data.SRCWeight,0 ));
  SOURCE_RIDWeight := MAX(GROUP,IF( in_data.SOURCE_RID_match_code=SALT37.MatchCode.ExactMatch, in_data.SOURCE_RIDWeight,0 ));
  DT_FIRST_SEENWeight := MAX(GROUP,IF( in_data.DT_FIRST_SEEN_match_code=SALT37.MatchCode.ExactMatch, in_data.DT_FIRST_SEENWeight,0 ));
  DT_LAST_SEENWeight := MAX(GROUP,IF( in_data.DT_LAST_SEEN_match_code=SALT37.MatchCode.ExactMatch, in_data.DT_LAST_SEENWeight,0 ));
  DT_EFFECTIVE_FIRSTWeight := MAX(GROUP,IF( in_data.DT_EFFECTIVE_FIRST_match_code=SALT37.MatchCode.ExactMatch, in_data.DT_EFFECTIVE_FIRSTWeight,0 ));
  DT_EFFECTIVE_LASTWeight := MAX(GROUP,IF( in_data.DT_EFFECTIVE_LAST_match_code=SALT37.MatchCode.ExactMatch, in_data.DT_EFFECTIVE_LASTWeight,0 ));
  MAINNAMEWeight := MAX(GROUP,IF( in_data.MAINNAME_match_code=SALT37.MatchCode.ExactMatch, in_data.MAINNAMEWeight,0 ));
  FULLNAMEWeight := MAX(GROUP,IF( in_data.FULLNAME_match_code=SALT37.MatchCode.ExactMatch, in_data.FULLNAMEWeight,0 ));
  ADDR1Weight := MAX(GROUP,IF( in_data.ADDR1_match_code=SALT37.MatchCode.ExactMatch, in_data.ADDR1Weight,0 ));
  LOCALEWeight := MAX(GROUP,IF( in_data.LOCALE_match_code=SALT37.MatchCode.ExactMatch, in_data.LOCALEWeight,0 ));
  ADDRESSWeight := MAX(GROUP,IF( in_data.ADDRESS_match_code=SALT37.MatchCode.ExactMatch, in_data.ADDRESSWeight,0 ));
  fname2Weight := MAX(GROUP,IF( in_data.fname2_match_code=SALT37.MatchCode.ExactMatch, in_data.fname2Weight,0 ));
  lname2Weight := MAX(GROUP,IF( in_data.lname2_match_code=SALT37.MatchCode.ExactMatch, in_data.lname2Weight,0 ));
END;
  R1 := TABLE(in_data,aggregateRec,Reference);
 
LayoutScoredFetch FixScores(LayoutScoredFetch le, aggregateRec ri) := TRANSFORM
  SELF.SNAMEWeight := MAP( ri.SNAMEWeight=0 OR le.SNAME_match_code=SALT37.MatchCode.ExactMatch => le.SNAMEWeight,MIN(le.SNAMEWeight,ri.SNAMEWeight-1) );
  SELF.FNAMEWeight := MAP( ri.FNAMEWeight=0 OR le.FNAME_match_code=SALT37.MatchCode.ExactMatch => le.FNAMEWeight,MIN(le.FNAMEWeight,ri.FNAMEWeight-1) );
  SELF.MNAMEWeight := MAP( ri.MNAMEWeight=0 OR le.MNAME_match_code=SALT37.MatchCode.ExactMatch => le.MNAMEWeight,MIN(le.MNAMEWeight,ri.MNAMEWeight-1) );
  SELF.LNAMEWeight := MAP( ri.LNAMEWeight=0 OR le.LNAME_match_code=SALT37.MatchCode.ExactMatch => le.LNAMEWeight,MIN(le.LNAMEWeight,ri.LNAMEWeight-1) );
  SELF.DERIVED_GENDERWeight := MAP( ri.DERIVED_GENDERWeight=0 OR le.DERIVED_GENDER_match_code=SALT37.MatchCode.ExactMatch => le.DERIVED_GENDERWeight,MIN(le.DERIVED_GENDERWeight,ri.DERIVED_GENDERWeight-1) );
  SELF.PRIM_RANGEWeight := MAP( ri.PRIM_RANGEWeight=0 OR le.PRIM_RANGE_match_code=SALT37.MatchCode.ExactMatch => le.PRIM_RANGEWeight,MIN(le.PRIM_RANGEWeight,ri.PRIM_RANGEWeight-1) );
  SELF.PRIM_NAMEWeight := MAP( ri.PRIM_NAMEWeight=0 OR le.PRIM_NAME_match_code=SALT37.MatchCode.ExactMatch => le.PRIM_NAMEWeight,MIN(le.PRIM_NAMEWeight,ri.PRIM_NAMEWeight-1) );
  SELF.SEC_RANGEWeight := MAP( ri.SEC_RANGEWeight=0 OR le.SEC_RANGE_match_code=SALT37.MatchCode.ExactMatch => le.SEC_RANGEWeight,MIN(le.SEC_RANGEWeight,ri.SEC_RANGEWeight-1) );
  SELF.CITYWeight := MAP( ri.CITYWeight=0 OR le.CITY_match_code=SALT37.MatchCode.ExactMatch => le.CITYWeight,MIN(le.CITYWeight,ri.CITYWeight-1) );
  SELF.STWeight := MAP( ri.STWeight=0 OR le.ST_match_code=SALT37.MatchCode.ExactMatch => le.STWeight,MIN(le.STWeight,ri.STWeight-1) );
  SELF.ZIPWeight := MAP( ri.ZIPWeight=0 OR le.ZIP_match_code=SALT37.MatchCode.ExactMatch => le.ZIPWeight,MIN(le.ZIPWeight,ri.ZIPWeight-1) );
  SELF.SSN5Weight := MAP( ri.SSN5Weight=0 OR le.SSN5_match_code=SALT37.MatchCode.ExactMatch => le.SSN5Weight,MIN(le.SSN5Weight,ri.SSN5Weight-1) );
  SELF.SSN4Weight := MAP( ri.SSN4Weight=0 OR le.SSN4_match_code=SALT37.MatchCode.ExactMatch => le.SSN4Weight,MIN(le.SSN4Weight,ri.SSN4Weight-1) );
  SELF.DOBWeight := MAP( ri.DOBWeight=0 OR (le.DOB_year_match_code=SALT37.MatchCode.ExactMatch AND le.DOB_month_match_code=SALT37.MatchCode.ExactMatch AND le.DOB_day_match_code=SALT37.MatchCode.ExactMatch) => le.DOBWeight,MIN(le.DOBWeight,ri.DOBWeight-1) );
  SELF.PHONEWeight := MAP( ri.PHONEWeight=0 OR le.PHONE_match_code=SALT37.MatchCode.ExactMatch => le.PHONEWeight,MIN(le.PHONEWeight,ri.PHONEWeight-1) );
  SELF.DL_STATEWeight := MAP( ri.DL_STATEWeight=0 OR le.DL_STATE_match_code=SALT37.MatchCode.ExactMatch => le.DL_STATEWeight,MIN(le.DL_STATEWeight,ri.DL_STATEWeight-1) );
  SELF.DL_NBRWeight := MAP( ri.DL_NBRWeight=0 OR le.DL_NBR_match_code=SALT37.MatchCode.ExactMatch => le.DL_NBRWeight,MIN(le.DL_NBRWeight,ri.DL_NBRWeight-1) );
  SELF.SRCWeight := MAP( ri.SRCWeight=0 OR le.SRC_match_code=SALT37.MatchCode.ExactMatch => le.SRCWeight,MIN(le.SRCWeight,ri.SRCWeight-1) );
  SELF.SOURCE_RIDWeight := MAP( ri.SOURCE_RIDWeight=0 OR le.SOURCE_RID_match_code=SALT37.MatchCode.ExactMatch => le.SOURCE_RIDWeight,MIN(le.SOURCE_RIDWeight,ri.SOURCE_RIDWeight-1) );
  SELF.DT_FIRST_SEENWeight := MAP( ri.DT_FIRST_SEENWeight=0 OR le.DT_FIRST_SEEN_match_code=SALT37.MatchCode.ExactMatch => le.DT_FIRST_SEENWeight,MIN(le.DT_FIRST_SEENWeight,ri.DT_FIRST_SEENWeight-1) );
  SELF.DT_LAST_SEENWeight := MAP( ri.DT_LAST_SEENWeight=0 OR le.DT_LAST_SEEN_match_code=SALT37.MatchCode.ExactMatch => le.DT_LAST_SEENWeight,MIN(le.DT_LAST_SEENWeight,ri.DT_LAST_SEENWeight-1) );
  SELF.DT_EFFECTIVE_FIRSTWeight := MAP( ri.DT_EFFECTIVE_FIRSTWeight=0 OR le.DT_EFFECTIVE_FIRST_match_code=SALT37.MatchCode.ExactMatch => le.DT_EFFECTIVE_FIRSTWeight,MIN(le.DT_EFFECTIVE_FIRSTWeight,ri.DT_EFFECTIVE_FIRSTWeight-1) );
  SELF.DT_EFFECTIVE_LASTWeight := MAP( ri.DT_EFFECTIVE_LASTWeight=0 OR le.DT_EFFECTIVE_LAST_match_code=SALT37.MatchCode.ExactMatch => le.DT_EFFECTIVE_LASTWeight,MIN(le.DT_EFFECTIVE_LASTWeight,ri.DT_EFFECTIVE_LASTWeight-1) );
  SELF.MAINNAMEWeight := MAP( ri.MAINNAMEWeight=0 OR le.MAINNAME_match_code=SALT37.MatchCode.ExactMatch => le.MAINNAMEWeight,MIN(le.MAINNAMEWeight,ri.MAINNAMEWeight-1) );
  SELF.FULLNAMEWeight := MAP( ri.FULLNAMEWeight=0 OR le.FULLNAME_match_code=SALT37.MatchCode.ExactMatch => le.FULLNAMEWeight,MIN(le.FULLNAMEWeight,ri.FULLNAMEWeight-1) );
  SELF.ADDR1Weight := MAP( ri.ADDR1Weight=0 OR le.ADDR1_match_code=SALT37.MatchCode.ExactMatch => le.ADDR1Weight,MIN(le.ADDR1Weight,ri.ADDR1Weight-1) );
  SELF.LOCALEWeight := MAP( ri.LOCALEWeight=0 OR le.LOCALE_match_code=SALT37.MatchCode.ExactMatch => le.LOCALEWeight,MIN(le.LOCALEWeight,ri.LOCALEWeight-1) );
  SELF.ADDRESSWeight := MAP( ri.ADDRESSWeight=0 OR le.ADDRESS_match_code=SALT37.MatchCode.ExactMatch => le.ADDRESSWeight,MIN(le.ADDRESSWeight,ri.ADDRESSWeight-1) );
  SELF.fname2Weight := MAP( ri.fname2Weight=0 OR le.fname2_match_code=SALT37.MatchCode.ExactMatch => le.fname2Weight,MIN(le.fname2Weight,ri.fname2Weight-1) );
  SELF.lname2Weight := MAP( ri.lname2Weight=0 OR le.lname2_match_code=SALT37.MatchCode.ExactMatch => le.lname2Weight,MIN(le.lname2Weight,ri.lname2Weight-1) );
  INTEGER2 Weight := MAX(0,SELF.DERIVED_GENDERWeight) + MAX(0,SELF.SSN5Weight) + MAX(0,SELF.SSN4Weight) + MAX(0,SELF.DOBWeight) + MAX(0,SELF.PHONEWeight) + MAX(0,SELF.DL_STATEWeight) + MAX(0,SELF.DL_NBRWeight) + MAX(0,SELF.SRCWeight) + MAX(0,SELF.SOURCE_RIDWeight) + MAX(SELF.MAINNAMEWeight,MAX(0,SELF.FNAMEWeight) + MAX(0,SELF.MNAMEWeight) + MAX(0,SELF.LNAMEWeight)) + MAX(0,SELF.SNAMEWeight) + MAX(0,SELF.PRIM_RANGEWeight) + MAX(0,SELF.SEC_RANGEWeight) + MAX(0,SELF.PRIM_NAMEWeight) + MAX(0,SELF.CITYWeight) + MAX(0,SELF.STWeight) + MAX(0,SELF.ZIPWeight) + MAX(0,SELF.fname2Weight) + MAX(0,SELF.lname2Weight);
  SELF.Weight := Weight; /*PHACK04*/
  SELF := le;
END;
 
  R2 := JOIN(in_data,R1,LEFT.reference=RIGHT.reference,FixScores(LEFT,RIGHT));
  RETURN SORT(GROUP(R2,Reference,ALL),-weight,DID);
END;
EXPORT CombineAllScores(DATASET(LayoutScoredFetch) in_data, BOOLEAN In_disableForce = FALSE) := FUNCTION
  OutputLayout_Batch Create_Output(LayoutScoredFetch le, DATASET(LayoutScoredFetch) ri) := TRANSFORM
    SELF.Results := ri;
    SELF.Reference := le.Reference;
    MAC_Add_ResolutionFlags()
  END;
  r0 := ROLLUP( SORT( GROUP( SORT ( DISTRIBUTE(In_Data,HASH(reference)),Reference, LOCAL ), Reference, LOCAL),DID),LEFT.DID=RIGHT.DID,Combine_Scores(LEFT,RIGHT,In_disableForce))(SALT37.DebugMode OR ~ForceFailed);
  r1 := AdjustScoresForNonExactMatches(UNGROUP(r0));
  R2 := ROLLUP( TOPN(r1,100,-Weight),GROUP, Create_Output(LEFT,ROWS(LEFT)) );
  SALT37.MAC_External_AddPcnt(R2,LayoutScoredFetch,Results,OutputLayout_Batch,29,R3);/*HACK16*/
  RETURN r3;
END;
EXPORT CombineLinkpathScores(DATASET(LayoutScoredFetch) in_data, BOOLEAN In_disableForce = TRUE) := FUNCTION
// Note - results are returned distributed by HASH(reference) - this is part of the specification
  rolled := ROLLUP ( SORT( DISTRIBUTE( in_data, HASH(reference) ), Reference, DID, LOCAL), Combine_Scores(LEFT,RIGHT, In_disableForce), Reference, DID, LOCAL);
  RETURN DEDUP( SORT( rolled, Reference, -weight, LOCAL ), Reference, KEEP(Config.LinkpathCandidateCount),LOCAL);
END;
EXPORT KeysUsedToText(UNSIGNED4 k) := FUNCTION
  list := IF(k&1 <>0,'UberKey,','') + IF(k&(1<<1)<>0,'NAME,','') + IF(k&(1<<2)<>0,'ADDRESS,','') + IF(k&(1<<3)<>0,'SSN,','') + IF(k&(1<<4)<>0,'SSN4,','') + IF(k&(1<<5)<>0,'DOB,','') + IF(k&(1<<6)<>0,'DOBF,','') + IF(k&(1<<7)<>0,'ZIP_PR,','') + IF(k&(1<<8)<>0,'SRC_RID,','') + IF(k&(1<<9)<>0,'DLN,','') + IF(k&(1<<10)<>0,'PH,','') + IF(k&(1<<11)<>0,'LFZ,','') + IF(k&(1<<12)<>0,'RELATIVE,','');
  RETURN list[1..LENGTH(TRIM(list))-1]; // Strim last ,
end;
EXPORT Layout_RolledEntity := RECORD,MAXLENGTH(63000)
  TYPEOF(h.did) DID; /*PHACK05*/
  DATASET(SALT37.Layout_FieldValueList) DERIVED_GENDER_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) SSN5_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) SSN4_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) DOB_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) PHONE_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) DL_STATE_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) DL_NBR_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) SRC_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) SOURCE_RID_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) DT_FIRST_SEEN_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) DT_LAST_SEEN_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) DT_EFFECTIVE_FIRST_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) DT_EFFECTIVE_LAST_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) FULLNAME_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) ADDRESS_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) fname2_Values := DATASET([],SALT37.Layout_FieldValueList);
  DATASET(SALT37.Layout_FieldValueList) lname2_Values := DATASET([],SALT37.Layout_FieldValueList);
END;
 
SHARED RollEntities(dataset(Layout_RolledEntity) infile) := FUNCTION
  Layout_RolledEntity RollValues(Layout_RolledEntity le,Layout_RolledEntity ri) := TRANSFORM
  SELF.DID := le.DID;
    SELF.DERIVED_GENDER_values := SALT37.fn_combine_fieldvaluelist(le.DERIVED_GENDER_values,ri.DERIVED_GENDER_values);
    SELF.SSN5_values := SALT37.fn_combine_fieldvaluelist(le.SSN5_values,ri.SSN5_values);
    SELF.SSN4_values := SALT37.fn_combine_fieldvaluelist(le.SSN4_values,ri.SSN4_values);
    SELF.DOB_values := SALT37.fn_combine_fieldvaluelist(le.DOB_values,ri.DOB_values);
    SELF.PHONE_values := SALT37.fn_combine_fieldvaluelist(le.PHONE_values,ri.PHONE_values);
    SELF.DL_STATE_values := SALT37.fn_combine_fieldvaluelist(le.DL_STATE_values,ri.DL_STATE_values);
    SELF.DL_NBR_values := SALT37.fn_combine_fieldvaluelist(le.DL_NBR_values,ri.DL_NBR_values);
    SELF.SRC_values := SALT37.fn_combine_fieldvaluelist(le.SRC_values,ri.SRC_values);
    SELF.SOURCE_RID_values := SALT37.fn_combine_fieldvaluelist(le.SOURCE_RID_values,ri.SOURCE_RID_values);
    SELF.DT_FIRST_SEEN_values := SALT37.fn_combine_fieldvaluelist(le.DT_FIRST_SEEN_values,ri.DT_FIRST_SEEN_values);
    SELF.DT_LAST_SEEN_values := SALT37.fn_combine_fieldvaluelist(le.DT_LAST_SEEN_values,ri.DT_LAST_SEEN_values);
    SELF.DT_EFFECTIVE_FIRST_values := SALT37.fn_combine_fieldvaluelist(le.DT_EFFECTIVE_FIRST_values,ri.DT_EFFECTIVE_FIRST_values);
    SELF.DT_EFFECTIVE_LAST_values := SALT37.fn_combine_fieldvaluelist(le.DT_EFFECTIVE_LAST_values,ri.DT_EFFECTIVE_LAST_values);
    SELF.FULLNAME_values := SALT37.fn_combine_fieldvaluelist(le.FULLNAME_values,ri.FULLNAME_values);
    SELF.ADDRESS_values := SALT37.fn_combine_fieldvaluelist(le.ADDRESS_values,ri.ADDRESS_values);
    SELF.fname2_values := SALT37.fn_combine_fieldvaluelist(le.fname2_values,ri.fname2_values);
    SELF.lname2_values := SALT37.fn_combine_fieldvaluelist(le.lname2_values,ri.lname2_values);
  END;
  ds_roll := ROLLUP( SORT( DISTRIBUTE( infile, HASH(DID) ), DID, LOCAL ), LEFT.DID = RIGHT.DID, RollValues(LEFT,RIGHT),LOCAL);
  Layout_RolledEntity SortValues(Layout_RolledEntity le) := TRANSFORM
    SELF.DID := le.DID;
    SELF.DERIVED_GENDER_values := SORT(le.DERIVED_GENDER_values, -cnt, val, LOCAL);
    SELF.SSN5_values := SORT(le.SSN5_values, -cnt, val, LOCAL);
    SELF.SSN4_values := SORT(le.SSN4_values, -cnt, val, LOCAL);
    SELF.DOB_values := SORT(le.DOB_values, -cnt, val, LOCAL);
    SELF.PHONE_values := SORT(le.PHONE_values, -cnt, val, LOCAL);
    SELF.DL_STATE_values := SORT(le.DL_STATE_values, -cnt, val, LOCAL);
    SELF.DL_NBR_values := SORT(le.DL_NBR_values, -cnt, val, LOCAL);
    SELF.SRC_values := SORT(le.SRC_values, -cnt, val, LOCAL);
    SELF.SOURCE_RID_values := SORT(le.SOURCE_RID_values, -cnt, val, LOCAL);
    SELF.DT_FIRST_SEEN_values := SORT(le.DT_FIRST_SEEN_values, -cnt, val, LOCAL);
    SELF.DT_LAST_SEEN_values := SORT(le.DT_LAST_SEEN_values, -cnt, val, LOCAL);
    SELF.DT_EFFECTIVE_FIRST_values := SORT(le.DT_EFFECTIVE_FIRST_values, -cnt, val, LOCAL);
    SELF.DT_EFFECTIVE_LAST_values := SORT(le.DT_EFFECTIVE_LAST_values, -cnt, val, LOCAL);
    SELF.FULLNAME_values := SORT(le.FULLNAME_values, -cnt, val, LOCAL);
    SELF.ADDRESS_values := SORT(le.ADDRESS_values, -cnt, val, LOCAL);
    SELF.fname2_values := SORT(le.fname2_values, -cnt, val, LOCAL);
    SELF.lname2_values := SORT(le.lname2_values, -cnt, val, LOCAL);
  END;
  ds_sort := PROJECT(ds_roll, SortValues(LEFT));
  RETURN ds_sort;
END;
 
EXPORT RolledEntities(DATASET(RECORDOF(Key)) in_data,DATASET(RECORDOF(Key0)) in_data0) := FUNCTION
 
Layout_RolledEntity into0(in_data0 le) := TRANSFORM
  SELF.DID := le.DID;
  SELF.fname2_Values := IF ( (SALT37.StrType)le.fname2 = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.fname2)}],SALT37.Layout_FieldValueList));
  SELF.lname2_Values := IF ( (SALT37.StrType)le.lname2 = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.lname2)}],SALT37.Layout_FieldValueList));
END;
AsFieldValues0 := PROJECT(in_data0,into0(LEFT));
 
Layout_RolledEntity into(in_data le) := TRANSFORM
  SELF.DID := le.DID;
  SELF.DERIVED_GENDER_Values := IF ( (SALT37.StrType)le.DERIVED_GENDER = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.DERIVED_GENDER)}],SALT37.Layout_FieldValueList));
  SELF.SSN5_Values := IF ( (SALT37.StrType)le.SSN5 = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.SSN5)}],SALT37.Layout_FieldValueList));
  SELF.SSN4_Values := IF ( (SALT37.StrType)le.SSN4 = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.SSN4)}],SALT37.Layout_FieldValueList));
  self.DOB_Values := IF ( (unsigned)le.DOB = 0,dataset([],SALT37.Layout_FieldValueList),dataset([{(SALT37.StrType)le.DOB}],SALT37.Layout_FieldValueList));
  SELF.PHONE_Values := IF ( (SALT37.StrType)le.PHONE = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.PHONE)}],SALT37.Layout_FieldValueList));
  SELF.DL_STATE_Values := IF ( (SALT37.StrType)le.DL_STATE = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.DL_STATE)}],SALT37.Layout_FieldValueList));
  SELF.DL_NBR_Values := IF ( (SALT37.StrType)le.DL_NBR = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.DL_NBR)}],SALT37.Layout_FieldValueList));
  SELF.SRC_Values := IF ( (SALT37.StrType)le.SRC = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.SRC)}],SALT37.Layout_FieldValueList));
  SELF.SOURCE_RID_Values := IF ( (SALT37.StrType)le.SOURCE_RID = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.SOURCE_RID)}],SALT37.Layout_FieldValueList));
  SELF.DT_FIRST_SEEN_Values := DATASET([{TRIM((SALT37.StrType)le.DT_FIRST_SEEN)}],SALT37.Layout_FieldValueList);
  SELF.DT_LAST_SEEN_Values := DATASET([{TRIM((SALT37.StrType)le.DT_LAST_SEEN)}],SALT37.Layout_FieldValueList);
  SELF.DT_EFFECTIVE_FIRST_Values := DATASET([{TRIM((SALT37.StrType)le.DT_EFFECTIVE_FIRST)}],SALT37.Layout_FieldValueList);
  SELF.DT_EFFECTIVE_LAST_Values := DATASET([{TRIM((SALT37.StrType)le.DT_EFFECTIVE_LAST)}],SALT37.Layout_FieldValueList);
  SELF.FULLNAME_Values := IF ( (SALT37.StrType)le.FNAME = '' AND (SALT37.StrType)le.MNAME = '' AND (SALT37.StrType)le.LNAME = '' AND (SALT37.StrType)le.SNAME = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.FNAME) + ' ' + TRIM((SALT37.StrType)le.MNAME) + ' ' + TRIM((SALT37.StrType)le.LNAME) + ' ' + TRIM((SALT37.StrType)le.SNAME)}],SALT37.Layout_FieldValueList));
  SELF.ADDRESS_Values := IF ( (SALT37.StrType)le.PRIM_RANGE = '' AND (SALT37.StrType)le.SEC_RANGE = '' AND (SALT37.StrType)le.PRIM_NAME = '' AND (SALT37.StrType)le.CITY = '' AND (SALT37.StrType)le.ST = '' AND (SALT37.StrType)le.ZIP = '',DATASET([],SALT37.Layout_FieldValueList),DATASET([{TRIM((SALT37.StrType)le.PRIM_RANGE) + ' ' + TRIM((SALT37.StrType)le.SEC_RANGE) + ' ' + TRIM((SALT37.StrType)le.PRIM_NAME) + ' ' + TRIM((SALT37.StrType)le.CITY) + ' ' + TRIM((SALT37.StrType)le.ST) + ' ' + TRIM((SALT37.StrType)le.ZIP)}],SALT37.Layout_FieldValueList));
END;
AsFieldValues := PROJECT(in_data,into(LEFT)) + AsFieldValues0;
  RETURN RollEntities(AsFieldValues);
END;
// Records which already had the DID on them may not be up to date. Update those IDs
EXPORT UpdateIDs(DATASET(InputLayout) in) := FUNCTION
  id_stream_layout init(in le) := TRANSFORM
    SELF.UniqueId := le.UniqueId;
    SELF.Weight := Config.MatchThreshold; // Assume at least 'threshold' met
    SELF.DID := le.Entered_DID;
    SELF.RID := le.Entered_RID;
  END;
  idupdate_candidates := PROJECT(in,init(LEFT));
  ids_updated0 := id_stream_historic(idupdate_candidates);
  ids_updated := PROJECT(ids_updated0,TRANSFORM(LayoutScoredFetch,SELF.Reference:=LEFT.UniqueId,SELF.keys_used:=0,SELF.keys_failed:=0,SELF:=LEFT));
  RETURN CombineLinkpathScores(ids_updated);
END;
SHARED incDS := File_InsuranceHeader;
SHARED PayloadKey0 := Config.PayloadKey;
SHARED PayloadCand0 := JOIN(incDS,PayloadKey0,KEYED(LEFT.DID = RIGHT.DID),TRANSFORM(RECORDOF(LEFT), SELF := RIGHT));
SHARED PayloadCand0_asof := SALT37.MAC_DatasetAsOf(PayloadCand0,RID,DID,,DT_EFFECTIVE_FIRST,DT_EFFECTIVE_LAST,,'YYYYMMDD',TRUE);
EXPORT PayloadCand := scaled_candidates(PayloadCand0_asof,Match_Candidates(PayloadCand0_asof,TRUE).candidates,TRUE);
SHARED IncCand_asof := SALT37.MAC_DatasetAsOf(incDS & PayloadCand0,RID,DID,,DT_EFFECTIVE_FIRST,DT_EFFECTIVE_LAST,,'YYYYMMDD',TRUE);
EXPORT IncCand := scaled_candidates(IncCand_asof,Match_Candidates(IncCand_asof,TRUE).candidates,TRUE);
EXPORT FullCand := scaled_candidates(File_InsuranceHeader);
END;
