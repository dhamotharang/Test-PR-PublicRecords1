IMPORT PublicRecords_KEL;

// NOTE: These are meant to be turned on or off at compile time (NOT run-time)
// for the sake of optimizing joins for a particular product.
//
// HINT: use Uses.kel to provide guidance for how to cluster the Boolean flags 
// for a particular key/data source.
// 
EXPORT Common(PublicRecords_KEL.Interface_Options Options) := MODULE

	// ---------------[ Consumer ]---------------

	EXPORT DoFDCJoin_Doxie__Key_Header := 
			Options.IncludeAddress OR 
			Options.IncludeAddressPhone OR 
			Options.IncludePerson OR 
			Options.IncludePersonAddress OR 
			Options.IncludePersonPhone OR 
			Options.IncludePersonSSN OR 
			Options.IncludePhone OR 
			Options.IncludePhoneSSN OR 
			Options.IncludeSocialSecurityNumber OR 
			Options.IncludeSSNAddress;
	
	EXPORT DoFDCJoin_Header_Quick__Key_Did := 
			Options.IncludeAddress OR 
			Options.IncludeAddressPhone OR 
			Options.IncludePerson OR 
			Options.IncludePersonAddress OR 
			Options.IncludePersonPhone OR 
			Options.IncludePersonSSN OR 
			Options.IncludePhone OR 
			Options.IncludePhoneSSN OR 
			Options.IncludeSocialSecurityNumber OR 
			Options.IncludeSSNAddress;
			
	// FCRA only
	EXPORT DoFDCJoin_Doxie_Files__Key_BocaShell_Crim_FCRA := 
			Options.isFCRA AND
			(Options.IncludePersonOffenses OR 
			Options.IncludePersonOffender OR 
			Options.IncludeCriminalOffense);
			
	// FCRA and nonFCRA versions exist, but old boca shell uses FCRA only.
	EXPORT DoFDCJoin_Doxie_files__Key_Court_Offenses := 
			Options.isFCRA AND
			(Options.IncludeCriminalOffender OR
			Options.IncludeCriminalOffense OR
			Options.IncludeCriminalPunishment OR
			Options.IncludeCriminalDetails);

	// FCRA and nonFCRA versions		
	EXPORT DoFDCJoin_Doxie_Files__Key_Offenses := 
			Options.isFCRA AND
			(Options.IncludeCriminalOffender OR
			Options.IncludeCriminalOffense OR
			Options.IncludeCriminalPunishment OR
			Options.IncludeCriminalDetails);

	// FCRA and nonFCRA versions		
	EXPORT DoFDCJoin_Doxie_Files__Key_Offenders := 
			Options.IncludeCriminalOffender OR
			Options.IncludeCriminalOffense OR
			Options.IncludeCriminalDetails OR
			Options.IncludePerson OR
			Options.IncludePersonOffenses OR
			Options.IncludePersonOffender OR
			Options.IncludeAddress OR
			Options.IncludeOffenderAddress OR
			Options.IncludeSocialSecurityNumber OR
			Options.IncludeOffenderSSN OR
			Options.IncludePersonSSN OR
			Options.IncludePersonAddress OR
			DoFDCJoin_Doxie_Files__Key_Court_Offenses OR // We use Key_Offenders_FCRA to do the offender_key lookup before joining to Key_Court_Offenses
			DoFDCJoin_Doxie_Files__Key_Offenses; // We use Key_Offenders_FCRA to do the offender_key lookup before joining to Key_Offenses

	// EXPORT DoFDCJoin_Doxie_Files__Key_BocaShell_Crim2 := 

	// NonFCRA only
	EXPORT DoFDCJoin_Doxie_Files__Key_Offenders_Risk := 
			NOT Options.isFCRA AND
			(Options.IncludeCriminalOffense OR
			Options.IncludeDriversLicense OR
			Options.IncludePersonOffenses OR
			Options.IncludePersonSSN OR
			Options.IncludeSocialSecurityNumber OR
			Options.IncludeSSNAddress OR
			Options.IncludeZipCodePerson);
			
	EXPORT DoFDCJoin_Doxie_Files__Key_Punishment := 
			NOT Options.isFCRA AND
			(Options.IncludeCriminalDetails OR
			Options.IncludeCriminalOffense OR
			Options.IncludeCriminalPunishment);

	EXPORT DoFDCJoin_Bankruptcy_Files__Key_bankruptcy_did :=
		(Options.IncludeBankruptcy OR
		Options.IncludePersonBankruptcy OR
		Options.IncludeSSNBankruptcy OR
		Options.IncludePerson OR
		Options.IncludePersonAddress OR
		Options.IncludePersonSSN OR
		Options.IncludePhoneSSN OR
		Options.IncludeSocialSecurityNumber OR
		Options.IncludeSSNAddress OR
		Options.IncludeZipCodePerson); 
	
	EXPORT DoFDCJoin_Bankruptcy_Files__Bankruptcy__Key_Search :=
		(Options.IncludeBankruptcy OR
		Options.IncludePersonBankruptcy OR
		Options.IncludeSSNBankruptcy OR
		Options.IncludePerson OR
		Options.IncludePersonAddress OR
		Options.IncludePersonSSN OR
		Options.IncludePhoneSSN OR
		Options.IncludeSocialSecurityNumber OR
		Options.IncludeSSNAddress OR
		Options.IncludeZipCodePerson);
	
	EXPORT DoFDCJoin_Bankruptcy_Files__Bankruptcy__Key_Main :=
		(Options.IncludeBankruptcy OR
		Options.IncludePersonBankruptcy OR
		Options.IncludeSSNBankruptcy OR
		Options.IncludePerson OR
		Options.IncludePersonAddress OR
		Options.IncludePersonSSN OR
		Options.IncludePhoneSSN OR
		Options.IncludeSocialSecurityNumber OR
		Options.IncludeSSNAddress OR
		Options.IncludeZipCodePerson);

	EXPORT DoFDCJoin_Bankruptcy_Files__Bankruptcy__Linkid_Key_Search :=
		(NOT Options.isFCRA AND 
		(Options.IncludeBankruptcy OR
		Options.IncludeSeleBankruptcy));
		
	EXPORT DoFDCJoin_Aircraft_Files__FAA__Aircraft_did :=
		(Options.IncludeAircraft OR
		Options.IncludeAircraftOwner); 

	EXPORT DoFDCJoin_Aircraft_Files__FAA__Aircraft_ID :=
		(Options.IncludeAircraft OR
		Options.IncludeAircraftOwner); 
		
	EXPORT DoFDCJoin_Aircraft_Files__FAA__Aircraft_linkids :=
	NOT Options.isFCRA AND
	(Options.IncludeAircraft OR
	Options.IncludeSeleAircraft);   
	
	EXPORT DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_DID :=
		NOT Options.isFCRA AND
		(Options.IncludeVehicle OR
		Options.IncludePersonVehicle); 

	EXPORT DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_LinkID :=
			NOT Options.isFCRA AND
		(Options.IncludeVehicle OR
		Options.IncludeSeleVehicle); 
		
	EXPORT DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_Party :=
		NOT Options.isFCRA AND
		(Options.IncludeVehicle OR
		Options.IncludePersonVehicle OR 
		Options.IncludeSeleVehicle);  

	EXPORT DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_Main :=
		NOT Options.isFCRA AND
		(Options.IncludeVehicle OR
		Options.IncludePersonVehicle OR 
		Options.IncludeSeleVehicle); 

	EXPORT DoFDCJoin_Watercraft_Files__Watercraft_DID :=
		(Options.IncludeWatercraft OR
		Options.IncludeWatercraftOwner); 
		
	EXPORT DoFDCJoin_Watercraft_Files__Watercraft_LinkId :=
			NOT Options.isFCRA AND 
		(Options.IncludeWatercraft OR
		Options.IncludeSeleWatercraft); 
		
	EXPORT DoFDCJoin_Watercraft_Files__Watercraft_SID :=
		(Options.IncludeWatercraft OR
		Options.IncludeWatercraftOwner OR
		Options.IncludeSeleWatercraft);

	// Do JOINs for FCRA and nonFCRA
	EXPORT DoFDCJoin_Prof_LicenseV2__Key_Proflic_Did :=
		(Options.IncludeProfessionalLicense OR
		Options.IncludeProfessionalLicenseAddress OR
		Options.IncludeProfessionalLicensePerson OR
		Options.IncludeProfessionalLicensePhone);

	// Do JOINs for FCRA and nonFCRA
	EXPORT DoFDCJoin_Prof_License_Mari__Key_Did :=
		(Options.IncludeProfessionalLicense OR
		Options.IncludeProfessionalLicenseAddress OR
		Options.IncludeProfessionalLicensePerson OR
		Options.IncludeProfessionalLicensePhone);
		
	EXPORT DoFDCJoin_ADVO__Key_Addr1 := 
			Options.IncludeAddress;

	EXPORT DoFDCJoin_ADVO__Key_Addr1_History := 
			Options.IncludeAddress;

	EXPORT DoFDCJoin_DMA__Key_DNM_Name_Address := 
		NOT Options.IsFCRA AND 
			Options.IncludeAddress;

	EXPORT DoFDCJoin_Fraudpoint3__Key_Address := 
		NOT Options.IsFCRA AND (
			Options.IncludeAddress OR 
			Options.IncludePhone OR 
			Options.IncludeSocialSecurityNumber);

	EXPORT DoFDCJoin_Header__Key_Addr_Hist := 
			Options.IncludePersonAddress OR 
			Options.IncludeZipCodePerson;

	EXPORT DoFDCJoin_Inquiry_AccLogs__Key_DID := 
		Options.IncludeInquiry OR
		Options.IncludePerson OR
		Options.IncludeAddress OR
		Options.IncludePhone OR
		Options.IncludeDriversLicense OR
		Options.IncludeSocialSecurityNumber OR
		Options.IncludePersonInquiry OR
		Options.IncludeAddressInquiry OR
		Options.IncludeSSNInquiry OR
		Options.IncludePhoneInquiry OR
		Options.IncludeDriversLicenseInquiry;

	EXPORT DoFDCJoin_USPIS_HotList__key_addr_search_zip := 
			Options.IncludeAddress;

	EXPORT DoFDCJoin_UtilFile__Key_Address := 
			Options.IncludeUtility OR
			Options.IncludeUtilityHomeAddress OR
			Options.IncludeAddress OR
			Options.IncludeUtilityPhone OR
			Options.IncludePhone OR
			Options.IncludeUtilityPerson OR
			Options.IncludePersonPhone OR
			Options.IncludeAddressPhone;

	EXPORT DoFDCJoin_UtilFile__Key_DID := 
			Options.IncludeUtility OR
			Options.IncludeUtilityHomeAddress OR
			Options.IncludeAddress OR
			Options.IncludeUtilityPhone OR
			Options.IncludePhone OR
			Options.IncludeUtilityPerson OR
			Options.IncludePersonPhone OR
			Options.IncludeAddressPhone;

	EXPORT DoFDCJoin_Email_Data__Key_DID :=
		NOT Options.isFCRA AND
		(Options.IncludeEmail or
		 Options.IncludePersonEmail or
		 Options.IncludeEmailHousehold or
		 Options.IncludePersonEmailPhoneAddress);
		 
	EXPORT DoFDCJoin_Email_Data__Key_Email_Address :=
		NOT Options.isFCRA AND
		(Options.IncludeEmail or
		 Options.IncludePersonEmail or
		 Options.IncludeEmailHousehold or
		 Options.IncludePersonEmailPhoneAddress);
		 
	EXPORT DoFDCJoin_DX_Email__Key_Email_Payload :=
		NOT Options.isFCRA AND
		(Options.IncludeEmail or
		 Options.IncludePersonEmail or
		 Options.IncludeEmailHousehold or
		 Options.IncludePersonEmailPhoneAddress);

	EXPORT DoFDCJoin_Doxie__Key_Death_MasterV2_SSA_DID := 
		NOT Options.IsFCRA AND (
			Options.IncludePerson OR
			Options.IncludeSocialSecurityNumber OR
			Options.IncludePersonSSN);

	EXPORT DoFDCJoin_DriversV2__Key_DL_DID := 
		NOT Options.IsFCRA AND (
			Options.IncludeDriversLicense OR 
			Options.IncludePerson OR
			Options.IncludePersonDriversLicense OR 
			Options.IncludeAddressDriversLicense);

	EXPORT DoFDCJoin_DriversV2__Key_DL_Number := 
		NOT Options.IsFCRA AND (
			Options.IncludeDriversLicense OR 
			Options.IncludePerson OR
			Options.IncludePersonDriversLicense OR 
			Options.IncludeAddressDriversLicense);

	EXPORT DoFDCJoin_Doxie__Key_Header_Address := 
			Options.IncludeAddress OR
			Options.IncludeSSNAddress OR
			Options.IncludePerson OR
			Options.IncludePersonAddress OR 
			Options.IncludeSocialSecurityNumber;
			
	EXPORT DoFDCJoin_Risk_Indicators__Key_FCRA_ADL_Risk_Table_v4_Filtered := 
		Options.IsFCRA AND (
			Options.IncludePerson);

	EXPORT DoFDCJoin_Risk_Indicators__Key_ADL_Risk_Table_v4 := 
		NOT Options.IsFCRA AND (
			Options.IncludePerson);

	// ---------------[ Business ]---------------

	EXPORT DoFDCJoin_Tradeline_Files__Tradeline__Key_LinkIds := 
		NOT Options.isFCRA AND 
		(Options.IncludeTradeline or 
		Options.IncludeTradelineBusiness);
		
	EXPORT DoFDCJoin_Business_Files__Business__Key_BH_Linking_Ids :=
		NOT Options.isFCRA AND
		 (Options.IncludeBusiness or //tradeline only
		 Options.IncludeTradelineBusiness or
		 Options.IncludeTIN or //TIN only comes from BH
		 Options.IncludeAddress or 
		 Options.IncludeTINBusinessSele or  
		 Options.IncludeBusinessSele or  
		 Options.IncludeSelePerson or  
		 Options.IncludeBusinessProx or  
		 Options.IncludeProxAddress or  
		 Options.IncludeProxPhone or  
		 Options.IncludeTINPhone or  
		 Options.IncludeTINAddress );  

	EXPORT DoFDCJoin_Corp2__Key_LinkIDs_Corp := 
		NOT Options.IsFCRA AND (
			Options.IncludeCorporateFiling OR
			Options.IncludeBusinessSele OR
			Options.IncludeBusinessProx OR
			Options.IncludeAddress);

	EXPORT DoFDCJoin_InfoUSA__Key_DEADCO_LinkIds := 
		NOT Options.IsFCRA AND 
			Options.IncludeAddress;

	EXPORT DoFDCJoin_UtilFile__Key_LinkIds := 
		NOT Options.IsFCRA AND (
			Options.IncludeBusinessSele OR
			Options.IncludeBusinessProx OR
			Options.IncludeProxUtility OR
			Options.IncludeAddress OR 
			Options.IncludeUtility OR
			Options.IncludeUtilityHomeAddress OR
			Options.IncludeUtilityPerson OR
			Options.IncludeUtilityPhone OR 
			Options.IncludeProxPhone OR 
			Options.IncludePersonPhone OR 
			Options.IncludeAddressPhone OR
			Options.IncludeProxAddress);
			
	EXPORT DoFDCJoin_UCC_Files__Main_RMSID :=
		NOT Options.isFCRA AND
		 (Options.IncludeUCC);  

	EXPORT DoFDCJoin_UCC_Files__Party_RMSID :=
		NOT Options.isFCRA AND
		 (Options.IncludeUCC or
		 Options.IncludePersonUCC or
		 Options.IncludeSeleUCC);  

	EXPORT DoFDCJoin_UCC_Files__Key_Linkids :=
		NOT Options.isFCRA AND
		 (Options.IncludeUCC or
		 Options.IncludePersonUCC or
		 Options.IncludeSeleUCC);		

	//Relatives is included in both FCRA and Non-FCRA
	EXPORT DoFDCJoin_Relatives__Key_Relatives_v3 := 
			NOT Options.isFCRA AND	
			(Options.IncludePerson OR
			Options.IncludeFirstDegreeAssociations OR
			Options.IncludeFirstDegreeRelative OR
			Options.IncludeSecondDegreeAssociations);
		 
	EXPORT DoFDCJoin_BBB2__kfetch_BBB_LinkIds :=
		NOT Options.isFCRA AND
		 (Options.IncludeBusinessSele);				
		 
	EXPORT DoFDCJoin_BBB2__kfetch_BBB_Non_Member_LinkIds :=
		NOT Options.isFCRA AND
		 (Options.IncludeBusinessSele);		

	EXPORT DoFDCJoin_BusReg__kfetch_busreg_company_linkids :=
		NOT Options.isFCRA AND
		 (Options.IncludeBusinessSele OR	
		 Options.IncludeBusinessProx);			
		 
	EXPORT DoFDCJoin_CalBus__kfetch_Calbus_LinkIDS :=
		NOT Options.isFCRA AND
		 (Options.IncludeBusinessSele);		
		 
	EXPORT DoFDCJoin_Cortera__kfetch_LinkID :=
		NOT Options.isFCRA AND
		 (Options.IncludeBusinessSele OR
		 Options.IncludeBusinessProx );
		
	EXPORT DoFDCJoin_DCAV2__kfetch_LinkIds :=
		NOT Options.isFCRA AND
		 (Options.IncludeBusinessSele);				 
		 	
	EXPORT DoFDCJoin_EBR_kfetch_5600_Demographic_Data_linkids :=
		NOT Options.isFCRA AND
		 (Options.IncludeBusinessSele OR
		 Options.IncludeBusinessProx);		
		
	EXPORT DoFDCJoin_FBNv2__kfetch_LinkIds :=
		NOT Options.isFCRA AND
		 (Options.IncludeBusinessSele);				 
	
	EXPORT DoFDCJoin_GovData__kfetch_IRS_NonProfit_linkIDs:=
		NOT Options.isFCRA AND
		 (Options.IncludeBusinessSele);		
		
	EXPORT DoFDCJoin_IRS5500__kfetch_LinkIDs :=
		NOT Options.isFCRA AND
		 (Options.IncludeBusinessSele);				 
	
	EXPORT DoFDCJoin_OSHAIR__kfetch_OSHAIR_LinkIds :=
		NOT Options.isFCRA AND
		 (Options.IncludeBusinessSele OR
		 Options.IncludeBusinessProx );
		
	EXPORT DoFDCJoin_SAM__kfetch_linkID :=
		NOT Options.isFCRA AND
		 (Options.IncludeBusinessSele);				 
	
	EXPORT DoFDCJoin_YellowPages__kfetch_yellowpages_linkids :=
		NOT Options.isFCRA AND
		 (Options.IncludeBusinessSele OR
		 Options.IncludeProxAddress	OR	
		 Options.IncludeProxPhone	OR
		 Options.IncludeAddressPhone OR	
		 Options.IncludeProxPhone);		
		 
	EXPORT DoFDCJoin_Infutor__NARB_kfetch_LinkIds :=
		NOT Options.isFCRA AND
		 (Options.IncludeBusinessSele);				 
	
	EXPORT DoFDCJoin_Equifax_Business_Data__kfetch_LinkIDs :=
		NOT Options.isFCRA AND
		 (Options.IncludeBusinessSele OR
		 Options.IncludeBusinessProx OR 
		 Options.IncludeProxAddress);		
	
	EXPORT DoFDCJoin_BIPV2_Build__kfetch_contact_linkids :=
		NOT Options.isFCRA AND
		 (Options.IncludeBusinessProx OR
		 Options.IncludeProxPerson);				 
		 
 	EXPORT DoFDCJoin_BIPV2_Best__Key_LinkIds := 
		NOT Options.isFCRA AND
			(Options.IncludeBusinessSele OR
			Options.IncludeBusinessProx OR		
			Options.IncludeSelePhoneNumber OR
			Options.IncludeProxPhone OR			
			Options.IncludeTINBusinessSele OR
			Options.IncludeProxTIN OR
			Options.IncludeSeleAddress OR
			Options.IncludeProxAddress);

	// ---------------[ Phone ]---------------

	EXPORT DoFDCJoin_Gong__Key_History_DID := 
		Options.IncludePhone OR
		Options.IncludePersonPhone OR
		Options.IncludeAddressPhone OR
		Options.IncludeHouseholdPhone;

	EXPORT DoFDCJoin_Gong__Key_History_Address := 
		Options.IncludePhone OR
		Options.IncludePersonPhone OR
		Options.IncludeAddressPhone OR
		Options.IncludeHouseholdPhone;

	EXPORT DoFDCJoin_Gong__Key_History_Phone := 
		Options.IncludePhone OR
		Options.IncludePersonPhone OR
		Options.IncludeAddressPhone OR
		Options.IncludeHouseholdPhone;

	EXPORT DoFDCJoin_Gong__Key_History_LinkIds := 
		Options.IncludePhone OR
		Options.IncludeProxPhoneNumber OR
		Options.IncludeAddressPhone;

	EXPORT DoFDCJoin_Targus__Key_Targus_Address := 
		Options.IncludePhone OR
		Options.IncludePersonPhone OR
		Options.IncludeAddressPhone OR
		Options.IncludeHouseholdPhone;

	EXPORT DoFDCJoin_Targus__Key_Targus_Phone := 
		Options.IncludePhone OR
		Options.IncludePersonPhone OR
		Options.IncludeAddressPhone OR
		Options.IncludeHouseholdPhone;

	EXPORT DoFDCJoin_InfutorCID__Key_Infutor_Phone := 
		Options.IncludePhone OR
		Options.IncludePersonPhone OR
		Options.IncludeAddressPhone;

	EXPORT DoFDCJoin_PhonePlus_V2__ScoringPhone := 
			NOT Options.isFCRA AND	
			(Options.IncludePhone OR
			Options.IncludePersonPhone OR
			Options.IncludeAddressPhone OR
			Options.IncludeHouseholdPhone);

	EXPORT DoFDCJoin_PhonePlus_V2__ScoringAddress := 
			NOT Options.isFCRA AND	
			(Options.IncludePhone OR
			Options.IncludePersonPhone OR
			Options.IncludeAddressPhone OR
			Options.IncludeHouseholdPhone);
	 
	EXPORT DoFDCJoin_PhonePlus_V2__Iverification_Phone := 
			NOT Options.isFCRA AND	
			(Options.IncludePhone OR
			Options.IncludeHouseholdPhone OR
			Options.IncludePersonPhone);
			
	EXPORT DoFDCJoin_PhonePlus_V2__Iverification_Did_Phone := 
			NOT Options.isFCRA AND	
			(Options.IncludePhone OR
			Options.IncludeHouseholdPhone OR
			Options.IncludePersonPhone);

	EXPORT DoFDCJoin_CellPhone__Key_Nustar_Phone := 
			NOT Options.isFCRA AND	
			Options.IncludePhone;
	
	EXPORT DoFDCJoin_PhonePlus_V2__Key_Phoneplus_FDid := 
			NOT Options.isFCRA AND	
			(Options.IncludePhone OR
			Options.IncludePersonPhone OR
			Options.IncludeHouseholdPhone OR
			Options.IncludeAddressPhone);
			
END;
