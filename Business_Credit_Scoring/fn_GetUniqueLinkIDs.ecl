IMPORT	Business_Credit_Scoring,	Business_Credit,	Business_Risk_BIP,	ut, STD,	Address;
EXPORT	fn_GetUniqueLinkIDs(	STRING	pVersion	=	(STRING8)STD.Date.Today(),
															DATASET(RECORDOF(Business_Credit.Layouts.SBFEAccountLayout)) pInput
														) := FUNCTION 
	
	Business_Risk_BIP.Layouts.Input	tFillLayout(pInput L,	DATASET(RECORDOF(pInput)) allRows)	:=	TRANSFORM
		// SELF.POWID					:=	0;
		// SELF.ProxID					:=	0;
		SELF.CompanyName		:=	L.Clean_Account_Holder_Business_Name;
		SELF.StreetAddress1	:=	Address.Addr1FromComponents(L.prim_range,L.predir,L.prim_name,L.addr_suffix,
																												L.postdir,L.unit_desig,L.sec_range);
		SELF.City						:=	L.v_city_name;
		SELF.State					:=	L.st;
		SELF.Zip5						:=	L.zip;
		SELF.FEIN						:=	L.Federal_TaxID_SSN;
		SELF.Phone10				:=	L.Phone_Number;
		SELF								:=	L;
	END;
	
	pInputGroup	:=	GROUP(SORT(DISTRIBUTE(pInput(	UltID		>	0 OR 
																								OrgID		>	0 OR 
																								SeleID	>	0 ),
										HASH(	UltID, OrgID, SeleID)),
                UltID, OrgID, SeleID, -ProxID, -POWID, -cycle_end_date, LOCAL),
                UltID, OrgID, SeleID, LOCAL);
													
	dFillLayout	:=	ROLLUP(pInputGroup,GROUP,tFillLayout(LEFT,ROWS(LEFT)));
	ut.MAC_Sequence_Records(dFillLayout,Seq,dFillLayoutWithSequenceNumber); // Add a sequence number to all records
	dFillLayoutWithAcctNumber	:=	PROJECT(dFillLayoutWithSequenceNumber,
																	TRANSFORM(RECORDOF(LEFT),
																		SELF.AcctNo	:=	(STRING)LEFT.Seq;
																		SELF				:=	LEFT));
																		
	RETURN	dFillLayoutWithAcctNumber;
END;
