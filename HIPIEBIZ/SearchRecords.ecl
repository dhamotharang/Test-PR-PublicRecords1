IMPORT HIPIEBIZ, STD, ut, doxie, AppendCleanAddress, Address;
EXPORT SearchRecords(DATASET(HIPIEBIZ.Layouts.SearchInput) dIn,
										 HIPIEBIZ.Options.SearchParams inOptions) := FUNCTION

	//Sequence records
	dInSeq := PROJECT(dIn, 
		TRANSFORM(HIPIEBIZ.Layouts.SearchInput, 
			SELF.seq 	:= COUNTER,
			SELF			:= LEFT));
			
	//By Business
	dInBusiness	:= PROJECT(dInSeq(BusinessName <> '' or BusinessZip <> '' or BusinessCity <> '' or BusinessState <> '' or FEIN <> ''), HIPIEBIZ.Layouts.BusinessInput);
	dByBusiness := HIPIEBIZ.BusinessRecords(dInBusiness, inOptions);
	
	//By sOfficer
	dInOfficer := PROJECT(dInSeq(OfficerName <> '' or OfficerZip <> '' or OfficerCity <> '' or OfficerState <> '' or SSN <> ''), HIPIEBIZ.Layouts.OfficerInput);
	dByOfficer := HIPIEBIZ.OfficerRecords(dInOfficer, inOptions);
	
	//By Customer Account Number
	dByCustomerAccount := JOIN(dInSeq(TRIM(CustomerAccount) <> ''), HIPIEBIZ.Keys(inOptions).KeyCustomerAccount,
		KEYED(LEFT.CustomerAccount = RIGHT.customer_account[1..LENGTH(TRIM(LEFT.CustomerAccount))]),
		TRANSFORM(HIPIEBIZ.Layouts.SearchOutput,
			SELF	:= LEFT,
			SELF	:= RIGHT),
		LIMIT(0), KEEP(1000));
		
	macJoin(dIn1, dIn2) := FUNCTIONMACRO
		dOut := JOIN(dIn1, dIn2,
			LEFT.BizRecId = RIGHT.BizRecId,
			TRANSFORM(LEFT));
		RETURN dOut;
	ENDMACRO;
	
	dBusinessAndRO := JOIN(dByBusiness, dByOfficer,
		LEFT.BizRecId = RIGHT.BizRecId,
		TRANSFORM(LEFT),
		LIMIT(0), KEEP(1));
		
	boolean searchBusiness := exists(dInBusiness);
	boolean searchOfficer:= exists(dInOfficer);
	boolean searchCustomerAccount := exists(dIn(CustomerAccount <> ''));
	
	dBIZRecords			:= MAP(searchCustomerAccount => dByCustomerAccount,
		searchBusiness and searchOfficer => dBusinessAndRO,
		searchBusiness => dByBusiness,
		dByOfficer);
	
	//Because we have to include ShowNewBusiness in the output layout in order to use it as a filtering parameter in DSP
	//if we set it to true, then only records with ShowNewBusiness set to true in the output will show
	//if we set it to false we want all records to show regardless of the date so all records need to have ShowNewBusiness set to false by default
	dBIZRecordsNewBusinesses := PROJECT(dBIZRecords, 
		TRANSFORM(HIPIEBIZ.Layouts.SearchOutput,
			SELF.ShowNewBusinesses := (INTEGER)(ut.DaysApart((STRING)Std.Date.Today(),(string8)LEFT.bestseledatefirstseen) <= 180),
			SELF := LEFT));
			
	dBIZRecordsFiltered := IF((BOOLEAN)inOptions.ShowNewBusinesses, dBIZRecordsNewBusinesses((BOOLEAN)BipAttributesIsNew), dBIZRecords);
	dOut								:= CHOOSEN(SORT(DEDUP(SORT(dBIZRecordsFiltered, BizRecId), BizRecId), -UltID, -SeleID, -ProxID), 5000);

	// output(dByBusiness, named('dByBusiness'));
	// output(dByOfficer, named('dByOfficer'));
	// output(dByCustomerAccount, named('dByCustomerAccount'));
	RETURN dOut;
END;