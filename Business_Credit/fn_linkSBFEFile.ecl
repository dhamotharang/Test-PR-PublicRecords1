IMPORT	Business_Credit,	Business_Header,	Business_Header_SS,	DID_Add,	MDR, NID,	ut,	STD;
EXPORT	fn_linkSBFEFile(STRING	pVersion,
												Constants().buildType	pBuildType	= Constants().buildType.Daily)	:=	FUNCTION

	//	Only Normalize today's records.
	dActive				:=	Business_Credit.Files().Active;
	dValidRecords	:=	IF(pBuildType	=	Constants().buildType.FullBuild,
											dActive,
											dActive(process_date=pVersion)
										);
	preBaseLayout	:=	Business_Credit.Layouts.SBFEAccountPreLayout;
	baseLayout		:=	Business_Credit.Layouts.SBFEAccountLayout;

	preBaseLayout	tGetTradeline(dValidRecords L)	:=	TRANSFORM
		SELF.record_type												:=	Business_Credit.Constants().AB;
		SELF.Sbfe_Contributor_Number						:=	L.portfolioHeader.Sbfe_Contributor_Number;
		SELF.Contract_Account_Number						:=	L.Contract_Account_Number;
		SELF.Original_Contract_Account_Number		:=	L.Original_Contract_Account_Number;
		SELF.Account_Type_Reported							:=	L.Account_Type_Reported;
		SELF.Extracted_Date											:=	L.portfolioHeader.Extracted_Date;
		SELF.Cycle_End_Date											:=	L.portfolioHeader.Cycle_End_Date;
		SELF.Account_Holder_Business_Name				:=	L.Account_Holder_Business_Name;
		SELF.Clean_Account_Holder_Business_Name	:=	NID.clnBizName(SELF.Account_Holder_Business_Name);
		SELF.DBA																:=	L.DBA;
		SELF.Clean_DBA													:=	NID.clnBizName(SELF.DBA);
		SELF.Business_Name											:=	L.Account_Holder_Business_Name;
		SELF.Clean_Business_Name								:=	NID.clnBizName(SELF.Business_Name);
		SELF.address														:=	L.address;
		SELF.phone															:=	L.phone;
		SELF.taxID															:=	L.taxID;
		SELF.individualOwner										:=	L.individualOwner;
		SELF.businessOwner											:=	L.businessOwner;
		// Get the original SBFE_Contributor_Number for consistency in the persistent record ID 
		Temp_Sbfe_Contributor_Number						:=	IF(COUNT(Business_Credit.Files().mapSBFEContributorNumber(New_Sbfe_Contributor_Number=L.portfolioHeader.Sbfe_Contributor_Number))>0,
																									Business_Credit.Files().mapSBFEContributorNumber(New_Sbfe_Contributor_Number=L.portfolioHeader.Sbfe_Contributor_Number)[1].Old_Sbfe_Contributor_Number,
																									L.portfolioHeader.Sbfe_Contributor_Number);
		SELF.persistent_record_ID								:=	HASH64(	TRIM(Temp_Sbfe_Contributor_Number,LEFT,RIGHT)+
																												TRIM(L.Original_Contract_Account_Number,LEFT,RIGHT)+
																												TRIM(L.portfolioHeader.Extracted_Date,LEFT,RIGHT)+
																												TRIM(L.portfolioHeader.Cycle_End_Date,LEFT,RIGHT)+
																												TRIM(L.Account_Holder_Business_Name,LEFT,RIGHT)+
																												TRIM(L.Parent_Sequence_Number,LEFT,RIGHT)+
																												TRIM(L.File_Sequence_Number,LEFT,RIGHT));
		SELF.sbfe_id														:=	L.sbfe_id;
		SELF.source															:=	Constants().source;
		SELF																		:=	L;
		SELF.Tradeline													:=	L;
		SELF																		:=	[];
	END;

	preBaseLayout	tGetIndividual(preBaseLayout L,	UNSIGNED cnt)	:=	TRANSFORM
		SELF.record_type												:=	Business_Credit.Constants().IS;
		SELF.Original_fname											:=	L.individualOwner[cnt].Original_fname;
		SELF.Original_mname											:=	L.individualOwner[cnt].Original_mname;
		SELF.Original_lname											:=	L.individualOwner[cnt].Original_lname;
		SELF.Original_suffix										:=	L.individualOwner[cnt].Original_suffix;
		SELF.Guarantor_Owner_Indicator					:=	L.individualOwner[cnt].Guarantor_Owner_Indicator;
		SELF.Relationship_to_Business_Indicator	:=	L.individualOwner[cnt].Relationship_to_Business_Indicator;
		SELF.Business_Title											:=	L.individualOwner[cnt].Business_Title;
		SELF.Percent_Of_Liability								:=	L.individualOwner[cnt].Percent_Of_Liability;
		SELF.Percent_Of_Ownership								:=	L.individualOwner[cnt].Percent_Of_Ownership;
		SELF.address														:=	L.individualOwner[cnt].address;
		SELF.phone															:=	L.individualOwner[cnt].phone;
		SELF.taxID															:=	L.individualOwner[cnt].taxID;
		SELF.E_Mail_Address											:=	L.individualOwner[cnt].E_Mail_Address;
		SELF.persistent_record_ID								:=	HASH64(	L.persistent_record_ID+
																												TRIM(L.individualOwner[cnt].File_Sequence_Number,LEFT,RIGHT));
		SELF.individualOwner										:=	[];
		SELF																		:=	L;
		SELF																		:=	[];
	END;

	preBaseLayout	tGetBusiness(preBaseLayout L,	UNSIGNED cnt)	:=	TRANSFORM
		SELF.record_type												:=	Business_Credit.Constants().BS;
		SELF.Business_Name											:=	L.businessOwner[cnt].Business_Name;
		SELF.Clean_Business_Name								:=	NID.clnBizName(SELF.Business_Name);
		SELF.Guarantor_Owner_Indicator					:=	L.businessOwner[cnt].Guarantor_Owner_Indicator;
		SELF.Relationship_to_Business_Indicator	:=	L.businessOwner[cnt].Relationship_to_Business_Indicator;
		SELF.Percent_Of_Liability								:=	L.businessOwner[cnt].Percent_Of_Liability;
		SELF.Percent_Of_Ownership								:=	L.businessOwner[cnt].Percent_Of_Ownership_If_Owner_Principal;
		SELF.Company_Website										:=	IF(L.businessOwner[cnt].Web_Address<>'',L.businessOwner[cnt].Web_Address,L.Company_Website);
		SELF.address														:=	L.businessOwner[cnt].address;
		SELF.phone															:=	L.businessOwner[cnt].phone;
		SELF.taxID															:=	L.businessOwner[cnt].taxID;
		SELF.persistent_record_ID								:=	HASH64(	L.persistent_record_ID+
																												TRIM(L.businessOwner[cnt].File_Sequence_Number,LEFT,RIGHT));
		SELF.businessOwner											:=	[];
		SELF																		:=	L;
		SELF																		:=	[];
	END;

	preBaseLayout	tGetAddress(preBaseLayout L,	UNSIGNED cnt)	:=	TRANSFORM
		addrrecs																	:=	SORT(L.address,file_sequence_number);
		SELF.Original_Address_Line_1							:=	addrrecs[cnt].Address_Line_1;
		SELF.Original_Address_Line_2							:=	addrrecs[cnt].Address_Line_2;
		SELF.Original_City												:=	addrrecs[cnt].City;
		SELF.Original_State												:=	addrrecs[cnt].State;
		SELF.Original_Zip_Code_or_CA_Postal_Code	:=	addrrecs[cnt].Zip_Code_or_CA_Postal_Code;
		SELF.Original_Postal_Code									:=	addrrecs[cnt].Postal_Code;
		SELF.Original_Country_Code								:=	addrrecs[cnt].Country_Code;
		SELF.Primary_Address_Indicator						:=	addrrecs[cnt].Primary_Address_Indicator;
		SELF.Address_Classification								:=	addrrecs[cnt].Address_Classification;
		SELF.persistent_record_ID									:=	HASH64(	L.persistent_record_ID+
																													TRIM(addrrecs[cnt].File_Sequence_Number,LEFT,RIGHT));
		SELF.address															:=	[];
		SELF																			:=	L;
		SELF																			:=	[];
	END;

	preBaseLayout	tGetPhone(preBaseLayout L,	UNSIGNED cnt)	:=	TRANSFORM
		phonerecs													:=	SORT(L.phone,file_sequence_number);
		SELF.Original_Area_Code						:=	phonerecs[cnt].Area_Code;
		SELF.Original_Phone_Number				:=	phonerecs[cnt].Phone_Number;
		SELF.Phone_Extension							:=	phonerecs[cnt].Phone_Extension;
		SELF.Primary_Phone_Indicator			:=	phonerecs[cnt].Primary_Phone_Indicator;
		SELF.Published_Unlisted_Indicator	:=	phonerecs[cnt].Published_Unlisted_Indicator;
		SELF.Phone_Type										:=	phonerecs[cnt].Phone_Type;
		SELF.Phone_Number									:=	ut.CleanPhone(SELF.Original_Area_Code+SELF.Original_Phone_Number);
		SELF.persistent_record_ID					:=	HASH64(	L.persistent_record_ID+
																									TRIM(phonerecs[cnt].File_Sequence_Number,LEFT,RIGHT));
		SELF.phone												:=	[];
		SELF															:=	L;
		SELF															:=	[];
	END;

	preBaseLayout	tGetTaxID(preBaseLayout L,	UNSIGNED cnt)	:=	TRANSFORM
		taxrecs														:=	SORT(L.taxID,file_sequence_number);
		SELF.Federal_TaxID_SSN						:=	taxrecs[cnt].Federal_TaxID_SSN;
		SELF.Federal_TaxID_SSN_Identifier	:=	taxrecs[cnt].Federal_TaxID_SSN_Identifier;
		SELF.persistent_record_ID					:=	HASH64(	L.persistent_record_ID+
																									TRIM(taxrecs[cnt].File_Sequence_Number,LEFT,RIGHT));
		SELF.taxID												:=	[];
		SELF															:=	L;
		SELF															:=	[];
	END;

	preBaseLayout	tGetDigitalFootPrintEmail(preBaseLayout L,	UNSIGNED cnt)	:=	TRANSFORM
		DFRecs														:=	SORT(L.DigitalFootprint,file_sequence_number);
		SELF.E_Mail_Address						:=	if(L.E_Mail_Address='',DFRecs[cnt].InformationValue,L.E_Mail_Address);
		SELF															:=	L;
		SELF															:=	[];
	END;
	preBaseLayout	tGetDigitalFootPrintWebsite(preBaseLayout L,	UNSIGNED cnt)	:=	TRANSFORM
		DFRecs														:=	SORT(L.DigitalFootprint,file_sequence_number);
		SELF.Company_Website						:=	if(L.Company_Website='',DFRecs[cnt].InformationValue,L.Company_Website);
		SELF.DigitalFootPrint												:=	[];
		SELF															:=	L;
		SELF															:=	[];
	END;
	baseLayout	tSBFEAccounts(preBaseLayout L)	:=	TRANSFORM
		SELF.timestamp												:=	(STRING8)Std.Date.Today()+Std.Date.SecondsToString(Std.date.CurrentSeconds(true), '%H%M%S');
		SELF.Extracted_Date										:=	L.Extracted_Date;
		SELF.Cycle_End_Date										:=	L.Cycle_End_Date;
		SELF																	:=	L;
		SELF																	:=	[];
	END;

	dTradeline				:=	PROJECT(dValidRecords,tGetTradeline(LEFT)):PERSIST(PersistNames.tradelines);
	dIndividual				:=	NORMALIZE(dTradeline(COUNT(individualOwner)>0),COUNT(LEFT.individualOwner),tGetIndividual(LEFT,COUNTER));
	dBusiness					:=	NORMALIZE(dTradeline(COUNT(businessOwner)>0),COUNT(LEFT.businessOwner),tGetBusiness(LEFT,COUNTER));
	dAllTradelines		:=	dTradeline+dIndividual+dBusiness;
	dNoAddress				:=	dAllTradelines(COUNT(address)=0);
	dHasAddress				:=	NORMALIZE(dAllTradelines(COUNT(address)>0),COUNT(LEFT.address),tGetAddress(LEFT,COUNTER));
	dNoPhone					:=	dHasAddress(COUNT(phone)=0)+dNoAddress(COUNT(phone)=0);
	dHasPhone					:=	NORMALIZE(dHasAddress(COUNT(phone)>0)+dNoAddress(COUNT(phone)>0),COUNT(LEFT.phone),tGetPhone(LEFT,COUNTER));
	dNoTaxID					:=	dHasPhone(COUNT(taxID)=0)+dNoPhone(COUNT(taxID)=0);
	dHasTaxID					:=	NORMALIZE(dHasPhone(COUNT(taxID)>0)+dNoPhone(COUNT(taxID)>0),COUNT(LEFT.taxID),tGetTaxID(LEFT,COUNTER));
	dNoEmail					:=	dHasTaxID(COUNT(DigitalFootprint(InformationTypeDescription='EMAIL'))=0)+dNoTaxID(COUNT(DigitalFootprint(InformationTypeDescription='EMAIL'))=0);
	dHasEmail					:=	NORMALIZE(dHasTaxID(COUNT(DigitalFootprint(InformationTypeDescription='EMAIL'))>0)+dNoTaxID(COUNT(DigitalFootprint(InformationTypeDescription='EMAIL'))>0),COUNT(LEFT.DigitalFootprint(InformationTypeDescription='EMAIL')),tGetDigitalFootPrintEmail(LEFT,COUNTER));
	dNoWebsite					:=	dHasEmail(COUNT(DigitalFootprint(InformationTypeDescription='WEBSITE'))=0)+dNoEmail(COUNT(DigitalFootprint(InformationTypeDescription='WEBSITE'))=0);
	dHasWebsite					:=	NORMALIZE(dHasEmail(COUNT(DigitalFootprint(InformationTypeDescription='WEBSITE'))>0)+dNoEmail(COUNT(DigitalFootprint(InformationTypeDescription='WEBSITE'))>0),COUNT(LEFT.DigitalFootprint(InformationTypeDescription='WEBSITE')),tGetDigitalFootPrintWebsite(LEFT,COUNTER));
	SBFE_Accounts			:=	PROJECT(dHasWebsite+dNoWebsite,tSBFEAccounts(LEFT));
	dCleanName				:=	Business_Credit.fn_cleanName(SBFE_Accounts):PERSIST(PersistNames.cleannames);
	dCleanAddress			:=	Business_Credit.fn_cleanAddressUsingCache(dCleanName):PERSIST(PersistNames.cleanaddresses);

	dRecordsToLink		:=	IF(pBuildType	IN	[Constants().buildType.Daily,Constants().buildType.FullBuild],
													dCleanAddress,
													dCleanAddress+
													//	If it's not a Daily we want to link everything.  But clean the fields first.
													PROJECT(Business_Credit.Files().LinkIDs,
														TRANSFORM(RECORDOF(LEFT),
															SELF.did				:=	0;
															SELF.did_score	:=	0;
															SELF.DotID			:=	0;
															SELF.DotScore		:=	0;
															SELF.DotWeight	:=	0;
															SELF.EmpID			:=	0;
															SELF.EmpScore		:=	0;
															SELF.EmpWeight	:=	0;
															SELF.POWID			:=	0;
															SELF.POWScore		:=	0;
															SELF.POWWeight	:=	0;
															SELF.ProxID			:=	0;
															SELF.ProxScore	:=	0;
															SELF.ProxWeight	:=	0;
															SELF.SELEID			:=	0;
															SELF.SELEScore	:=	0;
															SELF.SELEWeight	:=	0;	
															SELF.OrgID			:=	0;
															SELF.OrgScore		:=	0;
															SELF.OrgWeight	:=	0;
															SELF.UltID			:=	0;
															SELF.UltScore		:=	0;
															SELF.UltWeight	:=	0;	
															SELF						:=	LEFT))
												);

	/*	
			'A' = Address
			'F' = FEIN
			'P'	= phone
				* company name will always be part of the match if any of
					the above flags are set.
			'N' = Allow match on company name only.
	*/
	BIP_Matchset := ['A','F','P'];
	Business_Header_SS.MAC_Add_BDID_Flex(	dRecordsToLink(Clean_fname='' OR Clean_lname='')	// Input Dataset
																			 ,BIP_Matchset     														 // BDID Matchset what fields to match on
																			 ,Clean_Business_Name					     					  // company_name
																			 ,prim_range       													 // prim_range
																			 ,prim_name	        												// prim_name
																			 ,zip             												 // zip5
																			 ,sec_range         											// sec_range
																			 ,st	              										 // state
																			 ,Phone_Number             							// phone
																			 ,Federal_TaxID_SSN										 // fein
																			 ,''					        					      // bdid
																			 ,RECORDOF(baseLayout)							 // Output Layout
																			 ,FALSE              								// output layout has bdid score field?
																			 ,''								       				 // bdid_score
																			 ,SBFE_LinkId											// Output Dataset
																			 ,															 // default threshold
																			 ,													 		// use prod version of superfiles
																			 ,														 // default is to hit prod from dataland, and on prod hit prod.		
																			 ,[BIPV2.IDconstants.xlink_version_BIP]	// Create BIP Keys only
																			 ,Company_Website           		 // Url
																			 ,													// Email
																			 ,p_city_name							 // City
																			 ,												// fname
																			 ,											 // mname
																			 ,											// lname
																			 ,										 // Contact_SSN
																			 ,source							// Source Ã‚â€“ MDR.sourceTools
																			 ,persistent_record_ID	// Source_Record_Id
																			 ,									// Src_Matching_is_priorty
																		);
																		
	IS_BIP_Matchset := ['A','P'];
	Business_Header_SS.MAC_Add_BDID_Flex(	dRecordsToLink(Clean_fname<>'' AND Clean_lname<>'')	// Input Dataset
																			 ,IS_BIP_Matchset	     												 // BDID Matchset what fields to match on
																			 ,Clean_Business_Name					     					  // company_name
																			 ,prim_range       													 // prim_range
																			 ,prim_name	        												// prim_name
																			 ,zip             												 // zip5
																			 ,sec_range         											// sec_range
																			 ,st	              										 // state
																			 ,Phone_Number             							// phone
																			 ,''																	 // fein
																			 ,''					        				        // bdid
																			 ,RECORDOF(baseLayout)							 // Output Layout
																			 ,FALSE              								// output layout has bdid score field?
																			 ,''								       				 // bdid_score
																			 ,SBFE_LinkId_HasName							// Output Dataset
																			 ,															 // default threshold
																			 ,													 		// use prod version of superfiles
																			 ,														 // default is to hit prod from dataland, and on prod hit prod.		
																			 ,[BIPV2.IDconstants.xlink_version_BIP]	// Create BIP Keys only
																			 ,Company_Website           		 // Url
																			 ,E_Mail_Address						// Email
																			 ,p_city_name							 // City
																			 ,Clean_fname							// fname
																			 ,Clean_mname						 // mname
																			 ,Clean_lname						// lname
																			 ,Federal_TaxID_SSN		 // Contact_SSN
																			 ,source							// Source Ã‚â€“ MDR.sourceTools
																			 ,persistent_record_ID	// Source_Record_Id
																			 ,									// Src_Matching_is_priorty
																		);

	matchSetSZP	:=	['S','Z','P'];

	DID_Add.Mac_Match_Flex(	SBFE_LinkId_HasName,													 // Input Dataset
													matchSetSZP,																	// BDID Matchset what fields to match on
													Federal_TaxID_SSN,													 // SSN or Tax ID
													foo,																				// DOB
													Clean_fname,															 // First Name
													Clean_mname,															// Middle Name
													Clean_lname,														 // Last Name
													Clean_suffix,														// Suffix
													prim_range,														 // prim_range
													prim_name,														// prim_name
													sec_range,													 // sec_range
													zip,																// zip5
													st,																 // state
													Phone_Number,											// phone
													did,														 // did
													RECORDOF(baseLayout),						// Output Layout
													TRUE,													 // has score field
													did_score,										// did_score
													75,													 // threshold
													SBFE_DID										// Output Dataset
												);

	// All records linked with BIP and DID
	// If this is a Daily we need to get the previous records
	dLinked	:=	IF(pBuildType	=	Constants().buildType.Daily,
								SBFE_LinkId+SBFE_DID+Business_Credit.Files().LinkIDs,
								SBFE_LinkId+SBFE_DID
							);
	
	// Set First/Last Seen dates for the dataset
	rFirstLastDate	:=	RECORD
		UNSIGNED4	dt_first_seen;
		UNSIGNED4	dt_last_seen;
		UNSIGNED4	dt_vendor_first_reported;
		UNSIGNED4	dt_vendor_last_reported;
		UNSIGNED4	dt_datawarehouse_first_reported;
		UNSIGNED4	dt_datawarehouse_last_reported;
		STRING30	Sbfe_Contributor_Number;
		STRING50	Contract_Account_Number;
		STRING3		Account_Type_Reported;
	END;
	
	rFirstLastDate	tFillDates(rFirstLastDate	L,	rFirstLastDate	R)	:=	TRANSFORM
		SELF.dt_first_seen										:=	ut.EarliestDate(L.dt_first_seen,	R.dt_first_seen);
		SELF.dt_last_seen											:=	MAX(L.dt_last_seen,	R.dt_last_seen);
		SELF.dt_vendor_first_reported					:=	ut.EarliestDate(L.dt_vendor_first_reported,	R.dt_vendor_first_reported);
		SELF.dt_vendor_last_reported					:=	MAX(L.dt_vendor_last_reported,	R.dt_vendor_last_reported);
		SELF.dt_datawarehouse_first_reported	:=	ut.EarliestDate(L.dt_datawarehouse_first_reported,	R.dt_datawarehouse_first_reported);
		SELF.dt_datawarehouse_last_reported		:=	MAX(L.dt_datawarehouse_last_reported,	R.dt_datawarehouse_last_reported);
		SELF																	:=	L;
	END;
	
	dActiveFirstLastDate	:=	PROJECT(dActive(active),
															TRANSFORM(RECORDOF(rFirstLastDate),
																SELF.dt_first_seen										:=	(UNSIGNED4)LEFT.portfolioHeader.Cycle_End_Date;
																SELF.dt_last_seen											:=	(UNSIGNED4)LEFT.portfolioHeader.Cycle_End_Date;
																SELF.dt_vendor_first_reported					:=	(UNSIGNED4)LEFT.process_date;
																SELF.dt_vendor_last_reported					:=	(UNSIGNED4)LEFT.process_date;
																SELF.dt_datawarehouse_first_reported	:=	(UNSIGNED4)LEFT.portfolioHeader.Extracted_Date;
																SELF.dt_datawarehouse_last_reported		:=	(UNSIGNED4)LEFT.portfolioHeader.Extracted_Date;
																SELF.Sbfe_Contributor_Number					:=	LEFT.portfolioHeader.Sbfe_Contributor_Number;
																SELF.Contract_Account_Number					:=	LEFT.Contract_Account_Number;
																SELF.Account_Type_Reported						:=	LEFT.Account_Type_Reported;
														));
														
	dFirstLastDate	:=	SORT(DISTRIBUTE(dActiveFirstLastDate,
												HASH(	Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported)),
															Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,LOCAL
											);
										
	dGetDates	:=	ROLLUP(	dFirstLastDate,
													LEFT.Sbfe_Contributor_Number	=	RIGHT.Sbfe_Contributor_Number	AND
													LEFT.Contract_Account_Number	=	RIGHT.Contract_Account_Number	AND
													LEFT.Account_Type_Reported		=	RIGHT.Account_Type_Reported,
												tFillDates(LEFT,RIGHT),
												LOCAL
											);
	// Fill first/last seen dates
	dFillDates	:=	JOIN(
										SORT(DISTRIBUTE(dLinked,HASH(Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported)),Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,LOCAL),
										SORT(DISTRIBUTE(dGetDates,HASH(Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported)),Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported,LOCAL),
											LEFT.Sbfe_Contributor_Number	=	RIGHT.Sbfe_Contributor_Number	AND
											LEFT.Contract_Account_Number	=	RIGHT.Contract_Account_Number	AND
											LEFT.Account_Type_Reported		=	RIGHT.Account_Type_Reported,
										TRANSFORM(RECORDOF(LEFT), SELF:=RIGHT;SELF:=LEFT),
										LOCAL
									);

	addGlobalSID:=  MDR.macGetGlobalSID(dFillDates,'SBFECV','','global_sid'); //DF-25791: Populate Global_SID	

	// Determine which records are active and inactive as of today's build
	dSetActive	:=	JOIN(
										SORT(DISTRIBUTE(addGlobalSID,
											HASH(	Sbfe_Contributor_Number,Original_Contract_Account_Number,Account_Type_Reported,extracted_date,Cycle_End_Date,process_date)),
														Sbfe_Contributor_Number,Original_Contract_Account_Number,Account_Type_Reported,extracted_date,Cycle_End_Date,process_date,LOCAL),
										DEDUP(SORT(DISTRIBUTE(dActive,
											HASH(	portfolioHeader.Sbfe_Contributor_Number,Original_Contract_Account_Number,Account_Type_Reported,portfolioHeader.extracted_date,portfolioHeader.Cycle_End_Date,process_date)),
														portfolioHeader.Sbfe_Contributor_Number,Original_Contract_Account_Number,Account_Type_Reported,portfolioHeader.extracted_date,portfolioHeader.Cycle_End_Date,process_date,LOCAL),
														portfolioHeader.Sbfe_Contributor_Number,Original_Contract_Account_Number,Account_Type_Reported,portfolioHeader.extracted_date,portfolioHeader.Cycle_End_Date,process_date,LOCAL),
											LEFT.Sbfe_Contributor_Number					=	RIGHT.portfolioHeader.Sbfe_Contributor_Number	AND
											LEFT.Original_Contract_Account_Number	=	RIGHT.Original_Contract_Account_Number									AND
											LEFT.Account_Type_Reported						=	RIGHT.Account_Type_Reported										AND
											LEFT.extracted_date										=	RIGHT.portfolioHeader.extracted_date					AND
											LEFT.Cycle_End_Date										=	RIGHT.portfolioHeader.Cycle_End_Date					AND
											LEFT.process_date											=	RIGHT.process_date,
										TRANSFORM(
											RECORDOF(LEFT),	
											SELF.active									:=	RIGHT.active;
											SELF.correction_type				:=	RIGHT.correction_type;
											SELF.correction_date				:=	RIGHT.correction_date;
											SELF.original_process_date	:=	RIGHT.original_process_date;
											SELF:=LEFT
										),
										LOCAL											
									);
	
	//	In the event that we have to rebuild all of the records we still want to preserve the timestamp
	dPreservePersistentRecordID	:=	
									JOIN(
										SORT(DISTRIBUTE(dSetActive,
											HASH(	persistent_record_ID)),
														persistent_record_ID,LOCAL),
										SORT(DISTRIBUTE(Business_Credit.Files().LinkIDs,
											HASH(	persistent_record_ID)),
														persistent_record_ID,LOCAL),
											LEFT.persistent_record_ID	=	RIGHT.persistent_record_ID,
										TRANSFORM(
											RECORDOF(LEFT),	
											SELF.timestamp	:=	IF(RIGHT.timestamp<>'',RIGHT.timestamp,LEFT.timestamp);
											SELF						:=	LEFT;
										),
										LEFT OUTER,
										KEEP(1),
										LOCAL
									);

		// If this is a daily, don't worry about changing the active flag
	dBuildResult	:=	IF(	pBuildType	= Constants().buildType.Daily,
												addGlobalSID,																			//	Only new records are added
											IF(	pBuildType	= Constants().buildType.FullBuild,
												dPreservePersistentRecordID,											//	All records have been rebuild
												dSetActive                                        //	All records have been linked but not rebuilt
											)
										);
	RETURN dBuildResult;
	
END;
