import PublicRecords_KEL, Inquiry_Deltabase, Gateway, risk_indicators, std, MDR;

//inquriy delta base is not archivable
	
EXPORT Deltabase_Inquiry(PublicRecords_KEL.Interface_Options Options) := MODULE 

SHARED Layouts_FDC  := PublicRecords_KEL.ECL_Functions.Layouts_FDC(Options);
SHARED NotRegulated := PublicRecords_KEL.ECL_Functions.Constants.NotRegulated;
SHARED BlankString  := PublicRecords_KEL.ECL_Functions.Constants.BlankString;
SHARED SetDPMBitmap := PublicRecords_KEL.ECL_Functions.Fn_KEL_DPMBitmap.SetValue;
SHARED CFG_File     := PublicRecords_KEL.KEL_Queries_MAS_Shared.C_Compile;

SHARED DOBPaddingLayout := RECORD
	UNSIGNED4 DOB;
	STRING8 DOBPadded;
END;
SHARED CleanDateOfBirth(UNSIGNED4 dob_in) := FUNCTION
	Result := MAP(
		STD.Date.IsValidDate(dob_in)										=> ROW({dob_in, ''}, DOBPaddingLayout),
		STD.Date.IsValidDate((UNSIGNED4)(((STRING)dob_in)[1..6] + '01'))	=> ROW({(((STRING)dob_in)[1..6] + '01'), 'YYYYMM01'}, DOBPaddingLayout),
		STD.Date.IsValidDate((UNSIGNED4)(((STRING)dob_in)[1..4] + '0101'))	=> ROW({(((STRING)dob_in)[1..4] + '0101'), 'YYYY0101'}, DOBPaddingLayout),
																				ROW({dob_in, ''}, DOBPaddingLayout));
		
	RETURN Result;
END;


EXPORT GetDeltaBaseRec(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII_Overrides) shell) := function
													
	deltabase_Name := Options.gateways(servicename = Gateway.Constants.ServiceName.DeltaInquiry)[1].servicename;
	deltabase_check := Options.gateways(servicename = Gateway.Constants.ServiceName.DeltaInquiry)[1].url;

prep_input := PROJECT( shell,
				TRANSFORM( Layouts_FDC.LayoutInquiries,
					SELF.UIDAppend 				:=  LEFT.G_ProcUID,
					SELF.G_ProcUID 				:= LEFT.G_ProcUID,				
					SELF.P_LexID 					:= LEFT.P_LexID,				
					SELF.P_InpClnEmail 	 	:= LEFT.P_InpClnEmail,
					SELF.P_InpClnSSN 		 	:= LEFT.P_InpClnSSN,
					SELF.PrimaryRange    	:= LEFT.P_InpClnAddrPrimRng,
					SELF.PrimaryName     	:= LEFT.P_InpClnAddrPrimName,
					SELF.Postdirectional 	:= LEFT.P_InpClnAddrPostDir,
					SELF.ZIP5            	:= LEFT.P_InpClnAddrZip5,
					SELF.SecondaryRange  	:= LEFT.P_InpClnAddrSecRng,
					SELF.Phone					  := LEFT.P_InpClnPhoneHome,//dont need work phone into inq since boca shell only searching 1 phone
					SELF := LEFT,
					SELF := []));

																											
	//MS-160
	deltabase_URL := if((unsigned)prep_input[1].p_inpclnarchdt = (unsigned)(((string)risk_indicators.iid_constants.todaydate)[1..8]) and ~Options.isFCRA, deltabase_check, '');	
		
	DeltabaseGateway := DATASET([TRANSFORM(Gateway.Layouts.Config, SELF.ServiceName := deltabase_Name;
																																								 SELF.URL := deltabase_URL;
																																								 SELF := [])]);	
		
	deltaBase_all_ds := project(prep_input, transform(Inquiry_Deltabase.Layouts.Input_Deltabase_All,
																															self.seq := left.UIDAppend;
																															self.did := left.P_LexID;
																															self.SSN := left.P_InpClnSSN;
																															self.Prim_Range := left.PrimaryRange;
																															self.Prim_Name := left.PrimaryName;
																															self.Sec_Range := left.SecondaryRange;
																															self.Zip5 := left.ZIP5;
																															self.Phone10 := left.Phone;
																															self.Email := left.P_InpClnEmail));	

	// RQ-19982 - to speed up deltabase, we remove the function descriptions from the where clause and increased the limit on the SQL per join to 50 instead of 10																		
	deltaBase_all_results 		:= Inquiry_Deltabase.Search_All(deltaBase_all_ds, '50', DeltabaseGateway);//boca shell says 50, if testing increase so you can find all of the Search_Types
		
	deltaBase_slim_results := deltaBase_all_results(#EXPAND(PublicRecords_KEL.ECL_Functions.AccLogs_Constants.inquiry_is_ok_nonFCRA));
	// deltaBase_slim_results := deltaBase_all_results;//if you are doing testing its helpful to take off the filter

	return deltaBase_slim_results;
end;


EXPORT Inquiry_Address(DATASET(Inquiry_Deltabase.Layouts.Inquiry_All) deltabase) := FUNCTION


	deltabase_address_results := deltabase(Zip5 <> '' AND Prim_Name <> '' AND Search_Type='1');

	deltabasetrans_addr := project(deltabase_address_results, transform(Layouts_FDC.Layout_Inquiry_AccLogs__Inquiry_Table_Address,
					SELF.UIDAppend := LEFT.seq,
					SELF.G_ProcUID := LEFT.seq,
					SELF.DateOfInquiry := LEFT.Search_Info.DateTime[1..8];
					SELF.Src := MDR.sourceTools.src_InquiryAcclogs,
					SELF.IsUpdateRecord := FALSE,  //to help with debugging and data questions
					SELF.IsDeltaBaseRecord := TRUE, 
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date := '';
					DOBCleaned := CleanDateOfBirth((UNSIGNED)LEFT.person_q.dob);
					SELF.person_q.dob := (STRING)DOBCleaned.dob;
					SELF.DOBPadded := DOBCleaned.DOBPadded;
					SELF := LEFT,
					SELF := [])); 

	return deltabasetrans_addr;
end;

EXPORT Inquiry_Did(DATASET(Inquiry_Deltabase.Layouts.Inquiry_All) deltabase) := FUNCTION


	deltaBase_did_results := deltabase(S_DID <> 0 AND Search_Type='2');

	deltabasetrans_did := project(deltaBase_did_results, transform(Layouts_FDC.Layout_Inquiry_AccLogs__Inquiry_Table_DID,
					SELF.UIDAppend := LEFT.seq,
					SELF.G_ProcUID := LEFT.seq,
					SELF.DateOfInquiry := LEFT.Search_Info.DateTime[1..8];
					SELF.Src := MDR.sourceTools.src_InquiryAcclogs,
					SELF.IsUpdateRecord := FALSE,  //to help with debugging and data questions
					SELF.IsDeltaBaseRecord := TRUE, 
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date := '';	
					DOBCleaned := CleanDateOfBirth((UNSIGNED)LEFT.person_q.dob);
					SELF.person_q.dob := (STRING)DOBCleaned.dob;
					SELF.DOBPadded := DOBCleaned.DOBPadded;
					SELF := LEFT,
					SELF := [])); 

	return deltabasetrans_did;
end;

EXPORT Inquiry_Email(DATASET(Inquiry_Deltabase.Layouts.Inquiry_All) deltabase) := FUNCTION


	deltabase_email_results := deltabase(Email <> '' AND Search_Type='3');

	deltabasetrans_email := project(deltaBase_email_results, transform(Layouts_FDC.Layout_Inquiry_AccLogs__Inquiry_Table_Email,
					SELF.UIDAppend := LEFT.seq,
					SELF.G_ProcUID := LEFT.seq,
					SELF.DateOfInquiry := LEFT.Search_Info.DateTime[1..8];
					SELF.Src := MDR.sourceTools.src_InquiryAcclogs,
					SELF.IsUpdateRecord := FALSE,  //to help with debugging and data questions
					SELF.IsDeltaBaseRecord := TRUE, 
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date := '';
					DOBCleaned := CleanDateOfBirth((UNSIGNED)LEFT.person_q.dob);
					SELF.person_q.dob := (STRING)DOBCleaned.dob;
					SELF.DOBPadded := DOBCleaned.DOBPadded;
					SELF := LEFT,
					SELF := [])); 

	return deltabasetrans_email;
end;

EXPORT Inquiry_Phone(DATASET(Inquiry_Deltabase.Layouts.Inquiry_All) deltabase) := FUNCTION


	deltabase_phone_results := deltabase(Phone10 <> '' AND Search_Type='6');

	deltabasetrans_phone := project(deltaBase_phone_results, transform(Layouts_FDC.Layout_Inquiry_AccLogs__Inquiry_Table_Phone,
					SELF.UIDAppend := LEFT.seq,
					SELF.G_ProcUID := LEFT.seq,
					SELF.DateOfInquiry := LEFT.Search_Info.DateTime[1..8];
					SELF.Src := MDR.sourceTools.src_InquiryAcclogs,
					SELF.IsUpdateRecord := FALSE,  //to help with debugging and data questions
					SELF.IsDeltaBaseRecord := TRUE, 
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date := '';	
					DOBCleaned := CleanDateOfBirth((UNSIGNED)LEFT.person_q.dob);
					SELF.person_q.dob := (STRING)DOBCleaned.dob;
					SELF.DOBPadded := DOBCleaned.DOBPadded;
					SELF := LEFT,
					SELF := [])); 

	return deltabasetrans_phone;
end;

EXPORT Inquiry_SSN(DATASET(Inquiry_Deltabase.Layouts.Inquiry_All) deltabase) := FUNCTION


	deltabase_ssn_results := deltabase(SSN <> '' AND Search_Type='7');

	deltabasetrans_ssn := project(deltaBase_ssn_results, transform(Layouts_FDC.Layout_Inquiry_AccLogs__Inquiry_Table_SSN,
					SELF.UIDAppend := LEFT.seq,
					SELF.G_ProcUID := LEFT.seq,
					SELF.DateOfInquiry := LEFT.Search_Info.DateTime[1..8];
					SELF.Src := MDR.sourceTools.src_InquiryAcclogs,
					SELF.IsUpdateRecord := FALSE,  //to help with debugging and data questions
					SELF.IsDeltaBaseRecord := TRUE, 
					SELF.DPMBitmap := SetDPMBitmap( Source := MDR.sourceTools.src_InquiryAcclogs, FCRA_Restricted := Options.isFCRA, GLBA_Restricted := NotRegulated, Pre_GLB_Restricted := NotRegulated, DPPA_Restricted := NotRegulated, DPPA_State := BlankString, KELPermissions := CFG_File),
					self.Archive_Date := '';	
					DOBCleaned := CleanDateOfBirth((UNSIGNED)LEFT.person_q.dob);
					SELF.person_q.dob := (STRING)DOBCleaned.dob;
					SELF.DOBPadded := DOBCleaned.DOBPadded;
					SELF := LEFT,
					SELF := [])); 

	return deltabasetrans_ssn;
end;

end;