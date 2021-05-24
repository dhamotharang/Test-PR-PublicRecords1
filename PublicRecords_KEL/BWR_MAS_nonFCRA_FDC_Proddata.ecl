#workunit('name','MAS FDC Proddata - dev156 thread 1');
IMPORT KEL13 AS KEL;
import ut, PublicRecords_KEL, STD,RiskWise, Gateway;


STD.Date.Date_t dtArchiveDate := STD.Date.Today(); // Note: STD.Date.Date_t is UNSIGNED4

RoxieIP := RiskWise.shortcuts.Dev156;

threads := 1;

InputFile := '~temp::kel::ally_01_business_uat_sample_100k_20181015.csv';
OutputFile := '~bbraaten::FDC_100K_nonFCRA_Results'+ ThorLib.wuid();

histDate := STD.Date.Today;

Score_threshold := 80;
RecordsToRun := ALL;
eyeball := 100;

//options
// Use default list of allowed sources
AllowedSourcesDataset := DATASET([],PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources);
// Do not exclude any additional sources from allowed sources dataset.
ExcludeSourcesDataset := DATASET([],PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources);

BOOLEAN FDC := FALSE; //defaulted to false in query to see FDC turn on.  File to big to output when = TRUE
BOOLEAN DoFDCJoin_ADVO__Key_Addr1_History := False;
BOOLEAN DoFDCJoin_Aircraft_Files__FAA__Aircraft := False;
BOOLEAN DoFDCJoin_Aircraft_Files__FAA__Aircraft_linkids := False;
BOOLEAN DoFDCJoin_AlloyMedia_student_list__key_DID := False;
BOOLEAN DoFDCJoin_American_student_list__key_DID := False;
BOOLEAN DoFDCJoin_AVM_V2__Key_AVM_Address := False;
BOOLEAN DoFDCJoin_AVM_V2__Key_AVM_Medians := False;
BOOLEAN DoFDCJoin_Bankruptcy_Files__Bankruptcy__Linkid_Key_Search := False;
BOOLEAN DoFDCJoin_Bankruptcy_Files__Key_bankruptcy_did := False;
BOOLEAN DoFDCJoin_BBB2__kfetch_BBB_LinkIds := False;
BOOLEAN DoFDCJoin_BBB2__kfetch_BBB_Non_Member_LinkIds := False;
BOOLEAN DoFDCJoin_Best_Person__Key_Watchdog := False;
BOOLEAN DoFDCJoin_Best_Person__Key_Watchdog_FCRA := False;
BOOLEAN DoFDCJoin_BIPV2_Best__Key_LinkIds := False;
BOOLEAN DoFDCJoin_BIPV2_Build__kfetch_contact_linkids := False;
BOOLEAN DoFDCJoin_BIPV2_Build__kfetch_contact_linkids_slim   := False;
BOOLEAN DoFDCJoin_Business_Files__Business__Key_BH_Linking_Ids := False;
BOOLEAN DoFDCJoin_Business_Files__Business__Key_BH_Linking_Ids_extra := False;
BOOLEAN DoFDCJoin_BusReg__kfetch_busreg_company_linkids := False;
BOOLEAN DoFDCJoin_CalBus__kfetch_Calbus_LinkIDS := False;
BOOLEAN DoFDCJoin_CellPhone__Key_Nustar_Phone := False;
BOOLEAN DoFDCJoin_Certegy__Key_Certegy_DID := False;
BOOLEAN DoFDCJoin_Corp2__Key_LinkIDs_Corp := False;
BOOLEAN DoFDCJoin_Cortera__kfetch_LinkID := False;
BOOLEAN DoFDCJoin_DCAV2__kfetch_LinkIds := False;
BOOLEAN DoFDCJoin_DeathMaster__Key_SSN_SSA := False;
BOOLEAN DoFDCJoin_DMA__Key_DNM_Name_Address := False;
BOOLEAN DoFDCJoin_Doxie__Key_Death_MasterV2_SSA_DID := False;
BOOLEAN DoFDCJoin_Doxie__Key_Header := False;
BOOLEAN DoFDCJoin_Doxie__Key_Header_Address := False;
BOOLEAN DoFDCJoin_Doxie__Key_Header_ingest_date := False;
BOOLEAN DoFDCJoin_Doxie_Files__Key_Offenders := False;
BOOLEAN DoFDCJoin_Doxie_Files__Key_Offenders_Risk := False;
BOOLEAN DoFDCJoin_DriversV2__Key_DL_DID := False;
BOOLEAN DoFDCJoin_DriversV2__Key_DL_Number := False;
BOOLEAN DoFDCJoin_dx_CFPB__key_BLKGRP := False;
BOOLEAN DoFDCJoin_dx_CFPB__key_BLKGRP_over18 := False;
BOOLEAN DoFDCJoin_dx_CFPB__key_Census_Surnames := False;
BOOLEAN DoFDCJoin_dx_DataBridge__Key_LinkIds := False;
BOOLEAN DoFDCJoin_dx_Header__key_did_hhid := False;
BOOLEAN DoFDCJoin_Dx_Header__key_wild_phone := False;
BOOLEAN DoFDCJoin_Dx_Header__key_wild_SSN := False;
BOOLEAN DoFDCJoin_EBR__Key_0010_Header_linkids := False;
BOOLEAN DoFDCJoin_EBR__Key_2015_Trade_Payment_Totals_FILE_NUMBER   := False;
BOOLEAN DoFDCJoin_EBR_kfetch_5600_Demographic_Data_linkids := False;
BOOLEAN DoFDCJoin_Email_Data__Key_did := False;
BOOLEAN DoFDCJoin_Email_Data__Key_Did_FCRA := False;
BOOLEAN DoFDCJoin_Email_Data__Key_Email_Address := False;
BOOLEAN DoFDCJoin_eMerges__key_ccw_rid := False;
BOOLEAN DoFDCJoin_eMerges__Key_HuntFish_Rid := False;
BOOLEAN DoFDCJoin_Equifax_Business_Data__kfetch_LinkIDs := False;
BOOLEAN DoFDCJoin_Experian_CRDB__Key_LinkIDs := False;
BOOLEAN DoFDCJoin_FBNv2__kfetch_LinkIds := False;
BOOLEAN DoFDCJoin_Fraudpoint3__Key_Address := False;
BOOLEAN DoFDCJoin_fraudpoint3__Key_DID := False;
BOOLEAN DoFDCJoin_Fraudpoint3__Key_Phone := False;
BOOLEAN DoFDCJoin_Fraudpoint3__Key_SSN := False;
BOOLEAN DoFDCJoin_Gong__Key_History_Address := False;
BOOLEAN DoFDCJoin_Gong__Key_History_DID := False;
BOOLEAN DoFDCJoin_Gong__Key_History_LinkIds := False;
BOOLEAN DoFDCJoin_Gong__Key_History_Phone := False;
BOOLEAN DoFDCJoin_GovData__kfetch_IRS_NonProfit_linkIDs := False;
BOOLEAN DoFDCJoin_Header__Key_Addr_Hist   := False;
BOOLEAN DoFDCJoin_Header__key_ADL_segmentation := False;
BOOLEAN DoFDCJoin_HighRiskAddress := False;
BOOLEAN DoFDCJoin_HighRiskPhone := False;
BOOLEAN DoFDCJoin_Infutor__NARB_kfetch_LinkIds := False;
BOOLEAN DoFDCJoin_InfutorCID__Key_Infutor_Phone := False;
BOOLEAN DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_Address := False;
BOOLEAN DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_DID := False;
BOOLEAN DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_EMAIL := False;
BOOLEAN DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_FEIN := False;
BOOLEAN DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_LinkIDs := False;
BOOLEAN DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_Phone := False;
BOOLEAN DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_SSN := False;
BOOLEAN DoFDCJoin_Inquiry_AccLogs__Key_Address_FCRA := False;
BOOLEAN DoFDCJoin_Inquiry_AccLogs__Key_DID_FCRA := False;
BOOLEAN DoFDCJoin_Inquiry_AccLogs__Key_Phone_FCRA := False;
BOOLEAN DoFDCJoin_Inquiry_AccLogs__Key_SSN_FCRA := False;
BOOLEAN DoFDCJoin_IRS5500__kfetch_LinkIDs := False;
BOOLEAN DoFDCJoin_Key_SexOffender := False;
BOOLEAN DoFDCJoin_LiensV2_key_liens := False;
BOOLEAN DoFDCJoin_LiensV2_Key_party_Linkids_Records := False;
BOOLEAN DoFDCJoin_OSHAIR__kfetch_OSHAIR_LinkIds := False;
BOOLEAN DoFDCJoin_PhoneInfo__Key_Phone_Transaction := False;
BOOLEAN DoFDCJoin_PhoneInfo__Key_Phone_Type := False;
BOOLEAN DoFDCJoin_PhonePlus_V2__Iverification_Did_Phone := False;
BOOLEAN DoFDCJoin_PhonePlus_V2__Iverification_Phone := False;
BOOLEAN DoFDCJoin_PhonePlus_V2__Key_Source_Level_Payload_did   := False;
BOOLEAN DoFDCJoin_PhonePlus_V2__Key_Source_Level_Payload_phone := False;
BOOLEAN DoFDCJoin_Prof_License_Mari__Key_Did := False;
BOOLEAN DoFDCJoin_Prof_LicenseV2__Key_Proflic_Did   := False;
BOOLEAN DoFDCJoin_Property__Key_Foreclosure_FID := False;
BOOLEAN DoFDCJoin_PropertyV2__Key_Addr_Fid := False;
BOOLEAN DoFDCJoin_PropertyV2__Key_Assessor_Fid   := False;
BOOLEAN DoFDCJoin_PropertyV2__Key_Deed_Fid := False;
BOOLEAN DoFDCJoin_PropertyV2__Key_Linkids_Key := False;
BOOLEAN DoFDCJoin_PropertyV2__Key_Property_Did := False;
BOOLEAN DoFDCJoin_Quick_Header__key_wild_SSN := False;
BOOLEAN DoFDCJoin_Relatives__Key_Relatives_v3 := False;
BOOLEAN DoFDCJoin_Risk_Indicators__Correlation_Risk__key_addr_dob_summary := False;
BOOLEAN DoFDCJoin_Risk_Indicators__Correlation_Risk__key_addr_name_summary := False;
BOOLEAN DoFDCJoin_Risk_Indicators__Correlation_Risk__key_name_dob_summary := False;
BOOLEAN DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_addr_header_summary := False;
BOOLEAN DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_addr_summary := False;
BOOLEAN DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_dob_summary := False;
BOOLEAN DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_lname_header_summary := False;
BOOLEAN DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_lname_summary := False;
BOOLEAN DoFDCJoin_Risk_Indicators__Correlation_Risk__key_ssn_addr_summary := False;
BOOLEAN DoFDCJoin_Risk_Indicators__Correlation_Risk__key_ssn_dob_summary := False;
BOOLEAN DoFDCJoin_Risk_Indicators__Correlation_Risk__key_ssn_name_summary := False;
BOOLEAN DoFDCJoin_Risk_Indicators__Correlation_Risk__key_ssn_phone_summary := False;
BOOLEAN DoFDCJoin_RiskWise__Key_CityStZip := False;
BOOLEAN DoFDCJoin_SAM__kfetch_linkID := False;
BOOLEAN DoFDCJoin_Targus__Key_Targus_Phone := False;
BOOLEAN DoFDCJoin_Thrive__Key_did_QA := False;
BOOLEAN DoFDCJoin_Tradeline_Files__Tradeline__Key_LinkIds := False;
BOOLEAN DoFDCJoin_UCC_Files__Key_Linkids := False;
BOOLEAN DoFDCJoin_USPIS_HotList__key_addr_search_zip := False;
BOOLEAN DoFDCJoin_UtilFile__Key_Address := False;
BOOLEAN DoFDCJoin_UtilFile__Key_DID := False;
BOOLEAN DoFDCJoin_UtilFile__Key_LinkIds := False;
BOOLEAN DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_DID   := False;
BOOLEAN DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_LinkID := False;
BOOLEAN DoFDCJoin_Watercraft_Files__Watercraft := False;
BOOLEAN DoFDCJoin_Watercraft_Files__Watercraft_LinkId := False;
BOOLEAN DoFDCJoin_YellowPages__kfetch_yellowpages_linkids := False;
BOOLEAN DoFDCJoinfn_FLAccidents_Ecrash__key_Ecrash := False;
BOOLEAN DoFDCJoinfn_FLAccidents_Ecrash__key_Ecrash_accnbr := False;
BOOLEAN DoFDCJoinfn_IndexedSearchForXLinkIDs := False;
BOOLEAN DoFDCJoinfn_IncludeOverrides := False;


// If allowed sources aren't passed in, use default list of allowed sources
SetAllowedSources := IF(COUNT(AllowedSourcesDataset) = 0, PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_ALLOWED_SOURCES, AllowedSourcesDataset);
// If a source is on the Exclude list, remove it from the allowed sources list. 
FinalAllowedSources := JOIN(SetAllowedSources, ExcludeSourcesDataset, LEFT=RIGHT, TRANSFORM(RECORDOF(LEFT), SELF := LEFT), LEFT ONLY);
	
mod_ConfigTestJob(STD.Date.Date_t _dtArchiveDate = STD.Date.Today()) := MODULE

	SHARED BOOLEAN Is_Insurance_Product := FALSE;
	SHARED BOOLEAN Allow_DNBDMI := FALSE;

	// Configure options:
	EXPORT Options := MODULE(PublicRecords_KEL.Interface_Options)
		EXPORT STRING100 AttributeSetName           := '';
		EXPORT STRING100 VersionName                := '';
		EXPORT BOOLEAN isFCRA                    := FALSE; // ------------------------------------- FCRA is FALSE;
		EXPORT STRING8 ArchiveDate                := (STRING)_dtArchiveDate;
		EXPORT STRING250 InputFileName              := '';
		EXPORT STRING100 Data_Restriction_Mask      := '00000000000000000000000000000000000000000000000000';
		EXPORT STRING100 Data_Permission_Mask       := '11111111111111111111111111111111111111111111111111';
		EXPORT UNSIGNED GLBAPurpose              := 1;
		EXPORT UNSIGNED DPPAPurpose              := 2;
		EXPORT BOOLEAN Override_Experian_Restriction := FALSE;
		EXPORT STRING100 Allowed_Sources            := '';
		EXPORT INTEGER ScoreThreshold            := 80;
		EXPORT BOOLEAN ExcludeConsumerShell      := FALSE;
		EXPORT BOOLEAN isMarketing               := FALSE;
		EXPORT BOOLEAN OutputMasterResults       := FALSE;
		EXPORT DATASET(PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources) Allowed_Sources_Dataset := FinalAllowedSources;

		// BIP Append Options
		EXPORT UNSIGNED BIPAppendScoreThreshold  := 75;
		EXPORT UNSIGNED BIPAppendWeightThreshold := 0;
		EXPORT BOOLEAN BIPAppendPrimForce        := FALSE;
		EXPORT BOOLEAN BIPAppendReAppend         := TRUE;
		EXPORT BOOLEAN BIPAppendIncludeAuthRep   := FALSE;

		EXPORT DATA57 KEL_Permissions_Mask := 
				PublicRecords_KEL.ECL_Functions.Fn_KEL_DPMBitmap.Generate(
						DataRestrictionMask := Data_Restriction_Mask, 
						DataPermissionMask  := Data_Permission_Mask, 
						GLBA                := GLBAPurpose, 
						DPPA                := DPPAPurpose, 
						isFCRA              := isFCRA, 
						isMarketing         := isMarketing, 
						AllowDNBDMI         := Allow_DNBDMI, 
						OverrideExperianRestriction := Override_Experian_Restriction, 
						IntendedPurpose  := '',
						IndustryClass  := '',
						KELPermissions      := PublicRecords_KEL.KEL_Queries_MAS_Shared.C_Compile, 
						IsInsuranceProduct  := Is_Insurance_Product,
						AllowedSources := FinalAllowedSources);
	END;		

END;

m := mod_ConfigTestJob( dtArchiveDate );

PDPM := m.Options.KEL_Permissions_Mask;


// Read input file
prii_layout := RECORD
		STRING AccountNumber;
		STRING CompanyName;
		STRING AlternateCompanyName;
		STRING Addr1;
		STRING City1;
		STRING State1;
		STRING Zip1;
		STRING BusinessPhone;
		STRING TaxIdNumber;
		STRING BusinessIPAddress;
		STRING BusinessURL;
		STRING BusinessEmailAddress;
		STRING Rep1firstname;
		STRING Rep1MiddleName;
		STRING Rep1lastname;
		STRING Rep1NameSuffix;
		STRING Rep1Addr;
		STRING Rep1City;
		STRING Rep1State;
		STRING Rep1Zip;
		STRING Rep1SSN;
		STRING Rep1DOB;
		STRING Rep1Age;
		STRING Rep1DLNumber;
		STRING Rep1DLState;
		STRING Rep1HomePhone;
		STRING Rep1EmailAddress;
		STRING Rep1FormerLastName;
		STRING Rep1LexID;
		STRING ArchiveDate;
		STRING PowID;
		STRING ProxID;
		STRING SeleID;
		STRING OrgID;
		STRING UltID;
		STRING SIC_Code;
		STRING NAIC_Code;
		STRING Rep2firstname;
		STRING Rep2MiddleName;
		STRING Rep2lastname;
		STRING Rep2NameSuffix;
		STRING Rep2Addr;
		STRING Rep2City;
		STRING Rep2State;
		STRING Rep2Zip;
		STRING Rep2SSN;
		STRING Rep2DOB;
		STRING Rep2Age;
		STRING Rep2DLNumber;
		STRING Rep2DLState;
		STRING Rep2HomePhone;
		STRING Rep2EmailAddress;
		STRING Rep2FormerLastName;
		STRING Rep2LexID;
		STRING Rep3firstname;
		STRING Rep3MiddleName;
		STRING Rep3lastname;
		STRING Rep3NameSuffix;
		STRING Rep3Addr;
		STRING Rep3City;
		STRING Rep3State;
		STRING Rep3Zip;
		STRING Rep3SSN;
		STRING Rep3DOB;
		STRING Rep3Age;
		STRING Rep3DLNumber;
		STRING Rep3DLState;
		STRING Rep3HomePhone;
		STRING Rep3EmailAddress;
		STRING Rep3FormerLastName;
		STRING Rep3LexID;
		STRING Rep4firstname;
		STRING Rep4MiddleName;
		STRING Rep4lastname;
		STRING Rep4NameSuffix;
		STRING Rep4Addr;
		STRING Rep4City;
		STRING Rep4State;
		STRING Rep4Zip;
		STRING Rep4SSN;
		STRING Rep4DOB;
		STRING Rep4Age;
		STRING Rep4DLNumber;
		STRING Rep4DLState;
		STRING Rep4HomePhone;
		STRING Rep4EmailAddress;
		STRING Rep4FormerLastName;
		STRING Rep4LexID;
		STRING Rep5firstname;
		STRING Rep5MiddleName;
		STRING Rep5lastname;
		STRING Rep5NameSuffix;
		STRING Rep5Addr;
		STRING Rep5City;
		STRING Rep5State;
		STRING Rep5Zip;
		STRING Rep5SSN;
		STRING Rep5DOB;
		STRING Rep5Age;
		STRING Rep5DLNumber;
		STRING Rep5DLState;
		STRING Rep5HomePhone;
		STRING Rep5EmailAddress;
		STRING Rep5FormerLastName;
		STRING Rep5LexID;
		STRING ln_project_id;
		STRING pf_fraud;
		STRING pf_bad;
		STRING pf_funded;
		STRING pf_declined;
		STRING pf_approved_not_funded;
END;

p_in := DATASET(InputFile, prii_layout, CSV(QUOTE('"')))(companyname != 'CompanyName');

p := CHOOSEN(p_in, RecordsToRun);

PublicRecords_KEL.ECL_Functions.Input_Bus_Layout trans (p le, integer c) := transform 
		self.accountnumber := le.accountnumber;
		SELF.businesstin := le.TaxIdNumber;
		SELF.streetaddressline1 := le.Addr1;
		SELF.rep1streetaddressline1 := le.Rep1Addr;
		SELF := le;
		SELF := [];
end;

pp := project(p, trans(left, counter));

soapLayout := RECORD
		DATASET(PublicRecords_KEL.ECL_Functions.Input_Bus_Layout) input;
		INTEGER InputArchiveDateClean;
		STRING DataRestrictionMask;
		STRING DataPermissionMask;
		STRING GLBA;
		STRING DPPA;
		STRING PDPM;
		DATASET(PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources) AllowedSourcesDataset := DATASET([], PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources);
		DATASET(PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources) ExcludeSourcesDataset := DATASET([], PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources);
		BOOLEAN ViewFDC;
		BOOLEAN DoFDCJoin_ADVO__Key_Addr1_History;
		BOOLEAN DoFDCJoin_Aircraft_Files__FAA__Aircraft;
		BOOLEAN DoFDCJoin_Aircraft_Files__FAA__Aircraft_linkids;
		BOOLEAN DoFDCJoin_AlloyMedia_student_list__key_DID;
		BOOLEAN DoFDCJoin_American_student_list__key_DID;
		BOOLEAN DoFDCJoin_AVM_V2__Key_AVM_Address;
		BOOLEAN DoFDCJoin_AVM_V2__Key_AVM_Medians;
		BOOLEAN DoFDCJoin_Bankruptcy_Files__Bankruptcy__Linkid_Key_Search;
		BOOLEAN DoFDCJoin_Bankruptcy_Files__Key_bankruptcy_did;
		BOOLEAN DoFDCJoin_BBB2__kfetch_BBB_LinkIds;
		BOOLEAN DoFDCJoin_BBB2__kfetch_BBB_Non_Member_LinkIds;
		BOOLEAN DoFDCJoin_Best_Person__Key_Watchdog;
		BOOLEAN DoFDCJoin_Best_Person__Key_Watchdog_FCRA;
		BOOLEAN DoFDCJoin_BIPV2_Best__Key_LinkIds;
		BOOLEAN DoFDCJoin_BIPV2_Build__kfetch_contact_linkids;
		BOOLEAN DoFDCJoin_BIPV2_Build__kfetch_contact_linkids_slim;
		BOOLEAN DoFDCJoin_Business_Files__Business__Key_BH_Linking_Ids;
		BOOLEAN DoFDCJoin_Business_Files__Business__Key_BH_Linking_Ids_extra;
		BOOLEAN DoFDCJoin_BusReg__kfetch_busreg_company_linkids;
		BOOLEAN DoFDCJoin_CalBus__kfetch_Calbus_LinkIDS;
		BOOLEAN DoFDCJoin_CellPhone__Key_Nustar_Phone;
		BOOLEAN DoFDCJoin_Certegy__Key_Certegy_DID;
		BOOLEAN DoFDCJoin_Corp2__Key_LinkIDs_Corp;
		BOOLEAN DoFDCJoin_Cortera__kfetch_LinkID;
		BOOLEAN DoFDCJoin_DCAV2__kfetch_LinkIds;
		BOOLEAN DoFDCJoin_DeathMaster__Key_SSN_SSA;
		BOOLEAN DoFDCJoin_DMA__Key_DNM_Name_Address;
		BOOLEAN DoFDCJoin_Doxie__Key_Death_MasterV2_SSA_DID;
		BOOLEAN DoFDCJoin_Doxie__Key_Header;
		BOOLEAN DoFDCJoin_Doxie__Key_Header_Address;
		BOOLEAN DoFDCJoin_Doxie__Key_Header_ingest_date;
		BOOLEAN DoFDCJoin_Doxie_Files__Key_Offenders;
		BOOLEAN DoFDCJoin_Doxie_Files__Key_Offenders_Risk;
		BOOLEAN DoFDCJoin_DriversV2__Key_DL_DID;
		BOOLEAN DoFDCJoin_DriversV2__Key_DL_Number;
		BOOLEAN DoFDCJoin_dx_CFPB__key_BLKGRP;
		BOOLEAN DoFDCJoin_dx_CFPB__key_BLKGRP_over18;
		BOOLEAN DoFDCJoin_dx_CFPB__key_Census_Surnames;
		BOOLEAN DoFDCJoin_dx_DataBridge__Key_LinkIds;
		BOOLEAN DoFDCJoin_dx_Header__key_did_hhid;
		BOOLEAN DoFDCJoin_Dx_Header__key_wild_phone;
		BOOLEAN DoFDCJoin_Dx_Header__key_wild_SSN;
		BOOLEAN DoFDCJoin_EBR__Key_0010_Header_linkids;
		BOOLEAN DoFDCJoin_EBR__Key_2015_Trade_Payment_Totals_FILE_NUMBER;
		BOOLEAN DoFDCJoin_EBR_kfetch_5600_Demographic_Data_linkids;
		BOOLEAN DoFDCJoin_Email_Data__Key_did;
		BOOLEAN DoFDCJoin_Email_Data__Key_Did_FCRA;
		BOOLEAN DoFDCJoin_Email_Data__Key_Email_Address;
		BOOLEAN DoFDCJoin_eMerges__key_ccw_rid;
		BOOLEAN DoFDCJoin_eMerges__Key_HuntFish_Rid;
		BOOLEAN DoFDCJoin_Equifax_Business_Data__kfetch_LinkIDs;
		BOOLEAN DoFDCJoin_Experian_CRDB__Key_LinkIDs;
		BOOLEAN DoFDCJoin_FBNv2__kfetch_LinkIds;
		BOOLEAN DoFDCJoin_Fraudpoint3__Key_Address;
		BOOLEAN DoFDCJoin_fraudpoint3__Key_DID;
		BOOLEAN DoFDCJoin_Fraudpoint3__Key_Phone;
		BOOLEAN DoFDCJoin_Fraudpoint3__Key_SSN;
		BOOLEAN DoFDCJoin_Gong__Key_History_Address;
		BOOLEAN DoFDCJoin_Gong__Key_History_DID;
		BOOLEAN DoFDCJoin_Gong__Key_History_LinkIds;
		BOOLEAN DoFDCJoin_Gong__Key_History_Phone;
		BOOLEAN DoFDCJoin_GovData__kfetch_IRS_NonProfit_linkIDs;
		BOOLEAN DoFDCJoin_Header__Key_Addr_Hist;
		BOOLEAN DoFDCJoin_Header__key_ADL_segmentation;
		BOOLEAN DoFDCJoin_HighRiskAddress;
		BOOLEAN DoFDCJoin_HighRiskPhone;
		BOOLEAN DoFDCJoin_Infutor__NARB_kfetch_LinkIds;
		BOOLEAN DoFDCJoin_InfutorCID__Key_Infutor_Phone;
		BOOLEAN DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_Address;
		BOOLEAN DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_DID;
		BOOLEAN DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_EMAIL;
		BOOLEAN DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_FEIN;
		BOOLEAN DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_LinkIDs;
		BOOLEAN DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_Phone;
		BOOLEAN DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_SSN;
		BOOLEAN DoFDCJoin_Inquiry_AccLogs__Key_Address_FCRA;
		BOOLEAN DoFDCJoin_Inquiry_AccLogs__Key_DID_FCRA;
		BOOLEAN DoFDCJoin_Inquiry_AccLogs__Key_Phone_FCRA;
		BOOLEAN DoFDCJoin_Inquiry_AccLogs__Key_SSN_FCRA;
		BOOLEAN DoFDCJoin_IRS5500__kfetch_LinkIDs;
		BOOLEAN DoFDCJoin_Key_SexOffender;
		BOOLEAN DoFDCJoin_LiensV2_key_liens;
		BOOLEAN DoFDCJoin_LiensV2_Key_party_Linkids_Records;
		BOOLEAN DoFDCJoin_OSHAIR__kfetch_OSHAIR_LinkIds;
		BOOLEAN DoFDCJoin_PhoneInfo__Key_Phone_Transaction;
		BOOLEAN DoFDCJoin_PhoneInfo__Key_Phone_Type;
		BOOLEAN DoFDCJoin_PhonePlus_V2__Iverification_Did_Phone;
		BOOLEAN DoFDCJoin_PhonePlus_V2__Iverification_Phone;
		BOOLEAN DoFDCJoin_PhonePlus_V2__Key_Source_Level_Payload_did;
		BOOLEAN DoFDCJoin_PhonePlus_V2__Key_Source_Level_Payload_phone;
		BOOLEAN DoFDCJoin_Prof_License_Mari__Key_Did;
		BOOLEAN DoFDCJoin_Prof_LicenseV2__Key_Proflic_Did;
		BOOLEAN DoFDCJoin_Property__Key_Foreclosure_FID;
		BOOLEAN DoFDCJoin_PropertyV2__Key_Addr_Fid;
		BOOLEAN DoFDCJoin_PropertyV2__Key_Assessor_Fid;
		BOOLEAN DoFDCJoin_PropertyV2__Key_Deed_Fid;
		BOOLEAN DoFDCJoin_PropertyV2__Key_Linkids_Key;
		BOOLEAN DoFDCJoin_PropertyV2__Key_Property_Did;
		BOOLEAN DoFDCJoin_Quick_Header__key_wild_SSN;
		BOOLEAN DoFDCJoin_Relatives__Key_Relatives_v3;
		BOOLEAN DoFDCJoin_Risk_Indicators__Correlation_Risk__key_addr_dob_summary;
		BOOLEAN DoFDCJoin_Risk_Indicators__Correlation_Risk__key_addr_name_summary;
		BOOLEAN DoFDCJoin_Risk_Indicators__Correlation_Risk__key_name_dob_summary;
		BOOLEAN DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_addr_header_summary;
		BOOLEAN DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_addr_summary;
		BOOLEAN DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_dob_summary;
		BOOLEAN DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_lname_header_summary;
		BOOLEAN DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_lname_summary;
		BOOLEAN DoFDCJoin_Risk_Indicators__Correlation_Risk__key_ssn_addr_summary;
		BOOLEAN DoFDCJoin_Risk_Indicators__Correlation_Risk__key_ssn_dob_summary;
		BOOLEAN DoFDCJoin_Risk_Indicators__Correlation_Risk__key_ssn_name_summary;
		BOOLEAN DoFDCJoin_Risk_Indicators__Correlation_Risk__key_ssn_phone_summary;
		BOOLEAN DoFDCJoin_RiskWise__Key_CityStZip;
		BOOLEAN DoFDCJoin_SAM__kfetch_linkID;
		BOOLEAN DoFDCJoin_Targus__Key_Targus_Phone;
		BOOLEAN DoFDCJoin_Thrive__Key_did_QA;
		BOOLEAN DoFDCJoin_Tradeline_Files__Tradeline__Key_LinkIds;
		BOOLEAN DoFDCJoin_UCC_Files__Key_Linkids;
		BOOLEAN DoFDCJoin_USPIS_HotList__key_addr_search_zip;
		BOOLEAN DoFDCJoin_UtilFile__Key_Address;
		BOOLEAN DoFDCJoin_UtilFile__Key_DID;
		BOOLEAN DoFDCJoin_UtilFile__Key_LinkIds;
		BOOLEAN DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_DID;
		BOOLEAN DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_LinkID;
		BOOLEAN DoFDCJoin_Watercraft_Files__Watercraft;
		BOOLEAN DoFDCJoin_Watercraft_Files__Watercraft_LinkId;
		BOOLEAN DoFDCJoin_YellowPages__kfetch_yellowpages_linkids;
		BOOLEAN DoFDCJoinfn_FLAccidents_Ecrash__key_Ecrash;
		BOOLEAN DoFDCJoinfn_FLAccidents_Ecrash__key_Ecrash_accnbr;
		BOOLEAN DoFDCJoinfn_IndexedSearchForXLinkIDs;
		BOOLEAN DoFDCJoinfn_IncludeOverrides;

end;

soapLayout trans_pre (pp le, Integer c):= TRANSFORM 
	// The inquiry delta base which feeds the 1 day inq attrs is not needed for the input rep 1 at this point. for now we only run this delta base code in the nonFCRA service 
	
		SELF.input := PROJECT(le, TRANSFORM(PublicRecords_KEL.ECL_Functions.Input_Bus_Layout,
		SELF := LEFT;
    SELF := []));	
		SELF.InputArchiveDateClean := (INTEGER)dtArchiveDate;
		SELF.DataRestrictionMask := m.Options.Data_Restriction_Mask;
		SELF.DataPermissionMask := m.Options.Data_Permission_Mask;
		SELF.GLBA := (STRING)m.Options.GLBAPurpose;
		SELF.DPPA := (STRING)m.Options.DPPAPurpose;
		SELF.PDPM := (STRING)m.Options.KEL_Permissions_Mask;
		SELF.AllowedSourcesDataset := AllowedSourcesDataset;
		SELF.ExcludeSourcesDataset := ExcludeSourcesDataset;
		SELF.ViewFDC := FDC; //defaulted to false in query to see FDC turn on
		self.DoFDCJoin_ADVO__Key_Addr1_History:=DoFDCJoin_ADVO__Key_Addr1_History;
		self.DoFDCJoin_Aircraft_Files__FAA__Aircraft:=DoFDCJoin_Aircraft_Files__FAA__Aircraft;
		self.DoFDCJoin_Aircraft_Files__FAA__Aircraft_linkids:=DoFDCJoin_Aircraft_Files__FAA__Aircraft_linkids;
		self.DoFDCJoin_AlloyMedia_student_list__key_DID:=DoFDCJoin_AlloyMedia_student_list__key_DID;
		self.DoFDCJoin_American_student_list__key_DID:=DoFDCJoin_American_student_list__key_DID;
		self.DoFDCJoin_AVM_V2__Key_AVM_Address:=DoFDCJoin_AVM_V2__Key_AVM_Address;
		self.DoFDCJoin_AVM_V2__Key_AVM_Medians:=DoFDCJoin_AVM_V2__Key_AVM_Medians;
		self.DoFDCJoin_Bankruptcy_Files__Bankruptcy__Linkid_Key_Search:=DoFDCJoin_Bankruptcy_Files__Bankruptcy__Linkid_Key_Search;
		self.DoFDCJoin_Bankruptcy_Files__Key_bankruptcy_did:=DoFDCJoin_Bankruptcy_Files__Key_bankruptcy_did;
		self.DoFDCJoin_BBB2__kfetch_BBB_LinkIds:=DoFDCJoin_BBB2__kfetch_BBB_LinkIds;
		self.DoFDCJoin_BBB2__kfetch_BBB_Non_Member_LinkIds:=DoFDCJoin_BBB2__kfetch_BBB_Non_Member_LinkIds;
		self.DoFDCJoin_Best_Person__Key_Watchdog:=DoFDCJoin_Best_Person__Key_Watchdog;
		self.DoFDCJoin_Best_Person__Key_Watchdog_FCRA:=DoFDCJoin_Best_Person__Key_Watchdog_FCRA;
		self.DoFDCJoin_BIPV2_Best__Key_LinkIds:=DoFDCJoin_BIPV2_Best__Key_LinkIds;
		self.DoFDCJoin_BIPV2_Build__kfetch_contact_linkids:=DoFDCJoin_BIPV2_Build__kfetch_contact_linkids;
		self.DoFDCJoin_BIPV2_Build__kfetch_contact_linkids_slim:=DoFDCJoin_BIPV2_Build__kfetch_contact_linkids_slim;
		self.DoFDCJoin_Business_Files__Business__Key_BH_Linking_Ids:=DoFDCJoin_Business_Files__Business__Key_BH_Linking_Ids;
		self.DoFDCJoin_Business_Files__Business__Key_BH_Linking_Ids_extra:=DoFDCJoin_Business_Files__Business__Key_BH_Linking_Ids_extra;
		self.DoFDCJoin_BusReg__kfetch_busreg_company_linkids:=DoFDCJoin_BusReg__kfetch_busreg_company_linkids;
		self.DoFDCJoin_CalBus__kfetch_Calbus_LinkIDS:=DoFDCJoin_CalBus__kfetch_Calbus_LinkIDS;
		self.DoFDCJoin_CellPhone__Key_Nustar_Phone:=DoFDCJoin_CellPhone__Key_Nustar_Phone;
		self.DoFDCJoin_Certegy__Key_Certegy_DID:=DoFDCJoin_Certegy__Key_Certegy_DID;
		self.DoFDCJoin_Corp2__Key_LinkIDs_Corp:=DoFDCJoin_Corp2__Key_LinkIDs_Corp;
		self.DoFDCJoin_Cortera__kfetch_LinkID:=DoFDCJoin_Cortera__kfetch_LinkID;
		self.DoFDCJoin_DCAV2__kfetch_LinkIds:=DoFDCJoin_DCAV2__kfetch_LinkIds;
		self.DoFDCJoin_DeathMaster__Key_SSN_SSA:=DoFDCJoin_DeathMaster__Key_SSN_SSA;
		self.DoFDCJoin_DMA__Key_DNM_Name_Address:=DoFDCJoin_DMA__Key_DNM_Name_Address;
		self.DoFDCJoin_Doxie__Key_Death_MasterV2_SSA_DID:=DoFDCJoin_Doxie__Key_Death_MasterV2_SSA_DID;
		self.DoFDCJoin_Doxie__Key_Header:=DoFDCJoin_Doxie__Key_Header;
		self.DoFDCJoin_Doxie__Key_Header_Address:=DoFDCJoin_Doxie__Key_Header_Address;
		self.DoFDCJoin_Doxie__Key_Header_ingest_date:=DoFDCJoin_Doxie__Key_Header_ingest_date;
		self.DoFDCJoin_Doxie_Files__Key_Offenders:=DoFDCJoin_Doxie_Files__Key_Offenders;
		self.DoFDCJoin_Doxie_Files__Key_Offenders_Risk:=DoFDCJoin_Doxie_Files__Key_Offenders_Risk;
		self.DoFDCJoin_DriversV2__Key_DL_DID:=DoFDCJoin_DriversV2__Key_DL_DID;
		self.DoFDCJoin_DriversV2__Key_DL_Number:=DoFDCJoin_DriversV2__Key_DL_Number;
		self.DoFDCJoin_dx_CFPB__key_BLKGRP:=DoFDCJoin_dx_CFPB__key_BLKGRP;
		self.DoFDCJoin_dx_CFPB__key_BLKGRP_over18:=DoFDCJoin_dx_CFPB__key_BLKGRP_over18;
		self.DoFDCJoin_dx_CFPB__key_Census_Surnames:=DoFDCJoin_dx_CFPB__key_Census_Surnames;
		self.DoFDCJoin_dx_DataBridge__Key_LinkIds:=DoFDCJoin_dx_DataBridge__Key_LinkIds;
		self.DoFDCJoin_dx_Header__key_did_hhid:=DoFDCJoin_dx_Header__key_did_hhid;
		self.DoFDCJoin_Dx_Header__key_wild_phone:=DoFDCJoin_Dx_Header__key_wild_phone;
		self.DoFDCJoin_Dx_Header__key_wild_SSN:=DoFDCJoin_Dx_Header__key_wild_SSN;
		self.DoFDCJoin_EBR__Key_0010_Header_linkids:=DoFDCJoin_EBR__Key_0010_Header_linkids;
		self.DoFDCJoin_EBR__Key_2015_Trade_Payment_Totals_FILE_NUMBER:=DoFDCJoin_EBR__Key_2015_Trade_Payment_Totals_FILE_NUMBER;
		self.DoFDCJoin_EBR_kfetch_5600_Demographic_Data_linkids:=DoFDCJoin_EBR_kfetch_5600_Demographic_Data_linkids;
		self.DoFDCJoin_Email_Data__Key_did:=DoFDCJoin_Email_Data__Key_did;
		self.DoFDCJoin_Email_Data__Key_Did_FCRA:=DoFDCJoin_Email_Data__Key_Did_FCRA;
		self.DoFDCJoin_Email_Data__Key_Email_Address:=DoFDCJoin_Email_Data__Key_Email_Address;
		self.DoFDCJoin_eMerges__key_ccw_rid:=DoFDCJoin_eMerges__key_ccw_rid;
		self.DoFDCJoin_eMerges__Key_HuntFish_Rid:=DoFDCJoin_eMerges__Key_HuntFish_Rid;
		self.DoFDCJoin_Equifax_Business_Data__kfetch_LinkIDs:=DoFDCJoin_Equifax_Business_Data__kfetch_LinkIDs;
		self.DoFDCJoin_Experian_CRDB__Key_LinkIDs:=DoFDCJoin_Experian_CRDB__Key_LinkIDs;
		self.DoFDCJoin_FBNv2__kfetch_LinkIds:=DoFDCJoin_FBNv2__kfetch_LinkIds;
		self.DoFDCJoin_Fraudpoint3__Key_Address:=DoFDCJoin_Fraudpoint3__Key_Address;
		self.DoFDCJoin_fraudpoint3__Key_DID:=DoFDCJoin_fraudpoint3__Key_DID;
		self.DoFDCJoin_Fraudpoint3__Key_Phone:=DoFDCJoin_Fraudpoint3__Key_Phone;
		self.DoFDCJoin_Fraudpoint3__Key_SSN:=DoFDCJoin_Fraudpoint3__Key_SSN;
		self.DoFDCJoin_Gong__Key_History_Address:=DoFDCJoin_Gong__Key_History_Address;
		self.DoFDCJoin_Gong__Key_History_DID:=DoFDCJoin_Gong__Key_History_DID;
		self.DoFDCJoin_Gong__Key_History_LinkIds:=DoFDCJoin_Gong__Key_History_LinkIds;
		self.DoFDCJoin_Gong__Key_History_Phone:=DoFDCJoin_Gong__Key_History_Phone;
		self.DoFDCJoin_GovData__kfetch_IRS_NonProfit_linkIDs:=DoFDCJoin_GovData__kfetch_IRS_NonProfit_linkIDs;
		self.DoFDCJoin_Header__Key_Addr_Hist:=DoFDCJoin_Header__Key_Addr_Hist;
		self.DoFDCJoin_Header__key_ADL_segmentation:=DoFDCJoin_Header__key_ADL_segmentation;
		self.DoFDCJoin_HighRiskAddress:=DoFDCJoin_HighRiskAddress;
		self.DoFDCJoin_HighRiskPhone:=DoFDCJoin_HighRiskPhone;
		self.DoFDCJoin_Infutor__NARB_kfetch_LinkIds:=DoFDCJoin_Infutor__NARB_kfetch_LinkIds;
		self.DoFDCJoin_InfutorCID__Key_Infutor_Phone:=DoFDCJoin_InfutorCID__Key_Infutor_Phone;
		self.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_Address:=DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_Address;
		self.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_DID:=DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_DID;
		self.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_EMAIL:=DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_EMAIL;
		self.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_FEIN:=DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_FEIN;
		self.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_LinkIDs:=DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_LinkIDs;
		self.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_Phone:=DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_Phone;
		self.DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_SSN:=DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_SSN;
		self.DoFDCJoin_Inquiry_AccLogs__Key_Address_FCRA:=DoFDCJoin_Inquiry_AccLogs__Key_Address_FCRA;
		self.DoFDCJoin_Inquiry_AccLogs__Key_DID_FCRA:=DoFDCJoin_Inquiry_AccLogs__Key_DID_FCRA;
		self.DoFDCJoin_Inquiry_AccLogs__Key_Phone_FCRA:=DoFDCJoin_Inquiry_AccLogs__Key_Phone_FCRA;
		self.DoFDCJoin_Inquiry_AccLogs__Key_SSN_FCRA:=DoFDCJoin_Inquiry_AccLogs__Key_SSN_FCRA;
		self.DoFDCJoin_IRS5500__kfetch_LinkIDs:=DoFDCJoin_IRS5500__kfetch_LinkIDs;
		self.DoFDCJoin_Key_SexOffender:=DoFDCJoin_Key_SexOffender;
		self.DoFDCJoin_LiensV2_key_liens:=DoFDCJoin_LiensV2_key_liens;
		self.DoFDCJoin_LiensV2_Key_party_Linkids_Records:=DoFDCJoin_LiensV2_Key_party_Linkids_Records;
		self.DoFDCJoin_OSHAIR__kfetch_OSHAIR_LinkIds:=DoFDCJoin_OSHAIR__kfetch_OSHAIR_LinkIds;
		self.DoFDCJoin_PhoneInfo__Key_Phone_Transaction:=DoFDCJoin_PhoneInfo__Key_Phone_Transaction;
		self.DoFDCJoin_PhoneInfo__Key_Phone_Type:=DoFDCJoin_PhoneInfo__Key_Phone_Type;
		self.DoFDCJoin_PhonePlus_V2__Iverification_Did_Phone:=DoFDCJoin_PhonePlus_V2__Iverification_Did_Phone;
		self.DoFDCJoin_PhonePlus_V2__Iverification_Phone:=DoFDCJoin_PhonePlus_V2__Iverification_Phone;
		self.DoFDCJoin_PhonePlus_V2__Key_Source_Level_Payload_did:=DoFDCJoin_PhonePlus_V2__Key_Source_Level_Payload_did;
		self.DoFDCJoin_PhonePlus_V2__Key_Source_Level_Payload_phone:=DoFDCJoin_PhonePlus_V2__Key_Source_Level_Payload_phone;
		self.DoFDCJoin_Prof_License_Mari__Key_Did:=DoFDCJoin_Prof_License_Mari__Key_Did;
		self.DoFDCJoin_Prof_LicenseV2__Key_Proflic_Did:=DoFDCJoin_Prof_LicenseV2__Key_Proflic_Did;
		self.DoFDCJoin_Property__Key_Foreclosure_FID:=DoFDCJoin_Property__Key_Foreclosure_FID;
		self.DoFDCJoin_PropertyV2__Key_Addr_Fid:=DoFDCJoin_PropertyV2__Key_Addr_Fid;
		self.DoFDCJoin_PropertyV2__Key_Assessor_Fid:=DoFDCJoin_PropertyV2__Key_Assessor_Fid;
		self.DoFDCJoin_PropertyV2__Key_Deed_Fid:=DoFDCJoin_PropertyV2__Key_Deed_Fid;
		self.DoFDCJoin_PropertyV2__Key_Linkids_Key:=DoFDCJoin_PropertyV2__Key_Linkids_Key;
		self.DoFDCJoin_PropertyV2__Key_Property_Did:=DoFDCJoin_PropertyV2__Key_Property_Did;
		self.DoFDCJoin_Quick_Header__key_wild_SSN:=DoFDCJoin_Quick_Header__key_wild_SSN;
		self.DoFDCJoin_Relatives__Key_Relatives_v3:=DoFDCJoin_Relatives__Key_Relatives_v3;
		self.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_addr_dob_summary:=DoFDCJoin_Risk_Indicators__Correlation_Risk__key_addr_dob_summary;
		self.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_addr_name_summary:=DoFDCJoin_Risk_Indicators__Correlation_Risk__key_addr_name_summary;
		self.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_name_dob_summary:=DoFDCJoin_Risk_Indicators__Correlation_Risk__key_name_dob_summary;
		self.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_addr_header_summary:=DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_addr_header_summary;
		self.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_addr_summary:=DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_addr_summary;
		self.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_dob_summary:=DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_dob_summary;
		self.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_lname_header_summary:=DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_lname_header_summary;
		self.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_lname_summary:=DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_lname_summary;
		self.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_ssn_addr_summary:=DoFDCJoin_Risk_Indicators__Correlation_Risk__key_ssn_addr_summary;
		self.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_ssn_dob_summary:=DoFDCJoin_Risk_Indicators__Correlation_Risk__key_ssn_dob_summary;
		self.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_ssn_name_summary:=DoFDCJoin_Risk_Indicators__Correlation_Risk__key_ssn_name_summary;
		self.DoFDCJoin_Risk_Indicators__Correlation_Risk__key_ssn_phone_summary:=DoFDCJoin_Risk_Indicators__Correlation_Risk__key_ssn_phone_summary;
		self.DoFDCJoin_RiskWise__Key_CityStZip:=DoFDCJoin_RiskWise__Key_CityStZip;
		self.DoFDCJoin_SAM__kfetch_linkID:=DoFDCJoin_SAM__kfetch_linkID;
		self.DoFDCJoin_Targus__Key_Targus_Phone:=DoFDCJoin_Targus__Key_Targus_Phone;
		self.DoFDCJoin_Thrive__Key_did_QA:=DoFDCJoin_Thrive__Key_did_QA;
		self.DoFDCJoin_Tradeline_Files__Tradeline__Key_LinkIds:=DoFDCJoin_Tradeline_Files__Tradeline__Key_LinkIds;
		self.DoFDCJoin_UCC_Files__Key_Linkids:=DoFDCJoin_UCC_Files__Key_Linkids;
		self.DoFDCJoin_USPIS_HotList__key_addr_search_zip:=DoFDCJoin_USPIS_HotList__key_addr_search_zip;
		self.DoFDCJoin_UtilFile__Key_Address:=DoFDCJoin_UtilFile__Key_Address;
		self.DoFDCJoin_UtilFile__Key_DID:=DoFDCJoin_UtilFile__Key_DID;
		self.DoFDCJoin_UtilFile__Key_LinkIds:=DoFDCJoin_UtilFile__Key_LinkIds;
		self.DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_DID:=DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_DID;
		self.DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_LinkID:=DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_LinkID;
		self.DoFDCJoin_Watercraft_Files__Watercraft:=DoFDCJoin_Watercraft_Files__Watercraft;
		self.DoFDCJoin_Watercraft_Files__Watercraft_LinkId:=DoFDCJoin_Watercraft_Files__Watercraft_LinkId;
		self.DoFDCJoin_YellowPages__kfetch_yellowpages_linkids:=DoFDCJoin_YellowPages__kfetch_yellowpages_linkids;
		self.DoFDCJoinfn_FLAccidents_Ecrash__key_Ecrash:=DoFDCJoinfn_FLAccidents_Ecrash__key_Ecrash;
		self.DoFDCJoinfn_FLAccidents_Ecrash__key_Ecrash_accnbr:=DoFDCJoinfn_FLAccidents_Ecrash__key_Ecrash_accnbr;
		self.DoFDCJoinfn_IndexedSearchForXLinkIDs:=DoFDCJoinfn_IndexedSearchForXLinkIDs;
		self.DoFDCJoinfn_IncludeOverrides:=DoFDCJoinfn_IncludeOverrides;

		SELF := [];
END;

soap_in := PROJECT(pp, trans_pre(LEFT, Counter));

OUTPUT(CHOOSEN(p_in, eyeball), NAMED('Sample_Input'));
OUTPUT(CHOOSEN(soap_in, eyeball), NAMED('Sample_SOAPInput'));

OutputFDC := {recordof(PublicRecords_KEL.ECL_Functions.Layouts_FDC(m.Options).Layout_FDC)};

layout_FDC_Service := RECORD
		OutputFDC;
		STRING ErrorCode;
END;
	
layout_FDC_Service myFail(soap_in le) := TRANSFORM

	SELF.ErrorCode := (FAILCODE + ' ' + FAILMESSAGE);
		SELF := [];
END;

bwr_results := 
				SOAPCALL(soap_in, 
				RoxieIP,
				'PublicRecords_KEL.MAS_nonFCRA_FDC_Proddata_Service', 
				{soap_in}, 
				DATASET(layout_FDC_Service),
				// XPATH('*'),
        RETRY(2), TIMEOUT(300),
				PARALLEL(threads), 
        onFail(myFail(LEFT)));

output(bwr_results, named('soap_out'));

Passed := bwr_results(TRIM(ErrorCode) = ''); // Use as input to KEL query.
Failed := bwr_results(TRIM(ErrorCode) <> '');

output(choosen(Failed, 25), named('Failed_Results'));
output(count(failed), named('Failed_Count'));

OUTPUT(Passed,,OutputFile, Thor, overwrite, expire(45));