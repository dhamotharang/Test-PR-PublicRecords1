IMPORT Ecrash_Common, IDLExternalLinking, Address, AID, AID_Support;

	//Join vehicle_incident with combined_order
	// iVehicleIncident is distributed by Order_ID
	dVehicleIncident := DISTRIBUTED(iVehicleIncident(Order_ID <> ''), HASH32(Order_ID)); 
	uVehicleIncident := DEDUP(SORT(dVehicleIncident, Order_ID, -((UNSIGNED) Sequence_Nbr), -(mod_Utilities.StrDateTimeToUnsigned(Last_Changed)), LOCAL), 
	                          Order_ID, LOCAL); 
	
	// dOrderCombined is distributed by Order_ID
	dOrderCombined := DISTRIBUTED(OrderCombined, HASH32(Order_ID));													

	Layouts_NAccidentsInquiry.ORDER_COMBINED_VEHICLE_INCIDENT tOrderCombinedVehicleIncident(dOrderCombined L, uVehicleIncident R) := TRANSFORM
		SELF.INC_City            := R.INC_City;
		SELF.State_Abbr          := R.State_Abbr;
		SELF.Vehicle_Incident_ID := R.Vehicle_Incident_ID;
		SELF := L;
		SELF := [];
	END;
	jOrderCombinedVehicleIncident := JOIN(dOrderCombined, uVehicleIncident, LEFT.Order_ID = RIGHT.Order_ID,
                                        tOrderCombinedVehicleIncident(LEFT,RIGHT), LEFT OUTER, LOCAL);
																																							
	Layouts_NAccidentsInquiry.ORDER_COMBINED_VEHICLE_INCIDENT_ADDRESS tOrderCombinedVehicleIncidentAddress(jOrderCombinedVehicleIncident L) := TRANSFORM
	  address_1      := L.House_Nbr + ' ' + L.Street;
	  address_2      := L.Apt_Nbr;		
		SELF.pLine1    := Address.Addr1FromComponents('', address_1, address_2, '', '', '', '');
		
		ispLineLastOC  := L.City <> '' AND L.State <> '' AND L.Zip5 <> '';
		pLineLast      := Address.Addr2FromComponents(L.City, L.State, L.Zip5);
		pLineLastOC    := Address.Addr2FromComponents(L.inc_City, L.State_Abbr, '');
		LineLast       := IF(ispLineLastOC, pLineLast, pLineLastOC);
		SELF.pLineLast := LineLast;
		SELF           := L;
	END;
	pOrderCombinedVehicleIncidentAddress := PROJECT(jOrderCombinedVehicleIncident, tOrderCombinedVehicleIncidentAddress(LEFT));
	
	BlankAddr := pOrderCombinedVehicleIncidentAddress(pLine1 = '' AND pLineLast = ''); 
	NBlankAddr := pOrderCombinedVehicleIncidentAddress(~(pLine1 = '' AND pLineLast = ''));
	
	//Clean Address
  Address.MAC_Address_Clean(NBlankAddr, pLine1, pLineLast, TRUE, cleanAddr);
	
	Layouts_NAccidentsInquiry.ORDER_COMBINED_VEHICLE_INCIDENT tOrderCombinedVehicleIncidentCleanAddr(cleanAddr L) := TRANSFORM
		
		/* Input address is the address where the loss occurred and should not be assumed to be the address of any of the involved parties.  
		Most values are cross streets. EX: 'Yamato and Congress' or 'Winn Dixie P Lot'
		self.prim_range 					:= L.clean[1..10]; 
		self.predir 							:= L.clean[11..12];					   
		self.prim_name 						:= L.clean[13..40];
		self.suffix 							:= L.clean[41..44];
		self.postdir 							:= L.clean[45..46];
		self.unit_desig 					:= L.clean[47..56];
		self.sec_range 						:= L.clean[57..64];
		*/
		SELF.p_city_name 					:= L.clean[65..89];
		SELF.v_city_name 					:= L.clean[90..114];
		SELF.st 									:= IF(L.clean[115..116]='',ziplib.ZipToState2(L.clean[117..121]),
																		L.clean[115..116]);

		SELF.z5 									:= '';//the only zip info provided is contained in the order version table and must be labeled as inquiry data 
		SELF.z4 									:= '';//the only zip info provided is contained in the order version table and must be labeled as inquiry data 
		SELF.cart 								:= L.clean[126..129];
		SELF.cr_sort_sz 					:= L.clean[130];
		SELF.lot 									:= L.clean[131..134];
		SELF.lot_order 						:= L.clean[135];
		SELF.dpbc 								:= L.clean[136..137];
		SELF.chk_digit 						:= L.clean[138];
		SELF.rec_type 						:= L.clean[139..140];
		SELF.county_code					:= L.clean[141..145];
		SELF.geo_lat 							:= L.clean[146..155];
		SELF.geo_long 						:= L.clean[156..166];
		SELF.msa 									:= L.clean[167..170];
		SELF.geo_blk 							:= L.clean[171..177];
		SELF.geo_match 						:= L.clean[178];
		SELF.err_stat 						:= L.clean[179..182];
		SELF := L;
END;

  cleanAddOrderCombinedVehicleIncident := PROJECT(cleanAddr, tOrderCombinedVehicleIncidentCleanAddr(LEFT));
  cleanAddress := cleanAddOrderCombinedVehicleIncident + BlankAddr : PERSIST('~THOR::BASE::NTL_ACCIDENTS_INQUIRY::PERSIST::ORDER_COMBINED_VEHICLE_INCIDENT_CLEAN_ADDRESS');

	dOrderCombinedVehicleIncident := DISTRIBUTE(cleanAddress,  HASH32(Vehicle_Incident_ID));
	
  // Associate vehicles with Cru Orders using vehicle incident id and populate vin
	// iVehicle distributed by Vehicle_Incident_ID
	dVehicleByVehicleIncidentID := DISTRIBUTED(iVehicle(VehVIN <> ''), HASH32(Vehicle_Incident_ID));	
	uVehicle := DEDUP(SORT(dVehicleByVehicleIncidentID, Vehicle_Incident_ID, -(mod_Utilities.StrDateTimeToUnsigned(Last_Changed)), LOCAL), 
	                  Vehicle_Incident_ID, LOCAL); 
	
	OrderCombinedVehicleIncWithVin := JOIN(dOrderCombinedVehicleIncident , uVehicle,
	                                       LEFT.Vehicle_Incident_ID = RIGHT.Vehicle_Incident_ID,
																				 TRANSFORM(Layouts_NAccidentsInquiry.ORDER_COMBINED_VEHICLE_INCIDENT, 
																				           SELF.VehVin := RIGHT.VehVin;
																									 SELF.Vehicle_ID := RIGHT.Vehicle_ID;
																									 SELF := LEFT;),
																				 LEFT OUTER, LOCAL);
																																							
	pOrderCombinedVehicleIncWithVin := OrderCombinedVehicleIncWithVin(VehVin != '');	
	pOrderCombinedVehicleIncWithNoVin := OrderCombinedVehicleIncWithVin(VehVin = '');
																																							
	dOrderCombinedVehicleIncWithVin := DISTRIBUTE(pOrderCombinedVehicleIncWithVin, HASH32(VehVin, FName, LName));
	dVehiclePartyMainRollup := DISTRIBUTE(Ecrash_Common.VehiclePartyMainRollup(Flag <> 'F'), HASH32(Vina_Vin, FName, LName));
	
	// Get Did's matching with vehicle party main	
	Layouts_NAccidentsInquiry.ORDER_COMBINED_VEHICLE_INCIDENT xformVehPartyInfo(dVehiclePartyMainRollup L, dOrderCombinedVehicleIncWithVin R) := TRANSFORM
    SELF.FName_Party := L.FName;
    SELF.LName_Party := L.LName;
    SELF.DID_Party := L.Append_DID;
    SELF.DID := L.Append_DID;
    SELF := R;	
	END;
	VehPartyMainWithDids := JOIN(dVehiclePartyMainRollup, dOrderCombinedVehicleIncWithVin,
															 LEFT.Vina_Vin = RIGHT.VehVIN AND LEFT.FName = RIGHT.FName AND LEFT.LName = RIGHT.LName,
 															 xformVehPartyInfo(LEFT, RIGHT), RIGHT OUTER, LOCAL);

	AllOrderCombinedVehicleIncidentToLexIDAppend := VehPartyMainWithDids(DID = 0) + pOrderCombinedVehicleIncWithNoVin;

	//Appending Did/Lexid
	IDLExternalLinking.mac_xlinking_on_thor(AllOrderCombinedVehicleIncidentToLexIDAppend, DID, SName, FName, MName, LName, , ,
																					Prim_Name, Prim_Range, Sec_Range, P_City_Name, ST, Z5, SSN_1, DOB_1, DL_ST, DL_Nbr, , , 
																					OrderCombinedVehicleIncidentWithLexID, , Ecrash_Common.Constants.WeightScoreHdrLnk, 
																					Ecrash_Common.Constants.DistanceHdrLnk, , ,);

  lOrderCombinedVehicleIncidentWithLexID := OrderCombinedVehicleIncidentWithLexID  : PERSIST('~THOR::BASE::NTL_ACCIDENTS_INQUIRY::PERSIST::ORDER_COMBINED_VEHICLE_INCIDENT_WITH_LEXID');
	AllOrderCombinedVehicleIncident := lOrderCombinedVehicleIncidentWithLexID + VehPartyMainWithDids(DID != 0);

  dAllOrderCombinedVehicleIncident := DISTRIBUTE(AllOrderCombinedVehicleIncident, HASH32(Vehicle_Incident_ID, Vehicle_ID));
 
EXPORT OrderCombinedVehicleIncident := dAllOrderCombinedVehicleIncident : PERSIST('~THOR::BASE::NTL_ACCIDENTS_INQUIRY::PERSIST::ORDER_COMBINED_VEHICLE_INCIDENT');