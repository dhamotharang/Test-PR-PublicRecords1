
IMPORT ADVO, BankruptcyV3, BBB2, BIPV2, BIPV2_Best, BusReg,CalBus, CellPhone, Corp2, Cortera, Cortera_Tradeline, 
	DMA, DCAV2, Doxie_Files, dx_Email, dx_Header,EBR,  FAA,FBNv2, Fraudpoint3, Gong, GovData, 
	Header_Quick, InfoUSA, InfutorCID, Inquiry_AccLogs, IRS5500, Phonesplus_v2, Prof_License_Mari, Prof_LicenseV2,
	PublicRecords_KEL, OSHAIR, Targus, USPIS_HotList, UtilFile,SAM, VehicleV2, Watercraft,YellowPages, 
	UCCV2, dx_Infutor_NARB, dx_Equifax_Business_Data, BIPV2_Build, DriversV2, Risk_Indicators, Relationship,dx_header, data_services, Doxie;
	
	EXPORT Layouts_FDC(PublicRecords_KEL.Interface_Options Options = PublicRecords_KEL.Interface_Options) := MODULE 
	
	EXPORT LayoutIDs := RECORD
		INTEGER UIDAppend;
		INTEGER G_ProcUID;
		INTEGER G_ProcBusUID;
		INTEGER7 P_LexID;
		INTEGER7 B_LexIDUlt; // UltID
		INTEGER7 B_LexIDOrg;    // OrgID
		INTEGER7 B_LexIDLegal;    // SeleID
		INTEGER7 B_LexIDSite;     // ProxID
		INTEGER7 B_LexIDLoc;          // PowID
		STRING54 P_InpClnEmail;
		STRING50 P_InpClnDL;		
	END;

	EXPORT LayoutAddressGeneric := RECORD
		LayoutIDs;
		STRING10 PrimaryRange;
		STRING6 Predirectional; 
		STRING28 PrimaryName;
		STRING6 AddrSuffix;
		STRING6 Postdirectional;
		STRING25 City;
		STRING2 State;
		STRING6 ZIP5;
		STRING8 SecondaryRange;
		INTEGER CityCode;
		STRING8 AddressType;
	END;

	EXPORT LayoutPhoneGeneric := RECORD
		LayoutIDs;
		STRING10 Phone;
	END;
  
SHARED unsigned1 iType := IF(Options.IsFCRA, data_services.data_env.iFCRA, data_services.data_env.iNonFCRA);
	
	EXPORT LayoutPhoneAutoKeys := RECORD
		LayoutPhoneGeneric;
		unsigned6 Fdid;
	END;
	
  SHARED Doxie__Key_Header := dx_header.key_header(iType);
	EXPORT Layout_Doxie__Key_Header := RECORD
		LayoutIDs;
		LayoutAddressGeneric;
		RECORDOF(Doxie__Key_Header);
		UNSIGNED8 DPMBitmap;
	END;	
	// For Consumer and Address data
	
	SHARED Header_Quick__Key_Did := IF(Options.IsFCRA, Header_Quick.Key_Did_FCRA, Header_Quick.Key_Did);
	EXPORT Layout_Header_Quick__Key_Did := RECORD
		LayoutIDs;
		RECORDOF(Header_Quick__Key_Did);
		UNSIGNED8 DPMBitmap;
	END;	
	// For Consumer and Address data

	// --------------------[ Criminal ]--------------------
	
	EXPORT Layout_Doxie_Files__Key_BocaShell_Crim_FCRA_Denorm := RECORD
		LayoutIDs;
		RECORDOF(Doxie_Files.Key_BocaShell_Crim_FCRA);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;
	
	EXPORT Layout_Doxie_Files__Key_BocaShell_Crim_FCRA := RECORD
		LayoutIDs;
		RECORDOF(Doxie_Files.Key_BocaShell_Crim_FCRA) - Criminal_Count; // Changing layout to normalize child dataset Criminal_Count
		RECORDOF(Doxie_Files.Key_BocaShell_Crim_FCRA.Criminal_Count);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;
	
	EXPORT Layout_Doxie_Files__Key_Offenders := RECORD
		LayoutIDs;
		RECORDOF(Doxie_Files.Key_Offenders);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;	
	
	EXPORT Layout_Doxie_files__Key_Court_Offenses := RECORD
		LayoutIDs;
		RECORDOF(Doxie_files.Key_Court_Offenses);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;	
	
	EXPORT Layout_Doxie_Files__Key_Offenses := RECORD
		LayoutIDs;
		RECORDOF(Doxie_Files.Key_Offenses);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;	
	
	EXPORT Layout_Doxie_Files__Key_Offenders_Risk := RECORD
		LayoutIDs;
		RECORDOF(Doxie_Files.Key_Offenders_Risk);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;
	

	EXPORT Layout_Doxie_Files__Key_Punishment := RECORD
		LayoutIDs;
		RECORDOF(Doxie_Files.Key_Punishment);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;
	
	// --------------------[ Bankruptcy ]--------------------

	SHARED BankruptcyV3__key_bankruptcyV3_did := BankruptcyV3.key_bankruptcyV3_did(Options.IsFCRA);
	EXPORT Layout_Bankruptcy__Key_did := RECORD
		LayoutIDs;
		RECORDOF(BankruptcyV3__key_bankruptcyV3_did);
	END;		

	SHARED BankruptcyV3__key_bankruptcyv3_search_full_bip := BankruptcyV3.key_bankruptcyv3_search_full_bip(Options.IsFCRA);
	EXPORT Layout_BankruptcyV3__key_bankruptcyv3_search := RECORD
		LayoutIDs;
		RECORDOF(BankruptcyV3__key_bankruptcyv3_search_full_bip);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;	

	SHARED BankruptcyV3__key_bankruptcyV3_linkids_Key := BankruptcyV3.key_bankruptcyV3_linkids.kFetch2;
	EXPORT Layout_BankruptcyV3__key_bankruptcyV3_linkids_Key := RECORD
		LayoutIDs;
		RECORDOF(BankruptcyV3__key_bankruptcyV3_linkids_Key);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;
	// --------------------[ Business Header ]--------------------

	SHARED BIPV2__Key_BH_Linking_Ids__kfetch2 := BIPV2.Key_BH_Linking_Ids.kfetch2;
		EXPORT Layout_BIPV2__Key_BH_Linking_kfetch2 := RECORD
			RECORDOF(BIPV2__Key_BH_Linking_Ids__kfetch2);
			STRING2 src;
			UNSIGNED8 DPMBitmap;
	END;
	// For Business and Address data

	// --------------------[ Tradeline ]--------------------

	SHARED Cortera_Tradeline__Key_LinkIds__key := Cortera_Tradeline.Key_LinkIds.kFetch;
	EXPORT Layout_Cortera_Tradeline__Key_LinkIds := RECORD
		LayoutIDs;
		RECORDOF(Cortera_Tradeline__Key_LinkIds__key);
		UNSIGNED8 DPMBitmap;
	END;

	// --------------------[ Aircraft ]--------------------

	SHARED FAA__key_aircraft_did := FAA.key_aircraft_did();
	EXPORT Layout_FAA__key_aircraft_did := RECORD
		LayoutIDs;
		RECORDOF(FAA__key_aircraft_did);
	END;
	
	SHARED FAA__key_aircraft_linkids := FAA.key_aircraft_linkids.kFetch2;
	EXPORT Layout_FAA__key_aircraft_linkids := RECORD
		LayoutIDs;
		RECORDOF(FAA__key_aircraft_linkids);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;
	
	SHARED FAA__key_aircraft_id := FAA.key_aircraft_id();
	EXPORT Layout_FAA__key_aircraft_id := RECORD
		LayoutIDs;
		RECORDOF(faa__key_aircraft_id);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

	// --------------------[ Vehicle ]--------------------

	SHARED VehicleV2__Key_Vehicle_DID := VehicleV2.Key_Vehicle_DID;
	EXPORT Layout_VehicleV2__Key_Vehicle_DID := RECORD
		LayoutIDs;
		RECORDOF(VehicleV2__Key_Vehicle_DID);
	END;
	
	SHARED VehicleV2__Key_Vehicle_LinkID_Key := VehicleV2.Key_Vehicle_linkids.kFetch;
	EXPORT Layout_VehicleV2__Key_Vehicle_LinkID_Key := RECORD
		LayoutIDs;
		RECORDOF(VehicleV2__Key_Vehicle_LinkID_Key);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;	

	SHARED VehicleV2__Key_Vehicle_Party_Key := VehicleV2.Key_Vehicle_Party_Key;
	EXPORT Layout_VehicleV2__Key_Vehicle_Party_Key := RECORD
		LayoutIDs;
		RECORDOF(VehicleV2__Key_Vehicle_Party_Key);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

	SHARED VehicleV2__Key_Vehicle_Main_Key := VehicleV2.Key_Vehicle_Main_Key;
	EXPORT Layout_VehicleV2__Key_Vehicle_Main_Key := RECORD
		LayoutIDs;
		RECORDOF(VehicleV2__Key_Vehicle_Main_Key);
		STRING cleaned_brand_date_1;
		STRING cleaned_brand_date_2;
		STRING cleaned_brand_date_3;
		STRING cleaned_brand_date_4;
		STRING cleaned_brand_date_5;
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

	// --------------------[ Watercraft ]--------------------

	SHARED Watercraft__key_watercraft_did := Watercraft.key_watercraft_did();
	EXPORT Layout_Watercraft__key_watercraft_DID := RECORD
		LayoutIDs;
		RECORDOF(Watercraft__key_watercraft_did);
	END;
	
	SHARED Watercraft__Key_LinkIds := Watercraft.Key_LinkIds.kFetch2;
	EXPORT Layout_Watercraft__Key_LinkIds := RECORD
		LayoutIDs;
		RECORDOF(Watercraft__Key_LinkIds);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

	SHARED Watercraft__key_watercraft_sid := Watercraft.key_watercraft_sid();
	EXPORT Layout_Watercraft__Key_Watercraft_SID := RECORD
		LayoutIDs;
		RECORDOF(Watercraft__key_watercraft_sid);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

	// --------------------[ ProfessionalLicense ]--------------------
	
	SHARED Prof_LicenseV2__Key_Proflic_Did := Prof_LicenseV2.Key_Proflic_Did();
	EXPORT Layout_Prof_LicenseV2__Key_Proflic_Did := RECORD
		LayoutIDs;
		RECORDOF(Prof_LicenseV2__Key_Proflic_Did);
		STRING20 Cleaned_License_Number; 
		STRING2 Src; 
		STRING100 Occupation; 
		STRING1 Category;
		UNSIGNED8 DPMBitmap;
	END;

	SHARED Prof_License_Mari__key_did := Prof_License_Mari.key_did();
	EXPORT Layout_Prof_License_Mari__key_did := RECORD
		LayoutIDs;
		RECORDOF(Prof_License_Mari__key_did);
		STRING20 Cleaned_License_Number; 
		STRING2 Src; 
		STRING100 Occupation; 
		STRING1 Category;
		UNSIGNED8 DPMBitmap;
	END;
	
	// --------------------[ Email ]--------------------
	
	SHARED Email_Data__Key_DID :=  dx_Email.Key_Did();
	SHARED Email_Data__Key_Email_Address := dx_Email.Key_Email_Address();
	EXPORT Email_Data__Key_Email_Temp := RECORD
		LayoutIDs;
		RECORDOF(Email_Data__Key_DID);
		RECORDOF(Email_Data__Key_Email_Address) - email_rec_key;
	END;	
	
	SHARED DX_Email__Key_Email_Payload :=  DX_Email.Key_Email_Payload();
	EXPORT Layout_DX_Email__Key_Email_Payload := RECORD
		LayoutIDs;
		RECORDOF(DX_Email__Key_Email_Payload);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;
	
	// --------------------[ Address ]--------------------

	// NOTE: some keys for Address--Consumer and Business--are defined above already.
	// See comments.
	
	// Consumer Address keys, NonFCRA and FCRA:
	SHARED ADVO__Key_Addr1 := IF(Options.IsFCRA, ADVO.Key_Addr1_FCRA, ADVO.Key_Addr1);
	EXPORT Layout_ADVO__Key_Addr1 := RECORD
		LayoutIDs;
		RECORDOF(ADVO__Key_Addr1); // contains "src"
		UNSIGNED8 DPMBitmap;
	END;

	SHARED ADVO__Key_Addr1_History := IF(Options.IsFCRA, ADVO.Key_Addr1_FCRA_History, ADVO.Key_Addr1_History);
	EXPORT Layout_ADVO__Key_Addr1_History := RECORD
		LayoutIDs;
		RECORDOF(ADVO__Key_Addr1_History);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

	SHARED DMA__Key_DNM_Name_Address := DMA.Key_DNM_Name_Address;
	EXPORT Layout_DMA__Key_DNM_Name_Address := RECORD
		LayoutIDs;
		RECORDOF(DMA__Key_DNM_Name_Address);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

	SHARED Fraudpoint3__Key_Address := Fraudpoint3.Key_Address;
	EXPORT Layout_Fraudpoint3__Key_Address := RECORD
		LayoutIDs;
		RECORDOF(Fraudpoint3__Key_Address);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

	SHARED Header__Key_Addr_Hist := dx_Header.key_addr_hist();
	EXPORT Layout_Header__Key_Addr_Hist := RECORD
		LayoutIDs;
		RECORDOF(Header__Key_Addr_Hist);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

	SHARED Inquiry_AccLogs__Key_FCRA_DID := Inquiry_AccLogs.Key_FCRA_DID;
	EXPORT Layout_Inquiry_AccLogs__Key_FCRA_DID := RECORD
		LayoutIDs;
		RECORDOF(Inquiry_AccLogs__Key_FCRA_DID);
		STRING8 DateOfInquiry; // ref. Vault PublicRecords_KEL.FileCleaning
		STRING8 TimeOfInquiry; // ref. Vault PublicRecords_KEL.FileCleaning
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

	SHARED USPIS_HotList__key_addr_search_zip := USPIS_HotList.key_addr_search_zip;
	EXPORT Layout_USPIS_HotList__key_addr_search_zip := RECORD
		LayoutIDs;
		RECORDOF(USPIS_HotList__key_addr_search_zip);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

	SHARED UtilFile__Key_Address := UtilFile.Key_Address;
	EXPORT Layout_UtilFile__Key_Address := RECORD
		LayoutIDs;
		RECORDOF(UtilFile__Key_Address);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

	SHARED UtilFile__Key_DID := UtilFile.Key_DID;
	EXPORT Layout_UtilFile__Key_DID := RECORD
		LayoutIDs;
		RECORDOF(UtilFile__Key_DID);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

	SHARED Corp2__Kfetch2_LinkIDs_Corp := Corp2.Key_LinkIDs.Corp.kfetch2;
	EXPORT Layout_Corp2__Kfetch_LinkIDs_Corp := RECORD
		LayoutIDs;
		RECORDOF(Corp2__Kfetch2_LinkIDs_Corp);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

	SHARED InfoUSA_Key_DEADCO_LinkIds := InfoUSA.Key_DEADCO_LinkIds.kFetch2;
	EXPORT Layout_InfoUSA__Key_DEADCO_LinkIds := RECORD
		LayoutIDs;
		RECORDOF(InfoUSA_Key_DEADCO_LinkIds);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;
	
	SHARED UtilFile__Kfetch2_LinkIds := UtilFile.Key_LinkIds.Kfetch2;
	EXPORT Layout_UtilFile__Kfetch2_LinkIds := RECORD
		LayoutIDs;
		RECORDOF(UtilFile__Kfetch2_LinkIds);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

	// --------------------[ UCC ]--------------------
	// Key Linkids Layout
	SHARED UCC__Key_LinkIds_key := UCCV2.Key_LinkIds.kFetch2;
	EXPORT Layout_UCC__Key_LinkIds_key := RECORD
		LayoutIDs;
		RECORDOF(UCC__Key_LinkIds_key);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

	// RMSID Main Layout
	SHARED UCC__Key_RMSID_Main := UCCV2.Key_rmsid_main();
	EXPORT Layout_UCC__Key_RMSID_Main := RECORD
		LayoutIDs;
		RECORDOF(UCC__Key_RMSID_Main);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

	// RMSID Party Layout
	SHARED UCC__Key_RMSID_Party := UCCV2.Key_Rmsid_Party();
	EXPORT Layout_UCC__Key_RMSID_Party := RECORD
		LayoutIDs;
		RECORDOF(UCC__Key_RMSID_Party);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

	// --------------------[ Person ]--------------------

	// NOTE: some keys for Person are defined above already.
	
	SHARED Doxie__Key_Death_MasterV2_SSA_DID := Doxie.Key_Death_MasterV2_SSA_DID;
	EXPORT Layout_Doxie__Key_Death_MasterV2_SSA_DID := RECORD
		LayoutIDs;
		RECORDOF(Doxie__Key_Death_MasterV2_SSA_DID);  // contains "src"
		UNSIGNED8 DPMBitmap;
	END;

	SHARED DriversV2__Key_DL_DID := DriversV2.Key_DL_DID;
	EXPORT Layout_DriversV2__Key_DL_DID := RECORD
		LayoutIDs;
		RECORDOF(DriversV2__Key_DL_DID);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

	SHARED DriversV2__Key_DL_Number := DriversV2.Key_DL_Number;
	EXPORT Layout_DriversV2__Key_DL_Number := RECORD
		LayoutIDs;
		RECORDOF(DriversV2__Key_DL_Number);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

	SHARED Doxie__Key_Header_Address := dx_header.key_header_address; // not Doxie.Key_Address;
	EXPORT Layout_Doxie__Key_Header_Address := RECORD
		LayoutIDs;
		RECORDOF(Doxie__Key_Header_Address);  // contains "src"
		UNSIGNED8 DPMBitmap;
	END;

	SHARED Risk_Indicators__Key_FCRA_ADL_Risk_Table_v4_Filtered := Risk_Indicators.Key_FCRA_ADL_Risk_Table_v4_Filtered;
	EXPORT Layout_Risk_Indicators__Key_FCRA_ADL_Risk_Table_v4_Filtered := RECORD // "Filtered" = FCRA
		LayoutIDs;
		RECORDOF(Risk_Indicators__Key_FCRA_ADL_Risk_Table_v4_Filtered);
	END;	
	
	EXPORT Layout_Risk_Indicators__Key_FCRA_ADL_Risk_Table_v4_Filtered_Expanded := RECORD // "Filtered" = FCRA
		LayoutIDs;
		RECORDOF(Risk_Indicators__Key_FCRA_ADL_Risk_Table_v4_Filtered) AND NOT [combo, eq, en, tn];
		RECORDOF(Risk_Indicators__Key_FCRA_ADL_Risk_Table_v4_Filtered.combo);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

	SHARED Risk_Indicators__Key_ADL_Risk_Table_v4 := Risk_Indicators.Key_ADL_Risk_Table_v4;
	EXPORT Layout_Risk_Indicators__Key_ADL_Risk_Table_v4 := RECORD // no "Filtered" = NonFCRA
		LayoutIDs;
		RECORDOF(Risk_Indicators__Key_ADL_Risk_Table_v4);
	END;
	
	EXPORT Layout_Risk_Indicators__Key_ADL_Risk_Table_v4_Expanded := RECORD // no "Filtered" = NonFCRA
		LayoutIDs;
		RECORDOF(Risk_Indicators__Key_ADL_Risk_Table_v4) AND NOT [combo, eq, en, tn];
		RECORDOF(Risk_Indicators__Key_ADL_Risk_Table_v4.combo);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

// --------------------[ Relatives ]--------------------
	SHARED Relatives__Key_Relatives_V3 := Relationship.key_relatives_v3;
	EXPORT Layout_Relatives__Key_Relatives_V3 := RECORD
		LayoutIDs;
		RECORDOF(Relatives__Key_Relatives_V3);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

	SHARED BBB2__kfetch_BBB_LinkIds := BBB2.Key_BBB_LinkIds.Kfetch2;
	EXPORT Layout_BBB2__kfetch_BBB_LinkIds := RECORD
		LayoutIDs;
		RECORDOF(BBB2__kfetch_BBB_LinkIds);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;	
	
	SHARED BBB2__kfetch_BBB_Non_Member_LinkIds :=  BBB2.Key_BBB_Non_Member_LinkIds.Kfetch2;
	EXPORT Layout_BBB2__kfetch_BBB_Non_Member_LinkIds := RECORD
		LayoutIDs;
		RECORDOF(BBB2__kfetch_BBB_Non_Member_LinkIds);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

	SHARED BusReg__kfetch_busreg_company_linkids :=  BusReg.key_busreg_company_linkids.Kfetch2;
	EXPORT Layout_BusReg__kfetch_busreg_company_linkids := RECORD
		LayoutIDs;
		RECORDOF(BusReg__kfetch_busreg_company_linkids);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;
	
		SHARED CalBus__kfetch_Calbus_LinkIDS := CalBus.Key_Calbus_LinkIDS.Kfetch2;
	EXPORT Layout_CalBus__kfetch_Calbus_LinkIDS := RECORD
		LayoutIDs;
		RECORDOF(CalBus__kfetch_Calbus_LinkIDS);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;
	
		SHARED Cortera__kfetch_LinkID := Cortera.Key_LinkIDs.Kfetch2;
	EXPORT Layout_Cortera__kfetch_LinkID := RECORD
		LayoutIDs;
		RECORDOF(Cortera__kfetch_LinkID);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;
	
		SHARED DCAV2__kfetch_LinkIds := DCAV2.Key_LinkIds.Kfetch2;
	EXPORT Layout_DCAV2__kfetch_LinkIds := RECORD
		LayoutIDs;
		RECORDOF(DCAV2__kfetch_LinkIds);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

	SHARED EBR__kfetch_5600_Demographic_Data_linkids := EBR.Key_5600_Demographic_Data_linkids.Kfetch2;
	EXPORT Layout_EBR_kfetch_5600_Demographic_Data_linkids := RECORD
		LayoutIDs;
		RECORDOF(EBR__kfetch_5600_Demographic_Data_linkids);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;
	
	SHARED FBNv2__kfetch_LinkIds := FBNv2.Key_LinkIds.Kfetch2;
	EXPORT Layout_FBNv2__kfetch_LinkIds := RECORD
		LayoutIDs;
		RECORDOF(FBNv2__kfetch_LinkIds);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

	SHARED GovData__kfetch_IRS_NonProfit_linkIDs := GovData.key_IRS_NonProfit_linkIDs.Kfetch2;
	EXPORT Layout_GovData__kfetch_IRS_NonProfit_linkIDs := RECORD
		LayoutIDs;
		RECORDOF(GovData__kfetch_IRS_NonProfit_linkIDs);
		STRING2 src;
		INTEGER8 Reported_Earnings;
		UNSIGNED8 DPMBitmap;
	END;

	SHARED IRS5500__kfetch_LinkIDs := IRS5500.Key_LinkIDs.Kfetch2;
	EXPORT Layout_IRS5500__kfetch_LinkIDs := RECORD
		LayoutIDs;
		RECORDOF(IRS5500__kfetch_LinkIDs);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

	SHARED OSHAIR__kfetch_OSHAIR_LinkIds := OSHAIR.Key_OSHAIR_LinkIds.Kfetch2;
	EXPORT Layout_OSHAIR__kfetch_OSHAIR_LinkIds := RECORD
		LayoutIDs;
		RECORDOF(OSHAIR__kfetch_OSHAIR_LinkIds);
		STRING2 src;
		STRING1 inspection_type_code;
		UNSIGNED8 DPMBitmap;
	END;

	SHARED SAM__kfetch_linkID := SAM.key_linkID.Kfetch2;
	EXPORT Layout_SAM__kfetch_linkID := RECORD
		LayoutIDs;
		RECORDOF(SAM__kfetch_linkID);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

	SHARED YellowPages__kfetch_yellowpages_linkids := YellowPages.key_yellowpages_linkids.Kfetch2;
	EXPORT Layout_YellowPages__kfetch_yellowpages_linkids := RECORD
		LayoutIDs;
		RECORDOF(YellowPages__kfetch_yellowpages_linkids);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;
	
	SHARED Infutor_NARB__kfetch_LinkIds := dx_Infutor_NARB.Key_Linkids.Kfetch;//no kfetch2
	EXPORT Layout_Infutor_NARB__kfetch_LinkIds := RECORD
		LayoutIDs;
		RECORDOF(Infutor_NARB__kfetch_LinkIds);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;
	
	SHARED Equifax_Business_Data__kfetch_LinkIDs := dx_Equifax_Business_Data.Key_LinkIDs.Kfetch;//no kfetch2
	EXPORT Layout_Equifax_Business__Data_kfetch_LinkIDs := RECORD
		LayoutIDs;
		RECORDOF(Equifax_Business_Data__kfetch_LinkIDs);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;
	
	SHARED BIPV2_Build__kfetch_contact_linkids := BIPV2_Build.key_contact_linkids.Kfetch;//no kfetch2
	EXPORT Layout_BIPV2_Build__kfetch_contact_linkids := RECORD
		LayoutIDs;
		RECORDOF(BIPV2_Build__kfetch_contact_linkids);
		STRING2 src;
		String JobTitle; 
		String Status;
		UNSIGNED8 DPMBitmap;
	END;

	// --------------------[ BIP Best ]--------------------	
	EXPORT Layout_BIPV2_Best__Key_LinkIds := RECORD
		LayoutIDs;
		RECORDOF(BIPv2.IdAppendRoxie(DATASET([], BIPV2.IdAppendLayouts.AppendInput)).withBest());
		UNSIGNED8 DPMBitmap;
		STRING2 src;
	END;

	// --------------------[ Phone ]--------------------

	SHARED Gong__Key_History_DID := IF( Options.isFCRA, Gong.Key_History_DID, Gong.Key_FCRA_History_DID );
	EXPORT Layout_Gong__Key_History_DID := RECORD
		LayoutIDs;
		LayoutAddressGeneric;
		RECORDOF(Gong__Key_History_DID); // contains "src"
		STRING3 Listing_Type;
		UNSIGNED8 DPMBitmap;
	END;	
	
	SHARED Gong__Key_History_Address := IF( Options.isFCRA, Gong.Key_History_Address, Gong.Key_FCRA_History_Address );
	EXPORT Layout_Gong__Key_History_Address := RECORD
		LayoutIDs;
		LayoutAddressGeneric;
		RECORDOF(Gong__Key_History_Address); // contains "src"
		STRING3 Listing_Type;
		UNSIGNED8 DPMBitmap;
	END;	
	
	SHARED Gong__Key_History_Phone := IF( Options.isFCRA, Gong.Key_History_Phone, Gong.Key_FCRA_History_Phone );
	EXPORT Layout_Gong__Key_History_Phone := RECORD
		LayoutIDs;
		LayoutAddressGeneric;
		RECORDOF(Gong__Key_History_Phone); // contains "src"
		STRING3 Listing_Type;
		UNSIGNED8 DPMBitmap;
	END;	

	SHARED Gong__Key_History_LinkIds := Gong.Key_History_LinkIds.kFetch2;
	EXPORT Layout_Gong__Key_History_LinkIds := RECORD
		LayoutIDs;
		LayoutAddressGeneric;
		RECORDOF(Gong__Key_History_LinkIds);
		STRING3 Listing_Type;
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

	SHARED Targus__Key_Targus_Address := IF( Options.isFCRA, Targus.Key_Targus_Address, Targus.Key_Targus_FCRA_Address );
	EXPORT Layout_Targus__Key_Targus_Address := RECORD
		LayoutIDs;
		LayoutAddressGeneric;
		RECORDOF(Targus__Key_Targus_Address);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;	
	
	SHARED Targus__Key_Targus_Phone := IF( Options.isFCRA, Targus.Key_Targus_Phone, Targus.Key_Targus_FCRA_Phone );
	EXPORT Layout_Targus__Key_Targus_Phone := RECORD
		LayoutIDs;
		LayoutAddressGeneric;
		RECORDOF(Targus__Key_Targus_Phone);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;	
	 
	SHARED InfutorCID__Key_Infutor_Phone := IF( Options.isFCRA, InfutorCID.Key_Infutor_Phone, InfutorCID.Key_Infutor_Phone_FCRA );
	EXPORT Layout_InfutorCID__Key_Infutor_Phone := RECORD
		LayoutIDs;
		LayoutAddressGeneric;
		RECORDOF(InfutorCID__Key_Infutor_Phone);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;	
	
	SHARED PhonesPlus_v2_Keys_Scoring_Phone := Phonesplus_v2.Keys_Scoring().phone.qa;
	EXPORT Layout_Phone__PhonesPlus_v2_Keys_Scoring_Phone := RECORD
		LayoutIDs;
		LayoutPhoneGeneric;
		RECORDOF(PhonesPlus_v2_Keys_Scoring_Phone);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

	SHARED PhonesPlus_v2_Keys_Scoring_Address := Phonesplus_v2.Keys_Scoring().address.qa;
	EXPORT Layout_Phone__PhonesPlus_v2_Keys_Scoring_Address := RECORD
		LayoutIDs;
		LayoutAddressGeneric;
		RECORDOF(PhonesPlus_v2_Keys_Scoring_Address);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

	SHARED PhonesPlus_v2_Keys_Iverification_Phone := Phonesplus_v2.Keys_Iverification().phone.qa;
	EXPORT Layout_Key_Iverification__Keys_Iverification_phone := RECORD
		LayoutIDs;
		LayoutPhoneGeneric;
		RECORDOF(PhonesPlus_v2_Keys_Iverification_Phone);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

	SHARED PhonesPlus_v2_Keys_Iverification_Did_Phone := Phonesplus_v2.Keys_Iverification().did_phone.qa;
	EXPORT Layout_Key_Iverification__Keys_Iverification_Did_Phone := RECORD
		LayoutIDs;
		LayoutPhoneGeneric;
		RECORDOF(PhonesPlus_v2_Keys_Iverification_Did_Phone);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

	SHARED CellPhone__Key_Neustar_Phone := CellPhone.key_neustar_phone;
	EXPORT Layout_Key_CellPhone__Key_Neustar_Phone := RECORD
		LayoutIDs;
		LayoutPhoneGeneric;
		RECORDOF(CellPhone__Key_Neustar_Phone);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
	END;

	SHARED PhonesPlus_v2_Key_PhonePlus_Fdid_Records := Phonesplus_v2.Key_Phonesplus_Fdid;
	EXPORT Layout_PhonesPlus_v2_Key_PhonePlus_Fdid_Records := RECORD
		LayoutIDs;
		LayoutPhoneGeneric;
		RECORDOF(PhonesPlus_v2_Key_PhonePlus_Fdid_Records);
		UNSIGNED8 DPMBitmap;
		STRING2 Source;
	END;
	
	// ===================[ Composite Layout ]===================
  
	EXPORT Layout_FDC := RECORD
		LayoutIDs;

		DATASET(Layout_Doxie__Key_Header) Dataset_Doxie__Key_Header;		
		DATASET(Layout_Header_Quick__Key_Did) Dataset_Header_Quick__Key_Did;		
    
		// --------------------[ Consumer Section ]--------------------
		// Criminal
		DATASET(Layout_Doxie_Files__Key_BocaShell_Crim_FCRA) Dataset_Doxie_Files__Key_BocaShell_Crim_FCRA;		
		DATASET(Layout_Doxie_Files__Key_Offenders) Dataset_Doxie_Files__Key_Offenders;		
		DATASET(Layout_Doxie_files__Key_Court_Offenses) Dataset_Doxie_files__Key_Court_Offenses;		
		DATASET(Layout_Doxie_Files__Key_Offenses) Dataset_Doxie_Files__Key_Offenses;		
		DATASET(Layout_Doxie_Files__Key_Offenders_Risk) Dataset_Doxie_Files__Key_Offenders_Risk;		
		DATASET(Layout_Doxie_Files__Key_Punishment) Dataset_Doxie_Files__Key_Punishment;		
		// Bankruptcy
		DATASET(Layout_BankruptcyV3__key_bankruptcyv3_search) Dataset_Bankruptcy_Files__Key_Search;		
		DATASET(Layout_BankruptcyV3__key_bankruptcyV3_linkids_Key) Dataset_Bankruptcy_Files__Linkids_Key_Search;

		// Aircraft
		DATASET(Layout_FAA__key_aircraft_id) Dataset_FAA__Key_Aircraft_IDs;		
		    // Watercraft
		DATASET(Layout_Watercraft__Key_Watercraft_SID) Dataset_Watercraft__Key_Watercraft_SID;		
		// ProfessionalLicense
		DATASET(Layout_Prof_LicenseV2__Key_Proflic_Did) Dataset_Prof_LicenseV2__Key_Proflic_Did;		
		DATASET(Layout_Prof_License_Mari__Key_Did) Dataset_Prof_License_Mari__Key_Did;		
		// Email
		DATASET(Layout_DX_Email__Key_Email_Payload) Dataset_DX_Email__Key_Email_Payload;		
		// Address
		DATASET(Layout_ADVO__Key_Addr1) Dataset_ADVO__Key_Addr1;		
		DATASET(Layout_ADVO__Key_Addr1_History) Dataset_ADVO__Key_Addr1_History;		
		DATASET(Layout_DMA__Key_DNM_Name_Address) Dataset_DMA__Key_DNM_Name_Address;		
		DATASET(Layout_Fraudpoint3__Key_Address) Dataset_Fraudpoint3__Key_Address;		
		DATASET(Layout_Header__Key_Addr_Hist) Dataset_Header__Key_Addr_Hist;		
		DATASET(Layout_Inquiry_AccLogs__Key_FCRA_DID) Dataset_Inquiry_AccLogs__Key_FCRA_DID;		
		DATASET(Layout_USPIS_HotList__key_addr_search_zip) Dataset_USPIS_HotList__key_addr_search_zip;		
		DATASET(Layout_UtilFile__Key_Address) Dataset_UtilFile__Key_Address;		
		DATASET(Layout_UtilFile__Key_DID) Dataset_UtilFile__Key_DID;		
		// Person 
		DATASET(Layout_Doxie__Key_Header_Address) Dataset_Doxie__Key_Header_Address; 
		DATASET(Layout_Doxie__Key_Death_MasterV2_SSA_DID) Dataset_Doxie__Key_Death_MasterV2_SSA_DID; 
		DATASET(Layout_DriversV2__Key_DL_DID) Dataset_DriversV2__Key_DL_DID; 
		DATASET(Layout_DriversV2__Key_DL_Number) Dataset_DriversV2__Key_DL_Number; 
		DATASET(Layout_Risk_Indicators__Key_FCRA_ADL_Risk_Table_v4_Filtered_Expanded) Dataset_Risk_Indicators__Key_FCRA_ADL_Risk_Table_v4_Filtered_Combo; 
		DATASET(Layout_Risk_Indicators__Key_FCRA_ADL_Risk_Table_v4_Filtered_Expanded) Dataset_Risk_Indicators__Key_FCRA_ADL_Risk_Table_v4_Filtered_Experian; 
		DATASET(Layout_Risk_Indicators__Key_FCRA_ADL_Risk_Table_v4_Filtered_Expanded) Dataset_Risk_Indicators__Key_FCRA_ADL_Risk_Table_v4_Filtered_Equifax; 
		DATASET(Layout_Risk_Indicators__Key_ADL_Risk_Table_v4_Expanded) Dataset_Risk_Indicators__Key_ADL_Risk_Table_v4_Combo; 
		DATASET(Layout_Risk_Indicators__Key_ADL_Risk_Table_v4_Expanded) Dataset_Risk_Indicators__Key_ADL_Risk_Table_v4_Experian; 
		DATASET(Layout_Risk_Indicators__Key_ADL_Risk_Table_v4_Expanded) Dataset_Risk_Indicators__Key_ADL_Risk_Table_v4_Equifax; 
		DATASET(Layout_Risk_Indicators__Key_ADL_Risk_Table_v4_Expanded) Dataset_Risk_Indicators__Key_ADL_Risk_Table_v4_TransUnion; 
		// Phone
		DATASET(Layout_Gong__Key_History_DID) Dataset_Gong__Key_History_DID;
		DATASET(Layout_Gong__Key_History_Address) Dataset_Gong__Key_History_Address;
		DATASET(Layout_Gong__Key_History_Phone) Dataset_Gong__Key_History_Phone;
		DATASET(Layout_Gong__Key_History_LinkIds) Dataset_Gong__Key_History_LinkIds;
		DATASET(Layout_Targus__Key_Targus_Address) Dataset_Targus__Key_Address;
		DATASET(Layout_Targus__Key_Targus_Phone) Dataset_Targus__Key_Phone;
		DATASET(Layout_InfutorCID__Key_Infutor_Phone) Dataset_InfutorCID__Key_Phone;
	  DATASET(Layout_Phone__PhonesPlus_v2_Keys_Scoring_Phone) Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Phone;
		DATASET(Layout_Phone__PhonesPlus_v2_Keys_Scoring_Address) Dataset_Phone__PhonesPlus_v2_Keys_Scoring_Address;
		DATASET(Layout_Key_Iverification__Keys_Iverification_Phone) Dataset_Key_Iverification__Keys_Iverification_Phone;
		DATASET(Layout_Key_Iverification__Keys_Iverification_Did_Phone) Dataset_Key_Iverification__Keys_Iverification_Did_Phone;
		DATASET(Layout_Key_CellPhone__Key_Neustar_Phone) Dataset_Key_CellPhone__Key_Neustar_Phone;
	  DATASET(Layout_PhonesPlus_v2_Key_PhonePlus_Fdid_Records) Dataset_PhonesPlus_v2_Key_PhonePlus_Fdid_Records;
		// --------------------[ Business Section ]--------------------
		// Business Header
		DATASET(Layout_BIPV2__Key_BH_Linking_kfetch2) Dataset_BIPV2__Key_BH_Linking_kfetch2;
		// Cortera Tradeline
		DATASET(Layout_Cortera_Tradeline__Key_LinkIds) Dataset_Cortera_Tradeline__Key_LinkIds;
		// Address
		DATASET(Layout_Corp2__Kfetch_LinkIDs_Corp) Dataset_Corp2__Kfetch_LinkIDs_Corp;
		DATASET(Layout_InfoUSA__Key_DEADCO_LinkIds) Dataset_InfoUSA__Key_DEADCO_LinkIds;
		DATASET(Layout_UtilFile__Kfetch2_LinkIds) Dataset_UtilFile__Kfetch2_LinkIds;
		//vehicle
		DATASET(Layout_VehicleV2__Key_Vehicle_LinkID_Key) Dataset_VehicleV2__Key_Vehicle_LinkID_Key;
		//watercraft
		DATASET(Layout_Watercraft__Key_LinkIds) Dataset_Watercraft__Watercraft__Key_LinkIds;
		//aircraft
		DATASET(Layout_FAA__key_aircraft_linkids) Dataset_FAA__key_aircraft_linkids;
		//UCC
		DATASET(Layout_UCC__Key_LinkIds_key) Dataset_UCC__Key_LinkIds_key;
		DATASET(Layout_UCC__Key_RMSID_Main) Dataset_UCC__Key_RMSID_Main;
		DATASET(Layout_UCC__Key_RMSID_Party) Dataset_UCC__Key_RMSID_Party;
		//sele & prox remaining keys
		DATASET(Layout_BBB2__kfetch_BBB_LinkIds) Dataset_BBB2__kfetch_BBB_LinkIds;
		DATASET(Layout_BBB2__kfetch_BBB_Non_Member_LinkIds) Dataset_BBB2__kfetch_BBB_Non_Member_LinkIds;
		DATASET(Layout_BusReg__kfetch_busreg_company_linkids) Dataset_BusReg__kfetch_busreg_company_linkids;
		DATASET(Layout_CalBus__kfetch_Calbus_LinkIDS) Dataset_CalBus__kfetch_Calbus_LinkIDS;
		DATASET(Layout_Cortera__kfetch_LinkID) Dataset_Cortera__kfetch_LinkID;
		DATASET(Layout_DCAV2__kfetch_LinkIds) Dataset_DCAV2__kfetch_LinkIds;
		DATASET(Layout_EBR_kfetch_5600_Demographic_Data_linkids) Dataset_EBR_kfetch_5600_Demographic_Data_linkids;
		DATASET(Layout_FBNv2__kfetch_LinkIds) Dataset_FBNv2__kfetch_LinkIds;
		DATASET(Layout_GovData__kfetch_IRS_NonProfit_linkIDs) Dataset_GovData__kfetch_IRS_NonProfit_linkIDs;
		DATASET(Layout_IRS5500__kfetch_LinkIDs) Dataset_IRS5500__kfetch_LinkIDs;
		DATASET(Layout_OSHAIR__kfetch_OSHAIR_LinkIds) Dataset_OSHAIR__kfetch_OSHAIR_LinkIds;
		DATASET(Layout_SAM__kfetch_linkID) Dataset_SAM__kfetch_linkID;
		DATASET(Layout_YellowPages__kfetch_yellowpages_linkids) Dataset_YellowPages__kfetch_yellowpages_linkids;
		DATASET(Layout_Infutor_NARB__kfetch_LinkIds) Dataset_Layout_Infutor_NARB__kfetch_LinkIds;
		DATASET(Layout_Equifax_Business__Data_kfetch_LinkIDs) Dataset_Equifax_Business__Data_kfetch_LinkIDs;
		DATASET(Layout_BIPV2_Build__kfetch_contact_linkids) Dataset_BIPV2_Build__kfetch_contact_linkids;
		// BIP Best
		DATASET(Layout_BIPV2_Best__Key_LinkIds) Dataset_BIPV2_Best__Key_LinkIds;
		
				// --------------------[ Both ]--------------------
		
		// Vehicle
		DATASET(Layout_VehicleV2__Key_Vehicle_Party_Key) Dataset_VehicleV2__Key_Vehicle_Party_Key;
		DATASET(Layout_VehicleV2__Key_Vehicle_Main_Key) Dataset_VehicleV2__Key_Vehicle_Main_Key;
	
		// --------------------[ Relative - Person Relative ]--------------------

		// Relative V3
		DATASET(Layout_Relatives__Key_Relatives_V3) Dataset_Relatives__Key_Relatives_V3;
		
	
	END;
	
END;