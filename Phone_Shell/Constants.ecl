EXPORT Constants := MODULE
	// Phone Restriction Mask - Controls which types of phones can be returned
	EXPORT PRM := ENUM(AllPhones = 0,
										SubjectDIDOnly = 1,
										LastNameAddressOnly = 2,
										SSNOnly = 3,
										AddressOnly = 4,
										FirstDegreeRelativeOnly = 5);
																			
	EXPORT Phone_Subject_Level := ENUM(Subject = 1,
																		 Household = 2,
																		 FirstDegreeRelative = 3,
																		 LeadToSubject = 4);
																			
	EXPORT Default_MaxPhones := 99;
	
	EXPORT maxEQP_Phones := 3;
	
	EXPORT Default_DataPermission := '000000000000000'; // Currently 9 bits - see AutoStandardI.DataPermissionI for bit definitions, by default don't turn any on

	EXPORT default_DataRestriction := '000001000100110000000000'; 

	EXPORT Default_InsuranceVerificationAgeLimit := 730; // In days (2 Years)

	EXPORT Default_SPIIAccessLevel := ''; // Should have 5A or 5B to use TransUnion Gateway
	
	EXPORT HeaderSearchDate := 1826; // 5 Years (Including 1 extra day for leap years) since this is the oldest phone search (EDAHistory)
	
	EXPORT HeaderSixMonthsDate := 183; // 6 Months is used in Phones Plus and EDA Search by Address
	
	//if position 24 is populated then do not run Equifax	
	EXPORT posEquifaxRestriction := 24;
	
	EXPORT Default_PhoneScore := 217;
	
	EXPORT EquiaxDRMCheck(string DataRestrictionMask) := (DataRestrictionMask[posEquifaxRestriction] = '0' or DataRestrictionMask[posEquifaxRestriction] = '');

	EXPORT Src_Equifax := 'EQP';
END;