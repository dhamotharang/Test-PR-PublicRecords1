IMPORT	Business_Credit, MDR;

EXPORT	fn_GetSegments	:=	MODULE

	//SHARED	dValidRecords	:=	Business_Credit.Files().active;
SHARED	dValidRecords	:=	Business_Credit.Files().active;
	EXPORT	accountBase	:=	FUNCTION
		
		Business_Credit.Layouts.rAccountBase	tAccountBase(dValidRecords	pInput)	:=	TRANSFORM
			SELF.Sbfe_Contributor_Number	:=	pInput.portfolioHeader.Sbfe_Contributor_Number;
			self.Overall_File_Format_Version:=	pInput.portfolioHeader.Overall_File_Format_Version;
			SELF.Extracted_Date						:=	pInput.portfolioHeader.Extracted_Date;
			SELF.Cycle_End_Date						:=	pInput.portfolioHeader.Cycle_End_Date;
			SELF													:=	pInput;
		END;

		dAccountBase	:=	PROJECT(dValidRecords,tAccountBase(LEFT));

		RETURN	dAccountBase;
	END;

	EXPORT	BIClassification	:=	FUNCTION
	
		rPreBI	:=	RECORD
			STRING2		record_type;
			STRING30	Sbfe_Contributor_Number;
			STRING50	Contract_Account_Number;
			STRING50	Original_Contract_Account_Number;
			STRING3		Account_Type_Reported;
			STRING		process_date;
			STRING		original_process_date;
			STRING8		Extracted_Date;
			STRING8		Cycle_End_Date;
			BOOLEAN		active;
			DATASET(Business_Credit.Layouts.BI)	BI{MAXCOUNT(25)};		//	BI
		END;
		
		rPreBI tBusinessOwner(dValidRecords	pInput,	UNSIGNED cnt)	:=	TRANSFORM
			SELF.record_type											:=	Business_Credit.Constants().BS;
			SELF.Sbfe_Contributor_Number					:=	pInput.portfolioHeader.Sbfe_Contributor_Number;
			SELF.Contract_Account_Number					:=	pInput.Contract_Account_Number;
			SELF.Original_Contract_Account_Number	:=	pInput.Original_Contract_Account_Number;
			SELF.Account_Type_Reported						:=	pInput.Account_Type_Reported;
			SELF.process_date											:=	pInput.process_date;
			SELF.original_process_date						:=	pInput.original_process_date;
			SELF.Extracted_Date										:=	pInput.portfolioHeader.Extracted_Date;
			SELF.Cycle_End_Date										:=	pInput.portfolioHeader.Cycle_End_Date;
			SELF.active														:=	pInput.active;
			SELF.BI																:=	pInput.businessOwner[cnt].businessIndustryClassification;
		END;
		dBusinessOwner	:=	NORMALIZE(dValidRecords(COUNT(businessOwner.businessIndustryClassification)>0),
													COUNT(LEFT.businessOwner),
													tBusinessOwner(LEFT,COUNTER));
		
		rPreBI tAccountBase(dValidRecords	pInput)	:=	TRANSFORM
			SELF.record_type											:=	Business_Credit.Constants().AB;
			SELF.Sbfe_Contributor_Number					:=	pInput.portfolioHeader.Sbfe_Contributor_Number;
			SELF.Contract_Account_Number					:=	pInput.Contract_Account_Number;
			SELF.Original_Contract_Account_Number	:=	pInput.Original_Contract_Account_Number;
			SELF.Account_Type_Reported						:=	pInput.Account_Type_Reported;
			SELF.process_date											:=	pInput.process_date;
			SELF.original_process_date						:=	pInput.original_process_date;
			SELF.Extracted_Date										:=	pInput.portfolioHeader.Extracted_Date;
			SELF.Cycle_End_Date										:=	pInput.portfolioHeader.Cycle_End_Date;
			SELF.active														:=	pInput.active;
			SELF.BI																:=	pInput.businessIndustryClassification;
		END;
		dAccountBase		:=	PROJECT(dValidRecords(COUNT(businessIndustryClassification)>0),tAccountBase(LEFT));
		
		Business_Credit.Layouts.rBIClassification	tBIClassification(rPreBI	pInput,	UNSIGNED cnt)	:=	TRANSFORM
			SELF	:=	pInput.BI[cnt];
			SELF	:=	pInput;
		END;

		dBIClassification	:=	NORMALIZE(dBusinessOwner+dAccountBase,
														COUNT(LEFT.BI),
														tBIClassification(LEFT,COUNTER));

		RETURN	dBIClassification;
	END;
	export digitalfootprint:=function 
	 	rPreDF	:=	RECORD
			STRING2		record_type;
			STRING30	Sbfe_Contributor_Number;
			STRING50	Contract_Account_Number;
			STRING50	Original_Contract_Account_Number;
			STRING3		Account_Type_Reported;
			STRING		process_date;
			STRING		original_process_date;
			STRING8		Extracted_Date;
			STRING8		Cycle_End_Date;
			BOOLEAN		active;
			DATASET(Business_Credit.Layouts.DF)	DF{MAXCOUNT(25)};		//	BI
		END;
		rPreDF tBusinessOwner(dValidRecords	pInput,	UNSIGNED cnt)	:=	TRANSFORM
			SELF.record_type											:=	Business_Credit.Constants().BS;
			SELF.Sbfe_Contributor_Number					:=	pInput.portfolioHeader.Sbfe_Contributor_Number;
			SELF.Contract_Account_Number					:=	pInput.Contract_Account_Number;
			SELF.Original_Contract_Account_Number	:=	pInput.Original_Contract_Account_Number;
			SELF.Account_Type_Reported						:=	pInput.Account_Type_Reported;
			SELF.process_date											:=	pInput.process_date;
			SELF.original_process_date						:=	pInput.original_process_date;
			SELF.Extracted_Date										:=	pInput.portfolioHeader.Extracted_Date;
			SELF.Cycle_End_Date										:=	pInput.portfolioHeader.Cycle_End_Date;
			SELF.active														:=	pInput.active;
			SELF.DF																:=	pInput.businessOwner[cnt].DigitalFootPrint;
		END;
		dBusinessOwner	:=	NORMALIZE(dValidRecords(COUNT(businessOwner.DigitalFootPrint)>0),
													COUNT(LEFT.businessOwner),
													tBusinessOwner(LEFT,COUNTER));
		rPreDF tIndividualOwner(dValidRecords	pInput,	UNSIGNED cnt)	:=	TRANSFORM
			SELF.record_type											:=	Business_Credit.Constants().BS;
			SELF.Sbfe_Contributor_Number					:=	pInput.portfolioHeader.Sbfe_Contributor_Number;
			SELF.Contract_Account_Number					:=	pInput.Contract_Account_Number;
			SELF.Original_Contract_Account_Number	:=	pInput.Original_Contract_Account_Number;
			SELF.Account_Type_Reported						:=	pInput.Account_Type_Reported;
			SELF.process_date											:=	pInput.process_date;
			SELF.original_process_date						:=	pInput.original_process_date;
			SELF.Extracted_Date										:=	pInput.portfolioHeader.Extracted_Date;
			SELF.Cycle_End_Date										:=	pInput.portfolioHeader.Cycle_End_Date;
			SELF.active														:=	pInput.active;
			SELF.DF																:=	pInput.individualOwner[cnt].DigitalFootPrint;
		END;
		dIndividualOwner	:=	NORMALIZE(dValidRecords(COUNT(individualOwner.DigitalFootPrint)>0),
													COUNT(LEFT.individualOwner),
													tIndividualOwner(LEFT,COUNTER));
		rPreDF tAccountBase(dValidRecords	pInput)	:=	TRANSFORM
			SELF.record_type											:=	Business_Credit.Constants().AB;
			SELF.Sbfe_Contributor_Number					:=	pInput.portfolioHeader.Sbfe_Contributor_Number;
			SELF.Contract_Account_Number					:=	pInput.Contract_Account_Number;
			SELF.Original_Contract_Account_Number	:=	pInput.Original_Contract_Account_Number;
			SELF.Account_Type_Reported						:=	pInput.Account_Type_Reported;
			SELF.process_date											:=	pInput.process_date;
			SELF.original_process_date						:=	pInput.original_process_date;
			SELF.Extracted_Date										:=	pInput.portfolioHeader.Extracted_Date;
			SELF.Cycle_End_Date										:=	pInput.portfolioHeader.Cycle_End_Date;
			SELF.active														:=	pInput.active;
			SELF.DF																:=	pInput.DigitalFootPrint;
		END;
		dAccountBase		:=	PROJECT(dValidRecords(COUNT(DigitalFootPrint)>0),tAccountBase(LEFT));
		Business_Credit.Layouts.rDigitalFootprint	tDigitalFootprint(rPreDF	pInput,	UNSIGNED cnt)	:=	TRANSFORM
			SELF	:=	pInput.DF[cnt];
			SELF	:=	pInput;
		END;

		dDigitalFootprint	:=	NORMALIZE(dBusinessOwner+dIndividualOwner+dAccountBase,
														COUNT(LEFT.DF),
														tDigitalFootprint(LEFT,COUNTER));

		RETURN	dDigitalFootprint;	
	END;
	
	EXPORT	businessowner	:=	FUNCTION
		
		Business_Credit.Layouts.rBusinessOwner	tBusinessOwner(dValidRecords	pInput,	UNSIGNED cnt)	:=	TRANSFORM
			SELF.Sbfe_Contributor_Number					:=	pInput.portfolioHeader.Sbfe_Contributor_Number;
			SELF.Contract_Account_Number					:=	pInput.Contract_Account_Number;
			SELF.Original_Contract_Account_Number	:=	pInput.Original_Contract_Account_Number;
			SELF.Account_Type_Reported						:=	pInput.Account_Type_Reported;
			SELF.process_date											:=	pInput.process_date;
			SELF.original_process_date						:=	pInput.original_process_date;
			SELF.Extracted_Date										:=	pInput.portfolioHeader.Extracted_Date;
			SELF.Cycle_End_Date										:=	pInput.portfolioHeader.Cycle_End_Date;
			SELF.active														:=	pInput.active;
			SELF																	:=	pInput.businessOwner[cnt];
		END;

		dBusinessOwner	:=	NORMALIZE(dValidRecords(COUNT(businessOwner)>0),COUNT(LEFT.businessOwner),tBusinessOwner(LEFT,COUNTER));

		addGlobalSID 	:=  	MDR.macGetGlobalSID(dBusinessOwner,'SBFECV','','global_sid'); //DF-25791: Populate Global_SID	

		RETURN	addGlobalSID;
	END;

	EXPORT	merchantprocessing	:=	FUNCTION
		
		Return Business_Credit.fn_PrepMDandChildren;
	END;

	EXPORT	collateral	:=	FUNCTION
		
		Business_Credit.Layouts.rCollateral	tCollateral(dValidRecords	pInput,	UNSIGNED cnt)	:=	TRANSFORM
			SELF.Sbfe_Contributor_Number					:=	pInput.portfolioHeader.Sbfe_Contributor_Number;
			SELF.Contract_Account_Number					:=	pInput.Contract_Account_Number;
			SELF.Original_Contract_Account_Number	:=	pInput.Original_Contract_Account_Number;
			SELF.Account_Type_Reported						:=	pInput.Account_Type_Reported;
			SELF.process_date											:=	pInput.process_date;
			SELF.original_process_date						:=	pInput.original_process_date;
			SELF.Extracted_Date										:=	pInput.portfolioHeader.Extracted_Date;
			SELF.Cycle_End_Date										:=	pInput.portfolioHeader.Cycle_End_Date;
			SELF.active														:=	pInput.active;
			SELF																	:=	pInput.collateral[cnt];
		END;

		dCollateral	:=	NORMALIZE(dValidRecords(COUNT(collateral)>0),COUNT(LEFT.collateral),tCollateral(LEFT,COUNTER));

		RETURN	dCollateral;
	END;

	EXPORT	history	:=	FUNCTION
		
		Business_Credit.Layouts.rHistory	tHistory(dValidRecords	pInput,	UNSIGNED cnt)	:=	TRANSFORM
			SELF.Sbfe_Contributor_Number					:=	pInput.portfolioHeader.Sbfe_Contributor_Number;
			SELF.Contract_Account_Number					:=	pInput.Contract_Account_Number;
			SELF.Original_Contract_Account_Number	:=	pInput.Original_Contract_Account_Number;
			SELF.Account_Type_Reported						:=	pInput.Account_Type_Reported;
			SELF.process_date											:=	pInput.process_date;
			SELF.original_process_date						:=	pInput.original_process_date;
			SELF.Extracted_Date										:=	pInput.portfolioHeader.Extracted_Date;
			SELF.Cycle_End_Date										:=	pInput.portfolioHeader.Cycle_End_Date;
			SELF.active														:=	pInput.active;
			SELF																	:=	pInput.history[cnt];
		END;

		dHistory	:=	NORMALIZE(dValidRecords(COUNT(history)>0),COUNT(LEFT.history),tHistory(LEFT,COUNTER));

		RETURN	dHistory;
	END;

	EXPORT	individualowner	:=	FUNCTION
		
		Business_Credit.Layouts.rIndividualOwner	tIndividualOwner(dValidRecords	pInput,	UNSIGNED cnt)	:=	TRANSFORM
			SELF.Sbfe_Contributor_Number					:=	pInput.portfolioHeader.Sbfe_Contributor_Number;
			SELF.Contract_Account_Number					:=	pInput.Contract_Account_Number;
			SELF.Original_Contract_Account_Number	:=	pInput.Original_Contract_Account_Number;
			SELF.Account_Type_Reported						:=	pInput.Account_Type_Reported;
			SELF.process_date											:=	pInput.process_date;
			SELF.original_process_date						:=	pInput.original_process_date;
			SELF.Extracted_Date										:=	pInput.portfolioHeader.Extracted_Date;
			SELF.Cycle_End_Date										:=	pInput.portfolioHeader.Cycle_End_Date;
			SELF.active														:=	pInput.active;
			SELF																	:=	pInput.individualOwner[cnt];
		END;

		dIndividualOwner	:=	NORMALIZE(dValidRecords(COUNT(individualOwner)>0),COUNT(LEFT.individualOwner),tIndividualOwner(LEFT,COUNTER));

		addGlobalSID 		:=  	MDR.macGetGlobalSID(dIndividualOwner,'SBFECV','','global_sid'); //DF-25791: Populate Global_SID	

		RETURN	addGlobalSID;
	END;

	EXPORT	masterAccount	:=	FUNCTION
		
		Business_Credit.Layouts.rMasterAccount	tMasterAccount(dValidRecords	pInput)	:=	TRANSFORM
			SELF.Sbfe_Contributor_Number					:=	pInput.portfolioHeader.Sbfe_Contributor_Number;
			SELF.Contract_Account_Number					:=	pInput.Contract_Account_Number;
			SELF.Original_Contract_Account_Number	:=	pInput.Original_Contract_Account_Number;
			SELF.Account_Type_Reported						:=	pInput.Account_Type_Reported;
			SELF.process_date											:=	pInput.process_date;
			SELF.original_process_date						:=	pInput.original_process_date;
			SELF.Extracted_Date										:=	pInput.portfolioHeader.Extracted_Date;
			SELF.Cycle_End_Date										:=	pInput.portfolioHeader.Cycle_End_Date;
			SELF.active														:=	pInput.active;
			SELF																	:=	pInput.masterAccount[1];
		END;

		dMasterAccount	:=	PROJECT(dValidRecords(COUNT(masterAccount)>0),tMasterAccount(LEFT));

		RETURN	dMasterAccount;
	END;

	EXPORT	memberSpecific	:=	FUNCTION
	
		rPreMS	:=	RECORD
			STRING2		record_type;
			STRING30	Sbfe_Contributor_Number;
			STRING50	Contract_Account_Number;
			STRING50	Original_Contract_Account_Number;
			STRING3		Account_Type_Reported;
			STRING		process_date;
			STRING		original_process_date;
			STRING8		Extracted_Date;
			STRING8		Cycle_End_Date;
			BOOLEAN		active;
			DATASET(Business_Credit.Layouts.MS)	MS{MAXCOUNT(100)};	//	MS
		END;
		
		rPreMS tIndividualOwner(dValidRecords	pInput,	UNSIGNED cnt)	:=	TRANSFORM
			SELF.record_type											:=	Business_Credit.Constants().IS;
			SELF.Sbfe_Contributor_Number					:=	pInput.portfolioHeader.Sbfe_Contributor_Number;
			SELF.Contract_Account_Number					:=	pInput.Contract_Account_Number;
			SELF.Original_Contract_Account_Number	:=	pInput.Original_Contract_Account_Number;
			SELF.Account_Type_Reported						:=	pInput.Account_Type_Reported;
			SELF.process_date											:=	pInput.process_date;
			SELF.original_process_date						:=	pInput.original_process_date;
			SELF.Extracted_Date										:=	pInput.portfolioHeader.Extracted_Date;
			SELF.Cycle_End_Date										:=	pInput.portfolioHeader.Cycle_End_Date;
			SELF.active														:=	pInput.active;
			SELF.MS																:=	pInput.individualOwner[cnt].memberSpecific;
		END;
		dIndividualOwner	:=	NORMALIZE(dValidRecords(COUNT(individualOwner.memberSpecific)>0),
														COUNT(LEFT.individualOwner),
														tIndividualOwner(LEFT,COUNTER));
		
		rPreMS tBusinessOwner(dValidRecords	pInput,	UNSIGNED cnt)	:=	TRANSFORM
			SELF.record_type											:=	Business_Credit.Constants().BS;
			SELF.Sbfe_Contributor_Number					:=	pInput.portfolioHeader.Sbfe_Contributor_Number;
			SELF.Contract_Account_Number					:=	pInput.Contract_Account_Number;
			SELF.Original_Contract_Account_Number	:=	pInput.Original_Contract_Account_Number;
			SELF.Account_Type_Reported						:=	pInput.Account_Type_Reported;
			SELF.process_date											:=	pInput.process_date;
			SELF.original_process_date						:=	pInput.original_process_date;
			SELF.Extracted_Date										:=	pInput.portfolioHeader.Extracted_Date;
			SELF.Cycle_End_Date										:=	pInput.portfolioHeader.Cycle_End_Date;
			SELF.active														:=	pInput.active;
			SELF.MS																:=	pInput.businessOwner[cnt].memberSpecific;
		END;
		dBusinessOwner	:=	NORMALIZE(dValidRecords(COUNT(businessOwner.memberSpecific)>0),
													COUNT(LEFT.businessOwner),
													tBusinessOwner(LEFT,COUNTER));
		
		rPreMS tAccountBase(dValidRecords	pInput)	:=	TRANSFORM
			SELF.record_type											:=	Business_Credit.Constants().AB;
			SELF.Sbfe_Contributor_Number					:=	pInput.portfolioHeader.Sbfe_Contributor_Number;
			SELF.Contract_Account_Number					:=	pInput.Contract_Account_Number;
			SELF.Original_Contract_Account_Number	:=	pInput.Original_Contract_Account_Number;
			SELF.Account_Type_Reported						:=	pInput.Account_Type_Reported;
			SELF.process_date											:=	pInput.process_date;
			SELF.original_process_date						:=	pInput.original_process_date;
			SELF.Extracted_Date										:=	pInput.portfolioHeader.Extracted_Date;
			SELF.Cycle_End_Date										:=	pInput.portfolioHeader.Cycle_End_Date;
			SELF.active														:=	pInput.active;
			SELF.MS																:=	pInput.memberSpecific;
		END;
		dAccountBase		:=	PROJECT(dValidRecords(COUNT(memberSpecific)>0),tAccountBase(LEFT));
		
		Business_Credit.Layouts.rMemberSpecific	tMemberSpecific(rPreMS	pInput,	UNSIGNED cnt)	:=	TRANSFORM
			SELF	:=	pInput.MS[cnt];
			SELF	:=	pInput;
		END;

		dMemberSpecific	:=	NORMALIZE(dAccountBase+dIndividualOwner+dBusinessOwner,
													COUNT(LEFT.MS),
													tMemberSpecific(LEFT,COUNTER));

		RETURN	dMemberSpecific;
	END;
END;