/* This function appends the lexid from THOR.
The default for the score threshold is 80 - meaning no scores less than 80 will return 
a lexid. The user can override this score threshold by setting the score_threshold parameter.
*/
IMPORT did_add, ProfileBooster, ProfileBooster.ProfileBoosterV2_KEL, DidVille;

// this function will take the input data, append the DID and do all default values in layout output
EXPORT Fn_AppendLexid_THOR(
							DATASET(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Layouts.LayoutInputPII) indata,
              ProfileBooster.ProfileBoosterV2_KEL.Interface_Options Options
					) := FUNCTION


	matchset_input := ['A','D','S','P','Z'];
	
	indata_did := PROJECT(indata, 
    TRANSFORM(didville.Layout_Did_OutBatch, 
      SELF.Did := LEFT.P_InpLexID;
      SELF.dl_nbr:= LEFT.P_InpClnDL;
      SELF.email:= LEFT.P_InpClnEmail;
      //Same between the layouts
      SELF.Score := 0;
      SELF.Seq := LEFT.G_ProcUID;
      SELF.SSN := LEFT.P_InpClnSSN;
      SELF.DOB := LEFT.P_InpClnDOB; 
      SELF.Phone10 := LEFT.P_InpClnPhoneHome;
      SELF.title:= LEFT.P_InpClnNamePrfx;
      SELF.fname:= LEFT.P_InpClnNameFirst;
      SELF.mname:= LEFT.P_InpClnNameMid;
      SELF.lname:= LEFT.P_InpClnNameLast;
      SELF.suffix:= LEFT.P_InpClnNameSffx;
      SELF.prim_range:= LEFT.P_InpClnAddrPrimRng;
      SELF.predir:= LEFT.P_InpClnAddrPreDir;
      SELF.prim_name:= LEFT.P_InpClnAddrPrimName;
      SELF.addr_suffix:= LEFT.P_InpClnAddrSffx;
      SELF.postdir:= LEFT.P_InpClnAddrPostDir;
      SELF.unit_desig:= LEFT.P_InpClnAddrUnitDesig;
      SELF.sec_range:= LEFT.P_InpClnAddrSecRng;
      SELF.p_city_name:= LEFT.P_InpClnAddrCity;
      SELF.st:= LEFT.P_InpClnAddrState;
      SELF.z5:= LEFT.P_InpClnAddrZip5;
      SELF.zip4:= LEFT.P_InpClnAddrZip4;
      SELF.dl_state:= LEFT.P_InpClnDLState;
	  SELF := LEFT;
	  SELF := [];
      )); 	
	
	did_Add.MAC_Match_Flex(indata_did, matchset_input,
												 SSN, DOB, fName, mname, LName, suffix, 
												 prim_range, prim_name, sec_range, z5,
												 st, Phone10,
												 Did,
                         didville.Layout_Did_OutBatch,												 
                         TRUE, score,	//these should default to zero in definition
												 0,	  //dids with a score below here will be dropped 	
												 resu);
  
  // resu_dist := DISTRIBUTE( resu, HASH32(Seq) );
  resu_dist := resu;//DISTRIBUTE( resu, HASH32(Seq) );
  
  //Since Layout_Did_OutBatch doesn't have all the output from our indata, rejoin back to indata
  IndataGotDid := JOIN(indata, resu_dist,
   LEFT.G_ProcUID = RIGHT.Seq,
    TRANSFORM(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Layouts.LayoutInputPII, 
		SELF.P_InpLexID := LEFT.P_InpLexID;
		SELF.P_LexID := RIGHT.Did, 
		SELF.P_LexIDScore := RIGHT.Score,
		SELF.G_ProcUID := LEFT.G_ProcUID;
		SELF := LEFT),
   LEFT OUTER /*, LOCAL*/);												 
												 
  //Keep scores greater or equal to the score threshold
  dids_with_good_scores := IndataGotDid((INTEGER) P_LexIDScore >= Options.ScoreThreshold);
  //Change the lexid and score to be 0 for records below the score threshold
  dids_with_below_scores := PROJECT(IndataGotDid((INTEGER) P_LexIDScore < Options.ScoreThreshold), 
    TRANSFORM(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Layouts.LayoutInputPII, 
      SELF.P_LexID := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.P_LexIDScore := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF := LEFT));
			
  dids_with_Scores := SORT(dids_with_good_scores + dids_with_below_scores, G_ProcUID/*, LOCAL*/);

RETURN dids_with_Scores;

END;