/*--SOAP--
<message name="MAS_Business_nonFCRA_Service">
	<part name="input" type="tns:XmlDataSet" cols="100" rows="8"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="GLBPurpose" type="xsd:integer"/>
	<part name="DPPAPurpose" type="xsd:integer"/>
	<part name="IsMarketing" type="xsd:boolean"/>
	<part name="TurnOffHouseHolds" type="xsd:boolean"/>
	<part name="TurnOffRelatives" type="xsd:boolean"/>
	<part name="UseIngestDate" type="xsd:boolean"/>
	<part name="AllowedSourcesDataset" type="tns:XmlDataSet" cols="100" rows="8"/>
	<part name="ExcludeSourcesDataset" type="tns:XmlDataSet" cols="100" rows="8"/>
	<part name="LexIdSourceOptout" type="xsd:integer"/>

	<part name="Include__ADVO__Key_Addr1_History" type="xsd:boolean"/>
	<part name="Include__Aircraft_Files__FAA__Aircraft" type="xsd:boolean"/>
	<part name="Include__Aircraft_Files__FAA__Aircraft_linkids" type="xsd:boolean"/>
	<part name="Include__AlloyMedia_student_list__key_DID" type="xsd:boolean"/>
	<part name="Include__American_student_list__key_DID" type="xsd:boolean"/>
	<part name="Include__AVM_V2__Key_AVM_Address" type="xsd:boolean"/>
	<part name="Include__AVM_V2__Key_AVM_Medians" type="xsd:boolean"/>
	<part name="Include__Bankruptcy_Files__Bankruptcy__Linkid_Key_Search" type="xsd:boolean"/>
	<part name="Include__Bankruptcy_Files__Key_bankruptcy_did" type="xsd:boolean"/>
	<part name="Include__BBB2__kfetch_BBB_LinkIds" type="xsd:boolean"/>
	<part name="Include__BBB2__kfetch_BBB_Non_Member_LinkIds" type="xsd:boolean"/>
	<part name="Include__Best_Person__Key_Watchdog" type="xsd:boolean"/>
	<part name="Include__BIPV2_Best__Key_LinkIds" type="xsd:boolean"/>
	<part name="Include__BIPV2_Build__kfetch_contact_linkids" type="xsd:boolean"/>
	<part name="Include__BIPV2_Build__kfetch_contact_linkids_slim" type="xsd:boolean"/>
	<part name="Include__Business_Files__Business__Key_BH_Linking_Ids" type="xsd:boolean"/>
	<part name="Include__Business_Files__Business__Key_BH_Linking_Ids_extra" type="xsd:boolean"/>
	<part name="Include__BusReg__kfetch_busreg_company_linkids" type="xsd:boolean"/>
	<part name="Include__CalBus__kfetch_Calbus_LinkIDS" type="xsd:boolean"/>
	<part name="Include__CellPhone__Key_Nustar_Phone" type="xsd:boolean"/>
	<part name="Include__Certegy__Key_Certegy_DID" type="xsd:boolean"/>
	<part name="Include__Corp2__Key_LinkIDs_Corp" type="xsd:boolean"/>
	<part name="Include__Cortera__kfetch_LinkID" type="xsd:boolean"/>
	<part name="Include__DCAV2__kfetch_LinkIds" type="xsd:boolean"/>
	<part name="Include__DeathMaster__Key_SSN_SSA" type="xsd:boolean"/>
	<part name="Include__DMA__Key_DNM_Name_Address" type="xsd:boolean"/>
	<part name="Include__Doxie__Key_Death_MasterV2_SSA_DID" type="xsd:boolean"/>
	<part name="Include__Doxie__Key_Header" type="xsd:boolean"/>
	<part name="Include__Doxie__Key_Header_Address" type="xsd:boolean"/>
	<part name="Include__Doxie__Key_Header_ingest_date" type="xsd:boolean"/>
	<part name="Include__Doxie_Files__Key_Offenders" type="xsd:boolean"/>
	<part name="Include__Doxie_Files__Key_Offenders_Risk" type="xsd:boolean"/>
	<part name="Include__DriversV2__Key_DL_DID" type="xsd:boolean"/>
	<part name="Include__DriversV2__Key_DL_Number" type="xsd:boolean"/>
	<part name="Include__dx_CFPB__key_BLKGRP" type="xsd:boolean"/>
	<part name="Include__dx_CFPB__key_BLKGRP_over18" type="xsd:boolean"/>
	<part name="Include__dx_CFPB__key_Census_Surnames" type="xsd:boolean"/>
	<part name="Include__dx_DataBridge__Key_LinkIds" type="xsd:boolean"/>
	<part name="Include__dx_Header__key_did_hhid" type="xsd:boolean"/>
	<part name="Include__Dx_Header__key_wild_phone" type="xsd:boolean"/>
	<part name="Include__Dx_Header__key_wild_SSN" type="xsd:boolean"/>
	<part name="Include__EBR__Key_0010_Header_linkids" type="xsd:boolean"/>
	<part name="Include__EBR__Key_2015_Trade_Payment_Totals_FILE_NUMBER" type="xsd:boolean"/>
	<part name="Include__EBR_kfetch_5600_Demographic_Data_linkids" type="xsd:boolean"/>
	<part name="Include__Email_Data__Key_did" type="xsd:boolean"/>
	<part name="Include__Email_Data__Key_Did_FCRA" type="xsd:boolean"/>
	<part name="Include__Email_Data__Key_Email_Address" type="xsd:boolean"/>
	<part name="Include__eMerges__key_ccw_rid" type="xsd:boolean"/>
	<part name="Include__eMerges__Key_HuntFish_Rid" type="xsd:boolean"/>
	<part name="Include__Equifax_Business_Data__kfetch_LinkIDs" type="xsd:boolean"/>
	<part name="Include__Experian_CRDB__Key_LinkIDs" type="xsd:boolean"/>
	<part name="Include__FBNv2__kfetch_LinkIds" type="xsd:boolean"/>
	<part name="Include__Fraudpoint3__Key_Address" type="xsd:boolean"/>
	<part name="Include__fraudpoint3__Key_DID" type="xsd:boolean"/>
	<part name="Include__Fraudpoint3__Key_Phone" type="xsd:boolean"/>
	<part name="Include__Fraudpoint3__Key_SSN" type="xsd:boolean"/>
	<part name="Include__Gong__Key_History_Address" type="xsd:boolean"/>
	<part name="Include__Gong__Key_History_DID" type="xsd:boolean"/>
	<part name="Include__Gong__Key_History_LinkIds" type="xsd:boolean"/>
	<part name="Include__Gong__Key_History_Phone" type="xsd:boolean"/>
	<part name="Include__GovData__kfetch_IRS_NonProfit_linkIDs" type="xsd:boolean"/>
	<part name="Include__Header__Key_Addr_Hist" type="xsd:boolean"/>
	<part name="Include__Header__key_ADL_segmentation" type="xsd:boolean"/>
	<part name="Include__HighRiskAddress" type="xsd:boolean"/>
	<part name="Include__HighRiskPhone" type="xsd:boolean"/>
	<part name="Include__Infutor__NARB_kfetch_LinkIds" type="xsd:boolean"/>
	<part name="Include__InfutorCID__Key_Infutor_Phone" type="xsd:boolean"/>
	<part name="Include__Inquiry_AccLogs__Inquiry_Table_Address" type="xsd:boolean"/>
	<part name="Include__Inquiry_AccLogs__Inquiry_Table_DID" type="xsd:boolean"/>
	<part name="Include__Inquiry_AccLogs__Inquiry_Table_EMAIL" type="xsd:boolean"/>
	<part name="Include__Inquiry_AccLogs__Inquiry_Table_FEIN" type="xsd:boolean"/>
	<part name="Include__Inquiry_AccLogs__Inquiry_Table_LinkIDs" type="xsd:boolean"/>
	<part name="Include__Inquiry_AccLogs__Inquiry_Table_Phone" type="xsd:boolean"/>
	<part name="Include__Inquiry_AccLogs__Inquiry_Table_SSN" type="xsd:boolean"/>
	<part name="Include__Inquiry_AccLogs__Key_Address_FCRA" type="xsd:boolean"/>
	<part name="Include__Inquiry_AccLogs__Key_DID_FCRA" type="xsd:boolean"/>
	<part name="Include__Inquiry_AccLogs__Key_Phone_FCRA" type="xsd:boolean"/>
	<part name="Include__Inquiry_AccLogs__Key_SSN_FCRA" type="xsd:boolean"/>
	<part name="Include__IRS5500__kfetch_LinkIDs" type="xsd:boolean"/>
	<part name="Include__Key_SexOffender" type="xsd:boolean"/>
	<part name="Include__LiensV2_key_liens" type="xsd:boolean"/>
	<part name="Include__LiensV2_Key_party_Linkids_Records" type="xsd:boolean"/>
	<part name="Include__OSHAIR__kfetch_OSHAIR_LinkIds" type="xsd:boolean"/>
	<part name="Include__PhoneInfo__Key_Phone_Transaction" type="xsd:boolean"/>
	<part name="Include__PhoneInfo__Key_Phone_Type" type="xsd:boolean"/>
	<part name="Include__PhonePlus_V2__Iverification_Did_Phone" type="xsd:boolean"/>
	<part name="Include__PhonePlus_V2__Iverification_Phone" type="xsd:boolean"/>
	<part name="Include__PhonePlus_V2__Key_Source_Level_Payload_did" type="xsd:boolean"/>
	<part name="Include__PhonePlus_V2__Key_Source_Level_Payload_phone" type="xsd:boolean"/>
	<part name="Include__Prof_License_Mari__Key_Did" type="xsd:boolean"/>
	<part name="Include__Prof_LicenseV2__Key_Proflic_Did" type="xsd:boolean"/>
	<part name="Include__Property__Key_Foreclosure_FID" type="xsd:boolean"/>
	<part name="Include__PropertyV2__Key_Addr_Fid" type="xsd:boolean"/>
	<part name="Include__PropertyV2__Key_Assessor_Fid" type="xsd:boolean"/>
	<part name="Include__PropertyV2__Key_Deed_Fid" type="xsd:boolean"/>
	<part name="Include__PropertyV2__Key_Linkids_Key" type="xsd:boolean"/>
	<part name="Include__PropertyV2__Key_Property_Did" type="xsd:boolean"/>
	<part name="Include__Quick_Header__key_wild_SSN" type="xsd:boolean"/>
	<part name="Include__Relatives__Key_Relatives_v3" type="xsd:boolean"/>
	<part name="Include__Risk_Indicators__Correlation_Risk__key_addr_dob_summary" type="xsd:boolean"/>
	<part name="Include__Risk_Indicators__Correlation_Risk__key_addr_name_summary" type="xsd:boolean"/>
	<part name="Include__Risk_Indicators__Correlation_Risk__key_name_dob_summary" type="xsd:boolean"/>
	<part name="Include__Risk_Indicators__Correlation_Risk__key_phone_addr_header_summary" type="xsd:boolean"/>
	<part name="Include__Risk_Indicators__Correlation_Risk__key_phone_addr_summary" type="xsd:boolean"/>
	<part name="Include__Risk_Indicators__Correlation_Risk__key_phone_dob_summary" type="xsd:boolean"/>
	<part name="Include__Risk_Indicators__Correlation_Risk__key_phone_lname_header_summary" type="xsd:boolean"/>
	<part name="Include__Risk_Indicators__Correlation_Risk__key_phone_lname_summary" type="xsd:boolean"/>
	<part name="Include__Risk_Indicators__Correlation_Risk__key_ssn_addr_summary" type="xsd:boolean"/>
	<part name="Include__Risk_Indicators__Correlation_Risk__key_ssn_dob_summary" type="xsd:boolean"/>
	<part name="Include__Risk_Indicators__Correlation_Risk__key_ssn_name_summary" type="xsd:boolean"/>
	<part name="Include__Risk_Indicators__Correlation_Risk__key_ssn_phone_summary" type="xsd:boolean"/>
	<part name="Include__RiskWise__Key_CityStZip" type="xsd:boolean"/>
	<part name="Include__SAM__kfetch_linkID" type="xsd:boolean"/>
	<part name="Include__Targus__Key_Targus_Phone" type="xsd:boolean"/>
	<part name="Include__Thrive__Key_did_QA" type="xsd:boolean"/>
	<part name="Include__Tradeline_Files__Tradeline__Key_LinkIds" type="xsd:boolean"/>
	<part name="Include__UCC_Files__Key_Linkids" type="xsd:boolean"/>
	<part name="Include__USPIS_HotList__key_addr_search_zip" type="xsd:boolean"/>
	<part name="Include__UtilFile__Key_Address" type="xsd:boolean"/>
	<part name="Include__UtilFile__Key_DID" type="xsd:boolean"/>
	<part name="Include__UtilFile__Key_LinkIds" type="xsd:boolean"/>
	<part name="Include__Vehicle_Files__VehicleV2__Vehicle_DID" type="xsd:boolean"/>
	<part name="Include__Vehicle_Files__VehicleV2__Vehicle_LinkID" type="xsd:boolean"/>
	<part name="Include__Watercraft_Files__Watercraft" type="xsd:boolean"/>
	<part name="Include__Watercraft_Files__Watercraft_LinkId" type="xsd:boolean"/>
	<part name="Include__YellowPages__kfetch_yellowpages_linkids" type="xsd:boolean"/>
	<part name="Include_fn_FLAccidents_Ecrash__key_Ecrash" type="xsd:boolean"/>
	<part name="Include_fn_FLAccidents_Ecrash__key_Ecrash_accnbr" type="xsd:boolean"/>
	<part name="Include_fn_IndexedSearchForXLinkIDs" type="xsd:boolean"/>
	<part name="Include_fn_IncludeOverrides" type="xsd:boolean"/>


</message>
*/

IMPORT Std, PublicRecords_KEL;

export MAS_nonFCRA_FDC_Proddata_Service() := MACRO
	IMPORT KEL11 AS KEL;

	#WEBSERVICE(FIELDS(
    'input',
    'InputArchiveDateClean',
    'DataRestrictionMask',
    'DataPermissionMask',
    'GLBA',
    'DPPA',
		'AllowedSourcesDataset',
		'ExcludeSourcesDataset',
		'LexIdSourceOptout',
		'ViewFDC',
		'IsMarketing',
		'TurnOffHouseHolds',
		'TurnOffRelatives',
		'UseIngestDate',
		'Include__ADVO__Key_Addr1_History',
		'Include__Aircraft_Files__FAA__Aircraft',
		'Include__Aircraft_Files__FAA__Aircraft_linkids',
		'Include__AlloyMedia_student_list__key_DID',
		'Include__American_student_list__key_DID',
		'Include__AVM_V2__Key_AVM_Address',
		'Include__AVM_V2__Key_AVM_Medians',
		'Include__Bankruptcy_Files__Bankruptcy__Linkid_Key_Search',
		'Include__Bankruptcy_Files__Key_bankruptcy_did',
		'Include__BBB2__kfetch_BBB_LinkIds',
		'Include__BBB2__kfetch_BBB_Non_Member_LinkIds',
		'Include__Best_Person__Key_Watchdog',
		'Include__BIPV2_Best__Key_LinkIds',
		'Include__BIPV2_Build__kfetch_contact_linkids',
		'Include__BIPV2_Build__kfetch_contact_linkids_slim',
		'Include__Business_Files__Business__Key_BH_Linking_Ids',
		'Include__Business_Files__Business__Key_BH_Linking_Ids_extra',
		'Include__BusReg__kfetch_busreg_company_linkids',
		'Include__CalBus__kfetch_Calbus_LinkIDS',
		'Include__CellPhone__Key_Nustar_Phone',
		'Include__Certegy__Key_Certegy_DID',
		'Include__Corp2__Key_LinkIDs_Corp',
		'Include__Cortera__kfetch_LinkID',
		'Include__DCAV2__kfetch_LinkIds',
		'Include__DeathMaster__Key_SSN_SSA',
		'Include__DMA__Key_DNM_Name_Address',
		'Include__Doxie__Key_Death_MasterV2_SSA_DID',
		'Include__Doxie__Key_Header',
		'Include__Doxie__Key_Header_Address',
		'Include__Doxie__Key_Header_ingest_date',
		'Include__Doxie_Files__Key_Offenders',
		'Include__Doxie_Files__Key_Offenders_Risk',
		'Include__DriversV2__Key_DL_DID',
		'Include__DriversV2__Key_DL_Number',
		'Include__dx_CFPB__key_BLKGRP',
		'Include__dx_CFPB__key_BLKGRP_over18',
		'Include__dx_CFPB__key_Census_Surnames',
		'Include__dx_DataBridge__Key_LinkIds',
		'Include__dx_Header__key_did_hhid',
		'Include__Dx_Header__key_wild_phone',
		'Include__Dx_Header__key_wild_SSN',
		'Include__EBR__Key_0010_Header_linkids',
		'Include__EBR__Key_2015_Trade_Payment_Totals_FILE_NUMBER',
		'Include__EBR_kfetch_5600_Demographic_Data_linkids',
		'Include__Email_Data__Key_did',
		'Include__Email_Data__Key_Did_FCRA',
		'Include__Email_Data__Key_Email_Address',
		'Include__eMerges__key_ccw_rid',
		'Include__eMerges__Key_HuntFish_Rid',
		'Include__Equifax_Business_Data__kfetch_LinkIDs',
		'Include__Experian_CRDB__Key_LinkIDs',
		'Include__FBNv2__kfetch_LinkIds',
		'Include__Fraudpoint3__Key_Address',
		'Include__fraudpoint3__Key_DID',
		'Include__Fraudpoint3__Key_Phone',
		'Include__Fraudpoint3__Key_SSN',
		'Include__Gong__Key_History_Address',
		'Include__Gong__Key_History_DID',
		'Include__Gong__Key_History_LinkIds',
		'Include__Gong__Key_History_Phone',
		'Include__GovData__kfetch_IRS_NonProfit_linkIDs',
		'Include__Header__Key_Addr_Hist',
		'Include__Header__key_ADL_segmentation',
		'Include__HighRiskAddress',
		'Include__HighRiskPhone',
		'Include__Infutor__NARB_kfetch_LinkIds',
		'Include__InfutorCID__Key_Infutor_Phone',
		'Include__Inquiry_AccLogs__Inquiry_Table_Address',
		'Include__Inquiry_AccLogs__Inquiry_Table_DID',
		'Include__Inquiry_AccLogs__Inquiry_Table_EMAIL',
		'Include__Inquiry_AccLogs__Inquiry_Table_FEIN',
		'Include__Inquiry_AccLogs__Inquiry_Table_LinkIDs',
		'Include__Inquiry_AccLogs__Inquiry_Table_Phone',
		'Include__Inquiry_AccLogs__Inquiry_Table_SSN',
		'Include__Inquiry_AccLogs__Key_Address_FCRA',
		'Include__Inquiry_AccLogs__Key_DID_FCRA',
		'Include__Inquiry_AccLogs__Key_Phone_FCRA',
		'Include__Inquiry_AccLogs__Key_SSN_FCRA',
		'Include__IRS5500__kfetch_LinkIDs',
		'Include__LiensV2_key_liens',
		'Include__LiensV2_Key_party_Linkids_Records',
		'Include__OSHAIR__kfetch_OSHAIR_LinkIds',
		'Include__PhoneInfo__Key_Phone_Transaction',
		'Include__PhoneInfo__Key_Phone_Type',
		'Include__PhonePlus_V2__Iverification_Did_Phone',
		'Include__PhonePlus_V2__Iverification_Phone',
		'Include__PhonePlus_V2__Key_Source_Level_Payload_did',
		'Include__PhonePlus_V2__Key_Source_Level_Payload_phone',
		'Include__Prof_License_Mari__Key_Did',
		'Include__Prof_LicenseV2__Key_Proflic_Did',
		'Include__Property__Key_Foreclosure_FID',
		'Include__PropertyV2__Key_Addr_Fid',
		'Include__PropertyV2__Key_Assessor_Fid',
		'Include__PropertyV2__Key_Deed_Fid',
		'Include__PropertyV2__Key_Linkids_Key',
		'Include__PropertyV2__Key_Property_Did',
		'Include__Quick_Header__key_wild_SSN',
		'Include__Relatives__Key_Relatives_v3',
		'Include__Risk_Indicators__Correlation_Risk__key_addr_dob_summary',
		'Include__Risk_Indicators__Correlation_Risk__key_addr_name_summary',
		'Include__Risk_Indicators__Correlation_Risk__key_name_dob_summary',
		'Include__Risk_Indicators__Correlation_Risk__key_phone_addr_header_summary',
		'Include__Risk_Indicators__Correlation_Risk__key_phone_addr_summary',
		'Include__Risk_Indicators__Correlation_Risk__key_phone_dob_summary',
		'Include__Risk_Indicators__Correlation_Risk__key_phone_lname_header_summary',
		'Include__Risk_Indicators__Correlation_Risk__key_phone_lname_summary',
		'Include__Risk_Indicators__Correlation_Risk__key_ssn_addr_summary',
		'Include__Risk_Indicators__Correlation_Risk__key_ssn_dob_summary',
		'Include__Risk_Indicators__Correlation_Risk__key_ssn_name_summary',
		'Include__Risk_Indicators__Correlation_Risk__key_ssn_phone_summary',
		'Include__RiskWise__Key_CityStZip',
		'Include__SAM__kfetch_linkID',
		'Include__Targus__Key_Targus_Phone',
		'Include__Thrive__Key_did_QA',
		'Include__Tradeline_Files__Tradeline__Key_LinkIds',
		'Include__UCC_Files__Key_Linkids',
		'Include__USPIS_HotList__key_addr_search_zip',
		'Include__UtilFile__Key_Address',
		'Include__UtilFile__Key_DID',
		'Include__UtilFile__Key_LinkIds',
		'Include__Vehicle_Files__VehicleV2__Vehicle_DID',
		'Include__Vehicle_Files__VehicleV2__Vehicle_LinkID',
		'Include__Watercraft_Files__Watercraft',
		'Include__Watercraft_Files__Watercraft_LinkId',
		'Include__YellowPages__kfetch_yellowpages_linkids',
		'Include_fn_FLAccidents_Ecrash__key_Ecrash',
		'Include_fn_FLAccidents_Ecrash__key_Ecrash_accnbr',
		'Include_fn_IndexedSearchForXLinkIDs'


  ));
		STRING100 Default_data_permission_mask := '11111111111111111111111111111111111111111111111111';	
		#stored('DataPermissionMask',Default_data_permission_mask);

		STRING100 Default_data_restriction_mask := '00000000000000000000000000000000000000000000000000';	
		#stored('DataRestrictionMask',Default_data_restriction_mask);

		layout_input_combined := RECORD
			PublicRecords_KEL.ECL_Functions.Input_Layout;
			PublicRecords_KEL.ECL_Functions.Input_Bus_Layout;
		END;

		UNSIGNED1 _LexIdSourceOptout := 1 : STORED ('LexIdSourceOptout');


		ds_input := DATASET([],layout_input_combined) : STORED('input');
		

		is_fcra := FALSE;

		BOOLEAN ViewFDC := FALSE : STORED('ViewFDC');
		STD.Date.Date_t dtArchiveDate := STD.Date.Today() : STORED('InputArchiveDateClean');
		#CONSTANT('IsFCRA', FALSE);

	BOOLEAN IsInsuranceProduct := FALSE : STORED('IsInsuranceProduct');
	BOOLEAN AllowDNBDMI        := FALSE : STORED('AllowDNBDMI');
	STRING100 DataRestrictionMask      := Default_data_restriction_mask : STORED('DataRestrictionMask');
	STRING100 DataPermissionMask       := Default_data_permission_mask : STORED('DataPermissionMask');
	UNSIGNED GLBA              := 1 : STORED('GLBA');
	UNSIGNED DPPA              := 2 : STORED('DPPA');
	BOOLEAN is_Marketing               := FALSE : STORED('IsMarketing');
	BOOLEAN Turn_Off_Relatives               := FALSE : STORED('TurnOffRelatives');
	BOOLEAN Turn_Off_HouseHolds               := FALSE : STORED('TurnOffHouseHolds');
	BOOLEAN Use_Ingest_Date               := FALSE : STORED('UseIngestDate');
	BOOLEAN OverrideExperianRestriction := FALSE : STORED('OverrideExperianRestriction');
	AllowedSourcesDataset := DATASET([],PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources) : STORED('AllowedSourcesDataset');
	ExcludeSourcesDataset := DATASET([],PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources) : STORED('ExcludeSourcesDataset');
	// If allowed sources aren't passed in, use default list of allowed sources
	SetAllowedSources := IF(COUNT(AllowedSourcesDataset) = 0, PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_ALLOWED_SOURCES_NONFCRA, AllowedSourcesDataset);
	// If a source is on the Exclude list, remove it from the allowed sources list. 
	FinalAllowedSources := JOIN(SetAllowedSources, ExcludeSourcesDataset, LEFT=RIGHT, TRANSFORM(RECORDOF(LEFT), SELF := LEFT), LEFT ONLY);
	
	Options := MODULE(PublicRecords_KEL.Interface_Options)
		EXPORT STRING100 AttributeSetName           := '';
		EXPORT STRING100 VersionName                := '';
		EXPORT BOOLEAN isFCRA                   		 := is_fcra;
		EXPORT STRING8 ArchiveDate               		 := (STRING)dtArchiveDate;
		EXPORT STRING250 InputFileName              := '';
		EXPORT STRING5 IndustryClass        					 := '';
		EXPORT UNSIGNED1 LexIdSourceOptout := _LexIdSourceOptout;
		EXPORT STRING100 Data_Restriction_Mask      := DataRestrictionMask;
		EXPORT STRING100 Data_Permission_Mask       := DataPermissionMask;
		EXPORT UNSIGNED GLBAPurpose              := GLBA;
		EXPORT UNSIGNED DPPAPurpose              := DPPA;
		EXPORT BOOLEAN Override_Experian_Restriction := OverrideExperianRestriction;
		EXPORT STRING100 Allowed_Sources            := '';
		EXPORT INTEGER ScoreThreshold            := 80 : STORED('ScoreThreshold');
		EXPORT BOOLEAN ExcludeConsumerShell      := FALSE;
		EXPORT BOOLEAN isMarketing               := is_Marketing;
		EXPORT BOOLEAN UseIngestDate               := Use_Ingest_Date;
		EXPORT BOOLEAN TurnOffRelatives := Turn_Off_Relatives; 
		EXPORT BOOLEAN TurnOffHouseHolds := Turn_Off_HouseHolds;
		EXPORT DATASET(PublicRecords_KEL.ECL_Functions.Constants.Layout_Allowed_Sources) Allowed_Sources_Dataset := FinalAllowedSources;
		EXPORT DATA57 KEL_Permissions_Mask    := PublicRecords_KEL.ECL_Functions.Fn_KEL_DPMBitmap.Generate(
				DataRestrictionMask, 
				DataPermissionMask, 
				GLBA, 
				DPPA, 
				is_fcra, 
				is_Marketing, 
				AllowDNBDMI, 
				OverrideExperianRestriction, 
				'', // IntendedPurpose
				'', // IndustryClass
				PublicRecords_KEL.KEL_Queries_MAS_Shared.C_Compile,
				IsInsuranceProduct,
				FinalAllowedSources);
				
		EXPORT BOOLEAN OutputMasterResults       := FALSE;
		EXPORT UNSIGNED BIPAppendScoreThreshold  := 75;
		EXPORT UNSIGNED BIPAppendWeightThreshold := 0;
		EXPORT BOOLEAN BIPAppendPrimForce        := FALSE;
		EXPORT BOOLEAN BIPAppendReAppend         := TRUE;
		EXPORT BOOLEAN BIPAppendIncludeAuthRep   := TRUE;

	END;	

	JoinOptions := MODULE(PublicRecords_KEL.Join_Interface_Options);
		EXPORT BOOLEAN DoFDCJoin_ADVO__Key_Addr1_History := False: STORED('Include__ADVO__Key_Addr1_History');
		EXPORT BOOLEAN DoFDCJoin_Aircraft_Files__FAA__Aircraft := False: STORED('Include__Aircraft_Files__FAA__Aircraft');
		EXPORT BOOLEAN DoFDCJoin_Aircraft_Files__FAA__Aircraft_linkids := False: STORED('Include__Aircraft_Files__FAA__Aircraft_linkids');
		EXPORT BOOLEAN DoFDCJoin_AlloyMedia_student_list__key_DID := False: STORED('Include__AlloyMedia_student_list__key_DID');
		EXPORT BOOLEAN DoFDCJoin_American_student_list__key_DID := False: STORED('Include__American_student_list__key_DID');
		EXPORT BOOLEAN DoFDCJoin_AVM_V2__Key_AVM_Address := False: STORED('Include__AVM_V2__Key_AVM_Address');
		EXPORT BOOLEAN DoFDCJoin_AVM_V2__Key_AVM_Medians := False: STORED('Include__AVM_V2__Key_AVM_Medians');
		EXPORT BOOLEAN DoFDCJoin_Bankruptcy_Files__Bankruptcy__Linkid_Key_Search := False: STORED('Include__Bankruptcy_Files__Bankruptcy__Linkid_Key_Search');
		EXPORT BOOLEAN DoFDCJoin_Bankruptcy_Files__Key_bankruptcy_did := False: STORED('Include__Bankruptcy_Files__Key_bankruptcy_did');
		EXPORT BOOLEAN DoFDCJoin_BBB2__kfetch_BBB_LinkIds := False: STORED('Include__BBB2__kfetch_BBB_LinkIds');
		EXPORT BOOLEAN DoFDCJoin_BBB2__kfetch_BBB_Non_Member_LinkIds := False: STORED('Include__BBB2__kfetch_BBB_Non_Member_LinkIds');
		EXPORT BOOLEAN DoFDCJoin_Best_Person__Key_Watchdog := False: STORED('Include__Best_Person__Key_Watchdog');
		EXPORT BOOLEAN DoFDCJoin_BIPV2_Best__Key_LinkIds := False: STORED('Include__BIPV2_Best__Key_LinkIds');
		EXPORT BOOLEAN DoFDCJoin_BIPV2_Build__kfetch_contact_linkids := False: STORED('Include__BIPV2_Build__kfetch_contact_linkids');
		EXPORT BOOLEAN DoFDCJoin_BIPV2_Build__kfetch_contact_linkids_slim   := False: STORED('Include__BIPV2_Build__kfetch_contact_linkids_slim');
		EXPORT BOOLEAN DoFDCJoin_Business_Files__Business__Key_BH_Linking_Ids := False: STORED('Include__Business_Files__Business__Key_BH_Linking_Ids');
		EXPORT BOOLEAN DoFDCJoin_Business_Files__Business__Key_BH_Linking_Ids_extra := False: STORED('Include__Business_Files__Business__Key_BH_Linking_Ids_extra');
		EXPORT BOOLEAN DoFDCJoin_BusReg__kfetch_busreg_company_linkids := False: STORED('Include__BusReg__kfetch_busreg_company_linkids');
		EXPORT BOOLEAN DoFDCJoin_CalBus__kfetch_Calbus_LinkIDS := False: STORED('Include__CalBus__kfetch_Calbus_LinkIDS');
		EXPORT BOOLEAN DoFDCJoin_CellPhone__Key_Nustar_Phone := False: STORED('Include__CellPhone__Key_Nustar_Phone');
		EXPORT BOOLEAN DoFDCJoin_Certegy__Key_Certegy_DID := False: STORED('Include__Certegy__Key_Certegy_DID');
		EXPORT BOOLEAN DoFDCJoin_Corp2__Key_LinkIDs_Corp := False: STORED('Include__Corp2__Key_LinkIDs_Corp');
		EXPORT BOOLEAN DoFDCJoin_Cortera__kfetch_LinkID := False: STORED('Include__Cortera__kfetch_LinkID');
		EXPORT BOOLEAN DoFDCJoin_DCAV2__kfetch_LinkIds := False: STORED('Include__DCAV2__kfetch_LinkIds');
		EXPORT BOOLEAN DoFDCJoin_DeathMaster__Key_SSN_SSA := False: STORED('Include__DeathMaster__Key_SSN_SSA');
		EXPORT BOOLEAN DoFDCJoin_DMA__Key_DNM_Name_Address := False: STORED('Include__DMA__Key_DNM_Name_Address');
		EXPORT BOOLEAN DoFDCJoin_Doxie__Key_Death_MasterV2_SSA_DID := False: STORED('Include__Doxie__Key_Death_MasterV2_SSA_DID');
		EXPORT BOOLEAN DoFDCJoin_Doxie__Key_Header := False: STORED('Include__Doxie__Key_Header');
		EXPORT BOOLEAN DoFDCJoin_Doxie__Key_Header_Address := False: STORED('Include__Doxie__Key_Header_Address');
		EXPORT BOOLEAN DoFDCJoin_Doxie__Key_Header_ingest_date := False: STORED('Include__Doxie__Key_Header_ingest_date');
		EXPORT BOOLEAN DoFDCJoin_Doxie_Files__Key_Offenders := False: STORED('Include__Doxie_Files__Key_Offenders');
		EXPORT BOOLEAN DoFDCJoin_Doxie_Files__Key_Offenders_Risk := False: STORED('Include__Doxie_Files__Key_Offenders_Risk');
		EXPORT BOOLEAN DoFDCJoin_DriversV2__Key_DL_DID := False: STORED('Include__DriversV2__Key_DL_DID');
		EXPORT BOOLEAN DoFDCJoin_DriversV2__Key_DL_Number := False: STORED('Include__DriversV2__Key_DL_Number');
		EXPORT BOOLEAN DoFDCJoin_dx_CFPB__key_BLKGRP := False: STORED('Include__dx_CFPB__key_BLKGRP');
		EXPORT BOOLEAN DoFDCJoin_dx_CFPB__key_BLKGRP_over18 := False: STORED('Include__dx_CFPB__key_BLKGRP_over18');
		EXPORT BOOLEAN DoFDCJoin_dx_CFPB__key_Census_Surnames := False: STORED('Include__dx_CFPB__key_Census_Surnames');
		EXPORT BOOLEAN DoFDCJoin_dx_DataBridge__Key_LinkIds := False: STORED('Include__dx_DataBridge__Key_LinkIds');
		EXPORT BOOLEAN DoFDCJoin_dx_Header__key_did_hhid := False: STORED('Include__dx_Header__key_did_hhid');
		EXPORT BOOLEAN DoFDCJoin_Dx_Header__key_wild_phone := False: STORED('Include__Dx_Header__key_wild_phone');
		EXPORT BOOLEAN DoFDCJoin_Dx_Header__key_wild_SSN := False: STORED('Include__Dx_Header__key_wild_SSN');
		EXPORT BOOLEAN DoFDCJoin_EBR__Key_0010_Header_linkids := False: STORED('Include__EBR__Key_0010_Header_linkids');
		EXPORT BOOLEAN DoFDCJoin_EBR__Key_2015_Trade_Payment_Totals_FILE_NUMBER   := False: STORED('Include__EBR__Key_2015_Trade_Payment_Totals_FILE_NUMBER');
		EXPORT BOOLEAN DoFDCJoin_EBR_kfetch_5600_Demographic_Data_linkids := False: STORED('Include__EBR_kfetch_5600_Demographic_Data_linkids');
		EXPORT BOOLEAN DoFDCJoin_Email_Data__Key_did := False: STORED('Include__Email_Data__Key_did');
		EXPORT BOOLEAN DoFDCJoin_Email_Data__Key_Did_FCRA := False: STORED('Include__Email_Data__Key_Did_FCRA');
		EXPORT BOOLEAN DoFDCJoin_Email_Data__Key_Email_Address := False: STORED('Include__Email_Data__Key_Email_Address');
		EXPORT BOOLEAN DoFDCJoin_eMerges__key_ccw_rid := False: STORED('Include__eMerges__key_ccw_rid');
		EXPORT BOOLEAN DoFDCJoin_eMerges__Key_HuntFish_Rid := False: STORED('Include__eMerges__Key_HuntFish_Rid');
		EXPORT BOOLEAN DoFDCJoin_Equifax_Business_Data__kfetch_LinkIDs := False: STORED('Include__Equifax_Business_Data__kfetch_LinkIDs');
		EXPORT BOOLEAN DoFDCJoin_Experian_CRDB__Key_LinkIDs := False: STORED('Include__Experian_CRDB__Key_LinkIDs');
		EXPORT BOOLEAN DoFDCJoin_FBNv2__kfetch_LinkIds := False: STORED('Include__FBNv2__kfetch_LinkIds');
		EXPORT BOOLEAN DoFDCJoin_Fraudpoint3__Key_Address := False: STORED('Include__Fraudpoint3__Key_Address');
		EXPORT BOOLEAN DoFDCJoin_fraudpoint3__Key_DID := False: STORED('Include__fraudpoint3__Key_DID');
		EXPORT BOOLEAN DoFDCJoin_Fraudpoint3__Key_Phone := False: STORED('Include__Fraudpoint3__Key_Phone');
		EXPORT BOOLEAN DoFDCJoin_Fraudpoint3__Key_SSN := False: STORED('Include__Fraudpoint3__Key_SSN');
		EXPORT BOOLEAN DoFDCJoin_Gong__Key_History_Address := False: STORED('Include__Gong__Key_History_Address');
		EXPORT BOOLEAN DoFDCJoin_Gong__Key_History_DID := False: STORED('Include__Gong__Key_History_DID');
		EXPORT BOOLEAN DoFDCJoin_Gong__Key_History_LinkIds := False: STORED('Include__Gong__Key_History_LinkIds');
		EXPORT BOOLEAN DoFDCJoin_Gong__Key_History_Phone := False: STORED('Include__Gong__Key_History_Phone');
		EXPORT BOOLEAN DoFDCJoin_GovData__kfetch_IRS_NonProfit_linkIDs := False: STORED('Include__GovData__kfetch_IRS_NonProfit_linkIDs');
		EXPORT BOOLEAN DoFDCJoin_Header__Key_Addr_Hist   := False: STORED('Include__Header__Key_Addr_Hist');
		EXPORT BOOLEAN DoFDCJoin_Header__key_ADL_segmentation := False: STORED('Include__Header__key_ADL_segmentation');
		EXPORT BOOLEAN DoFDCJoin_HighRiskAddress := False: STORED('Include__HighRiskAddress');
		EXPORT BOOLEAN DoFDCJoin_HighRiskPhone := False: STORED('Include__HighRiskPhone');
		EXPORT BOOLEAN DoFDCJoin_Infutor__NARB_kfetch_LinkIds := False: STORED('Include__Infutor__NARB_kfetch_LinkIds');
		EXPORT BOOLEAN DoFDCJoin_InfutorCID__Key_Infutor_Phone := False: STORED('Include__InfutorCID__Key_Infutor_Phone');
		EXPORT BOOLEAN DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_Address := False: STORED('Include__Inquiry_AccLogs__Inquiry_Table_Address');
		EXPORT BOOLEAN DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_DID := False: STORED('Include__Inquiry_AccLogs__Inquiry_Table_DID');
		EXPORT BOOLEAN DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_EMAIL := False: STORED('Include__Inquiry_AccLogs__Inquiry_Table_EMAIL');
		EXPORT BOOLEAN DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_FEIN := False: STORED('Include__Inquiry_AccLogs__Inquiry_Table_FEIN');
		EXPORT BOOLEAN DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_LinkIDs := False: STORED('Include__Inquiry_AccLogs__Inquiry_Table_LinkIDs');
		EXPORT BOOLEAN DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_Phone := False: STORED('Include__Inquiry_AccLogs__Inquiry_Table_Phone');
		EXPORT BOOLEAN DoFDCJoin_Inquiry_AccLogs__Inquiry_Table_SSN := False: STORED('Include__Inquiry_AccLogs__Inquiry_Table_SSN');
		EXPORT BOOLEAN DoFDCJoin_Inquiry_AccLogs__Key_Address_FCRA := False: STORED('Include__Inquiry_AccLogs__Key_Address_FCRA');
		EXPORT BOOLEAN DoFDCJoin_Inquiry_AccLogs__Key_DID_FCRA := False: STORED('Include__Inquiry_AccLogs__Key_DID_FCRA');
		EXPORT BOOLEAN DoFDCJoin_Inquiry_AccLogs__Key_Phone_FCRA := False: STORED('Include__Inquiry_AccLogs__Key_Phone_FCRA');
		EXPORT BOOLEAN DoFDCJoin_Inquiry_AccLogs__Key_SSN_FCRA := False: STORED('Include__Inquiry_AccLogs__Key_SSN_FCRA');
		EXPORT BOOLEAN DoFDCJoin_IRS5500__kfetch_LinkIDs := False: STORED('Include__IRS5500__kfetch_LinkIDs');
		EXPORT BOOLEAN DoFDCJoin_LiensV2_key_liens := False: STORED('Include__LiensV2_key_liens');
		EXPORT BOOLEAN DoFDCJoin_LiensV2_Key_party_Linkids_Records := False: STORED('Include__LiensV2_Key_party_Linkids_Records');
		EXPORT BOOLEAN DoFDCJoin_OSHAIR__kfetch_OSHAIR_LinkIds := False: STORED('Include__OSHAIR__kfetch_OSHAIR_LinkIds');
		EXPORT BOOLEAN DoFDCJoin_PhoneInfo__Key_Phone_Transaction := False: STORED('Include__PhoneInfo__Key_Phone_Transaction');
		EXPORT BOOLEAN DoFDCJoin_PhoneInfo__Key_Phone_Type := False: STORED('Include__PhoneInfo__Key_Phone_Type');
		EXPORT BOOLEAN DoFDCJoin_PhonePlus_V2__Iverification_Did_Phone := False: STORED('Include__PhonePlus_V2__Iverification_Did_Phone');
		EXPORT BOOLEAN DoFDCJoin_PhonePlus_V2__Iverification_Phone := False: STORED('Include__PhonePlus_V2__Iverification_Phone');
		EXPORT BOOLEAN DoFDCJoin_PhonePlus_V2__Key_Source_Level_Payload_did   := False: STORED('Include__PhonePlus_V2__Key_Source_Level_Payload_did');
		EXPORT BOOLEAN DoFDCJoin_PhonePlus_V2__Key_Source_Level_Payload_phone := False: STORED('Include__PhonePlus_V2__Key_Source_Level_Payload_phone');
		EXPORT BOOLEAN DoFDCJoin_Prof_License_Mari__Key_Did := False: STORED('Include__Prof_License_Mari__Key_Did');
		EXPORT BOOLEAN DoFDCJoin_Prof_LicenseV2__Key_Proflic_Did   := False: STORED('Include__Prof_LicenseV2__Key_Proflic_Did');
		EXPORT BOOLEAN DoFDCJoin_Property__Key_Foreclosure_FID := False: STORED('Include__Property__Key_Foreclosure_FID');
		EXPORT BOOLEAN DoFDCJoin_PropertyV2__Key_Addr_Fid := False: STORED('Include__PropertyV2__Key_Addr_Fid');
		EXPORT BOOLEAN DoFDCJoin_PropertyV2__Key_Assessor_Fid   := False: STORED('Include__PropertyV2__Key_Assessor_Fid');
		EXPORT BOOLEAN DoFDCJoin_PropertyV2__Key_Deed_Fid := False: STORED('Include__PropertyV2__Key_Deed_Fid');
		EXPORT BOOLEAN DoFDCJoin_PropertyV2__Key_Linkids_Key := False: STORED('Include__PropertyV2__Key_Linkids_Key');
		EXPORT BOOLEAN DoFDCJoin_PropertyV2__Key_Property_Did := False: STORED('Include__PropertyV2__Key_Property_Did');
		EXPORT BOOLEAN DoFDCJoin_Quick_Header__key_wild_SSN := False: STORED('Include__Quick_Header__key_wild_SSN');
		EXPORT BOOLEAN DoFDCJoin_Relatives__Key_Relatives_v3 := False: STORED('Include__Relatives__Key_Relatives_v3');
		EXPORT BOOLEAN DoFDCJoin_Risk_Indicators__Correlation_Risk__key_addr_dob_summary := False: STORED('Include__Risk_Indicators__Correlation_Risk__key_addr_dob_summary');
		EXPORT BOOLEAN DoFDCJoin_Risk_Indicators__Correlation_Risk__key_addr_name_summary := False: STORED('Include__Risk_Indicators__Correlation_Risk__key_addr_name_summary');
		EXPORT BOOLEAN DoFDCJoin_Risk_Indicators__Correlation_Risk__key_name_dob_summary := False: STORED('Include__Risk_Indicators__Correlation_Risk__key_name_dob_summary');
		EXPORT BOOLEAN DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_addr_header_summary := False: STORED('Include__Risk_Indicators__Correlation_Risk__key_phone_addr_header_summary');
		EXPORT BOOLEAN DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_addr_summary := False: STORED('Include__Risk_Indicators__Correlation_Risk__key_phone_addr_summary');
		EXPORT BOOLEAN DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_dob_summary := False: STORED('Include__Risk_Indicators__Correlation_Risk__key_phone_dob_summary');
		EXPORT BOOLEAN DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_lname_header_summary := False: STORED('Include__Risk_Indicators__Correlation_Risk__key_phone_lname_header_summary');
		EXPORT BOOLEAN DoFDCJoin_Risk_Indicators__Correlation_Risk__key_phone_lname_summary := False: STORED('Include__Risk_Indicators__Correlation_Risk__key_phone_lname_summary');
		EXPORT BOOLEAN DoFDCJoin_Risk_Indicators__Correlation_Risk__key_ssn_addr_summary := False: STORED('Include__Risk_Indicators__Correlation_Risk__key_ssn_addr_summary');
		EXPORT BOOLEAN DoFDCJoin_Risk_Indicators__Correlation_Risk__key_ssn_dob_summary := False: STORED('Include__Risk_Indicators__Correlation_Risk__key_ssn_dob_summary');
		EXPORT BOOLEAN DoFDCJoin_Risk_Indicators__Correlation_Risk__key_ssn_name_summary := False: STORED('Include__Risk_Indicators__Correlation_Risk__key_ssn_name_summary');
		EXPORT BOOLEAN DoFDCJoin_Risk_Indicators__Correlation_Risk__key_ssn_phone_summary := False: STORED('Include__Risk_Indicators__Correlation_Risk__key_ssn_phone_summary');
		EXPORT BOOLEAN DoFDCJoin_RiskWise__Key_CityStZip := False: STORED('Include__RiskWise__Key_CityStZip');
		EXPORT BOOLEAN DoFDCJoin_SAM__kfetch_linkID := False: STORED('Include__SAM__kfetch_linkID');
		EXPORT BOOLEAN DoFDCJoin_Targus__Key_Targus_Phone := False: STORED('Include__Targus__Key_Targus_Phone');
		EXPORT BOOLEAN DoFDCJoin_Thrive__Key_did_QA := False: STORED('Include__Thrive__Key_did_QA');
		EXPORT BOOLEAN DoFDCJoin_Tradeline_Files__Tradeline__Key_LinkIds := False: STORED('Include__Tradeline_Files__Tradeline__Key_LinkIds');
		EXPORT BOOLEAN DoFDCJoin_UCC_Files__Key_Linkids := False: STORED('Include__UCC_Files__Key_Linkids');
		EXPORT BOOLEAN DoFDCJoin_USPIS_HotList__key_addr_search_zip := False: STORED('Include__USPIS_HotList__key_addr_search_zip');
		EXPORT BOOLEAN DoFDCJoin_UtilFile__Key_Address := False: STORED('Include__UtilFile__Key_Address');
		EXPORT BOOLEAN DoFDCJoin_UtilFile__Key_DID := False: STORED('Include__UtilFile__Key_DID');
		EXPORT BOOLEAN DoFDCJoin_UtilFile__Key_LinkIds := False: STORED('Include__UtilFile__Key_LinkIds');
		EXPORT BOOLEAN DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_DID   := False: STORED('Include__Vehicle_Files__VehicleV2__Vehicle_DID');
		EXPORT BOOLEAN DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_LinkID := False: STORED('Include__Vehicle_Files__VehicleV2__Vehicle_LinkID');
		EXPORT BOOLEAN DoFDCJoin_Watercraft_Files__Watercraft := False: STORED('Include__Watercraft_Files__Watercraft');
		EXPORT BOOLEAN DoFDCJoin_Watercraft_Files__Watercraft_LinkId := False: STORED('Include__Watercraft_Files__Watercraft_LinkId');
		EXPORT BOOLEAN DoFDCJoin_YellowPages__kfetch_yellowpages_linkids := False: STORED('Include__YellowPages__kfetch_yellowpages_linkids');
		EXPORT BOOLEAN DoFDCJoinfn_FLAccidents_Ecrash__key_Ecrash := False: STORED('Include_fn_FLAccidents_Ecrash__key_Ecrash');
		EXPORT BOOLEAN DoFDCJoinfn_FLAccidents_Ecrash__key_Ecrash_accnbr := False: STORED('Include_fn_FLAccidents_Ecrash__key_Ecrash_accnbr');
		EXPORT BOOLEAN DoFDCJoinfn_IndexedSearchForXLinkIDs := False: STORED('Include_fn_IndexedSearchForXLinkIDs');

	end;
	

	ds_input_bus := 
		PROJECT(ds_input,
			TRANSFORM( PublicRecords_KEL.ECL_Functions.Input_UID_Bus_Layout,
				SELF.G_ProcBusUID := COUNTER,
				SELF := LEFT;
				SELF := []));		
				
	echoReps := SORT(PublicRecords_KEL.ECL_Functions.Fn_InputEchoBusReps_Roxie( ds_input_bus ), G_ProcBusUID);

	cleanReps := PublicRecords_KEL.ECL_Functions.Fn_CleanInput_Roxie( echoReps );	

	echoBusiness := PublicRecords_KEL.ECL_Functions.Fn_InputEchoBus_Roxie( ds_input_bus );

	cleanBusiness := PublicRecords_KEL.ECL_Functions.Fn_CleanInputBus_Roxie( echoBusiness );	

	withRepLexIDs := PublicRecords_KEL.ECL_Functions.Fn_AppendLexid_Roxie( cleanReps, Options );
	Rep1Input := withRepLexIDs(RepNumber = 1);

	withBIPIDs := PublicRecords_KEL.ECL_Functions.Fn_AppendBIPIDs_Roxie( cleanBusiness, Rep1Input, Options );
	
	FDCDatasetMini := PublicRecords_KEL.Fn_MAS_FDC_Mini( Rep1Input, Options, JoinOptions, withBIPIDs);		

	MiniAttributes := PublicRecords_KEL.FnRoxie_GetMiniFDCAttributes(Rep1Input, FDCDatasetMini, Options); 

	FDCDataset := PublicRecords_KEL.Fn_MAS_FDC( MiniAttributes, Options, JoinOptions, withBIPIDs,FDCDatasetMini );

	ds_slim := project(FDCDataset, transform(PublicRecords_KEL.ECL_Functions.Layouts_FDC(Options).Layout_FDC, self.UIDAppend := left.UIDAppend, self :=[]));

	ds_out := if(ViewFDC, FDCDataset, ds_slim);

	OUTPUT(ds_out, NAMED('FDCDataset'));
			
ENDMACRO;			