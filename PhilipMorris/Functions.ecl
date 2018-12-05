import Address, mdr, doxie, header, suppress, iesp, AddrBest, DayBatchEDA, NID;

CN := PhilipMorris.Constants;
LT := PhilipMorris.Layouts;
LTB := PhilipMorris.Layouts_Batch;
LB := AddrBest.Layout_BestAddr;
LBO := DayBatchEDA.Layout_Batch_Out;

export Functions := MODULE

	EXPORT fn_getLen(STRING x) := LENGTH(TRIM(x));	
		
	SHARED MAC_GetBase() := MACRO
		String TransactionNumber := '' : STORED('TransactionNumber');
		String CCN := '' : STORED('CCN');
		String ContactID := '' : STORED('ContactID');
		String ChannelIdentifier := '' : STORED('ChannelIdentifier');			
		
		String Title := '' : STORED('Title');
		String NameFirst := '' : STORED('NameFirst');
		String NameMiddle := '' : STORED('NameMiddle');
		String NameLast := '' : STORED('NameLast');

		String NameSuffix := '' : STORED('NameSuffix');
		String SSN := '' : STORED('SSN');
		String SSNLast4 := '' : STORED('SSNLast4');
		String DOB_YYYYMMDD := '' : STORED('DOB_YYYYMMDD');

		String GIIDAddressLine1 := '' : STORED('GIIDAddressLine1');
		String GIIDAddressLine2 := '' : STORED('GIIDAddressLine2');
		String GIIDCity := '' : STORED('GIIDCity');
		String GIIDState := '' : STORED('GIIDState');
		String GIIDZipCode := '' : STORED('GIIDZipCode');

		String CurrentAddressLine1 := '' : STORED('CurrentAddressLine1');
		String CurrentAddressLine2 := '' : STORED('CurrentAddressLine2');
		String CurrentCity := '' : STORED('CurrentCity');
		String CurrentState := '' : STORED('CurrentState');
		String CurrentZipCode := '' : STORED('CurrentZipCode');

		String PreviousAddressLine1 := '' : STORED('PreviousAddressLine1');
		String PreviousAddressLine2 := '' : STORED('PreviousAddressLine2');
		String PreviousCity := '' : STORED('PreviousCity');
		String PreviousState := '' : STORED('PreviousState');
		String PreviousZipCode := '' : STORED('PreviousZipCode');
			
		self.acctno := '';
		self.TransactionNumber := TransactionNumber;
		self.CCN := CCN;
		self.ContactID := ContactID;
		self.ChannelIdentifier := ChannelIdentifier;
			
		self.Title := Title;
		self.NameFirst := NameFirst;
		self.NameMiddle := NameMiddle;
		self.NameLast := NameLast;

		self.NameSuffix := NameSuffix;
		//self.SSN := SSN;
		self.DOB_YYYYMMDD := DOB_YYYYMMDD;

		self.GIIDAddress.AddressLine1 := GIIDAddressLine1;
		self.GIIDAddress.AddressLine2 := GIIDAddressLine2;
		self.GIIDAddress.City := GIIDCity;
		self.GIIDAddress.State := GIIDState;
		self.GIIDAddress.ZipCode := GIIDZipCode;

		self.CurrentAddress.AddressLine1 := CurrentAddressLine1;
		self.CurrentAddress.AddressLine2 := CurrentAddressLine2;
		self.CurrentAddress.City := CurrentCity;
		self.CurrentAddress.State := CurrentState;
		self.CurrentAddress.ZipCode := CurrentZipCode;

		self.PreviousAddress.AddressLine1 := PreviousAddressLine1;
		self.PreviousAddress.AddressLine2 := PreviousAddressLine2;
		self.PreviousAddress.City := PreviousCity;
		self.PreviousAddress.State := PreviousState;
		self.PreviousAddress.ZipCode := PreviousZipCode;
		self.InputEcho.TransactionNumber := self.TransactionNumber;
		self.InputEcho.CCN := self.CCN;
		self.InputEcho.ContactID := self.ContactID;
		self.InputEcho.ChannelIdentifier := self.ChannelIdentifier;
		self.InputEcho.Name.Prefix := self.Title;
		self.InputEcho.Name.First := self.NameFirst;
		self.InputEcho.Name.Middle := self.NameMiddle;
		self.InputEcho.Name.Last := self.NameLast;
		self.InputEcho.Name.Suffix := self.NameSuffix;
		//self.InputEcho.SSN := self.SSN;
		self.InputEcho.DOB := iesp.ECL2ESP.toDatestring8 (self.DOB_YYYYMMDD);
		self.InputEcho.GIIDAddress.StreetAddress1 := self.GIIDAddress.AddressLine1;
		self.InputEcho.GIIDAddress.StreetAddress2 := self.GIIDAddress.AddressLine2;
		self.InputEcho.GIIDAddress.City := self.GIIDAddress.City;
		self.InputEcho.GIIDAddress.State := self.GIIDAddress.State;
		self.InputEcho.GIIDAddress.Zip5 := self.GIIDAddress.ZipCode;
		self.InputEcho.CurrentAddress.StreetAddress1 := self.CurrentAddress.AddressLine1;
		self.InputEcho.CurrentAddress.StreetAddress2 := self.CurrentAddress.AddressLine2;
		self.InputEcho.CurrentAddress.City := self.CurrentAddress.City;
		self.InputEcho.CurrentAddress.State := self.CurrentAddress.State;
		self.InputEcho.CurrentAddress.Zip5 := self.CurrentAddress.ZipCode;
		self.InputEcho.PreviousAddress.StreetAddress1 := self.PreviousAddress.AddressLine1;
		self.InputEcho.PreviousAddress.StreetAddress2 := self.PreviousAddress.AddressLine2;						
		self.InputEcho.PreviousAddress.City := self.PreviousAddress.City;
		self.InputEcho.PreviousAddress.State := self.PreviousAddress.State;
		self.InputEcho.PreviousAddress.Zip5 := self.PreviousAddress.ZipCode;	
		
	ENDMACRO;
		
	EXPORT fn_getNonXMLInputData() := FUNCTION
	
		LT.InRecord.Dirty.FullRecord getGlobalComponents := TRANSFORM		
				
			MAC_GetBase();
			self.SSN := SSN;
			self.InputEcho.SSN := self.SSN;
			//all other fields purposedly blank
			self.InputEcho := [];			

		END;
			
		RETURN DATASET([getGlobalComponents]);
	END;
	
	EXPORT fn_getNonXMLInputDataSSN4() := FUNCTION
	
		LT.InRecord.Dirty.SSN4FullRecord getGlobalComponents := TRANSFORM		
				
			MAC_GetBase();
			self.SSN := SSNLast4;			
			self.InputEcho.SSNLast4 := self.SSN;
			//all other fields purposedly blank
			self.InputEcho := [];			
		END;
			
		RETURN DATASET([getGlobalComponents]);
	END;
	
	EXPORT fn_IsPoBox( String Prim_Name ) := Prim_Name[1..7] = 'PO BOX ';
	
	EXPORT fn_RRType( String Prim_Name ) :=  Prim_Name[1..3] in ['RR ', 'HC '];
	
	EXPORT fn_BuildBirthDate( Year, Month, Day ) := FUNCTION
				
		is_valid_components := (year >= 1800) and (Month between 1 and 12) and (Day between 1 and 31);
		s_year := if ( is_valid_components, (String) Year, '');
		s_month := if ( is_valid_components, (String) Month, '');
		s_day := if ( is_valid_components, (String) Day, '');
		
		clean_month := CASE ( fn_getlen(s_month), 1 => '0' + s_month, 2 => s_month, '');
		clean_day := CASE ( fn_getlen(s_day), 1 => '0' + s_day, 2 => s_day, '');
		
		return if ( fn_getlen(s_year) = 4 and fn_getlen(clean_month) = 2 and fn_getlen(clean_day) = 2, s_year + clean_month + clean_day, '');
		
	END;
	
	EXPORT fn_getCleanAddress(LT.InRecord.Dirty.Address le, INTEGER2 AddressID) := FUNCTION
	
		LT.Clean.Address getCleanComponents := TRANSFORM
			street_addr_1 := StringLib.StringCleanSpaces(TRIM(le.AddressLine1 + ' '+ le.AddressLine2));
			city_st_zip_1 := StringLib.StringCleanSpaces(Address.Addr2FromComponents(le.City, le.State, le.ZipCode));	
			clean_addr_1 := if(street_addr_1='' or city_st_zip_1='', '', Address.CleanAddress182(street_addr_1,city_st_zip_1));
			
			self.Prim_Range := clean_addr_1[1..10];
			self.PreDir := clean_addr_1[11..12];
			self.Prim_Name := clean_addr_1[13..40];
			self.Addr_Suffix := clean_addr_1[41..44];
			self.Postdir := clean_addr_1[45..46];
			self.Unit_Desig := clean_addr_1[47..56];
			self.Sec_Range := clean_addr_1[57..64];
			self.V_City_Name := clean_addr_1[90..114];
			self.St := clean_addr_1[115..116];
			self.Zip5 := clean_addr_1[117..121];
			self.Zip4 := clean_addr_1[122..125];
			self.addr_rec_type := clean_addr_1[139];
			self.err_stat := clean_addr_1[179..182];
			self.fips_county := clean_addr_1[143..145];
						
			self.AddressID := AddressID;
			self.ISPoBOXType := fn_IsPoBox(self.Prim_Name);
			self.ISRRType := fn_RRType(self.Prim_Name);
			self.Z5Numeric := (Integer4)self.Zip5;			
			self.PrimNameLen 			:= fn_getLen(self.Prim_Name);
			self.PrimRangeLen 		:= fn_getLen(self.Prim_Range);						
		END;
		
		RETURN ROW(getCleanComponents);
		
	END;

	EXPORT LT.Clean.Name fn_getCleanName(STRING LastName, String FirstName, String MiddleName, String Suffix, String Title, boolean bUseCleaner=true) := FUNCTION
				
		LT.Clean.Name getCleanComponents := TRANSFORM
					
			//per Vladimir, F M L is the best way to pass the data to the cleaner
			//suffix and title should not be included AND
			//the title/suffix generated by the cleaner will be ignored (we will use the customer provided ones directly)
			
			//per kathy bardeen, eliminate spaces in the last name so we dont do searches incorrectly on
			//multi part last names (first part of last name becomes middle name)
			l_Last := StringLib.StringFindReplace(LastName, ' ', '');
			UnParsedFullName := StringLib.StringCleanSpaces(FirstName + ' ' + MiddleName + ' ' + l_Last);
			cleaned_name := if (bUseCleaner, stringlib.stringtouppercase(address.CleanPersonFML73(UnParsedFullName)), '');				
						
			cleaner_first := TRIM(cleaned_name[6..25]);
			cleaner_last := TRIM(cleaned_name[46..65]);
			cleaner_middle := TRIM(cleaned_name[26..45]);
			cleaner_suffix := TRIM(cleaned_name[66..70]);
			cleaner_title := TRIM(cleaned_name[1..5]);
			
			noncleaner_first := StringLib.StringCleanSpaces(TRIM(stringlib.stringfilter(stringlib.stringtouppercase(FirstName), CN.ALPHABET)));
			noncleaner_last := StringLib.StringCleanSpaces(TRIM(stringlib.stringfilter(stringlib.stringtouppercase(l_Last), CN.ALPHABET)));
			noncleaner_middle := StringLib.StringCleanSpaces(TRIM(stringlib.stringfilter(stringlib.stringtouppercase(MiddleName), CN.ALPHABET)));
			noncleaner_suffix := StringLib.StringCleanSpaces(TRIM(stringlib.stringfilter(stringlib.stringtouppercase(Suffix), CN.ALPHABET)));
			noncleaner_title := StringLib.StringCleanSpaces(TRIM(stringlib.stringfilter(stringlib.stringtouppercase(Title), CN.ALPHABET)));
			
			//if we have a last, first from the cleaner, we will use ALL output from the cleaner
      boolean use_cleaned := cleaner_first <> '' and cleaner_last <> '';
			SELF.Fname := IF ( use_cleaned, cleaner_first, noncleaner_first);
			SELF.Lname :=  IF ( use_cleaned, cleaner_last, noncleaner_last);
			SELF.Mname :=  IF ( use_cleaned, cleaner_middle, noncleaner_middle);
			//SELF.Name_Suffix :=  IF ( TRIM(cleaner_first) <> '' and TRIM(cleaner_last) <> '', cleaner_suffix, noncleaner_suffix);
			//SELF.Title :=  IF ( TRIM(cleaner_first) <> '' and TRIM(cleaner_last) <> '', cleaner_title, noncleaner_title);
			SELF.Name_Suffix :=  noncleaner_suffix;
			SELF.Title :=  noncleaner_title;
			
			SELF.PFname := StringLib.StringCleanSpaces(NID.PreferredFirstNew(SELF.Fname,false));
			SELF.PFname2 := StringLib.StringCleanSpaces(NID.PreferredFirstNew(SELF.Fname,true));
			SELF.PhoneticLname := StringLib.StringCleanSpaces(metaphonelib.DMetaPhone1(SELF.Lname));
			
		END;
		
		RETURN ROW(getCleanComponents);
		
	END;
	
	EXPORT fn_CleanSSN ( String DirtySSN ) := function
			CleanSSN := REGEXREPLACE( '-', DirtySSN, '');			
			RETURN (QString9)StringLib.StringCleanSpaces((TRIM(MAP(fn_getLen(CleanSSN)=7 =>'00' + CleanSSN,
																														 fn_getLen(CleanSSN)=8 =>'0' + CleanSSN,
																														 CleanSSN))));
	END;
	
	EXPORT fn_CleanSSN4 ( String DirtySSN4 ) := function
			CleanSSN4 := REGEXREPLACE( '-', DirtySSN4, '');			
			RETURN (QString9)StringLib.StringCleanSpaces(TRIM(CleanSSN4));
	END;
	
	EXPORT fn_IsSearchableSSN( String CleanSSN ) := 
			(unsigned8)CleanSSN <> 0 AND 
			 fn_getLen(CleanSSN) = 9 AND
			 CleanSSN[1..3] <> '000' AND
			 CleanSSN not in ['000000000', 
												'111111111', 
												'222222222', 
												'333333333', 
												'444444444', 
												'555555555', 
												'666666666', 
												'777777777', 
												'888888888', 
												'999999999', 
												'012345678', 
												'123456789'];
												
	EXPORT fn_IsSearchableSSN4 (String CleanSSN4) :=
		(unsigned4)CleanSSN4 <> 0 AND 
			 fn_getLen(CleanSSN4) = 4 AND
			 CleanSSN4[1..4] <> '0000';			 
	
	EXPORT fn_CleanDOB ( String DirtyDOB ) := function
			CleanDOB := REGEXREPLACE( '[\\, /, -]', DirtyDOB, '');			
			RETURN (QString8)StringLib.StringCleanSpaces((TRIM(CleanDOB) + '00000000'));
	END;
	
	EXPORT fn_CleanDOBFromInt ( INTEGER DirtyDOB ) := fn_CleanDOB((String)(DirtyDOB));

	EXPORT fn_MatchesSSN( QString9 SSN1, QString9 SSN2 ) := SSN1 <> '' and SSN1 = SSN2;
	
	EXPORT fn_MatchesSSN4( QString9 SSN4_1, QString9 SSN4_2 ) := SSN4_1 <> '' and SSN4_1 = SSN4_2;	
	
	EXPORT fn_MatchesYOB( QSTRING8 DOB1_YYYYMMDD, QSTRING8 DOB2_YYYYMMDD ) := DOB1_YYYYMMDD[1..4] <> '0000' and DOB1_YYYYMMDD <> '' and DOB1_YYYYMMDD[1..4] = 	DOB2_YYYYMMDD[1..4];
	
	EXPORT fn_MatchesYOBMOB( QSTRING8 DOB1_YYYYMMDD, QSTRING8 DOB2_YYYYMMDD ) := fn_MatchesYOB(DOB1_YYYYMMDD, DOB2_YYYYMMDD) AND DOB1_YYYYMMDD[5..6] <> '00' AND DOB1_YYYYMMDD[5..6] <> '' and DOB1_YYYYMMDD[5..6] = 	DOB2_YYYYMMDD[5..6];
	
	EXPORT fn_MatchesYOBMOBDOB( QSTRING8 DOB1_YYYYMMDD, QSTRING8 DOB2_YYYYMMDD ) := fn_MatchesYOBMOB(DOB1_YYYYMMDD, DOB2_YYYYMMDD) AND DOB1_YYYYMMDD[7..8] <> '00' AND DOB1_YYYYMMDD[7..8] <> '' and DOB1_YYYYMMDD[7..8] = 	DOB2_YYYYMMDD[7..8];
		
	EXPORT fn_MatchesZIP_Exact( INTEGER4 ZIP5_1, INTEGER4 ZIP5_2 ) := ZIP5_1 <> 0 and ZIP5_1 = ZIP5_2;
		
	EXPORT fn_MatchesZIP( INTEGER4 ZIP5_1, INTEGER4 ZIP5_2 ) := fn_MatchesZip_Exact(ZIP5_1, ZIP5_2);
		
	EXPORT fn_MatchesHouseNumberPobBox_Exact(LT.Clean.Address CleanAddress1, LT.Clean.Address CleanAddress2 ) :=
		CleanAddress1.Prim_Name <> '' and CleanAddress1.Prim_Name = CleanAddress2.Prim_Name;
	
	EXPORT fn_MatchesHouseNumberPobBox(LT.Clean.Address CleanAddress1, LT.Clean.Address CleanAddress2 ) := 
		MAP((fn_getLen(CleanAddress1.Prim_Name) >= 10) => (CleanAddress1.Prim_Name[1..10] = CleanAddress2.Prim_Name[1..10]),
				(fn_getLen(CleanAddress1.Prim_Name) > 0) 	 => (CleanAddress1.Prim_Name = CleanAddress2.Prim_Name),
				FALSE);
	
	EXPORT fn_MatchesHouseNumberRR_Exact(LT.Clean.Address CleanAddress1, LT.Clean.Address CleanAddress2 ) := 
		MAP((fn_getLen(CleanAddress1.Sec_Range) <> 0) => (CleanAddress1.Sec_Range = CleanAddress2.Sec_Range),
				(fn_getLen(CleanAddress1.Sec_Range) = 0 and (fn_getLen(CleanAddress2.Sec_Range) = 0)) => TRUE,
				FALSE);
	
	//It seems like if one of them was null and the other one wasnt, this would
	//have passed in the CPS world and that does not seem right
	//at the moment, stricter seems to be the better alternative
	EXPORT fn_MatchesHouseNumberRR(LT.Clean.Address CleanAddress1, LT.Clean.Address CleanAddress2 ) := 
		MAP((fn_getLen(CleanAddress1.Sec_Range) >= 3) => (CleanAddress1.Sec_Range[1..3] = CleanAddress2.Sec_Range[1..3]),
				(fn_getLen(CleanAddress1.Sec_Range) > 0) => (CleanAddress1.Sec_Range = CleanAddress2.Sec_Range),
				(fn_getLen(CleanAddress1.Sec_Range) = 0 and (fn_getLen(CleanAddress2.Sec_Range) = 0)) => TRUE,
				FALSE);
	
	EXPORT fn_MatchesHouseNumberNormal_Exact(LT.Clean.Address CleanAddress1, LT.Clean.Address CleanAddress2 ) := 
		MAP((fn_getLen(CleanAddress1.Prim_Range) <> 0) => (CleanAddress1.Prim_Range = CleanAddress2.Prim_Range),
				(fn_getLen(CleanAddress1.Prim_Range) = 0 and (fn_getLen(CleanAddress2.Prim_Range) = 0)) => TRUE,
				FALSE);
	
	EXPORT fn_MatchesStreetNameNormal_Exact(LT.Clean.Address CleanAddress1, LT.Clean.Address CleanAddress2 ) :=
		IF ((fn_getLen(CleanAddress1.Prim_Name) <> 0), 
				(CleanAddress1.Prim_Name = CleanAddress2.Prim_Name),
				FALSE);
	
	EXPORT fn_MatchesHouseNumberNormal(LT.Clean.Address CleanAddress1, LT.Clean.Address CleanAddress2 ) := 
		MAP((fn_getLen(CleanAddress1.Prim_Range) >= 3) => (CleanAddress1.Prim_Range[1..3] = CleanAddress2.Prim_Range[1..3]),
				(fn_getLen(CleanAddress1.Prim_Range) > 0) => (CleanAddress1.Prim_Range = CleanAddress2.Prim_Range),
				(fn_getLen(CleanAddress1.Prim_Range) = 0 and (fn_getLen(CleanAddress2.Prim_Range) = 0)) => TRUE,
				FALSE);
								
	EXPORT fn_MatchesStreetNameNormal(LT.Clean.Address CleanAddress1, LT.Clean.Address CleanAddress2 ) := 
		MAP((fn_getLen(CleanAddress1.Prim_Name) >= 4) => (CleanAddress1.Prim_Name[1..4] = CleanAddress2.Prim_Name[1..4]),
				(fn_getLen(CleanAddress1.Prim_Name) > 0) => (CleanAddress1.Prim_Name = CleanAddress2.Prim_Name),
				FALSE);
	
	EXPORT fn_MatchesAddress(LT.Clean.Address CleanAddress1, LT.Clean.Address CleanAddress2 ) := FUNCTION
		matchesZip := fn_MatchesZIP(CleanAddress1.Z5Numeric, CleanAddress2.Z5Numeric);
		matchesHouseNumber := MAP(CleanAddress1.ISPoBOXType => fn_MatchesHouseNumberPobBox(CleanAddress1, CleanAddress2),
															CleanAddress1.ISRRType	  => fn_MatchesHouseNumberRR(CleanAddress1, CleanAddress2),
															fn_MatchesHouseNumberNormal(CleanAddress1, CleanAddress2));
		matchesStreetName := fn_MatchesStreetNameNormal(CleanAddress1, CleanAddress2);
		return matchesZip and matchesHouseNumber and MatchesStreetName;
	END;
	
	EXPORT fn_MatchesAddress_Exact(LT.Clean.Address CleanAddress1, LT.Clean.Address CleanAddress2 ) := FUNCTION
		matchesZip := fn_MatchesZIP_Exact(CleanAddress1.Z5Numeric, CleanAddress2.Z5Numeric);
		matchesHouseNumber := MAP(CleanAddress1.ISPoBOXType => fn_MatchesHouseNumberPobBox_Exact(CleanAddress1, CleanAddress2),
															CleanAddress1.ISRRType	  => fn_MatchesHouseNumberRR_Exact(CleanAddress1, CleanAddress2),
															fn_MatchesHouseNumberNormal_Exact(CleanAddress1, CleanAddress2));
		matchesStreetName := fn_MatchesStreetNameNormal_Exact(CleanAddress1, CleanAddress2);
		return matchesZip and matchesHouseNumber and MatchesStreetName;
	END;	
	
	SHARED fn_MatchesFuzzyString(String str1, String str2, Real FuzzyMatchingThresholdPct) := FUNCTION
		//attempt to address the issue of hyphens vs no hyphens in the fuzzy step (and other punctuation)
		f_str1 := stringlib.stringfilter(stringlib.stringtouppercase(str1), CN.ALPHABET);
		f_str2 := stringlib.stringfilter(stringlib.stringtouppercase(str2), CN.ALPHABET);
		return f_str1[1] <> ' ' and f_str1[1] = f_str2[1] and (100-datalib.StringSimilar100(trim(f_str1), trim(f_str2))) >= FuzzyMatchingThresholdPct;			
	END;	
	
	EXPORT fn_MatchesLastName_Exact(LT.Clean.Name CleanName1, LT.Clean.Name CleanName2 ) := CleanName1.Lname <> '' and CleanName1.Lname = CleanName2.Lname;
	
	EXPORT fn_MatchesLastName_Fuzzy(LT.Clean.Name CleanName1, LT.Clean.Name CleanName2, Real FuzzyMatchingThresholdPct ) := fn_MatchesFuzzyString(CleanName1.LName, CleanName2.LName, FuzzyMatchingThresholdPct);

	//left hand side expected to be SEARCH data
	//right hand side expected to be LN data
	fn_MatchesFirstInitial(LT.Clean.Name CleanName1, LT.Clean.Name CleanName2 ) := 
		CleanName1.Fname <> '' and (fn_getLen(CleanName1.Fname) = 1) AND (CleanName1.Fname[1] = CleanName2.Fname[1] ) ;
	
	//left hand side expected to be SEARCH data
	//right hand side expected to be LN data
	//it is possible that PFName -> PFName would be a sufficient comparison
	//however, in an effort to find as many matches as possible, the extra comparisons have been kept
	EXPORT fn_MatchesFirstName_Exact(LT.Clean.Name CleanName1, LT.Clean.Name CleanName2, boolean bAcceptFirstInitialHit = false ) := FUNCTION
		bMatchesFull :=	CleanName1.Fname <> '' and 
									(CleanName1.Fname = CleanName2.Fname or 
									 CleanName1.PFname = CleanName2.Fname or
									 CleanName1.Fname = CleanName2.PFname or
									 CleanName1.PFname = CleanName2.PFname or
									 CleanName1.PFname = CleanName2.PFname2 or
									 CleanName1.PFname2 = CleanName2.Fname or
									 CleanName1.Fname = CleanName2.PFname2 or
									 CleanName1.PFname2 = CleanName2.PFname2 or
									 CleanName1.PFname2 = CleanName2.PFname); 
		bMatchesInitial := bAcceptFirstInitialHit and fn_MatchesFirstInitial(CleanName1, CleanName2);
		RETURN IF ( bMatchesFull, bMatchesFull, bMatchesInitial);
	END;
	
	EXPORT fn_MatchesFirstName_Fuzzy(LT.Clean.Name CleanName1, LT.Clean.Name CleanName2, Real FuzzyMatchingThresholdPct ) :=
		fn_MatchesFuzzyString(CleanName1.FName, CleanName2.FName, FuzzyMatchingThresholdPct);
	
	EXPORT fn_MatchesFirstLastName_Fuzzy(LT.Clean.Name CleanName1, LT.Clean.Name CleanName2, Real FuzzyMatchingThresholdPct ) := FUNCTION
				
		name1Full_1 := TRIM(CleanName1.LName) + TRIM(CleanName1.FName);	
		name1Full_2 := TRIM(CleanName1.FName) + TRIM(CleanName1.LName);
		
		name2Full_1 := TRIM(CleanName2.LName) + TRIM(CleanName2.FName);
		name2Full_2 := TRIM(CleanName2.FName) + TRIM(CleanName2.LName);
		
		matchesBothIndivComponents := fn_MatchesFirstName_Fuzzy(CleanName1, CleanName2, FuzzyMatchingThresholdPct) AND 
																	fn_MatchesLastName_Fuzzy(CleanName1, CleanName2, FuzzyMatchingThresholdPct);
																	
		matchesComponentsTogether := 	fn_MatchesFuzzyString(name1Full_1, name2Full_1, FuzzyMatchingThresholdPct) OR						
																	fn_MatchesFuzzyString(name1Full_2, name2Full_2, FuzzyMatchingThresholdPct);	
																	
		canAttemptComponentsTogether := fn_getLen(CleanName1.LName) > 1 AND
																		fn_getLen(CleanName1.FName) > 1 AND
																		fn_getLen(CleanName2.LName) > 1 AND
																		fn_getLen(CleanName2.FName) > 1;
		
		RETURN (matchesBothIndivComponents OR (canAttemptComponentsTogether AND matchesComponentsTogether));
	END;
	
	fn_MatchesFirstLastInstringHelper( string str1, string str2 ) := FUNCTION
		str1local := ' ' + TRIM(str1) + ' ';
		str2local := ' ' + TRIM(str2) + ' ';
		return stringlib.stringFind(str1local, str2local, 1) > 0;
	END;
	
	fn_MatchesFirstLastInstringNameHelper(LT.Clean.Name CleanName1, LT.Clean.Name CleanName2 ) := FUNCTION
		name2Complete1 := TRIM(CleanName2.LName) + ' ' + TRIM(CleanName2.FName)  + ' ' + TRIM(CleanName2.MName);
		name2Complete2 := TRIM(CleanName2.LName) + ' ' + TRIM(CleanName2.PFName)  + ' ' + TRIM(CleanName2.MName);
		name2Complete3 := TRIM(CleanName2.LName) + ' ' + TRIM(CleanName2.PFName2)  + ' ' + TRIM(CleanName2.MName);
						
		fName1FoundTmp := fn_MatchesFirstLastInstringHelper(name2Complete1,CleanName1.FName);
		fName1FoundTmp2 := IF ( ~fName1FoundTmp, fn_MatchesFirstLastInstringHelper(name2Complete2,CleanName1.FName), true);
		fName1Found := IF ( ~fName1FoundTmp2, fn_MatchesFirstLastInstringHelper(name2Complete3,CleanName1.FName), true);
		
		lName1Found := fn_MatchesFirstLastInstringHelper(name2Complete1,CleanName1.LName);
		
		RETURN ( fName1Found and lName1Found );
	END;
	
	EXPORT fn_MatchesFirstLastInstring(LT.Clean.Name SearchName, LT.Clean.Name LNName ) :=
		fn_MatchesFirstLastInstringNameHelper(SearchName, LNName);
	
	EXPORT fn_GetAgeMatchType(QString8 DOB1_YYYYMMDD, QString8 DOB2_YYYYMMDD ) := FUNCTION
		lenDob1 := fn_getLen(DOB1_YYYYMMDD);
		
		RETURN  MAP ( lenDob1 >= 8 and fn_MatchesYOBMOBDOB(DOB1_YYYYMMDD, DOB2_YYYYMMDD) => CN.SortAgeMatchTypeEnum.YYYYMMDD,
									lenDob1 >= 8 and fn_MatchesYOBMOB(DOB1_YYYYMMDD, DOB2_YYYYMMDD) => CN.SortAgeMatchTypeEnum.YYYYMM,
									lenDob1 >= 8 and fn_MatchesYOBMOB(DOB1_YYYYMMDD, DOB2_YYYYMMDD) => CN.SortAgeMatchTypeEnum.YYYY,
									lenDob1 >= 6 and fn_MatchesYOBMOB(DOB1_YYYYMMDD, DOB2_YYYYMMDD) => CN.SortAgeMatchTypeEnum.YYYYMM,
									lenDob1 >= 6 and fn_MatchesYOB(DOB1_YYYYMMDD, DOB2_YYYYMMDD) => CN.SortAgeMatchTypeEnum.YYYY,
									lenDob1 >= 4 and fn_MatchesYOB(DOB1_YYYYMMDD, DOB2_YYYYMMDD) => CN.SortAgeMatchTypeEnum.YYYY,
									CN.SortAgeMatchTypeEnum.NONE);
									
	END;
	
	//based on output DOB
	EXPORT fn_GetUnderAge(QString8 DOB1_YYYYMMDD, UNSIGNED2 minAgeValue, UNSIGNED2 todayYear, UNSIGNED4 todayYearMonth, UNSIGNED4 todayYearMonthDay) := FUNCTION
		totalBytesAvailable := MAP(fn_getLen(DOB1_YYYYMMDD) >= 6 and DOB1_YYYYMMDD[5..6] = '00' => 4, 
															 fn_getLen(DOB1_YYYYMMDD) >= 8 and DOB1_YYYYMMDD[6..8] = '00' => 6,
															 fn_getLen(DOB1_YYYYMMDD) >= 8 => 8,
															 0);
													 
		DOBOutputNumeric := (UNSIGNED4)(DOB1_YYYYMMDD[1..totalBytesAvailable]);
		
		RETURN  MAP ( totalBytesAvailable = 8 and (todayYearMonthDay - DOBOutputNumeric < (minAgeValue * 10000)) => CN.DISPLAY_YES,
									totalBytesAvailable = 6 and (todayYearMonth - DOBOutputNumeric < (minAgeValue * 100)) => CN.DISPLAY_YES,
									totalBytesAvailable = 4 and (todayYear - DOBOutputNumeric < (minAgeValue)) => CN.DISPLAY_YES,
								  CN.DISPLAY_NO);
									
	END;
	
	EXPORT fn_GetSourceNameSort (STRING2 src, CN.SortSearchPassEnum searchPass) := MAP (
					 src IN ['AD','CD','DD','ED','FD','ID','KD','ND','OD','PD','SD','TD','VD','WD',
									 'YD','1X','2X','3X','4X','5X','6X','7X','8X','9X','BX','XX','ZX'] => CN.SortSourceEnum.DMV,
					 src IN ['AV','EV','FV','IV','KV','LV','MV','NV','OV','PV','RV','QV','TV','WV','XV',
									 'YV','!E','#E','$E','&E','+E','.E','?E','@E','AE','BE','CE','EE','GE','HE',
									 'IE','JE','KE','LE','NE','OE','ME','PE','QE','UE','RE','SE','TE','VE','WE','XE','ZE'] => CN.SortSourceEnum.MVR,				 
					 src IN ['UT','ZT'] => CN.SortSourceEnum.UTILITY,
					 src IN ['EQ','TS', 'EN', 'LT', 'TU', 'QH', 'WH', 'TN'] => CN.SortSourceEnum.CHDR,
					 searchPass != CN.SortSearchPassEnum.SSN4EXPANSION and src IN ['CY'] => CN.SortSourceEnum.CERTEGY,
					 searchPass != CN.SortSearchPassEnum.SSN4EXPANSION and src IN ['VO'] => CN.SortSourceEnum.VOTR,
					 CN.SortSourceEnum.UNK); 
	
	EXPORT fn_GetSourceName (CN.SortSearchPassEnum sourceNameSort, boolean bIsDerived) :=
			MAP( sourceNameSort = CN.SortSourceEnum.DMV and ~bIsDerived => CN.DISPLAY_SOURCENAME_ORIGINALDATA_DMV, 
					 sourceNameSort = CN.SortSourceEnum.MVR and ~bIsDerived => CN.DISPLAY_SOURCENAME_ORIGINALDATA_MVR,							   
					 sourceNameSort = CN.SortSourceEnum.VOTR and ~bIsDerived => CN.DISPLAY_SOURCENAME_ORIGINALDATA_VOTR,
					 sourceNameSort = CN.SortSourceEnum.CHDR and ~bIsDerived => CN.DISPLAY_SOURCENAME_ORIGINALDATA_CHDR,					 
					 sourceNameSort = CN.SortSourceEnum.CHDR_EXPERIAN_GW and ~bIsDerived => CN.DISPLAY_SOURCENAME_ORIGINALDATA_EXPERIAN_GW,
           sourceNameSort = CN.SortSourceEnum.CLUE and ~bIsDerived => CN.DISPLAY_SOURCENAME_ORIGINALDATA_CLUE,
           sourceNameSort = CN.SortSourceEnum.UTILITY and ~bIsDerived => CN.DISPLAY_SOURCENAME_ORIGINALDATA_UTILITY,
					 sourceNameSort = CN.SortSourceEnum.CERTEGY and ~bIsDerived => CN.DISPLAY_SOURCENAME_ORIGINALDATA_CERTEGY,
					 sourceNameSort = CN.SortSourceEnum.DMV and bIsDerived => CN.DISPLAY_SOURCENAME_DERIVEDDATA_DMV, 
					 sourceNameSort = CN.SortSourceEnum.MVR and bIsDerived => CN.DISPLAY_SOURCENAME_DERIVEDDATA_MVR,							   
					 sourceNameSort = CN.SortSourceEnum.VOTR and bIsDerived => CN.DISPLAY_SOURCENAME_DERIVEDDATA_VOTR,
					 sourceNameSort = CN.SortSourceEnum.CHDR and bIsDerived => CN.DISPLAY_SOURCENAME_DERIVEDDATA_CHDR,
 					 sourceNameSort = CN.SortSourceEnum.CHDR_EXPERIAN_GW and bIsDerived => CN.DISPLAY_SOURCENAME_DERIVEDDATA_EXPERIAN_GW,
           sourceNameSort = CN.SortSourceEnum.CLUE and bIsDerived => CN.DISPLAY_SOURCENAME_DERIVEDDATA_CLUE,
           sourceNameSort = CN.SortSourceEnum.UTILITY and bIsDerived => CN.DISPLAY_SOURCENAME_DERIVEDDATA_UTILITY,
					 sourceNameSort = CN.SortSourceEnum.CERTEGY and bIsDerived => CN.DISPLAY_SOURCENAME_DERIVEDDATA_CERTEGY,
					 CN.DISPLAY_SOURCENAME_BLANK);
	
	//INTERNAL ONLY
	EXPORT fn_GetSourceType (STRING2 src) := 	MDR.sourceTools.TranslateSource(src);																			       
	
	EXPORT fn_GetInputMatchCode (CN.SortSearchPassEnum searchPass, CN.AddressTypeEnum AddressID ) := FUNCTION
			
			searchPassIsFuzzy := searchPass in 
													[CN.SortSearchPassEnum.FUZZY1_F,
													CN.SortSearchPassEnum.FUZZY1_L,
													CN.SortSearchPassEnum.FUZZY1_LF,
													CN.SortSearchPassEnum.FUZZY2_F,
													CN.SortSearchPassEnum.FUZZY2_L,
													CN.SortSearchPassEnum.FUZZY2_LF,
													CN.SortSearchPassEnum.FUZZYX_LF,
													CN.SortSearchPassEnum.FUZZY_INSTRING,
													CN.SortSearchPassEnum.MISS_DERIVE_FUZZY];
													
			searchPassViaAddress := searchPass in 
															[CN.SortSearchPassEnum.PRIMARY,
															CN.SortSearchPassEnum.NAMEFLIP_PRIMARY,
															CN.SortSearchPassEnum.FIRSTINITIAL,
															CN.SortSearchPassEnum.IGNOREHOUSENUMBER,
															CN.SortSearchPassEnum.SSN4EXPANSION];
															
			searchPassDerived := searchPass in 
															[CN.SortSearchPassEnum.DERIVED,
															CN.SortSearchPassEnum.NAMEFLIP_DERIVED,
															CN.SortSearchPassEnum.DERIVED_IGNORE_LAST];			
			
			RETURN 
			MAP( searchPass = CN.SortSearchPassEnum.INPUT_SSN => CN.DISPLAY_INPUTMATCHCODE_SSN,
					 searchPass = CN.SortSearchPassEnum.INPUT_SSN_IGNORE_LAST => CN.DISPLAY_INPUTMATCHCODE_SSN_IGNORE_LAST,					 
					 searchPassIsFuzzy and AddressID = CN.AddressTypeEnum.GIID => CN.DISPLAY_INPUTMATCHCODE_ADDRESS_GIID_ROBUST_OR_INSTRING,
					 searchPassIsFuzzy and AddressID = CN.AddressTypeEnum.CURRENT => CN.DISPLAY_INPUTMATCHCODE_ADDRESS_CURRENT_ROBUST_OR_INSTRING,
					 searchPassIsFuzzy and AddressID = CN.AddressTypeEnum.PREVIOUS => CN.DISPLAY_INPUTMATCHCODE_ADDRESS_PREVIOUS_ROBUST_OR_INSTRING,																			
					 searchPassViaAddress and AddressID = CN.AddressTypeEnum.GIID => CN.DISPLAY_INPUTMATCHCODE_ADDRESS_GIID, 
					 searchPassViaAddress and AddressID = CN.AddressTypeEnum.CURRENT => CN.DISPLAY_INPUTMATCHCODE_ADDRESS_CURRENT,							   
					 searchPassViaAddress and AddressID = CN.AddressTypeEnum.PREVIOUS => CN.DISPLAY_INPUTMATCHCODE_ADDRESS_PREVIOUS,
					 searchPassDerived => CN.DISPLAY_INPUTMATCHCODE_ADDRESS_DERIVED,
					 CN.DISPLAY_INPUTMATCHCODE_ADDRESS_ERROR);
	END;
	
	EXPORT fn_IsValidCandidateForSearchPass ( boolean			MatchesSSN,
																					  boolean			MatchesSSN4,
																						boolean			MatchesYOB,
																						boolean			MatchesYOBMOB,
																						boolean			MatchesYOBMOBDOB,
																						boolean			MatchesFirstName,																		
																						boolean			MatchesLastName,
																						boolean			MatchesFirstNameFuzzy,
																						boolean			MatchesLastNameFuzzy,
																						boolean			MatchesFirstLastNameFuzzy_Age4,
																						boolean			MatchesFirstLastNameFuzzy_Age6,
																						boolean			MatchesFirstLastInstring,
																						boolean 		MatchesZipCode,
																						boolean			MatchesStreetNameExact,
																						boolean			MatchesHouseNumberExact,
																						boolean			MatchesStreetNameFirst4,
																						boolean			MatchesHouseNumberFirst3,
																						CN.SortSearchPassEnum searchPass,
																						CN.SortSearchPassEnum sourceNameSort) := FUNCTION
																		
		RETURN
				/* PRIMARY and NAMEFLIP_PRIMARY don't include YYYY as a minimum because
						we can get derived SSNs without a DOB match
				*/
				IF ( 	sourceNameSort = CN.SortSourceEnum.UNK, 
							false,
							MAP ( searchPass = CN.SortSearchPassEnum.INPUT_SSN => MatchesYOB and MatchesFirstName and MatchesLastName and MatchesSSN,
										searchPass = CN.SortSearchPassEnum.PRIMARY => MatchesFirstName and MatchesLastName and MatchesZipCode and MatchesStreetNameFirst4 and MatchesHouseNumberFirst3,
										searchPass = CN.SortSearchPassEnum.INPUT_SSN_IGNORE_LAST =>  MatchesYOBMOBDOB and MatchesFirstName and MatchesSSN,				
										searchPass = CN.SortSearchPassEnum.DERIVED => MatchesYOB and MatchesFirstName and MatchesLastName and MatchesSSN,
										searchPass = CN.SortSearchPassEnum.NAMEFLIP_PRIMARY => MatchesFirstName and MatchesLastName and MatchesZipCode and MatchesStreetNameFirst4 and MatchesHouseNumberFirst3,
										searchPass = CN.SortSearchPassEnum.NAMEFLIP_DERIVED => MatchesYOB and MatchesFirstName and MatchesLastName and MatchesSSN,
										searchPass = CN.SortSearchPassEnum.FIRSTINITIAL => MatchesYOB and MatchesFirstName and MatchesLastName and MatchesZipCode and MatchesStreetNameFirst4 and MatchesHouseNumberFirst3,
										searchPass = CN.SortSearchPassEnum.FUZZY1_F => MatchesYOB and MatchesFirstNameFuzzy and MatchesLastName and MatchesZipCode and MatchesStreetNameExact and MatchesHouseNumberExact,
										searchPass = CN.SortSearchPassEnum.FUZZY1_L => MatchesYOB and MatchesFirstName and MatchesLastNameFuzzy and MatchesZipCode and MatchesStreetNameExact and MatchesHouseNumberExact,
										searchPass = CN.SortSearchPassEnum.FUZZY1_LF => ((MatchesYOB and MatchesFirstLastNameFuzzy_Age6) or (MatchesYOBMOB and MatchesFirstLastNameFuzzy_Age4)) and MatchesZipCode and MatchesStreetNameExact and MatchesHouseNumberExact,
										searchPass = CN.SortSearchPassEnum.FUZZY2_F => MatchesYOB and MatchesFirstNameFuzzy and MatchesLastName and MatchesZipCode and MatchesStreetNameExact and MatchesHouseNumberExact,
										searchPass = CN.SortSearchPassEnum.FUZZY2_L => MatchesYOB and MatchesFirstName and MatchesLastNameFuzzy and MatchesZipCode and MatchesStreetNameExact and MatchesHouseNumberExact,
										searchPass = CN.SortSearchPassEnum.FUZZY2_LF => ((MatchesYOB and MatchesFirstLastNameFuzzy_Age6) or (MatchesYOBMOB and MatchesFirstLastNameFuzzy_Age4)) and MatchesZipCode and MatchesStreetNameExact and MatchesHouseNumberExact,
										searchPass = CN.SortSearchPassEnum.FUZZYX_LF => MatchesYOB and MatchesFirstName and MatchesLastName and MatchesZipCode and MatchesStreetNameExact and MatchesHouseNumberExact,
										searchPass = CN.SortSearchPassEnum.FUZZY_INSTRING => MatchesYOB and MatchesFirstLastInstring and MatchesZipCode and MatchesStreetNameExact and MatchesHouseNumberExact,
										searchPass = CN.SortSearchPassEnum.IGNOREHOUSENUMBER => MatchesYOB and MatchesFirstName and MatchesLastName and MatchesZipCode and MatchesStreetNameFirst4,
										searchPass = CN.SortSearchPassEnum.DERIVED_IGNORE_LAST =>  MatchesYOBMOBDOB and MatchesFirstName and MatchesSSN,
										searchPass = CN.SortSearchPassEnum.SSN4EXPANSION => MatchesFirstName and MatchesLastName and MatchesZipCode and MatchesSSN4 and (MatchesStreetNameFirst4 or MatchesYOBMOBDOB),
										false
									));
	END;
	
	EXPORT fn_GetBestSearchPassFuzzy (boolean			MatchesYOB,
																		boolean			MatchesYOBMOB,
																		boolean			MatchesYOBMOBDOB,
																		boolean			MatchesFirstName,																		
																		boolean			MatchesLastName,
																		boolean			MatchesFirstNameFuzzy,
																		boolean			MatchesLastNameFuzzy,
																		boolean			MatchesFirstLastNameFuzzy_Age4,
																		boolean			MatchesFirstLastNameFuzzy_Age6,
																		boolean			MatchesFirstLastInstring,
																		boolean 		MatchesZipCode,
																		boolean			MatchesStreetNameExact,
																		boolean			MatchesHouseNumberExact) := FUNCTION
		RETURN
			MAP(MatchesYOB and MatchesFirstName and MatchesLastName and MatchesZipCode and MatchesStreetNameExact and MatchesHouseNumberExact => CN.SortSearchPassEnum.FUZZYX_LF,
					MatchesYOB and MatchesFirstNameFuzzy and MatchesLastName and MatchesZipCode and MatchesStreetNameExact and MatchesHouseNumberExact => CN.SortSearchPassEnum.FUZZY1_F,
					MatchesYOB and MatchesFirstNameFuzzy and MatchesLastName and MatchesZipCode and MatchesStreetNameExact and MatchesHouseNumberExact => CN.SortSearchPassEnum.FUZZY2_F,
					MatchesYOB and MatchesFirstName and MatchesLastNameFuzzy and MatchesZipCode and MatchesStreetNameExact and MatchesHouseNumberExact => CN.SortSearchPassEnum.FUZZY1_L,
					MatchesYOB and MatchesFirstName and MatchesLastNameFuzzy and MatchesZipCode and MatchesStreetNameExact and MatchesHouseNumberExact => CN.SortSearchPassEnum.FUZZY2_L,
					((MatchesYOB and MatchesFirstLastNameFuzzy_Age6) or (MatchesYOBMOB and MatchesFirstLastNameFuzzy_Age4)) and MatchesZipCode and MatchesStreetNameExact and MatchesHouseNumberExact => CN.SortSearchPassEnum.FUZZY1_LF,
					((MatchesYOB and MatchesFirstLastNameFuzzy_Age6) or (MatchesYOBMOB and MatchesFirstLastNameFuzzy_Age4)) and MatchesZipCode and MatchesStreetNameExact and MatchesHouseNumberExact => CN.SortSearchPassEnum.FUZZY2_LF,					
					MatchesYOB and MatchesFirstLastInstring and MatchesZipCode and MatchesStreetNameExact and MatchesHouseNumberExact => CN.SortSearchPassEnum.FUZZY_INSTRING,
					CN.SortSearchPassEnum.MISS );
					
	END;
						
	EXPORT fn_GetAgeVerified (boolean allSearchPassDataMatched, CN.SortAgeMatchTypeEnum AgeMatchType,  QSTring2 UnderAge, boolean IsPrimaryHit, CN.SortSearchPassEnum sourceNameSort ) := FUNCTION
		isGoodAgeMatchType := AgeMatchType in [CN.SortAgeMatchTypeEnum.YYYY, CN.SortAgeMatchTypeEnum.YYYYMM, CN.SortAgeMatchTypeEnum.YYYYMMDD];
		
		RETURN 
					MAP( sourceNameSort <> CN.SortSourceEnum.UNK and allSearchPassDataMatched and isGoodAgeMatchType and UnderAge = CN.DISPLAY_NO => true, 
							 sourceNameSort <> CN.SortSourceEnum.UNK and allSearchPassDataMatched and isGoodAgeMatchType and UnderAge = CN.DISPLAY_YES and IsPrimaryHit => true, 
							 false);
	END;
	
	EXPORT fn_IsPrimaryHit ( QSTRING2 DisplaySourceName ) := 
				IF( DisplaySourceName in [CN.DISPLAY_SOURCENAME_ORIGINALDATA_CERTEGY,
																 CN.DISPLAY_SOURCENAME_ORIGINALDATA_EXPERIAN_GW,
																 CN.DISPLAY_SOURCENAME_ORIGINALDATA_UTILITY,
																 CN.DISPLAY_SOURCENAME_ORIGINALDATA_CLUE,
																 CN.DISPLAY_SOURCENAME_ORIGINALDATA_CHDR,
																 CN.DISPLAY_SOURCENAME_ORIGINALDATA_VOTR,
																 CN.DISPLAY_SOURCENAME_ORIGINALDATA_MVR,
																 CN.DISPLAY_SOURCENAME_ORIGINALDATA_DMV], true,							   						 
						 false);		
						 
	EXPORT LT.Search.FullRecordNormWithHeaderData
		fn_ApplyRestrictions (UNSIGNED1 DPPA_Purpose, 
															 UNSIGNED1 GLB_Purpose, 
															 DATASET(LT.Search.FullRecordNormWithHeaderData) rawRecords,
															 boolean skipRestrictionsCallCompletely = false,
															 boolean probation_override_value = false,
															 string6 ssn_mask_value = 'NONE',															 
															 string5 industry_class_value = '',
															 boolean maskSSN = false) := FUNCTION												
		
		// Get missing permissions from global module
		mod_access := MODULE (doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule ()))
		  EXPORT unsigned1 glb := glb_purpose;
			EXPORT unsigned1 dppa := dppa_purpose;
			EXPORT boolean probation_override := probation_override_value;
			EXPORT string5 industry_class := industry_class_value;
			EXPORT boolean no_scrub := probation_override_value; 
			EXPORT string ssn_mask := ssn_mask_value;
		END; 
		dppa_ok := mod_access.isValidDPPA();
		glb_ok := mod_access.isValidGLB();
		//for testing purposes (batch mode only), i need to test with the inclusion
		//of certain datasets that alghough not yet live, can be used (experian, tu)
		//the only way for that option to be open if the macro is invoked is to 
		//set no_scrub (above) to true
			
		header.MAC_GlbClean_Header(rawRecords, cleanRecs, , , mod_access);
		suppress.MAC_Mask(cleanRecs, masked, ssn, blank, true, false, , , , mod_access.ssn_mask);

		cleanedMasked := if(maskSSN, masked, cleanRecs);	
		cleanedMaskedInputLayout := project (cleanedMasked, LT.Search.FullRecordNormWithHeaderData);
		
		outputSet := if (skipRestrictionsCallCompletely, rawRecords, cleanedMaskedInputLayout);
		
		return outputSet;

	END;

	EXPORT string1 fn_gongMatchType(LTB.processRec L, LBO.Layout_Final_Output R) := FUNCTION
		// First Name Match = first name or alias or first initial
		boolean matchFirst       := L.Name_First[1]=R.Name_First[1] or NID.mod_PFirstTools.RinPFL(R.Name_First,L.preferredFirst);
		boolean matchExactLast   := L.Name_Last=R.Name_Last;
		// Full Address Match = street number and street name
		boolean isPoBox := fn_IsPoBox(L.Prim_Name) and fn_IsPoBox(R.Prim_Name);
		boolean isRRTyp := fn_RRType(L.Prim_Name) and fn_RRType(R.Prim_Name);
		boolean matchFullAddress := (L.Prim_Range=R.Prim_Range and L.Prim_Name=R.Prim_Name)
			or ((isPoBox or isRRTyp) and L.Prim_Name=R.Prim_Name);
		boolean matchCityZip     := L.City=R.p_City_Name or L.Zip5=R.Z5;
		boolean matchState       := L.State=R.St;
		boolean matchPhone       := L.PhoneNo=R.Phone10;
		string1 matchType := map(
			matchFirst and matchExactLast and matchFullAddress and matchCityZip and matchState => '1',
			matchFirst and matchExactLast and matchFullAddress and matchCityZip and matchState and matchPhone => '2',
			matchExactLast and matchFullAddress and matchCityZip and matchState => '3',
			matchExactLast and matchFullAddress and matchCityZip and matchState and matchPhone => '4',
			matchFirst and matchExactLast and matchFullAddress and matchState => '5',
			matchFirst and matchExactLast and matchFullAddress and matchState and matchPhone => '6',
			matchExactLast and matchFullAddress and matchState => '7',
			matchExactLast and matchFullAddress and matchState and matchPhone => '8',
			'N');
		return matchType;
	END;

	EXPORT string1 fn_bestAddrMatchType(LTB.processRec L, LTB.bestAddrRec R) := FUNCTION
		// First Name Match = first name or alias or first initial
		boolean matchFirst       := L.Name_First[1]=R.Name_First[1] or NID.mod_PFirstTools.RinPFL(R.Name_First, L.preferredFirst);
		boolean matchExactFirst  := L.Name_First=R.Name_First;
		boolean matchExactLast   := L.Name_Last=R.Name_Last;
		// Partial Address Match = (a) first 3 numbers of street number and (b) first 4 letters of street name
		boolean isPoBox := fn_IsPoBox(L.Prim_Name) and fn_IsPoBox(R.Prim_Name);
		boolean isRRTyp := fn_RRType(L.Prim_Name) and fn_RRType(R.Prim_Name);
		boolean matchPartialAddr := (L.Prim_Range[1..3]=R.Prim_Range[1..3] and L.Prim_Name[1..4]=R.Prim_Name[1..4])
			or ((isPoBox or isRRTyp) and L.Prim_Name=R.Prim_Name);
		boolean matchZip         := L.Zip5=R.Z5;
		boolean matchPhone10     := length(trim(L.PhoneNo))=10 and L.PhoneNo=R.Phone10;
		boolean matchDOB4        := length(trim(L.DOB))>=4 and L.DOB[1..4]=R.DOB[1..4];
		boolean matchDOB8        := length(trim(L.DOB))=8 and L.DOB=R.DOB;
		string1 matchType := map(
			matchFirst and matchExactLast and matchPartialAddr and matchZip and matchDOB4 => 'A',
			(matchExactFirst or matchExactLast) and matchPartialAddr and matchZip and matchDOB8 => 'B',
			matchExactFirst and matchExactLast and matchPhone10 and matchDOB8 => 'C',
			'N');
		return matchType;
	END;
	
	// function return dobs in the input dataset for the sources that are found in the key.
	EXPORT getHeaderSourceDob(dataset(Layouts.Search.FullRecordNormWithHeaderData) dirty_header_records) := FUNCTION
	
		dob_records := JOIN (dirty_header_records, doxie.Key_TUCH_dob,
											KEYED(LEFT.rid = right.rid) 
											and	LEFT.src = RIGHT.src,
											TRANSFORM (Layouts.Search.FullRecordNormWithHeaderData,
												SELF.DOB := IF(RIGHT.SRC != '', RIGHT.DOB, LEFT.DOB),
												SELF := LEFT), LEFT OUTER,
										LIMIT(CN.MAX_NUM_RECORDS_PER_DID, SKIP)
												);
		RETURN dob_records;
	END;
	
END;
