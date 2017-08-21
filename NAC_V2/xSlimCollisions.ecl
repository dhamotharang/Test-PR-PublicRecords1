import Address, header, std;

	slim2 := RECORD
	unsigned1 pri:=0
	,string10 matchset:=''
	,unsigned6 LexID:=0
		,string3 LexIdScore
		,string8	StartDate
		,string8	EndDate;
		string2			ProgramState1;
		string1			ProgramCode1;
		string2			ProgramState2;
		string1			ProgramCode2;
		string			name1;
		string			name2;
		string9		SSN1;
		string9		SSN2;
		string8		DOB1;
		string8		DOB2;
		string10 MatchCodes;
		integer2	ssndelta;				// >1 high, > 0 med
		boolean		dobnear;				// dob high
		integer2	dobdelta;				// > 1 medium
		boolean		isSSNhi;
		boolean		isSSNmed;
		boolean		isDobHi;
		boolean		isDobMed;
		//boolean		gensok;
		string20		ClientId1;
		string20		ClientId2;
		string			addr1;
		string			addr2;
	END;

	EXPORT slim2	xSlimCollisions(nac_V2.Layout_Collisions2.Layout_Collisions c) := TRANSFORM
		self.			ProgramState1 := c.BenefitState;
		self.			ProgramCode1 := c.SearchBenefitType;
		self.			ProgramState2 := c.CaseState;
		self.			ProgramCode2 := c.CaseBenefitType;
		self.			name1 :=  Address.NameFromComponents(
										StandardizeName(c.SearchFirstName)
										,StandardizeName(c.SearchMiddleName)
										,StandardizeName(c.SearchLastName)
										,''
										);
		self.			name2 := Address.NameFromComponents(
										StandardizeName(c.ClientFirstName)
										,StandardizeName(c.ClientMiddleName)
										,StandardizeName(c.ClientLastName)
										,''
										);
		self.		SSN1 := c.SearchSSN;
		self.		SSN2 := c.ClientSSN;
		self.		DOB1 := c.SearchDOB;
		self.		DOB2 := c.ClientDob;
		self.ssndelta := ssn_value(c.SearchSSN, c.ClientSSN);
		self.dobnear :=	header.sig_near_dob((integer)c.SearchDOB, (integer)c.ClientDob);
		self.dobdelta := 		header.date_value((integer)c.SearchDOB, (integer)c.ClientDob);
		self.		isSSNhi := ssn_high(c.SearchSSN, c.ClientSSN);
		self.		isSSNmed := ssn_med(c.SearchSSN, c.ClientSSN);
		self.		isDobHi := dob_near((integer)c.SearchDOB, (integer)c.ClientDob);
		self.		isDobMed :=dob_medium((integer)c.SearchDOB,(integer)c.ClientDob);
		//self.gensok := header.gens_ok(l.suffix_field,l.dob_field,r.suffix_field,r.dob_field)
		self.		ClientId1 := c.SearchClientId;
		self.		ClientId2 := c.ClientID;
		self.			addr1 := Std.Str.CleanSpaces(c.SearchAddress1StreetAddress1 + ' ' + c.SearchAddress1StreetAddress2 + ' ' +
																	c.SearchAddress1City + ' ' 
																			+ ' ' + c.SearchAddress1State);
		self.			addr2 := Std.Str.CleanSpaces(c.CasePhysicalStreet1 + ' ' + c.CasePhysicalStreet2 + ' ' +
																	c.CasePhysicalCity + ' ' 
																			+ ' ' + c.CasePhysicalState);
		
		//			SELF.Prepped_addr1    := StandardizeName(L.Street1 + ' ' + L.Street2);
		//		SELF.Prepped_addr2    := ;
	
		self := c;
	END;