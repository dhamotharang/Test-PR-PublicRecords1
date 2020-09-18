IMPORT Business_Credit, ut, Address;
AcctOpenStartDate	:=	'20180101';
AcctOpenEndDate		:=	'20191231';
// All Active Records
// dActive			:=	Business_Credit.Files().Active(active);
dActive			:=	Business_Credit.Files().ActiveLookupSBFE;
// Sort/Distribute our input records
dActiveDist	:=	SORT(DISTRIBUTE(dActive,
									HASH(	portfolioHeader.Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported)),
												portfolioHeader.Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,LOCAL);

// Prepare all AB Segments for Validation
rValidateLayout	:=	RECORD
	STRING30	Sbfe_Contributor_Number				:=	dActive.portfolioHeader.Sbfe_Contributor_Number;
	STRING50	Contract_Account_Number				:=	dActive.Contract_Account_Number;
	STRING3		Account_Type_Reported					:=	dActive.Account_Type_Reported;
	STRING8		Date_Account_Opened						:=	dActive.Date_Account_Opened;
	STRING250	Account_Holder_Business_Name	:=	dActive.Account_Holder_Business_Name;
	STRING8		Cycle_End_Date								:=	dActive.portfolioHeader.Cycle_End_Date;
	BOOLEAN		bValidAccountOpenRange				:=	FALSE;
	BOOLEAN		bUniqueAccountOpenDate				:=	FALSE;
	BOOLEAN		bValidAccountOpenCycleEndDate	:=	FALSE;
	BOOLEAN		bValidBusinessName						:=	FALSE;
	BOOLEAN		bValidAddress									:=	FALSE;
// Requirement Number: 2.1
// Requirement: Business Identity / Input Elements
// If there are multiple addresses reported as of the first cycle date, for example, 
// give preference to an address identified as primary.  Else, select the first address reported.  
// This approach applies to all identity elements. 
	Business_Credit.Layouts.AD	address			:=	SORT(dActive.address,-Primary_Address_Indicator)[1];
	Business_Credit.Layouts.PN	phone				:=	SORT(dActive.phone,-Primary_Phone_Indicator)[1];
	Business_Credit.Layouts.TI	taxID				:=	dActive.taxID((UNSIGNED)Federal_TaxID_SSN>0)[1];
		// 001 = Owner
		// 002 = Guarantor
		// 003 = Both Owner and Guarantor
// Development Comments: 
// If the person is identified as both the owner and guarantor, then the person should appear 
// in both the owner and guarantor section of the return file.
	DATASET(Business_Credit.Layouts.IndividualOwnerLayout)	individualOwner			:=	dActive.individualOwner(Guarantor_Owner_Indicator IN ['001','003']);
	DATASET(Business_Credit.Layouts.IndividualOwnerLayout)	individualGuarantor	:=	dActive.individualOwner(Guarantor_Owner_Indicator IN ['002','003']);
END;

dValidateLayout	:=	TABLE(dActiveDist,rValidateLayout);

// Requirement Number: 1.2
// Requirement:  Account selection criteria
RECORDOF(dValidateLayout)	tValidateLayout(dValidateLayout	l,	DATASET(RECORDOF(dValidateLayout)) allRows)	:=	TRANSFORM
// Requirement Number: 3.2
// From the first cycle date reported for each account selected in Req. 1.2, 
// please create a CSV file that contains (2) years of trade line data for each account. 
	SELF.Cycle_End_Date									:=	MIN(allRows,allRows.Cycle_End_Date);
// Select all accounts with an account open date of January 1, 2011 – December 31, 2012, except for the following:
	SELF.bValidAccountOpenRange					:=	MIN(allRows,allRows.Date_Account_Opened)	>=	AcctOpenStartDate	AND
																					MAX(allRows,allRows.Date_Account_Opened)	<=	AcctOpenEndDate;
// 1.	Accounts with no business name or address populated as of the first cycle date.
	SELF.bValidBusinessName							:=	TRIM(l.Account_Holder_Business_Name,LEFT,RIGHT)<>'';
	SELF.bValidAddress									:=	l.address.Segment_Identifier='AD';
// 2.	Accounts with more than one account open date.
	SELF.bUniqueAccountOpenDate					:=	COUNT(DEDUP(SORT(allRows,Date_Account_Opened),Date_Account_Opened))=1;
// 3.	Accounts with an account open date that occurs after the first cycle date reported for the account.
// 4.	Accounts where the account open date occurs more than 18 months prior to the first cycle date.
	SELF.bValidAccountOpenCycleEndDate	:=	MIN(allRows,allRows.Date_Account_Opened) < l.Cycle_End_Date	AND
																					ut.DaysApart(MIN(allRows,allRows.Date_Account_Opened),l.Cycle_End_Date)<549;
	SELF																:=	l;
END;

dValidateRecords	:=	ROLLUP(
												GROUP(SORT(DISTRIBUTE(dValidateLayout,
													HASH(	Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported)),
																Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,Cycle_End_Date,LOCAL),
																Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,LOCAL),
												GROUP,
												tValidateLayout(LEFT,ROWS(LEFT))
											);

dValidRecords	:=	dValidateRecords(
																		bValidAccountOpenRange	AND
																		bValidBusinessName			AND
																		bValidAddress						AND
																		bUniqueAccountOpenDate	AND
																		bValidAccountOpenCycleEndDate
																	);
																	
// Requirement 1.2
// Expected account total = 1.2 million
OUTPUT(COUNT(dValidRecords),NAMED('Account_Selection_Criteria_Count'));
OUTPUT(CHOOSEN(dValidRecords,1000),NAMED('Account_Selection_Criteria_Sample'));

// Requirement Number: 3.1
// Requirement:  Input / Header File
rPreExtractDataLayout	:=	RECORD
	STRING30	Sbfe_Contributor_Number;
	STRING50	Contract_Account_Number;
	STRING3		Account_Type_Reported;
	STRING8		Date_Account_Opened;
	UNSIGNED6	UltID;
	UNSIGNED6	OrgID;
	UNSIGNED6	SELEID;
	UNSIGNED6	ProxID;
	UNSIGNED6	POWID;
	STRING250	Business_Name;
	STRING		Business_Street_Address;
	STRING50	Business_City;
	STRING2		Business_State;
	STRING6		Business_Zip_Code;
	STRING10	Business_Phone;
	STRING9		Business_FEIN;
	UNSIGNED6	Owner_LexID;
	STRING20	Owner_First_Name;
	STRING20	Owner_Last_Name;
	STRING		Owner_Street_Address;
	STRING50	Owner_City;
	STRING2		Owner_State;
	STRING6		Owner_Zip_Code;
	STRING10	Owner_Phone;
	STRING9		Owner_SSN;
	UNSIGNED6	Guarantor_LexID;
	STRING20	Guarantor_First_Name;
	STRING20	Guarantor_Last_Name;
	STRING		Guarantor_Street_Address;
	STRING50	Guarantor_City;
	STRING2		Guarantor_State;
	STRING6		Guarantor_Zip_Code;
	STRING10	Guarantor_Phone;
	STRING9		Guarantor_SSN;
	
	DATASET(Business_Credit.Layouts.IndividualOwnerLayout)	individualOwner;
	DATASET(Business_Credit.Layouts.IndividualOwnerLayout)	individualGuarantor;
END;
												
dValidRecordsDist	:=	SORT(DISTRIBUTE(dValidRecords,
												HASH(	Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,
															address.Address_Line_1,address.Address_Line_2,address.City,address.State,address.Zip_Code_or_CA_Postal_Code,
															phone.Area_Code,phone.Phone_Number,TaxID.Federal_TaxID_SSN)),
															Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,
															address.Address_Line_1,address.Address_Line_2,address.City,address.State,address.Zip_Code_or_CA_Postal_Code,
															phone.Area_Code,phone.Phone_Number,TaxID.Federal_TaxID_SSN,LOCAL);
												
dBIPLinkIDsDist		:=	SORT(DISTRIBUTE(Business_Credit.Key_BusinessInformation()(record_type='AB'),
												HASH(	Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,
															Original_Address_Line_1,Original_Address_Line_2,Original_City,Original_State,Original_Zip_Code_or_CA_Postal_Code,
															Original_Area_Code,Original_Phone_Number,Federal_TaxID_SSN)),
															Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,
															Original_Address_Line_1,Original_Address_Line_2,Original_City,Original_State,Original_Zip_Code_or_CA_Postal_Code,
															Original_Area_Code,Original_Phone_Number,Federal_TaxID_SSN,LOCAL);

rPreExtractDataLayout	tGetBIPIds(dValidRecordsDist	l,	dBIPLinkIDsDist	r)	:=	TRANSFORM
// Requirement Number: 2.1
	SELF.Sbfe_Contributor_Number	:=	IF(r.Sbfe_Contributor_Number<>'',r.Sbfe_Contributor_Number,l.Sbfe_Contributor_Number);
	SELF.Contract_Account_Number	:=	IF(r.Contract_Account_Number<>'',r.Contract_Account_Number,l.Contract_Account_Number);
	SELF.Account_Type_Reported		:=	IF(r.Account_Type_Reported<>'',r.Account_Type_Reported,l.Account_Type_Reported);
	SELF.Date_Account_Opened			:=	l.Date_Account_Opened;
	SELF.UltID										:=	r.UltID;
	SELF.OrgID										:=	r.OrgID;
	SELF.SELEID										:=	r.SELEID;
	SELF.ProxID										:=	r.ProxID;
	SELF.POWID										:=	r.POWID;
	SELF.Business_Name						:=	IF(r.Clean_Account_Holder_Business_Name<>'',r.Clean_Account_Holder_Business_Name,l.Account_Holder_Business_Name);
	SELF.Business_Street_Address	:=	IF(r.Sbfe_Contributor_Number<>'',
																			Address.Addr1FromComponents(r.prim_range,r.predir,r.prim_name,r.addr_suffix,r.postdir,r.unit_desig,r.sec_range),
																			l.address.Address_Line_1+l.address.Address_Line_2);
	SELF.Business_City						:=	IF(r.v_city_name<>'',r.v_city_name,l.address.City);
	SELF.Business_State						:=	IF(r.st<>'',r.st,l.address.State);
	SELF.Business_Zip_Code				:=	IF(r.zip<>'',r.zip,l.address.Zip_Code_or_CA_Postal_Code);
	SELF.Business_Phone						:=	IF(r.Phone_Number<>'',r.Phone_Number,TRIM(l.phone.Area_Code+l.phone.Phone_Number,LEFT,RIGHT));
	SELF.Business_FEIN						:=	IF(r.Federal_TaxID_SSN<>'',r.Federal_TaxID_SSN,l.TaxID.Federal_TaxID_SSN);

	SELF.individualOwner					:=	l.individualOwner;
	SELF.individualGuarantor			:=	l.individualGuarantor;
	SELF													:=	[];
END;

dGetBIPIds	:=	JOIN(
									dValidRecordsDist,
									dBIPLinkIDsDist,
										LEFT.Sbfe_Contributor_Number	=	RIGHT.Sbfe_Contributor_Number	AND
										LEFT.Contract_Account_Number	=	RIGHT.Contract_Account_Number	AND
										LEFT.Account_Type_Reported		=	RIGHT.Account_Type_Reported		AND
										LEFT.address.Address_Line_1		=	RIGHT.Original_Address_Line_1	AND
										LEFT.address.Address_Line_2		=	RIGHT.Original_Address_Line_2	AND
										LEFT.address.City							=	RIGHT.Original_City						AND
										LEFT.address.State						=	RIGHT.Original_State					AND
										LEFT.address.Zip_Code_or_CA_Postal_Code	=	RIGHT.Original_Zip_Code_or_CA_Postal_Code	AND
										LEFT.phone.Area_Code					=	RIGHT.Original_Area_Code			AND
										LEFT.phone.Phone_Number				=	RIGHT.Original_Phone_Number		AND
										LEFT.TaxID.Federal_TaxID_SSN	=	RIGHT.Federal_TaxID_SSN,
									tGetBIPIds(LEFT,RIGHT),
									LEFT OUTER,
									KEEP(1),
									LOCAL
								);

// Requirement 1.2
// Expected unique seleID total = 1 million
OUTPUT(COUNT(DEDUP(SORT(DISTRIBUTE(dGetBIPIds,HASH(SELEID)),SELEID,LOCAL),SELEID,LOCAL)),NAMED('Unique_SeleID_Count'));

// Requirement Number: 2.2
// Requirement:  Owner Selection
rPreExtractDataLayout	tGetIndividual(rPreExtractDataLayout L,	UNSIGNED cnt)	:=	TRANSFORM
	SELF.Owner_First_Name			:=	L.individualOwner[cnt].Original_fname;
	SELF.Owner_Last_Name			:=	L.individualOwner[cnt].Original_lname;
	addr											:=	SORT(L.individualOwner[cnt].address,-Primary_Address_Indicator)[1];
	phone											:=	SORT(L.individualOwner[cnt].phone,-Primary_Phone_Indicator)[1];
	taxID											:=	L.individualOwner[cnt].taxID((UNSIGNED)Federal_TaxID_SSN>0)[1];
	SELF.Owner_Street_Address	:=	TRIM(addr.Address_Line_1+addr.Address_Line_2,LEFT,RIGHT);
	SELF.Owner_City						:=	addr.City;
	SELF.Owner_State					:=	addr.State;
	SELF.Owner_Zip_Code				:=	addr.Zip_Code_or_CA_Postal_Code;
	SELF.Owner_Phone					:=	phone.Area_Code+phone.Phone_Number;
	SELF.Owner_SSN						:=	taxID.Federal_TaxID_SSN;
	SELF.individualOwner			:=	[];
	SELF.individualGuarantor	:=	[];
	SELF											:=	L;
	SELF											:=	[];
END;
dIndividual	:=	NORMALIZE(dGetBIPIds(COUNT(individualOwner)>0),COUNT(LEFT.individualOwner),tGetIndividual(LEFT,COUNTER));

dIndividualDist	:=	SORT(DISTRIBUTE(dIndividual,
												HASH(	Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,
															UltID,OrgID,SELEID,ProxID,POWID,Business_Name,
															Owner_First_Name,Owner_Last_Name)),
															Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,
															UltID,OrgID,SELEID,ProxID,POWID,Business_Name,
															Owner_First_Name,Owner_Last_Name,LOCAL);

OUTPUT(CHOOSEN(dIndividualDist,1000),NAMED('dIndividualDist'));
												
dLexIDDist			:=	SORT(DISTRIBUTE(Business_Credit.Key_BusinessInformation()(record_type='IS'),
												HASH(	Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,
															UltID,OrgID,SELEID,ProxID,POWID,Clean_Account_Holder_Business_Name,
															original_fname,original_lname)),
															Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,
															UltID,OrgID,SELEID,ProxID,POWID,Clean_Account_Holder_Business_Name,
// Requirement Number: 2.2
// Requirement:  Owner Selection
// 2.	Give preference to owners with a LexID populated.
															original_fname,original_lname,-did,LOCAL);

rPreExtractDataLayout	tGetIndividualOwnerIds(dIndividualDist	l,	dLexIDDist	r)	:=	TRANSFORM
// Requirement Number: 2.3
// Requirement:  Owner Identity / Input Elements
	SELF.Sbfe_Contributor_Number	:=	l.Sbfe_Contributor_Number;
	SELF.Contract_Account_Number	:=	l.Contract_Account_Number;
	SELF.Account_Type_Reported		:=	l.Account_Type_Reported;
	SELF.Date_Account_Opened			:=	l.Date_Account_Opened;
	SELF.UltID										:=	l.UltID;
	SELF.OrgID										:=	l.OrgID;
	SELF.SELEID										:=	l.SELEID;
	SELF.ProxID										:=	l.ProxID;
	SELF.POWID										:=	l.POWID;
	SELF.Business_Name						:=	l.Business_Name;
	SELF.Business_Street_Address	:=	l.Business_Street_Address;
	SELF.Business_City						:=	l.Business_City;
	SELF.Business_State						:=	l.Business_State;
	SELF.Business_Zip_Code				:=	l.Business_Zip_Code;
	SELF.Business_Phone						:=	l.Business_Phone;
	SELF.Business_FEIN						:=	l.Business_FEIN;
	
	SELF.Owner_LexID							:=	r.did;
	SELF.Owner_First_Name					:=	IF(r.clean_fname<>'',r.clean_fname,l.Owner_First_Name);
	SELF.Owner_Last_Name					:=	IF(r.clean_lname<>'',r.clean_lname,l.Owner_Last_Name);
	SELF.Owner_Street_Address			:=	IF(r.did>0,
																			Address.Addr1FromComponents(r.prim_range,r.predir,r.prim_name,r.addr_suffix,r.postdir,r.unit_desig,r.sec_range),
																			l.Owner_Street_Address);
	SELF.Owner_City								:=	IF(r.did>0,r.v_city_name,l.Owner_City);
	SELF.Owner_State							:=	IF(r.did>0,r.st,l.Owner_State);
	SELF.Owner_Zip_Code						:=	IF(r.did>0,r.zip,l.Owner_Zip_Code);
	SELF.Owner_Phone							:=	IF(r.did>0,r.Phone_Number,l.Owner_Phone);
	SELF.Owner_SSN								:=	IF(r.did>0,r.Federal_TaxID_SSN,l.Owner_SSN);

	SELF													:=	[];
END;

dGetIndividualOwnerIds	:=	JOIN(
															dIndividualDist,
															dLexIDDist,
																LEFT.Sbfe_Contributor_Number	=	RIGHT.Sbfe_Contributor_Number	AND
																LEFT.Contract_Account_Number	=	RIGHT.Contract_Account_Number	AND
																LEFT.Account_Type_Reported		=	RIGHT.Account_Type_Reported		AND
																LEFT.UltID										=	RIGHT.UltID										AND
																LEFT.OrgID										=	RIGHT.OrgID										AND
																LEFT.SELEID										=	RIGHT.SELEID									AND
																LEFT.ProxID										=	RIGHT.ProxID									AND
																LEFT.POWID										=	RIGHT.POWID										AND
																LEFT.Business_Name						=	RIGHT.Clean_Account_Holder_Business_Name	AND
																LEFT.Owner_First_Name					=	RIGHT.original_fname					AND
																LEFT.Owner_Last_Name					=	RIGHT.original_lname,
															tGetIndividualOwnerIds(LEFT,RIGHT),
															LEFT OUTER,
															LOCAL
														);

// Requirement Number: 2.4
// Requirement:  Guarantor Selection

rPreExtractDataLayout	tGetGuarantor(rPreExtractDataLayout L,	UNSIGNED cnt)	:=	TRANSFORM
	SELF.Guarantor_First_Name			:=	L.individualGuarantor[cnt].Original_fname;
	SELF.Guarantor_Last_Name			:=	L.individualGuarantor[cnt].Original_lname;
	addr													:=	SORT(L.individualGuarantor[cnt].address,-Primary_Address_Indicator)[1];
	phone													:=	SORT(L.individualGuarantor[cnt].phone,-Primary_Phone_Indicator)[1];
	taxID													:=	L.individualGuarantor[cnt].taxID((UNSIGNED)Federal_TaxID_SSN>0)[1];
	SELF.Guarantor_Street_Address	:=	TRIM(addr.Address_Line_1+addr.Address_Line_2,LEFT,RIGHT);
	SELF.Guarantor_City						:=	addr.City;
	SELF.Guarantor_State					:=	addr.State;
	SELF.Guarantor_Zip_Code				:=	addr.Zip_Code_or_CA_Postal_Code;
	SELF.Guarantor_Phone					:=	phone.Area_Code+phone.Phone_Number;
	SELF.Guarantor_SSN						:=	taxID.Federal_TaxID_SSN;
	SELF.individualOwner					:=	[];
	SELF.individualGuarantor			:=	[];
	SELF													:=	L;
	SELF													:=	[];
END;

dGuarantor	:=	NORMALIZE(dGetBIPIds(COUNT(individualGuarantor)>0),COUNT(LEFT.individualGuarantor),tGetGuarantor(LEFT,COUNTER));
dGuarantorDist	:=	SORT(DISTRIBUTE(dGuarantor,
												HASH(	Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,
															UltID,OrgID,SELEID,ProxID,POWID,Business_Name,
															Guarantor_First_Name,Guarantor_Last_Name)),
															Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,
															UltID,OrgID,SELEID,ProxID,POWID,Business_Name,
															Guarantor_First_Name,Guarantor_Last_Name,LOCAL);
OUTPUT(CHOOSEN(dGuarantorDist,1000),NAMED('dGuarantorDist'));
												
rPreExtractDataLayout	tGetIndividualGuarantorIds(dGuarantorDist	l,	dLexIDDist	r)	:=	TRANSFORM
// Requirement Number: 2.5
// Requirement:  Guarantor Identity / Input Elements
	SELF.Sbfe_Contributor_Number	:=	l.Sbfe_Contributor_Number;
	SELF.Contract_Account_Number	:=	l.Contract_Account_Number;
	SELF.Account_Type_Reported		:=	l.Account_Type_Reported;
	SELF.Date_Account_Opened			:=	l.Date_Account_Opened;
	SELF.UltID										:=	l.UltID;
	SELF.OrgID										:=	l.OrgID;
	SELF.SELEID										:=	l.SELEID;
	SELF.ProxID										:=	l.ProxID;
	SELF.POWID										:=	l.POWID;
	SELF.Business_Name						:=	l.Business_Name;
	SELF.Business_Street_Address	:=	l.Business_Street_Address;
	SELF.Business_City						:=	l.Business_City;
	SELF.Business_State						:=	l.Business_State;
	SELF.Business_Zip_Code				:=	l.Business_Zip_Code;
	SELF.Business_Phone						:=	l.Business_Phone;
	SELF.Business_FEIN						:=	l.Business_FEIN;
	
	SELF.Guarantor_LexID					:=	r.did;
	SELF.Guarantor_First_Name			:=	IF(r.clean_fname<>'',r.clean_fname,l.Guarantor_First_Name);
	SELF.Guarantor_Last_Name			:=	IF(r.clean_lname<>'',r.clean_lname,l.Guarantor_Last_Name);
	SELF.Guarantor_Street_Address	:=	IF(r.did>0,
																			Address.Addr1FromComponents(r.prim_range,r.predir,r.prim_name,r.addr_suffix,r.postdir,r.unit_desig,r.sec_range),
																			l.Guarantor_Street_Address);
	SELF.Guarantor_City						:=	IF(r.did>0,r.v_city_name,l.Guarantor_City);
	SELF.Guarantor_State					:=	IF(r.did>0,r.st,l.Guarantor_State);
	SELF.Guarantor_Zip_Code				:=	IF(r.did>0,r.zip,l.Guarantor_Zip_Code);
	SELF.Guarantor_Phone					:=	IF(r.did>0,r.Phone_Number,l.Guarantor_Phone);
	SELF.Guarantor_SSN						:=	IF(r.did>0,r.Federal_TaxID_SSN,l.Guarantor_SSN);

	SELF													:=	[];
END;

dGetGuarantorOwnerIds	:=	JOIN(
															dGuarantorDist,
															dLexIDDist,
																LEFT.Sbfe_Contributor_Number	=	RIGHT.Sbfe_Contributor_Number	AND
																LEFT.Contract_Account_Number	=	RIGHT.Contract_Account_Number	AND
																LEFT.Account_Type_Reported		=	RIGHT.Account_Type_Reported		AND
																LEFT.UltID										=	RIGHT.UltID										AND
																LEFT.OrgID										=	RIGHT.OrgID										AND
																LEFT.SELEID										=	RIGHT.SELEID									AND
																LEFT.ProxID										=	RIGHT.ProxID									AND
																LEFT.POWID										=	RIGHT.POWID										AND
																LEFT.Business_Name						=	RIGHT.Clean_Account_Holder_Business_Name	AND
																LEFT.Guarantor_First_Name			=	RIGHT.original_fname					AND
																LEFT.Guarantor_Last_Name			=	RIGHT.original_lname,
															tGetIndividualGuarantorIds(LEFT,RIGHT),
															LEFT OUTER,
															LOCAL
														);

rPreExtractDataLayout	tRollupIds(rPreExtractDataLayout	L,	rPreExtractDataLayout	R)	:=	TRANSFORM
	SELF.Sbfe_Contributor_Number	:=	L.Sbfe_Contributor_Number;
	SELF.Contract_Account_Number	:=	L.Contract_Account_Number;
	SELF.Account_Type_Reported		:=	L.Account_Type_Reported;
	SELF.Date_Account_Opened			:=	L.Date_Account_Opened;
	SELF.UltID										:=	L.UltID;
	SELF.OrgID										:=	L.OrgID;
	SELF.SELEID										:=	L.SELEID;
	SELF.ProxID										:=	L.ProxID;
	SELF.POWID										:=	L.POWID;
	SELF.Business_Name						:=	L.Business_Name;
	SELF.Business_Street_Address	:=	L.Business_Street_Address;
	SELF.Business_City						:=	L.Business_City;
	SELF.Business_State						:=	L.Business_State;
	SELF.Business_Zip_Code				:=	L.Business_Zip_Code;
	SELF.Business_Phone						:=	L.Business_Phone;
	SELF.Business_FEIN						:=	L.Business_FEIN;
	SELF.Owner_LexID							:=	IF(L.Owner_LexID>0,L.Owner_LexID,R.Owner_LexID);
	SELF.Owner_First_Name					:=	IF(L.Owner_LexID>0,L.Owner_First_Name,R.Owner_First_Name);
	SELF.Owner_Last_Name					:=	IF(L.Owner_LexID>0,L.Owner_Last_Name,R.Owner_Last_Name);
	SELF.Owner_Street_Address			:=	IF(L.Owner_LexID>0,L.Owner_Street_Address,R.Owner_Street_Address);
	SELF.Owner_City								:=	IF(L.Owner_LexID>0,L.Owner_City,R.Owner_City);
	SELF.Owner_State							:=	IF(L.Owner_LexID>0,L.Owner_State,R.Owner_State);
	SELF.Owner_Zip_Code						:=	IF(L.Owner_LexID>0,L.Owner_Zip_Code,R.Owner_Zip_Code);
	SELF.Owner_Phone							:=	IF(L.Owner_LexID>0,L.Owner_Phone,R.Owner_Phone);
	SELF.Owner_SSN								:=	IF(L.Owner_LexID>0,L.Owner_SSN,R.Owner_SSN);
	SELF.Guarantor_LexID					:=	IF(L.Guarantor_LexID>0,L.Guarantor_LexID,R.Guarantor_LexID);
	SELF.Guarantor_First_Name			:=	IF(L.Guarantor_LexID>0,L.Guarantor_First_Name,R.Guarantor_First_Name);
	SELF.Guarantor_Last_Name			:=	IF(L.Guarantor_LexID>0,L.Guarantor_Last_Name,R.Guarantor_Last_Name);
	SELF.Guarantor_Street_Address	:=	IF(L.Guarantor_LexID>0,L.Guarantor_Street_Address,R.Guarantor_Street_Address);
	SELF.Guarantor_City						:=	IF(L.Guarantor_LexID>0,L.Guarantor_City,R.Guarantor_City);
	SELF.Guarantor_State					:=	IF(L.Guarantor_LexID>0,L.Guarantor_State,R.Guarantor_State);
	SELF.Guarantor_Zip_Code				:=	IF(L.Guarantor_LexID>0,L.Guarantor_Zip_Code,R.Guarantor_Zip_Code);
	SELF.Guarantor_Phone					:=	IF(L.Guarantor_LexID>0,L.Guarantor_Phone,R.Guarantor_Phone);
	SELF.Guarantor_SSN						:=	IF(L.Guarantor_LexID>0,L.Guarantor_SSN,R.Guarantor_SSN);
	SELF.individualOwner					:=	[];
	SELF.individualGuarantor			:=	[];
	SELF													:=	[];
END;
											
dIdsDist	:=	SORT(DISTRIBUTE(dGetBIPIds+dGetIndividualOwnerIds+dGetGuarantorOwnerIds,
								HASH(	Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,
											UltID,OrgID,SELEID,ProxID,POWID,Business_Name)),
											Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,
											UltID,OrgID,SELEID,ProxID,POWID,Business_Name,-Owner_LexID,-Guarantor_LexID,LOCAL);

dRollupIds	:=	ROLLUP(	dIdsDist,
													LEFT.Sbfe_Contributor_Number	=	RIGHT.Sbfe_Contributor_Number	AND
													LEFT.Contract_Account_Number	=	RIGHT.Contract_Account_Number	AND
													LEFT.Account_Type_Reported		=	RIGHT.Account_Type_Reported		AND
													LEFT.UltID										=	RIGHT.UltID										AND
													LEFT.OrgID										=	RIGHT.OrgID										AND
													LEFT.SELEID										=	RIGHT.SELEID									AND
													LEFT.ProxID										=	RIGHT.ProxID									AND
													LEFT.POWID										=	RIGHT.POWID										AND
													LEFT.Business_Name						=	RIGHT.Business_Name,
												tRollupIds(LEFT,RIGHT),
												LOCAL
											);
											
OUTPUT(COUNT(dRollupIds),NAMED('Rollup_Sample_Count'));
OUTPUT(CHOOSEN(dRollupIds,1000),NAMED('Rollup_Sample'));

// Requirement Number: 3.1
// Requirement:  Input / Header File
rExtractDataLayout	:=	RECORD
	rPreExtractDataLayout	AND NOT
	[
		individualOwner,
		individualGuarantor
	];
END;

dExtractData			:=	PROJECT(dRollupIds,TRANSFORM(RECORDOF(rExtractDataLayout),SELF:=LEFT));
dExtractDataSort	:=	SORT(DISTRIBUTE(dExtractData,HASH(Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported)),Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,LOCAL);
OUTPUT(dExtractDataSort,,'~thor::out::sbfe::ExtractData',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE);

// Requirement Number: 3.2
// Requirement:  Trade line File
dTradelineData	:=	JOIN(
											SORT(DISTRIBUTE(Business_Credit.key_tradeline(),HASH(Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported)),Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,LOCAL),
											SORT(DISTRIBUTE(dValidRecords,HASH(Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported)),Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,LOCAL),
												LEFT.Sbfe_Contributor_Number	=		RIGHT.Sbfe_Contributor_Number	AND
												LEFT.Contract_Account_Number	=		RIGHT.Contract_Account_Number	AND
												LEFT.Account_Type_Reported		=		RIGHT.Account_Type_Reported		AND
// From the first cycle date reported for each account selected in Req. 1.2, 
// please create a CSV file that contains (2) years of trade line data for each account. 
												(UNSIGNED)LEFT.Cycle_End_Date	<=	(UNSIGNED)RIGHT.Cycle_End_Date+20000,
											TRANSFORM(LEFT),
											LOCAL
										);
dTradelineDataSort	:=	SORT(DISTRIBUTE(dTradelineData,HASH(Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,Cycle_End_Date)),Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,Cycle_End_Date,LOCAL);

OUTPUT(COUNT(dTradelineDataSort),NAMED('Tradeline_Sample_Count'));
OUTPUT(CHOOSEN(dTradelineDataSort,1000),NAMED('Tradeline_Sample'));
OUTPUT(dTradelineDataSort,,'~thor::out::sbfe::TradelineData',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE);

// Requirement Number: 3.3
// Requirement:  Test File Delivery
dExtractDataSample		:=	CHOOSEN(ENTH(dExtractData,1,100),10000);
dTradelineDataSample	:=	JOIN(
														SORT(DISTRIBUTE(dTradelineData,HASH(Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported)),Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,Cycle_End_Date,LOCAL),
														SORT(DISTRIBUTE(dExtractDataSample,HASH(Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported)),Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,LOCAL),
															LEFT.Sbfe_Contributor_Number	=		RIGHT.Sbfe_Contributor_Number	AND
															LEFT.Contract_Account_Number	=		RIGHT.Contract_Account_Number	AND
															LEFT.Account_Type_Reported		=		RIGHT.Account_Type_Reported,
														TRANSFORM(LEFT),
														LOCAL
													);
													
OUTPUT(dExtractDataSample,,'~thor::out::sbfe::ExtractDataSample',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE);
OUTPUT(dTradelineDataSample,,'~thor::out::sbfe::TradelineDataSample',CSV(HEADING(SINGLE),SEPARATOR(','),QUOTE('"'),MAXLENGTH(100000)),OVERWRITE);
