IMPORT Address, AID, AID_Support, NID_Support, IDLExternalLinking, Ecrash_Common;

	Layouts_NAccidentsInquiry.VEHICLE_PARTY tVehicleParty(Files_NAccidentsInquiry.DS_SPRAY_VEHICLE_PARTY L) := TRANSFORM
		SELF.Vehicle_Party_ID       := TRIM(L.Vehicle_Party_ID, LEFT, RIGHT);
		SELF.Vehicle_ID             := TRIM(L.Vehicle_ID, LEFT, RIGHT);
		SELF.Vehicle_Incident_ID    := TRIM(L.Vehicle_Incident_ID, LEFT, RIGHT);
		SELF.First_Name             := TRIM(L.First_Name, LEFT, RIGHT);
		SELF.Last_Name              := TRIM(L.Last_Name, LEFT, RIGHT);
		SELF.Business_Name          := TRIM(L.Business_Name, LEFT, RIGHT);
		SELF.VP_DL_Nbr              := TRIM(L.VP_DL_Nbr, LEFT, RIGHT);
		SELF.VP_DL_ST               := TRIM(L.VP_DL_ST, LEFT, RIGHT);
		SELF.DOB                    := TRIM(L.DOB, LEFT, RIGHT);
		SELF.Last_Changed           := TRIM(L.Last_Changed, LEFT, RIGHT);
		SELF.UserID                 := TRIM(L.UserID, LEFT, RIGHT);
		SELF                        := L;
		SELF                        := [];
  END;
  sUncleanVehicleParty := PROJECT(Files_NAccidentsInquiry.DS_SPRAY_VEHICLE_PARTY, tVehicleParty(LEFT));

  rmvHeaderPerson := sUncleanVehicleParty(Vehicle_Party_ID NOT IN Constants_NtlAccidentsInquiry.HdrVehicleParty);

  Ecrash_Common.mac_CleanFields(rmvHeaderPerson,sCleanVehicleParty);
  Ecrash_Common.mac_ConvertToUpperCase(sCleanVehicleParty, sVehiclePartyUpper);
	
  dVehicleParty := DISTRIBUTE(sVehiclePartyUpper, HASH32(Vehicle_Incident_ID, Vehicle_ID));
	
	// OrderCombinedVehicleIncident distributed by Vehicle_Incident_ID, Vehicle_ID
  dOrderCombinedVehicleIncident := DISTRIBUTED(OrderCombinedVehicleIncident, HASH32(Vehicle_Incident_ID, Vehicle_ID));
  uOrderCombinedVehicleIncident := DEDUP(SORT(dOrderCombinedVehicleIncident, Vehicle_Incident_ID, Vehicle_ID, -(mod_Utilities.StrDateTimeToUnsigned(Last_Changed)), LOCAL),
	                                     Vehicle_Incident_ID, Vehicle_ID, LOCAL);
	
	Layouts_NAccidentsInquiry.VEHICLE_PARTY_ADDRESS tVehiclePartyMNameAddress(uOrderCombinedVehicleIncident L, dVehicleParty R) := TRANSFORM
		SELF.House_Nbr   := L.House_Nbr;
		SELF.Street      := L.Street;
		SELF.Apt_Nbr     := L.Apt_Nbr;
		SELF.inc_City    := L.inc_City;
		SELF.State_Abbr  := L.State_Abbr;
		SELF.ZIP5        := L.ZIP5;
		
		address_1        := L.House_Nbr + ' ' + L.Street;
    address_2        := L.Apt_Nbr;
		SELF.pLine1      := Address.Addr1FromComponents('', address_1, address_2, '', '', '', '');
		SELF.pLineLast   := Address.Addr2FromComponents(L.inc_City, L.State_Abbr, L.ZIP5);
		SELF.City        := '';
		SELF.State       := '';
		SELF.ZIP4        := '';
		
		vpName           := R.First_Name + R.Last_Name;
		SELF.Middle_Name := MAP(vpName = L.Last_Name_1 + L.First_Name_1 => L.Middle_Name_1,
		                        vpName = L.Last_Name_2 + L.First_Name_2 => L.Middle_Name_2, 
														vpName = L.Last_Name_3 + L.First_Name_3 => L.Middle_Name_3, 
														'');
														
		vpDOB            := R.DOB[7..10] + R.DOB[1..2] + R.DOB[4..5];
		//DOB from Combined order
		//Fetch DOB for Vehicle party Name matching with Combined order
		coDOB            := IF(vpName = L.Last_Name_1 + L.First_Name_1, L.DOB_1[7..10] + L.DOB_1[1..2] + L.DOB_1[4..5], '');
		SELF.VP_CO_DOB   := IF(R.DOB != '', vpDOB, coDOB);
		
		coSSN           	:= MAP(LENGTH(TRIM(L.SSN_1, ALL)) = 7 => '00'+ L.SSN_1,
														 LENGTH(TRIM(L.SSN_1, ALL)) = 8 => '0' + L.SSN_1,
														 L.SSN_1);
		SELF.CO_SSN      := IF(vpName = L.Last_Name_1 + L.First_Name_1, coSSN, '');
		SELF.VehVin      := L.VehVin;
		SELF.Inquiry_DOB 	:= R.VP_CO_DOB;
		
		SELF             := R;
	END;
  jVehiclePartyMNameAddress := JOIN(uOrderCombinedVehicleIncident, dVehicleParty,
																		LEFT.Vehicle_Incident_ID = RIGHT.Vehicle_Incident_ID AND
																		LEFT.Vehicle_ID = RIGHT.Vehicle_ID,
																		tVehiclePartyMNameAddress(LEFT,RIGHT), RIGHT OUTER, LOCAL);

	VehiclePartyBlankAddr    := jVehiclePartyMNameAddress(pLine1 = '' AND pLineLast = ''); 
	VehiclePartyNonBlankAddr := jVehiclePartyMNameAddress(~(pLine1 = '' AND pLineLast = ''));
	
	//Clean Address
  Address.MAC_Address_Clean(VehiclePartyNonBlankAddr, pLine1, pLineLast, TRUE, cleanAddr);
	
	Layouts_NAccidentsInquiry.VEHICLE_PARTY tVehiclePartyCleanAddr(cleanAddr L) := TRANSFORM
		
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
    SELF.inquiry_zip5					:= L.clean[117..121];
    SELF.inquiry_zip4					:= L.clean[122..125];
		SELF                      := L;
END;
  AllRecordsAfterAddressClean := PROJECT(cleanAddr, tVehiclePartyCleanAddr(LEFT));	
  pVehiclePartyCleanAddr := AllRecordsAfterAddressClean + VehiclePartyBlankAddr : PERSIST('~THOR::BASE::NTL_ACCIDENTS_INQUIRY::PERSIST::I_VEHICLE_PARTY_CLEAN_ADDRESS');

  //Clean Name 
  Ecrash_Common.mac_NID_cleanname(pVehiclePartyCleanAddr, FIRST_NAME, MIDDLE_NAME, LAST_NAME, pVehiclePartyClean); 
  VehiclePartyClean := pVehiclePartyClean : PERSIST('~THOR::BASE::NTL_ACCIDENTS_INQUIRY::PERSIST::I_VEHICLE_PARTY_CLEAN');
	
	 Layouts_NAccidentsInquiry.VEHICLE_PARTY tVehiclePartyCleanNames(VehiclePartyClean L) := TRANSFORM 
	  SELF.Inquiry_MName := IF(L.MName = 'UNKNOWN', '', L.MName);
   SELF := L;
	 END;
  pVehiclePartyCleanName := PROJECT(VehiclePartyClean, tVehiclePartyCleanNames(LEFT));
	
	 VehPartyWithDids := pVehiclePartyCleanName(DID != 0);
	 VehPartyWithNoDids := pVehiclePartyCleanName(DID = 0);
	
	 //Appending Did/Lexid
	 IDLExternalLinking.mac_xlinking_on_thor(VehPartyWithNoDids, DID, SName, FName, MName, LName, , ,
																					Prim_Name, Prim_Range, Sec_Range, P_City_Name, ST, Z5, CO_SSN, VP_CO_DOB, VP_DL_ST, VP_DL_Nbr, , , 
																					VehiclePartyWithLexID, , Ecrash_Common.Constants.WeightScoreHdrLnk, 
																					Ecrash_Common.Constants.DistanceHdrLnk, , ,);

  lVehiclePartyWithLexID := VehiclePartyWithLexID : PERSIST('~THOR::BASE::NTL_ACCIDENTS_INQUIRY::PERSIST::VEHICLE_PARTY_WITH_LexID');
	 AllVehicleParty := lVehiclePartyWithLexID + VehPartyWithDids;
	dAllVehicleParty := DISTRIBUTE(AllVehicleParty, HASH32(Vehicle_Party_ID)) ;

EXPORT iVehicleParty := dAllVehicleParty : PERSIST('~THOR::BASE::NTL_ACCIDENTS_INQUIRY::PERSIST::I_VEHICLE_PARTY');