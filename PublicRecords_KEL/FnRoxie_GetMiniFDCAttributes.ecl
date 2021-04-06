IMPORT KEL13 AS KEL;
IMPORT PublicRecords_KEL, Risk_Indicators, STD;

EXPORT FnRoxie_GetMiniFDCAttributes(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) InputData,
			DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset,
			PublicRecords_KEL.Interface_Options Options) := FUNCTION

	Common_Functions := PublicRecords_KEL.ECL_Functions.Common_Functions;

	Get_Lexids_FDC := table(FDCDataset.Dataset_Header__Key_Addr_Hist, {p_lexid, UIDAppend, G_ProcUID,
															_count := count(group)}, p_lexid, UIDAppend, G_ProcUID, merge);
		
	contact_inputs := project(Get_Lexids_FDC, transform(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII, self.p_lexid := left.p_lexid, self.G_UID := left.UIDAppend; self.G_ProcUID := left.G_ProcUID; self := []));							
	Input_Data := project(InputData, transform(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII, 
										self.G_UID := IF( left.g_procbusuid > 0, left.g_procbusuid, left.g_procuid); 
										self.p_lexidscore := if(left.p_lexidscore = PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT, (-1*left.p_lexidscore),left.p_lexidscore); 
										self.IsInputRec := TRUE;
										self := left));							
	
	Combine_InputData := 	dedup(sort((contact_inputs+Input_Data),G_UID, G_ProcUID,  p_lexid,  -p_lexidscore ), G_UID, G_ProcUID, p_lexid ); //keep the row with the input
	
	RecordsWithLexID := Combine_InputData(P_LexID  > 0);
	RecordsWithoutLexID := Combine_InputData(P_LexID  <= 0);	

	temp := RECORD
		SET ids;
		PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII;
		DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset;
	end;
	
	getids := project(Combine_InputData, transform(temp, self.ids := SET(Get_Lexids_FDC, P_LexID); self := left;  self := [];));			
						
	CleanInputs := getids(P_LexID  > 0 and (INTEGER)p_inpclnarchdt <> 0);
									
	LayoutFCRAPersonAttributes := RECORD
		INTEGER g_uid;
		Dataset({RECORDOF(PublicRecords_KEL.Q_Non_F_C_R_A_Mini_Attributes_V1_Roxie_Dynamic([], 0, PublicRecords_KEL.CFG_Compile.Permit__NONE).res0)}) attributes;
	END;
	LayoutNonFCRAPersonAttributes := RECORD
		INTEGER g_uid;
		Dataset({RECORDOF(PublicRecords_KEL.Q_F_C_R_A_Mini_Attributes_V1_Roxie_Dynamic([], 0, PublicRecords_KEL.CFG_Compile.Permit__NONE).res0)}) attributes;
	END;
	
	FDCRolled := ROLLUP(SORT(FDCDataset, UIDAppend, RepNumber), LEFT.UIDAppend = RIGHT.UIDAppend, TRANSFORM(RECORDOF(LEFT),
		SELF.Dataset_Header__key_ADL_segmentation := LEFT.Dataset_Header__key_ADL_segmentation + RIGHT.Dataset_Header__key_ADL_segmentation,
		SELF.Dataset_Best_Person__Key_Watchdog := LEFT.Dataset_Best_Person__Key_Watchdog + RIGHT.Dataset_Best_Person__Key_Watchdog,
		SELF.Dataset_Header_Quick__Key_Did := LEFT.Dataset_Header_Quick__Key_Did + RIGHT.Dataset_Header_Quick__Key_Did,
		SELF.Dataset_Doxie__Key_Header := LEFT.Dataset_Doxie__Key_Header + RIGHT.Dataset_Doxie__Key_Header,
		SELF.Dataset_Header__Key_Addr_Hist := LEFT.Dataset_Header__Key_Addr_Hist + RIGHT.Dataset_Header__Key_Addr_Hist,
		SELF := LEFT));
		
		
	// For business transactions, Rep 1 and Rep 6 lexids are input as a set in one row to KEL, so we need to denorm the FDC to include both the 6th rep data and all the other business/rep data.
	MiniAttributesInput := DENORMALIZE(CleanInputs, FDCRolled, LEFT.g_uid = RIGHT.UIDAppend, TRANSFORM(temp, SELF.FDCDataset := DATASET(RIGHT), SELF := LEFT));
	
	NonFCRAPersonAttributesRaw := NOCOMBINE(PROJECT(MiniAttributesInput,
		TRANSFORM(LayoutNonFCRAPersonAttributes,
			SELF.g_uid := LEFT.g_uid;
			NonFCRAPersonResults := PublicRecords_KEL.Q_Non_F_C_R_A_Mini_Attributes_V1_Roxie_Dynamic(LEFT.ids, (INTEGER)(LEFT.P_InpClnArchDt[1..8]), Options.KEL_Permissions_Mask, LEFT.FDCDataset).res0;	
			SELF.attributes := NonFCRAPersonResults;
			SELF := [])));
		
	FCRAPersonAttributesRaw := NOCOMBINE(PROJECT(MiniAttributesInput,
		TRANSFORM(LayoutFCRAPersonAttributes,
			SELF.g_uid := LEFT.g_uid;
			FCRAPersonResults := PublicRecords_KEL.Q_F_C_R_A_Mini_Attributes_V1_Roxie_Dynamic(LEFT.ids, (INTEGER)(LEFT.P_InpClnArchDt[1..8]), Options.KEL_Permissions_Mask, LEFT.FDCDataset).res0;	
			SELF.attributes := FCRAPersonResults;
			SELF := [])));

		
	FinalnonFCRA := RECORD
		INTEGER g_uid;
		RECORDOF(PublicRecords_KEL.Q_Non_F_C_R_A_Mini_Attributes_V1_Roxie_Dynamic([], 0, PublicRecords_KEL.CFG_Compile.Permit__NONE).res0);
	END;	
	FinalFCRA := RECORD
		INTEGER g_uid;
		RECORDOF(PublicRecords_KEL.Q_F_C_R_A_Mini_Attributes_V1_Roxie_Dynamic([], 0, PublicRecords_KEL.CFG_Compile.Permit__NONE).res0);
	END;
	
	FinalnonFCRA Normalize_FinalnonFCRA(RecordOF(LayoutNonFCRAPersonAttributes.attributes) ri, LayoutNonFCRAPersonAttributes le) := TRANSFORM
		SELF.g_uid := le.g_uid;
		SELF := ri;
		SELF := le;
	END;
			
	FinalFCRA Normalize_FinalFCRA(RecordOF(LayoutFCRAPersonAttributes.attributes) ri, LayoutFCRAPersonAttributes le) := TRANSFORM
		SELF.g_uid := le.g_uid;	
		SELF := ri;
		SELF := le;
	END;
		
	norm_nonFCRA := normalize(NonFCRAPersonAttributesRaw, left.attributes, Normalize_FinalnonFCRA(RIGHT,LEFT));
	norm_FCRA := normalize(FCRAPersonAttributesRaw, left.attributes, Normalize_FinalFCRA(RIGHT,LEFT));
	
	
	PersonAttributesClean := IF(Options.IsFCRA, 
															KEL.Clean(norm_FCRA, TRUE, TRUE, TRUE),
															KEL.Clean(norm_nonFCRA, TRUE, TRUE, TRUE));	
	
	PersonAttributesWithLexID := JOIN(RecordsWithLexID, PersonAttributesClean, LEFT.g_uid = RIGHT.g_uid AND LEFT.P_LexID  = RIGHT.LexID, 
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII,
			ResultsFound := RIGHT.LexID > 0;
			P_LexIDSeenFlag := IF(ResultsFound,RIGHT.P_LexIDSeenFlag,'0');
			LexIDNotOnFile := P_LexIDSeenFlag = '0';
			self.CurrentAddrPrimRng :=  IF(ResultsFound, RIGHT.CurrentAddrPrimRng, '');
			self.CurrentAddrPreDir:= IF(ResultsFound, RIGHT.CurrentAddrPreDir, '');
			self.CurrentAddrPrimName:= IF(ResultsFound, RIGHT.CurrentAddrPrimName, '');
			self.CurrentAddrSffx:= IF(ResultsFound, RIGHT.CurrentAddrSffx, '');
			self.CurrentAddrPostDir := IF(ResultsFound, RIGHT.CurrentPostdirectional, '');
			self.CurrentAddrSecRng:= IF(ResultsFound, RIGHT.CurrentAddrSecRng, '');
			self.CurrentAddrState:= IF(ResultsFound, RIGHT.CurrentAddrState, '');
			self.CurrentAddrZip5:= IF(ResultsFound, (STRING)RIGHT.CurrentAddrZip5, '');
			self.CurrentAddrStateCode:= IF(ResultsFound, (STRING)RIGHT.CurrentAddrStateCode, '');
			self.CurrentAddrCnty:= IF(ResultsFound, (STRING)RIGHT.CurrentAddrCnty, '');
			self.CurrentAddrGeo:= IF(ResultsFound, (STRING)RIGHT.CurrentAddrGeo, '');
			self.CurrentAddrCity:= IF(ResultsFound, (STRING)RIGHT.CurrentAddrCity, '');
			self.PreviousAddrPrimRng:= IF(ResultsFound, RIGHT.PreviousAddrPrimRng, '');
			self.PreviousAddrPreDir:= IF(ResultsFound, RIGHT.PreviousAddrPreDir, '');
			self.PreviousAddrPrimName:= IF(ResultsFound, RIGHT.PreviousAddrPrimName, '');
			self.PreviousAddrSffx:= IF(ResultsFound, RIGHT.PreviousAddrSffx, '');
			self.PreviousAddrPostDir:= IF(ResultsFound, RIGHT.PreviousPostdirectional, '');
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
			self.EmergingAddrPostDir:= IF(ResultsFound, RIGHT.EmergingPostdirectional, '');
			self.EmergingAddrSecRng:= IF(ResultsFound, RIGHT.EmergingAddrSecRng, '');
			self.EmergingAddrState:= IF(ResultsFound, RIGHT.EmergingAddrState, '');
			self.EmergingAddrZip5:= IF(ResultsFound, (STRING)RIGHT.EmergingAddrZip5, '');
			self.EmergingAddrStateCode:= IF(ResultsFound, (STRING)RIGHT.EmergingAddrStateCode, '');
			self.EmergingAddrCnty:= IF(ResultsFound, (STRING)RIGHT.EmergingAddrCnty, '');
			self.EmergingAddrGeo:= IF(ResultsFound, (STRING)RIGHT.EmergingAddrGeo, '');

			SELF.BestNameFirst := IF(ResultsFound, (STRING)RIGHT.PL_BestNameFirst, '');
			SELF.BestNameMid := IF(ResultsFound, (STRING)RIGHT.PL_BestNameMid, '');
			SELF.BestNameLast := IF(ResultsFound, (STRING)RIGHT.PL_BestNameLast, '');
			SELF.BestSSN := IF(ResultsFound, (STRING)RIGHT.PL_BestSSN, '');
			SELF.BestDOB := IF(ResultsFound, (STRING)RIGHT.PL_BestDOB, '');
									
			self.p_lexidscore := if(left.p_lexidscore =  (-1*PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT),PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,left.p_lexidscore);//have to put this back
			SELF := LEFT;
			SELF := [];),LEFT OUTER, KEEP(1)); 
	
	PersonAttributesWithoutLexID := PROJECT(RecordsWithoutLexID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII,
			self.CurrentAddrPrimRng:= '';
			self.CurrentAddrPreDir:= '';
			self.CurrentAddrPrimName:= '';
			self.CurrentAddrSffx:= '';
			self.CurrentAddrPostDir:= '';
			self.CurrentAddrSecRng:= '';
			self.CurrentAddrState:= '';
			self.CurrentAddrZip5:= '';
			self.CurrentAddrStateCode:= '';
			self.CurrentAddrCnty:= '';
			self.CurrentAddrGeo:= '';
			self.CurrentAddrCity:= '';
			self.PreviousAddrPrimRng:= '';
			self.PreviousAddrPreDir:= '';
			self.PreviousAddrPrimName:= '';
			self.PreviousAddrSffx:= '';
			self.PreviousAddrPostDir:= '';
			self.PreviousAddrSecRng:= '';
			self.PreviousAddrState:= '';	
			self.PreviousAddrZip5:= '';	
			self.PreviousAddrStateCode:= '';	
			self.PreviousAddrCnty:= '';	
			self.PreviousAddrGeo:= '';	
			self.EmergingAddrPrimRng:= '';
			self.EmergingAddrZip5	:= '';					
			self.EmergingAddrStateCode	:= '';					
			self.EmergingAddrCnty	:= '';					
			self.EmergingAddrGeo	:= '';					
			self.EmergingAddrPreDir:= '';
			self.EmergingAddrPrimName:= '';
			self.EmergingAddrSffx:= '';
			self.EmergingAddrPostDir:= '';
			self.EmergingAddrSecRng:= '';
			self.EmergingAddrState	:= '';	
			
			self.BestNameFirst	:= '';					
			self.BestNameMid	:= '';					
			self.BestNameLast	:= '';					
			self.BestSSN	:= '';					
			self.BestDOB	:= '';					
			SELF := LEFT,			
			
			Self := [];)); 
			

//if input was from business g_procbusuid then do nothing. else if input is comsumer and append best data then project best data into clean fields for next round of FDC.
ds_append_best := project(PersonAttributesWithLexID, transform(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII, 
		self.P_InpClnNameFirst := left.BestNameFirst;
		self.P_InpClnNameMid := left.BestNameMid;
		self.P_InpClnNameLast := left.BestNameLast;
		self.P_InpClnSSN := left.BestSSN;
		self.P_InpClnDOB := left.BestDOB;
		self.P_InpClnAddrPrimRng := left.CurrentAddrPrimRng;
		self.P_InpClnAddrPreDir := left.CurrentAddrPreDir;
		self.P_InpClnAddrPrimName := left.CurrentAddrPrimName;
		self.P_InpClnAddrSffx := left.CurrentAddrSffx;
		self.P_InpClnAddrPostDir := left.CurrentAddrPostDir;
		self.P_InpClnAddrCity := left.CurrentAddrCity;
		self.P_InpClnAddrState := left.CurrentAddrState;
		self.P_InpClnAddrZip5 := left.CurrentAddrZip5;
		self.P_InpClnAddrSecRng := left.CurrentAddrSecRng;
		self.P_InpClnAddrStateCode := left.CurrentAddrStateCode;
		self.P_InpClnAddrCnty := left.CurrentAddrCnty;
		self.P_InpClnAddrGeo := left.CurrentAddrGeo;
		self.PI_BestDataAppended := TRUE;
		self.PL_BestNameAppendFlag:= TRUE;
		self.PL_BestSSNAppendFlag:= TRUE;
		self.PL_BestAddrAppendFlag:= TRUE;
		self.PL_BestDOBAppendFlag:= TRUE;
		self.PL_BestPhoneAppendFlag:= FALSE;//no phone yet
		self := left;
		self := [];));
		
	prescreenappend := project(PersonAttributesWithLexID, transform(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII, 
		self.P_InpClnSSN := left.BestSSN;
		self.P_InpClnDOB := left.BestDOB;
		self.P_InpClnAddrPrimRng := left.CurrentAddrPrimRng;
		self.P_InpClnAddrPreDir := left.CurrentAddrPreDir;
		self.P_InpClnAddrPrimName := left.CurrentAddrPrimName;
		self.P_InpClnAddrSffx := left.CurrentAddrSffx;
		self.P_InpClnAddrPostDir := left.CurrentAddrPostDir;
		self.P_InpClnAddrCity := left.CurrentAddrCity;
		self.P_InpClnAddrState := left.CurrentAddrState;
		self.P_InpClnAddrZip5 := left.CurrentAddrZip5;
		self.P_InpClnAddrSecRng := left.CurrentAddrSecRng;
		self.P_InpClnAddrStateCode := left.CurrentAddrStateCode;
		self.P_InpClnAddrCnty := left.CurrentAddrCnty;
		self.P_InpClnAddrGeo := left.CurrentAddrGeo;
		self.PI_BestDataAppended := TRUE;
		self.PL_BestSSNAppendFlag:= TRUE;
		self.PL_BestAddrAppendFlag:= TRUE;
		self.PL_BestDOBAppendFlag:= TRUE;
		self.PL_BestPhoneAppendFlag:= FALSE;//no phone yet
		self := left;
		self := [];));
		
	
	appendssnonly := project(PersonAttributesWithLexID, transform(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII, 
		self.P_InpClnSSN := IF((TRIM((STRING)left.P_InpClnSSN, left, right) = '') , left.BestSSN, left.P_InpClnSSN);
		self.PI_BestDataAppended :=  IF((TRIM((STRING)left.P_InpClnSSN, left, right) = ''), TRUE,false);
		self.PL_BestSSNAppendFlag:= self.PI_BestDataAppended;
		self := left;
		self := [];));

	MiniAttributesPre := IF(Options.BestPIIAppend  ,ds_append_best, //append best, append all like LI mode in boca she
															IF((Options.IsPrescreen and Options.RetainInputLexid), prescreenappend, //prescreen append all but name components
																	IF((Options.IsPrescreen and NOT Options.RetainInputLexid), appendssnonly ,PersonAttributesWithLexID)));//prescreen withno lexid on input, only append ssn if 4 digits or less, do not append the others

	MiniAttributes := SORT( MiniAttributesPre + PersonAttributesWithoutLexID, G_ProcUID ); 

	RETURN MiniAttributes;
END;	