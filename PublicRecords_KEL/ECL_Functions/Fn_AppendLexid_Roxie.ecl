/* This function appends the lexid from Roxie.
The default for the score threshold is 80 - meaning no scores less than 80 will return 
a lexid. The user can override this score threshold by setting the score_threshold parameter.
*/
IMPORT didville, PublicRecords_KEL;

// this function will take the input data, append the DID and do all default values in layout output
EXPORT Fn_AppendLexid_Roxie(
							DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) indata,
							PublicRecords_KEL.Interface_Options Options
					) := FUNCTION

  dedup_these := FALSE; //allow multiple DID's
  fz := '4GZ';
  allscores := FALSE;
  indata_did := PROJECT(indata(P_InpLexID = 0),
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
      )); 
			
  keepinputdid :=   PROJECT(indata(P_InpLexID <> 0),
    TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII, 
      SELF.P_LexID := left.P_InpLexID;
      SELF.P_LexIDScore := PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT;
      SELF := LEFT));			

			

			
  //The Roxie Lexid Append
	didville.Mac_DIDAppend(indata_did, resu, dedup_these, fz, allscores) ;

 //Since Layout_Did_OutBatch doesn't have all the output from our indata, rejoin back to indata
  IndataGotDid := JOIN(indata, resu,
   LEFT.G_ProcUID = RIGHT.Seq,
    TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII, 
		SELF.P_InpLexID := LEFT.P_InpLexID;
		SELF.P_LexID := RIGHT.Did, 
		SELF.P_LexIDScore := RIGHT.Score,
		SELF.G_ProcUID := LEFT.G_ProcUID;
		SELF := LEFT),
   LEFT OUTER);
  
  dids_with_good_scores := IndataGotDid((INTEGER) P_LexIDScore >= Options.ScoreThreshold);

  //Change the lexid and score to be 0 for records below the score threshold
  dids_with_below_scores := DEDUP(SORT(
    PROJECT(IndataGotDid((INTEGER) P_LexIDScore < Options.ScoreThreshold), 
    TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII, 
      SELF.P_LexID := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF.P_LexIDScore := PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
      SELF := LEFT))
      , G_ProcUID, P_LexID), G_ProcUID);

	all_dids := dids_with_good_scores + dids_with_below_scores; 
	
	// On roxie, dedup dids to keep only the DID with the highest score.
	// On thor, this code is not needed since thor append only returns one did.
	dids_deduped := DEDUP(SORT(all_dids, G_ProcUID, -P_LexIDScore, P_LexID), G_ProcUID);
	
	
	PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII chooser(recordof(dids_deduped) le, recordof(keepinputdid) ri) := transform
		SELF.P_InpLexID := le.P_InpLexID;
		SELF.G_ProcUID := le.G_ProcUID;

		retain := IF(options.RetainInputLexid and ri.P_LexID > 0, TRUE, FALSE);
		//if we set retain input did and we have a good did on file then keep the input one, else go find one
		
		self.P_Lexid := if(retain = TRUE, ri.P_LexID, le.P_LexID);
		self.P_LexIDScore := if(retain = TRUE, PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT, le.P_LexIDScore);
		self := le;
	end;
	
	didchooser := join(dids_deduped, keepinputdid, 
						LEFT.G_ProcUID = right.G_ProcUID,
						chooser(left,right),LEFT OUTER);

	getpullidlist := PublicRecords_KEL.ECL_Functions.Fn_getpullid(didchooser, options);				

	
RETURN getpullidlist;

END;