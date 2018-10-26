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
      SELF.Did := LEFT.InputLexID;
      SELF.dl_nbr:= LEFT.InputCleanDLNumber;
      SELF.email:= LEFT.InputCleanEMail;
      //Same between the layouts
      SELF.Score := 0;
      SELF.Seq := LEFT.InputID;
      SELF.SSN := LEFT.InputCleanSSN;
      SELF.DOB := LEFT.InputCleanDOB; 
      SELF.Phone10 := LEFT.InputCleanHomePhone;
      SELF.title:= LEFT.InputCleanPrefix;
      SELF.fname:= LEFT.InputCleanFirstName;
      SELF.mname:= LEFT.InputCleanMiddleName;
      SELF.lname:= LEFT.InputCleanLastName;
      SELF.suffix:= LEFT.InputCleanSuffix;
      SELF.prim_range:= LEFT.InputCleanPrimaryRange;
      SELF.predir:= LEFT.InputCleanPreDirection;
      SELF.prim_name:= LEFT.InputCleanPrimaryName;
      SELF.addr_suffix:= LEFT.InputCleanAddressSuffix;
      SELF.postdir:= LEFT.InputCleanPostDirection;
      SELF.unit_desig:= LEFT.InputCleanUnitDesig;
      SELF.sec_range:= LEFT.InputCleanSecondaryRange;
      SELF.p_city_name:= LEFT.InputCleanCityName;
      SELF.st:= LEFT.InputCleanState;
      SELF.z5:= LEFT.InputCleanZip5;
      SELF.zip4:= LEFT.InputCleanZip4;
      SELF.dl_state:= LEFT.InputCleanDLState;
      SELF := LEFT;
      )); 
  //The Roxie Lexid Append
	didville.Mac_DIDAppend(indata_did, resu, dedup_these, fz, allscores) ;
 //Since Layout_Did_OutBatch doesn't have all the output from our indata, rejoin back to indata
  IndataGotDid := JOIN(indata, resu,
   LEFT.InputID = RIGHT.Seq,
    TRANSFORM(PublicRecords_KEL.ECL_Functions.Input_ALL_Layout, 
	  SELF.InputLexid := IF(LEFT.InputLexid = 0, PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT, LEFT.InputLexid);
      SELF.AppendedLexID := RIGHT.Did, 
      SELF.AppendedLexIDscore := RIGHT.Score,
      SELF.InputID := LEFT.InputID;
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
      , InputID, AppendedLexID), InputID);

RETURN dids_with_good_scores + dids_with_below_scores;

END;