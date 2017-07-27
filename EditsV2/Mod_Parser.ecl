IMPORT iesp;

/* Parser: Translates the EditsV2 Order into specific layouts viz RI, PI, AL, DL, etc */
EXPORT Mod_Parser := MODULE
	
	// General layouts
	SHARED Layout_StrArrayItem := iesp.share.t_StringArrayItem;
	SHARED Layout_Order := EditsV2.Layouts_Order.Order;
	
	// Specific layouts
	SHARED Layout_RI := EditsV2.Layouts_Order.RI01_V2;
	SHARED Layout_PI := EditsV2.Layouts_Order.PI01_V2;
	SHARED Layout_AL := EditsV2.Layouts_Order.AL01_V2;
	SHARED Layout_DL := EditsV2.Layouts_Order.DL01_V2;
	SHARED Layout_RP := EditsV2.Layouts_Order.RP01_V2;
	SHARED Layout_RI2 := EditsV2.Layouts_Order.RI02_V2;
	
	SHARED StringRec := RECORD STRING150 Rec; END;

	/* Construct RI Layout from Original Edits Record */
	SHARED DATASET(Layout_RI) GetRIRecs (STRING EditsRec) := FUNCTION

		// Create dataset in order to project the source record
		StringDS := DATASET([{EditsRec}], StringRec);
		
		Layout_RI CreateRIRec(StringDS L) := TRANSFORM
			SELF.UnitNum 					 := L.Rec[1..3];
			SELF.RecCode 					 := L.Rec[4..7];
			
			SELF.AcctNum 					 := L.Rec[8..13];
			SELF.AcctSufNum 			 := L.Rec[14..16];
			
			SELF.CustBillIdText 	 := L.Rec[17..31];
			SELF.QuotebackText 		 := L.Rec[32..91];
			
			SELF.ReportCode 			 := L.Rec[92..95];
			SELF.ReportVerCode 		 := L.Rec[96..96];
			SELF.Filler 					 := L.Rec[97..102];
			
			SELF.ReportUseCode 		 := L.Rec[103..104];
			SELF.ReportWrkdLocCode := L.Rec[105..111];
			SELF.ProdLineCode 		 := L.Rec[112..112];
			SELF.Filler2 					 := L.Rec[113..113];
			
			SELF.RecVerNum 				 := L.Rec[114..115];
			SELF.ReportOrderDate 	 := L.Rec[116..123];
			SELF.Filler3 					 := L.Rec[124..150];
		END;
		
		RETURN PROJECT (StringDS, CreateRIRec(LEFT));
	END;
	
	/* Construct PI Layout from Original Edits Record */
	SHARED DATASET(Layout_PI) GetPIRecs (STRING EditsRec) := FUNCTION

		// Create dataset in order to project the source record
		StringDS := DATASET([{EditsRec}], StringRec);
		
		Layout_PI CreatePIRec(StringDS L) := TRANSFORM
			SELF.UnitNum 					 := L.Rec[1..3];
			SELF.RecCode 					 := L.Rec[4..7];
			
			SELF.ClassCode				 := L.Rec[8..9];
			SELF.PrefName					 := L.Rec[10..13];
			SELF.LastName					 := L.Rec[14..41];
			SELF.FirstName				 := L.Rec[42..61];
			SELF.MidName 					 := L.Rec[62..76];
			SELF.SufName 					 := L.Rec[77..79];

			SELF.BirthDate				 := L.Rec[80..87];
			SELF.AgeCnt  					 := L.Rec[33..90];
			SELF.SexCode 					 := L.Rec[91..91];
			SELF.SsnNum  					 := L.Rec[92..100];

			SELF.HtFtCnt 					 := L.Rec[101..101];
			SELF.HtInCnt 					 := L.Rec[102..103];
			SELF.WtCnt   					 := L.Rec[104..106];
			SELF.MarrStatCode			 := L.Rec[107..107];

			SELF.EyeCode 					 := L.Rec[108..110];
			SELF.HairCode					 := L.Rec[111..113];
			SELF.RaceCode					 := L.Rec[114..114];
			SELF.Filler1 					 := L.Rec[115..150];
		END;
		
		RETURN PROJECT (StringDS, CreatePIRec(LEFT));
	END;
	
	/* Construct AL Layout from Original Edits Record */
	SHARED DATASET(Layout_AL) GetALRecs (STRING EditsRec) := FUNCTION

		// Create dataset in order to project the source record
		StringDS := DATASET([{EditsRec}], StringRec);
		
		Layout_AL CreateALRec(StringDS L) := TRANSFORM
			SELF.UnitNum 					 := L.Rec[1..3];
			SELF.RecCode 					 := L.Rec[4..7];
			
			SELF.ClassCode  			 := L.Rec[8..9];
			SELF.GroupUseInd		 	 := L.Rec[10..10];

			SELF.HouseNum 					 := L.Rec[11..19];
			SELF.StrName 					 := L.Rec[20..39];
			SELF.AptNum 					 := L.Rec[40..44];

			SELF.CityName					 := L.Rec[45..64];
			SELF.StateCode				 := L.Rec[65..66];
			SELF.ZipNum  					 := L.Rec[67..71];
			SELF.ZipSufNum				 := L.Rec[72..75];

			SELF.YrCnt   					 := L.Rec[76..77];
			SELF.MoCnt   					 := L.Rec[78..79];
			SELF.StartDate				 := L.Rec[80..87];
			SELF.EndDate 					 := L.Rec[88..95];

			SELF.CntyName					 := L.Rec[96..110];
			SELF.CnssTrct					 := L.Rec[111..120];
			SELF.Filler1 					 := L.Rec[121..150];
		END;
		
		RETURN PROJECT (StringDS, CreateALRec(LEFT));
	END;
	
	/* Construct DL Layout from Original Edits Record */
	SHARED DATASET(Layout_DL) GetDLRecs (STRING EditsRec) := FUNCTION

		// Create dataset in order to project the source record
		StringDS := DATASET([{EditsRec}], StringRec);
		
		Layout_DL CreateDLRec(StringDS L) := TRANSFORM
			SELF.UnitNum 					 := L.Rec[1..3];
			SELF.RecCode 					 := L.Rec[4..7];
			
			SELF.ClassCode				 := L.Rec[8..9];
			SELF.LicNum						 := L.Rec[10..34];
			SELF.StateCode				 := L.Rec[35..36];
			
			SELF.Filler1					 := L.Rec[37..150];
		END;
		
		RETURN PROJECT (StringDS, CreateDLRec(LEFT));
	END;
	
	/* Construct RP Layout from Original Edits Record */
	SHARED DATASET(Layout_RP) GetRPRecs (STRING EditsRec) := FUNCTION

		// Create dataset in order to project the source record
		StringDS := DATASET([{EditsRec}], StringRec);
		
		Layout_RP CreateRPRec(StringDS L) := TRANSFORM
			SELF.UnitNum 					 := L.Rec[1..3];
			SELF.RecCode 					 := L.Rec[4..7];
			SELF.RptRqstrName 		 := L.Rec[8..57];
			SELF.CoName 					 := L.Rec[58..107];
			SELF.ClassCode				 := L.Rec[108..109];
			SELF.Filler1					 := L.Rec[110..150];
		END;
		
		RETURN PROJECT (StringDS, CreateRPRec(LEFT));
	END;

	/* Construct RI02 Layout from Original Edits Record */
	SHARED DATASET(Layout_RI2) GetRI2Recs (STRING EditsRec) := FUNCTION

		// Create dataset in order to project the source record
		StringDS := DATASET([{EditsRec}], StringRec);
		
		Layout_RI2 CreateRI2Rec(StringDS L) := TRANSFORM
			SELF.UnitNum 					 := L.Rec[1..3];
			SELF.RecCode 					 := L.Rec[4..7];
			SELF.CustOrgLvl1Code	 := L.Rec[8..17];
			SELF.CustOrgLvl2Code	 := L.Rec[18..27];
			SELF.CustOrgLvl3Code	 := L.Rec[28..37];
			SELF.CustOrgLvl4Code	 := L.Rec[38..47];
			SELF.RptSplFldId1Desc	 := L.Rec[48..57];
			SELF.RptSplFldId2Desc	 := L.Rec[58..67];
			SELF.RptSplFldId3Desc	 := L.Rec[68..77];
			SELF.RptSplFldIdADesc	 := L.Rec[78..87];
			SELF.RptSplFldIdBDesc	 := L.Rec[88..97];
			SELF.RptSplFldIdCDesc	 := L.Rec[98..107];
			SELF.RptSpecFldId1Num	 := L.Rec[108..111];
			SELF.Filler1					 := L.Rec[112..150];
		END;
		
		RETURN PROJECT (StringDS, CreateRI2Rec(LEFT));
	END;
	
	
	/* Parse/convert the Edits inquiry into record layout */
	EXPORT DATASET(Layout_Order) ParseEditsOrder(DATASET(Layout_StrArrayItem) EditsOrder) := FUNCTION
		
		// Project orignial edits orders onto the order layout
		Layout_Order PopulateOrigEditsToLayout(Layout_StrArrayItem L) := TRANSFORM
			// Populate RI Record
			SELF.RI01_Recs := IF (L.Value[4..7] = Constants.RI_IND, GetRIRecs (L.Value));
			
			// Populate PI Record
			SELF.PI01_Recs := IF (L.Value[4..7] = Constants.PI_IND, GetPIRecs (L.Value));

			// Populate AL Record
			SELF.AL01_Recs := IF (L.Value[4..7] = Constants.AL_IND, GetALRecs (L.Value));

			// Populate DL Record
			SELF.DL01_Recs := IF (L.Value[4..7] = Constants.DL_IND, GetDLRecs (L.Value));

			// Populate RP Record
			SELF.RP01_Recs := IF (L.Value[4..7] = Constants.RP_IND, GetRPRecs (L.Value));

			// Populate RI02 Record
			SELF.RI02_Recs := IF (L.Value[4..7] = Constants.RI2_IND, GetRI2Recs (L.Value));
		END;
		
		Layout_Order TempOrder := PROJECT(EditsOrder, PopulateOrigEditsToLayout(LEFT));
		
		// Rollup the original edits order onto the respective layouts
		Layout_Order BindEditsToLayout(Layout_Order L, Layout_Order R) := TRANSFORM
			
			SELF.RI01_Recs := L.RI01_Recs & R.RI01_Recs;
			SELF.PI01_Recs := L.PI01_Recs & R.PI01_Recs;
			SELF.AL01_Recs := L.AL01_Recs & R.AL01_Recs;
			SELF.DL01_Recs := L.DL01_Recs & R.DL01_Recs;
			SELF.RP01_Recs := L.RP01_Recs & R.RP01_Recs;
			SELF.RI02_Recs := L.RI02_Recs & R.RI02_Recs;
			
		END;
		
		RETURN ROLLUP (TempOrder, true, BindEditsToLayout(LEFT, RIGHT));
	END;
END;
