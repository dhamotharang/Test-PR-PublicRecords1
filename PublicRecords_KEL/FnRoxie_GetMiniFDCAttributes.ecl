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
									
	LayoutPersonAttributes := RECORD
		INTEGER g_uid;
		Dataset(PublicRecords_KEL.KEL_Queries_MAS_Shared.L_Compile.Mini_Attributes_V1_Roxie_Dynamic_Res0_Layout) attributes;
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
	
	PersonAttributesRaw := NOCOMBINE(PROJECT(MiniAttributesInput,
		TRANSFORM(LayoutPersonAttributes,
			SELF.g_uid := LEFT.g_uid;
			PersonResults := PublicRecords_KEL.KEL_Queries_MAS_Shared.Q_Mini_Attributes_V1_Roxie_Dynamic(LEFT.ids, (INTEGER)(LEFT.P_InpClnArchDt[1..8]), Options.KEL_Permissions_Mask, Options.IsFCRA, LEFT.FDCDataset).res0;	
			SELF.attributes := PersonResults;
			SELF := [])));

		
	Final := RECORD
		INTEGER g_uid;
		RECORDOF(PublicRecords_KEL.KEL_Queries_MAS_Shared.L_Compile.Mini_Attributes_V1_Roxie_Dynamic_Res0_Layout);
	END;
	
	Final Normalize_Final(RecordOF(LayoutPersonAttributes.attributes) ri, LayoutPersonAttributes le) := TRANSFORM
		SELF.g_uid := le.g_uid;
		SELF := ri;
		SELF := le;
	END;
			

	norm := normalize(PersonAttributesRaw, left.attributes, Normalize_Final(RIGHT,LEFT));	
	
	PersonAttributesClean := KEL.Clean(norm, TRUE, TRUE, TRUE);	
	
	PersonAttributesWithLexID := JOIN(RecordsWithLexID, PersonAttributesClean, LEFT.g_uid = RIGHT.g_uid AND LEFT.P_LexID  = RIGHT.LexID, 
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII,
			SELF.CurrentAddrPrimRng := RIGHT.PrepCurrentAddrPrimRng;
			SELF.CurrentAddrPreDir := RIGHT.PrepCurrentAddrPreDir;
			SELF.CurrentAddrPrimName := RIGHT.PrepCurrentAddrPrimName;
			SELF.CurrentAddrPostDir  := RIGHT.PrepCurrentPostdirectional;
			SELF.CurrentAddrSffx := RIGHT.PrepCurrentAddrSffx;
			SELF.CurrentAddrSecRng := RIGHT.PrepCurrentAddrSecRng;
			SELF.CurrentAddrState := RIGHT.PrepCurrentAddrState;
			SELF.CurrentAddrZip5 := RIGHT.PrepCurrentAddrZip5;
			SELF.CurrentAddrZip4 := RIGHT.PrepCurrentAddrZip4;
			SELF.CurrentAddrStateCode := RIGHT.PrepCurrentAddrStateCode;
			SELF.CurrentAddrCnty := RIGHT.PrepCurrentAddrCnty;
			SELF.CurrentAddrGeo := RIGHT.PrepCurrentAddrGeo;
			SELF.CurrentAddrCity  := RIGHT.PrepCurrentAddrCity;
			SELF.CurrentAddrLat := RIGHT.PrepCurrentAddrLat;
			SELF.CurrentAddrLng := RIGHT.PrepCurrentAddrLng;
			SELF.CurrentAddrUnitDesignation := RIGHT.PrepCurrentAddrUnitDesignation;
			SELF.CurrentAddrType := RIGHT.PrepCurrentAddrType;
			SELF.CurrentAddrStatus := RIGHT.PrepCurrentAddrStatus;
			SELF.CurrentAddrDateFirstSeen := RIGHT.PrepCurrentAddrDateFirstSeen;
			SELF.CurrentAddrDateLastSeen := RIGHT.PrepCurrentAddrDateLastSeen;
			SELF.CurrentAddrFull  := RIGHT.PrepCurrentAddrFull;
			SELF.PreviousAddrPrimRng := RIGHT.PrepPreviousAddrPrimRng;
			SELF.PreviousAddrPreDir := RIGHT.PrepPreviousAddrPreDir;
			SELF.PreviousAddrPrimName := RIGHT.PrepPreviousAddrPrimName;
			SELF.PreviousAddrPostdir := RIGHT.PrepPreviousPostdirectional;
			SELF.PreviousAddrSffx := RIGHT.PrepPreviousAddrSffx;
			SELF.PreviousAddrSecRng := RIGHT.PrepPreviousAddrSecRng;
			SELF.PreviousAddrState := RIGHT.PrepPreviousAddrState;
			SELF.PreviousAddrZip5 := RIGHT.PrepPreviousAddrZip5;
			SELF.PreviousAddrZip4 := RIGHT.PrepPreviousAddrZip4;
			SELF.PreviousAddrStateCode := RIGHT.PrepPreviousAddrStateCode;
			SELF.PreviousAddrCnty := RIGHT.PrepPreviousAddrCnty;
			SELF.PreviousAddrGeo := RIGHT.PrepPreviousAddrGeo;
			SELF.PreviousAddrCity := RIGHT.PrepPreviousAddrCity;
			SELF.PreviousAddrLat := RIGHT.PrepPreviousAddrLat;
			SELF.PreviousAddrLng := RIGHT.PrepPreviousAddrLng;
			SELF.PreviousAddrUnitDesignation := RIGHT.PrepPreviousAddrUnitDesignation;
			SELF.PreviousAddrType := RIGHT.PrepPreviousAddrType;
			SELF.PreviousAddrStatus := RIGHT.PrepPreviousAddrStatus;
			SELF.PreviousAddrDateFirstSeen := RIGHT.PrepPreviousAddrDateFirstSeen;
			SELF.PreviousAddrDateLastSeen := RIGHT.PrepPreviousAddrDateLastSeen;
			SELF.PreviousAddrFull := RIGHT.PrepPreviousAddrFull;
			
			self.EmergingAddrPrimRng:= RIGHT.EmergingAddrPrimRng;
			self.EmergingAddrPreDir:= RIGHT.EmergingAddrPreDir;
			self.EmergingAddrPrimName:= RIGHT.EmergingAddrPrimName;
			self.EmergingAddrSffx:= RIGHT.EmergingAddrSffx;
			self.EmergingAddrPostDir:= RIGHT.EmergingPostdirectional;
			self.EmergingAddrSecRng:= RIGHT.EmergingAddrSecRng;
			self.EmergingAddrState:= RIGHT.EmergingAddrState;
			self.EmergingAddrZip5:= (STRING)RIGHT.EmergingAddrZip5;
			self.EmergingAddrStateCode:= (STRING)RIGHT.EmergingAddrStateCode;
			self.EmergingAddrCnty:= (STRING)RIGHT.EmergingAddrCnty;
			self.EmergingAddrGeo:= (STRING)RIGHT.EmergingAddrGeo;

			SELF.BestNameFirst := RIGHT.PL_BestNameFirst;
			SELF.BestNameMid := RIGHT.PL_BestNameMid;
			SELF.BestNameLast := RIGHT.PL_BestNameLast;;
			SELF.BestSSN := RIGHT.PL_BestSSN;;
			SELF.BestDOB := RIGHT.PL_BestDOB;;
									
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