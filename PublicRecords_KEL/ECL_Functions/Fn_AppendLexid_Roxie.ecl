/* This function appends the lexid from Roxie.
The default for the score threshold is 80 - meaning no scores less than 80 will return 
a lexid. The user can override this score threshold by setting the score_threshold parameter.
*/
IMPORT didville, PublicRecords_KEL;

// this function will take the input data, append the DID and do all default values in layout output
EXPORT Fn_AppendLexid_Roxie(
							DATASET(PublicRecords_KEL.ECL_Functions.Input_ALL_Layout) indata,
              INTEGER Score_threshold = 80
					) := FUNCTION

  dedup_these := FALSE; //allow multiple DID's
  fz := '4GZ';
  allscores := FALSE;
  indata_did := PROJECT(indata, 
    TRANSFORM(didville.Layout_Did_OutBatch, 
      SELF.Did := LEFT.InputLexIDEcho;
      SELF.dl_nbr:= LEFT.InputDLNumberClean;
      SELF.email:= LEFT.InputEmailClean;
      //Same between the layouts
      SELF.Score := 0;
      SELF.Seq := LEFT.InputUIDAppend;
      SELF.SSN := LEFT.InputSSNClean;
      SELF.DOB := LEFT.InputDOBClean; 
      SELF.Phone10 := LEFT.InputHomePhoneClean;
      SELF.title:= LEFT.InputPrefixClean;
      SELF.fname:= LEFT.InputFirstNameClean;
      SELF.mname:= LEFT.InputMiddleNameClean;
      SELF.lname:= LEFT.InputLastNameClean;
      SELF.suffix:= LEFT.InputSuffixClean;
      SELF.prim_range:= LEFT.InputPrimaryRangeClean;
      SELF.predir:= LEFT.InputPreDirectionClean;
      SELF.prim_name:= LEFT.InputPrimaryNameClean;
      SELF.addr_suffix:= LEFT.InputAddressSuffixClean;
      SELF.postdir:= LEFT.InputPostDirectionClean;
      SELF.unit_desig:= LEFT.InputUnitDesigClean;
      SELF.sec_range:= LEFT.InputSecondaryRangeClean;
      SELF.p_city_name:= LEFT.InputCityNameClean;
      SELF.st:= LEFT.InputStateClean;
      SELF.z5:= LEFT.InputZip5Clean;
      SELF.zip4:= LEFT.InputZip4Clean;
      SELF.dl_state:= LEFT.InputDLStateClean;
      SELF := LEFT;
      )); 
  //The Roxie Lexid Append
	didville.Mac_DIDAppend(indata_did, resu, dedup_these, fz, allscores) ;
 //Since Layout_Did_OutBatch doesn't have all the output from our indata, rejoin back to indata
  IndataGotDid := JOIN(indata, resu,
   LEFT.InputUIDAppend = RIGHT.Seq,
    TRANSFORM(PublicRecords_KEL.ECL_Functions.Input_ALL_Layout, 
			SELF.InputLexIDEcho := LEFT.InputLexIDEcho;
      SELF.AppendedLexID := RIGHT.Did, 
      SELF.AppendedLexIDscore := RIGHT.Score,
      SELF.InputUIDAppend := LEFT.InputUIDAppend;
      SELF := LEFT),
   LEFT OUTER);
  
  dids_with_good_scores := IndataGotDid((INTEGER) AppendedLexIDscore >= Score_threshold);

  //Change the lexid and score to be 0 for records below the score threshold
  dids_with_below_scores := DEDUP(SORT(
    PROJECT(IndataGotDid((INTEGER) AppendedLexIDscore < Score_threshold), 
    TRANSFORM(PublicRecords_KEL.ECL_Functions.Input_ALL_Layout, 
      SELF.AppendedLexID := IF(LEFT.AppendedLexID = 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.AppendedLexID);
      SELF.AppendedLexIDscore := IF(LEFT.AppendedLexIDscore = 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT,LEFT.AppendedLexIDscore);, 
      SELF := LEFT))
      , InputUIDAppend, AppendedLexID), InputUIDAppend);

RETURN dids_with_good_scores + dids_with_below_scores;

END;