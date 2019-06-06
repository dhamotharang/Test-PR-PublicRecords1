﻿IMPORT PublicRecords_KEL;

// NOTE: These are meant to be turned on or off at compile time (NOT run-time)
// for the sake of optimizing joins for a particular product.
EXPORT Common(PublicRecords_KEL.Interface_Options Options) := MODULE

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

	EXPORT DoFDCJoin_Aircraft_Files__FAA__Aircraft_did :=
		(Options.IncludeAircraft OR
		Options.IncludeAircraftOwner); 

	EXPORT DoFDCJoin_Aircraft_Files__FAA__Aircraft_ID :=
		(Options.IncludeAircraft OR
		Options.IncludeAircraftOwner);   

	EXPORT DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_DID :=
		NOT Options.isFCRA AND
		(Options.IncludeVehicle OR
		Options.IncludePersonVehicle); 

	EXPORT DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_Party :=
		NOT Options.isFCRA AND
		(Options.IncludeVehicle OR
		Options.IncludePersonVehicle);  

	EXPORT DoFDCJoin_Vehicle_Files__VehicleV2__Vehicle_Main :=
		NOT Options.isFCRA AND
		(Options.IncludeVehicle OR
		Options.IncludePersonVehicle); 

	EXPORT DoFDCJoin_Watercraft_Files__Watercraft_DID :=
		(Options.IncludeWatercraft OR
		Options.IncludeWatercraftOwner); 

	EXPORT DoFDCJoin_Watercraft_Files__Watercraft_SID :=
		(Options.IncludeWatercraft OR
		Options.IncludeWatercraftOwner);
		
	EXPORT DoFDCJoin_Tradeline_Files__Tradeline__Key_LinkIds := 
		NOT Options.isFCRA AND 
		(Options.IncludeTradeline or 
		Options.IncludeTradelineBusiness);
		
	EXPORT DoFDCJoin_Business_Files__Business__Key_BH_Linking_Ids :=
		NOT Options.isFCRA AND
		 (Options.IncludeBusiness or
		 Options.IncludeTradelineBusiness);  

END;