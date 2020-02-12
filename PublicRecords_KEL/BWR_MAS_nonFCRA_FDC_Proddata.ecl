﻿// EXPORT BWR_MAS_nonFCRA_FDC_Proddata := 'todo';

IMPORT KEL011 AS KEL;
import ut, PublicRecords_KEL, STD,RiskWise;


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
BOOLEAN FDC := FALSE; //defaulted to false in query to see FDC turn on.  File to big to output when = TRUE
BOOLEAN Accident := TRUE;
BOOLEAN Address := TRUE;
BOOLEAN Aircraft := TRUE;
BOOLEAN Bankruptcy := TRUE;
BOOLEAN BusinessSele := TRUE;
BOOLEAN BusinessProx := TRUE;
BOOLEAN CriminalOffender := TRUE;
BOOLEAN CriminalOffense := TRUE;
BOOLEAN CriminalPunishment := TRUE;
BOOLEAN DriversLicense := TRUE;
BOOLEAN Education := TRUE;
BOOLEAN Email := TRUE;
BOOLEAN Employment := TRUE;
BOOLEAN Household := TRUE;
BOOLEAN Inquiry := TRUE;
BOOLEAN Person := TRUE;
BOOLEAN Phone := TRUE;
BOOLEAN ProfessionalLicense := TRUE;
BOOLEAN Property := TRUE;
BOOLEAN PropertyEvent := TRUE;
BOOLEAN SocialSecurityNumber := TRUE;
BOOLEAN TIN := TRUE;
BOOLEAN Tradeline := TRUE;
BOOLEAN Utility := TRUE;
BOOLEAN Vehicle := TRUE;
BOOLEAN Watercraft := TRUE;
BOOLEAN ZipCode := TRUE;
BOOLEAN UCC := TRUE;


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
		EXPORT STRING100 PermissiblePurpose         := '';
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
		// BIP Append Options
		EXPORT UNSIGNED BIPAppendScoreThreshold  := 75;
		EXPORT UNSIGNED BIPAppendWeightThreshold := 0;
		EXPORT BOOLEAN BIPAppendPrimForce        := FALSE;
		EXPORT BOOLEAN BIPAppendReAppend         := TRUE;
		EXPORT BOOLEAN BIPAppendIncludeAuthRep   := FALSE;

		EXPORT UNSIGNED8 KEL_Permissions_Mask := 
				PublicRecords_KEL.ECL_Functions.Fn_KEL_DPMBitmap.Generate(
						DataRestrictionMask := Data_Restriction_Mask, 
						DataPermissionMask  := Data_Permission_Mask, 
						GLBA                := GLBAPurpose, 
						DPPA                := DPPAPurpose, 
						isFCRA              := isFCRA, 
						isMarketing         := isMarketing, 
						AllowDNBDMI         := Allow_DNBDMI, 
						OverrideExperianRestriction := Override_Experian_Restriction, 
						PermissiblePurpose  := '',
						IndustryClass  := '',
						KELPermissions      := PublicRecords_KEL.CFG_Compile, 
						IsInsuranceProduct  := Is_Insurance_Product );
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
		BOOLEAN ViewFDC;
		BOOLEAN IncludeAccident;
		BOOLEAN IncludeAddress;
		BOOLEAN IncludeAircraft;
		BOOLEAN IncludeBankruptcy;
		BOOLEAN IncludeBusinessSele;
		BOOLEAN IncludeBusinessProx ;
		BOOLEAN IncludeCriminalOffender;
		BOOLEAN IncludeCriminalOffense;
		BOOLEAN IncludeCriminalPunishment ;
		BOOLEAN IncludeDriversLicense;
		BOOLEAN IncludeEducation;
		BOOLEAN IncludeEmail;
		BOOLEAN IncludeEmployment ;
		BOOLEAN IncludeHousehold;
		BOOLEAN IncludeInquiry;
		BOOLEAN IncludePerson;
		BOOLEAN IncludePhone;
		BOOLEAN IncludeProfessionalLicense;
		BOOLEAN IncludeProperty ;
		BOOLEAN IncludePropertyEvent;
		BOOLEAN IncludeSocialSecurityNumber;
		BOOLEAN IncludeTIN;
		BOOLEAN IncludeTradeline ;
		BOOLEAN IncludeUtility ;
		BOOLEAN IncludeVehicle;
		BOOLEAN IncludeWatercraft;
		BOOLEAN IncludeZipCode;
		BOOLEAN IncludeUCC ;
end;

soapLayout trans_pre (pp le, Integer c):= TRANSFORM 
		SELF.input := PROJECT(le, TRANSFORM(PublicRecords_KEL.ECL_Functions.Input_Bus_Layout,
		SELF := LEFT;
    SELF := []));	
		SELF.InputArchiveDateClean := (INTEGER)dtArchiveDate;
		SELF.DataRestrictionMask := m.Options.Data_Restriction_Mask;
		SELF.DataPermissionMask := m.Options.Data_Permission_Mask;
		SELF.GLBA := (STRING)m.Options.GLBAPurpose;
		SELF.DPPA := (STRING)m.Options.DPPAPurpose;
		SELF.PDPM := (STRING)m.Options.KEL_Permissions_Mask;
		SELF.ViewFDC := FDC; //defaulted to false in query to see FDC turn on
		self.IncludeAccident := Accident;
		self.IncludeAddress := Address;
		self.IncludeAircraft := Aircraft;
		self.IncludeBankruptcy := Bankruptcy;
		self.IncludeBusinessSele := BusinessSele;
		self.IncludeBusinessProx := BusinessProx;
		self.IncludeCriminalOffender := CriminalOffender;
		self.IncludeCriminalOffense := CriminalOffense;
		self.IncludeCriminalPunishment := CriminalPunishment;
		self.IncludeDriversLicense := DriversLicense;
		self.IncludeEducation := Education;
		self.IncludeEmail := Email;
		self.IncludeEmployment := Employment;
		self.IncludeHousehold := Household;
		self.IncludeInquiry := Inquiry;
		self.IncludePerson := Person;
		self.IncludePhone := Phone;
		self.IncludeProfessionalLicense := ProfessionalLicense;
		self.IncludeProperty := Property;
		self.IncludePropertyEvent := PropertyEvent;
		self.IncludeSocialSecurityNumber := SocialSecurityNumber;
		self.IncludeTIN := TIN;
		self.IncludeTradeline := Tradeline;
		self.IncludeUtility := Utility;
		self.IncludeVehicle := Vehicle;
		self.IncludeWatercraft := Watercraft;
		self.IncludeZipCode := ZipCode;
		self.IncludeUCC := UCC;
		SELF := [];
END;

soap_in := PROJECT(pp, trans_pre(LEFT, Counter));

OUTPUT(CHOOSEN(p_in, eyeball), NAMED('Sample_Input'));
OUTPUT(CHOOSEN(soap_in, eyeball), NAMED('Sample_SOAPInput'));

OutputFDC := {recordof(PublicRecords_KEL.ECL_Functions.Layouts_FDC(m.Options).Layout_FDC)};

layout_FDC_Service := RECORD

	OutputFDC LayoutFDC {XPATH('Results/Result/Dataset[@name=\'FDCDataset\']/Row')};

		STRING ErrorCode;
END;
	
layout_FDC_Service myFail(soap_in le) := TRANSFORM

	SELF.ErrorCode := STD.Str.FilterOut(TRIM(FAILCODE + ' ' + FAILMESSAGE), '\n');
		SELF := [];
END;

bwr_results := 
				SOAPCALL(soap_in, 
				RoxieIP,
				'PublicRecords_KEL.MAS_nonFCRA_FDC_Proddata_Service.3', //prox assoc
				{soap_in}, 
				DATASET(layout_FDC_Service),
				XPATH('*'),
        RETRY(2), TIMEOUT(300),
				PARALLEL(threads), 
        onFail(myFail(LEFT)));

output(bwr_results, named('soap_out'));

Passed := bwr_results(TRIM(ErrorCode) = ''); // Use as input to KEL query.
Failed := bwr_results(TRIM(ErrorCode) <> '');

output(Failed, named('Failed_Resutls'));

OUTPUT(Passed,,OutputFile, Thor, overwrite);