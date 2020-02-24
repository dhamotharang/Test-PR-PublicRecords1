IMPORT STD, Ecrash_Common;

	EXPORT mod_MapNtlAccidentsInquiryBase(DATASET(Layouts_NAccidentsInquiry.ALL_CRU_ORDERS) AllCruOrders = Files_NAccidentsInquiry.DS_BASE_ALL_CRU_ORDERS,
																																							DATASET(Layouts_NAccidentsInquiry.RESULT) AllResult = Files_NAccidentsInquiry.DS_BASE_RESULT,
																																							DATASET(Layouts_NAccidentsInquiry.VEHICLE_INCIDENT) AllVehicleIncident = Files_NAccidentsInquiry.DS_BASE_VEHICLE_INCIDENT,  
																																							DATASET(Layouts_NAccidentsInquiry.CLIENT) AllClient = Files_NAccidentsInquiry.DS_BASE_CLIENT) := MODULE

	//###########################################################################
	// Shared unique datasets used in Consolidation of the 
	// Accidents Base and eCrashCRU Inquiry Base
	//########################################################################### 
	dAllCruOrders := DISTRIBUTED(AllCruOrders(Order_ID <> ''), HASH32(Order_ID));
	dsAllCruOrders := DEDUP(SORT(dAllCruOrders, Order_ID, -((UNSIGNED) Sequence_Nbr),  -(mod_Utilities.StrDateTimeToUnsigned(Checkin_Date)), -(mod_Utilities.StrDateTimeToUnsigned(Last_Changed)), RECORD, LOCAL), 
	                        Order_ID, LOCAL);

	dAllResult := DISTRIBUTED(AllResult(Order_ID <> ''), HASH32(Order_ID));															
	dsAllResult := DEDUP(SORT(dAllResult, Order_ID, -((UNSIGNED) Sequence_Nbr), -(mod_Utilities.StrDateTimeToUnsigned(Last_Changed)), RECORD, LOCAL),
	                     Order_ID, LOCAL);

	dAllVehicleIncident := DISTRIBUTED(AllVehicleIncident(Order_ID <> ''), HASH32(Order_ID));
	dsAllVehicleIncident := DEDUP(SORT(dAllVehicleIncident, Order_ID, -((UNSIGNED) Sequence_Nbr), -(mod_Utilities.StrDateTimeToUnsigned(Last_Changed)), RECORD, LOCAL),
	                              Order_ID, LOCAL); 

	//##############################################################################
	// Shared Consolidation of the AllCRUOrders, Result, Vehicle Incident and Client
	// datasets for Accidents Base and eCrashCRU Inquiry Base
	//##############################################################################
	Layouts_NAccidentsInquiry.COMBINED tOrdersWithResult(dsAllCruOrders L, dsAllResult R) := TRANSFORM
		tCheckinDate := TRIM(L.Checkin_Date, LEFT, RIGHT);
		tLastChanged := TRIM(L.Last_Changed, LEFT, RIGHT);
		trLastChanged := TRIM(R.Last_Changed, LEFT, RIGHT);
		CheckinDate := mod_Utilities.StrDateTimeToDate(tCheckinDate);
		LastChanged := mod_Utilities.StrDateTimeToDate(tLastChanged);

		lLast_Changed := IF(tCheckinDate <> '', CheckinDate, LastChanged);
		rLast_Changed := mod_Utilities.StrDateTimeToDate(trLastChanged);
		
		isOrderIdEqual := L.Order_ID = R.Order_ID;

		SELF.Last_Changed := IF(isOrderIdEqual AND  lLast_Changed < rLast_Changed, (STRING) rLast_Changed, (STRING) lLast_Changed);
		SELF := L;
		SELF := R;
		SELF := [];
	END;
	OrdersWithResult := JOIN(dsAllCruOrders, dsAllResult, LEFT.Order_ID = RIGHT.Order_ID,
	                         tOrdersWithResult(LEFT,RIGHT), LEFT OUTER, LOCAL);

	Layouts_NAccidentsInquiry.COMBINED tOrdersResultWithVehicleIncident(OrdersWithResult L, dsAllVehicleIncident R) := TRANSFORM
		lLast_Changed := L.Last_Changed;
		trLast_Changed := TRIM(R.Last_Changed, LEFT, RIGHT);
		rLast_Changed := mod_Utilities.StrDateTimeToDate(trLast_Changed); 
		isOrderIdEqual := L.Order_ID = R.Order_ID;

		SELF.Order_ID := L.Order_ID;
		SELF.Sequence_Nbr := L.Sequence_Nbr;
		SELF.Creation_Date := L.Creation_Date;
		SELF.Service_ID := IF(isOrderIdEqual  AND L.Service_ID = '', R.Service_ID, L.Service_ID);
		SELF.Loss_Date := IF(isOrderIdEqual  AND L.Loss_Date <> '', R.Loss_Date, L.Loss_Date); 
		SELF.Loss_Time := IF(isOrderIdEqual  AND L.Loss_Time <> '', R.Loss_Time, L.Loss_Time); 
		SELF.Report_Nbr := IF(isOrderIdEqual  AND L.Report_Nbr = '', R.Report_Nbr, L.Report_Nbr);

		//keeping the latest last change date
		SELF.Last_Changed := IF(isOrderIdEqual AND (UNSIGNED) lLast_Changed < rLast_Changed, (STRING) rLast_Changed, lLast_Changed);

		SELF := R;
		SELF := L;
		SELF := [];
	END;
	SHARED OrdersResultWithVehicleIncident := JOIN(OrdersWithResult, dsAllVehicleIncident, LEFT.Order_ID = RIGHT.Order_ID,
	                                               tOrdersResultWithVehicleIncident(LEFT,RIGHT), LEFT OUTER, LOCAL);						    

	dClient := DISTRIBUTE(AllClient, HASH32(Acct_Nbr, Client_ID));
	SHARED dsAllClient := DEDUP(SORT(dClient, Acct_Nbr, Client_ID, -(mod_Utilities.StrDateTimeToUnsigned(Last_Changed)), RECORD, LOCAL), 
	                            Acct_Nbr, Client_ID, LOCAL);

	//###########################################################################
	// Function to Consolidate Data for eCrash CRU Base
	//###########################################################################																																													
	EXPORT fn_CruInquiry() := FUNCTION

	dOrdersResultWithVehicleIncident := DISTRIBUTE(OrdersResultWithVehicleIncident, HASH32(Acct_Nbr, Client_ID));

	//Inquiry Base			
	Layouts_NAccidentsInquiry.COMBINED tConsolidateClient(dOrdersResultWithVehicleIncident L, dsAllClient R) := TRANSFORM
	lLast_Changed := L.Last_Changed;
	rLast_Changed := mod_Utilities.StrDateTimeToDate(R.Last_Changed);

	BOOLEAN isAcctNbrEqual := L.Acct_Nbr = R.Acct_Nbr;
	SELF.Last_Changed := IF(isAcctNbrEqual AND (UNSIGNED) lLast_Changed < rLast_Changed, (STRING) rLast_Changed, lLast_Changed);
	SELF.UserID := IF(isAcctNbrEqual AND (UNSIGNED) lLast_Changed > rLast_Changed, L.UserID, R.UserID);	

	SELF.Start_Date := (STRING) mod_Utilities.StrDateTimeToDate(R.Start_Date);
	
	SELF.Acct_Nbr := L.Acct_Nbr;
	SELF.Client_ID := L.Client_ID;
	
	SELF := R;
	SELF := L;
	SELF := [];
	END;
	ConAllCruOrdersClient := JOIN(dOrdersResultWithVehicleIncident, dsAllClient,
																															LEFT.Acct_Nbr = RIGHT.Acct_Nbr AND 
																															LEFT.Client_ID = RIGHT.Client_ID,
																															tConsolidateClient(LEFT,RIGHT), LEFT OUTER, LOCAL);
																															
 fConAllCruOrdersClient := ConAllCruOrdersClient(FIRST_NAME_1 + MIDDLE_NAME_1 + LAST_NAME_1 + VIN != '');
 
	Layouts_NAccidentsInquiry.NATIONAL_ACCIDENTS_INQUIRY tConsolidatedCruInquiry(fConAllCruOrdersClient L) := TRANSFORM
		DtFirstSeen := mod_Utilities.ConvertSlashedMDYtoCYMD(L.Loss_Date[1..10]);
		SELF.Dt_First_Seen := DtFirstSeen;
		SELF.Dt_Last_Seen := IF((UNSIGNED) L.Last_Changed <> 0, L.Last_Changed, DtFirstSeen);
		SELF.Dob_1 := mod_Utilities.ConvertSlashedMDYtoCYMD(TRIM(L.Dob_1, LEFT, RIGHT)[1..10]);
		SELF.Report_Code := L.Service_ID;
		SELF.Report_Category := Ecrash_Common.fn_Report_Type_To_Category(L.Service_ID);
		SELF.Report_Code_Desc := Ecrash_Common.fn_Report_Type_To_Description(L.Service_ID);	
		
		SELF.Vehicle_Incident_ID := IF(L.Vehicle_Incident_ID != '', L.Vehicle_Incident_ID , 'OID' + L.Order_ID);

		SELF.Orig_Fname :=L.FIRST_NAME_1;
		SELF.Orig_Lname :=L.LAST_NAME_1;
		SELF.Orig_Mname :=L.MIDDLE_NAME_1; 
		SELF.Orig_Fname2 :=L.FIRST_NAME_2;
		SELF.Orig_Lname2 :=L.LAST_NAME_2;
		SELF.Orig_Mname2 :=L.MIDDLE_NAME_2;
		SELF.Orig_Fname3 :=L.FIRST_NAME_3;
		SELF.Orig_Lname3 :=L.LAST_NAME_3;
		SELF.Orig_Mname3 :=L.MIDDLE_NAME_3;

		SELF := L;
		SELF := [];
	END;
	pCruInquiry := PROJECT (fConAllCruOrdersClient, tConsolidatedCruInquiry(LEFT));
	
	CruInquiry := DEDUP(SORT(pCruInquiry, RECORD, LOCAL), RECORD, LOCAL);

	RETURN CruInquiry;
	END;

	//###########################################################################
	// Function to consolidate Data for Accidents Base
	//###########################################################################	
	EXPORT fn_NtlAccidents(DATASET(Layouts_NAccidentsInquiry.VEHICLE) AllVehicle = Files_NAccidentsInquiry.DS_BASE_VEHICLE,
	DATASET(Layouts_NAccidentsInquiry.VEHICLE_PARTY) AllVehicleParty = Files_NAccidentsInquiry.DS_BASE_VEHICLE_PARTY, 
	DATASET(Layouts_NAccidentsInquiry.VEHICLE_INSURANCE) AllVehicleInsurance = Files_NAccidentsInquiry.DS_BASE_VEHICLE_INSCR) := FUNCTION

	dOrdersResultWithVehicleIncident:= DISTRIBUTE(OrdersResultWithVehicleIncident, HASH32(Vehicle_Incident_ID));

	dVehicle := DISTRIBUTE(AllVehicle, HASH32(Vehicle_ID));
	uVehicle := DEDUP(SORT(dVehicle, Vehicle_ID, -(mod_Utilities.StrDateTimeToUnsigned(Last_Changed)), RECORD, LOCAL), Vehicle_ID, LOCAL);
	dVehicleByVehIncId := DISTRIBUTE(uVehicle(Vehicle_Incident_ID <> ''), HASH32(Vehicle_Incident_ID));

	ddVehicleParty := DISTRIBUTED(AllVehicleParty(Vehicle_Incident_ID <> ''), HASH32(Vehicle_Party_ID));
	uVehicleParty := DEDUP(SORT(ddVehicleParty, Vehicle_Party_ID, -(mod_Utilities.StrDateTimeToUnsigned(Last_Changed)), RECORD, LOCAL), Vehicle_Party_ID, LOCAL);
	dVehicleParty := DISTRIBUTE(uVehicleParty, HASH32(Vehicle_Incident_ID, Vehicle_ID));

	dVehicleInsurance := DISTRIBUTED(AllVehicleInsurance, HASH32(Carrier_ID));  
	uVehicleInsurance := DEDUP(SORT(dVehicleInsurance, RECORD, LOCAL), RECORD, LOCAL); 

	Layouts_NAccidentsInquiry.COMBINED tConsolidateVehicle(dOrdersResultWithVehicleIncident L, dVehicleByVehIncId R) := TRANSFORM
		lLast_Changed := L.Last_Changed;
		rLast_Changed := mod_Utilities.StrDateTimeToDate(R.Last_Changed);

		BOOLEAN isVehicleIncidentIdEqual:= L.Vehicle_Incident_ID = R.Vehicle_Incident_ID;
		SELF.Last_Changed := IF(isVehicleIncidentIdEqual AND (UNSIGNED) lLast_Changed < rLast_Changed, (STRING) rLast_Changed, lLast_Changed);
		SELF.UserID := IF(isVehicleIncidentIdEqual AND (UNSIGNED) lLast_Changed > rLast_Changed, L.UserID, R.UserID);	
		
		SELF.Vehicle_Incident_ID 	:= L.Vehicle_Incident_ID;
 
  SELF.VehVin := IF(isVehicleIncidentIdEqual, R.VehVin, L.VehVin);
  SELF.VehYear := IF(isVehicleIncidentIdEqual, R.VehYear, L.VehYear);
  SELF.VehMake := IF(isVehicleIncidentIdEqual, R.VehMake, L.VehMake);
  SELF.VehModel := IF(isVehicleIncidentIdEqual,R.VehModel, L.VehModel);
  SELF.Vehicle_Status		:= IF(isVehicleIncidentIdEqual, R.Vehicle_Status, L.Vehicle_Status);
  SELF.Impact_Location	:= IF(isVehicleIncidentIdEqual, R.Impact_Location, L.Impact_Location);						 
  SELF.Tag := IF(isVehicleIncidentIdEqual, L.Tag, '');
  SELF.Tag_State := IF(isVehicleIncidentIdEqual, L.Tag_State, '');

		SELF := R;
		SELF := L;
		SELF :=[];
	END;
	ConAllCruOrdersVehicle := JOIN(dOrdersResultWithVehicleIncident, dVehicleByVehIncId, LEFT.Vehicle_Incident_ID = RIGHT.Vehicle_Incident_ID,
	                               tConsolidateVehicle(LEFT,RIGHT), LEFT OUTER, LOCAL);				     
	
	dConAllCruOrdersVehicle := DISTRIBUTE(ConAllCruOrdersVehicle(Vehicle_Incident_ID <> ''), HASH32(Vehicle_Incident_ID, Vehicle_ID));			     

	Layouts_NAccidentsInquiry.COMBINED tConsolidateParty(dConAllCruOrdersVehicle L, dVehicleParty R) := TRANSFORM
		SELF.Vehicle_Incident_ID := L.Vehicle_Incident_ID;
		SELF.Vehicle_ID := L.Vehicle_ID;

		BOOLEAN isVehicleIncidentIdEqual:= L.Vehicle_Incident_ID = R.Vehicle_Incident_ID;
		BOOLEAN isVehicleIdEqual := L.Vehicle_ID = R.Vehicle_ID;

		lLast_Changed := L.Last_Changed;
		rLast_Changed := mod_Utilities.StrDateTimeToDate(R.Last_Changed);

		SELF.Last_Changed := IF(isVehicleIncidentIdEqual AND isVehicleIdEqual AND (UNSIGNED) lLast_Changed < rLast_Changed, (STRING) rLast_Changed, lLast_Changed);
		SELF.UserID	:= IF(isVehicleIncidentIdEqual AND isVehicleIdEqual AND (UNSIGNED) lLast_Changed > rLast_Changed, L.UserID, R.UserID);             
		SELF.Dob := IF(isVehicleIncidentIdEqual AND isVehicleIdEqual, (STRING) mod_Utilities.StrDateTimeToDate(R.Dob), '');

  SELF.VP_DL_Nbr:= IF(isVehicleIncidentIdEqual AND isVehicleIdEqual, R.VP_DL_Nbr, '');						
  SELF.VP_DL_ST := IF(isVehicleIncidentIdEqual AND isVehicleIdEqual, R.VP_DL_ST, '');
				
  // Populate Inquiry fields, these fields contain data pulled from the order version table and must be labeled accordingly
  SELF.Inquiry_SSN 	:= IF(isVehicleIncidentIdEqual AND isVehicleIdEqual, R.CO_SSN, '');

		SELF := R;
		SELF := L;
		SELF :=[];
	END;
	ConAllCruOrdersVehicleParty := JOIN(dConAllCruOrdersVehicle, dVehicleParty,
																																					LEFT.Vehicle_Incident_ID = RIGHT.Vehicle_Incident_ID AND
																																					LEFT.Vehicle_ID = RIGHT.Vehicle_ID, 
																																					tConsolidateParty(LEFT,RIGHT), LEFT OUTER, LOCAL);

	Layouts_NAccidentsInquiry.COMBINED tConsolidateInsurance(ConAllCruOrdersVehicleParty L, uVehicleInsurance R) := TRANSFORM
		lLast_Changed := L.Last_Changed;
		rLast_Changed := mod_Utilities.StrDateTimeToDate(R.Last_Changed);

		SELF.Carrier_ID        := L.Carrier_ID;

		BOOLEAN isCarrierIdEqual := L.Carrier_ID = R.Carrier_ID;
		SELF.Carrier_Name := IF(isCarrierIdEqual, R.Carrier_Name, L.Carrier_Name);
		SELF.Last_Changed := IF(isCarrierIdEqual AND (UNSIGNED) lLast_Changed < rLast_Changed, (STRING) rLast_Changed, lLast_Changed);
		SELF.UserID := IF(isCarrierIdEqual AND (UNSIGNED) lLast_Changed > rLast_Changed, L.UserID, R.UserID);

		SELF := R;
		SELF := L;
	END;
	ConAllCruOrdersVehiclePartyIns := JOIN(ConAllCruOrdersVehicleParty, uVehicleInsurance, LEFT.Carrier_ID = RIGHT.Carrier_ID,
	                                       tConsolidateInsurance(LEFT,RIGHT), LEFT OUTER, LOOKUP);

	dConAllCruOrdersVehiclePartyIns := DISTRIBUTE(ConAllCruOrdersVehiclePartyIns,HASH32(Acct_Nbr, Client_ID));

	Layouts_NAccidentsInquiry.COMBINED tAccConsolidateClient(dConAllCruOrdersVehiclePartyIns L, dsAllClient R) := TRANSFORM
	 SELF.Acct_Nbr := L.Acct_Nbr;
		SELF.Client_ID := L.Client_ID;
		
		lLast_Changed := L.Last_Changed;
		rLast_Changed := mod_Utilities.StrDateTimeToDate(R.Last_Changed);

		BOOLEAN isAcctNbrEqual := L.Acct_Nbr = R.Acct_Nbr;
		SELF.Last_Changed := IF(isAcctNbrEqual AND (UNSIGNED) lLast_Changed < rLast_Changed, (STRING) rLast_Changed, lLast_Changed);
		SELF.UserID := IF(isAcctNbrEqual AND (UNSIGNED) lLast_Changed > rLast_Changed, L.UserID, R.UserID);
		SELF.Start_Date := (STRING) mod_Utilities.StrDateTimeToDate(R.Start_Date);
		
		SELF := R;
		SELF := L;
	END;
	ConAllCruOrdersVehiclePartyInsClient := JOIN(dConAllCruOrdersVehiclePartyIns, dsAllClient,
																																														LEFT.Acct_Nbr = RIGHT.Acct_Nbr AND 
																																														LEFT.Client_ID = RIGHT.Client_ID AND
																																														LEFT.Last_Name = LEFT.Last_Name_1 AND 
																																														LEFT.First_Name = LEFT.First_Name_1,
																																														tAccConsolidateClient(LEFT,RIGHT), LEFT OUTER, LOCAL);

	Layouts_NAccidentsInquiry.NATIONAL_ACCIDENTS tConsolidatedAccidents(ConAllCruOrdersVehiclePartyInsClient L) := TRANSFORM
		DtFirstSeen := mod_Utilities.ConvertSlashedMDYtoCYMD(L.Loss_Date[1..10]);
		SELF.Dt_First_Seen := DtFirstSeen;
		SELF.Dt_Last_Seen := IF((UNSIGNED) L.Last_Changed = 0, L.Last_Changed, DtFirstSeen);
		SELF.Policy_Exp_Date := mod_Utilities.ConvertSlashedMDYtoCYMD(L.Policy_Exp_Date[1..10]);
		SELF.Report_Code := L.Service_ID;
		SELF.Report_Category  := Ecrash_Common.fn_Report_Type_To_Category(L.Service_ID);
		SELF.Report_Code_Desc := Ecrash_Common.fn_Report_Type_To_Description(L.Service_ID);
		
		SELF.Edit_Agency_Name := TRIM(REGEXREPLACE(';', TRIM(L.Edit_Agency_Name), ''));

		Name := L.Last_Name + L.First_Name;
		BOOLEAN isNameEqualName1 := Name = L.Last_Name_1 + L.First_Name_1;
		BOOLEAN isNameEqualName2 := Name = L.Last_Name_2 + L.First_Name_2;
		BOOLEAN isNameEqualName3 := Name = L.Last_Name_3 + L.First_Name_3;

		SELF.Orig_Fname  := MAP(isNameEqualName1 => L.First_Name,
																										isNameEqualName2 => L.First_Name,
																										isNameEqualName3 => L.First_Name,
																										''); 

		SELF.Orig_Lname := MAP(isNameEqualName1 => L.Last_Name,
																									isNameEqualName2 => L.Last_Name,
																									isNameEqualName3 => L.Last_Name,
																									''); 

		SELF.Orig_Mname := '';
		SELF := L;
		SELF := [];
	END;
	pNtlAccidents := PROJECT (ConAllCruOrdersVehiclePartyInsClient, tConsolidatedAccidents(LEFT));	

 NtlAccidents := DEDUP(SORT(pNtlAccidents, RECORD, LOCAL), RECORD, LOCAL);
 
	RETURN NtlAccidents;
	END;
END;