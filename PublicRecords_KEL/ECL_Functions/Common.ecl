IMPORT PublicRecords_KEL, Risk_Indicators;
 
// NOTE: These are meant to be turned on or off at compile time (NOT run-time)
// for the sake of optimizing joins for a particular product.
//
// 
EXPORT Common(PublicRecords_KEL.Interface_Options Options,
				PublicRecords_KEL.Join_Interface_Options JoinFlags) := MODULE

EXPORT DoFDCJoin_Doxie__Key_Header_ingest_date := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Doxie__Key_Header_ingest_date;

//IncludeMini
EXPORT DoFDCJoin_Doxie__Key_Header := JoinFlags.DoFDCJoin_Doxie__Key_Header;
	// Header_Quick.Key_Did_FCRA
	// dx_header.key_header
				
EXPORT DoFDCJoin_Quick_Header__key_wild_SSN := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Quick_Header__key_wild_SSN;

			
EXPORT DoFDCJoin_Dx_Header__key_wild_SSN := JoinFlags.DoFDCJoin_Dx_Header__key_wild_SSN;

			
EXPORT DoFDCJoin_Dx_Header__key_wild_phone := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Dx_Header__key_wild_phone;

			 
EXPORT DoFDCJoin_dx_Header__key_did_hhid := NOT Options.isFCRA AND NOT Options.TurnOffHouseHolds AND JoinFlags.DoFDCJoin_dx_Header__key_did_hhid;
	// dx_Header.key_did_hhid()
	// dx_Header.key_hhid_did()	
	
EXPORT DoFDCJoin_Relatives__Key_Relatives_v3 := NOT Options.isFCRA AND NOT Options.TurnOffRelatives AND JoinFlags.DoFDCJoin_Relatives__Key_Relatives_v3;
	// Relationship.proc_GetRelationshipNeutral - both marketing and nonmarketing same function

	
EXPORT DoFDCJoin_Best_Person__Key_Watchdog := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Best_Person__Key_Watchdog;

	
EXPORT DoFDCJoin_Best_Person__Key_Watchdog_FCRA := Options.isFCRA AND JoinFlags.DoFDCJoin_Best_Person__Key_Watchdog_FCRA;
	// Watchdog.Key_Watchdog_FCRA_nonEN
	// Watchdog.Key_Watchdog_FCRA_nonEQ		

EXPORT DoFDCJoin_Header__Key_Addr_Hist :=  JoinFlags.DoFDCJoin_Header__Key_Addr_Hist AND JoinFlags.DoFDCJoin_Doxie__Key_Header;//only work with header
	// dx_Header.key_addr_hist
	// AID_Build.Key_AID_Base

	
EXPORT DoFDCJoin_BIPV2_Build__kfetch_contact_linkids := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_BIPV2_Build__kfetch_contact_linkids;

//can't have slim contacts without full contacts
EXPORT DoFDCJoin_BIPV2_Build__kfetch_contact_linkids_slim := NOT Options.isFCRA AND (JoinFlags.DoFDCJoin_BIPV2_Build__kfetch_contact_linkids_slim and JoinFlags.DoFDCJoin_BIPV2_Build__kfetch_contact_linkids);//can't have slim contacts without contacts

		 
EXPORT DoFDCJoin_Header__key_ADL_segmentation := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Header__key_ADL_segmentation;

//end of mini section	
	
EXPORT DoFDCJoinfn_IndexedSearchForXLinkIDs	:= NOT Options.isFCRA AND JoinFlags.DoFDCJoinfn_IndexedSearchForXLinkIDs;
			
	// FCRA and nonFCRA versions exist, but old boca shell uses FCRA only.
EXPORT DoFDCJoin_Doxie_files__Key_Court_Offenses := Options.isFCRA AND JoinFlags.DoFDCJoin_Doxie_Files__Key_Offenders;


	// FCRA 	
EXPORT DoFDCJoin_Doxie_Files__Key_Offenses := Options.isFCRA AND JoinFlags.DoFDCJoin_Doxie_Files__Key_Offenders;


	// FCRA and nonFCRA versions		
EXPORT DoFDCJoin_Doxie_Files__Key_Offenders := JoinFlags.DoFDCJoin_Doxie_Files__Key_Offenders;


	// NonFCRA only
EXPORT DoFDCJoin_Doxie_Files__Key_Offenders_Risk	:= NOT Options.isFCRA  AND JoinFlags.DoFDCJoin_Doxie_Files__Key_Offenders_Risk;

			
EXPORT DoFDCJoin_Doxie_Files__Key_Punishment := NOT Options.isFCRA  AND JoinFlags.DoFDCJoin_Doxie_Files__Key_Offenders;


EXPORT DoFDCJoin_Bankruptcy_Files__Key_bankruptcy_did := JoinFlags.DoFDCJoin_Bankruptcy_Files__Key_bankruptcy_did;		
	// BankruptcyV3.key_bankruptcyV3_did
	// BankruptcyV3.key_bankruptcyv3_search_full_bip
	


EXPORT DoFDCJoin_Bankruptcy_Files__Bankruptcy__Linkid_Key_Search := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Bankruptcy_Files__Bankruptcy__Linkid_Key_Search;

//triggerd by turning on above bank keys
EXPORT DoFDCJoin_Bankruptcy_Files__Key_bankruptcy_WithdrawnStatus := (JoinFlags.DoFDCJoin_Bankruptcy_Files__Key_bankruptcy_did OR (NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Bankruptcy_Files__Bankruptcy__Linkid_Key_Search));		
			
EXPORT DoFDCJoin_Aircraft_Files__FAA__Aircraft := JoinFlags.DoFDCJoin_Aircraft_Files__FAA__Aircraft;	
	// FAA.key_aircraft_did	
	// FAA.key_aircraft_id
		
EXPORT DoFDCJoin_Aircraft_Files__FAA__Aircraft_linkids := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Aircraft_Files__FAA__Aircraft_linkids;

	
EXPORT DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_DID := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_DID;
	// VehicleV2.Key_Vehicle_DID

EXPORT DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_LinkID := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_LinkID;
	// VehicleV2.Key_Vehicle_DID
		
EXPORT DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_Main_Party := NOT Options.isFCRA AND (JoinFlags.DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_DID OR JoinFlags.DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_LinkID);
	// VehicleV2.Key_Vehicle_Party_Key
	// VehicleV2.Key_Vehicle_Main_Key


EXPORT DoFDCJoin_Watercraft_Files__Watercraft := JoinFlags.DoFDCJoin_Watercraft_Files__Watercraft;		
	// Watercraft.key_watercraft_did
	// Watercraft.key_watercraft_sid
		
EXPORT DoFDCJoin_Watercraft_Files__Watercraft_LinkId := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Watercraft_Files__Watercraft_LinkId;


	// Do JOINs for FCRA and nonFCRA
EXPORT DoFDCJoin_Prof_LicenseV2__Key_Proflic_Did := JoinFlags.DoFDCJoin_Prof_LicenseV2__Key_Proflic_Did;		


	// Do JOINs for FCRA and nonFCRA
EXPORT DoFDCJoin_Prof_License_Mari__Key_Did := JoinFlags.DoFDCJoin_Prof_License_Mari__Key_Did;			

//triggerd by turning on above proflic keys	
EXPORT DoFDCJoin_Prof_LicenseV2__Key_LicenseType_lookup := (JoinFlags.DoFDCJoin_Prof_LicenseV2__Key_Proflic_Did OR JoinFlags.DoFDCJoin_Prof_License_Mari__Key_Did);	

EXPORT DoFDCJoin_ADVO__Key_Addr1_History := JoinFlags.DoFDCJoin_ADVO__Key_Addr1_History;	


EXPORT DoFDCJoin_DMA__Key_DNM_Name_Address := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_DMA__Key_DNM_Name_Address;


EXPORT DoFDCJoin_Fraudpoint3__Key_Address := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Fraudpoint3__Key_Address;


EXPORT DoFDCJoin_Fraudpoint3__Key_SSN := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Fraudpoint3__Key_SSN;

		 
EXPORT DoFDCJoin_Fraudpoint3__Key_Phone := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Fraudpoint3__Key_Phone;


EXPORT DoFDCJoin_USPIS_HotList__key_addr_search_zip := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_USPIS_HotList__key_addr_search_zip;


EXPORT DoFDCJoin_UtilFile__Key_Address := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_UtilFile__Key_Address;


EXPORT DoFDCJoin_UtilFile__Key_DID := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_UtilFile__Key_DID;


EXPORT DoFDCJoin_Email_Data__Key_did := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Email_Data__Key_did;

		 
EXPORT DoFDCJoin_Email_Data__Key_Email_Address := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Email_Data__Key_Email_Address;

		 
//triggerd by turning on above email keys	
EXPORT DoFDCJoin_Email_Data__Key_Email_Payload := (JoinFlags.DoFDCJoin_Email_Data__Key_Email_Address OR JoinFlags.DoFDCJoin_Email_Data__Key_did);	
	

EXPORT DoFDCJoin_Email_Data__Key_Did_FCRA := Options.isFCRA AND JoinFlags.DoFDCJoin_Email_Data__Key_Did_FCRA;			
	

EXPORT DoFDCJoin_Doxie__Key_Death_MasterV2_SSA_DID := JoinFlags.DoFDCJoin_Doxie__Key_Death_MasterV2_SSA_DID;


EXPORT DoFDCJoin_DeathMaster__Key_SSN_SSA := JoinFlags.DoFDCJoin_DeathMaster__Key_SSN_SSA;


EXPORT DoFDCJoin_DriversV2__Key_DL_DID := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_DriversV2__Key_DL_DID;


EXPORT DoFDCJoin_DriversV2__Key_DL_Number := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_DriversV2__Key_DL_Number;


EXPORT DoFDCJoin_Certegy__Key_Certegy_DID := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Certegy__Key_Certegy_DID;

		
EXPORT DoFDCJoin_Doxie__Key_Header_Address := JoinFlags.DoFDCJoin_Doxie__Key_Header_Address;

					
EXPORT DoFDCJoin_American_student_list__key_DID := JoinFlags.DoFDCJoin_American_student_list__key_DID;

		 
EXPORT DoFDCJoin_AlloyMedia_student_list__key_DID := JoinFlags.DoFDCJoin_AlloyMedia_student_list__key_DID;

			
/*-----------------------AddressSummary-----------------------*/
EXPORT DoFDCJoin_Risk_Indicators__Correlation_Risk__key_addr_dob_summary := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_addr_dob_summary;

EXPORT DoFDCJoin_Risk_Indicators__Correlation_Risk__key_addr_name_summary := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_addr_name_summary;

EXPORT DoFDCJoin_Risk_Indicators__Correlation_Risk__key_ssn_addr_summary := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_ssn_addr_summary;

EXPORT DoFDCJoin_Risk_Indicators__Correlation_Risk__key_ssn_dob_summary := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_ssn_dob_summary;

EXPORT DoFDCJoin_Risk_Indicators__Correlation_Risk__key_ssn_name_summary := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_ssn_name_summary;

EXPORT DoFDCJoin_Risk_Indicators__Correlation_Risk__key_ssn_phone_summary := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_ssn_phone_summary;

EXPORT DoFDCJoin_Risk_Indicators__Correlation_Risk__key_name_dob_summary := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_name_dob_summary;

EXPORT DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_addr_header_summary := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_addr_header_summary;

EXPORT DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_addr_summary := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_addr_summary;

EXPORT DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_lname_summary := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_lname_summary;

EXPORT DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_lname_header_summary := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_lname_header_summary;

EXPORT DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_dob_summary := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_dob_summary;
		 

EXPORT DoFDCJoin_dx_CFPB__key_Census_Surnames := JoinFlags.DoFDCJoin_dx_CFPB__key_Census_Surnames;

EXPORT DoFDCJoin_dx_CFPB__key_BLKGRP := JoinFlags.DoFDCJoin_dx_CFPB__key_BLKGRP;

EXPORT DoFDCJoin_dx_CFPB__key_BLKGRP_over18 := JoinFlags.DoFDCJoin_dx_CFPB__key_BLKGRP_over18;
	
	 
		 
EXPORT DoFDCJoin_LiensV2_key_liens := JoinFlags.DoFDCJoin_LiensV2_key_liens;
	// liensv2.key_liens_DID
	// LiensV2.Key_Liens_Party_ID_FCRA

EXPORT DoFDCJoin_LiensV2_Key_party_Linkids_Records := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_LiensV2_Key_party_Linkids_Records;
	// LiensV2.Key_LinkIds.kFetch2

//triggered by turning on the above liens keys
EXPORT DoFDCJoin_LiensV2_Key_main_ID_Records := ((NOT Options.isFCRA AND JoinFlags.DoFDCJoin_LiensV2_Key_party_Linkids_Records) OR JoinFlags.DoFDCJoin_LiensV2_key_liens);
	// LiensV2_key_liens_main_ID_Records
			
EXPORT DoFDCJoin_Tradeline_Files__Tradeline__Key_LinkIds := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Tradeline_Files__Tradeline__Key_LinkIds;

		
EXPORT DoFDCJoin_Business_Files__Business__Key_BH_Linking_Ids_extra := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Business_Files__Business__Key_BH_Linking_Ids_extra;
EXPORT DoFDCJoin_Business_Files__Business__Key_BH_Linking_Ids := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Business_Files__Business__Key_BH_Linking_Ids;
	

EXPORT DoFDCJoin_Corp2__Key_LinkIDs_Corp := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Corp2__Key_LinkIDs_Corp;


EXPORT DoFDCJoin_UtilFile__Key_LinkIds := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_UtilFile__Key_LinkIds;

			
EXPORT DoFDCJoin_UCC_Files__Key_Linkids := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_UCC_Files__Key_Linkids;
	// UCCV2.Key_Rmsid_Party()
	// UCCV2.Key_LinkIds.kFetch2
	// UCCV2.Key_rmsid_main()
	


	
EXPORT DoFDCJoin_BBB2__kfetch_BBB_LinkIds := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_BBB2__kfetch_BBB_LinkIds;
		
		 
EXPORT DoFDCJoin_BBB2__kfetch_BBB_Non_Member_LinkIds := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_BBB2__kfetch_BBB_Non_Member_LinkIds;


EXPORT DoFDCJoin_BusReg__kfetch_busreg_company_linkids := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_BusReg__kfetch_busreg_company_linkids;
			
		 
EXPORT DoFDCJoin_CalBus__kfetch_Calbus_LinkIDS := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_CalBus__kfetch_Calbus_LinkIDS;

		 
EXPORT DoFDCJoin_Cortera__kfetch_LinkID := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Cortera__kfetch_LinkID;

		
EXPORT DoFDCJoin_DCAV2__kfetch_LinkIds := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_DCAV2__kfetch_LinkIds;
			 
		 	
EXPORT DoFDCJoin_EBR_kfetch_5600_Demographic_Data_linkids := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_EBR_kfetch_5600_Demographic_Data_linkids;

		
EXPORT DoFDCJoin_FBNv2__kfetch_LinkIds := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_FBNv2__kfetch_LinkIds;
			 
	
EXPORT DoFDCJoin_GovData__kfetch_IRS_NonProfit_linkIDs := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_GovData__kfetch_IRS_NonProfit_linkIDs;
	
		
EXPORT DoFDCJoin_IRS5500__kfetch_LinkIDs := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_IRS5500__kfetch_LinkIDs;
		 
	
EXPORT DoFDCJoin_OSHAIR__kfetch_OSHAIR_LinkIds := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_OSHAIR__kfetch_OSHAIR_LinkIds;

		
EXPORT DoFDCJoin_SAM__kfetch_linkID := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_SAM__kfetch_linkID;
		 
	
EXPORT DoFDCJoin_YellowPages__kfetch_yellowpages_linkids := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_YellowPages__kfetch_yellowpages_linkids;

		 
EXPORT DoFDCJoin_Infutor__NARB_kfetch_LinkIds := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Infutor__NARB_kfetch_LinkIds;
				 
	
EXPORT DoFDCJoin_Equifax_Business_Data__kfetch_LinkIDs := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Equifax_Business_Data__kfetch_LinkIDs;


	
		 
EXPORT DoFDCJoin_EBR__Key_0010_Header_linkids := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_EBR__Key_0010_Header_linkids;//can be used by itself without FILE_NUMBER
		 

EXPORT DoFDCJoin_EBR__Key_2015_Trade_Payment_Totals_FILE_NUMBER := NOT Options.isFCRA AND (JoinFlags.DoFDCJoin_EBR__Key_2015_Trade_Payment_Totals_FILE_NUMBER and JoinFlags.DoFDCJoin_EBR__Key_0010_Header_linkids);//needs kfetch
	// ebr.Key_2015_Trade_Payment_Totals_FILE_NUMBER
	// EBR.Key_0010_Header_linkids.kFetch2
		 
EXPORT DoFDCJoin_Experian_CRDB__Key_LinkIDs := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Experian_CRDB__Key_LinkIDs;

		 
EXPORT DoFDCJoin_dx_DataBridge__Key_LinkIds := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_dx_DataBridge__Key_LinkIds;
		 	 
		 
EXPORT DoFDCJoin_BIPV2_Best__Key_LinkIds := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_BIPV2_Best__Key_LinkIds;

		 
EXPORT DoFDCJoin_RiskWise__Key_CityStZip := JoinFlags.DoFDCJoin_RiskWise__Key_CityStZip;



EXPORT DoFDCJoin_Gong__Key_History_DID := JoinFlags.DoFDCJoin_Gong__Key_History_DID;


EXPORT DoFDCJoin_Gong__Key_History_Address := JoinFlags.DoFDCJoin_Gong__Key_History_Address;


EXPORT DoFDCJoin_Gong__Key_History_Phone := JoinFlags.DoFDCJoin_Gong__Key_History_Phone;


EXPORT DoFDCJoin_Gong__Key_History_LinkIds := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Gong__Key_History_LinkIds;


EXPORT DoFDCJoin_Targus__Key_Targus_Phone := JoinFlags.DoFDCJoin_Targus__Key_Targus_Phone;


EXPORT DoFDCJoin_InfutorCID__Key_Infutor_Phone := JoinFlags.DoFDCJoin_InfutorCID__Key_Infutor_Phone;


 
EXPORT DoFDCJoin_PhonePlus_V2__Key_Source_Level_Payload_phone := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_PhonePlus_V2__Key_Source_Level_Payload_phone;

EXPORT DoFDCJoin_PhonePlus_V2__Key_Source_Level_Payload_did := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_PhonePlus_V2__Key_Source_Level_Payload_did;

//triggerd by turning on the above pp keys	
EXPORT DoFDCJoin_PhonePlus_V2__Key_Source_Level_Payload := NOT Options.isFCRA AND (JoinFlags.DoFDCJoin_PhonePlus_V2__Key_Source_Level_Payload_did OR JoinFlags.DoFDCJoin_PhonePlus_V2__Key_Source_Level_Payload_phone);
	
			
EXPORT DoFDCJoin_PhonePlus_V2__Iverification_Phone := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_PhonePlus_V2__Iverification_Phone;
EXPORT DoFDCJoin_PhonePlus_V2__Iverification_Did_Phone := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_PhonePlus_V2__Iverification_Did_Phone;


EXPORT DoFDCJoin_CellPhone__Key_Nustar_Phone := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_CellPhone__Key_Nustar_Phone;
 

		 
EXPORT DoFDCJoin_PhoneInfo__Key_Phone_Type := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_PhoneInfo__Key_Phone_Type;

		
EXPORT DoFDCJoin_PhoneInfo__Key_Phone_Transaction := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_PhoneInfo__Key_Phone_Transaction;


EXPORT DoFDCJoin_PropertyV2__Key_Assessor_Fid := JoinFlags.DoFDCJoin_PropertyV2__Key_Assessor_Fid;	

	
EXPORT DoFDCJoin_PropertyV2__Key_Deed_Fid := JoinFlags.DoFDCJoin_PropertyV2__Key_Deed_Fid;	


EXPORT DoFDCJoin_PropertyV2__Key_Property_Did := JoinFlags.DoFDCJoin_PropertyV2__Key_Property_Did;	

			
EXPORT DoFDCJoin_PropertyV2__Key_Linkids_Key := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_PropertyV2__Key_Linkids_Key;

			
EXPORT DoFDCJoin_PropertyV2__Key_Addr_Fid := JoinFlags.DoFDCJoin_PropertyV2__Key_Addr_Fid;	

			
EXPORT DoFDCJoin_PropertyV2__Key_Search_Fid := (JoinFlags.DoFDCJoin_PropertyV2__Key_Assessor_Fid OR JoinFlags.DoFDCJoin_PropertyV2__Key_Deed_Fid);//does not have dates of its own

	
EXPORT DoFDCJoin_AVM_V2__Key_AVM_Address := JoinFlags.DoFDCJoin_AVM_V2__Key_AVM_Address;	

		
EXPORT DoFDCJoin_AVM_V2__Key_AVM_Medians := JoinFlags.DoFDCJoin_AVM_V2__Key_AVM_Medians;	

			
EXPORT DoFDCJoinfn_FLAccidents_Ecrash__key_Ecrash_accnbr := NOT Options.isFCRA AND JoinFlags.DoFDCJoinfn_FLAccidents_Ecrash__key_Ecrash_accnbr;
	// FLAccidents_Ecrash.key_EcrashV2_accnbr
	
EXPORT DoFDCJoinfn_FLAccidents_Ecrash__key_Ecrash := NOT Options.isFCRA AND JoinFlags.DoFDCJoinfn_FLAccidents_Ecrash__key_Ecrash;
	// FLAccidents_Ecrash.Key_ECrash

//triggered by turning on the above accident keys
EXPORT DoFDCJoinfn_FLAccidents_Ecrash__Key_EcrashV2_did := NOT Options.isFCRA AND (JoinFlags.DoFDCJoinfn_FLAccidents_Ecrash__key_Ecrash OR JoinFlags.DoFDCJoinfn_FLAccidents_Ecrash__key_Ecrash_accnbr);
	// FLAccidents_Ecrash.Key_EcrashV2_did
			 


EXPORT DoFDCJoin_fraudpoint3__Key_DID := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_fraudpoint3__Key_DID;


//MAS is only using the nonFCRA version of these keys right now, however the FCRA version was left in the FDC joins in case future changes are wanted.
EXPORT DoFDCJoin_eMerges__key_ccw_rid := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_eMerges__key_ccw_rid;
	// eMerges.key_ccw_did
	// eMerges.key_ccw_rid
			
//MAS is only using the nonFCRA version of these keys right now, however the FCRA version was left in the FDC joins in case future changes are wanted.		
EXPORT DoFDCJoin_eMerges__Key_HuntFish_Rid := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_eMerges__Key_HuntFish_Rid;
	// Key_HuntFish_Did
	// eMerges.Key_HuntFish_Rid		
		
EXPORT DoFDCJoin_Thrive__Key_did_QA := JoinFlags.DoFDCJoin_Thrive__Key_did_QA;
	
			 
//inquiries
EXPORT DoFDCJoin_Inquiry_AccLogs__Key_Address_FCRA := Options.isFCRA AND JoinFlags.DoFDCJoin_Inquiry_AccLogs__Key_Address_FCRA;
EXPORT DoFDCJoin_Inquiry_AccLogs__Key_DID_FCRA := Options.isFCRA AND JoinFlags.DoFDCJoin_Inquiry_AccLogs__Key_DID_FCRA;
EXPORT DoFDCJoin_Inquiry_AccLogs__Key_SSN_FCRA := Options.isFCRA AND JoinFlags.DoFDCJoin_Inquiry_AccLogs__Key_SSN_FCRA;
EXPORT DoFDCJoin_Inquiry_AccLogs__Key_Phone_FCRA := Options.isFCRA AND JoinFlags.DoFDCJoin_Inquiry_AccLogs__Key_Phone_FCRA;
	

		 
// /will get full, update and deltabase when gateway is one
EXPORT DoFDCJoin_Inquiry_AccLogs__Inquiry_DeltaBase := NOT Options.isFCRA AND (JoinFlags.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_Address OR
																																									JoinFlags.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_DID OR 
																																									JoinFlags.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_EMAIL OR 
																																									JoinFlags.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_Phone OR
																																									JoinFlags.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_SSN);
																																									
EXPORT DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_Address := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_Address;
EXPORT DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_DID := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_DID;
EXPORT DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_EMAIL := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_EMAIL;
EXPORT DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_Phone := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_Phone;
EXPORT DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_SSN := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_SSN;
EXPORT DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_FEIN := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_FEIN;
EXPORT DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_LinkIDs := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_LinkIDs;

	
 
EXPORT DoFDCJoin_HighRiskAddress := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_HighRiskAddress;

		 
EXPORT DoFDCJoin_HighRiskPhone := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_HighRiskPhone;

		 
EXPORT DoFDCJoin_Overrides := Options.IsFCRA AND JoinFlags.DoFDCJoinfn_IncludeOverrides;	

		 
EXPORT DoFDCJoin_Key_SexOffender := Options.isFCRA AND JoinFlags.DoFDCJoin_Key_SexOffender;
	// Key_SexOffender_DID
	// Key_SexOffender_SPK
	
EXPORT DoFDCJoin_Property__Key_Foreclosure_FID := NOT Options.isFCRA AND JoinFlags.DoFDCJoin_Property__Key_Foreclosure_FID;
	// Key_Foreclosure_DID
	// Key_Foreclosures_FID

END;