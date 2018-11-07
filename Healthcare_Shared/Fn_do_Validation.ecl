import iesp,ut,Business_Header,Business_Header_SS,Risk_Indicators,doxie,suppress,enclarity,
	Healthcare_Shared,STD,dx_BestRecords;

export Fn_do_Validation := Module
		shared currentDate := (string)ut.GetDate;
		EXPORT checkCurrentLicense(iesp.share.t_Date inputValue) := FUNCTION
			licDate:= iesp.ECL2ESP.t_DateToString8(inputValue);
			RETURN licDate>=currentDate;
		END;
		shared layout_nameCheck := record
			string20 		acctno := '';
			unsigned6 	lnpid:=0;
			STRING9 		ssn := '';
			string1			FName := '';
			string20		LName := '';
			string1			FlipFName := '';
			string20		FlipLName := '';
			string1			FName2 := '';
			string20		LName2 := '';
			string1			FlipFName2 := '';
			string20		FlipLName2 := '';
			string1			FName3 := '';
			string20		LName3 := '';
			string1			FlipFName3 := '';
			string20		FlipLName3 := '';
		end;
		export SetDefaults(dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) inRecs) := Function 
			results := project(inRecs, transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
									self.VerificationInfo := project(left,transform(Healthcare_Shared.Layouts.Verifications,
																							self.acctno := left.acctno;
																							self.lnpid:=left.lnpid;
																							self.VerificationConfiguration := '';
																							self.VerificationConfigurationStatus := '';
																							self.NPISuppliedExists := left.VerificationInfo[1].NPISuppliedExists;
																							self.NPISuppliedExistsAuth := left.VerificationInfo[1].NPISuppliedExistsAuth;
																							self.NPIFlags := left.VerificationInfo[1].NPIFlags;
																							self.DEASuppliedExists := left.VerificationInfo[1].DEASuppliedExists;
																							self.DEASuppliedExistsAuth := left.VerificationInfo[1].DEASuppliedExistsAuth;
																							self.DEAFlags := left.VerificationInfo[1].DEAFlags;
																							self.DEA2SuppliedExists := left.VerificationInfo[1].DEA2SuppliedExists;
																							self.DEA2SuppliedExistsAuth := left.VerificationInfo[1].DEA2SuppliedExistsAuth;
																							self.DEA2Flags := left.VerificationInfo[1].DEA2Flags;
																							self.UPINSuppliedExists := left.VerificationInfo[1].UPINSuppliedExists;
																							self.UPINSuppliedExistsAuth := left.VerificationInfo[1].UPINSuppliedExistsAuth;
																							self.UPINFlags := left.VerificationInfo[1].UPINFlags;
																							self.License1SuppliedExists := left.VerificationInfo[1].License1SuppliedExists;
																							self.License1SuppliedExistsAuth := left.VerificationInfo[1].License1SuppliedExistsAuth;
																							self.License1Flags := left.VerificationInfo[1].License1Flags;
																							self.CLIASuppliedExists := left.VerificationInfo[1].CLIASuppliedExists;
																							self.CLIASuppliedExistsAuth := left.VerificationInfo[1].CLIASuppliedExistsAuth;
																							self.CLIAFlags := left.VerificationInfo[1].CLIAFlags;
																							self.NCPDPSuppliedExists := left.VerificationInfo[1].NCPDPSuppliedExists;
																							self.NCPDPSuppliedExistsAuth := left.VerificationInfo[1].NCPDPSuppliedExistsAuth;
																							self.NCPDPFlags := left.VerificationInfo[1].NCPDPFlags;
																							self :=[]));
									self:=left;));
			return results;
		end;
		export NameVerified(dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) inRecs) := Function 
			results := project(inRecs, transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
									src := left.userinput;
									hasLast := Healthcare_Shared.Functions.cleanWord(src.name_last) <> '';
									nameMatch := project(left.names, transform(Healthcare_Shared.Layouts.Verifications, 
																self.NameVerified := if((Healthcare_Shared.Functions.cleanWord(left.FirstName) = Healthcare_Shared.Functions.cleanWord(src.name_first) and 
																Healthcare_Shared.Functions.cleanWord(left.LastName) = Healthcare_Shared.Functions.cleanWord(src.name_last)),true,skip)));
									Verif := project(left.VerificationInfo, transform(Healthcare_Shared.Layouts.Verifications,
																self.NameVerified := hasLast and exists(nameMatch);
																self := left;));
									self.VerificationInfo := Verif;
									self:=left;));
			return results;
		end;
		export CompanyNamesVerified(dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) inRecs) := Function 
			results := project(inRecs, transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
									src := left.userinput;
									hasFull := Healthcare_Shared.Functions.cleanBusinessWord(src.comp_name) <> '';
									recs := project(left.names, transform(Healthcare_Shared.Layouts.Verifications, self.CompanyNameVerified := 
														IF (ut.CompanySimilar100 (Healthcare_Shared.Functions.cleanBusinessWord(Healthcare_Shared.Functions.getCleanHealthCareName(STD.Str.ToUpperCase(left.CompanyName))), Healthcare_Shared.Functions.cleanBusinessWord(Healthcare_Shared.Functions.getCleanHealthCareName(STD.Str.ToUpperCase(src.comp_name))),true) < 60,true,skip)));
									recs2 := project(left.names, transform(Healthcare_Shared.Layouts.Verifications, self.CompanyNameVerified := 
														if (Healthcare_Shared.Functions.CompareBusinessNameConfidence(STD.Str.ToUpperCase(left.CompanyName),STD.Str.ToUpperCase(src.comp_name)) > Healthcare_Shared.Constants.BUS_NAME_BIPMATCH_THRESHOLD,true,skip)));
									Verif := project(left.VerificationInfo, transform(Healthcare_Shared.Layouts.Verifications,
																self.CompanyNameVerified := hasFull and (exists(recs) or exists(recs2));
																self := left;));
									self.VerificationInfo := Verif;
									self:=left;));
			return results;
		end;
		export AddressVerified(dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) inRecs) := Function 
			results := project(inRecs, transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
									src := left.userinput;
									hasPrimRange := Healthcare_Shared.Functions.cleanWord(src.prim_range) <>'';
									hasPrimName := Healthcare_Shared.Functions.cleanWord(src.prim_name) <>'';
									hasCity := Healthcare_Shared.Functions.cleanWord(src.p_city_name) <>'';
									hasInputAddrtoVerify := (hasPrimRange and hasPrimName) or (hasPrimName and hasCity);
									input_range := Healthcare_Shared.Functions.cleanWord(src.prim_range);
									input_name := Healthcare_Shared.Functions.cleanWord(src.prim_name);
									recs := project(left.Addresses, transform(Healthcare_Shared.Layouts.Verifications, self.AddressVerified := 
														if((Healthcare_Shared.Functions.cleanWord(left.prim_range) = input_range and 
																Healthcare_Shared.Functions.cleanWord(left.prim_name) = input_name) or  
																(Healthcare_Shared.Functions.cleanWord(left.prim_range) = input_name and 
																Healthcare_Shared.Functions.cleanWord(left.p_city_name) = Healthcare_Shared.Functions.cleanWord(src.p_city_name)),true,skip)));
									Verif := project(left.VerificationInfo, transform(Healthcare_Shared.Layouts.Verifications,
																self.AddressVerified := hasInputAddrtoVerify and exists(recs);
																self := left;));
									self.VerificationInfo := Verif;
									self:=left;));
			return results;
		end;
		export PhoneVerified(dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) inRecs) := Function 
			results := project(inRecs, transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
									src := left.userinput;
									hasPhone := src.homephone <> '';
									recs := project(left.Phones, transform(Healthcare_Shared.Layouts.Verifications, self.PhoneVerified := 
														if(Healthcare_Shared.Functions.cleanWord(left.phone) = Healthcare_Shared.Functions.cleanWord(src.homephone) and Healthcare_Shared.Functions.cleanWord(left.Phone) <> '',true,skip)));
									Verif := project(left.VerificationInfo, transform(Healthcare_Shared.Layouts.Verifications,
																self.PhoneVerified := hasPhone and exists(recs);
																self := left;));
									self.VerificationInfo := Verif;
									self:=left;));
			return results;
		end;
		export SSNVerified(dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) inRecs) := Function 
			SSNSupplied := inRecs(userinput.ssn <> '' and length(trim(userinput.ssn,all))=9 and userinput.name_first <> '' and userinput.name_last <> '');
			//Collect all Names for matching later
			nameRecs := dedup(sort(normalize(SSNSupplied, left.names,Transform(layout_nameCheck, 
																			self.acctno := left.acctno;
																			self.lnpid := left.lnpid;
																			closeEnough := (STD.Str.ToUpperCase(right.FirstName[1..2]) = STD.Str.ToUpperCase(left.userinput.name_first[1..2]) and right.LastName[1..4] = STD.Str.ToUpperCase(left.userinput.name_last[1..4])) or 
																										 (STD.Str.ToUpperCase(right.LastName[1..2]) = STD.Str.ToUpperCase(left.userinput.name_first[1..2]) and right.FirstName[1..4] = STD.Str.ToUpperCase(left.userinput.name_last[1..4]));
																			self.ssn := if(closeEnough,left.userinput.SSN,skip),
																			self.FName := STD.Str.ToUpperCase(right.FirstName[1..2]); 
																			self.LName:=STD.Str.ToUpperCase(right.LastName);
																			self.FlipFName := STD.Str.ToUpperCase(right.LastName[1..2]); 
																			self.FlipLName:=STD.Str.ToUpperCase(right.FirstName);self:=left;self:=[];)),record),record);
			// output(nameRecs,named('NameRecs'));
			//Check Doxie SSN for anything matching the user supplied information and if the first name is close keep it
			checkDidFromSSN := dedup(sort(Join(SSNSupplied,Doxie.Key_Header_SSN,
																	keyed(right.s1=left.userinput.ssn[1]) and keyed(right.s2=left.userinput.ssn[2]) and
																	keyed(right.s3=left.userinput.ssn[3]) and keyed(right.s4=left.userinput.ssn[4]) and
																	keyed(right.s5=left.userinput.ssn[5]) and keyed(right.s6=left.userinput.ssn[6]) and
																	keyed(right.s7=left.userinput.ssn[7]) and keyed(right.s8=left.userinput.ssn[8]) and
																	keyed(right.s9=left.userinput.ssn[9]),
																	Transform(Healthcare_Shared.Layouts.layout_lookup_DID, 
																			keepRec := ut.NameMatch100(right.pfname,'','',STD.Str.ToUpperCase(left.userinput.name_first),'','')>80;
																			self.acctno := if(keepRec,left.acctno,skip); self.lnpid := left.lnpid; self.did:= right.did;self.name_first := left.userinput.name_first, self.name_last := left.userinput.name_last;),
																	keep(50), limit(0)),record),record);
			// output(checkDidFromSSN,named('checkDidFromSSN'));
			//Check the SSN against the watchdog file to get the full name and see if it is close to what the user supplied if so get the watch dog name and compare it to the real names collected
			bestRecs := dx_BestRecords.append(checkDidFromSSN, did, dx_BestRecords.Constants.perm_type.glb, left_outer := false);
			bestInfo:=project(bestRecs(((_best.fname[1..2]=STD.Str.ToUpperCase(name_first[1..2]) and _best.lname = STD.Str.ToUpperCase(name_last)) or 
																	(_best.fname[1..2]=STD.Str.ToUpperCase(name_last[1..2]) and _best.lname = STD.Str.ToUpperCase(name_first)))),
																	Transform(Healthcare_Shared.Layouts.layout_lookup_DID, 
																			self.acctno := left.acctno; 
																			self.lnpid := left.lnpid; 
																			self.did:= (integer)left._best.ssn;
																			self.name_first := left._best.fname, 
																			self.name_last := left._best.lname));
			// output(bestInfo,named('bestInfo'));
			//Compare the best Info to the Names we are about to return to see if it matches any of the variations
			bestInfo_match := Join(BestInfo,nameRecs, left.acctno=right.acctno and left.lnpid=right.lnpid and left.did=(integer)right.ssn,
																transform(Healthcare_Shared.Layouts.layout_lookup_DID,
																	self.did := if(ut.NameMatch100(left.name_first[1..2],'',left.name_last,right.FName,'',right.LName)>80 or
																					 ut.NameMatch100(left.name_first[1..2],'',left.name_last,right.FName,'',right.LName)>80 or
																					 ut.NameMatch100(left.name_first[1..2],'',left.name_last,right.FName,'',right.LName)>80 or
																					 ut.NameMatch100(left.name_first[1..2],'',left.name_last,right.FlipFName,'',right.FlipLName)>80 or
																					 ut.NameMatch100(left.name_first[1..2],'',left.name_last,right.FlipFName,'',right.FlipLName)>80 or
																					 ut.NameMatch100(left.name_first[1..2],'',left.name_last,right.FlipFName,'',right.FlipLName)>80,
																			left.did,skip);self:=left),
																Keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0));
			// output(bestInfo_match,named('bestInfo_match'));
			//Collect SSN based on User Input that appear to match based on the name
			// ds_ssn_match:=join(Risk_Indicators.Key_SSN_Table_v4_2,nameRecs, keyed(left.ssn=right.ssn),
												// Transform(Healthcare_Shared.Layouts.layout_lookup_DID,
														// self.did := if(ut.NameMatch100(left.combo.lname1.fname[1..2],'',left.combo.lname1.lname,right.FName,'',right.LName)>80 or
																					 // ut.NameMatch100(left.combo.lname2.fname[1..2],'',left.combo.lname2.lname,right.FName,'',right.LName)>80 or
																					 // ut.NameMatch100(left.combo.lname3.fname[1..2],'',left.combo.lname3.lname,right.FName,'',right.LName)>80 or
																					 // ut.NameMatch100(left.combo.lname1.fname[1..2],'',left.combo.lname1.lname,right.FlipFName,'',right.FlipLName)>80 or
																					 // ut.NameMatch100(left.combo.lname2.fname[1..2],'',left.combo.lname2.lname,right.FlipFName,'',right.FlipLName)>80 or
																					 // ut.NameMatch100(left.combo.lname3.fname[1..2],'',left.combo.lname3.lname,right.FlipFName,'',right.FlipLName)>80,
														// (integer)left.ssn,skip);
														// self := right),keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0));
			ds_ssn_matchname:=join(SSNSupplied,Risk_Indicators.Key_SSN_Table_v4_2, keyed(right.ssn=left.userinput.ssn),
												Transform(layout_nameCheck,
														self.acctno := left.acctno;
														self.ssn := right.SSN,
														self.FName := right.combo.lname1.fname[1..2]; 
														self.LName := right.combo.lname1.lname;
														self.FlipFName := right.combo.lname1.lname[1..2]; 
														self.FlipLName:= right.combo.lname1.fname;
														self.FName2 := right.combo.lname2.fname[1..2]; 
														self.LName2 := right.combo.lname2.lname;
														self.FlipFName2 := right.combo.lname2.lname[1..2]; 
														self.FlipLName2:= right.combo.lname2.fname;
														self.FName3 := right.combo.lname3.fname[1..2]; 
														self.LName3 := right.combo.lname3.lname;
														self.FlipFName3 := right.combo.lname3.lname[1..2]; 
														self.FlipLName3:= right.combo.lname3.fname;self:=right),keep(10), limit(0));
			ds_ssn_match:=join(ds_ssn_matchname,nameRecs,left.acctno=right.acctno and left.ssn=right.ssn,
												Transform(Healthcare_Shared.Layouts.layout_lookup_DID,
														self.did := if(ut.NameMatch100(left.Fname,'',left.LName,right.FName,'',right.LName)>80 or
																					 ut.NameMatch100(left.Fname2,'',left.LName2,right.FName,'',right.LName)>80 or
																					 ut.NameMatch100(left.Fname3,'',left.LName3,right.FName,'',right.LName)>80 or
																					 ut.NameMatch100(left.Fname,'',left.LName,right.FlipFName,'',right.FlipLName)>80 or
																					 ut.NameMatch100(left.Fname2,'',left.LName,right.FlipFName2,'',right.FlipLName)>80 or
																					 ut.NameMatch100(left.Fname3,'',left.LName,right.FlipFName3,'',right.FlipLName)>80,
														(integer)left.ssn,skip);
														self := right),keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0));
			// output(ds_ssn_match,named('ds_ssn_match'));
			dsMatches := dedup(sort(ds_ssn_match+bestInfo_match,acctno,lnpid,did),acctno,lnpid,did);
			results := project(inRecs, transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
										src := left.userinput;
										hasSSN := src.SSN <> '' and length(trim(src.SSN,all))=9;
										deepdiveSSNMatch := left.src = Healthcare_Shared.Constants.SRC_BOCA_PERSON_HEADER and hasSSN and exists(left.ssns(ssn=src.SSN));
										recs := project(left.ssnlookups, transform(Healthcare_Shared.Layouts.Verifications, self.SSNVerified := if(Healthcare_Shared.Functions.cleanWord(left.ssn) = Healthcare_Shared.Functions.cleanWord(src.SSN) and Healthcare_Shared.Functions.cleanWord(left.ssn) <> '',true,skip)));
										recs2 := project(left.ssns, transform(Healthcare_Shared.Layouts.Verifications, self.SSNVerified := if(Healthcare_Shared.Functions.cleanWord(left.ssn) = Healthcare_Shared.Functions.cleanWord(src.SSN) and Healthcare_Shared.Functions.cleanWord(left.ssn) <> '',true,skip)));
										recs3 := dsMatches(acctno=left.acctno and lnpid=left.lnpid);
										Verif := project(left.VerificationInfo, transform(Healthcare_Shared.Layouts.Verifications,
																self.SSNVerified := hasSSN and (exists(recs) or exists(recs2) or exists(recs3) or deepdiveSSNMatch);
																self := left;));
									self.VerificationInfo := Verif;
									self:=left;));
			// output(SSNSupplied);
			// output(nameRecs);
			// output(checkDidFromSSN);
			// output(bestInfo);
			// output(bestInfo_match);
			// output(ds_ssn_match);
			// output(dsMatches);
			// output(results,named('SSNVerifiedResults'));
			return results;
		end;
		Export feinlookup1(dataset(Healthcare_Shared.Layouts.feinLookup) ds) := function
			return join(ds,Business_Header.RoxieKeys().NewFetch.Key_FEIN_QA,keyed(left.bit1=right.f1) and keyed(left.bit2=right.f2) and keyed(left.bit3=right.f3) and
																																			keyed(left.bit4=right.f4) and keyed(left.bit5=right.f5) and keyed(left.bit6=right.f6) and
																																			keyed(left.bit7=right.f7) and keyed(left.bit8=right.f8) and keyed(left.bit9=right.f9),
																																			transform(Healthcare_Shared.Layouts.feinLookupResults, self.acctno := left.acctno; self.lnpid := left.lnpid; self.CompanyName := right.cname;self:=[];),
																																			keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN),limit(0));
		end;
		Export feinlookup2(dataset(Healthcare_Shared.Layouts.feinLookup) ds) := function
			return join(ds,Business_Header_SS.Key_BH_FEIN,keyed(left.fein=right.fein),
																											transform(Healthcare_Shared.Layouts.feinLookupResults, self.acctno := left.acctno; self.lnpid := left.lnpid; self.CompanyName := right.Company_Name;self:=[];),
																											keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN),limit(0));
		end;
		Export feinlookup3(dataset(Healthcare_Shared.Layouts.feinLookup) ds) := function
			hits:= join(ds,enclarity.Keys(,Healthcare_Shared.Constants.mprd_Keys_useProd).associate_bill_tin.qa,keyed((string)left.fein=right.bill_tin),
																											transform(Healthcare_Shared.Layouts.feinLookupResults, self.acctno := left.acctno; self.lnpid := left.lnpid; self.group_key:= right.billing_group_key;self:=[];),
																											keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN),limit(0));
			results := join(hits(group_key <> ''),Enclarity.Keys(,Healthcare_Shared.Constants.mprd_Keys_useProd).facility_group_key.qa,keyed(left.group_key=right.group_key),
																											transform(Healthcare_Shared.Layouts.feinLookupResults, self.acctno := left.acctno; self.lnpid := left.lnpid; self.CompanyName := right.prac_company_name;self:=[];),
																											keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN),limit(0));
			results2 := join(hits(group_key <> ''),Enclarity.Keys(,Healthcare_Shared.Constants.mprd_Keys_useProd).facility_group_key.qa,keyed(left.group_key=right.group_key),
																											transform(Healthcare_Shared.Layouts.feinLookupResults, self.acctno := left.acctno; self.lnpid := left.lnpid; self.CompanyName := right.clean_company_name;self:=[];),
																											keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN),limit(0));
			return results+results2;
		end;
		export FEINVerified(dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) inRecs) := Function 
			//Process TaxIDs
			taxidFmt := dedup(sort(normalize(inRecs, left.taxids,Transform(Healthcare_Shared.Layouts.feinLookup, 
																			self.acctno := left.acctno;
																			self.lnpid := left.lnpid;
																			val2CheckFmt := (string)INTFORMAT((integer)right.taxid,9,1);
																			self.fein:=(integer)val2CheckFmt; self.bit1:=val2CheckFmt[1]; 
																			self.bit2:=val2CheckFmt[2]; self.bit3:=val2CheckFmt[3]; 
																			self.bit4:=val2CheckFmt[4]; self.bit5:=val2CheckFmt[5]; 
																			self.bit6:=val2CheckFmt[6]; self.bit7:=val2CheckFmt[7]; 
																			self.bit8:=val2CheckFmt[8]; self.bit9:=val2CheckFmt[9];)),record),record);
			userInput := project(inRecs,transform(Healthcare_Shared.Layouts.feinLookup,
																			self.acctno := left.acctno;
																			self.lnpid := left.lnpid;
																			val2CheckFmt := (string)INTFORMAT((integer)left.userinput.taxid,9,1);
																			self.fein:=(integer)val2CheckFmt; self.bit1:=val2CheckFmt[1]; 
																			self.bit2:=val2CheckFmt[2]; self.bit3:=val2CheckFmt[3]; 
																			self.bit4:=val2CheckFmt[4]; self.bit5:=val2CheckFmt[5]; 
																			self.bit6:=val2CheckFmt[6]; self.bit7:=val2CheckFmt[7]; 
																			self.bit8:=val2CheckFmt[8]; self.bit9:=val2CheckFmt[9];));
			//Process Feins
			feinFmt := dedup(sort(normalize(inRecs, left.feins,Transform(Healthcare_Shared.Layouts.feinLookup, 
																			self.acctno := left.acctno;
																			self.lnpid := left.lnpid;
																			val2CheckFmt := (string)INTFORMAT((integer)right.fein,9,1);
																			self.fein:=(integer)val2CheckFmt; self.bit1:=val2CheckFmt[1]; 
																			self.bit2:=val2CheckFmt[2]; self.bit3:=val2CheckFmt[3]; 
																			self.bit4:=val2CheckFmt[4]; self.bit5:=val2CheckFmt[5]; 
																			self.bit6:=val2CheckFmt[6]; self.bit7:=val2CheckFmt[7]; 
																			self.bit8:=val2CheckFmt[8]; self.bit9:=val2CheckFmt[9];)),record),record);
			userInput2 := project(inRecs,transform(Healthcare_Shared.Layouts.feinLookup,
																			self.acctno := left.acctno;
																			self.lnpid := left.lnpid;
																			val2CheckFmt := (string)INTFORMAT((integer)left.userinput.fein,9,1);
																			self.fein:=(integer)val2CheckFmt; self.bit1:=val2CheckFmt[1]; 
																			self.bit2:=val2CheckFmt[2]; self.bit3:=val2CheckFmt[3]; 
																			self.bit4:=val2CheckFmt[4]; self.bit5:=val2CheckFmt[5]; 
																			self.bit6:=val2CheckFmt[6]; self.bit7:=val2CheckFmt[7]; 
																			self.bit8:=val2CheckFmt[8]; self.bit9:=val2CheckFmt[9];));
			// Merge
			// ds := feinFmt+taxidFmt+userInput+userInput2;
			ds := (userInput+userInput2)(fein>0);
			lookup1 := feinlookup1(ds(fein>0));
			lookup2 := feinlookup2(ds(fein>0));
			lookup3 := feinlookup3(ds(fein>0));
			CNamesInput := project(inRecs(userinput.comp_name <> ''),transform(Healthcare_Shared.Layouts.feinLookupResults,
																			self.acctno := left.acctno;
																			self.lnpid := left.lnpid;
																			self.CompanyName := STD.Str.ToUpperCase(left.userinput.comp_name);self:=[]));
			CNamesResults := dedup(sort(normalize(inRecs, left.Names,Transform(Healthcare_Shared.Layouts.feinLookupResults,
																			self.acctno := left.acctno;
																			self.lnpid := left.lnpid;
																			self.CompanyName := STD.Str.ToUpperCase(right.CompanyName);self:=[])),record),record);
			CNamesResultsNPI1 := dedup(sort(normalize(inRecs, left.NPIRaw,Transform(Healthcare_Shared.Layouts.feinLookupResults,
																			self.acctno := left.acctno;
																			self.lnpid := left.lnpid;
																			self.CompanyName := right.EntityInformation.CompanyName;self:=[])),record),record);
			CNamesResultsNPI2 := dedup(sort(normalize(inRecs, left.NPIRaw,Transform(Healthcare_Shared.Layouts.feinLookupResults,
																			self.acctno := left.acctno;
																			self.lnpid := left.lnpid;
																			self.CompanyName := right.EntityInformation.CompanyNameAKA;self:=[])),record),record);
			//Cleaned Company Names from Results
			ResultsCompanyNamesCleaned := dedup(project(CNamesInput+CNamesResults+CNamesResultsNPI1+CNamesResultsNPI2,transform(Healthcare_Shared.Layouts.feinLookupResults,self.CompanyName:=Healthcare_Shared.Functions.getCleanHealthCareName(left.CompanyName);self:=left;self:=[];))(CompanyName<>''),all);
			//Cleaned Company Names from lookup1
			lookup1Cleaned := dedup(sort(project(lookup1,transform(Healthcare_Shared.Layouts.feinLookupResults,self.CompanyName:=Healthcare_Shared.Functions.getCleanHealthCareName(left.CompanyName);self:=left;self:=[];)),record),record);
			//Cleaned Company Names from lookup2
			lookup2Cleaned := dedup(sort(project(lookup2,transform(Healthcare_Shared.Layouts.feinLookupResults,self.CompanyName:=Healthcare_Shared.Functions.getCleanHealthCareName(left.CompanyName);self:=left;self:=[];)),record),record);
			//Cleaned Company Names from lookup3
			lookup3Cleaned := dedup(sort(project(lookup3,transform(Healthcare_Shared.Layouts.feinLookupResults,self.CompanyName:=Healthcare_Shared.Functions.getCleanHealthCareName(left.CompanyName);self:=left;self:=[];)),record),record);
			lookMatch1 := join(lookup1Cleaned(CompanyName<>''),ResultsCompanyNamesCleaned(CompanyName<>''),
																					left.acctno = right.acctno and left.lnpid=right.lnpid,transform(Healthcare_Shared.Layouts.Verifications, 
																								closematch := ut.CompanySimilar100(Healthcare_Shared.Functions.getCleanHealthCareName(left.CompanyName),Healthcare_Shared.Functions.getCleanHealthCareName(right.CompanyName));
																								self.FEINVerified := if(closematch<=Healthcare_Shared.Constants.BUS_NAME_MATCH_THRESHOLD,true,skip);self:=left;),keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0));
			lookMatch2 := join(lookup2Cleaned(CompanyName<>''),ResultsCompanyNamesCleaned(CompanyName<>''),
																					left.acctno = right.acctno and left.lnpid=right.lnpid,transform(Healthcare_Shared.Layouts.Verifications, 
																								closematch := ut.CompanySimilar100(Healthcare_Shared.Functions.getCleanHealthCareName(left.CompanyName),Healthcare_Shared.Functions.getCleanHealthCareName(right.CompanyName));
																								self.FEINVerified := if(closematch<=Healthcare_Shared.Constants.BUS_NAME_MATCH_THRESHOLD,true,skip);self:=left;),keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0));
			lookMatch3 := join(lookup3Cleaned(CompanyName<>''),ResultsCompanyNamesCleaned(CompanyName<>''),
																					left.acctno = right.acctno and left.lnpid=right.lnpid,transform(Healthcare_Shared.Layouts.Verifications, 
																								closematch := ut.CompanySimilar100(Healthcare_Shared.Functions.getCleanHealthCareName(left.CompanyName),Healthcare_Shared.Functions.getCleanHealthCareName(right.CompanyName));
																								self.FEINVerified := if(closematch<=Healthcare_Shared.Constants.BUS_NAME_MATCH_THRESHOLD,true,skip);self:=left;),keep(Healthcare_Shared.Constants.MAX_RECS_ON_JOIN), limit(0));
			dsMatches := lookMatch1+lookMatch2+lookMatch3;
			results := project(inRecs, transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
										src := left.userinput;
										hasTIN := src.taxid <> '';
										hasFEIN := src.FEIN <> '';
										hasInputValuetoVerify := hasTIN or hasFEIN;
										recs := project(left.feins, transform(Healthcare_Shared.Layouts.Verifications, self.FEINVerified := if((Healthcare_Shared.Functions.cleanWord(left.fein) = Healthcare_Shared.Functions.cleanWord(src.FEIN) or Healthcare_Shared.Functions.cleanWord(left.fein) = Healthcare_Shared.Functions.cleanWord(src.taxid)) and Healthcare_Shared.Functions.cleanWord(left.fein) <> '',true,skip)));
										recs2 := project(left.taxids, transform(Healthcare_Shared.Layouts.Verifications, self.FEINVerified := if((Healthcare_Shared.Functions.cleanWord(left.taxid) = Healthcare_Shared.Functions.cleanWord(src.taxid) or Healthcare_Shared.Functions.cleanWord(left.taxid) = Healthcare_Shared.Functions.cleanWord(src.fein)) and Healthcare_Shared.Functions.cleanWord(left.taxid) <> '',true,skip)));
										recs3 := dsMatches(acctno=left.acctno and lnpid=left.lnpid);
										Verif := project(left.VerificationInfo, transform(Healthcare_Shared.Layouts.Verifications,
																self.FEINVerified := hasInputValuetoVerify and 
																										(exists(recs) or exists(recs2) or exists(recs3));
																self := left;));
									self.VerificationInfo := Verif;
									self:=left;));
			// output(feinFmt,named('feinFmt'));
			// output(taxidFmt,named('taxidFmt'));
			// output(userInput,named('userInput'));
			// output(userInput2,named('userInput2'));
			// output(ds,named('ds'));
			// output(lookup1,named('lookup1'));
			// output(lookup2,named('lookup2'));
			// output(lookup3,named('lookup3'));
			// output(CNamesInput,named('CNamesInput'));
			// output(CNamesResults,named('CNamesResults'));
			// output(CNamesResultsNPI1,named('CNamesResultsNPI1'));
			// output(CNamesResultsNPI2,named('CNamesResultsNPI2'));
			// output(ResultsCompanyNamesCleaned,named('ResultsCompanyNamesCleaned'));
			// output(lookup1Cleaned,named('lookup1Cleaned'));
			// output(lookup2Cleaned,named('lookup2Cleaned'));
			// output(lookup3Cleaned,named('lookup3Cleaned'));
			// output(lookMatch1,named('lookMatch1'));
			// output(lookMatch2,named('lookMatch2'));
			// output(lookMatch3,named('lookMatch3'));
			// output(dsMatches,named('dsMatches'));
			return results;
		end;
		Export FEINExists(dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) inRecs) := Function 
			userInput := project(inRecs,transform(Healthcare_Shared.Layouts.feinLookup,
																			self.acctno := left.acctno;
																			self.lnpid := left.lnpid;
																			val2CheckFmt := (string)INTFORMAT((integer)left.userinput.taxid,9,1);
																			self.fein:=(integer)val2CheckFmt; self.bit1:=val2CheckFmt[1]; 
																			self.bit2:=val2CheckFmt[2]; self.bit3:=val2CheckFmt[3]; 
																			self.bit4:=val2CheckFmt[4]; self.bit5:=val2CheckFmt[5]; 
																			self.bit6:=val2CheckFmt[6]; self.bit7:=val2CheckFmt[7]; 
																			self.bit8:=val2CheckFmt[8]; self.bit9:=val2CheckFmt[9];));
			userInput2 := project(inRecs,transform(Healthcare_Shared.Layouts.feinLookup,
																			self.acctno := left.acctno;
																			self.lnpid := left.lnpid;
																			val2CheckFmt := (string)INTFORMAT((integer)left.userinput.fein,9,1);
																			self.fein:=(integer)val2CheckFmt; self.bit1:=val2CheckFmt[1]; 
																			self.bit2:=val2CheckFmt[2]; self.bit3:=val2CheckFmt[3]; 
																			self.bit4:=val2CheckFmt[4]; self.bit5:=val2CheckFmt[5]; 
																			self.bit6:=val2CheckFmt[6]; self.bit7:=val2CheckFmt[7]; 
																			self.bit8:=val2CheckFmt[8]; self.bit9:=val2CheckFmt[9];));
			// Merge
			ds := userInput+userInput2;
			lookup1 := feinlookup1(ds(fein>0));
			lookup2 := feinlookup2(ds(fein>0));
			lookup3 := feinlookup3(ds(fein>0));
			dsMatches := lookup1+lookup2+lookup3;
			results := project(inRecs, transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
										src := left.userinput;
										hasTIN := src.taxid <> '';
										hasFEIN := src.FEIN <> '';
										hasInputValuetoVerify := hasTIN or hasFEIN;
										recs := project(left.feins, transform(Healthcare_Shared.Layouts.Verifications, self.FEINSuppliedExists := if((Healthcare_Shared.Functions.cleanWord(left.fein) = Healthcare_Shared.Functions.cleanWord(src.FEIN) or Healthcare_Shared.Functions.cleanWord(left.fein) = Healthcare_Shared.Functions.cleanWord(src.taxid)) and Healthcare_Shared.Functions.cleanWord(left.fein) <> '',true,skip)));
										recs2 := project(left.taxids, transform(Healthcare_Shared.Layouts.Verifications, self.FEINSuppliedExists := if((Healthcare_Shared.Functions.cleanWord(left.taxid) = Healthcare_Shared.Functions.cleanWord(src.taxid) or Healthcare_Shared.Functions.cleanWord(left.taxid) = Healthcare_Shared.Functions.cleanWord(src.fein)) and Healthcare_Shared.Functions.cleanWord(left.taxid) <> '',true,skip)));
										recs3 := dsMatches(acctno=left.acctno and lnpid=left.lnpid);
										Verif := project(left.VerificationInfo, transform(Healthcare_Shared.Layouts.Verifications,
																self.FEINSuppliedExists := hasInputValuetoVerify and 
																										(exists(recs) or exists(recs2) or exists(recs3));
																self := left;));
									self.VerificationInfo := Verif;
									self:=left;));
			return results;
		end;
		Export MedSchoolVerified(dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) inRecs) := Function
			results := project(inRecs, transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
										src := left.userinput;
										hasInput := src.MedicalSchoolNameVerification <> '';
										recs := project(left.MedSchools, transform(Healthcare_Shared.Layouts.Verifications, self.MedicalSchoolNameVerified := if(BridgerScoreLib.companyScore(left.MedSchoolName,src.MedicalSchoolNameVerification)>.80,true,skip)));
										Verif := project(left.VerificationInfo, transform(Healthcare_Shared.Layouts.Verifications,
																self.MedicalSchoolNameVerified := hasInput and exists(recs);
																self := left;));
									self.VerificationInfo := Verif;
									self:=left;));
			return results;
		End;
		Export GradYearVerified(dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) inRecs) := Function
			results := project(inRecs, transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
										src := left.userinput;
										hasInput := src.GraduationYearVerification > 0;
										recs := project(left.MedSchools, transform(Healthcare_Shared.Layouts.Verifications, self.GraduationYearVerified := if(src.GraduationYearVerification=(integer)left.GraduationYear and (integer)left.GraduationYear <> 0,true,skip)));
										Verif := project(left.VerificationInfo, transform(Healthcare_Shared.Layouts.Verifications,
																self.GraduationYearVerified := hasInput and exists(recs);
																self := left;));
									self.VerificationInfo := Verif;
									self:=left;));
			return results;
		End;
		export CLIAValid(dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) inRecs) := Function
			results := project(inRecs, transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
										src := left.userinput;
										hasInput := src.CLIANumber <> '';
										recs := project(left.CLIARaw(RecordType='C'), transform(Healthcare_Shared.Layouts.Verifications, 
															self.CLIAValid := if(Healthcare_Shared.Functions.cleanWord(left.CLIANumber) = Healthcare_Shared.Functions.cleanWord(src.CLIANumber) and 
																										Healthcare_Shared.Functions.cleanWord(left.CLIANumber) <> '' and 
																										checkCurrentLicense(left.ExpirationDate) and 
																										(trim(left.TerminationCode,all) = '' or trim(left.TerminationCode,all) = '00'),true,skip)));
										Verif := project(left.VerificationInfo, transform(Healthcare_Shared.Layouts.Verifications,
																self.CLIAValid := hasInput and exists(recs);
																self := left;));
									self.VerificationInfo := Verif;
									self:=left;));
			return results;
		end;
		export CLIAVerified(dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) inRecs) := Function
			results := project(inRecs, transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
										src := left.userinput;
										hasInput := src.CLIANumber <> '';
										recs := project(left.CLIARaw, transform(Healthcare_Shared.Layouts.Verifications, 
															self.CLIAVerified := if(Healthcare_Shared.Functions.cleanWord(left.CLIANumber) = Healthcare_Shared.Functions.cleanWord(src.CLIANumber) and 
															Healthcare_Shared.Functions.cleanWord(left.CLIANumber) <> '',true,skip)));
										Verif := project(left.VerificationInfo, transform(Healthcare_Shared.Layouts.Verifications,
																self.CLIAVerified := hasInput and exists(recs);
																self := left;));
									self.VerificationInfo := Verif;
									self:=left;));
			return results;
		end;
		Export UPINVerified(dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) inRecs) := Function
			results := project(inRecs, transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
										src := left.userinput;
										hasInput := src.upin <> '';
										recs := project(left.upins, transform(Healthcare_Shared.Layouts.Verifications,self.UPINVerified := if(Healthcare_Shared.Functions.cleanWord(left.upin) = Healthcare_Shared.Functions.cleanWord(src.UPIN) and Healthcare_Shared.Functions.cleanWord(left.upin) <> '',true,skip)));
										Verif := project(left.VerificationInfo, transform(Healthcare_Shared.Layouts.Verifications,
																self.UPINVerified := hasInput and exists(recs);
																self := left;));
									self.VerificationInfo := Verif;
									self:=left;));
			return results;
		End;
		Export NPIValid(dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) inRecs) := Function
			results := project(inRecs, transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
										src := left.userinput;
										hasInput := src.npi <> '';
										recs := project(left.NPIRaw, transform(Healthcare_Shared.Layouts.Verifications, self.NPIValid := 
															if(Healthcare_Shared.Functions.cleanWord(left.NPIInformation.NPINumber) = Healthcare_Shared.Functions.cleanWord(src.NPI) and 
																Healthcare_Shared.Functions.cleanWord(left.NPIInformation.NPINumber) <> '' and 
																(length(trim(iesp.ECL2ESP.t_DateToString8(left.NPIInformation.DeactivationDate),all))=0 or 
																 length(trim(iesp.ECL2ESP.t_DateToString8(left.NPIInformation.ReactivationDate),all))>0),
																true,skip)));
										Verif := project(left.VerificationInfo, transform(Healthcare_Shared.Layouts.Verifications,
																self.NPIValid := hasInput and exists(recs);
																self := left;));
									self.VerificationInfo := Verif;
									self:=left;));
			return results;
		End;
		Export NpiVerified(dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) inRecs) := Function
			results := project(inRecs, transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
										src := left.userinput;
										hasInput := src.npi <> '';
										recs := project(left.npis, transform(Healthcare_Shared.Layouts.Verifications, self.NPIVerified := 
															if(Healthcare_Shared.Functions.cleanWord(left.npi) = Healthcare_Shared.Functions.cleanWord(src.NPI) and 
																	Healthcare_Shared.Functions.cleanWord(left.npi) <> '',true,skip))); 
										recs2 := project(left.NPIRaw, transform(Healthcare_Shared.Layouts.Verifications, self.NPIVerified := 
															if(Healthcare_Shared.Functions.cleanWord(left.NPIInformation.NPINumber) = Healthcare_Shared.Functions.cleanWord(src.NPI) and 
																	Healthcare_Shared.Functions.cleanWord(left.NPIInformation.NPINumber) <> '',true,skip)));
										Verif := project(left.VerificationInfo, transform(Healthcare_Shared.Layouts.Verifications,
																self.NpiVerified := hasInput and (exists(recs) or exists(recs2));
																self := left;));
									self.VerificationInfo := Verif;
									self:=left;));
			return results;
		End;
		export DEAValid(dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) inRecs) := Function
			results := project(inRecs, transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
										src := left.userinput;
										hasInput := src.DEA <> '';
										recs := project(left.deas, transform(Healthcare_Shared.Layouts.Verifications, self.DEAValid := 
															if((Healthcare_Shared.Functions.cleanWord(left.dea_num) = Healthcare_Shared.Functions.cleanWord(src.DEA) or 
																	Healthcare_Shared.Functions.cleanOnlyNumbers(left.dea_num) = Healthcare_Shared.Functions.cleanOnlyNumbers(src.DEA)) and 
																Healthcare_Shared.Functions.cleanWord(left.dea_num) <> '' and 
																trim(left.dea_num_exp,all)>=trim(currentDate,all),true,skip)));
										Verif := project(left.VerificationInfo, transform(Healthcare_Shared.Layouts.Verifications,
																self.DEAValid := hasInput and exists(recs);
																self := left;));
									self.VerificationInfo := Verif;
									self:=left;));
			return results;
		end;
		export DEA2Valid(dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) inRecs) := Function
			results := project(inRecs, transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
										src := left.userinput;
										hasInput := src.DEA2 <> '';
										recs := project(left.deas, transform(Healthcare_Shared.Layouts.Verifications, self.DEA2Valid := 
															if((Healthcare_Shared.Functions.cleanWord(left.dea_num) = Healthcare_Shared.Functions.cleanWord(src.DEA2) or 
																	Healthcare_Shared.Functions.cleanOnlyNumbers(left.dea_num) = Healthcare_Shared.Functions.cleanOnlyNumbers(src.DEA2)) and 
																Healthcare_Shared.Functions.cleanWord(left.dea_num) <> '' and 
																trim(left.dea_num_exp,all)>=trim(currentDate,all),true,skip)));
										Verif := project(left.VerificationInfo, transform(Healthcare_Shared.Layouts.Verifications,
																self.DEA2Valid := hasInput and exists(recs);
																self := left;));
									self.VerificationInfo := Verif;
									self:=left;));
			return results;
		end;
		export DEAVerified(dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) inRecs) := Function
			results := project(inRecs, transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
										src := left.userinput;
										hasInput := src.DEA <> '';
										recs := project(left.deas, transform(Healthcare_Shared.Layouts.Verifications, self.DEAVerified := 
															if((Healthcare_Shared.Functions.cleanWord(left.dea_num) = Healthcare_Shared.Functions.cleanWord(src.DEA) or 
																	Healthcare_Shared.Functions.cleanOnlyNumbers(left.dea_num) = Healthcare_Shared.Functions.cleanOnlyNumbers(src.DEA)) and 
															Healthcare_Shared.Functions.cleanWord(left.dea_num) <> '',true,skip)));
										Verif := project(left.VerificationInfo, transform(Healthcare_Shared.Layouts.Verifications,
																self.DEAVerified := hasInput and exists(recs);
																self := left;));
									self.VerificationInfo := Verif;
									self:=left;));
			return results;
		end;
		export DEA2Verified(dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) inRecs) := Function
			results := project(inRecs, transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
										src := left.userinput;
										hasInput := src.DEA2 <> '';
										recs := project(left.deas, transform(Healthcare_Shared.Layouts.Verifications, self.DEA2Verified := 
															if((Healthcare_Shared.Functions.cleanWord(left.dea_num) = Healthcare_Shared.Functions.cleanWord(src.DEA2) or 
																	Healthcare_Shared.Functions.cleanOnlyNumbers(left.dea_num) = Healthcare_Shared.Functions.cleanOnlyNumbers(src.DEA2)) and 
															Healthcare_Shared.Functions.cleanWord(left.dea_num) <> '',true,skip)));
										Verif := project(left.VerificationInfo, transform(Healthcare_Shared.Layouts.Verifications,
																self.DEA2Verified := hasInput and exists(recs);
																self := left;));
									self.VerificationInfo := Verif;
									self:=left;));
			return results;
		end;
		export NCPDPNumberVerified(dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) inRecs) := Function
			results := project(inRecs, transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
										src := left.userinput;
										hasInput := src.NCPDPNumber <> '';
										recs := project(left.NCPDPRaw, transform(Healthcare_Shared.Layouts.Verifications, self.NCPDPNumberVerified := 
															if((integer)Healthcare_Shared.Functions.cleanWord(left.EntityInformation.PharmacyProviderId) = 
																 (integer)Healthcare_Shared.Functions.cleanWord(src.NCPDPNumber) and 
																Healthcare_Shared.Functions.cleanWord(left.EntityInformation.PharmacyProviderId) <> '',true,skip)));
										recs2 := project(left.ncpdps, transform(Healthcare_Shared.Layouts.Verifications, self.NCPDPNumberVerified := 
															if((integer)Healthcare_Shared.Functions.cleanWord(left.ncpdp_id) = 
																 (integer)Healthcare_Shared.Functions.cleanWord(src.NCPDPNumber) and 
																Healthcare_Shared.Functions.cleanWord(left.ncpdp_id) <> '',true,skip)));
										Verif := project(left.VerificationInfo, transform(Healthcare_Shared.Layouts.Verifications,
																self.NCPDPNumberVerified := hasInput and (exists(recs) or exists(recs2));
																self := left;));
									self.VerificationInfo := Verif;
									self:=left;));
			return results;
		end;
		shared isLicenseMatch(dataset(Healthcare_Shared.Layouts.layout_LicenseValidation) results, string srcLic, String srcLicState) := Function 
			hasLicense := srcLic <> '';
			hasLicenseState := srcLicState <> '';
			recsRaw := project(sort(results,-TerminationDate), transform(Healthcare_Shared.Layouts.Verifications, 
																						isLicMatch := trim(left.cleanLicenseNum,all) = trim(Healthcare_Shared.Functions.cleanWord(srcLic),all) or left.cleanIntLicenseNum = (integer)Healthcare_Shared.Functions.cleanOnlyNumbers(srcLic);
																						isStateMatch := trim(left.cleanLicenseState,all) = trim(Healthcare_Shared.Functions.cleanWord(srcLicState),all);
																						self.License1ResultMatch := if(isLicMatch and if(srcLicState <> '',isStateMatch,true), (string)left.licenseSeq,skip);
																						self := left));
			return if(hasLicense,recsRaw[1].License1ResultMatch,'');
		end;
		shared isCustomerLicenseValid(dataset(Healthcare_Shared.Layouts.layout_LicenseValidation) results, string srcLic, String srcLicState) := Function 
			hasLicense := srcLic <> '';
			hasLicenseState := srcLicState <> '';//Supplied
			recsRaw := project(results, transform(Healthcare_Shared.Layouts.layout_LicenseValidation, 
																												self.LicenseValid := trim(left.cleanLicenseNum,all) = trim(Healthcare_Shared.Functions.cleanWord(srcLic)) or left.cleanIntLicenseNum = (integer)Healthcare_Shared.Functions.cleanOnlyNumbers(srcLic);
																												self.LicenseStateValid := trim(left.cleanLicenseState,all) = trim(Healthcare_Shared.Functions.cleanWord(srcLicState),all);
																												self := left));
			recs := recsRaw(LicenseValid and TerminationDateValid and if(hasLicenseState,LicenseStateValid,true));
			return hasLicense and exists(recs);
		end;
		shared isCustomerLicenseVerified(dataset(Healthcare_Shared.Layouts.layout_LicenseValidation) results, string srcLic, String srcLicState) := Function 
			hasLicense := srcLic <> '';
			hasLicenseState := srcLicState <> '';//Supplied
			recsRaw := project(results, transform(Healthcare_Shared.Layouts.layout_LicenseValidation, 
																												self.LicenseValid := trim(left.cleanLicenseNum,all) = trim(Healthcare_Shared.Functions.cleanWord(srcLic),all) or left.cleanIntLicenseNum = (integer)Healthcare_Shared.Functions.cleanOnlyNumbers(srcLic);
																												self.LicenseStateValid := trim(left.cleanLicenseState,all) = trim(Healthcare_Shared.Functions.cleanWord(srcLicState),all);
																												self := left));
			recs := recsRaw(LicenseValid and if(hasLicenseState,LicenseStateValid,true));
			return hasLicense and exists(recs);
		end;
		export LicenseValid(dataset(Healthcare_Shared.Layouts.layout_LicenseValidation) results, string srcLic, String srcLicState) := Function 
			hasLicense := srcLic <> '';
			hasLicenseState := srcLicState <> '';
			recsRaw := project(results, transform(Healthcare_Shared.Layouts.layout_LicenseValidation, 
																												self.LicenseValid := trim(left.cleanLicenseNum,all) = trim(Healthcare_Shared.Functions.cleanWord(srcLic)) or left.cleanIntLicenseNum = (integer)Healthcare_Shared.Functions.cleanOnlyNumbers(srcLic);
																												self.LicenseStateValid := trim(left.cleanLicenseState,all) = trim(Healthcare_Shared.Functions.cleanWord(srcLicState),all);
																												self := left));
			recs := recsRaw(LicenseValid and TerminationDateValid and if(hasLicenseState,LicenseStateValid,true));
			return hasLicense and exists(recs);
		end;
		export LicenseVerified(dataset(Healthcare_Shared.Layouts.layout_LicenseValidation) results, string srcLic, String srcLicState) := Function 
			hasLicense := srcLic <> '';
			hasLicenseState := srcLicState <> '';
			hasLicensetoVerify := hasLicense and hasLicenseState;
			recsRaw := project(results, transform(Healthcare_Shared.Layouts.layout_LicenseValidation, 
																												self.LicenseValid := trim(left.cleanLicenseNum,all) = trim(Healthcare_Shared.Functions.cleanWord(srcLic),all) or left.cleanIntLicenseNum = (integer)Healthcare_Shared.Functions.cleanOnlyNumbers(srcLic);
																												self.LicenseStateValid := trim(left.cleanLicenseState,all) = trim(Healthcare_Shared.Functions.cleanWord(srcLicState),all);
																												self := left));
			recs := recsRaw(LicenseValid and if(hasLicenseState,LicenseStateValid,true));
			return hasLicense and exists(recs);
		end;
		export StateLicenseFlags(dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) inRecs, string25 CustomerID) := Function
			licRecs1 := dedup(sort(normalize(inRecs, left.StateLicenses,Transform(Healthcare_Shared.Layouts.layout_LicenseValidation, 
																			self.acctno := left.acctno;
																			self.internalID := left.internalID;
																			self.licenseSeq := right.licenseSeq;
																			self.origLicenseState := right.LicenseState;
																			self.cleanLicenseState := Healthcare_Shared.Functions.cleanWord(right.LicenseState);
																			self.origLicenseNum := right.LicenseNumber;
																			self.cleanLicenseNum := Healthcare_Shared.Functions.cleanWord(right.LicenseNumber);
																			self.cleanIntLicenseNum := (integer)Healthcare_Shared.Functions.cleanOnlyNumbers(right.LicenseNumber);
																			self.LicenseValid := false;
																			self.LicenseStateValid := false;
																			self.TerminationDate := right.Termination_Date;
																			self.TerminationDateValid := trim(right.Termination_Date,all)>=trim(currentDate,all);)),record),record);
			licRecs2 := dedup(sort(normalize(inRecs, left.StateLicenses,Transform(Healthcare_Shared.Layouts.layout_LicenseValidation, 
																			self.acctno := left.acctno;
																			self.internalID := left.internalID;
																			self.licenseSeq := right.licenseSeq;
																			self.origLicenseState := right.LicenseState;
																			self.cleanLicenseState := Healthcare_Shared.Functions.cleanWord(right.LicenseState);
																			self.origLicenseNum := if(right.LicenseType<>'',trim(right.LicenseType,left,right)+'.','');
																			self.cleanLicenseNum := Healthcare_Shared.Functions.cleanWord(if(right.LicenseType<>'',trim(right.LicenseType,left,right)+'.',''));
																			self.cleanIntLicenseNum := (integer)Healthcare_Shared.Functions.cleanOnlyNumbers(if(right.LicenseType<>'',trim(right.LicenseType,left,right)+'.',''));
																			self.LicenseValid := false;
																			self.LicenseStateValid := false;
																			self.TerminationDate := right.Termination_Date;
																			self.TerminationDateValid := trim(right.Termination_Date,all)>=trim(currentDate,all))),record),record);
			licRecsRaw := licRecs1+licRecs2;
			customerlicRecsRaw := dedup(sort(normalize(inRecs, left.customerLicense,Transform(Healthcare_Shared.Layouts.layout_LicenseValidation, 
																			stateDefault := map(trim(CustomerID,left,right) = '1535116' => 'MI',
																												trim(CustomerID,left,right) = '1594356' => 'IL','');
																			self.acctno := left.acctno;
																			self.internalID := left.internalID;
																			self.licenseSeq := 0;
																			self.origLicenseState := stateDefault;
																			self.cleanLicenseState := stateDefault;
																			self.origLicenseNum := right.LicenseNumber;
																			self.cleanLicenseNum := Healthcare_Shared.Functions.cleanWord(right.LicenseNumber);
																			self.cleanIntLicenseNum := (integer)Healthcare_Shared.Functions.cleanOnlyNumbers(right.LicenseNumber);
																			self.LicenseValid := false;
																			self.LicenseStateValid := false;
																			self.TerminationDate := iesp.ECL2ESP.t_DateToString8(right.ExpirationDate);
																			self.TerminationDateValid := trim(iesp.ECL2ESP.t_DateToString8(right.ExpirationDate),all)>=trim(currentDate,all))),record),record);
			results := project(inRecs, transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
										src := left.userinput;
										licRecs := licRecsRaw(acctno=left.acctno and internalID=left.internalID);
										customerlicRecs := customerlicRecsRaw(acctno=left.acctno and internalID=left.internalID);
										lvalOrig := isCustomerLicenseValid(customerlicRecs(TerminationDateValid=true),src.license_number,src.license_state) or LicenseValid(licRecs(TerminationDateValid=true),src.license_number,src.license_state);
										lverOrig := isCustomerLicenseVerified(customerlicRecs,src.license_number,src.license_state) or LicenseVerified(licRecs,src.license_number,src.license_state);
										lval1 := isCustomerLicenseValid(customerlicRecs(TerminationDateValid=true),src.StateLicense1Verification,src.StateLicense1StateVerification) or LicenseValid(licRecs(TerminationDateValid=true),src.StateLicense1Verification,src.StateLicense1StateVerification);
										lmatch1 := isLicenseMatch(licRecs,src.StateLicense1Verification,src.StateLicense1StateVerification);
										lver1 := isCustomerLicenseVerified(customerlicRecs,src.StateLicense1Verification,src.StateLicense1StateVerification) or LicenseVerified(licRecs,src.StateLicense1Verification,src.StateLicense1StateVerification);
										lval2 := isCustomerLicenseValid(customerlicRecs(TerminationDateValid=true),src.StateLicense2Verification,src.StateLicense2StateVerification) or LicenseValid(licRecs(TerminationDateValid=true),src.StateLicense2Verification,src.StateLicense2StateVerification);
										lver2 := isCustomerLicenseVerified(customerlicRecs,src.StateLicense2Verification,src.StateLicense2StateVerification) or LicenseVerified(licRecs,src.StateLicense2Verification,src.StateLicense2StateVerification);
										lmatch2 := isLicenseMatch(licRecs,src.StateLicense2Verification,src.StateLicense2StateVerification);
										lval3 := isCustomerLicenseValid(customerlicRecs(TerminationDateValid=true),src.StateLicense3Verification,src.StateLicense3StateVerification) or LicenseValid(licRecs(TerminationDateValid=true),src.StateLicense3Verification,src.StateLicense3StateVerification);
										lver3 := isCustomerLicenseVerified(customerlicRecs,src.StateLicense3Verification,src.StateLicense3StateVerification) or LicenseVerified(licRecs,src.StateLicense3Verification,src.StateLicense3StateVerification);
										lmatch3 := isLicenseMatch(licRecs,src.StateLicense3Verification,src.StateLicense3StateVerification);
										lval4 := isCustomerLicenseValid(customerlicRecs(TerminationDateValid=true),src.StateLicense4Verification,src.StateLicense4StateVerification) or LicenseValid(licRecs(TerminationDateValid=true),src.StateLicense4Verification,src.StateLicense4StateVerification);
										lver4 := isCustomerLicenseVerified(customerlicRecs,src.StateLicense4Verification,src.StateLicense4StateVerification) or LicenseVerified(licRecs,src.StateLicense4Verification,src.StateLicense4StateVerification);
										lmatch4 := isLicenseMatch(licRecs,src.StateLicense4Verification,src.StateLicense4StateVerification);
										lval5 := isCustomerLicenseValid(customerlicRecs(TerminationDateValid=true),src.StateLicense5Verification,src.StateLicense5StateVerification) or LicenseValid(licRecs(TerminationDateValid=true),src.StateLicense5Verification,src.StateLicense5StateVerification);
										lver5 := isCustomerLicenseVerified(customerlicRecs,src.StateLicense5Verification,src.StateLicense5StateVerification) or LicenseVerified(licRecs,src.StateLicense5Verification,src.StateLicense5StateVerification);
										lmatch5 := isLicenseMatch(licRecs,src.StateLicense5Verification,src.StateLicense5StateVerification);
										lval6 := isCustomerLicenseValid(customerlicRecs(TerminationDateValid=true),src.StateLicense6Verification,src.StateLicense6StateVerification) or LicenseValid(licRecs(TerminationDateValid=true),src.StateLicense6Verification,src.StateLicense6StateVerification);
										lver6 := isCustomerLicenseVerified(customerlicRecs,src.StateLicense6Verification,src.StateLicense6StateVerification) or LicenseVerified(licRecs,src.StateLicense6Verification,src.StateLicense6StateVerification);
										lmatch6 := isLicenseMatch(licRecs,src.StateLicense6Verification,src.StateLicense6StateVerification);
										lval7 := isCustomerLicenseValid(customerlicRecs(TerminationDateValid=true),src.StateLicense7Verification,src.StateLicense7StateVerification) or LicenseValid(licRecs(TerminationDateValid=true),src.StateLicense7Verification,src.StateLicense7StateVerification);
										lver7 := isCustomerLicenseVerified(customerlicRecs,src.StateLicense7Verification,src.StateLicense7StateVerification) or LicenseVerified(licRecs,src.StateLicense7Verification,src.StateLicense7StateVerification);
										lmatch7 := isLicenseMatch(licRecs,src.StateLicense7Verification,src.StateLicense7StateVerification);
										lval8 := isCustomerLicenseValid(customerlicRecs(TerminationDateValid=true),src.StateLicense8Verification,src.StateLicense8StateVerification) or LicenseValid(licRecs(TerminationDateValid=true),src.StateLicense8Verification,src.StateLicense8StateVerification);
										lver8 := isCustomerLicenseVerified(customerlicRecs,src.StateLicense8Verification,src.StateLicense8StateVerification) or LicenseVerified(licRecs,src.StateLicense8Verification,src.StateLicense8StateVerification);
										lmatch8 := isLicenseMatch(licRecs,src.StateLicense8Verification,src.StateLicense8StateVerification);
										lval9 := isCustomerLicenseValid(customerlicRecs(TerminationDateValid=true),src.StateLicense9Verification,src.StateLicense9StateVerification) or LicenseValid(licRecs(TerminationDateValid=true),src.StateLicense9Verification,src.StateLicense9StateVerification);
										lver9 := isCustomerLicenseVerified(customerlicRecs,src.StateLicense9Verification,src.StateLicense9StateVerification) or LicenseVerified(licRecs,src.StateLicense9Verification,src.StateLicense9StateVerification);
										lmatch9 := isLicenseMatch(licRecs,src.StateLicense9Verification,src.StateLicense9StateVerification);
										lval10 := isCustomerLicenseValid(customerlicRecs(TerminationDateValid=true),src.StateLicense10Verification,src.StateLicense10StateVerification) or LicenseValid(licRecs(TerminationDateValid=true),src.StateLicense10Verification,src.StateLicense10StateVerification);
										lver10 := isCustomerLicenseVerified(customerlicRecs,src.StateLicense10Verification,src.StateLicense10StateVerification) or LicenseVerified(licRecs,src.StateLicense10Verification,src.StateLicense10StateVerification);
										lmatch10 := isLicenseMatch(licRecs,src.StateLicense10Verification,src.StateLicense10StateVerification);
										Verif := project(left.VerificationInfo, transform(Healthcare_Shared.Layouts.Verifications,
																self.LicenseValid := lvalOrig or lval1 or lval2 or lval3 or lval4 or lval5 or lval6 or lval7 or lval8 or lval9 or lval10;
																self.LicenseVerified := lverOrig or lver1 or lver2 or lver3 or lver4 or lver5 or lver6 or lver7 or lver8 or lver9 or lver10;
																self.License1Valid := lvalOrig or lval1;
																self.License1Verified :=  lverOrig or lver1;
																self.License1ResultMatch := lmatch1;
																// self.License1SuppliedExists := false;
																self.License2Valid := lval2;
																self.License2Verified :=  lver2;
																self.License2ResultMatch := lmatch2;
																self.License3Valid := lval3;
																self.License3Verified := lver3;
																self.License3ResultMatch := lmatch3;
																self.License4Valid := lval4;
																self.License4Verified := lver4;
																self.License4ResultMatch := lmatch4;
																self.License5Valid := lval5;
																self.License5Verified := lver5;
																self.License5ResultMatch := lmatch5;
																self.License6Valid := lval6;
																self.License6Verified := lver6;
																self.License6ResultMatch := lmatch6;
																self.License7Valid := lval7;
																self.License7Verified := lver7;
																self.License7ResultMatch := lmatch7;
																self.License8Valid := lval8;
																self.License8Verified := lver8;
																self.License8ResultMatch := lmatch8;
																self.License9Valid := lval9;
																self.License9Verified := lver9;
																self.License9ResultMatch := lmatch9;
																self.License10Valid := lval10;
																self.License10Verified := lver10;
																self.License10ResultMatch := lmatch10;
																self := left;));
									self.VerificationInfo := Verif;
									self:=left;));
			return results;
		end;
		shared layout_taxonomy := record
			unsigned1	 	rowid := 0;
			string10	 	taxonomycode := '';
		end;
		export TaxonomyExists(dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) inRecs) := Function
			// results := project(inRecs, transform(Healthcare_Shared.Layouts.Verifications,
										// src := left.userinput;
										// ds := dataset([{1,STD.Str.ToUpperCase(src.Taxonomy1Verification)},
																		// {2,STD.Str.ToUpperCase(src.Taxonomy2Verification)},
																		// {3,STD.Str.ToUpperCase(src.Taxonomy3Verification)},
																		// {4,STD.Str.ToUpperCase(src.Taxonomy4Verification)},
																		// {5,STD.Str.ToUpperCase(src.Taxonomy5Verification)}],layout_taxonomy);
										// recs := join(newtable,ds
										
										
										// ,keyed(left.taxonomycode=right.taxonomycode),transform(layout_taxonomy,self:=left),keep(10), limit(0));
										// Verif := project(left.VerificationInfo, transform(Healthcare_Shared.Layouts.Verifications,
																// self.TaxonomyExists := exists(recs);
																// self.Taxonomy1Exists := exists(recs(rowid=1));
																// self.Taxonomy2Exists := exists(recs(rowid=2));
																// self.Taxonomy3Exists := exists(recs(rowid=3));
																// self.Taxonomy4Exists := exists(recs(rowid=4));
																// self.Taxonomy5Exists := exists(recs(rowid=5));
																// self := left;));
									// self.VerificationInfo := Verif;
									// self:=left;));
			// return results;
			return inRecs;
		end;
		export TaxonomyVerified(dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) inRecs) := Function
			results := project(inRecs, transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
										src := left.userinput;
										recs1 := project(left.Taxonomy, transform(Healthcare_Shared.Layouts.Verifications, self.TaxonomyVerified := 
																										if(Healthcare_Shared.Functions.cleanWord(left.TaxonomyCode) = Healthcare_Shared.Functions.cleanWord(src.Taxonomy1Verification) and 
																												Healthcare_Shared.Functions.cleanWord(left.TaxonomyCode) <> '',true,skip)));
										recs2 := project(left.Taxonomy, transform(Healthcare_Shared.Layouts.Verifications, self.TaxonomyVerified := 
																										if(Healthcare_Shared.Functions.cleanWord(left.TaxonomyCode) = Healthcare_Shared.Functions.cleanWord(src.Taxonomy2Verification) and 
																												Healthcare_Shared.Functions.cleanWord(left.TaxonomyCode) <> '',true,skip)));
										recs3 := project(left.Taxonomy, transform(Healthcare_Shared.Layouts.Verifications, self.TaxonomyVerified := 
																										if(Healthcare_Shared.Functions.cleanWord(left.TaxonomyCode) = Healthcare_Shared.Functions.cleanWord(src.Taxonomy3Verification) and 
																												Healthcare_Shared.Functions.cleanWord(left.TaxonomyCode) <> '',true,skip)));
										recs4 := project(left.Taxonomy, transform(Healthcare_Shared.Layouts.Verifications, self.TaxonomyVerified := 
																										if(Healthcare_Shared.Functions.cleanWord(left.TaxonomyCode) = Healthcare_Shared.Functions.cleanWord(src.Taxonomy4Verification) and 
																												Healthcare_Shared.Functions.cleanWord(left.TaxonomyCode) <> '',true,skip)));
										recs5 := project(left.Taxonomy, transform(Healthcare_Shared.Layouts.Verifications, self.TaxonomyVerified := 
																										if(Healthcare_Shared.Functions.cleanWord(left.TaxonomyCode) = Healthcare_Shared.Functions.cleanWord(src.Taxonomy5Verification) and 
																												Healthcare_Shared.Functions.cleanWord(left.TaxonomyCode) <> '',true,skip)));
										nppesRec := NORMALIZE(left.NPIRaw,left.ProviderTaxonomies,transform(Healthcare_Shared.Layouts.layout_taxonomy,
																										self.acctno:='1';self.internalID:=(unsigned6)left.NPIInformation.NPINumber,self.TaxonomyCode:=right.SelectedTaxonomyCode;self.PrimaryIndicator:=right.PrimaryTaxonomy,self:=[]));
										recs6 := project(nppesRec, transform(Healthcare_Shared.Layouts.Verifications, self.TaxonomyVerified := 
																										if(Healthcare_Shared.Functions.cleanWord(left.TaxonomyCode) = Healthcare_Shared.Functions.cleanWord(src.Taxonomy1Verification) and 
																												Healthcare_Shared.Functions.cleanWord(left.TaxonomyCode) <> '',true,skip)));
										recs7 := project(nppesRec, transform(Healthcare_Shared.Layouts.Verifications, self.TaxonomyVerified := 
																										if(Healthcare_Shared.Functions.cleanWord(left.TaxonomyCode) = Healthcare_Shared.Functions.cleanWord(src.Taxonomy2Verification) and 
																												Healthcare_Shared.Functions.cleanWord(left.TaxonomyCode) <> '',true,skip)));
										recs8 := project(nppesRec, transform(Healthcare_Shared.Layouts.Verifications, self.TaxonomyVerified := 
																										if(Healthcare_Shared.Functions.cleanWord(left.TaxonomyCode) = Healthcare_Shared.Functions.cleanWord(src.Taxonomy3Verification) and 
																												Healthcare_Shared.Functions.cleanWord(left.TaxonomyCode) <> '',true,skip)));
										recs9 := project(nppesRec, transform(Healthcare_Shared.Layouts.Verifications, self.TaxonomyVerified := 
																										if(Healthcare_Shared.Functions.cleanWord(left.TaxonomyCode) = Healthcare_Shared.Functions.cleanWord(src.Taxonomy4Verification) and 
																												Healthcare_Shared.Functions.cleanWord(left.TaxonomyCode) <> '',true,skip)));
										recs10 := project(nppesRec, transform(Healthcare_Shared.Layouts.Verifications, self.TaxonomyVerified := 
																										if(Healthcare_Shared.Functions.cleanWord(left.TaxonomyCode) = Healthcare_Shared.Functions.cleanWord(src.Taxonomy5Verification) and 
																												Healthcare_Shared.Functions.cleanWord(left.TaxonomyCode) <> '',true,skip)));
										Verif := project(left.VerificationInfo, transform(Healthcare_Shared.Layouts.Verifications,
																self.TaxonomyVerified := exists(recs1) or exists(recs2) or exists(recs3) or exists(recs4) or exists(recs5) or 
																												exists(recs6) or exists(recs7) or exists(recs8) or exists(recs9) or exists(recs10);
																self.Taxonomy1Verified := exists(recs1) or exists(recs6);
																self.Taxonomy2Verified := exists(recs2) or exists(recs7);
																self.Taxonomy3Verified := exists(recs3) or exists(recs8);
																self.Taxonomy4Verified := exists(recs4) or exists(recs9);
																self.Taxonomy5Verified := exists(recs5) or exists(recs10);
																self := left;));
									self.VerificationInfo := Verif;
									self:=left;));
			return results;
		end;
		export ABMSSpecialtyValid(dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) inRecs) := Function
			results := project(inRecs, transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
										src := left.userinput;
										recs1 := project(left.abmsRaw[1].Certifications(CertificateType <> 'S'), transform(Healthcare_Shared.Layouts.Verifications, self.BoardCertifiedSpecialtyValid := 
																										if(Healthcare_Shared.Functions.cleanWord(left.CertificateName) = Healthcare_Shared.Functions.cleanWord(src.BoardCertifiedSpecialtyVerification) and 
																											 Healthcare_Shared.Functions.cleanWord(left.CertificateName) <> '' and 
																											 (trim(left.DurationType) = 'L' or 
																												trim(left.DurationType) = 'M' or 
																												trim(iesp.ecl2esp.DateToString(left.ExpireDate),all)>=trim(currentDate,all) or 
																												trim(iesp.ecl2esp.DateToString(left.ReverificationDate),all)>=trim(currentDate,all)),true,skip)));
										recs2 := project(left.abmsRaw[1].Certifications(CertificateType <> 'S'), transform(Healthcare_Shared.Layouts.Verifications, self.BoardCertifiedSpecialty2Valid := 
																										if(Healthcare_Shared.Functions.cleanWord(left.CertificateName) = Healthcare_Shared.Functions.cleanWord(src.BoardCertifiedSpecialty2Verification) and 
																											 Healthcare_Shared.Functions.cleanWord(left.CertificateName) <> '' and 
																											 (trim(left.DurationType) = 'L' or 
																												trim(left.DurationType) = 'M' or 
																												trim(iesp.ecl2esp.DateToString(left.ExpireDate),all)>=trim(currentDate,all) or 
																												trim(iesp.ecl2esp.DateToString(left.ReverificationDate),all)>=trim(currentDate,all)),true,skip)));
										recs3 := project(left.abmsRaw[1].Certifications(CertificateType <> 'S'), transform(Healthcare_Shared.Layouts.Verifications, self.BoardCertifiedSpecialty3Valid := 
																										if(Healthcare_Shared.Functions.cleanWord(left.CertificateName) = Healthcare_Shared.Functions.cleanWord(src.BoardCertifiedSpecialty3Verification) and 
																											 Healthcare_Shared.Functions.cleanWord(left.CertificateName) <> '' and 
																											 (trim(left.DurationType) = 'L' or 
																												trim(left.DurationType) = 'M' or 
																												trim(iesp.ecl2esp.DateToString(left.ExpireDate),all)>=trim(currentDate,all) or 
																												trim(iesp.ecl2esp.DateToString(left.ReverificationDate),all)>=trim(currentDate,all)),true,skip)));
										recs4 := project(left.abmsRaw[1].Certifications(CertificateType <> 'S'), transform(Healthcare_Shared.Layouts.Verifications, self.BoardCertifiedSpecialty4Valid := 
																										if(Healthcare_Shared.Functions.cleanWord(left.CertificateName) = Healthcare_Shared.Functions.cleanWord(src.BoardCertifiedSpecialty4Verification) and 
																											 Healthcare_Shared.Functions.cleanWord(left.CertificateName) <> '' and 
																											 (trim(left.DurationType) = 'L' or 
																												trim(left.DurationType) = 'M' or 
																												trim(iesp.ecl2esp.DateToString(left.ExpireDate),all)>=trim(currentDate,all) or 
																												trim(iesp.ecl2esp.DateToString(left.ReverificationDate),all)>=trim(currentDate,all)),true,skip)));
										recs5 := project(left.abmsRaw[1].Certifications(CertificateType <> 'S'), transform(Healthcare_Shared.Layouts.Verifications, self.BoardCertifiedSpecialty5Valid := 
																										if(Healthcare_Shared.Functions.cleanWord(left.CertificateName) = Healthcare_Shared.Functions.cleanWord(src.BoardCertifiedSpecialty5Verification) and 
																											 Healthcare_Shared.Functions.cleanWord(left.CertificateName) <> '' and 
																											 (trim(left.DurationType) = 'L' or 
																												trim(left.DurationType) = 'M' or 
																												trim(iesp.ecl2esp.DateToString(left.ExpireDate),all)>=trim(currentDate,all) or 
																												trim(iesp.ecl2esp.DateToString(left.ReverificationDate),all)>=trim(currentDate,all)),true,skip)));
										Verif := project(left.VerificationInfo, transform(Healthcare_Shared.Layouts.Verifications,
																self.BoardCertifiedSpecialtyValid := exists(recs1) or exists(recs2) or exists(recs3) or exists(recs4) or exists(recs5);
																self.BoardCertifiedSpecialty1Valid := exists(recs1);
																self.BoardCertifiedSpecialty2Valid := exists(recs2);
																self.BoardCertifiedSpecialty3Valid := exists(recs3);
																self.BoardCertifiedSpecialty4Valid := exists(recs4);
																self.BoardCertifiedSpecialty5Valid := exists(recs5);
																self := left;));
									self.VerificationInfo := Verif;
									self:=left;));
			return results;
		end;
		export ABMSSpecialtyVerified(dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) inRecs) := Function
			results := project(inRecs, transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
										src := left.userinput;
										recs1 := project(left.abmsRaw[1].Certifications(CertificateType <> 'S'), transform(Healthcare_Shared.Layouts.Verifications, self.BoardCertifiedSpecialtyVerified := 
																										if(Healthcare_Shared.Functions.cleanWord(left.CertificateName) = Healthcare_Shared.Functions.cleanWord(src.BoardCertifiedSpecialtyVerification) and 
																											 Healthcare_Shared.Functions.cleanWord(left.CertificateName) <> '',true,skip)));
										recs2 := project(left.abmsRaw[1].Certifications(CertificateType <> 'S'), transform(Healthcare_Shared.Layouts.Verifications, self.BoardCertifiedSpecialty2Verified := 
																										if(Healthcare_Shared.Functions.cleanWord(left.CertificateName) = Healthcare_Shared.Functions.cleanWord(src.BoardCertifiedSpecialty2Verification) and 
																											 Healthcare_Shared.Functions.cleanWord(left.CertificateName) <> '',true,skip)));
										recs3 := project(left.abmsRaw[1].Certifications(CertificateType <> 'S'), transform(Healthcare_Shared.Layouts.Verifications, self.BoardCertifiedSpecialty3Verified := 
																										if(Healthcare_Shared.Functions.cleanWord(left.CertificateName) = Healthcare_Shared.Functions.cleanWord(src.BoardCertifiedSpecialty3Verification) and 
																											 Healthcare_Shared.Functions.cleanWord(left.CertificateName) <> '',true,skip)));
										recs4 := project(left.abmsRaw[1].Certifications(CertificateType <> 'S'), transform(Healthcare_Shared.Layouts.Verifications, self.BoardCertifiedSpecialty4Verified := 
																										if(Healthcare_Shared.Functions.cleanWord(left.CertificateName) = Healthcare_Shared.Functions.cleanWord(src.BoardCertifiedSpecialty4Verification) and 
																											 Healthcare_Shared.Functions.cleanWord(left.CertificateName) <> '',true,skip)));
										recs5 := project(left.abmsRaw[1].Certifications(CertificateType <> 'S'), transform(Healthcare_Shared.Layouts.Verifications, self.BoardCertifiedSpecialty5Verified := 
																										if(Healthcare_Shared.Functions.cleanWord(left.CertificateName) = Healthcare_Shared.Functions.cleanWord(src.BoardCertifiedSpecialty5Verification) and 
																											 Healthcare_Shared.Functions.cleanWord(left.CertificateName) <> '',true,skip)));
										Verif := project(left.VerificationInfo, transform(Healthcare_Shared.Layouts.Verifications,
																self.BoardCertifiedSpecialtyVerified := exists(recs1) or exists(recs2) or exists(recs3) or exists(recs4) or exists(recs5);
																self.BoardCertifiedSpecialty1Verified := exists(recs1);
																self.BoardCertifiedSpecialty2Verified := exists(recs2);
																self.BoardCertifiedSpecialty3Verified := exists(recs3);
																self.BoardCertifiedSpecialty4Verified := exists(recs4);
																self.BoardCertifiedSpecialty5Verified := exists(recs5);
																self := left;));
									self.VerificationInfo := Verif;
									self:=left;));
			return results;
		end;
		export ABMSSubSpecialtyValid(dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) inRecs) := Function
			results := project(inRecs, transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
										src := left.userinput;
										recs1 := project(left.abmsRaw[1].Certifications(CertificateType <> 'S'), transform(Healthcare_Shared.Layouts.Verifications, self.BoardCertifiedSpecialtyValid := 
																										if(Healthcare_Shared.Functions.cleanWord(left.CertificateName) = Healthcare_Shared.Functions.cleanWord(src.BoardCertifiedSubSpecialtyVerification) and 
																											 Healthcare_Shared.Functions.cleanWord(left.CertificateName) <> '' and 
																											 (trim(left.DurationType) = 'L' or 
																												trim(left.DurationType) = 'M' or 
																												trim(iesp.ecl2esp.DateToString(left.ExpireDate),all)>=trim(currentDate,all) or 
																												trim(iesp.ecl2esp.DateToString(left.ReverificationDate),all)>=trim(currentDate,all)),true,skip)));
										recs2 := project(left.abmsRaw[1].Certifications(CertificateType <> 'S'), transform(Healthcare_Shared.Layouts.Verifications, self.BoardCertifiedSubSpecialty2Valid := 
																										if(Healthcare_Shared.Functions.cleanWord(left.CertificateName) = Healthcare_Shared.Functions.cleanWord(src.BoardCertifiedSubSpecialty2Verification) and 
																											 Healthcare_Shared.Functions.cleanWord(left.CertificateName) <> '' and 
																											 (trim(left.DurationType) = 'L' or 
																												trim(left.DurationType) = 'M' or 
																												trim(iesp.ecl2esp.DateToString(left.ExpireDate),all)>=trim(currentDate,all) or 
																												trim(iesp.ecl2esp.DateToString(left.ReverificationDate),all)>=trim(currentDate,all)),true,skip)));
										recs3 := project(left.abmsRaw[1].Certifications(CertificateType <> 'S'), transform(Healthcare_Shared.Layouts.Verifications, self.BoardCertifiedSubSpecialty3Valid := 
																										if(Healthcare_Shared.Functions.cleanWord(left.CertificateName) = Healthcare_Shared.Functions.cleanWord(src.BoardCertifiedSubSpecialty3Verification) and 
																											 Healthcare_Shared.Functions.cleanWord(left.CertificateName) <> '' and 
																											 (trim(left.DurationType) = 'L' or 
																												trim(left.DurationType) = 'M' or 
																												trim(iesp.ecl2esp.DateToString(left.ExpireDate),all)>=trim(currentDate,all) or 
																												trim(iesp.ecl2esp.DateToString(left.ReverificationDate),all)>=trim(currentDate,all)),true,skip)));
										recs4 := project(left.abmsRaw[1].Certifications(CertificateType <> 'S'), transform(Healthcare_Shared.Layouts.Verifications, self.BoardCertifiedSubSpecialty4Valid := 
																										if(Healthcare_Shared.Functions.cleanWord(left.CertificateName) = Healthcare_Shared.Functions.cleanWord(src.BoardCertifiedSubSpecialty4Verification) and 
																											 Healthcare_Shared.Functions.cleanWord(left.CertificateName) <> '' and 
																											 (trim(left.DurationType) = 'L' or 
																												trim(left.DurationType) = 'M' or 
																												trim(iesp.ecl2esp.DateToString(left.ExpireDate),all)>=trim(currentDate,all) or 
																												trim(iesp.ecl2esp.DateToString(left.ReverificationDate),all)>=trim(currentDate,all)),true,skip)));
										recs5 := project(left.abmsRaw[1].Certifications(CertificateType <> 'S'), transform(Healthcare_Shared.Layouts.Verifications, self.BoardCertifiedSubSpecialty5Valid := 
																										if(Healthcare_Shared.Functions.cleanWord(left.CertificateName) = Healthcare_Shared.Functions.cleanWord(src.BoardCertifiedSubSpecialty5Verification) and 
																											 Healthcare_Shared.Functions.cleanWord(left.CertificateName) <> '' and 
																											 (trim(left.DurationType) = 'L' or 
																												trim(left.DurationType) = 'M' or 
																												trim(iesp.ecl2esp.DateToString(left.ExpireDate),all)>=trim(currentDate,all) or 
																												trim(iesp.ecl2esp.DateToString(left.ReverificationDate),all)>=trim(currentDate,all)),true,skip)));
										Verif := project(left.VerificationInfo, transform(Healthcare_Shared.Layouts.Verifications,
																self.BoardCertifiedSubSpecialtyValid := exists(recs1) or exists(recs2) or exists(recs3) or exists(recs4) or exists(recs5);
																self.BoardCertifiedSubSpecialty1Valid := exists(recs1);
																self.BoardCertifiedSubSpecialty2Valid := exists(recs2);
																self.BoardCertifiedSubSpecialty3Valid := exists(recs3);
																self.BoardCertifiedSubSpecialty4Valid := exists(recs4);
																self.BoardCertifiedSubSpecialty5Valid := exists(recs5);
																self := left;));
									self.VerificationInfo := Verif;
									self:=left;));
			return results;
		end;
		export ABMSSubSpecialtyVerified(dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) inRecs) := Function
			results := project(inRecs, transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
										src := left.userinput;
										recs1 := project(left.abmsRaw[1].Certifications(CertificateType <> 'S'), transform(Healthcare_Shared.Layouts.Verifications, self.BoardCertifiedSubSpecialtyVerified := 
																										if(Healthcare_Shared.Functions.cleanWord(left.CertificateName) = Healthcare_Shared.Functions.cleanWord(src.BoardCertifiedSubSpecialtyVerification) and 
																											 Healthcare_Shared.Functions.cleanWord(left.CertificateName) <> '',true,skip)));
										recs2 := project(left.abmsRaw[1].Certifications(CertificateType <> 'S'), transform(Healthcare_Shared.Layouts.Verifications, self.BoardCertifiedSubSpecialty2Verified := 
																										if(Healthcare_Shared.Functions.cleanWord(left.CertificateName) = Healthcare_Shared.Functions.cleanWord(src.BoardCertifiedSubSpecialty2Verification) and 
																											 Healthcare_Shared.Functions.cleanWord(left.CertificateName) <> '',true,skip)));
										recs3 := project(left.abmsRaw[1].Certifications(CertificateType <> 'S'), transform(Healthcare_Shared.Layouts.Verifications, self.BoardCertifiedSubSpecialty3Verified := 
																										if(Healthcare_Shared.Functions.cleanWord(left.CertificateName) = Healthcare_Shared.Functions.cleanWord(src.BoardCertifiedSubSpecialty3Verification) and 
																											 Healthcare_Shared.Functions.cleanWord(left.CertificateName) <> '',true,skip)));
										recs4 := project(left.abmsRaw[1].Certifications(CertificateType <> 'S'), transform(Healthcare_Shared.Layouts.Verifications, self.BoardCertifiedSubSpecialty4Verified := 
																										if(Healthcare_Shared.Functions.cleanWord(left.CertificateName) = Healthcare_Shared.Functions.cleanWord(src.BoardCertifiedSubSpecialty4Verification) and 
																											 Healthcare_Shared.Functions.cleanWord(left.CertificateName) <> '',true,skip)));
										recs5 := project(left.abmsRaw[1].Certifications(CertificateType <> 'S'), transform(Healthcare_Shared.Layouts.Verifications, self.BoardCertifiedSubSpecialty5Verified := 
																										if(Healthcare_Shared.Functions.cleanWord(left.CertificateName) = Healthcare_Shared.Functions.cleanWord(src.BoardCertifiedSubSpecialty5Verification) and 
																											 Healthcare_Shared.Functions.cleanWord(left.CertificateName) <> '',true,skip)));
										Verif := project(left.VerificationInfo, transform(Healthcare_Shared.Layouts.Verifications,
																self.BoardCertifiedSubSpecialtyVerified := exists(recs1) or exists(recs2) or exists(recs3) or exists(recs4) or exists(recs5);
																self.BoardCertifiedSubSpecialty1Verified := exists(recs1);
																self.BoardCertifiedSubSpecialty2Verified := exists(recs2);
																self.BoardCertifiedSubSpecialty3Verified := exists(recs3);
																self.BoardCertifiedSubSpecialty4Verified := exists(recs4);
																self.BoardCertifiedSubSpecialty5Verified := exists(recs5);
																self := left;));
									self.VerificationInfo := Verif;
									self:=left;));
			return results;
		end;
		export isAliveNoSanc(dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) inRecs) := Function
			//If Death false and Sanctions do not exist we are good.
			results := project(inRecs, transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
										isDead := left.DeathLookup or left.DateofDeath <> '';
										hasSanctions := exists(left.Sanctions);
										hasEPLS := exists(left.LegacySanctions(sanc_grouptype='FEDERAL',sanc_subgrouptype='OPM'));
										hasLEIE := exists(left.LegacySanctions(sanc_grouptype='FEDERAL',sanc_subgrouptype='OIG'));
										hasDisciplinary := exists(left.LegacySanctions(sanc_grouptype='STATE'));
										Verif := project(left.VerificationInfo, transform(Healthcare_Shared.Layouts.Verifications,
																self.isAliveNoSanc := if(isDead or hasSanctions,false,true);
																self.isDead := isDead;
																self.hasSanctions := hasSanctions;
																self.hasEPLSSanctions := hasEPLS;
																self.hasLEIESanctions := hasLEIE;
																self.hasDisciplinarySanctions := hasDisciplinary;
																self := left;));
									self.VerificationInfo := Verif;
									self:=left;));
			return results;
		end;
		export OneStepValidation(dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) inRecs, string OneStepRule) := Function
			results := project(inRecs, transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
									self.VerificationInfo := Healthcare_Shared.Fn_do_OneStepValidation.compareResults2Configuration(STD.Str.ToUpperCase(OneStepRule),left.VerificationInfo);
									self:=left;));
			return results;
		end;
		export doSSNMasking(dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) inRecs, dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg) := Function 
			results := project(inRecs, transform(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout,
									addInputSSN := if(left.VerificationInfo[1].SSNVerified,
																			project(left,transform(Healthcare_Shared.Layouts.layout_ssn,
																										self.ssn:=left.userinput.ssn;
																										self:=[])),
																			project(left,transform(Healthcare_Shared.Layouts.layout_ssn,
																										self:=[]))); 
									ssnInfo := dedup(left.ssns+addInputSSN,record,all)(SSN<>'');
									ssnLookupInfo := left.SSNLookups;
									suppressionType := if(cfg[1].glb_ok,'NONE','LAST4');
									suppress.MAC_Mask(ssnInfo, maskedSSNs, ssn, blank, true, false, false, false,ssn,suppressionType);
									suppress.MAC_Mask(ssnLookupInfo, maskedSSNLookups, ssn, blank, true, false, false, false,ssn,suppressionType);
									self.ssns := maskedSSNs;
									self.SSNLookups := maskedSSNLookups;
									self:=left;));
			return results;
		end;
		export Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout processVerifications(dataset(Healthcare_Shared.Layouts.CombinedHeaderResultsDoxieLayout) inRecs, dataset(Healthcare_Shared.Layouts.common_runtime_config) cfg) := Function 
			processSetDefaults := SetDefaults(inRecs);
			processNameVerified := NameVerified(processSetDefaults);
			processCompanyVerified := CompanyNamesVerified(processNameVerified);
			processAddressVerified := AddressVerified(processCompanyVerified);
			processPhoneVerified := PhoneVerified(processAddressVerified);
			processSSNVerified := SSNVerified(processPhoneVerified);
			processFEINVerified := FEINVerified(processSSNVerified);
			processFEINSuppliedExists := FEINExists(processFEINVerified);
			processMedicalSchoolNameVerified := MedSchoolVerified(processFEINSuppliedExists);
			processGraduationYearVerified := GradYearVerified(processMedicalSchoolNameVerified);
			processCLIAValid := CLIAValid(processGraduationYearVerified);
			processCLIAVerified := CLIAVerified(processCLIAValid);
			processUPINVerified := UPINVerified(processCLIAVerified);
			// processHeaderFlags := Healthcare_Shared.Fn_search_Ind_Header.getFlags(processUPINVerified);
			// processBusHeaderFlags := Healthcare_Shared.Fn_search_Bus_Header.getFlags(processHeaderFlags);
			processNPIValid := NPIValid(processUPINVerified);
			processNPIVerified := NPIVerified(processNPIValid);
			processDEAValid := DEAValid(processNPIVerified);
			processDEA2Valid := DEA2Valid(processDEAValid);
			processDEAVerified := DEAVerified(processDEA2Valid);
			processDEA2Verified := DEA2Verified(processDEAVerified);
			processNCPDPNumberVerified := NCPDPNumberVerified(processDEA2Verified);
			processStateLicense := StateLicenseFlags(processNCPDPNumberVerified,cfg[1].CustomerID);
			processTaxonomyVerified := TaxonomyVerified(processStateLicense);
			processTaxonomyExists := TaxonomyExists(processTaxonomyVerified);
			processABMSSpecialtyValid := ABMSSpecialtyValid(processTaxonomyExists);
			processABMSSpecialtyVerified := ABMSSpecialtyVerified(processABMSSpecialtyValid);
			processABMSSubSpecialtyValid := ABMSSubSpecialtyValid(processABMSSpecialtyVerified);
			processABMSSubSpecialtyVerified := ABMSSubSpecialtyVerified(processABMSSubSpecialtyValid);
			processAliveNoSanc := isAliveNoSanc(processABMSSubSpecialtyVerified);
			processOneStepValidation := OneStepValidation(processAliveNoSanc,cfg[1].OneStepRule);
			processSSNMasking := doSSNMasking(processOneStepValidation,cfg);
			// output(processSetDefaults,named('processSetDefaults'));
			// output(processNameVerified,named('processNameVerified'));
			// output(processCompanyVerified,named('processCompanyVerified'));
			// output(processAddressVerified,named('processAddressVerified'));
			// output(processPhoneVerified,named('processPhoneVerified'));
			// output(processSSNVerified,named('processSSNVerified'));
			// output(processFEINVerified,named('processFEINVerified'));
			// output(processFEINSuppliedExists,named('processFEINSuppliedExists'));
			// output(processMedicalSchoolNameVerified,named('processMedicalSchoolNameVerified'));
			// output(processGraduationYearVerified,named('processGraduationYearVerified'));
			// output(processCLIAValid,named('processCLIAValid'));
			// output(processCLIAVerified,named('processCLIAVerified'));
			// output(processUPINVerified,named('processUPINVerified'));
			// output(processHeaderFlags,named('processHeaderFlags'));
			// output(processNPIValid,named('processNPIValid'));
			// output(processNPIVerified,named('processNPIVerified'));
			// output(processDEAValid,named('processDEAValid'));
			// output(processDEA2Valid,named('processDEA2Valid'));
			// output(processDEAVerified,named('processDEAVerified'));
			// output(processDEA2Verified,named('processDEA2Verified'));
			// output(processNCPDPNumberVerified,named('processNCPDPNumberVerified'));
			// output(processStateLicense,named('processStateLicense'));
			// output(processTaxonomyVerified,named('processTaxonomyVerified'));
			// output(processABMSSpecialtyValid,named('processABMSSpecialtyValid'));
			// output(processABMSSpecialtyVerified,named('processABMSSpecialtyVerified'));
			// output(processABMSSubSpecialtyValid,named('processABMSSubSpecialtyValid'));
			// output(processABMSSubSpecialtyVerified,named('processABMSSubSpecialtyVerified'));
			// output(processAliveNoSanc,named('processAliveNoSanc'));
			// output(processOneStepValidation,named('processOneStepValidation'));
			// output(processSSNMasking,named('processSSNMasking'));
		return processSSNMasking;
		end;
END;
