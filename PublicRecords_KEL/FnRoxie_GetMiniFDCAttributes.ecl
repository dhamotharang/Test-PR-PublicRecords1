IMPORT KEL11 AS KEL;
IMPORT PublicRecords_KEL, Risk_Indicators, STD;

EXPORT FnRoxie_GetMiniFDCAttributes(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) InputData,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset,
			PublicRecords_KEL.Interface_Options Options) := FUNCTION

	Common_Functions := PublicRecords_KEL.ECL_Functions.Common_Functions;
	OptionsMini := PublicRecords_KEL.Interface_Mini_Options(Options);

	Get_Lexids_FDC := table(FDCDataset.Dataset_Header__Key_Addr_Hist, {p_lexid, G_ProcUID,
															_count := count(group)}, p_lexid, G_ProcUID, merge);
		
	contact_inputs := project(Get_Lexids_FDC, transform(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII, self.p_lexid := left.p_lexid, self.G_ProcUID := left.G_ProcUID; self := []));							
	
	Combine_InputData := 	dedup(sort((contact_inputs+InputData),G_ProcUID,  p_lexid,  -p_lexidscore ),  G_ProcUID, p_lexid ); //keep the row with the input
	
	RecordsWithLexID := Combine_InputData(P_LexID  > 0);
	RecordsWithoutLexID := Combine_InputData(P_LexID  <= 0);	

	temp := RECORD
		SET ids;
		PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII;
	end;
	
	getids := project(Get_Lexids_FDC, transform(temp, self.ids := SET(Get_Lexids_FDC, P_LexID); self := left;  self := [];));			

	Outids := join(RecordsWithLexID, getids, LEFT.p_lexid = right.p_lexid,	
							transform(temp, self.ids := right.ids, self := left;), left outer, atmost(1));
								
	CleanInputs := Outids((INTEGER)p_inparchdt <> 0);//keeping the record with inputs
	
	LayoutFCRAPersonAttributes := RECORD
		INTEGER G_ProcUID;
		Dataset({RECORDOF(PublicRecords_KEL.Q_F_C_R_A_Mini_Attributes_V1([], 0, 0).res0)}) attributes;
	END;
	LayoutNonFCRAPersonAttributes := RECORD
		INTEGER G_ProcUID;
		Dataset({RECORDOF(PublicRecords_KEL.Q_Non_F_C_R_A_Mini_Attributes_V1([], 0, 0).res0)}) attributes;
	END;
	
	NonFCRAPersonAttributesRaw := PROJECT(CleanInputs, TRANSFORM(LayoutNonFCRAPersonAttributes,
		SELF.G_ProcUID := LEFT.G_ProcUID;
		NonFCRAPersonResults := PublicRecords_KEL.Q_Non_F_C_R_A_Mini_Attributes_V1(LEFT.ids , (INTEGER)(LEFT.P_InpClnArchDt[1..8]), OptionsMini.KEL_Permissions_Mask, FDCDataset).res0;	
		SELF.attributes := NonFCRAPersonResults;
		SELF := []));	

	FCRAPersonAttributesRaw := PROJECT(CleanInputs, TRANSFORM(LayoutFCRAPersonAttributes,
		SELF.G_ProcUID := LEFT.G_ProcUID;
		FCRAPersonResults := PublicRecords_KEL.Q_F_C_R_A_Mini_Attributes_V1(LEFT.ids , (INTEGER)(LEFT.P_InpClnArchDt[1..8]), OptionsMini.KEL_Permissions_Mask, FDCDataset).res0;	
		SELF.attributes := FCRAPersonResults;
		SELF := []));	
			
	FinalnonFCRA := RECORD
		INTEGER G_ProcUID;
		RECORDOF(PublicRecords_KEL.Q_Non_F_C_R_A_Mini_Attributes_V1([], 0, 0).res0);
	END;	
	FinalFCRA := RECORD
		INTEGER G_ProcUID;
		RECORDOF(PublicRecords_KEL.Q_F_C_R_A_Mini_Attributes_V1([], 0, 0).res0);
	END;
	
	FinalnonFCRA Normalize_FinalnonFCRA(RecordOF(LayoutNonFCRAPersonAttributes.attributes) ri, LayoutNonFCRAPersonAttributes le) := TRANSFORM
		SELF.G_ProcUID := le.G_ProcUID;
		SELF := ri;
		SELF := le;
	END;
			
	FinalFCRA Normalize_FinalFCRA(RecordOF(LayoutFCRAPersonAttributes.attributes) ri, LayoutFCRAPersonAttributes le) := TRANSFORM
		SELF.G_ProcUID := le.G_ProcUID;	
		SELF := ri;
		SELF := le;
	END;
		
	norm_nonFCRA := normalize(NonFCRAPersonAttributesRaw, left.attributes, Normalize_FinalnonFCRA(RIGHT,LEFT));
	norm_FCRA := normalize(FCRAPersonAttributesRaw, left.attributes, Normalize_FinalFCRA(RIGHT,LEFT));
	
	
	PersonAttributesClean := IF(OptionsMini.IsFCRA, 
															KEL.Clean(norm_FCRA, TRUE, TRUE, TRUE),
															KEL.Clean(norm_nonFCRA, TRUE, TRUE, TRUE));	
	
	PersonAttributesWithLexID := JOIN(RecordsWithLexID, PersonAttributesClean, LEFT.G_ProcUID = RIGHT.G_ProcUID AND LEFT.P_LexID  = RIGHT.LexID, 
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII,
			ResultsFound := RIGHT.LexID > 0;
			P_LexIDSeenFlag := IF(ResultsFound,RIGHT.P_LexIDSeenFlag,'0');
			LexIDNotOnFile := P_LexIDSeenFlag = '0';
			self.CurrentAddrPrimRng :=  IF(ResultsFound, RIGHT.CurrentAddrPrimRng, '');
			self.CurrentAddrPreDir:= IF(ResultsFound, RIGHT.CurrentAddrPreDir, '');
			self.CurrentAddrPrimName:= IF(ResultsFound, RIGHT.CurrentAddrPrimName, '');
			self.CurrentAddrSffx:= IF(ResultsFound, RIGHT.CurrentAddrSffx, '');
			self.CurrentAddrSecRng:= IF(ResultsFound, RIGHT.CurrentAddrSecRng, '');
			self.CurrentAddrState:= IF(ResultsFound, RIGHT.CurrentAddrState, '');
			self.CurrentAddrZip5:= IF(ResultsFound, (STRING)RIGHT.CurrentAddrZip5, '');
			self.CurrentAddrStateCode:= IF(ResultsFound, (STRING)RIGHT.CurrentAddrStateCode, '');
			self.CurrentAddrCnty:= IF(ResultsFound, (STRING)RIGHT.CurrentAddrCnty, '');
			self.CurrentAddrGeo:= IF(ResultsFound, (STRING)RIGHT.CurrentAddrGeo, '');
			self.PreviousAddrPrimRng:= IF(ResultsFound, RIGHT.PreviousAddrPrimRng, '');
			self.PreviousAddrPreDir:= IF(ResultsFound, RIGHT.PreviousAddrPreDir, '');
			self.PreviousAddrPrimName:= IF(ResultsFound, RIGHT.PreviousAddrPrimName, '');
			self.PreviousAddrSffx:= IF(ResultsFound, RIGHT.PreviousAddrSffx, '');
			self.PreviousAddrSecRng:= IF(ResultsFound, RIGHT.PreviousAddrSecRng, '');
			self.PreviousAddrState:= IF(ResultsFound, RIGHT.PreviousAddrState, '');
			self.PreviousAddrZip5:= IF(ResultsFound, (STRING)RIGHT.PreviousAddrZip5, '');
			self.PreviousAddrStateCode:= IF(ResultsFound, (STRING)RIGHT.PreviousAddrStateCode, '');
			self.PreviousAddrCnty:= IF(ResultsFound, (STRING)RIGHT.PreviousAddrCnty, '');
			self.PreviousAddrGeo:= IF(ResultsFound, (STRING)RIGHT.PreviousAddrGeo, '');
			self.EmergingAddrPrimRng:= IF(ResultsFound, RIGHT.EmergingAddrPrimRng, '');
			self.EmergingAddrPreDir:= IF(ResultsFound, RIGHT.EmergingAddrPreDir, '');
			self.EmergingAddrPrimName:= IF(ResultsFound, RIGHT.EmergingAddrPrimName, '');
			self.EmergingAddrSffx:= IF(ResultsFound, RIGHT.EmergingAddrSffx, '');
			self.EmergingAddrSecRng:= IF(ResultsFound, RIGHT.EmergingAddrSecRng, '');
			self.EmergingAddrState:= IF(ResultsFound, RIGHT.EmergingAddrState, '');
			self.EmergingAddrZip5:= IF(ResultsFound, (STRING)RIGHT.EmergingAddrZip5, '');
			self.EmergingAddrStateCode:= IF(ResultsFound, (STRING)RIGHT.EmergingAddrStateCode, '');
			self.EmergingAddrCnty:= IF(ResultsFound, (STRING)RIGHT.EmergingAddrCnty, '');
			self.EmergingAddrGeo:= IF(ResultsFound, (STRING)RIGHT.EmergingAddrGeo, '');
			SELF := LEFT;
			SELF := [];),LEFT OUTER, KEEP(1)); 
	
	PersonAttributesWithoutLexID := PROJECT(RecordsWithoutLexID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII,
			self.CurrentAddrPrimRng:= '';
			self.CurrentAddrPreDir:= '';
			self.CurrentAddrPrimName:= '';
			self.CurrentAddrSffx:= '';
			self.CurrentAddrSecRng:= '';
			self.CurrentAddrState:= '';
			self.CurrentAddrZip5:= '';
			self.CurrentAddrStateCode:= '';
			self.CurrentAddrCnty:= '';
			self.CurrentAddrGeo:= '';
			self.PreviousAddrPrimRng:= '';
			self.PreviousAddrPreDir:= '';
			self.PreviousAddrPrimName:= '';
			self.PreviousAddrSffx:= '';
			self.PreviousAddrSecRng:= '';
			self.PreviousAddrState:= '';	
			self.PreviousAddrZip5:= '';	
			self.PreviousAddrStateCode:= '';	
			self.PreviousAddrCnty:= '';	
			self.PreviousAddrGeo:= '';	
			self.EmergingAddrPrimRng:= '';
			self.EmergingAddrPreDir:= '';
			self.EmergingAddrPrimName:= '';
			self.EmergingAddrSffx:= '';
			self.EmergingAddrSecRng:= '';
			self.EmergingAddrState	:= '';					
			self.EmergingAddrZip5	:= '';					
			self.EmergingAddrStateCode	:= '';					
			self.EmergingAddrCnty	:= '';					
			self.EmergingAddrGeo	:= '';					
			SELF := LEFT,
			Self := [];)); 
			
	MiniAttributes := SORT( PersonAttributesWithLexID + PersonAttributesWithoutLexID, G_ProcUID ); 

	RETURN MiniAttributes;
END;
