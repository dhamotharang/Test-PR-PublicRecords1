// DF-22213	SBFE extract for Account Management
#OPTION('multiplePersistInstances',FALSE);
#WORKUNIT('name','SBFE Extract for Account Management');
IMPORT	Business_Credit, Address, STD, SALT38, Data_Services;
// Requirement Number: 1.2	
// Requirement:  Account selection criteria
// Randomly select 1M accounts from each of the following account types, 001, 002, 003, 004, and 006 
AccountTypeReportedSet	:=	['001','002','003','004','006'];
// with cycle end dates1 within January 2015. Repeat process for January 2016 and January 2017. 
CycleEndDateStartDay			:=	'0101';
CycleEndDateEndDay					:=	'0131';
CycleEndDateStartYear		:=	'2015';
CycleEndDateEndYear				:=	'2017';
dLinkIDs															:=	Business_Credit.Files().LinkIDs(
																											active AND 
																											record_type IN ['AB','IS']	AND
																											// account types 001, 002, 003, 004, and 006 
																											Account_Type_Reported	IN AccountTypeReportedSet	AND
																											//	Jan 1-31
																											Cycle_End_Date[5..8] >= CycleEndDateStartDay	AND
																											Cycle_End_Date[5..8] <= CycleEndDateEndDay	AND
																											// 2015-2017
																											Cycle_End_Date[1..4] >= CycleEndDateStartYear	AND
																											Cycle_End_Date[1..4] <= CycleEndDateEndYear
																										);

rBusinessBII	:=	RECORD
	STRING8			Cycle_End_Date;
	STRING1			Primary_Address_Indicator;
	UNSIGNED6	UltID;
	UNSIGNED6	OrgID;
	UNSIGNED6	SELEID;
	UNSIGNED6	ProxID;
	UNSIGNED6	POWID;
	STRING250	Business_Name;
	STRING				Business_Street_Address;
	STRING50		Business_City;
	STRING2			Business_State;
	STRING10		Business_Zip_Code;
	STRING10		Business_Phone;
	STRING9			Business_FEIN;
END;

rPersonPII	:=	RECORD
	STRING8			Cycle_End_Date;
	STRING1			Primary_Phone_Indicator;
	UNSIGNED6	LexID;
	STRING20		First_Name;
	STRING20		Last_Name;
	STRING				Street_Address;
	STRING50		City;
	STRING2			State;
	STRING10		Zip_Code;
	STRING10		Phone;
	STRING9			SSN;
END;

// Prepare all Records for Validation
rValidateLayout	:=	RECORD
	STRING30	Sbfe_Contributor_Number					:=	dLinkIDs.Sbfe_Contributor_Number;
	STRING50	Contract_Account_Number					:=	dLinkIDs.Contract_Account_Number;
	STRING3		Account_Type_Reported							:=	dLinkIDs.Account_Type_Reported;
	STRING8		Date_Account_Opened									:=	dLinkIDs.Tradeline.Date_Account_Opened;
	STRING1		Multiple_Account_Open_Dates	:=	'';
	STRING8		Cycle_End_Date														:=	dLinkIDs.Cycle_End_Date;

	//	Fill Business Information if this is an AB Segment
	DATASET(rBusinessBII)	businessBII		:=	IF(dLinkIDs.Record_Type = Business_Credit.Constants().AB,
																						DATASET([
																							{
																								dLinkIDs.Cycle_End_Date
																								,dLinkIDs.Primary_Address_Indicator
																								,dLinkIDs.UltID
																								,dLinkIDs.OrgID
																								,dLinkIDs.SELEID
																								,dLinkIDs.ProxID
																								,dLinkIDs.POWID
																								,dLinkIDs.Clean_Business_Name
																								,Address.Addr1FromComponents(
																									dLinkIDs.prim_range
																									,dLinkIDs.predir
																									,dLinkIDs.prim_name
																									,dLinkIDs.addr_suffix
																									,dLinkIDs.postdir
																									,dLinkIDs.unit_desig
																									,dLinkIDs.sec_range
																								)
																								,dLinkIDs.p_city_name
																								,dLinkIDs.st
																								,dLinkIDs.zip+IF(TRIM(dLinkIDs.zip4,LEFT,RIGHT)<>'','-'+TRIM(dLinkIDs.zip4,LEFT,RIGHT),'')
																								,dLinkIDs.Phone_Number
																								,dLinkIDs.Federal_TaxID_SSN
																							}
																						],rBusinessBII),
																						DATASET([],rBusinessBII)
																					);

	//	001 = Owner
	//	002 = Guarantor
	//	003 = Both Owner and Guarantor
	//	Fill Owner Information if this is an Individual Owner Segment (IS) and Guarantor_Owner_Indicator IN ['001','003']
	DATASET(rPersonPII)		ownerPII			:=	IF(	dLinkIDs.Record_Type = Business_Credit.Constants().IS	AND
																							dLinkIDs.Guarantor_Owner_Indicator IN ['001','003'],
																						DATASET([
																							{
																								dLinkIDs.Cycle_End_Date
																								,dLinkIDs.Primary_Phone_Indicator
																								,dLinkIDs.did
																								,dLinkIDs.Clean_fname
																								,dLinkIDs.Clean_lname
																								,Address.Addr1FromComponents(
																									dLinkIDs.prim_range
																									,dLinkIDs.predir
																									,dLinkIDs.prim_name
																									,dLinkIDs.addr_suffix
																									,dLinkIDs.postdir
																									,dLinkIDs.unit_desig
																									,dLinkIDs.sec_range
																								)
																								,dLinkIDs.p_city_name
																								,dLinkIDs.st
																								,dLinkIDs.zip+IF(TRIM(dLinkIDs.zip4,LEFT,RIGHT)<>'','-'+TRIM(dLinkIDs.zip4,LEFT,RIGHT),'')
																								,dLinkIDs.Phone_Number
																								,dLinkIDs.Federal_TaxID_SSN
																							}
																						],rPersonPII),
																						DATASET([],rPersonPII)
																					);
																				
	//	Fill Guarantor Information if this is an Individual Owner Segment (IS) and Guarantor_Owner_Indicator IN ['002','003']
	DATASET(rPersonPII)		guarantorPII	:=	IF(	dLinkIDs.Record_Type = Business_Credit.Constants().IS	AND
																						dLinkIDs.Guarantor_Owner_Indicator IN ['002','003'],
																					DATASET([
																						{
																							dLinkIDs.Cycle_End_Date
																							,dLinkIDs.Primary_Phone_Indicator
																							,dLinkIDs.did
																							,dLinkIDs.Clean_fname
																							,dLinkIDs.Clean_lname
																							,Address.Addr1FromComponents(
																								dLinkIDs.prim_range
																								,dLinkIDs.predir
																								,dLinkIDs.prim_name
																								,dLinkIDs.addr_suffix
																								,dLinkIDs.postdir
																								,dLinkIDs.unit_desig
																								,dLinkIDs.sec_range
																							)
																							,dLinkIDs.p_city_name
																							,dLinkIDs.st
																							,dLinkIDs.zip+IF(TRIM(dLinkIDs.zip4,LEFT,RIGHT)<>'','-'+TRIM(dLinkIDs.zip4,LEFT,RIGHT),'')
																							,dLinkIDs.Phone_Number
																							,dLinkIDs.Federal_TaxID_SSN
																						}
																					],rPersonPII),
																					DATASET([],rPersonPII)
																				);
END;

//	Prepare Records
dValidateLayout	:=	TABLE(dLinkIDs,rValidateLayout):PERSIST('~persist::out::sbfe::AccountManagementExtractData');
OUTPUT(CHOOSEN(dValidateLayout,2000),NAMED('SampleValidateLayout'));

RECORDOF(dValidateLayout)	tValidateLayout(dValidateLayout	l,	DATASET(RECORDOF(dValidateLayout)) allRows)	:=	TRANSFORM
// Requirement Number: 1.2	
// Requirement:  Account selection criteria
// Randomly select 1M accounts from each of the following account types, 001, 002, 003, 004, and 006 
// with cycle end dates1 within January 2015. Repeat process for January 2016 and January 2017. 
// Development Comments: 
// It is critical that these accounts are randomly selected.
// 1 If the account appears multiples within a specific month select the earliest end cycle date. 
	SELF.Cycle_End_Date														:=	MIN(allRows,allRows.Cycle_End_Date);
// This should result in approximately 15M accounts. Account type 002 will have less than 1M accounts for each month. 
// Exclusions developed for previous extract requests should not be applied.
 
// An indicator (0/1) should be created and returned to indicate when an account has more than 
// one account open date available.
	SELF.Date_Account_Opened									:=	MIN(allRows,allRows.Date_Account_Opened);
	SELF.Multiple_Account_Open_Dates	:=	IF(COUNT(DEDUP(SORT(allRows,Date_Account_Opened),Date_Account_Opened))=1,'0','1');
	SELF.businessBII																	:=	allRows.businessBII;
	SELF.ownerPII																				:=	allRows.ownerPII;
	SELF.guarantorPII																:=	allRows.guarantorPII;
	SELF																													:=	l;
END;

// Requirement Number: 1.1	
// Requirement: Definition of Account
// An account is a unique combination of the SBFE contributor number, account/contract number, and account type.
// If the account appears multiples within a specific month select the earliest end cycle date. 
dValidateRecords	:=	ROLLUP(
											GROUP(SORT(DISTRIBUTE(dValidateLayout,
												HASH(	Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,Cycle_End_Date[1..6])),
																		Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,Cycle_End_Date[1..6],LOCAL),
																		Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,Cycle_End_Date[1..6],LOCAL),
											GROUP,
											tValidateLayout(LEFT,ROWS(LEFT))
										):PERSIST('~persist::rollup::sbfe::AccountManagementExtractData');

dValidRecords	:=	dValidateRecords;
OUTPUT(COUNT(dValidRecords),NAMED('Account_Management_Account_Selection_Criteria_Count'));
OUTPUT(CHOOSEN(dValidRecords,200),NAMED('Account_Management_Account_Selection_Criteria_Sample'));

// Requirement Number: 3.1	
// Requirement:  Input / Header File
// For all accounts selected in Req. 1.2, please create a CSV file containing the following columns. Each record should represent one unique account.
// 1.	SBFE contributor number
// 2.	Account/contract number
// 3.	Account type
// 4.	Account open date4
// 5.	Cycle end date (YYYYMMDD)
// 6.	Multiple account open date flag5
// 7.	UltID
// 8.	OrgID
// 9.	SeleID
// 10.	ProxID
// 11.	PowID
// 12.	Business Name
// 13.	Business Street Address
// 14.	Business City
// 15.	Business State
// 16.	Business Zip
// 17.	Business Phone
// 18.	Business FEIN
// 19.	Owner LexID 
// 20.	Owner First Name
// 21.	Owner Last Name
// 22.	Owner Street Address
// 23.	Owner City
// 24.	Owner State
// 25.	Owner Zip
// 26.	Owner Phone
// 27.	Owner SSN
// 28.	Guarantor LexID 
// 29.	Guarantor First Name
// 30.	Guarantor Last Name
// 31.	Guarantor Street Address
// 32.	Guarantor City
// 33.	Guarantor State
// 34.	Guarantor Zip
// 35.	Guarantor Phone
// 36.	Guarantor SSN
// If necessary, break the full file into smaller parts in order to expedite file transmission.
// Development Comments: 
// 4 If multiple account open dates are associated with the account, this should return the earliest account open date.
// 5 Return ‘0’ if only one account open date is reported for the account.  Return ‘1’ if more than one account open date is reported with the account.
rAccountManagementExtractDataLayout	:=	RECORD
	STRING30		Sbfe_Contributor_Number;
	STRING50		Contract_Account_Number;
	STRING3			Account_Type_Reported;
	STRING8			Date_Account_Opened;
	STRING8			Cycle_End_Date;
	STRING1			Multiple_Account_Open_Dates;
	UNSIGNED6	UltID;
	UNSIGNED6	OrgID;
	UNSIGNED6	SELEID;
	UNSIGNED6	ProxID;
	UNSIGNED6	POWID;
	STRING250	Business_Name;
	STRING				Business_Street_Address;
	STRING50		Business_City;
	STRING2			Business_State;
	STRING10		Business_Zip_Code;
	STRING10		Business_Phone;
	STRING9			Business_FEIN;
	UNSIGNED6	Owner_LexID;
	STRING20		Owner_First_Name;
	STRING20		Owner_Last_Name;
	STRING				Owner_Street_Address;
	STRING50		Owner_City;
	STRING2			Owner_State;
	STRING10		Owner_Zip_Code;
	STRING10		Owner_Phone;
	STRING9			Owner_SSN;
	UNSIGNED6	Guarantor_LexID;
	STRING20		Guarantor_First_Name;
	STRING20		Guarantor_Last_Name;
	STRING				Guarantor_Street_Address;
	STRING50		Guarantor_City;
	STRING2			Guarantor_State;
	STRING10		Guarantor_Zip_Code;
	STRING10		Guarantor_Phone;
	STRING9			Guarantor_SSN;
END;

rAccountManagementExtractDataLayout	tAccountManagementExtractData(rValidateLayout	pInput)	:=	TRANSFORM
	SELF.Sbfe_Contributor_Number					:=	pInput.Sbfe_Contributor_Number;
	SELF.Contract_Account_Number					:=	pInput.Contract_Account_Number;
	SELF.Account_Type_Reported							:=	pInput.Account_Type_Reported;
	SELF.Date_Account_Opened									:=	pInput.Date_Account_Opened;
	SELF.Cycle_End_Date														:=	pInput.Cycle_End_Date;
	SELF.Multiple_Account_Open_Dates	:=	pInput.Multiple_Account_Open_Dates;
	
	/******************************/
	/*	Get Business Information	*/
	/******************************/
// Requirement Number: 2.1	
// Requirement: Business Identity / Input Elements
// Select the following clean business identity elements reported for the business account holder as of the 
// first end cycle date reported for the account.  
// If there are multiple addresses reported as of the first end cycle date, for example, give preference to an 
// address identified as primary.  If there are multiple primary addresses, then choose the address reported 
// most frequently.  Else, select the first address listed.  This approach applies to all identity elements. 
// 1.	UltID
// 2.	OrgID
// 3.	SeleID
// 4.	ProxID
// 5.	PowID
// 6.	Business Name
// 7.	Business Street Address
// 8.	Business City
// 9.	Business State
// 10.	Business Zip
// 11.	Business Phone
// 12.	Business FEIN
	pBusinessAddress1	:=	SORT(TABLE(
																							SORT(pInput.businessBII(Cycle_End_Date = pInput.Cycle_End_Date AND Business_Street_Address <> ''),
																								Business_Street_Address,Business_City,Business_State,Business_Zip_Code,Primary_Address_Indicator),
																							{Business_Street_Address,Business_City,Business_State,Business_Zip_Code,Primary_Address_Indicator,cnt:=COUNT(GROUP)},
																							Business_Street_Address,Business_City,Business_State,Business_Zip_Code,Primary_Address_Indicator,FEW
																						),Primary_Address_Indicator<>'Y',-cnt)[1];
	pBusinessAddress2	:=	SORT(TABLE(
																							SORT(pInput.businessBII(Business_Street_Address <> ''),
																								Business_Street_Address,Business_City,Business_State,Business_Zip_Code,Primary_Address_Indicator),
																							{Business_Street_Address,Business_City,Business_State,Business_Zip_Code,Primary_Address_Indicator,cnt:=COUNT(GROUP)},
																							Business_Street_Address,Business_City,Business_State,Business_Zip_Code,Primary_Address_Indicator,FEW
																						),Primary_Address_Indicator<>'Y',-cnt)[1];
	pBusinessAddress		:=	IF(pBusinessAddress1.Business_Street_Address<>'',pBusinessAddress1,pBusinessAddress2);
	pBusinessBII						:=	SORT(pInput.businessBII,cycle_end_date,-Business_Phone,-Business_FEIN)(
																							Business_Street_Address		=	pBusinessAddress.Business_Street_Address	AND
																							Business_City							=	pBusinessAddress.Business_City						AND
																							Business_State						=	pBusinessAddress.Business_State						AND
																							Business_Zip_Code					=	pBusinessAddress.Business_Zip_Code				AND
																							Primary_Address_Indicator	=	pBusinessAddress.Primary_Address_Indicator
																						)[1];

	SELF.UltID																			:=	pBusinessBII.UltID;
	SELF.OrgID																			:=	pBusinessBII.OrgID;
	SELF.SELEID																		:=	pBusinessBII.SELEID;
	SELF.ProxID																		:=	pBusinessBII.ProxID;
	SELF.POWID																			:=	pBusinessBII.POWID;
	SELF.Business_Name											:=	pBusinessBII.Business_Name;
	SELF.Business_Street_Address	:=	pBusinessBII.Business_Street_Address;
	SELF.Business_City											:=	pBusinessBII.Business_City;
	SELF.Business_State										:=	pBusinessBII.Business_State;
	SELF.Business_Zip_Code							:=	pBusinessBII.Business_Zip_Code;
	SELF.Business_Phone										:=	pBusinessBII.Business_Phone;
	SELF.Business_FEIN											:=	pBusinessBII.Business_FEIN;
	
	/******************************/
	/*	Get Owner Information			*/
	/******************************/
// Requirement Number: 2.2	
// Requirement:  Owner Selection
// Select (1) person as the owner of the business.
// Using the individual owners reported in the IS segment (001 or 003)2 as of the account’s first end cycle date, 
// please select the person and input combination that returns a LexID.  If multiple LexIDs exist, then choose 
// the person reported most frequently.  Else, choose the first person listed.  
// Development Comments: 
// 2 Use field IS-10 (Guarantor/Owner Indicator): 001 = Owner, 002 = Guarantor, 003 = Both Owner and Guarantor.
// If the person is identified as both the owner and guarantor, then the person should appear in both the owner 
// and guarantor section of the return file.  If no person is identified as of the first cycle end date, then 
// both the owner and guarantor section should be left blank.
// A previous SBFE extract script may have linked individual PII to an account by the POWID found in the 
// trade line (AB) segment and the individual (IS) segment.  Ideally, we would merge individual PII to the 
// account by the unique account number.  If the merge requires a BIP ID, then SELE ID should be used.
// Previous extract results showed that owner/guarantor information was predominately only available for 
// commercial credit cards (account type 003).  This is an unexpected result and may warrant additional investigation.
// Requirement Number: 2.3
// Requirement:  Owner Identity / Input Elements
// Select the following clean owner identity elements for the owner selected in Req. 2.2 as of the 
// first end cycle date.
// 1.	Owner LexID 
// 2.	Owner First Name
// 3.	Owner Last Name
// 4.	Owner Street Address
// 5.	Owner City
// 6.	Owner State
// 7.	Owner Zip
// 8.	Owner Phone
// 9.	Owner SSN
	pOwnerLexID1	:=	SORT(TABLE(
																		SORT(pInput.ownerPII(Cycle_End_Date = pInput.Cycle_End_Date AND LexID > 0),LexID),
																		{LexID,cnt:=COUNT(GROUP)},
																		LexID,FEW
																	),-cnt)[1].LexID; // <-- If multiple LexIDs exist, then choose the person reported most frequently
	pOwnerLexID2	:=	SORT(pInput.ownerPII(First_Name<>'' AND	Last_Name<>''),Cycle_End_Date,-LexID)[1].LexID; // <-- Else, choose the first person listed.  
	pOwnerLexID		:=	IF(pOwnerLexID1>0,pOwnerLexID1,pOwnerLexID2);
	pOwnerPII				:=	SORT(pInput.ownerPII(First_Name<>'' AND	Last_Name<>''),Cycle_End_Date,-LexID,-Phone,-SSN)(
																					LexID	=	pOwnerLexID
																	)[1];
	SELF.Owner_LexID										:=	pOwnerPII.LexID;
	SELF.Owner_First_Name					:=	pOwnerPII.First_Name;
	SELF.Owner_Last_Name						:=	pOwnerPII.Last_Name;
	SELF.Owner_Street_Address	:=	pOwnerPII.Street_Address;
	SELF.Owner_City											:=	pOwnerPII.City;
	SELF.Owner_State										:=	pOwnerPII.State;
	SELF.Owner_Zip_Code							:=	pOwnerPII.Zip_Code;
	SELF.Owner_Phone										:=	pOwnerPII.Phone;
	SELF.Owner_SSN												:=	pOwnerPII.SSN;
	
	/******************************/
	/*	Get Guarantor Information	*/
	/******************************/
// Requirement Number: 2.4	
// Requirement:  Guarantor Selection
// Select (1) person as the guarantor of the business.
// Using the individual guarantors reported in the IS segment (002 or 003)3 as of the account’s first end 
// cycle date, please select the person and input combination that returns a LexID.  If multiple LexIDs 
// exist, then choose the person reported most frequently.  Else, choose the first person listed.
// Development Comments: 
// 3 Use field IS-10 (Guarantor/Owner Indicator): 001 = Owner, 002 = Guarantor, 003 = Both Owner and Guarantor.
// If the person is identified as both the owner and guarantor, then the person should appear in both the owner 
// and guarantor section of the return file.  If no person is identified as of the first cycle end date, then 
// both the owner and guarantor section should be left blank.
// Requirement Number: 2.5
// Requirement:  Guarantor Identity / Input Elements
// Select the following clean guarantor identity elements for the owner selected in Req. 2.4 as of the end cycle date.
// 1.	Guarantor LexID 
// 2.	Guarantor First Name
// 3.	Guarantor Last Name
// 4.	Guarantor Street Address
// 5.	Guarantor City
// 6.	Guarantor State
// 7.	Guarantor Zip
// 8.	Guarantor Phone
// 9.	Guarantor SSN
	pGuarantorLexID1	:=	SORT(TABLE(
																						SORT(pInput.guarantorPII(Cycle_End_Date = pInput.Cycle_End_Date AND LexID > 0),LexID),
																						{LexID,cnt:=COUNT(GROUP)},
																						LexID,FEW
																					),-cnt)[1].LexID;
	pGuarantorLexID2	:=	SORT(pInput.guarantorPII(First_Name<>'' AND	Last_Name<>''),Cycle_End_Date,-LexID)[1].LexID;
	pGuarantorLexID		:=	IF(pGuarantorLexID1>0,pGuarantorLexID1,pGuarantorLexID2);
	pGuarantorPII				:=	SORT(pInput.guarantorPII(First_Name<>'' AND	Last_Name<>''),Cycle_End_Date,-LexID,-Phone,-SSN)(
																						LexID	=	pGuarantorLexID
																					)[1];
	SELF.Guarantor_LexID										:=	pGuarantorPII.LexID;
	SELF.Guarantor_First_Name					:=	pGuarantorPII.First_Name;
	SELF.Guarantor_Last_Name						:=	pGuarantorPII.Last_Name;
	SELF.Guarantor_Street_Address	:=	pGuarantorPII.Street_Address;
	SELF.Guarantor_City											:=	pGuarantorPII.City;
	SELF.Guarantor_State										:=	pGuarantorPII.State;
	SELF.Guarantor_Zip_Code							:=	pGuarantorPII.Zip_Code;
	SELF.Guarantor_Phone										:=	pGuarantorPII.Phone;
	SELF.Guarantor_SSN												:=	pGuarantorPII.SSN;
END;

dAccountManagementExtractData	:=	PROJECT(dValidRecords,tAccountManagementExtractData(LEFT));
OUTPUT(COUNT(dAccountManagementExtractData),NAMED('Account_Management_Extract_Count'));
OUTPUT(CHOOSEN(dAccountManagementExtractData(Owner_LexID>0 AND Guarantor_LexID>0),1000),NAMED('Account_Management_Extract_Sample'));

dAccountManagementExtractDataSort	:=	SORT(DISTRIBUTE(dAccountManagementExtractData,
															HASH(	Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,Date_Account_Opened)),
																					Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,Date_Account_Opened,LOCAL):PERSIST('~persist::out::sbfe::AccountManagementExtractDataSort');

// Randomly select 1M accounts from each of the following account types, 001, 002, 003, 004, and 006 
// with cycle end dates1 within January 2015. Repeat process for January 2016 and January 2017. 
dAccountManagementExtractDataJan2015_001	:=	CHOOSEN(DISTRIBUTE(dAccountManagementExtractDataSort(Account_Type_Reported	IN ['001'] AND cycle_end_date[1..4] IN ['2015']),RANDOM()),1000000);
dAccountManagementExtractDataJan2015_002	:=	CHOOSEN(DISTRIBUTE(dAccountManagementExtractDataSort(Account_Type_Reported	IN ['002'] AND cycle_end_date[1..4] IN ['2015']),RANDOM()),1000000);
dAccountManagementExtractDataJan2015_003	:=	CHOOSEN(DISTRIBUTE(dAccountManagementExtractDataSort(Account_Type_Reported	IN ['003'] AND cycle_end_date[1..4] IN ['2015']),RANDOM()),1000000);
dAccountManagementExtractDataJan2015_004	:=	CHOOSEN(DISTRIBUTE(dAccountManagementExtractDataSort(Account_Type_Reported	IN ['004'] AND cycle_end_date[1..4] IN ['2015']),RANDOM()),1000000);
dAccountManagementExtractDataJan2015_006	:=	CHOOSEN(DISTRIBUTE(dAccountManagementExtractDataSort(Account_Type_Reported	IN ['006'] AND cycle_end_date[1..4] IN ['2015']),RANDOM()),1000000);
dAccountManagementExtractDataJan2016_001	:=	CHOOSEN(DISTRIBUTE(dAccountManagementExtractDataSort(Account_Type_Reported	IN ['001'] AND cycle_end_date[1..4] IN ['2016']),RANDOM()),1000000);
dAccountManagementExtractDataJan2016_002	:=	CHOOSEN(DISTRIBUTE(dAccountManagementExtractDataSort(Account_Type_Reported	IN ['002'] AND cycle_end_date[1..4] IN ['2016']),RANDOM()),1000000);
dAccountManagementExtractDataJan2016_003	:=	CHOOSEN(DISTRIBUTE(dAccountManagementExtractDataSort(Account_Type_Reported	IN ['003'] AND cycle_end_date[1..4] IN ['2016']),RANDOM()),1000000);
dAccountManagementExtractDataJan2016_004	:=	CHOOSEN(DISTRIBUTE(dAccountManagementExtractDataSort(Account_Type_Reported	IN ['004'] AND cycle_end_date[1..4] IN ['2016']),RANDOM()),1000000);
dAccountManagementExtractDataJan2016_006	:=	CHOOSEN(DISTRIBUTE(dAccountManagementExtractDataSort(Account_Type_Reported	IN ['006'] AND cycle_end_date[1..4] IN ['2016']),RANDOM()),1000000);
dAccountManagementExtractDataJan2017_001	:=	CHOOSEN(DISTRIBUTE(dAccountManagementExtractDataSort(Account_Type_Reported	IN ['001'] AND cycle_end_date[1..4] IN ['2017']),RANDOM()),1000000);
dAccountManagementExtractDataJan2017_002	:=	CHOOSEN(DISTRIBUTE(dAccountManagementExtractDataSort(Account_Type_Reported	IN ['002'] AND cycle_end_date[1..4] IN ['2017']),RANDOM()),1000000);
dAccountManagementExtractDataJan2017_003	:=	CHOOSEN(DISTRIBUTE(dAccountManagementExtractDataSort(Account_Type_Reported	IN ['003'] AND cycle_end_date[1..4] IN ['2017']),RANDOM()),1000000);
dAccountManagementExtractDataJan2017_004	:=	CHOOSEN(DISTRIBUTE(dAccountManagementExtractDataSort(Account_Type_Reported	IN ['004'] AND cycle_end_date[1..4] IN ['2017']),RANDOM()),1000000);
dAccountManagementExtractDataJan2017_006	:=	CHOOSEN(DISTRIBUTE(dAccountManagementExtractDataSort(Account_Type_Reported	IN ['006'] AND cycle_end_date[1..4] IN ['2017']),RANDOM()),1000000);

dAccountManagementRandomSelection	:=	
	dAccountManagementExtractDataJan2015_001	+
	dAccountManagementExtractDataJan2015_002	+
	dAccountManagementExtractDataJan2015_003	+
	dAccountManagementExtractDataJan2015_004	+
	dAccountManagementExtractDataJan2015_006	+
	dAccountManagementExtractDataJan2016_001	+
	dAccountManagementExtractDataJan2016_002	+
	dAccountManagementExtractDataJan2016_003	+
	dAccountManagementExtractDataJan2016_004	+
	dAccountManagementExtractDataJan2016_006	+
	dAccountManagementExtractDataJan2017_001	+
	dAccountManagementExtractDataJan2017_002	+
	dAccountManagementExtractDataJan2017_003	+
	dAccountManagementExtractDataJan2017_004	+
	dAccountManagementExtractDataJan2017_006;

SEQUENTIAL(
	STD.File.StartSuperFileTransaction(),
	STD.File.CreateSuperFile('~thor::out::sbfe::AccountManagementExtractData',,TRUE),
	STD.File.ClearSuperFile('~thor::out::sbfe::AccountManagementExtractData',TRUE),
	STD.File.FinishSuperFileTransaction(),
	OUTPUT(dAccountManagementExtractDataJan2015_001,,'~thor::out::sbfe::AccountManagementExtractDataJan2015_001',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE,COMPRESSED),
	OUTPUT(dAccountManagementExtractDataJan2015_002,,'~thor::out::sbfe::AccountManagementExtractDataJan2015_002',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE,COMPRESSED),
	OUTPUT(dAccountManagementExtractDataJan2015_003,,'~thor::out::sbfe::AccountManagementExtractDataJan2015_003',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE,COMPRESSED),
	OUTPUT(dAccountManagementExtractDataJan2015_004,,'~thor::out::sbfe::AccountManagementExtractDataJan2015_004',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE,COMPRESSED),
	OUTPUT(dAccountManagementExtractDataJan2015_006,,'~thor::out::sbfe::AccountManagementExtractDataJan2015_006',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE,COMPRESSED),
	OUTPUT(dAccountManagementExtractDataJan2016_001,,'~thor::out::sbfe::AccountManagementExtractDataJan2016_001',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE,COMPRESSED),
	OUTPUT(dAccountManagementExtractDataJan2016_002,,'~thor::out::sbfe::AccountManagementExtractDataJan2016_002',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE,COMPRESSED),
	OUTPUT(dAccountManagementExtractDataJan2016_003,,'~thor::out::sbfe::AccountManagementExtractDataJan2016_003',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE,COMPRESSED),
	OUTPUT(dAccountManagementExtractDataJan2016_004,,'~thor::out::sbfe::AccountManagementExtractDataJan2016_004',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE,COMPRESSED),
	OUTPUT(dAccountManagementExtractDataJan2016_006,,'~thor::out::sbfe::AccountManagementExtractDataJan2016_006',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE,COMPRESSED),
	OUTPUT(dAccountManagementExtractDataJan2017_001,,'~thor::out::sbfe::AccountManagementExtractDataJan2017_001',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE,COMPRESSED),
	OUTPUT(dAccountManagementExtractDataJan2017_002,,'~thor::out::sbfe::AccountManagementExtractDataJan2017_002',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE,COMPRESSED),
	OUTPUT(dAccountManagementExtractDataJan2017_003,,'~thor::out::sbfe::AccountManagementExtractDataJan2017_003',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE,COMPRESSED),
	OUTPUT(dAccountManagementExtractDataJan2017_004,,'~thor::out::sbfe::AccountManagementExtractDataJan2017_004',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE,COMPRESSED),
	OUTPUT(dAccountManagementExtractDataJan2017_006,,'~thor::out::sbfe::AccountManagementExtractDataJan2017_006',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE,COMPRESSED),
	STD.File.StartSuperFileTransaction(),
	STD.File.AddSuperFile('~thor::out::sbfe::AccountManagementExtractData','~thor::out::sbfe::AccountManagementExtractDataJan2015_001'),
	STD.File.AddSuperFile('~thor::out::sbfe::AccountManagementExtractData','~thor::out::sbfe::AccountManagementExtractDataJan2015_002'),
	STD.File.AddSuperFile('~thor::out::sbfe::AccountManagementExtractData','~thor::out::sbfe::AccountManagementExtractDataJan2015_003'),
	STD.File.AddSuperFile('~thor::out::sbfe::AccountManagementExtractData','~thor::out::sbfe::AccountManagementExtractDataJan2015_004'),
	STD.File.AddSuperFile('~thor::out::sbfe::AccountManagementExtractData','~thor::out::sbfe::AccountManagementExtractDataJan2015_006'),
	STD.File.AddSuperFile('~thor::out::sbfe::AccountManagementExtractData','~thor::out::sbfe::AccountManagementExtractDataJan2016_001'),
	STD.File.AddSuperFile('~thor::out::sbfe::AccountManagementExtractData','~thor::out::sbfe::AccountManagementExtractDataJan2016_002'),
	STD.File.AddSuperFile('~thor::out::sbfe::AccountManagementExtractData','~thor::out::sbfe::AccountManagementExtractDataJan2016_003'),
	STD.File.AddSuperFile('~thor::out::sbfe::AccountManagementExtractData','~thor::out::sbfe::AccountManagementExtractDataJan2016_004'),
	STD.File.AddSuperFile('~thor::out::sbfe::AccountManagementExtractData','~thor::out::sbfe::AccountManagementExtractDataJan2016_006'),
	STD.File.AddSuperFile('~thor::out::sbfe::AccountManagementExtractData','~thor::out::sbfe::AccountManagementExtractDataJan2017_001'),
	STD.File.AddSuperFile('~thor::out::sbfe::AccountManagementExtractData','~thor::out::sbfe::AccountManagementExtractDataJan2017_002'),
	STD.File.AddSuperFile('~thor::out::sbfe::AccountManagementExtractData','~thor::out::sbfe::AccountManagementExtractDataJan2017_003'),
	STD.File.AddSuperFile('~thor::out::sbfe::AccountManagementExtractData','~thor::out::sbfe::AccountManagementExtractDataJan2017_004'),
	STD.File.AddSuperFile('~thor::out::sbfe::AccountManagementExtractData','~thor::out::sbfe::AccountManagementExtractDataJan2017_006'),
	STD.File.FinishSuperFileTransaction()
);


// Requirement Number: 3.2	
// Requirement:  Trade line File
// From the first cycle date reported for each account selected in Req. 1.2, please create a CSV file that 
// contains (2) years6 of trade line data for each account. Each record should contain the following information.
// 1.	SBFE contributor number
// 2.	Account/contract number
// 3.	Account type
// 4.	Account open date7
// 5.	All other trade line data from the AB segment / key (see the SBFE Data Layout)
// If necessary, break the full file into smaller parts in order to expedite file transmission.
// Development Comments: 
// 6 Some accounts may not have 24 months of trade line (AB) data reported.  In these cases, return all 
// trade line (AB) records available.
// 7 If multiple account open dates are associated with the account, this should return the earliest account 
// open date.

dAccountManagementRandomExtract	:=	DATASET(Data_Services.foreign_prod+'thor::out::sbfe::AccountManagementExtractData',rAccountManagementExtractDataLayout,CSV(HEADING(1),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)));
dAccountManagementTradelineData	:=	JOIN(
											SORT(DISTRIBUTE(PULL(Business_Credit.key_tradeline()),	HASH(Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported)),Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,LOCAL),
											SORT(DISTRIBUTE(dAccountManagementRandomExtract,							HASH(Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported)),Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,LOCAL),
												LEFT.Sbfe_Contributor_Number	=		RIGHT.Sbfe_Contributor_Number	AND
												LEFT.Contract_Account_Number	=		RIGHT.Contract_Account_Number	AND
												LEFT.Account_Type_Reported			=		RIGHT.Account_Type_Reported			AND
												(INTEGER)LEFT.Cycle_End_Date	>=	(INTEGER)RIGHT.Cycle_End_Date	AND
												(INTEGER)LEFT.Cycle_End_Date	<=	(INTEGER)Std.Date.AdjustDate((INTEGER)RIGHT.Cycle_End_Date,2),
											TRANSFORM(LEFT),
											LOCAL
										);
dAccountManagementTradelineDataSort	:=	SORT(DISTRIBUTE(dAccountManagementTradelineData,
																HASH(	Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,Cycle_End_Date,Date_Account_Opened)),
																						Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,Cycle_End_Date,Date_Account_Opened,LOCAL):PERSIST('~persist::out::sbfe::AccountManagementTradelineDataSort');

OUTPUT(COUNT(dAccountManagementTradelineDataSort),NAMED('Account_Management_Tradeline_Sample_Count'));
OUTPUT(CHOOSEN(dAccountManagementTradelineDataSort,1000),NAMED('Account_Management_Tradeline_Sample'));

// TABLE(dAccountManagementTradelineDataSort,{Cycle_End_Date[1..4],COUNT(GROUP)},Cycle_End_Date[1..4],FEW);

SEQUENTIAL(
	STD.File.StartSuperFileTransaction(),
	STD.File.CreateSuperFile('~thor::out::sbfe::AccountManagementTradelineData201807',,TRUE),
	STD.File.ClearSuperFile('~thor::out::sbfe::AccountManagementTradelineData201807',TRUE),
	STD.File.FinishSuperFileTransaction(),
	OUTPUT(dAccountManagementTradelineDataSort(Cycle_End_Date[1..4] IN ['2015']	AND Account_Type_Reported	IN ['001']),,'~thor::out::sbfe::AccountManagementTradelineData201807_2015_001',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE,COMPRESSED),
	OUTPUT(dAccountManagementTradelineDataSort(Cycle_End_Date[1..4] IN ['2015']	AND Account_Type_Reported	IN ['002']),,'~thor::out::sbfe::AccountManagementTradelineData201807_2015_002',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE,COMPRESSED),
	OUTPUT(dAccountManagementTradelineDataSort(Cycle_End_Date[1..4] IN ['2015']	AND Account_Type_Reported	IN ['003']),,'~thor::out::sbfe::AccountManagementTradelineData201807_2015_003',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE,COMPRESSED),
	OUTPUT(dAccountManagementTradelineDataSort(Cycle_End_Date[1..4] IN ['2015']	AND Account_Type_Reported	IN ['004']),,'~thor::out::sbfe::AccountManagementTradelineData201807_2015_004',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE,COMPRESSED),
	OUTPUT(dAccountManagementTradelineDataSort(Cycle_End_Date[1..4] IN ['2015']	AND Account_Type_Reported	IN ['006']),,'~thor::out::sbfe::AccountManagementTradelineData201807_2015_006',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE,COMPRESSED),
	OUTPUT(dAccountManagementTradelineDataSort(Cycle_End_Date[1..4] IN ['2016']	AND Account_Type_Reported	IN ['001']),,'~thor::out::sbfe::AccountManagementTradelineData201807_2016_001',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE,COMPRESSED),
	OUTPUT(dAccountManagementTradelineDataSort(Cycle_End_Date[1..4] IN ['2016']	AND Account_Type_Reported	IN ['002']),,'~thor::out::sbfe::AccountManagementTradelineData201807_2016_002',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE,COMPRESSED),
	OUTPUT(dAccountManagementTradelineDataSort(Cycle_End_Date[1..4] IN ['2016']	AND Account_Type_Reported	IN ['003']),,'~thor::out::sbfe::AccountManagementTradelineData201807_2016_003',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE,COMPRESSED),
	OUTPUT(dAccountManagementTradelineDataSort(Cycle_End_Date[1..4] IN ['2016']	AND Account_Type_Reported	IN ['004']),,'~thor::out::sbfe::AccountManagementTradelineData201807_2016_004',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE,COMPRESSED),
	OUTPUT(dAccountManagementTradelineDataSort(Cycle_End_Date[1..4] IN ['2016']	AND Account_Type_Reported	IN ['006']),,'~thor::out::sbfe::AccountManagementTradelineData201807_2016_006',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE,COMPRESSED),
	OUTPUT(dAccountManagementTradelineDataSort(Cycle_End_Date[1..4] IN ['2017']	AND Account_Type_Reported	IN ['001']),,'~thor::out::sbfe::AccountManagementTradelineData201807_2017_001',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE,COMPRESSED),
	OUTPUT(dAccountManagementTradelineDataSort(Cycle_End_Date[1..4] IN ['2017']	AND Account_Type_Reported	IN ['002']),,'~thor::out::sbfe::AccountManagementTradelineData201807_2017_002',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE,COMPRESSED),
	OUTPUT(dAccountManagementTradelineDataSort(Cycle_End_Date[1..4] IN ['2017']	AND Account_Type_Reported	IN ['003']),,'~thor::out::sbfe::AccountManagementTradelineData201807_2017_003',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE,COMPRESSED),
	OUTPUT(dAccountManagementTradelineDataSort(Cycle_End_Date[1..4] IN ['2017']	AND Account_Type_Reported	IN ['004']),,'~thor::out::sbfe::AccountManagementTradelineData201807_2017_004',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE,COMPRESSED),
	OUTPUT(dAccountManagementTradelineDataSort(Cycle_End_Date[1..4] IN ['2017']	AND Account_Type_Reported	IN ['006']),,'~thor::out::sbfe::AccountManagementTradelineData201807_2017_006',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE,COMPRESSED),
	OUTPUT(dAccountManagementTradelineDataSort(Cycle_End_Date[1..4] IN ['2018']	AND Account_Type_Reported	IN ['001']),,'~thor::out::sbfe::AccountManagementTradelineData201807_2018_001',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE,COMPRESSED),
	OUTPUT(dAccountManagementTradelineDataSort(Cycle_End_Date[1..4] IN ['2018']	AND Account_Type_Reported	IN ['002']),,'~thor::out::sbfe::AccountManagementTradelineData201807_2018_002',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE,COMPRESSED),
	OUTPUT(dAccountManagementTradelineDataSort(Cycle_End_Date[1..4] IN ['2018']	AND Account_Type_Reported	IN ['003']),,'~thor::out::sbfe::AccountManagementTradelineData201807_2018_003',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE,COMPRESSED),
	OUTPUT(dAccountManagementTradelineDataSort(Cycle_End_Date[1..4] IN ['2018']	AND Account_Type_Reported	IN ['004']),,'~thor::out::sbfe::AccountManagementTradelineData201807_2018_004',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE,COMPRESSED),
	OUTPUT(dAccountManagementTradelineDataSort(Cycle_End_Date[1..4] IN ['2018']	AND Account_Type_Reported	IN ['006']),,'~thor::out::sbfe::AccountManagementTradelineData201807_2018_006',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE,COMPRESSED),
	STD.File.StartSuperFileTransaction(),
	STD.File.AddSuperFile('~thor::out::sbfe::AccountManagementTradelineData201807','~thor::out::sbfe::AccountManagementTradelineData201807_2015_001'),
	STD.File.AddSuperFile('~thor::out::sbfe::AccountManagementTradelineData201807','~thor::out::sbfe::AccountManagementTradelineData201807_2015_002'),
	STD.File.AddSuperFile('~thor::out::sbfe::AccountManagementTradelineData201807','~thor::out::sbfe::AccountManagementTradelineData201807_2015_003'),
	STD.File.AddSuperFile('~thor::out::sbfe::AccountManagementTradelineData201807','~thor::out::sbfe::AccountManagementTradelineData201807_2015_004'),
	STD.File.AddSuperFile('~thor::out::sbfe::AccountManagementTradelineData201807','~thor::out::sbfe::AccountManagementTradelineData201807_2015_006'),
	STD.File.AddSuperFile('~thor::out::sbfe::AccountManagementTradelineData201807','~thor::out::sbfe::AccountManagementTradelineData201807_2016_001'),
	STD.File.AddSuperFile('~thor::out::sbfe::AccountManagementTradelineData201807','~thor::out::sbfe::AccountManagementTradelineData201807_2016_002'),
	STD.File.AddSuperFile('~thor::out::sbfe::AccountManagementTradelineData201807','~thor::out::sbfe::AccountManagementTradelineData201807_2016_003'),
	STD.File.AddSuperFile('~thor::out::sbfe::AccountManagementTradelineData201807','~thor::out::sbfe::AccountManagementTradelineData201807_2016_004'),
	STD.File.AddSuperFile('~thor::out::sbfe::AccountManagementTradelineData201807','~thor::out::sbfe::AccountManagementTradelineData201807_2016_006'),
	STD.File.AddSuperFile('~thor::out::sbfe::AccountManagementTradelineData201807','~thor::out::sbfe::AccountManagementTradelineData201807_2017_001'),
	STD.File.AddSuperFile('~thor::out::sbfe::AccountManagementTradelineData201807','~thor::out::sbfe::AccountManagementTradelineData201807_2017_002'),
	STD.File.AddSuperFile('~thor::out::sbfe::AccountManagementTradelineData201807','~thor::out::sbfe::AccountManagementTradelineData201807_2017_003'),
	STD.File.AddSuperFile('~thor::out::sbfe::AccountManagementTradelineData201807','~thor::out::sbfe::AccountManagementTradelineData201807_2017_004'),
	STD.File.AddSuperFile('~thor::out::sbfe::AccountManagementTradelineData201807','~thor::out::sbfe::AccountManagementTradelineData201807_2017_006'),
	STD.File.AddSuperFile('~thor::out::sbfe::AccountManagementTradelineData201807','~thor::out::sbfe::AccountManagementTradelineData201807_2018_001'),
	STD.File.AddSuperFile('~thor::out::sbfe::AccountManagementTradelineData201807','~thor::out::sbfe::AccountManagementTradelineData201807_2018_002'),
	STD.File.AddSuperFile('~thor::out::sbfe::AccountManagementTradelineData201807','~thor::out::sbfe::AccountManagementTradelineData201807_2018_003'),
	STD.File.AddSuperFile('~thor::out::sbfe::AccountManagementTradelineData201807','~thor::out::sbfe::AccountManagementTradelineData201807_2018_004'),
	STD.File.AddSuperFile('~thor::out::sbfe::AccountManagementTradelineData201807','~thor::out::sbfe::AccountManagementTradelineData201807_2018_006'),
	STD.File.FinishSuperFileTransaction()
);

	// /******************************************/
	// /*	Account Management Extract SALT Report	*/
	// /******************************************/
SALT38.MAC_Profile(dAccountManagementRandomExtract);

