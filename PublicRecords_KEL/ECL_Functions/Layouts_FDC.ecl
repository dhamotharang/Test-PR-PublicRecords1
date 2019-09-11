IMPORT BankruptcyV3, BIPV2, Cortera_Tradeline, dx_header, Doxie_Files, FAA, Header_Quick, 
	PublicRecords_KEL, VehicleV2, Watercraft, data_services;

EXPORT Layouts_FDC(PublicRecords_KEL.Interface_Options Options = PublicRecords_KEL.Interface_Options) := MODULE 

  SHARED unsigned1 iType := IF(Options.IsFCRA, data_services.data_env.iFCRA, data_services.data_env.iNonFCRA);

	SHARED LayoutIDs := RECORD
		INTEGER InputUIDAppend;
		INTEGER7 LexIDAppend;
		INTEGER BusInputUIDAppend;
		INTEGER7 LexIDBusExtendedFamilyAppend;//UltID
		INTEGER7 LexIDBusLegalFamilyAppend;	//OrgID
		INTEGER7 LexIDBusLegalEntityAppend;//SeleID
	END;
	
	SHARED Doxie__Key_Header := dx_header.key_header(iType);
	EXPORT Layout_Doxie__Key_Header := RECORD
		LayoutIDs;
		RECORDOF(Doxie__Key_Header);
		UNSIGNED8 DPMBitmap;
	END;	

	SHARED Header_Quick__Key_Did := IF(Options.IsFCRA, Header_Quick.Key_Did_FCRA, Header_Quick.Key_Did);
	EXPORT Layout_Header_Quick__Key_Did := RECORD
		LayoutIDs;
		RECORDOF(Header_Quick__Key_Did);
		UNSIGNED8 DPMBitmap;
	END;	

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

	// --------------------[ Business Header ]--------------------

	SHARED BIPV2__Key_BH_Linking_Ids__key := BIPV2.Key_BH_Linking_Ids.key;
	EXPORT Layout_BIPV2__Key_BH_Linking_Ids := RECORD
		LayoutIDs;
		RECORDOF(BIPV2__Key_BH_Linking_Ids__key);
		UNSIGNED8 DPMBitmap;
	END;

	// --------------------[ Tradeline ]--------------------

	SHARED Cortera_Tradeline__Key_LinkIds__key := Cortera_Tradeline.Key_LinkIds.Key;
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

	SHARED Watercraft__key_watercraft_sid := Watercraft.key_watercraft_sid();
	EXPORT Layout_Watercraft__Key_Watercraft_SID := RECORD
		LayoutIDs;
		RECORDOF(Watercraft__key_watercraft_sid);
		STRING2 src;
		UNSIGNED8 DPMBitmap;
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
		// Aircraft
		DATASET(Layout_FAA__key_aircraft_id) Dataset_FAA__Key_Aircraft_IDs;
		// Vehicle
		DATASET(Layout_VehicleV2__Key_Vehicle_Party_Key) Dataset_VehicleV2__Key_Vehicle_Party_Key;
		DATASET(Layout_VehicleV2__Key_Vehicle_Main_Key) Dataset_VehicleV2__Key_Vehicle_Main_Key;
    // Watercraft
		DATASET(Layout_Watercraft__Key_Watercraft_SID) Dataset_Watercraft__Key_Watercraft_SID;
		
    // --------------------[ Business Section ]--------------------
		// Business Header
		DATASET(Layout_BIPV2__Key_BH_Linking_Ids) Dataset_BIPV2__Key_BH_Linking_Ids;
		// Cortera Tradeline
		DATASET(Layout_Cortera_Tradeline__Key_LinkIds) Dataset_Cortera_Tradeline__Key_LinkIds;
	END;
	
END;
