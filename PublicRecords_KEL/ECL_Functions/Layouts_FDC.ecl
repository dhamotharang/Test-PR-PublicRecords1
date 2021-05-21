IMPORT AID_Build, ADVO, AlloyMedia_student_list,  American_student_list, AutoKey, AVM_V2, BankruptcyV3, BBB2, BIPV2, BIPV2_Best, BIPV2_Build, Business_Risk_BIP, BusReg, CalBus, CellPhone, Certegy, Corp2, 
		 Data_Services, DCAV2, Death_Master,  Doxie, Doxie_Files, DriversV2, DMA, dx_BestRecords, dx_ConsumerFinancialProtectionBureau, dx_Cortera, dx_DataBridge, DX_Email, 
		dx_Cortera_Tradeline, dx_Equifax_Business_Data, dx_Gong, dx_Header, dx_Infutor_NARB, dx_PhonesInfo, dx_PhonesPlus, dx_Property, dx_Relatives_v3, EBR, Email_Data, emerges, Experian_CRDB, FAA, FBNv2, FLAccidents_Ecrash, Fraudpoint3, Gong, 
		GovData, Header, Header_Quick, InfoUSA, IRS5500, InfutorCID, Inquiry_AccLogs, LiensV2, LN_PropertyV2, MDR, OSHAIR, Phonesplus_v2, PublicRecords_KEL, dx_prof_license_mari, 
		Prof_LicenseV2, Relationship, Risk_Indicators, RiskView, RiskWise, SAM, SexOffender, STD, Suppress, Targus, thrive, USPIS_HotList, Utilfile, ut,
		VehicleV2, Watercraft, Watchdog, UCCV2, YellowPages, dx_OSHAIR;	
	
	EXPORT Layouts_FDC(PublicRecords_KEL.Interface_Options Options = PublicRecords_KEL.Interface_Options) := MODULE 
	
	shared dpmtype := record
	DATA57 DPMBitMAP;	
	end;
	
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
		STRING10 B_InpClnTIN;
		STRING54 P_InpClnEmail;
		STRING50 P_InpClnDL;		
		STRING9 P_InpClnSSN;
		STRING20 P_InpClnNameFirst;
		STRING20 P_InpClnNameMid;
		STRING30 P_InpClnNameLast;		
		STRING30 P_InpClnSurname1;		
		STRING30 P_InpClnSurname2;		
		STRING20 p_inpclnarchdt;
		STRING10 P_InpClnDOB;
		STRING10 P_InpClnAddrPrimRng;
		STRING6 P_InpClnAddrPreDir;
		STRING28 P_InpClnAddrPrimName;
		STRING6 P_InpClnAddrSffx;
		STRING6 P_InpClnAddrPostDir;
		STRING25 P_InpClnAddrCity;
		STRING6 P_InpClnAddrState;
		STRING6 P_InpClnAddrZip5;
		STRING8 P_InpClnAddrSecRng;
		STRING AddressGeoLink;
		STRING6 P_InpClnAddrStateCode;
		STRING6 P_InpClnAddrCnty;
		STRING7 P_InpClnAddrGeo;
		STRING10 P_InpClnPhoneHome;
		INTEGER RepNumber;
		UNSIGNED4 Contact_date;
		Boolean IsInput;
	END;
	
	EXPORT LayoutIDs_Inputs := RECORD
		LayoutIDs;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides;
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
	
	EXPORT LayoutAddressGeneric_inputs := RECORD
		LayoutIDs_Inputs;
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
	
	EXPORT LayoutPhoneGeneric_inputs := RECORD
		LayoutIDs_Inputs;
		STRING10 Phone;
	END;
	
    EXPORT LayoutCombinedPhoneAddr := RECORD
    STRING10 Phone;
    LayoutAddressGeneric;
    END;
    

	EXPORT LayoutInquiries := record//for delta base nonFCRA only doesn't need context fields
	LayoutAddressGeneric;
	STRING10 Phone;
	END;	
	
	
SHARED unsigned1 iType := IF(Options.IsFCRA, data_services.data_env.iFCRA, data_services.data_env.iNonFCRA);
	
	EXPORT LayoutPhoneAutoKeys := RECORD
		LayoutPhoneGeneric;
		unsigned6 Fdid;
		STRING Archive_Date;
	END;
	
	SHARED Doxie__Key_Header := dx_header.key_header(iType);

	export tempHeader := record //for overrides
		INTEGER UIDAppend;
		INTEGER G_ProcUID; 
		Boolean HeaderRec;
		STRING Archive_Date;
		unsigned4 first_ingest_date;
		dpmtype;
		dx_Header.layout_header;	
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.header_correct_record_id;
	end;
	
	EXPORT Layout_Doxie__Key_Header := RECORD
		LayoutIDs;
		RECORDOF(Doxie__Key_Header)-dt_first_seen;//same as dx_Header.layout_header;
		unsigned dt_first_seen;
		STRING Archive_Date;
		unsigned4 first_ingest_date;
		STRING DOBPadded;
		dpmtype;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.header_correct_record_id;
		Boolean HeaderRec;//for corrections
	END;	
	
	
	
	// For Consumer and Address data
	
	SHARED Header_Quick__Key_Did := IF(Options.IsFCRA, Header_Quick.Key_Did_FCRA, Header_Quick.Key_Did);
	EXPORT Layout_Header_Quick__Key_Did := RECORD
		LayoutIDs;
		RECORDOF(Header_Quick__Key_Did)- dt_first_seen;
		unsigned dt_first_seen;
		STRING Archive_Date;
		unsigned4 first_ingest_date;
		STRING DOBPadded;
		dpmtype;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.header_correct_record_id;
		Boolean HeaderRec;//for corrections
	END;	
	// For Consumer and Address data

  SHARED Doxie__key_wild_SSN := dx_Header.key_wild_SSN();
	EXPORT Layout_Doxie__key_wild_SSN := RECORD
		LayoutIDs;
		RECORDOF(Doxie__key_wild_SSN);
		STRING Archive_Date;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides;//this will be needed
	END;	  
	
    SHARED Header_key_wild_phone := dx_Header.key_wild_phone();
	EXPORT Layout_Header_key_wild_phone := RECORD
		LayoutIDs;
		RECORDOF(Header_key_wild_phone);
		STRING Archive_Date;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides;
	END;	

	// --------------------[ Criminal ]--------------------
	
	
	EXPORT Layout_Doxie_Files__Key_Offenders := RECORD
		LayoutIDs;
		RECORDOF(Doxie_Files.Key_Offenders);
		STRING2 src;
		STRING Archive_Date;
		STRING DOBPadded;
		STRING DOB_AliasPadded;
		dpmtype;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.crim_correct_ofk;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.crim_correct_ffid;		
		END;	
	
	EXPORT Layout_Doxie_files__Key_Court_Offenses := RECORD
		LayoutIDs;
		RECORDOF(Doxie_files.Key_Court_Offenses);
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.crim_correct_ofk;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.crim_correct_ffid;	
		END;	
	
	EXPORT Layout_Doxie_Files__Key_Offenses := RECORD
		LayoutIDs;
		RECORDOF(Doxie_Files.Key_Offenses);
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.crim_correct_ofk;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.crim_correct_ffid;	
		END;	
	
	EXPORT Layout_Doxie_Files__Key_Offenders_Risk := RECORD
		LayoutIDs;
		RECORDOF(Doxie_Files.Key_Offenders_Risk);
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
	END;
	

	EXPORT Layout_Doxie_Files__Key_Punishment := RECORD
		LayoutIDs;
		RECORDOF(Doxie_Files.Key_Punishment);
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
	END;
	
	// --------------------[ Bankruptcy ]--------------------

	SHARED BankruptcyV3__key_bankruptcyV3_did := BankruptcyV3.key_bankruptcyV3_did(Options.IsFCRA);
	EXPORT Layout_Bankruptcy__Key_did := RECORD
		LayoutIDs;
		STRING Archive_Date;
		RECORDOF(BankruptcyV3__key_bankruptcyV3_did);
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.bankrupt_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.bankrupt_correct_RECORD_ID;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.bankrupt_correct_cccn;
	END;		

	SHARED BankruptcyV3__key_bankruptcyv3_search_full_bip := BankruptcyV3.key_bankruptcyv3_search_full_bip(Options.IsFCRA);
	EXPORT Layout_BankruptcyV3__key_bankruptcyv3_search := RECORD
		LayoutIDs;
		RECORDOF(BankruptcyV3__key_bankruptcyv3_search_full_bip);
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.bankrupt_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.bankrupt_correct_RECORD_ID;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.bankrupt_correct_cccn;
	END;	

	SHARED BankruptcyV3__key_bankruptcyV3_linkids_Key := BankruptcyV3.key_bankruptcyV3_linkids.kFetch2;
	EXPORT Layout_BankruptcyV3__key_bankruptcyV3_linkids_Key := RECORD
		LayoutIDs;
		RECORDOF(BankruptcyV3__key_bankruptcyV3_linkids_Key);
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
	END;
	// --------------------[ Business Header ]--------------------

	SHARED BIPV2__Key_BH_Linking_Ids__kfetch2 := BIPV2.Key_BH_Linking_Ids.kfetch2;
		EXPORT Layout_BIPV2__Key_BH_Linking_kfetch2 := RECORD
			RECORDOF(BIPV2__Key_BH_Linking_Ids__kfetch2);
			STRING2 src;
			dpmtype;
			BOOLEAN sele_gold_boolean;
			BOOLEAN is_sele_level_boolean; 
			BOOLEAN is_org_level_boolean; 
			BOOLEAN is_ult_level_boolean; 
			BOOLEAN iscorp_boolean;
			STRING Archive_Date;
			LayoutIDs;//this has to stay at the end of this layout or this key will display garbage for some reason
	END;
	// For Business and Address data

	// --------------------[ Tradeline ]--------------------

	EXPORT Layout_Cortera_Tradeline__Key_LinkIds := RECORD
		LayoutIDs;
		dx_Cortera_Tradeline.Layouts.Layout_Tradeline_Key;
		dpmtype;
		STRING Archive_Date;
	END;

	// --------------------[ Aircraft ]--------------------

	SHARED FAA__key_aircraft_did := FAA.key_aircraft_did();
	EXPORT Layout_FAA__key_aircraft_did := RECORD
		LayoutIDs;
		STRING Archive_Date;
		RECORDOF(FAA__key_aircraft_did);
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.air_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.air_correct_RECORD_ID;	
	END;
	
	SHARED FAA__key_aircraft_linkids := FAA.key_aircraft_linkids.kFetch2;
	EXPORT Layout_FAA__key_aircraft_linkids := RECORD
		LayoutIDs;
		RECORDOF(FAA__key_aircraft_linkids);
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
	END;
	
	SHARED FAA__key_aircraft_id := FAA.key_aircraft_id();
	EXPORT Layout_FAA__key_aircraft_id := RECORD
		LayoutIDs;
		RECORDOF(faa__key_aircraft_id);
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.air_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.air_correct_RECORD_ID;	

	END;

	// --------------------[ Vehicle ]--------------------

	SHARED VehicleV2__Key_Vehicle_DID := VehicleV2.Key_Vehicle_DID;
	EXPORT Layout_VehicleV2__Key_Vehicle_DID := RECORD
		LayoutIDs;
		STRING Archive_Date;
		RECORDOF(VehicleV2__Key_Vehicle_DID);
	END;
	
	SHARED VehicleV2__Key_Vehicle_LinkID_Key := VehicleV2.Key_Vehicle_linkids.kFetch;
	EXPORT Layout_VehicleV2__Key_Vehicle_LinkID_Key := RECORD
		LayoutIDs;
		RECORDOF(VehicleV2__Key_Vehicle_LinkID_Key)-date_first_seen;
		unsigned date_first_seen;
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
	END;	

	SHARED VehicleV2__Key_Vehicle_Party_Key := VehicleV2.Key_Vehicle_Party_Key;
	EXPORT Layout_VehicleV2__Key_Vehicle_Party_Key := RECORD
		LayoutIDs;
		RECORDOF(VehicleV2__Key_Vehicle_Party_Key)-date_first_seen;
		unsigned date_first_seen;
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
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
		STRING Archive_Date;
		dpmtype;
	END;

	// --------------------[ Watercraft ]--------------------

	SHARED Watercraft__key_watercraft_did := Watercraft.key_watercraft_did();
	EXPORT Layout_Watercraft__key_watercraft_DID := RECORD
		LayoutIDs;
		STRING Archive_Date;
		RECORDOF(Watercraft__key_watercraft_did);
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.water_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.water_correct_RECORD_ID;
	END;
	
	SHARED Watercraft__Key_LinkIds := Watercraft.Key_LinkIds.kFetch2;
	EXPORT Layout_Watercraft__Key_LinkIds := RECORD
		LayoutIDs;
		RECORDOF(Watercraft__Key_LinkIds);
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
	END;

	SHARED Watercraft__key_watercraft_sid := Watercraft.key_watercraft_sid();
	EXPORT Layout_Watercraft__Key_Watercraft_SID := RECORD
		LayoutIDs;
		RECORDOF(Watercraft__key_watercraft_sid);
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.water_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.water_correct_RECORD_ID;
	END;

	// --------------------[ ProfessionalLicense ]--------------------
	
	SHARED Prof_LicenseV2__Key_Proflic_Did := Prof_LicenseV2.Key_Proflic_Did();
	EXPORT Layout_Prof_LicenseV2__Key_Proflic_Did := RECORD
		LayoutIDs;
		RECORDOF(Prof_LicenseV2__Key_Proflic_Did);
		STRING20 Cleaned_License_Number; 
		STRING2 Src; 
		STRING Archive_Date;
		STRING100 Occupation; 
		STRING1 Category;
		dpmtype;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.proflic_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.proflic_correct_RECORD_ID;
	END;

	SHARED Prof_License_Mari__key_did := dx_prof_license_mari.layouts.i_did;
	EXPORT Layout_Prof_License_Mari__key_did := RECORD
		LayoutIDs;
		RECORDOF(Prof_License_Mari__key_did);
		STRING20 Cleaned_License_Number; 
		STRING2 Src; 
		STRING Archive_Date;
		STRING100 Occupation; 
		STRING1 Category;
		dpmtype;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.proflic_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.proflic_correct_RECORD_ID;
	END;
	
	// --------------------[ Email ]--------------------
	
	SHARED Email_Data__Key_DID :=  dx_Email.Key_Did();
	SHARED Email_Data__Key_Email_Address := dx_Email.Key_Email_Address();
	EXPORT Email_Data__Key_Email_Temp := RECORD
		LayoutIDs;
		STRING Archive_Date;
		RECORDOF(Email_Data__Key_DID);
		RECORDOF(Email_Data__Key_Email_Address) - email_rec_key - __internal_fpos__;
	END;	
	
	SHARED DX_Email__Key_Email_Payload :=  DX_Email.Key_Email_Payload();
	EXPORT Layout_DX_Email__Key_Email_Payload := RECORD
		LayoutIDs;
		RECORDOF(DX_Email__Key_Email_Payload);
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
	END;

	SHARED Email_Data__Key_Did_FCRA :=  Email_Data.Key_Did_FCRA;
	EXPORT Layout_Email_Data__Key_Did_FCRA := RECORD
		LayoutIDs;
		RECORDOF(Email_Data__Key_Did_FCRA);
		STRING Archive_Date;
		STRING2 src;
		dpmtype;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.email_data_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.email_data_correct_record_id
		END;	

	
	// --------------------[ Address ]--------------------

	// NOTE: some keys for Address--Consumer and Business--are defined above already.
	// See comments.
	

	SHARED ADVO__Key_Addr1_History := IF(Options.IsFCRA, ADVO.Key_Addr1_FCRA_History, ADVO.Key_Addr1_History);
	EXPORT Layout_ADVO__Key_Addr1_History := RECORD
		LayoutIDs;
		RECORDOF(ADVO__Key_Addr1_History);
		STRING12 Geo_Link;
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.advo_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.advo_correct_record_id;
	END;

	SHARED DMA__Key_DNM_Name_Address := DMA.Key_DNM_Name_Address;
	EXPORT Layout_DMA__Key_DNM_Name_Address := RECORD
		LayoutIDs;
		RECORDOF(DMA__Key_DNM_Name_Address);
		STRING3 src;
		STRING Archive_Date;
		dpmtype;
	END;

	SHARED Fraudpoint3__Key_Address := Fraudpoint3.Key_Address;
	EXPORT Layout_Fraudpoint3__Key_Address := RECORD
		LayoutIDs;
		RECORDOF(Fraudpoint3__Key_Address);
		STRING3 src;
		STRING Archive_Date;
		BOOLEAN FDNIndicator;
		dpmtype;
	END;

	SHARED Fraudpoint3__Key_SSN := Fraudpoint3.Key_SSN;
	EXPORT Layout_Fraudpoint3__Key_SSN := RECORD
		LayoutIDs;
		RECORDOF(Fraudpoint3__Key_SSN);
		STRING3 src;
		STRING Archive_Date;
		BOOLEAN FDNIndicator;
		dpmtype;
	END;	
	
	SHARED FraudPoint3_Key_Phone := FraudPoint3.key_phone;
	EXPORT Layout_FraudPoint3_Key_Phone := RECORD
		LayoutPhoneGeneric;
		RECORDOF(FraudPoint3_Key_Phone);
		dpmtype;
		STRING3 Src;
		STRING Archive_Date;
	END;

	SHARED Header__Key_Addr_Hist := dx_Header.key_addr_hist(iType);
	EXPORT Layout_Header__Key_Addr_Hist_temp := RECORD
		LayoutIDs;
		RECORDOF(Header__Key_Addr_Hist)-date_first_seen;
		unsigned date_first_seen;
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.header_correct_record_id;
	END;	
	
	EXPORT Layout_Header__Key_Addr_Hist := RECORD
		LayoutIDs;
		RECORDOF(Header__Key_Addr_Hist)- date_first_seen;
		unsigned date_first_seen;
		STRING25 v_city_name;
		STRING2 st;
		string4 zip4;
		string2 StateCode;
		string3 county; 
		string10 geo_lat; 
		string11 geo_long; 
		string7 geo_blk; 
		string1 geo_match; 
		String12 Geo_Link;
		string4 err_stat;
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.header_correct_record_id;
	END;


	SHARED USPIS_HotList__key_addr_search_zip := USPIS_HotList.key_addr_search_zip;
	EXPORT Layout_USPIS_HotList__key_addr_search_zip := RECORD
		LayoutIDs;
		STRING Archive_Date;
		RECORDOF(USPIS_HotList__key_addr_search_zip);
		STRING3 src;
		dpmtype;
	END;



	SHARED UtilFile__Key_Address := UtilFile.Key_Address;
	EXPORT Layout_UtilFile__Key_Address := RECORD
		LayoutIDs;
		STRING Archive_Date;
		RECORDOF(UtilFile__Key_Address);
		STRING2 src;
		dpmtype;
	END;

	SHARED UtilFile__Key_DID := UtilFile.Key_DID;
	EXPORT Layout_UtilFile__Key_DID := RECORD
		LayoutIDs;
		STRING Archive_Date;
		RECORDOF(UtilFile__Key_DID);
		STRING2 src;
		dpmtype;
	END;

	SHARED Corp2__Kfetch2_LinkIDs_Corp := Corp2.Key_LinkIDs.Corp.kfetch2;
	EXPORT Layout_Corp2__Kfetch_LinkIDs_Corp := RECORD
		LayoutIDs;
		STRING Archive_Date;
		RECORDOF(Corp2__Kfetch2_LinkIDs_Corp);
		STRING2 src;
		dpmtype;
	END;


	SHARED UtilFile__Kfetch2_LinkIds := UtilFile.Key_LinkIds.Kfetch2;
	EXPORT Layout_UtilFile__Kfetch2_LinkIds := RECORD
		LayoutIDs;
		RECORDOF(UtilFile__Kfetch2_LinkIds);
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
	END;
	
	SHARED RiskWise__key_CityStZip := RiskWise.Key_CityStZip;
	EXPORT Layout_RiskWise__key_CityStZip := RECORD
		LayoutIDs;
		RECORDOF(RiskWise__key_CityStZip);
		STRING3 src;
		STRING Archive_Date;
		dpmtype;
	END;

	// --------------------[ UCC ]--------------------
	// Key Linkids Layout
	SHARED UCC__Key_LinkIds_key := UCCV2.Key_LinkIds.kFetch2;
	EXPORT Layout_UCC__Key_LinkIds_key := RECORD
		LayoutIDs;
		RECORDOF(UCC__Key_LinkIds_key);
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
	END;

	// RMSID Main Layout
	SHARED UCC__Key_RMSID_Main := UCCV2.Key_rmsid_main();
	EXPORT Layout_UCC__Key_RMSID_Main := RECORD
		LayoutIDs;
		RECORDOF(UCC__Key_RMSID_Main);
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
	END;

	// RMSID Party Layout
	SHARED UCC__Key_RMSID_Party := UCCV2.Key_Rmsid_Party();
	EXPORT Layout_UCC__Key_RMSID_Party := RECORD
		LayoutIDs;
		RECORDOF(UCC__Key_RMSID_Party);
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
	END;

	// --------------------[ Person ]--------------------

	// NOTE: some keys for Person are defined above already.
	SHARED Death_MasterV2__key_ssn_ssa := Death_Master.key_ssn_ssa(Options.IsFCRA);
	EXPORT Layout_Death_MasterV2__key_ssn_ssa := RECORD
		LayoutIDs;
		RECORDOF(Death_MasterV2__key_ssn_ssa);  // contains "src"
		STRING Archive_Date;
		dpmtype;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.Death_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.Death_correct_record_id;
	END;
	
	SHARED Doxie__Key_Death_MasterV2_SSA_DID := IF(Options.IsFCRA, Doxie.key_death_masterV2_ssa_DID_fcra, Doxie.Key_Death_MasterV2_SSA_DID);

	EXPORT Layout_Doxie__Key_Death_MasterV2_SSA_DID := RECORD
		LayoutIDs;
		RECORDOF(Doxie__Key_Death_MasterV2_SSA_DID);  // contains "src"
		STRING Archive_Date;
		dpmtype;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.Death_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.Death_correct_record_id;
		STRING DOB8Padded;
	END;

	SHARED DriversV2__Key_DL_DID := DriversV2.Key_DL_DID;
	EXPORT Layout_DriversV2__Key_DL_DID := RECORD
		LayoutIDs;
		RECORDOF(DriversV2__Key_DL_DID)-dt_first_seen;
		unsigned dt_first_seen;
		STRING2 src;
		STRING Archive_Date;
		STRING DOBPadded;
		dpmtype;
	END;

	SHARED DriversV2__Key_DL_Number := DriversV2.Key_DL_Number;
	EXPORT Layout_DriversV2__Key_DL_Number := RECORD
		LayoutIDs;
		RECORDOF(DriversV2__Key_DL_Number)-dt_first_seen;
		unsigned dt_first_seen;
		STRING2 src;
		STRING Archive_Date;
		STRING DOBPadded;
		dpmtype;
	END;
	
	SHARED Certegy__Key_Certegy_DID := Certegy.key_certegy_did;
	EXPORT Layout_Certegy__Key_Certegy_DID := RECORD
		LayoutIDs;
		RECORDOF(Certegy__Key_Certegy_DID);
		STRING2 source_code;
		STRING Archive_Date;
		dpmtype;
	END;
	
	SHARED Doxie__Key_Header_Address := dx_header.key_header_address(itype); // not Doxie.Key_Address;
	EXPORT Layout_Doxie__Key_Header_Address := RECORD
		LayoutAddressGeneric;
		RECORDOF(Doxie__Key_Header_Address)-dt_first_seen;  // contains "src"
		unsigned dt_first_seen;
		STRING Archive_Date;
		dpmtype;
	END;

	
// --------------------[ Relatives ]--------------------
	EXPORT Layout_Relatives__Key_Relatives_V3 := RECORD
		LayoutIDs;
		Relationship.layout_GetRelationship.interfaceOutputNeutral;
		UNSIGNED1 CoSourceCount;
		UNSIGNED1 CoSourceSum;
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
	END;
	
	SHARED BBB2__kfetch_BBB_LinkIds := BBB2.Key_BBB_LinkIds.Kfetch2;
	EXPORT Layout_BBB2__kfetch_BBB_LinkIds := RECORD
		LayoutIDs;
		RECORDOF(BBB2__kfetch_BBB_LinkIds);
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
	END;	
	
	SHARED BBB2__kfetch_BBB_Non_Member_LinkIds :=  BBB2.Key_BBB_Non_Member_LinkIds.Kfetch2;
	EXPORT Layout_BBB2__kfetch_BBB_Non_Member_LinkIds := RECORD
		LayoutIDs;
		RECORDOF(BBB2__kfetch_BBB_Non_Member_LinkIds);
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
	END;

	SHARED BusReg__kfetch_busreg_company_linkids :=  BusReg.key_busreg_company_linkids.Kfetch2;
	EXPORT Layout_BusReg__kfetch_busreg_company_linkids := RECORD
		LayoutIDs;
		RECORDOF(BusReg__kfetch_busreg_company_linkids);
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
	END;
	
		SHARED CalBus__kfetch_Calbus_LinkIDS := CalBus.Key_Calbus_LinkIDS.Kfetch2;
	EXPORT Layout_CalBus__kfetch_Calbus_LinkIDS := RECORD
		LayoutIDs;
		RECORDOF(CalBus__kfetch_Calbus_LinkIDS);
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
	END;
	
		SHARED Cortera__kfetch_LinkID := dx_Cortera.Key_LinkIds.Kfetch2;
	EXPORT Layout_Cortera__kfetch_LinkID := RECORD
		LayoutIDs;
		RECORDOF(Cortera__kfetch_LinkID);
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
	END;
	
		SHARED DCAV2__kfetch_LinkIds := DCAV2.Key_LinkIds.Kfetch2;
	EXPORT Layout_DCAV2__kfetch_LinkIds := RECORD
		LayoutIDs;
		RECORDOF(DCAV2__kfetch_LinkIds);
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
	END;

	SHARED EBR__kfetch_5600_Demographic_Data_linkids := EBR.Key_5600_Demographic_Data_linkids.Kfetch2;
	EXPORT Layout_EBR_kfetch_5600_Demographic_Data_linkids := RECORD
		LayoutIDs;
		RECORDOF(EBR__kfetch_5600_Demographic_Data_linkids);
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
	END;
	
	SHARED FBNv2__kfetch_LinkIds := FBNv2.Key_LinkIds.Kfetch2;
	EXPORT Layout_FBNv2__kfetch_LinkIds := RECORD
		LayoutIDs;
		RECORDOF(FBNv2__kfetch_LinkIds);
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
	END;

	SHARED GovData__kfetch_IRS_NonProfit_linkIDs := GovData.key_IRS_NonProfit_linkIDs.Kfetch2;
	EXPORT Layout_GovData__kfetch_IRS_NonProfit_linkIDs := RECORD
		LayoutIDs;
		RECORDOF(GovData__kfetch_IRS_NonProfit_linkIDs);
		STRING2 src;
		INTEGER8 Reported_Earnings;
		STRING Archive_Date;
		dpmtype;
	END;

	SHARED IRS5500__kfetch_LinkIDs := IRS5500.Key_LinkIDs.Kfetch2;
	EXPORT Layout_IRS5500__kfetch_LinkIDs := RECORD
		LayoutIDs;
		RECORDOF(IRS5500__kfetch_LinkIDs);
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
	END;

	SHARED OSHAIR__kfetch_OSHAIR_LinkIds := dx_OSHAIR.Key_LinkIds.Kfetch2;
	EXPORT Layout_OSHAIR__kfetch_OSHAIR_LinkIds := RECORD
		LayoutIDs;
		RECORDOF(OSHAIR__kfetch_OSHAIR_LinkIds);
		STRING2 src;
		STRING Archive_Date;
		STRING1 inspection_type_code;
		dpmtype;
	END;

	SHARED SAM__kfetch_linkID := SAM.key_linkID.Kfetch2;
	EXPORT Layout_SAM__kfetch_linkID := RECORD
		LayoutIDs;
		RECORDOF(SAM__kfetch_linkID);
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
	END;

	SHARED YellowPages__kfetch_yellowpages_linkids := YellowPages.key_yellowpages_linkids.Kfetch2;
	EXPORT Layout_YellowPages__kfetch_yellowpages_linkids := RECORD
		LayoutIDs;
		RECORDOF(YellowPages__kfetch_yellowpages_linkids);
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
	END;
	
	SHARED Infutor_NARB__kfetch_LinkIds := dx_Infutor_NARB.Key_Linkids.Kfetch;//no kfetch2
	EXPORT Layout_Infutor_NARB__kfetch_LinkIds := RECORD
		LayoutIDs;
		RECORDOF(Infutor_NARB__kfetch_LinkIds);
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
	END;
	
	SHARED Equifax_Business_Data__kfetch_LinkIDs := dx_Equifax_Business_Data.Key_LinkIDs.Kfetch;//no kfetch2
	EXPORT Layout_Equifax_Business__Data_kfetch_LinkIDs := RECORD
		LayoutIDs;
		RECORDOF(Equifax_Business_Data__kfetch_LinkIDs);
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
	END;
	
	SHARED BIPV2_Build__kfetch_contact_linkids := BIPV2_Build.key_contact_linkids.Kfetch;//no kfetch2
	EXPORT Layout_BIPV2_Build__kfetch_contact_linkids := RECORD
		LayoutIDs;
		RECORDOF(BIPV2_Build__kfetch_contact_linkids);
		STRING2 src;
		STRING Archive_Date;
		String JobTitle; 
		String Status;
		dpmtype;
	END;

	SHARED layout_clean182_fips := RECORD
		string2 st; //needed for property marketing from BH
	END;
	
	EXPORT Layout_BIPV2_Build__kfetch_contact_linkids_slim := RECORD
		LayoutIDs;
		unsigned6 ultid;
		unsigned6 orgid;
		unsigned6 seleid;
		unsigned6 proxid;
		unsigned6 powid;
		unsigned6 empid;
		unsigned6 dotid;
		string2 source;
		unsigned4 dt_first_seen_contact;
		unsigned4 dt_last_seen_contact;	
		unsigned4 dt_first_seen;
		unsigned4 dt_last_seen;
		unsigned4 dt_vendor_first_reported;
		unsigned4 dt_vendor_last_reported;
		unsigned6 contact_did;
		layout_clean182_fips company_address; //needed for property marketing from BH
		STRING2 src;
		STRING Archive_Date;
		// String JobTitle; 
		// String Status;
		dpmtype;
	END;
	
	// --------------------[ BIP Best ]--------------------	
	EXPORT Layout_BIPV2_Best__Key_LinkIds := RECORD
		LayoutIDs;
		RECORDOF(BIPv2.IdAppendRoxie(DATASET([], BIPV2.IdAppendLayouts.AppendInput)).withBest());
		dpmtype;
		STRING Archive_Date;
		STRING2 src;
	END;

	// --------------------[ Phone ]--------------------

	SHARED Gong__Key_History_DID := dx_Gong.key_history_did(iType);
	EXPORT Layout_Gong__Key_History_DID := RECORD
		LayoutAddressGeneric;
		RECORDOF(Gong__Key_History_DID); // contains "src"
		STRING3 Listing_Type;
		STRING Archive_Date;
		dpmtype;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.gong_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.gong_correct_record_id;
	END;	
	
	SHARED Gong__Key_History_Address := dx_Gong.key_history_address(iType);
	EXPORT Layout_Gong__Key_History_Address := RECORD
		LayoutAddressGeneric;
		RECORDOF(Gong__Key_History_Address); // contains "src"
		STRING3 Listing_Type;
		STRING Archive_Date;
		dpmtype;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.gong_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.gong_correct_record_id;
	END;	
	
	SHARED Gong__Key_History_Phone := dx_Gong.key_history_phone(iType);
	EXPORT Layout_Gong__Key_History_Phone := RECORD
		LayoutAddressGeneric;
		RECORDOF(Gong__Key_History_Phone); // contains "src"
		STRING3 Listing_Type;
		STRING Archive_Date;
		dpmtype;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.gong_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.gong_correct_record_id;
	END;	

	SHARED Gong__Key_History_LinkIds := dx_Gong.Key_History_LinkIds.kFetch2;
	EXPORT Layout_Gong__Key_History_LinkIds := RECORD
		LayoutAddressGeneric;
		RECORDOF(Gong__Key_History_LinkIds);
		STRING3 Listing_Type;
		STRING Archive_Date;
		STRING2 src;
		dpmtype;
	END;

	SHARED Targus__Key_Targus_Phone := IF( Options.isFCRA, Targus.Key_Targus_FCRA_Phone, Targus.Key_Targus_Phone );
	EXPORT Layout_Targus__Key_Targus_Phone := RECORD
		LayoutAddressGeneric;
		RECORDOF(Targus__Key_Targus_Phone)-state-dt_first_seen;
		unsigned dt_first_seen;
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
	END;	
	
	 
	SHARED InfutorCID__Key_Infutor_Phone := IF( Options.isFCRA, InfutorCID.Key_Infutor_Phone_FCRA, InfutorCID.Key_Infutor_Phone );
	EXPORT Layout_InfutorCID__Key_Infutor_Phone := RECORD
		LayoutAddressGeneric;
		RECORDOF(InfutorCID__Key_Infutor_Phone);
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.infutor_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.infutor_correct_record_id;
	END;	

	SHARED PhonesPlus_v2_Keys_Iverification_Phone := Phonesplus_v2.Keys_Iverification().phone.qa;
	EXPORT Layout_Key_Iverification__Keys_Iverification_phone := RECORD
		LayoutPhoneGeneric;
		RECORDOF(PhonesPlus_v2_Keys_Iverification_Phone)-phone;
		string10 Phone_Iver;
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
	END;

	SHARED PhonesPlus_v2_Keys_Iverification_Did_Phone := Phonesplus_v2.Keys_Iverification().did_phone.qa;
	EXPORT Layout_Key_Iverification__Keys_Iverification_Did_Phone := RECORD
		LayoutPhoneGeneric;
		RECORDOF(PhonesPlus_v2_Keys_Iverification_Did_Phone)-phone;
		string10 Phone_Iver;
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
	END;

	SHARED CellPhone__Key_Neustar_Phone := CellPhone.key_neustar_phone;
	EXPORT Layout_Key_CellPhone__Key_Neustar_Phone := RECORD
		LayoutPhoneGeneric;
		RECORDOF(CellPhone__Key_Neustar_Phone);
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
	END;
	
	SHARED PhonesPlus_v2_Key_Source_Level_Did := dx_PhonesPlus.Key_Source_Level_DID;
	SHARED PhonesPlus_v2_Key_Source_Level_Phone := dx_PhonesPlus.Key_Source_Level_Phone;
	EXPORT Layout_PhonesPlus_v2_Key_Source_Level_Temp := RECORD
		LayoutPhoneGeneric;
		RECORDOF(PhonesPlus_v2_Key_Source_Level_Did);
		RECORDOF(PhonesPlus_v2_Key_Source_Level_Phone);
		STRING Archive_Date;
	END;
	
	SHARED PhonesPlus_v2_Key_Source_Level_Payload := dx_PhonesPlus.Key_Source_Level_Payload;
	EXPORT Layout_PhonesPlus_v2_Key_Source_Level_Payload := RECORD
		LayoutPhoneGeneric;
		RECORDOF(PhonesPlus_v2_Key_Source_Level_Payload)-datefirstseen;
		unsigned datefirstseen;
		dpmtype;
		STRING2 Src;
		STRING Archive_Date;
		STRING DOBPadded;
	END;	
	
	SHARED dx_PhonesInfo_Key_Phones_Type := dx_PhonesInfo.Key_Phones_Type;
	EXPORT Layout_dx_PhonesInfo_Key_Phones_Type := RECORD
		LayoutPhoneGeneric;
		RECORDOF(dx_PhonesInfo_Key_Phones_Type);
		dpmtype;
		STRING2 Src;
		STRING Archive_Date;
	END;	
	
	SHARED dx_PhonesInfo_Key_Phones_Transaction := dx_PhonesInfo.Key_Phones_Transaction;
	EXPORT Layout_dx_PhonesInfo_Key_Phones_Transaction := RECORD
		LayoutPhoneGeneric;
		RECORDOF(dx_PhonesInfo_Key_Phones_Transaction);
		dpmtype;
		STRING2 Src;
		STRING Archive_Date;
	END;	
	
		//====================[Education]============================
	SHARED American_student_list__key_DID := IF( Options.isFCRA, American_student_list.key_DID_FCRA, American_student_list.key_DID);
	EXPORT Layout_American_student_list__key_DID := RECORD
		LayoutIDs;
		RECORDOF(American_student_list__key_DID); // contains "src"
		dpmtype;
		STRING Archive_Date;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.student_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.student_correct_RECORD_ID;
	END;	
	
	SHARED AlloyMedia_student_list__Key_DID := IF( Options.isFCRA, AlloyMedia_student_list.Key_DID_FCRA, AlloyMedia_student_list.Key_DID);	
	EXPORT Layout_AlloyMedia_student_list__Key_DID := RECORD
		LayoutIDs;
		RECORDOF(AlloyMedia_student_list__key_DID); // contains "src"
		STRING Archive_Date;
		dpmtype;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.student_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.student_correct_RECORD_ID;
	END;
//====================[SummaryEntity]=============================

	SHARED Risk_Indicators__Correlation_Risk__key_addr_dob_summary := Risk_Indicators.Correlation_Risk.key_addr_dob_summary;
	EXPORT Layout_Risk_Indicators__Correlation_Risk__key_addr_dob_summary_Denorm := RECORD
		LayoutIDs;
		RECORDOF(Risk_Indicators__Correlation_Risk__key_addr_dob_summary); // Once Normalized, it contains src
		dpmtype;
		STRING Archive_Date;
		STRING DOBPadded;
	END;
	EXPORT Layout_Risk_Indicators__Correlation_Risk__key_addr_dob_summary := RECORD
		LayoutIDs;
		RECORDOF(Risk_Indicators__Correlation_Risk__key_addr_dob_summary)-summary;
		RECORDOF(Risk_Indicators__Correlation_Risk__key_addr_dob_summary.summary); // it contains src
		dpmtype;
		STRING Archive_Date;
		STRING DOBPadded;
	END;



	SHARED Risk_Indicators__Correlation_Risk__key_addr_name_summary := Risk_Indicators.Correlation_Risk.key_addr_name_summary;
	EXPORT Layout_Risk_Indicators__Correlation_Risk__key_addr_name_summary_Denorm := RECORD
		LayoutIDs;
		RECORDOF(Risk_Indicators__Correlation_Risk__key_addr_name_summary); // Once Normalized, it contains src
		dpmtype;
		STRING Archive_Date;
	END;

	EXPORT Layout_Risk_Indicators__Correlation_Risk__key_addr_name_summary := RECORD
		LayoutIDs;
		RECORDOF(Risk_Indicators__Correlation_Risk__key_addr_name_summary)-summary;
		RECORDOF(Risk_Indicators__Correlation_Risk__key_addr_name_summary.summary); // it contains src
		dpmtype;
		STRING Archive_Date;
	END;

//SSN Summary

	SHARED Risk_Indicators__key_ssn_addr_summary := Risk_Indicators.Correlation_Risk.key_ssn_addr_summary;
	EXPORT Layout_ssn_addr_summary_key_records := RECORD
		LayoutIDs;
		RECORDOF(Risk_Indicators__key_ssn_addr_summary);
		dpmtype;
		STRING Archive_Date;
	END;
	
	EXPORT Layout_ssn_addr_summary_records := RECORD
		LayoutIDs;
		RECORDOF(Risk_Indicators__key_ssn_addr_summary)-summary;
		RECORDOF(Risk_Indicators__key_ssn_addr_summary.summary);
		dpmtype;
		STRING Archive_Date;
	END;
//
 SHARED Risk_Indicators__key_ssn_dob_summary := Risk_Indicators.Correlation_Risk.key_ssn_dob_summary;
	EXPORT Layout_ssn_dob_summary_key_records := RECORD
		LayoutIDs;
		RECORDOF(Risk_Indicators__key_ssn_dob_summary);
		dpmtype;
		STRING Archive_Date;
		STRING DOBPadded;
	END;
	
	EXPORT Layout_ssn_dob_summary_records := RECORD
		LayoutIDs;
		RECORDOF(Risk_Indicators__key_ssn_dob_summary)-summary;
		RECORDOF(Risk_Indicators__key_ssn_dob_summary.summary);
		dpmtype;
		STRING Archive_Date;
		STRING DOBPadded;
	END;
//
 SHARED Risk_Indicators__key_ssn_name_summary := Risk_Indicators.Correlation_Risk.key_ssn_name_summary;
	EXPORT Layout_ssn_name_summary_key_records := RECORD
		LayoutIDs;
		RECORDOF(Risk_Indicators__key_ssn_name_summary);
		dpmtype;
		STRING Archive_Date;
	END;
	
	EXPORT Layout_ssn_name_summary_records := RECORD
		LayoutIDs;
		RECORDOF(Risk_Indicators__key_ssn_name_summary)-summary;
		RECORDOF(Risk_Indicators__key_ssn_name_summary.summary);
		dpmtype;
		STRING Archive_Date;
	END;
//
 SHARED Risk_Indicators__key_ssn_phone_summary := Risk_Indicators.Correlation_Risk.key_ssn_phone_summary;
	EXPORT Layout_ssn_phone_summary_key_records := RECORD
		LayoutIDs;
		RECORDOF(Risk_Indicators__key_ssn_phone_summary);
		dpmtype;
		STRING Archive_Date;
	END;
	
	EXPORT Layout_ssn_phone_summary_records := RECORD
		LayoutIDs;
		RECORDOF(Risk_Indicators__key_ssn_phone_summary)-summary;
		RECORDOF(Risk_Indicators__key_ssn_phone_summary.summary);
		dpmtype;
		STRING Archive_Date;
	END;

//====================[Surname]============================
	SHARED dx_CFPB__key_Census_Surnames:= IF( Options.isFCRA, dx_ConsumerFinancialProtectionBureau.key_census_surnames(TRUE), dx_ConsumerFinancialProtectionBureau.key_census_surnames(False));
	EXPORT Layout_dx_CFPB_key_Census_Surnames := RECORD
		LayoutIDs;
		RECORDOF(dx_CFPB__key_Census_Surnames); // contains "src"
		STRING Archive_Date;		
		dpmtype;
		STRING3 src;
	END;	
	
	//====================[Household]============================
	SHARED dx_Header__key_did_hhid:=dx_Header.key_did_hhid;
	EXPORT Layout_dx_Header__key_did_hhid := RECORD
		LayoutIDs;
		RECORDOF(dx_Header__key_did_hhid);
		STRING Archive_Date;		
		dpmtype;
		STRING3 src;
	END;
	
	//hhid_did
	SHARED dx_Header__key_hhid_did:=dx_Header.key_hhid_did;
	EXPORT Layout_dx_Header__key_hhid_did := RECORD
		LayoutIDs;
		RECORDOF(dx_Header__key_hhid_did);
		STRING Archive_Date;		
		dpmtype;
		STRING3 src;
	END;
	
	
		
// --------------------[ Property - Consumer and Business]--------------------	

//to help with memory limit errors in roxie we are removing fields that are not used. 
	SHARED PropertyV2_Key_Assessor_Fid_Records := LN_PropertyV2.key_assessor_fid(Options.isFCRA);
	EXPORT Layout_PropertyV2_Key_Assessor_Fid_Records := RECORD
		LayoutAddressGeneric;
		PropertyV2_Key_Assessor_Fid_Records.ln_fares_id;
		PropertyV2_Key_Assessor_Fid_Records.proc_date;
		PropertyV2_Key_Assessor_Fid_Records.vendor_source_flag;
		PropertyV2_Key_Assessor_Fid_Records.mailing_city_state_zip;
		PropertyV2_Key_Assessor_Fid_Records.property_full_street_address;
		PropertyV2_Key_Assessor_Fid_Records.property_city_state_zip;
		PropertyV2_Key_Assessor_Fid_Records.standardized_land_use_code;
		PropertyV2_Key_Assessor_Fid_Records.recording_date;
		PropertyV2_Key_Assessor_Fid_Records.sale_date;
		PropertyV2_Key_Assessor_Fid_Records.sales_price;
		PropertyV2_Key_Assessor_Fid_Records.document_type;
		PropertyV2_Key_Assessor_Fid_Records.mortgage_loan_amount;
		PropertyV2_Key_Assessor_Fid_Records.mortgage_loan_type_code;
		PropertyV2_Key_Assessor_Fid_Records.prior_recording_date;
		PropertyV2_Key_Assessor_Fid_Records.prior_sales_price;
		PropertyV2_Key_Assessor_Fid_Records.assessed_total_value;
		PropertyV2_Key_Assessor_Fid_Records.assessed_value_year;
		PropertyV2_Key_Assessor_Fid_Records.market_total_value;
		PropertyV2_Key_Assessor_Fid_Records.market_value_year;
		PropertyV2_Key_Assessor_Fid_Records.tax_year;
		PropertyV2_Key_Assessor_Fid_Records.land_square_footage;
		PropertyV2_Key_Assessor_Fid_Records.lot_size;
		PropertyV2_Key_Assessor_Fid_Records.building_area;
		PropertyV2_Key_Assessor_Fid_Records.year_built;
		PropertyV2_Key_Assessor_Fid_Records.effective_year_built;
		PropertyV2_Key_Assessor_Fid_Records.no_of_buildings;
		PropertyV2_Key_Assessor_Fid_Records.no_of_stories;
		PropertyV2_Key_Assessor_Fid_Records.no_of_units;
		PropertyV2_Key_Assessor_Fid_Records.no_of_rooms;
		PropertyV2_Key_Assessor_Fid_Records.no_of_bedrooms;
		PropertyV2_Key_Assessor_Fid_Records.no_of_baths;
		PropertyV2_Key_Assessor_Fid_Records.no_of_partial_baths;
		PropertyV2_Key_Assessor_Fid_Records.garage_type_code;
		PropertyV2_Key_Assessor_Fid_Records.parking_no_of_cars;
		PropertyV2_Key_Assessor_Fid_Records.style_code;
		PropertyV2_Key_Assessor_Fid_Records.tape_cut_date;
		PropertyV2_Key_Assessor_Fid_Records.certification_date;
		BOOLEAN owner_occupied;
		BOOLEAN fireplace_indicator;
		BOOLEAN ln_mobile_home_indicator;
		BOOLEAN ln_condo_indicator;
		BOOLEAN current_record;
		BOOLEAN ln_property_tax_exemption;		
		UNSIGNED date_first_seen;
		dpmtype;
		STRING Archive_Date;
		STRING2 src;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.prop_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.prop_correct_lnfare;
	END;
	
//to help with memory limit errors in roxie we are removing fields that are not used. 	
	SHARED PropertyV2_Key_Deed_Fid_Records := LN_PropertyV2.key_deed_fid(Options.isFCRA);
	EXPORT Layout_PropertyV2_Key_Deed_Fid_Records := RECORD
		LayoutAddressGeneric;
		PropertyV2_Key_Deed_Fid_Records.ln_fares_id;
		PropertyV2_Key_Deed_Fid_Records.process_date;
		PropertyV2_Key_Deed_Fid_Records.buyer_or_borrower_ind;
		PropertyV2_Key_Deed_Fid_Records.name1;
		PropertyV2_Key_Deed_Fid_Records.name2;
		PropertyV2_Key_Deed_Fid_Records.mailing_csz;
		PropertyV2_Key_Deed_Fid_Records.property_full_street_address;
		PropertyV2_Key_Deed_Fid_Records.property_address_citystatezip;
		PropertyV2_Key_Deed_Fid_Records.contract_date;
		PropertyV2_Key_Deed_Fid_Records.recording_date;
		PropertyV2_Key_Deed_Fid_Records.sales_price;
		PropertyV2_Key_Deed_Fid_Records.document_type_code;
		PropertyV2_Key_Deed_Fid_Records.land_lot_size;
		PropertyV2_Key_Deed_Fid_Records.vendor_source_flag;
		BOOLEAN current_record;
		BOOLEAN timeshare_flag;
		BOOLEAN addl_name_flag;
		UNSIGNED Date_First_Seen;	
		dpmtype;
		STRING Archive_Date;
		STRING2 src;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.prop_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.prop_correct_lnfare;
	END;
	
//to help with memory limit errors in roxie we are removing fields that are not used. 	
	SHARED PropertyV2_Key_Property_Did_Records := LN_PropertyV2.key_Property_did(Options.isFCRA);
	EXPORT Layout_PropertyV2_Data_Temp := RECORD
		LayoutAddressGeneric;
		PropertyV2_Key_Property_Did_Records.s_did;
		PropertyV2_Key_Property_Did_Records.source_code_2;
		string1 source_code_1;
		PropertyV2_Key_Property_Did_Records.ln_fares_id;
		PropertyV2_Key_Property_Did_Records.prim_range;
		PropertyV2_Key_Property_Did_Records.predir;
		PropertyV2_Key_Property_Did_Records.prim_name;
		PropertyV2_Key_Property_Did_Records.suffix;
		PropertyV2_Key_Property_Did_Records.postdir;
		PropertyV2_Key_Property_Did_Records.sec_range;
		PropertyV2_Key_Property_Did_Records.st;
		PropertyV2_Key_Property_Did_Records.zip;
		STRING Archive_Date;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.prop_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.prop_correct_lnfare;
		Boolean IsAddress;
	END;		
	
//to help with memory limit errors in roxie we are removing fields that are not used. 	
	SHARED PropertyV2_Key_Search_Fid_Records := LN_PropertyV2.key_search_fid(Options.isFCRA);
	EXPORT Layout_PropertyV2_Key_Search_Fid_Records := RECORD
		LayoutAddressGeneric;
		PropertyV2_Key_Search_Fid_Records.source_code_2;
		PropertyV2_Key_Search_Fid_Records.source_code_1;
		PropertyV2_Key_Search_Fid_Records.source_code;
		PropertyV2_Key_Search_Fid_Records.ln_fares_id;
		PropertyV2_Key_Search_Fid_Records.did;
		PropertyV2_Key_Search_Fid_Records.prim_range;
		PropertyV2_Key_Search_Fid_Records.predir;
		PropertyV2_Key_Search_Fid_Records.prim_name;
		PropertyV2_Key_Search_Fid_Records.suffix;
		PropertyV2_Key_Search_Fid_Records.postdir;
		PropertyV2_Key_Search_Fid_Records.unit_desig;
		PropertyV2_Key_Search_Fid_Records.sec_range;
		PropertyV2_Key_Search_Fid_Records.p_city_name;
		PropertyV2_Key_Search_Fid_Records.v_city_name;
		PropertyV2_Key_Search_Fid_Records.st;
		PropertyV2_Key_Search_Fid_Records.zip;
		PropertyV2_Key_Search_Fid_Records.ultid;
		PropertyV2_Key_Search_Fid_Records.orgid;
		PropertyV2_Key_Search_Fid_Records.seleid;
		PropertyV2_Key_Search_Fid_Records.proxid;
		PropertyV2_Key_Search_Fid_Records.powid;
		PropertyV2_Key_Search_Fid_Records.fname;
		PropertyV2_Key_Search_Fid_Records.lname;
		PropertyV2_Key_Search_Fid_Records.persistent_record_id;//overrides & suppressions
		PropertyV2_Key_Search_Fid_Records.vendor_source_flag;
		BOOLEAN PartyIsBuyerOrOwner;
		BOOLEAN PartyIsBorrower;
		BOOLEAN PartyIsSeller;
		BOOLEAN PartyIsCareOf;
		BOOLEAN OwnerAddress;
		BOOLEAN SellerAddress;
		BOOLEAN PropertyAddress;
		BOOLEAN BorrowerAddress;
		dpmtype;
		STRING2 src;
		STRING Archive_Date;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.prop_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.prop_correct_lnfare;
	END;
	
	SHARED AVM_V2_Key_AVM_Address_Records := IF( Options.isFCRA, AVM_V2.Key_AVM_Address_FCRA, AVM_V2.Key_AVM_Address );
	
	EXPORT Layout_AVM_V2_Key_AVM_Address_Records := RECORD
		LayoutAddressGeneric;
		RECORDOF(AVM_V2_Key_AVM_Address_Records);
		BOOLEAN IsCurrent;
		dpmtype;
		STRING3 src;
		STRING Archive_Date;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.avm_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.avm_correct_RECORD_ID;
	END;
	
	EXPORT Layout_AVM_V2_Key_AVM_Address_Norm_Records := RECORD
		Layout_AVM_V2_Key_AVM_Address_Records - history OR RECORDOF(AVM_V2_Key_AVM_Address_Records.history);
	END;

	SHARED AVM_V2_Key_AVM_Medians_Records := IF( Options.isFCRA, AVM_V2.Key_AVM_Medians_fcra, AVM_V2.Key_AVM_Medians );
	
	EXPORT Layout_AVM_V2_Key_AVM_Medians_Records := RECORD
		LayoutAddressGeneric;
		RECORDOF(AVM_V2_Key_AVM_Medians_Records);
		BOOLEAN IsCurrent;
		dpmtype;
		STRING3 src;
		STRING Archive_Date;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.avm_medians_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.avm_medians_correct_record_id;

	END;
	
	EXPORT Layout_AVM_V2_Key_AVM_Medians_Norm_Records := RECORD
		Layout_AVM_V2_Key_AVM_Medians_Records - history OR RECORDOF(AVM_V2_Key_AVM_Medians_Records.history);
	END;
	// --------------------[ LienJudgement ]--------------------	

	SHARED LienJudgement_DID := IF(Options.IsFCRA, liensv2.key_liens_did_FCRA, liensv2.key_liens_DID);
	EXPORT Layout_LienJudgement_DID := RECORD
		LayoutIDs;
		RECORDOF(LienJudgement_DID);
		dpmtype;
		STRING2 src;
		STRING Archive_Date;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.lien_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.lien_correct_tmsid_rmsid;
	END;
	
	SHARED LiensV2_key_liens_main_ID_Records := IF( Options.isFCRA, LiensV2.key_liens_main_ID_FCRA, LiensV2.key_liens_main_ID	 );
	EXPORT Layout_LiensV2_key_liens_main_ID_Records := RECORD
		LayoutIDs;
		RECORDOF(LiensV2_key_liens_main_ID_Records);
		dpmtype;
    STRING100 FilingStatusDescription;
		STRING Archive_Date;
		STRING2 src;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.lien_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.lien_correct_tmsid_rmsid;
	END;

	SHARED LiensV2_Key_Liens_Party_ID_Records := IF( Options.isFCRA, LiensV2.Key_Liens_Party_ID_FCRA, LiensV2.Key_Liens_Party_ID	 );
	EXPORT Layout_LiensV2_Key_Liens_Party_ID_Records := RECORD
		LayoutIDs;
		RECORDOF(LiensV2_Key_Liens_Party_ID_Records);
		dpmtype;
		STRING2 src;
		STRING100 DebtorName;
		STRING100 PlaintiffName; 
		STRING100 SubjectsName;
		STRING Archive_Date;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.lien_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.lien_correct_tmsid_rmsid
	END;

	SHARED LiensV2__Key_party_Linkids_Records := LiensV2.Key_LinkIds.kFetch2;	
	EXPORT Layout_Key_party_Linkids_Records := RECORD
		LayoutIDs;
		RECORDOF(LiensV2__Key_party_Linkids_Records);
		dpmtype;
		STRING2 src;
		STRING Archive_Date;
		//need to be here because did and linkid are transformed into linkid layout 
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.lien_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.lien_correct_tmsid_rmsid;
	END;	
	
	SHARED FLAccidents_Ecrash__key_EcrashV2_accnbr := FLAccidents_Ecrash.key_EcrashV2_accnbr;	
	EXPORT Layout_FLAccidents_Ecrash__key_EcrashV2_accnbr := RECORD
		LayoutIDs;
		RECORDOF(FLAccidents_Ecrash__key_EcrashV2_accnbr);
		dpmtype;
		STRING2 src;
		STRING Archive_Date;
	END;	
	
	SHARED FLAccidents_Ecrash__Key_ECrash4 := FLAccidents_Ecrash.Key_ECrash4;	
	EXPORT Layout_FLAccidents_Ecrash__Key_ECrash4 := RECORD
		LayoutIDs;
		RECORDOF(FLAccidents_Ecrash__Key_ECrash4);
		dpmtype;
		STRING2 src;
		STRING Archive_Date;
	END;	
	
	SHARED FLAccidents_Ecrash__Key_EcrashV2_did	 := FLAccidents_Ecrash.Key_EcrashV2_did	;	
	EXPORT Layout_FLAccidents_Ecrash__Key_EcrashV2_did := RECORD
		LayoutIDs;
		RECORDOF(FLAccidents_Ecrash__Key_EcrashV2_did);
		dpmtype;
		STRING2 src;
		STRING Archive_Date;
	END;
	
	// --------------------[ WatchDog - Best Person ]--------------------	
	//watchdog data is NOT archivable. Forcibly remove all dates so they can't accidentally be used
	SHARED Best_Person__Key_Watchdog	 := dx_BestRecords.layout_best;	
	EXPORT Layout_Best_Person__Key_Watchdog := RECORD
		LayoutIDs;
		RECORDOF(Best_Person__Key_Watchdog) - run_date - addr_dt_first_seen - addr_dt_last_seen rec;
		dpmtype;
		STRING2 src;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides;
		STRING Archive_Date;//not archivable but we need this here for vault
		STRING DOBPadded;
	END;
	
	//watchdog data is NOT archivable. Forcibly remove all dates so they can't accidentally be used
	SHARED Best_Person__Key_Watchdog_FCRA_nonEN	 := Watchdog.Key_Watchdog_FCRA_nonEN;	
	EXPORT Layout_Best_Person__Key_Watchdog_FCRA_nonEN := RECORD
		LayoutIDs;
		RECORDOF(Best_Person__Key_Watchdog_FCRA_nonEN) - run_date - addr_dt_first_seen - addr_dt_last_seen;
		dpmtype;
		STRING3 src;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides;
		STRING Archive_Date;//not archivable but we need this here for vault
		STRING DOBPadded;
	END;
	
	//watchdog data is NOT archivable. Forcibly remove all dates so they can't accidentally be used
	SHARED Best_Person__Key_Watchdog_FCRA_nonEQ	 := Watchdog.Key_Watchdog_FCRA_nonEQ;	
	EXPORT Layout_Best_Person__Key_Watchdog_FCRA_nonEQ := RECORD
		LayoutIDs;
		RECORDOF(Best_Person__Key_Watchdog_FCRA_nonEQ) - run_date - addr_dt_first_seen - addr_dt_last_seen;
		dpmtype;
		STRING3 src;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides;
		STRING Archive_Date;//not archivable but we need this here for vault
		STRING DOBPadded;
	END;
	
	SHARED dx_ConsumerFinancialProtectionBureau__Key_BLKGRP := IF( Options.isFCRA, dx_ConsumerFinancialProtectionBureau.Key_BLKGRP(TRUE), dx_ConsumerFinancialProtectionBureau.Key_BLKGRP(FALSE) );
	EXPORT Layout_dx_ConsumerFinancialProtectionBureau__Key_BLKGRP := RECORD
		LayoutIDs;
		RECORDOF(dx_ConsumerFinancialProtectionBureau__Key_BLKGRP);
		dpmtype;
		STRING Archive_Date;
		STRING3 src;
	END;		
	
	SHARED dx_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18 := IF( Options.isFCRA, dx_ConsumerFinancialProtectionBureau.key_BLKGRP_attr_over18(TRUE), dx_ConsumerFinancialProtectionBureau.key_BLKGRP_attr_over18(FALSE) );
	EXPORT Layout_dx_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18 := RECORD
		LayoutIDs;
		RECORDOF(dx_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18);
		dpmtype;
		STRING Archive_Date;
		STRING3 src;
	END;	
	
    // --------------------[ RiskTable ]--------------------	
    SHARED name_dob_summary__key := Risk_Indicators.Correlation_Risk.key_name_dob_summary;
    EXPORT Layout_name_dob_summary_key_records := RECORD
		LayoutIDs;
		RECORDOF(name_dob_summary__key);
		dpmtype;
		STRING2 src;
		STRING Archive_Date;
		STRING DOBPadded;
	END;
  
	EXPORT Layout_name_dob_summary_key_norm_records := RECORD
		Layout_name_dob_summary_key_records - summary OR RECORDOF(Layout_name_dob_summary_key_records.summary);
	END;
  
    SHARED phone_addr_header_summary__key := Risk_Indicators.Correlation_Risk.key_phone_addr_header_summary;
    EXPORT Layout_phone_addr_header_summary_key_records := RECORD
		LayoutIDs;
		RECORDOF(phone_addr_header_summary__key);
		dpmtype;
        STRING2 src;
		STRING Archive_Date;
	END;
  
	EXPORT Layout_phone_addr_header_summary_key_norm_records := RECORD
		Layout_phone_addr_header_summary_key_records - summary OR RECORDOF(Layout_phone_addr_header_summary_key_records.summary);
	END;
	
      SHARED phone_addr_summary__key := Risk_Indicators.Correlation_Risk.key_phone_addr_summary;
    EXPORT Layout_phone_addr_summary_key_records := RECORD
		LayoutIDs;
		RECORDOF(phone_addr_summary__key);
		dpmtype;
        STRING2 src;
		STRING Archive_Date;
	END;
  
	EXPORT Layout_phone_addr_summary_key_norm_records := RECORD
		Layout_phone_addr_summary_key_records - summary OR RECORDOF(Layout_phone_addr_summary_key_records.summary);
	END;
  
    SHARED phone_lname_summary__key := Risk_Indicators.Correlation_Risk.key_phone_lname_summary;
    EXPORT Layout_phone_lname_summary_key_records := RECORD
		LayoutIDs;
		RECORDOF(phone_lname_summary__key);
		dpmtype;
        STRING2 src;
		STRING Archive_Date;
	END;
  
	EXPORT Layout_phone_lname_summary_key_norm_records := RECORD
		Layout_phone_lname_summary_key_records - summary OR RECORDOF(Layout_phone_lname_summary_key_records.summary);
	END;
  
    SHARED phone_lname_header_summary__key := Risk_Indicators.Correlation_Risk.key_phone_lname_header_summary;
    EXPORT Layout_phone_lname_header_summary_key_records := RECORD
		LayoutIDs;
		RECORDOF(phone_lname_header_summary__key);
		dpmtype;
        STRING2 src;
		STRING Archive_Date;
	END;
  
	EXPORT Layout_phone_lname_header_summary_key_norm_records := RECORD
		Layout_phone_lname_header_summary_key_records - summary OR RECORDOF(Layout_phone_lname_header_summary_key_records.summary);
	END;
  
    
    SHARED phone_dob_summary__key := Risk_Indicators.Correlation_Risk.key_phone_dob_summary;
    EXPORT Layout_phone_dob_summary_key_records := RECORD
		LayoutIDs;
		RECORDOF(phone_dob_summary__key);
		dpmtype;
        STRING2 src;
		STRING Archive_Date;
		STRING DOBPadded;
	END;
  
	EXPORT Layout_phone_dob_summary_key_norm_records := RECORD
		Layout_phone_dob_summary_key_records - summary OR RECORDOF(Layout_phone_dob_summary_key_records.summary);
	END;
  
	//nonFCRA only
	SHARED eMerges__Key_HuntFish_Did := 	 IF( Options.isFCRA, eMerges.Key_HuntFish_Did(TRUE), eMerges.Key_HuntFish_Did(FALSE) );
	EXPORT Layout_eMerges__Key_HuntFish_Did := RECORD
		LayoutIDs;
		RECORDOF(eMerges__Key_HuntFish_Did);
	END;		
	

	SHARED Thrive__Key___Did_QA := 	 IF( Options.isFCRA, thrive.keys().Did_fcra.qa, thrive.keys().did.qa );
	EXPORT Layout_Thrive__Key___Did_QA := RECORD
		LayoutIDs;
		Thrive__Key___Did_QA.did;
		Thrive__Key___Did_QA.persistent_record_id;
		Thrive__Key___Did_QA.dt_first_seen;
		Thrive__Key___Did_QA.dt_last_seen;
		Thrive__Key___Did_QA.dt_vendor_first_reported;
		Thrive__Key___Did_QA.dt_vendor_last_reported;
		Thrive__Key___Did_QA.employer;
		Thrive__Key___Did_QA.pay_frequency;
		Thrive__Key___Did_QA.income;
		Thrive__Key___Did_QA.src;
		DATA100 DPMBitmap;
		STRING Archive_Date;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.thrive_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.thrive_correct_record_id;
	END;	
	
		//This is a very wide key and we only use a handful of fields
	SHARED eMerges__Key_HuntFish_Rid :=   IF( Options.isFCRA, eMerges.Key_HuntFish_Rid(TRUE), eMerges.Key_HuntFish_Rid(FALSE) );
	EXPORT Layout_eMerges__Key_HuntFish_Rid := RECORD
		LayoutIDs;
		eMerges__Key_HuntFish_Rid.rid;
		eMerges__Key_HuntFish_Rid.persistent_record_id;
		eMerges__Key_HuntFish_Rid.process_date;
		eMerges__Key_HuntFish_Rid.resident;
		eMerges__Key_HuntFish_Rid.hunt;
		eMerges__Key_HuntFish_Rid.fish;
		eMerges__Key_HuntFish_Rid.did_out;
		eMerges__Key_HuntFish_Rid.datelicense;
		eMerges__Key_HuntFish_Rid.homestate;
		eMerges__Key_HuntFish_Rid.source_state;
		integer did;
		BOOLEAN IsResident;
		BOOLEAN IsHunting;
		BOOLEAN IsFishing;
		dpmtype;
		STRING3 src;
		STRING Archive_Date;
	END;		
		
		
	SHARED EBR__Key_0010_Header_linkids := EBR.Key_0010_Header_linkids.kfetch2;
	EXPORT Layout_EBR__Key_0010_Header_linkids := RECORD
		LayoutIDs;
		RECORDOF(EBR__Key_0010_Header_linkids);
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
	END;	
	
	SHARED EBR__Key_2015_Trade_Payment_Totals_FILE_NUMBER := EBR.Key_2015_Trade_Payment_Totals_FILE_NUMBER;
	EXPORT Layout_EBR__Key_2015_Trade_Payment_Totals_FILE_NUMBER := RECORD
		LayoutIDs;
		RECORDOF(EBR__Key_2015_Trade_Payment_Totals_FILE_NUMBER);
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
	END;	
	
	SHARED Experian_CRDB__Key_LinkIDs := Experian_CRDB.Key_LinkIDs.kfetch;
	EXPORT Layout_Experian_CRDB__Key_LinkIDs := RECORD
		LayoutIDs;
		RECORDOF(Experian_CRDB__Key_LinkIDs);
		STRING2 src;
		STRING Archive_Date;
		dpmtype;
	END;	


	SHARED dx_DataBridge__Key_LinkIds := dx_DataBridge.Key_LinkIds.kfetch;
	EXPORT Layout_dx_DataBridge__Key_LinkIds := RECORD
		LayoutIDs;
		RECORDOF(dx_DataBridge__Key_LinkIds);
		STRING Archive_Date;
		dpmtype;
	END;	
	

		
	SHARED eMerges__key_ccw_did :=  IF( Options.isFCRA, eMerges.key_ccw_did(TRUE), eMerges.key_ccw_did(FALSE) );
	EXPORT Layout_eMerges__key_ccw_did := RECORD
		LayoutIDs;
		RECORDOF(eMerges__key_ccw_did);
	END;		

			//This is a very wide key and we only use a handful of fields
	SHARED eMerges__key_ccw_rid :=   IF( Options.isFCRA, eMerges.key_ccw_rid(TRUE), eMerges.key_ccw_rid(FALSE) );
	EXPORT Layout_eMerges__key_ccw_rid := RECORD
		LayoutIDs;
		eMerges__key_ccw_rid.rid;
		eMerges__key_ccw_rid.persistent_record_id;
		eMerges__key_ccw_rid.process_date;
		eMerges__key_ccw_rid.ccwpermnum;
		eMerges__key_ccw_rid.ccwpermtype;
		eMerges__key_ccw_rid.ccwexpdate;
		eMerges__key_ccw_rid.ccwregdate;
		eMerges__key_ccw_rid.did_out;
		integer did;
		dpmtype;
		STRING3 src;
		STRING Archive_Date;
	END;		
	
	SHARED fraudpoint3__Key_DID :=  fraudpoint3.Key_DID;
	EXPORT Layout_fraudpoint3__Key_DID := RECORD
		LayoutIDs;
		RECORDOF(fraudpoint3__Key_DID);
		dpmtype;
		STRING3 src;
		STRING DOBPadded;
	END;		
	
	//inquiries fcra
	SHARED Inquiry_AccLogs__Key_FCRA_SSN := Inquiry_AccLogs.Key_FCRA_SSN;
	EXPORT Layout_Inquiry_AccLogs__Key_FCRA_SSN := RECORD
		LayoutIDs;
		STRING Archive_Date;
		STRING DOBPadded;
		STRING DateOfInquiry;
		RECORDOF(Inquiry_AccLogs__Key_FCRA_SSN);
		STRING2 src;
		dpmtype;
	END;	

	SHARED Inquiry_AccLogs__Key_FCRA_Phone := Inquiry_AccLogs.Key_FCRA_Phone;
	EXPORT Layout_Inquiry_AccLogs__Key_FCRA_Phone := RECORD
		LayoutPhoneGeneric;
		STRING Archive_Date;
		STRING DOBPadded;
		STRING DateOfInquiry;
		RECORDOF(Inquiry_AccLogs__Key_FCRA_Phone);
		STRING2 src;
		dpmtype;
	END;	
	
		SHARED Inquiry_AccLogs__Key_FCRA_Address := Inquiry_AccLogs.Key_FCRA_Address;
	EXPORT Layout_Inquiry_AccLogs__Key_FCRA_Address := RECORD
		LayoutAddressGeneric;
		STRING Archive_Date;
		STRING DOBPadded;
		STRING DateOfInquiry;
		RECORDOF(Inquiry_AccLogs__Key_FCRA_Address);
		STRING2 src;
		dpmtype;
	END;	
	
		SHARED Inquiry_AccLogs__Key_FCRA_DID := Inquiry_AccLogs.Key_FCRA_DID;
	EXPORT Layout_Inquiry_AccLogs__Key_FCRA_DID := RECORD
		LayoutIDs;
		STRING Archive_Date;
		STRING DOBPadded;
		STRING DateOfInquiry;
		RECORDOF(Inquiry_AccLogs__Key_FCRA_DID);
		STRING2 src;
		dpmtype;
	END;	

	//inquiries nonfcra
	SHARED Inquiry_AccLogs__Inquiry_Table_Address := Inquiry_AccLogs.Key_Inquiry_Address;
	EXPORT Layout_Inquiry_AccLogs__Inquiry_Table_Address := RECORD
		LayoutAddressGeneric;
		STRING Archive_Date;
		STRING DOBPadded;
		STRING DateOfInquiry;
		RECORDOF(Inquiry_AccLogs__Inquiry_Table_Address);
		STRING2 src;
		dpmtype;
		BOOLEAN IsUpdateRecord;//flagging what records are update vs full
		BOOLEAN IsDeltaBaseRecord;//flagging what records are DeltaBse
	END;	
	
	SHARED Inquiry_AccLogs__Inquiry_Table_DID := Inquiry_AccLogs.Key_Inquiry_DID;
	EXPORT Layout_Inquiry_AccLogs__Inquiry_Table_DID := RECORD
		LayoutIDs;
		STRING Archive_Date;
		STRING DOBPadded;
		STRING DateOfInquiry;
		RECORDOF(Inquiry_AccLogs__Inquiry_Table_DID);
		STRING2 src;
		dpmtype;
		BOOLEAN IsUpdateRecord;//flagging what records are update vs full
		BOOLEAN IsDeltaBaseRecord;//flagging what records are DeltaBse
	END;	
	
SHARED Inquiry_AccLogs__Inquiry_Table_Email := Inquiry_AccLogs.Key_Inquiry_Email;
	EXPORT Layout_Inquiry_AccLogs__Inquiry_Table_Email := RECORD
		LayoutIDs;
		STRING Archive_Date;
		STRING DOBPadded;
		STRING DateOfInquiry;
		RECORDOF(Inquiry_AccLogs__Inquiry_Table_Email);
		STRING2 src;
		dpmtype;
		BOOLEAN IsUpdateRecord;//flagging what records are update vs full
		BOOLEAN IsDeltaBaseRecord;//flagging what records are DeltaBse
	END;	

	SHARED Inquiry_AccLogs__Inquiry_Table_FEIN := Inquiry_AccLogs.Key_Inquiry_FEIN;
	EXPORT Layout_Inquiry_AccLogs__Inquiry_Table_FEIN := RECORD
		LayoutIDs;
		STRING Archive_Date;
		STRING DOBPadded;
		STRING DateOfInquiry;
		RECORDOF(Inquiry_AccLogs__Inquiry_Table_FEIN);
		STRING2 src;
		dpmtype;
		BOOLEAN IsUpdateRecord;//flagging what records are update vs full
		BOOLEAN IsDeltaBaseRecord;//flagging what records are DeltaBse
	END;	

	SHARED Inquiry_AccLogs__Inquiry_Table_LinkIds := Inquiry_AccLogs.Key_Inquiry_LinkIds.kfetch2;
	EXPORT Layout_Inquiry_AccLogs__Inquiry_Table_LinkIds := RECORD
		LayoutIDs;
		STRING Archive_Date;
		STRING DOBPadded;
		STRING DateOfInquiry;
		RECORDOF(Inquiry_AccLogs__Inquiry_Table_LinkIds);
		STRING2 src;
		dpmtype;
		BOOLEAN IsUpdateRecord;//flagging what records are update vs full
		BOOLEAN IsDeltaBaseRecord;//flagging what records are DeltaBse
	END;	

	SHARED Inquiry_AccLogs__Inquiry_Table_Phone := Inquiry_AccLogs.Key_Inquiry_Phone;
	EXPORT Layout_Inquiry_AccLogs__Inquiry_Table_Phone := RECORD
		LayoutPhoneGeneric;
		STRING Archive_Date;
		STRING DOBPadded;
		STRING DateOfInquiry;
		RECORDOF(Inquiry_AccLogs__Inquiry_Table_Phone);
		STRING2 src;
		dpmtype;
		BOOLEAN IsUpdateRecord;//flagging what records are update vs full
		BOOLEAN IsDeltaBaseRecord;//flagging what records are DeltaBse
	END;	

	SHARED Inquiry_AccLogs__Inquiry_Table_SSN := Inquiry_AccLogs.Key_Inquiry_SSN;
	EXPORT Layout_Inquiry_AccLogs__Inquiry_Table_SSN := RECORD
		LayoutIDs;
		STRING Archive_Date;
		STRING DOBPadded;
		STRING DateOfInquiry;
		RECORDOF(Inquiry_AccLogs__Inquiry_Table_SSN);
		STRING2 src;
		dpmtype;
		BOOLEAN IsUpdateRecord;//flagging what records are update vs full
		BOOLEAN IsDeltaBaseRecord;//flagging what records are DeltaBse
	END;	
	
	EXPORT Layout_ConsumerStatementFlags_temp := record
		LayoutIDs;
		recordof(Risk_Indicators.Layouts.tmp_Consumer_Statements);
	end;
	
	//this is only used in FCRA current mode. not archivable data
	EXPORT Layout_ConsumerStatementFlags := RECORD
		LayoutIDs;
		risk_indicators.Layout_ConsumerFlags;
		recordof(Risk_Indicators.Layouts.tmp_Consumer_Statements);
		STRING DateFirstSeen;
		STRING3 src;
		dpmtype;
		STRING Archive_Date;
	END;	

SHARED SexOffender__Key_SexOffender_DID :=  IF( Options.isFCRA, SexOffender.Key_SexOffender_DID(TRUE), SexOffender.Key_SexOffender_DID(FALSE) );
	EXPORT Layout_SexOffender__Key_SexOffender_DID := RECORD
		LayoutIDs;
		RECORDOF(SexOffender__Key_SexOffender_DID);
				PublicRecords_KEL.ECL_Functions.Layout_Overrides.SexOffender_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.SexOffender_correct_record_id;
	END;		

			//This is a very wide key and we only use a handful of fields
	SHARED SexOffender__Key_SexOffender_SPK :=   IF( Options.isFCRA, SexOffender.Key_SexOffender_SPK(TRUE), SexOffender.Key_SexOffender_SPK(FALSE) );
	EXPORT Layout_SexOffender__Key_SexOffender_SPK := RECORD
		LayoutIDs;
		RECORDOF(SexOffender__Key_SexOffender_SPK);
		dpmtype;
		STRING2 src;
		STRING Archive_Date;
				PublicRecords_KEL.ECL_Functions.Layout_Overrides.SexOffender_correct_ffid;
		PublicRecords_KEL.ECL_Functions.Layout_Overrides.SexOffender_correct_record_id;
	END;		
		
SHARED Header__key_ADL_segmentation :=  Header.key_ADL_segmentation;
	EXPORT Layout_Header__key_ADL_segmentation := RECORD
		LayoutIDs;
		RECORDOF(Header__key_ADL_segmentation);
		dpmtype;
		STRING2 src;
		STRING Archive_Date;
	END;			
	
SHARED Address_Search_Roxie_layout := BIPV2_Build.key_high_risk_industries.Address_Search_Roxie;
SHARED Key_Code_layout := BIPV2_Build.key_high_risk_industries.Key_Code;
SHARED Phone_Search_layout := BIPV2_Build.key_high_risk_industries.Phone_Search;	
	
	EXPORT highrisktemp := record
		unsigned6 locid;
		unsigned6 seleid;
		string10 company_phone;
	end;
	EXPORT Layout_BIPV2_Build__key_high_risk_industries_phone := RECORD
			LayoutIDs;
			RECORDOF(Phone_Search_layout)-seleid;
			RECORDOF(Key_Code_layout);
			dpmtype;
			STRING3 SRC;	
			STRING Archive_Date;
			string6 SIC_Code;
			string6 NAICS_Code;
	END;			
	
	EXPORT Layout_BIPV2_Build__key_high_risk_industries_addr := RECORD
			LayoutIDs;
			RECORDOF(BIPV2_Build.key_high_risk_industries.AddrSearchLayout);
			RECORDOF(Address_Search_Roxie_layout)-seleid;
			RECORDOF(Key_Code_layout);
			dpmtype;
			STRING3 SRC;	
			STRING Archive_Date;
			string6 SIC_Code;
			string6 NAICS_Code;
	END;
	EXPORT Layout_DX_Property__Key_Foreclosures_FID_With_Did := RECORD
		LayoutIDs;
		dpmtype;
		INTEGER did;
		string2 src;
		STRING5 Zip5;
		STRING4 Zip4;
		STRING Archive_Date;
		recordof(dx_Property.Key_Foreclosures_FID);
	END;
	
	// ===================[ Composite Layout ]===================
	EXPORT Layout_FDC := RECORD
		LayoutIDs_Inputs;
//datasets in mini FDC
		DATASET(Layout_BIPV2_Build__kfetch_contact_linkids) Dataset_BIPV2_Build__kfetch_contact_linkids;
		DATASET(Layout_BIPV2_Build__kfetch_contact_linkids_slim) Dataset_BIPV2_Build__kfetch_contact_linkids_slim;		
		DATASET(Layout_Best_Person__Key_Watchdog) Dataset_Best_Person__Key_Watchdog;
		DATASET(Layout_Best_Person__Key_Watchdog_FCRA_nonEN) Dataset_Best_Person__Key_Watchdog_FCRA_nonEN;
		DATASET(Layout_Best_Person__Key_Watchdog_FCRA_nonEQ) Dataset_Best_Person__Key_Watchdog_FCRA_nonEQ;
		DATASET(Layout_dx_Header__key_did_hhid) Dataset_dx_Header__key_did_hhid;
		DATASET(Layout_dx_Header__key_hhid_did) Dataset_dx_Header__key_hhid_did;	
		DATASET(Layout_Relatives__Key_Relatives_V3) Dataset_Relatives__Key_Relatives_V3;
		DATASET(Layout_Header__key_ADL_segmentation) Dataset_Header__key_ADL_segmentation;		
		DATASET(Layout_Doxie__Key_Header) Dataset_Doxie__Key_Header;		
		DATASET(Layout_Header_Quick__Key_Did) Dataset_Header_Quick__Key_Did;	
		DATASET(Layout_Header__Key_Addr_Hist) Dataset_Header__Key_Addr_Hist;	
		dataset(Layout_ConsumerStatementFlags) Dataset_ConsumerStatementFlags;


//These are now in alphabetical order by PACKAGE NOT KEY.  please keep this in this order, if you are unsure where to put a key please check DOPS

		//American Student
		DATASET(Layout_American_student_list__key_DID) Dataset_American_student_list__key_DID;

		//alloy
		DATASET(Layout_AlloyMedia_student_list__Key_DID) Dataset_AlloyMedia_student_list__Key_DID;

		// ADVO
		DATASET(Layout_ADVO__Key_Addr1_History) Dataset_ADVO__Key_Addr1_History;		
		DATASET(Layout_USPIS_HotList__key_addr_search_zip) Dataset_USPIS_HotList__key_addr_search_zip;		

		//avm
		DATASET(Layout_AVM_V2_Key_AVM_Address_Norm_Records) Dataset_AVM_V2__Key_AVM_Address;
		DATASET(Layout_AVM_V2_Key_AVM_Medians_Norm_Records) Dataset_AVM_V2__Key_AVM_Medians;

		// Bankruptcy
		DATASET(Layout_BankruptcyV3__key_bankruptcyv3_search) Dataset_Bankruptcy_Files__Key_Search;		
		DATASET(Layout_BankruptcyV3__key_bankruptcyV3_linkids_Key) Dataset_Bankruptcy_Files__Linkids_Key_Search;

		//bbb
		DATASET(Layout_BBB2__kfetch_BBB_LinkIds) Dataset_BBB2__kfetch_BBB_LinkIds;
		DATASET(Layout_BBB2__kfetch_BBB_Non_Member_LinkIds) Dataset_BBB2__kfetch_BBB_Non_Member_LinkIds;

		//bip
		DATASET(Layout_BIPV2__Key_BH_Linking_kfetch2) Dataset_BIPV2__Key_BH_Linking_kfetch2;
		DATASET(Layout_BIPV2_Best__Key_LinkIds) Dataset_BIPV2_Best__Key_LinkIds;
		DATASET(Layout_BIPV2_Build__key_high_risk_industries_addr) Dataset_BIPV2_Build__key_high_risk_industries_addr;
		DATASET(Layout_BIPV2_Build__key_high_risk_industries_phone) Dataset_BIPV2_Build__key_high_risk_industries_phone;

		//busreg
		DATASET(Layout_BusReg__kfetch_busreg_company_linkids) Dataset_BusReg__kfetch_busreg_company_linkids;

		//calbus
		DATASET(Layout_CalBus__kfetch_Calbus_LinkIDS) Dataset_CalBus__kfetch_Calbus_LinkIDS;

		//certegy
		DATASET(Layout_Certegy__Key_Certegy_DID) Dataset_Certegy__Key_Certegy_DID;

		//cfbp
		DATASET(Layout_dx_CFPB_key_Census_Surnames) Dataset_dx_CFPB_key_Census_Surnames;
		DATASET(Layout_dx_ConsumerFinancialProtectionBureau__Key_BLKGRP) Dataset_dx_ConsumerFinancialProtectionBureau__Key_BLKGRP;
		DATASET(Layout_dx_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18) Dataset_dx_ConsumerFinancialProtectionBureau__key_BLKGRP_attr_over18;

		//citystatezip
		DATASET(Layout_RiskWise__key_CityStZip) Dataset_RiskWise__key_CityStZip;

		//cortera
		DATASET(Layout_Cortera__kfetch_LinkID) Dataset_Cortera__kfetch_LinkID;

		//corteratradeline
		DATASET(Layout_Cortera_Tradeline__Key_LinkIds) Dataset_Cortera_Tradeline__Key_LinkIds;

		//coprs
		DATASET(Layout_Corp2__Kfetch_LinkIDs_Corp) Dataset_Corp2__Kfetch_LinkIDs_Corp;

		//crdb
		DATASET(Layout_Experian_CRDB__Key_LinkIDs) Dataset_Experian_CRDB__Key_LinkIDs;	
			
		//databridge
		DATASET(Layout_dx_DataBridge__Key_LinkIds) Dataset_dx_DataBridge__Key_LinkIds;		

		//dcav2
		DATASET(Layout_DCAV2__kfetch_LinkIds) Dataset_DCAV2__kfetch_LinkIds;

		// DeathMaster
		DATASET(Layout_Doxie__Key_Death_MasterV2_SSA_DID) Dataset_Doxie__Key_Death_MasterV2_SSA_DID; 
		DATASET(Layout_Death_MasterV2__key_ssn_ssa) Dataset_Death_MasterV2__key_ssn_ssa; 

		//DLv2
		DATASET(Layout_DriversV2__Key_DL_DID) Dataset_DriversV2__Key_DL_DID; 
		DATASET(Layout_DriversV2__Key_DL_Number) Dataset_DriversV2__Key_DL_Number; 

		//DNM
		DATASET(Layout_DMA__Key_DNM_Name_Address) Dataset_DMA__Key_DNM_Name_Address;	

		//DOC
		DATASET(Layout_Doxie_Files__Key_Offenders) Dataset_Doxie_Files__Key_Offenders;		
		DATASET(Layout_Doxie_files__Key_Court_Offenses) Dataset_Doxie_files__Key_Court_Offenses;		
		DATASET(Layout_Doxie_Files__Key_Offenses) Dataset_Doxie_Files__Key_Offenses;		
		DATASET(Layout_Doxie_Files__Key_Offenders_Risk) Dataset_Doxie_Files__Key_Offenders_Risk;		
		DATASET(Layout_Doxie_Files__Key_Punishment) Dataset_Doxie_Files__Key_Punishment;		

		//ebr
		DATASET(Layout_EBR_kfetch_5600_Demographic_Data_linkids) Dataset_EBR_kfetch_5600_Demographic_Data_linkids;
		DATASET(Layout_EBR__Key_0010_Header_linkids) Dataset_EBR__Key_0010_Header_linkids;		
		DATASET(Layout_EBR__Key_2015_Trade_Payment_Totals_FILE_NUMBER) Dataset_EBR__Key_2015_Trade_Payment_Totals_FILE_NUMBER;	

		//ecrash
		DATASET(Layout_FLAccidents_Ecrash__key_EcrashV2_accnbr) Dataset_FLAccidents_Ecrash__key_EcrashV2_accnbr;
		DATASET(Layout_FLAccidents_Ecrash__Key_ECrash4) Dataset_FLAccidents_Ecrash__Key_ECrash4;

		// Email
		DATASET(Layout_DX_Email__Key_Email_Payload) Dataset_DX_Email__Key_Email_Payload;		
		DATASET(Layout_Email_Data__Key_Did_FCRA) Dataset_Email_Data__Key_Did_FCRA;			

		//emerges
		DATASET(Layout_eMerges__key_ccw_rid) Dataset_eMerges__key_ccw_rid;
		DATASET(Layout_eMerges__Key_HuntFish_Rid) Dataset_eMerges__Key_HuntFish_Rid;

		//eq business
		DATASET(Layout_Equifax_Business__Data_kfetch_LinkIDs) Dataset_Equifax_Business__Data_kfetch_LinkIDs;

		// FAA
		DATASET(Layout_FAA__key_aircraft_id) Dataset_FAA__Key_Aircraft_IDs;		
		DATASET(Layout_FAA__key_aircraft_linkids) Dataset_FAA__key_aircraft_linkids;

		//fbn
		DATASET(Layout_FBNv2__kfetch_LinkIds) Dataset_FBNv2__kfetch_LinkIds;

		// Foreclosure
		DATASET(Layout_DX_Property__Key_Foreclosures_FID_With_Did) Dataset_DX_Property__Key_Foreclosures_FID_With_Did;

		//Fraudpoint3
		DATASET(Layout_Fraudpoint3__Key_Address) Dataset_Fraudpoint3__Key_Address;		
		DATASET(Layout_Fraudpoint3__Key_SSN) Dataset_Fraudpoint3__Key_SSN;		
		DATASET(Layout_fraudpoint3__Key_DID) Dataset_fraudpoint3__Key_DID;
		DATASET(Layout_FraudPoint3_Key_Phone) Dataset_FraudPoint3__Key_Phone;

		//gong
		DATASET(Layout_Gong__Key_History_DID) Dataset_Gong__Key_History_DID;
		DATASET(Layout_Gong__Key_History_Address) Dataset_Gong__Key_History_Address;
		DATASET(Layout_Gong__Key_History_Phone) Dataset_Gong__Key_History_Phone;
		DATASET(Layout_Gong__Key_History_LinkIds) Dataset_Gong__Key_History_LinkIds;

		//govdata
		DATASET(Layout_GovData__kfetch_IRS_NonProfit_linkIDs) Dataset_GovData__kfetch_IRS_NonProfit_linkIDs;

		//liens
		DATASET(Layout_LiensV2_key_liens_main_ID_Records) Dataset_LiensV2_key_liens_main_ID_Records;
		DATASET(Layout_LiensV2_Key_Liens_Party_ID_Records) Dataset_LiensV2_Key_Liens_Party_ID_Records; 		
		DATASET(Layout_Key_party_Linkids_Records) Dataset_LiensV2__Key_party_Linkids_Records;	   

		//infutorcid
		DATASET(Layout_InfutorCID__Key_Infutor_Phone) Dataset_InfutorCID__Key_Phone;

		//infutornarb
		DATASET(Layout_Infutor_NARB__kfetch_LinkIds) Dataset_Layout_Infutor_NARB__kfetch_LinkIds;

		//irs
		DATASET(Layout_IRS5500__kfetch_LinkIDs) Dataset_IRS5500__kfetch_LinkIDs;

		//inquiries
		DATASET(Layout_Inquiry_AccLogs__Key_FCRA_Address) Dataset_Inquiry_AccLogs__Key_FCRA_Address;	
		DATASET(Layout_Inquiry_AccLogs__Key_FCRA_DID) Dataset_Inquiry_AccLogs__Key_FCRA_DID;		
		DATASET(Layout_Inquiry_AccLogs__Key_FCRA_Phone) Dataset_Inquiry_AccLogs__Key_FCRA_Phone;		
		DATASET(Layout_Inquiry_AccLogs__Key_FCRA_SSN) Dataset_Inquiry_AccLogs__Key_FCRA_SSN;		
		DATASET(Layout_Inquiry_AccLogs__Inquiry_Table_Address) Dataset_Inquiry_AccLogs__Inquiry_Table_Address;		
		DATASET(Layout_Inquiry_AccLogs__Inquiry_Table_DID) Dataset_Inquiry_AccLogs__Inquiry_Table_DID;		
		DATASET(Layout_Inquiry_AccLogs__Inquiry_Table_EMAIL) Dataset_Inquiry_AccLogs__Inquiry_Table_EMAIL;		
		DATASET(Layout_Inquiry_AccLogs__Inquiry_Table_FEIN) Dataset_Inquiry_AccLogs__Inquiry_Table_FEIN;		
		DATASET(Layout_Inquiry_AccLogs__Inquiry_Table_LinkIDs) Dataset_Inquiry_AccLogs__Inquiry_Table_LinkIDs;		
		DATASET(Layout_Inquiry_AccLogs__Inquiry_Table_Phone) Dataset_Inquiry_AccLogs__Inquiry_Table_Phone;		
		DATASET(Layout_Inquiry_AccLogs__Inquiry_Table_SSN) Dataset_Inquiry_AccLogs__Inquiry_Table_SSN;				

		//oshira
		DATASET(Layout_OSHAIR__kfetch_OSHAIR_LinkIds) Dataset_OSHAIR__kfetch_OSHAIR_LinkIds;

		//PersonHeader
		DATASET(Layout_Doxie__Key_Header_Address) Dataset_Doxie__Key_Header_Address; 

		// PhonesInfo
		DATASET(Layout_dx_PhonesInfo_Key_Phones_Type) Dataset_dx_PhonesInfo__Key_Phones_Type;
		DATASET(Layout_dx_PhonesInfo_Key_Phones_Transaction) Dataset_dx_PhonesInfo__Key_Phones_Transaction;
		
		//phonesplus
		DATASET(Layout_Key_Iverification__Keys_Iverification_Phone) Dataset_Key_Iverification__Keys_Iverification_Phone;
		DATASET(Layout_Key_Iverification__Keys_Iverification_Did_Phone) Dataset_Key_Iverification__Keys_Iverification_Did_Phone;
		DATASET(Layout_Key_CellPhone__Key_Neustar_Phone) Dataset_Key_CellPhone__Key_Neustar_Phone;
		DATASET(Layout_PhonesPlus_v2_Key_Source_Level_Payload) Dataset_PhonesPlus_v2__Key_Source_Level_Payload;
		
		// ProfessionalLicense
		DATASET(Layout_Prof_LicenseV2__Key_Proflic_Did) Dataset_Prof_LicenseV2__Key_Proflic_Did;		
		DATASET(Layout_Prof_License_Mari__Key_Did) Dataset_Prof_License_Mari__Key_Did;	
		// lnprop
		DATASET(Layout_PropertyV2_Key_Assessor_Fid_Records) Dataset_PropertyV2__Key_Assessor_Fid;
		DATASET(Layout_PropertyV2_Key_Deed_Fid_Records) Dataset_PropertyV2__Key_Deed_Fid_Fid;
		DATASET(Layout_PropertyV2_Key_Search_Fid_Records) Dataset_PropertyV2__Key_Search_Fid;

		//risktablekeys
		DATASET(Layout_Risk_Indicators__Correlation_Risk__key_addr_dob_summary) Dataset_Risk_Indicators__Correlation_Risk__key_addr_dob_summary;
		DATASET(Layout_Risk_Indicators__Correlation_Risk__key_addr_name_summary) Dataset_Risk_Indicators__Correlation_Risk__key_addr_name_summary;
		DATASET(Layout_ssn_addr_summary_records) Dataset_Risk_Indicators__Key_SSN_Addr_Summary;
		DATASET(Layout_ssn_dob_summary_records) Dataset_Risk_Indicators__Key_SSN_DOB_Summary;
		DATASET(Layout_ssn_name_summary_records) Dataset_Risk_Indicators__Key_SSN_Name_Summary;
		DATASET(Layout_ssn_phone_summary_records) Dataset_Risk_Indicators__Key_SSN_Phone_Summary;		
		DATASET(Layout_name_dob_summary_key_norm_records) Dataset_RiskTable__Key_Name_Dob_Summary;
		DATASET(Layout_phone_addr_header_summary_key_norm_records) Dataset_RiskTable__Key_Phone_Addr_Header_Summary;
		DATASET(Layout_phone_addr_summary_key_norm_records) Dataset_RiskTable__Key_Phone_Addr_Summary;
		DATASET(Layout_phone_lname_summary_key_norm_records) Dataset_RiskTable__Key_Phone_Lname_Summary;
		DATASET(Layout_phone_lname_header_summary_key_norm_records) Dataset_RiskTable__Key_Phone_Lname_Header_Summary;
		DATASET(Layout_phone_dob_summary_key_norm_records) Dataset_RiskTable__Key_Phone_Dob_Summary;		

		//sam
		DATASET(Layout_SAM__kfetch_linkID) Dataset_SAM__kfetch_linkID;

		//sexoffender
		dataset(Layout_SexOffender__Key_SexOffender_SPK) Dataset_SexOffender__Key_SexOffender_SPK;

		//targus
		DATASET(Layout_Targus__Key_Targus_Phone) Dataset_Targus__Key_Phone;

		//thrive
		DATASET(Layout_Thrive__Key___Did_QA) Dataset_Thrive__Key___Did_QA;

		//UCC
		DATASET(Layout_UCC__Key_LinkIds_key) Dataset_UCC__Key_LinkIds_key;
		DATASET(Layout_UCC__Key_RMSID_Main) Dataset_UCC__Key_RMSID_Main;
		DATASET(Layout_UCC__Key_RMSID_Party) Dataset_UCC__Key_RMSID_Party;

		//Utility
		DATASET(Layout_UtilFile__Key_Address) Dataset_UtilFile__Key_Address;		
		DATASET(Layout_UtilFile__Key_DID) Dataset_UtilFile__Key_DID;
		DATASET(Layout_UtilFile__Kfetch2_LinkIds) Dataset_UtilFile__Kfetch2_LinkIds;

		//vehicle
		DATASET(Layout_VehicleV2__Key_Vehicle_LinkID_Key) Dataset_VehicleV2__Key_Vehicle_LinkID_Key;
		DATASET(Layout_VehicleV2__Key_Vehicle_Party_Key) Dataset_VehicleV2__Key_Vehicle_Party_Key;
		DATASET(Layout_VehicleV2__Key_Vehicle_Main_Key) Dataset_VehicleV2__Key_Vehicle_Main_Key;

		// Watercraft
		DATASET(Layout_Watercraft__Key_Watercraft_SID) Dataset_Watercraft__Key_Watercraft_SID;	
		DATASET(Layout_Watercraft__Key_LinkIds) Dataset_Watercraft__Watercraft__Key_LinkIds;

		//yellow pages
		DATASET(Layout_YellowPages__kfetch_yellowpages_linkids) Dataset_YellowPages__kfetch_yellowpages_linkids;
			
END;
	
END;
