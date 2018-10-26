import iesp,ut,Business_Header,Business_Header_SS,Risk_Indicators,doxie,watchdog,suppress,dx_BestRecords;

export Functions_Validation := Module
		shared myLayouts := Healthcare_Provider_Services.layouts;
		shared myConst := Healthcare_Provider_Services.Constants;
		shared currentDate := (string)ut.GetDate;
		EXPORT cleanValue(STRING inputValue) := FUNCTION
			RETURN stringlib.StringFilter(stringlib.StringToUpperCase(inputValue),'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
		END;
		EXPORT cleanValueNumbers(STRING inputValue) := FUNCTION
			RETURN stringlib.StringFilter(stringlib.StringToUpperCase(inputValue),'0123456789');
		END;
		EXPORT checkCurrentLicense(iesp.share.t_Date inputValue) := FUNCTION
			licDate:= iesp.ECL2ESP.t_DateToString8(inputValue);
			RETURN licDate>=currentDate;
		END;
		shared layout_nameCheck := record
			STRING9 		ssn := '';
			string1			FName := '';
			string20		LName := '';
			string1			FlipFName := '';
			string20		FlipLName := '';
		end;
		export NameVerified(myLayouts.CombinedHeaderResultsDoxieLayout results,myLayouts.autokeyInput src) := Function 
			hasLast := cleanValue(src.name_last) <> '';
			recs := project(results.names, transform(myLayouts.Verifications, self.NameVerified := if((cleanValue(left.FirstName) = cleanValue(src.name_first) and cleanValue(left.LastName) = cleanValue(src.name_last)),true,skip)));
			return hasLast and exists(recs);
		end;
		export CompanyNamesVerified(myLayouts.CombinedHeaderResultsDoxieLayout results,myLayouts.autokeyInput src) := Function 
			hasFull := cleanValue(src.comp_name) <> '';
			recs := project(results.names, transform(myLayouts.Verifications, self.CompanyNameVerified := IF (ut.CompanySimilar100 (cleanValue(Functions.getCleanHealthCareName(left.CompanyName)), cleanValue(Functions.getCleanHealthCareName(src.comp_name)),true) < 60,true,skip)));
			return hasFull and exists(recs);
		end;
		export AddressVerified(myLayouts.CombinedHeaderResultsDoxieLayout results,myLayouts.autokeyInput src) := Function 
			hasPrimRange := cleanValue(src.prim_range) <>'';
			hasPrimName := cleanValue(src.prim_name) <>'';
			hasCity := cleanValue(src.p_city_name) <>'';
			hasInputAddrtoVerify := (hasPrimRange and hasPrimName) or (hasPrimName and hasCity);
			input_range := cleanValue(src.prim_range);
			input_name := cleanValue(src.prim_name);
			recs := project(results.Addresses, transform(myLayouts.Verifications, self.AddressVerified := if((cleanValue(left.prim_range) = input_range and 
																																									cleanValue(left.prim_name) = input_name) or  
																																									(cleanValue(left.prim_range) = input_name and 
																																									cleanValue(left.p_city_name) = cleanValue(src.p_city_name)),true,skip)));
			return hasInputAddrtoVerify and exists(recs);
		end;
		export PhoneVerified(myLayouts.CombinedHeaderResultsDoxieLayout results, myLayouts.autokeyInput src) := Function 
			hasPhone := src.homephone <> '';
			recs := project(results.Phones, transform(myLayouts.Verifications, self.PhoneVerified := if(cleanValue(left.phone) = cleanValue(src.homephone) and cleanValue(left.Phone) <> '',true,skip)));
			return hasPhone and exists(recs);
		end;
		export SSNVerified(myLayouts.CombinedHeaderResultsDoxieLayout results, myLayouts.autokeyInput src) := Function 
			hasSSN := src.SSN <> '' and length(trim(src.SSN,all))=9;
			hasName := src.name_first <> '' and src.name_last <> '';
			//If we did not find anything in the results, compare user input our SSN files see if there is a match
			nameRecs := dedup(sort(project(results.names, transform(layout_nameCheck, 
																										//is the record we are evaluating close enough to the input criteria to keep
																										closeEnough := (left.FirstName[1] = src.name_first[1] and left.LastName[1..4] = src.name_last[1..4]) or 
																																	 (left.LastName[1] = src.name_first[1] and left.FirstName[1..4] = src.name_last[1..4]);
																										self.ssn := if(closeEnough,src.SSN,skip),
																										self.FName := left.FirstName[1]; 
																										self.LName:=left.LastName;
																										self.FlipFName := left.LastName[1]; 
																										self.FlipLName:=left.FirstName;self:=left)),record),record);
			getdidfromssn := if(hasSSN and hasName,Choosen(Doxie.Key_Header_SSN(keyed(s1=src.ssn[1]),keyed(s2=src.ssn[2]),keyed(s3=src.ssn[3]),keyed(s4=src.ssn[4]),keyed(s5=src.ssn[5]),keyed(s6=src.ssn[6]),keyed(s7=src.ssn[7]),keyed(s8=src.ssn[8]),keyed(s9=src.ssn[9])),10));
			didbasedssn := dedup(sort(project(getdidfromssn,myLayouts.layout_did),record),record);
			bestRaw := dx_BestRecords.get(dataset([{didbasedssn[1].did}], doxie.layout_references), 
				did, dx_BestRecords.Constants.perm_type.glb);
			bestRecs := project(bestRaw, transform(dx_BestRecords.layout_best, self := left._best));
			bestInfo:=bestRecs(((fname[1]=src.name_first[1] and lname = src.name_last) or 
													(fname[1]=src.name_last[1] and lname = src.name_first)));
			bestInfo_match := join(bestInfo,nameRecs,left.ssn=right.ssn,transform(recordof(bestInfo),
														self.ssn := if(ut.NameMatch100(left.fname[1],'',left.lname,right.FName,'',right.LName)>80 or
																					 ut.NameMatch100(left.fname[1],'',left.lname,right.FName,'',right.LName)>80 or
																					 ut.NameMatch100(left.fname[1],'',left.lname,right.FName,'',right.LName)>80 or
																					 ut.NameMatch100(left.fname[1],'',left.lname,right.FlipFName,'',right.FlipLName)>80 or
																					 ut.NameMatch100(left.fname[1],'',left.lname,right.FlipFName,'',right.FlipLName)>80 or
																					 ut.NameMatch100(left.fname[1],'',left.lname,right.FlipFName,'',right.FlipLName)>80,
														left.ssn,skip);
														self := left));
			//Compare user input against any names we found to see if there is a match
			ds_ssn_main:=if(hasSSN and hasName,Choosen(Risk_Indicators.Key_SSN_Table_v4_2(keyed(ssn=src.ssn)),10));
			ds_ssn_match := join(ds_ssn_main,nameRecs,left.ssn=right.ssn,transform(recordof(ds_ssn_main),
														self.ssn := if(ut.NameMatch100(left.combo.lname1.fname[1],'',left.combo.lname1.lname,right.FName,'',right.LName)>80 or
																					 ut.NameMatch100(left.combo.lname2.fname[1],'',left.combo.lname2.lname,right.FName,'',right.LName)>80 or
																					 ut.NameMatch100(left.combo.lname3.fname[1],'',left.combo.lname3.lname,right.FName,'',right.LName)>80 or
																					 ut.NameMatch100(left.combo.lname1.fname[1],'',left.combo.lname1.lname,right.FlipFName,'',right.FlipLName)>80 or
																					 ut.NameMatch100(left.combo.lname2.fname[1],'',left.combo.lname2.lname,right.FlipFName,'',right.FlipLName)>80 or
																					 ut.NameMatch100(left.combo.lname3.fname[1],'',left.combo.lname3.lname,right.FlipFName,'',right.FlipLName)>80,
														left.ssn,skip);
														self := left));
			recs := project(results.ssnlookups, transform(myLayouts.Verifications, self.SSNVerified := if(cleanValue(left.ssn) = cleanValue(src.SSN) and cleanValue(left.ssn) <> '',true,skip)));
			recs2 := project(results.ssns, transform(myLayouts.Verifications, self.SSNVerified := if(cleanValue(left.ssn) = cleanValue(src.SSN) and cleanValue(left.ssn) <> '',true,skip)));
			// output(getdidfromssn);
			// output(didbasedssn);
			// output(bestInfo);
			// output(bestInfo_match);
			// output(ds_ssn_main);
			// output(nameRecs);
			// output(ds_ssn_match);
			// output(recs);
			// output(recs2);
			return hasSSN and (exists(recs) or exists(recs2) or exists(ds_ssn_match) or exists(bestInfo_match));
		end;
		Export feinlookup1(dataset(myLayouts.feinLookup) ds) := function
			return join(ds,Business_Header.RoxieKeys().NewFetch.Key_FEIN_QA,keyed(left.bit1=right.f1) and keyed(left.bit2=right.f2) and keyed(left.bit3=right.f3) and
																																			keyed(left.bit4=right.f4) and keyed(left.bit5=right.f5) and keyed(left.bit6=right.f6) and
																																			keyed(left.bit7=right.f7) and keyed(left.bit8=right.f8) and keyed(left.bit9=right.f9),
																																			transform(myLayouts.feinLookupResults, self.CompanyName := right.cname;self:=[];),
																																			keep(myConst.MAX_RECS_ON_JOIN),limit(0));
		end;
		Export feinlookup2(dataset(myLayouts.feinLookup) ds) := function
			return join(ds,Business_Header_SS.Key_BH_FEIN,keyed(left.fein=right.fein),
																											transform(myLayouts.feinLookupResults, self.CompanyName := right.Company_Name;self:=[];),
																											keep(myConst.MAX_RECS_ON_JOIN),limit(0));
		end;
		export FEINVerified(myLayouts.CombinedHeaderResultsDoxieLayout results, myLayouts.autokeyInput src) := Function 
			hasTIN := src.taxid <> '';
			hasFEIN := src.FEIN <> '';
			hasInputValuetoVerify := hasTIN or hasFEIN;
			recs := project(results.feins, transform(myLayouts.Verifications, self.FEINVerified := if((cleanValue(left.fein) = cleanValue(src.FEIN) or cleanValue(left.fein) = cleanValue(src.taxid)) and cleanValue(left.fein) <> '',true,skip)));
			recs2 := project(results.taxids, transform(myLayouts.Verifications, self.FEINVerified := if((cleanValue(left.taxid) = cleanValue(src.taxid) or cleanValue(left.taxid) = cleanValue(src.fein)) and cleanValue(left.taxid) <> '',true,skip)));
			feinFmt := project(results.feins,transform(myLayouts.feinLookup,
																									val2CheckFmt := (string)INTFORMAT((integer)left.fein,9,1);
																									self.fein:=(integer)val2CheckFmt; self.bit1:=val2CheckFmt[1]; 
																									self.bit2:=val2CheckFmt[2]; self.bit3:=val2CheckFmt[3]; 
																									self.bit4:=val2CheckFmt[4]; self.bit5:=val2CheckFmt[5]; 
																									self.bit6:=val2CheckFmt[6]; self.bit7:=val2CheckFmt[7]; 
																									self.bit8:=val2CheckFmt[8]; self.bit9:=val2CheckFmt[9];));
			taxidFmt := project(results.taxids,transform(myLayouts.feinLookup,
																									val2CheckFmt := (string)INTFORMAT((integer)left.taxid,9,1);
																									self.fein:=(integer)val2CheckFmt; self.bit1:=val2CheckFmt[1]; 
																									self.bit2:=val2CheckFmt[2]; self.bit3:=val2CheckFmt[3]; 
																									self.bit4:=val2CheckFmt[4]; self.bit5:=val2CheckFmt[5]; 
																									self.bit6:=val2CheckFmt[6]; self.bit7:=val2CheckFmt[7]; 
																									self.bit8:=val2CheckFmt[8]; self.bit9:=val2CheckFmt[9];));
			userInput := project(src,transform(myLayouts.feinLookup,
																									val2CheckFmt := (string)INTFORMAT((integer)left.taxid,9,1);
																									self.fein:=(integer)val2CheckFmt; self.bit1:=val2CheckFmt[1]; 
																									self.bit2:=val2CheckFmt[2]; self.bit3:=val2CheckFmt[3]; 
																									self.bit4:=val2CheckFmt[4]; self.bit5:=val2CheckFmt[5]; 
																									self.bit6:=val2CheckFmt[6]; self.bit7:=val2CheckFmt[7]; 
																									self.bit8:=val2CheckFmt[8]; self.bit9:=val2CheckFmt[9];));
			userInput2 := project(src,transform(myLayouts.feinLookup,
																									val2CheckFmt := (string)INTFORMAT((integer)left.fein,9,1);
																									self.fein:=(integer)val2CheckFmt; self.bit1:=val2CheckFmt[1]; 
																									self.bit2:=val2CheckFmt[2]; self.bit3:=val2CheckFmt[3]; 
																									self.bit4:=val2CheckFmt[4]; self.bit5:=val2CheckFmt[5]; 
																									self.bit6:=val2CheckFmt[6]; self.bit7:=val2CheckFmt[7]; 
																									self.bit8:=val2CheckFmt[8]; self.bit9:=val2CheckFmt[9];));
			ds := feinFmt+taxidFmt+userInput+userInput2;
			lookup1 := feinlookup1(ds(fein>0));
			lookup2 := feinlookup2(ds(fein>0));
			CNamesInput := dataset([{src.comp_name,0}],myLayouts.feinLookupResults);
			CNamesResults := Project(results.Names,transform(myLayouts.feinLookupResults,self.CompanyName:=left.CompanyName;self:=[];));
			CNamesResultsNPI1 := Project(results.NPIRaw,transform(myLayouts.feinLookupResults,self.CompanyName:=left.EntityInformation.CompanyName;self:=[];));
			CNamesResultsNPI2 := Project(results.NPIRaw,transform(myLayouts.feinLookupResults,self.CompanyName:=left.EntityInformation.CompanyNameAKA;self:=[];));
			//Cleaned Company Names from Results
			ResultsCompanyNamesCleaned := dedup(project(CNamesInput+CNamesResults+CNamesResultsNPI1+CNamesResultsNPI2,transform(myLayouts.feinLookupResults,self.CompanyName:=Functions.getCleanHealthCareName(left.CompanyName);self:=[];))(CompanyName<>''),all);
			//Cleaned Company Names from lookup1
			lookup1Cleaned := dedup(project(lookup1,transform(myLayouts.feinLookupResults,self.CompanyName:=Functions.getCleanHealthCareName(left.CompanyName);self:=[];)),all);
			//Cleaned Company Names from lookup2
			lookup2Cleaned := dedup(project(lookup2,transform(myLayouts.feinLookupResults,self.CompanyName:=Functions.getCleanHealthCareName(left.CompanyName);self:=[];)),all);
			
			lookMatch1 := join(lookup1Cleaned(CompanyName<>''),ResultsCompanyNamesCleaned(CompanyName<>''),
																					left.boguslink = right.boguslink,transform(myLayouts.Verifications, 
																								closematch := ut.CompanySimilar100(Functions.getCleanHealthCareName(left.CompanyName),Functions.getCleanHealthCareName(right.CompanyName));
																								self.FEINVerified := if(closematch<=Constants.BUS_NAME_MATCH_THRESHOLD,true,skip)));
			lookMatch2 := join(lookup2Cleaned(CompanyName<>''),ResultsCompanyNamesCleaned(CompanyName<>''),
																					left.boguslink = right.boguslink,transform(myLayouts.Verifications, 
																								closematch := ut.CompanySimilar100(Functions.getCleanHealthCareName(left.CompanyName),Functions.getCleanHealthCareName(right.CompanyName));
																								self.FEINVerified := if(closematch<=Constants.BUS_NAME_MATCH_THRESHOLD,true,skip)));
			// output(src,named('src'));
			// output(hasInputValuetoVerify,named('hasInputValuetoVerify'));
			// output(recs,named('recs'));
			// output(recs2,named('recs2'));
			// output(feinFmt,named('feinFmt'));
			// output(taxidFmt,named('taxidFmt'));
			// output(userInput,named('userInput'));
			// output(ds,named('ds'));
			// output(lookup1,named('lookup1'));
			// output(lookup2,named('lookup2'));
			// output(CNamesInput,named('CNamesInput'));
			// output(CNamesResults,named('CNamesResults'));
			// output(CNamesResultsNPI1,named('CNamesResultsNPI1'));
			// output(CNamesResultsNPI2,named('CNamesResultsNPI2'));
			// output(ResultsCompanyNamesCleaned,named('ResultsCompanyNamesCleaned'));
			// output(lookup1Cleaned,named('lookup1Cleaned'));
			// output(lookup2Cleaned,named('lookup2Cleaned'));
			// output(lookMatch1,named('lookMatch1'));
			// output(lookMatch2,named('lookMatch2'));
			return hasInputValuetoVerify and (exists(recs) or exists(recs2) or exists(lookMatch1) or exists(lookMatch2));
		end;
		Export FEINExists(myLayouts.autokeyInput src) := Function
			hasTIN := src.taxid <> '';
			hasFEIN := src.FEIN <> '';
			hasInputValuetoVerify := hasTIN or hasFEIN;
			val2Check := map(hasInputValuetoVerify and hasFEIN =>src.FEIN,
											 hasInputValuetoVerify and hasTIN => src.taxid,'');
			val2CheckFmt := (string)INTFORMAT((integer)val2Check,9,1);
			ds := dataset([{(integer)val2CheckFmt,val2CheckFmt[1],val2CheckFmt[2],val2CheckFmt[3],val2CheckFmt[4],val2CheckFmt[5],val2CheckFmt[6],val2CheckFmt[7],val2CheckFmt[8],val2CheckFmt[9]}],myLayouts.feinLookup);
			recs := feinlookup1(ds);
			recs2 := feinlookup2(ds);
			return hasInputValuetoVerify and (exists(recs) or exists(recs2));
		end;
		Export MedSchoolVerified(myLayouts.CombinedHeaderResultsDoxieLayout results, myLayouts.autokeyInput src) := Function
			hasInput := src.MedicalSchoolNameVerification <> '';
			hasMatch := exists(project(results.MedSchools, transform(myLayouts.Verifications, self.MedicalSchoolNameVerified := if(BridgerScoreLib.companyScore(left.MedSchoolName,src.MedicalSchoolNameVerification)>.80,true,skip))));
			return hasInput and hasMatch;
		End;
		Export GradYearVerified(myLayouts.CombinedHeaderResultsDoxieLayout results, myLayouts.autokeyInput src) := Function
			hasInput := src.GraduationYearVerification > 0;
			hasMatch := exists(project(results.MedSchools, transform(myLayouts.Verifications, self.GraduationYearVerified := if(src.GraduationYearVerification=(integer)left.GraduationYear and (integer)left.GraduationYear <> 0,true,skip))));
			return hasInput and hasMatch;
		End;
		export CLIAValid(myLayouts.CombinedHeaderResultsDoxieLayout results, myLayouts.autokeyInput src) := Function 
			hasClia := src.CLIANumber <> '';
			recs := project(results.CLIARaw(RecordType='C'), transform(myLayouts.Verifications, self.CLIAValid := if(cleanValue(left.CLIANumber) = cleanValue(src.CLIANumber) and cleanValue(left.CLIANumber) <> '' 
																																															 and checkCurrentLicense(left.ExpirationDate) 
																																															 and (trim(left.TerminationCode,all) = '' or trim(left.TerminationCode,all) = '00'),true,skip)));
			return hasClia and exists(recs);
		end;
		export CLIAVerified(myLayouts.CombinedHeaderResultsDoxieLayout results, myLayouts.autokeyInput src) := Function 
			hasClia := src.CLIANumber <> '';
			recs := project(results.CLIARaw, transform(myLayouts.Verifications, self.CLIAVerified := if(cleanValue(left.CLIANumber) = cleanValue(src.CLIANumber) and cleanValue(left.CLIANumber) <> '',true,skip)));
			return hasClia and exists(recs);
		end;
		Export UPINVerified(myLayouts.CombinedHeaderResultsDoxieLayout results, myLayouts.autokeyInput src) := Function
			hasInput := src.upin <> '';
			hasMatch := exists(project(results.upins, transform(myLayouts.Verifications,self.UPINVerified := if(cleanValue(left.upin) = cleanValue(src.UPIN) and cleanValue(left.upin) <> '',true,skip))));
			return hasInput and hasMatch;
		End;
		Export NpiExists(myLayouts.autokeyInput src) := Function
			hasInput := src.npi <> '';
			hasMatch := exists(Functions.getNPPESByNPI(dataset([{src.NPI}],myLayouts.NPPES_Layouts.layout_npiid)));
			return hasInput and hasMatch;
		End;
		Export NPIValid(myLayouts.CombinedHeaderResultsDoxieLayout results, myLayouts.autokeyInput src) := Function
			hasInput := src.npi <> '';
			hasMatch := exists(project(results.NPIRaw, transform(myLayouts.Verifications, self.NPIValid := if(cleanValue(left.NPIInformation.NPINumber) = cleanValue(src.NPI) and 
																																					cleanValue(left.NPIInformation.NPINumber) <> '' and 
																																					(length(trim(iesp.ECL2ESP.t_DateToString8(left.NPIInformation.DeactivationDate),all))=0 or length(trim(iesp.ECL2ESP.t_DateToString8(left.NPIInformation.ReactivationDate),all))>0),
																																					true,skip))));
			return hasInput and hasMatch;
		End;
		Export NpiVerified(myLayouts.CombinedHeaderResultsDoxieLayout results, myLayouts.autokeyInput src) := Function
			hasInput := src.npi <> '';
			hasMatch := exists(project(results.npis, transform(myLayouts.Verifications, self.NPIVerified := if(cleanValue(left.npi) = cleanValue(src.NPI) and cleanValue(left.npi) <> '',true,skip))));
			hasMatch2 := exists(project(results.NPIRaw, transform(myLayouts.Verifications, self.NPIVerified := if(cleanValue(left.NPIInformation.NPINumber) = cleanValue(src.NPI) and cleanValue(left.NPIInformation.NPINumber) <> '',true,skip))));
			return hasInput and (hasMatch or hasMatch2);
		End;
		export DEAValid(myLayouts.CombinedHeaderResultsDoxieLayout results, myLayouts.autokeyInput src) := Function 
			hasDea := src.DEA <> '';
			recs := project(results.deas, transform(myLayouts.Verifications, self.DEAVerified := if((cleanValue(left.dea) = cleanValue(src.DEA) or cleanValueNumbers(left.dea) = cleanValueNumbers(src.DEA)) and cleanValue(left.dea) <> '' and trim(left.expiration_date,all)>=trim(currentDate,all),true,skip)));
			return hasDea and exists(recs);
		end;
		export DEA2Valid(myLayouts.CombinedHeaderResultsDoxieLayout results, myLayouts.autokeyInput src) := Function 
			hasDea := src.DEA2 <> '';
			recs := project(results.deas, transform(myLayouts.Verifications, self.DEA2Verified := if((cleanValue(left.dea) = cleanValue(src.DEA2) or cleanValueNumbers(left.dea) = cleanValueNumbers(src.DEA2)) and cleanValue(left.dea) <> '' and trim(left.expiration_date,all)>=trim(currentDate,all),true,skip)));
			return hasDea and exists(recs);
		end;
		export DEAVerified(myLayouts.CombinedHeaderResultsDoxieLayout results, myLayouts.autokeyInput src) := Function 
			hasDea := src.DEA <> '';
			recs := project(results.deas, transform(myLayouts.Verifications, self.DEAVerified := if((cleanValue(left.dea) = cleanValue(src.DEA) or cleanValueNumbers(left.dea) = cleanValueNumbers(src.DEA)) and cleanValue(left.dea) <> '',true,skip)));
			return hasDea and exists(recs);
		end;
		export DEA2Verified(myLayouts.CombinedHeaderResultsDoxieLayout results, myLayouts.autokeyInput src) := Function 
			hasDea := src.DEA2 <> '';
			recs := project(results.deas, transform(myLayouts.Verifications, self.DEA2Verified := if((cleanValue(left.dea) = cleanValue(src.DEA2) or cleanValueNumbers(left.dea) = cleanValueNumbers(src.DEA2)) and cleanValue(left.dea) <> '',true,skip)));
			return hasDea and exists(recs);
		end;
		export LicenseMatch(dataset(myLayouts.layout_LicenseValidation) results, string srcLic, String srcLicState) := Function 
			hasLicense := srcLic <> '';
			hasLicenseState := srcLicState <> '';
			hasLicensetoMatch := hasLicense and hasLicenseState;
			recsRaw := project(sort(results,-TerminationDate), transform(myLayouts.Verifications, 
																						isLicMatch := trim(left.cleanLicenseNum,all) = trim(cleanValue(srcLic),all) or left.cleanIntLicenseNum = (integer)cleanValueNumbers(srcLic);
																						isStateMatch := trim(left.cleanLicenseState,all) = trim(cleanValue(srcLicState),all);
																						self.License1ResultMatch := if(isLicMatch and isStateMatch, (string)left.licenseSeq,skip);
																						self := left));
			return if(hasLicense,recsRaw[1].License1ResultMatch,'');
		end;
		export CustomerLicenseValid(dataset(myLayouts.layout_LicenseValidation) results, string srcLic, String srcLicState) := Function 
			hasLicense := srcLic <> '';
			hasLicenseState := srcLicState <> '';//Supplied
			recsRaw := project(results, transform(myLayouts.layout_LicenseValidation, 
																												self.LicenseValid := trim(left.cleanLicenseNum,all) = trim(cleanValue(srcLic)) or left.cleanIntLicenseNum = (integer)cleanValueNumbers(srcLic);
																												self.LicenseStateValid := trim(left.cleanLicenseState,all) = trim(cleanValue(srcLicState),all);
																												self := left));
			recs := recsRaw(LicenseValid and TerminationDateValid and if(hasLicenseState,LicenseStateValid,true));
			return hasLicense and exists(recs);
		end;
		export CustomerLicenseVerified(dataset(myLayouts.layout_LicenseValidation) results, string srcLic, String srcLicState) := Function 
			hasLicense := srcLic <> '';
			hasLicenseState := srcLicState <> '';//Supplied
			recsRaw := project(results, transform(myLayouts.layout_LicenseValidation, 
																												self.LicenseValid := trim(left.cleanLicenseNum,all) = trim(cleanValue(srcLic),all) or left.cleanIntLicenseNum = (integer)cleanValueNumbers(srcLic);
																												self.LicenseStateValid := trim(left.cleanLicenseState,all) = trim(cleanValue(srcLicState),all);
																												self := left));
			recs := recsRaw(LicenseValid and if(hasLicenseState,LicenseStateValid,true));
			return hasLicense and exists(recs);
		end;
		export LicenseValid(dataset(myLayouts.layout_LicenseValidation) results, string srcLic, String srcLicState) := Function 
			hasLicense := srcLic <> '';
			hasLicenseState := srcLicState <> '';
			hasLicensetoVerify := hasLicense and hasLicenseState;
			recsRaw := project(results, transform(myLayouts.layout_LicenseValidation, 
																												self.LicenseValid := trim(left.cleanLicenseNum,all) = trim(cleanValue(srcLic)) or left.cleanIntLicenseNum = (integer)cleanValueNumbers(srcLic);
																												self.LicenseStateValid := trim(left.cleanLicenseState,all) = trim(cleanValue(srcLicState),all);
																												self := left));
			recs := recsRaw(LicenseValid and LicenseStateValid and TerminationDateValid);
			return hasLicensetoVerify and exists(recs);
		end;
		export LicenseVerified(dataset(myLayouts.layout_LicenseValidation) results, string srcLic, String srcLicState) := Function 
			hasLicense := srcLic <> '';
			hasLicenseState := srcLicState <> '';
			hasLicensetoVerify := hasLicense and hasLicenseState;
			recsRaw := project(results, transform(myLayouts.layout_LicenseValidation, 
																												self.LicenseValid := trim(left.cleanLicenseNum,all) = trim(cleanValue(srcLic),all) or left.cleanIntLicenseNum = (integer)cleanValueNumbers(srcLic);
																												self.LicenseStateValid := trim(left.cleanLicenseState,all) = trim(cleanValue(srcLicState),all);
																												self := left));
			recs := recsRaw(LicenseValid and LicenseStateValid);
			return hasLicensetoVerify and exists(recs);
		end;
		export TaxonomyVerified(myLayouts.CombinedHeaderResultsDoxieLayout results, string srcTaxonomy) := Function 
			hasTaxonomy := srcTaxonomy <> '';
			recs := project(results.Taxonomy, transform(myLayouts.Verifications, self.TaxonomyVerified := if(cleanValue(left.TaxonomyCode) = cleanValue(srcTaxonomy) and cleanValue(left.TaxonomyCode) <> '',true,skip)));
			nppesRec := NORMALIZE(results.NPIRaw,left.ProviderTaxonomies,transform(myLayouts.layout_taxonomy,self.acctno:='1';self.ProviderID:=(unsigned6)left.NPIInformation.NPINumber,self.TaxonomyCode:=right.SelectedTaxonomyCode;self.PrimaryIndicator:=right.PrimaryTaxonomy,self:=[]));
			recs2 := project(nppesRec, transform(myLayouts.Verifications, self.TaxonomyVerified := if(cleanValue(left.TaxonomyCode) = cleanValue(srcTaxonomy) and cleanValue(left.TaxonomyCode) <> '',true,skip)));
			return hasTaxonomy and (exists(recs) or exists(recs2));
		end;
		export ABMSSpecialtyValid(myLayouts.CombinedHeaderResultsDoxieLayout results, string srcSpecialty) := Function 
			hasSpecialty := srcSpecialty <> '';
			recs := project(results.abmsRaw[1].Certifications(CertificateType <> 'S'), 
								transform(myLayouts.Verifications, self.BoardCertifiedSpecialtyVerified := if(cleanValue(left.CertificateName) = cleanValue(srcSpecialty) and 
																																													 cleanValue(left.CertificateName) <> '' and 
																																													 (trim(left.DurationType) = 'L' or 
																																														trim(left.DurationType) = 'M' or 
																																														trim(iesp.ecl2esp.DateToString(left.ExpireDate),all)>=trim(currentDate,all) or 
																																														trim(iesp.ecl2esp.DateToString(left.ReverificationDate),all)>=trim(currentDate,all)),true,skip)));
			return hasSpecialty and exists(recs);
		end;
		export ABMSSpecialtyVerified(myLayouts.CombinedHeaderResultsDoxieLayout results, string srcSpecialty) := Function 
			hasSpecialty := srcSpecialty <> '';
			recs := project(results.abmsRaw[1].Certifications(CertificateType <> 'S'), transform(myLayouts.Verifications, self.BoardCertifiedSpecialtyVerified := if(cleanValue(left.CertificateName) = cleanValue(srcSpecialty) and cleanValue(left.CertificateName) <> '',true,skip)));
			return hasSpecialty and exists(recs);
		end;
		export ABMSSubSpecialtyValid(myLayouts.CombinedHeaderResultsDoxieLayout results, string srcSubSpecialty) := Function 
			hasSubSpecialty := srcSubSpecialty <> '';
			recs := project(results.abmsRaw[1].Certifications(CertificateType = 'S'), 
								transform(myLayouts.Verifications, self.BoardCertifiedSubSpecialtyVerified := if(cleanValue(left.CertificateName) = cleanValue(srcSubSpecialty) and 
																																														 cleanValue(left.CertificateName) <> '' and 
																																														 (trim(left.DurationType) = 'L' or 
																																															trim(left.DurationType) = 'M' or 
																																															trim(iesp.ecl2esp.DateToString(left.ExpireDate),all)>=trim(currentDate,all) or 
																																															trim(iesp.ecl2esp.DateToString(left.ReverificationDate),all)>=trim(currentDate,all)),true,skip)));
			return hasSubSpecialty and exists(recs);
		end;
		export ABMSSubSpecialtyVerified(myLayouts.CombinedHeaderResultsDoxieLayout results, string srcSubSpecialty) := Function 
			hasSubSpecialty := srcSubSpecialty <> '';
			recs := project(results.abmsRaw[1].Certifications(CertificateType = 'S'), transform(myLayouts.Verifications, self.BoardCertifiedSubSpecialtyVerified := if(cleanValue(left.CertificateName) = cleanValue(srcSubSpecialty) and cleanValue(left.CertificateName) <> '',true,skip)));
			return hasSubSpecialty and exists(recs);
		end;
		export isAliveNoSanc(myLayouts.CombinedHeaderResultsDoxieLayout results) := Function 
			//If Death false and Sanctions do not exist we are good.
			isDead := results.DeathLookup or results.DateofDeath <> '';
			hasSanctions := exists(results.Sanctions);
			return if(isDead or hasSanctions,false,true);
		end;

		export mylayouts.CombinedHeaderResultsDoxieLayout processVerifications(myLayouts.CombinedHeaderResultsDoxieLayout results, myLayouts.autokeyInput src) := Transform 
			rec_out := myLayouts.Verifications;
			rec_out setinput():=transform
				self.Acctno := src.acctno;
				self.VerificationConfiguration := src.OneStepRule;
				self.VerificationConfigurationOutcome := false;
				self.NameVerified := NameVerified(results,src);
				self.CompanyNameVerified := CompanyNamesVerified(results,src);
				self.AddressVerified := AddressVerified(results,src);
				self.PhoneVerified := PhoneVerified(results,src);
				self.SSNVerified := SSNVerified(results,src);
				self.FEINVerified := FEINVerified(results,src);
				self.FEINSuppliedExists := FEINExists(src);
				self.MedicalSchoolNameVerified := MedSchoolVerified(results,src);
				self.GraduationYearVerified := GradYearVerified(results,src);
				self.CLIAValid := CLIAValid(results,src);
				self.CLIAVerified := CLIAVerified(results,src);
				self.UPINVerified := UPINVerified(results,src);
				self.NPIValid := NPIValid(results,src);
				self.NPISuppliedExists := NpiExists(src);
				self.NPIVerified := NpiVerified(results,src);
				self.DEAValid := DEAValid(results,src);
				self.DEA2Valid := DEA2Valid(results,src);
				self.DEAVerified := DEAVerified(results,src);
				self.DEA2Verified := DEA2Verified(results,src);
				licRecs := Sort(project(results.StateLicenses, transform(myLayouts.layout_LicenseValidation, 
																									self.licenseSeq := left.licenseSeq;
																									self.origLicenseState := left.LicenseState;
																									self.cleanLicenseState := cleanValue(left.LicenseState);
																									self.origLicenseNum := left.LicenseNumber;
																									self.cleanLicenseNum := cleanValue(left.LicenseNumber);
																									self.cleanIntLicenseNum := (integer)cleanValueNumbers(left.LicenseNumber);
																									self.LicenseValid := false;
																									self.LicenseStateValid := false;
																									self.TerminationDate := left.Termination_Date;
																									self.TerminationDateValid := trim(left.Termination_Date,all)>=trim(currentDate,all))),record);
				customerlicRecs := Sort(project(results.customerLicense, transform(myLayouts.layout_LicenseValidation, 
																									stateDefault := map(trim(left.CustomerDataSrc,left,right) = '1535116' => 'MI',
																																			'');
																									self.licenseSeq := 0;
																									self.origLicenseState := stateDefault;
																									self.cleanLicenseState := stateDefault;
																									self.origLicenseNum := left.LicenseNumber;
																									self.cleanLicenseNum := cleanValue(left.LicenseNumber);
																									self.cleanIntLicenseNum := (integer)cleanValueNumbers(left.LicenseNumber);
																									self.LicenseValid := false;
																									self.LicenseStateValid := false;
																									self.TerminationDate := iesp.ECL2ESP.t_DateToString8(left.ExpirationDate);
																									self.TerminationDateValid := trim(iesp.ECL2ESP.t_DateToString8(left.ExpirationDate),all)>=trim(currentDate,all))),record);
				lvalOrig := CustomerLicenseValid(customerlicRecs(TerminationDateValid=true),src.license_number,src.license_state) or LicenseValid(licRecs(TerminationDateValid=true),src.license_number,src.license_state);
				lverOrig := CustomerLicenseVerified(customerlicRecs,src.license_number,src.license_state) or LicenseVerified(licRecs,src.license_number,src.license_state);
				lval1 := CustomerLicenseValid(customerlicRecs(TerminationDateValid=true),src.StateLicense1Verification,src.StateLicense1StateVerification) or LicenseValid(licRecs(TerminationDateValid=true),src.StateLicense1Verification,src.StateLicense1StateVerification);
				lmatch1 := LicenseMatch(licRecs,src.StateLicense1Verification,src.StateLicense1StateVerification);
				lver1 := CustomerLicenseVerified(customerlicRecs,src.StateLicense1Verification,src.StateLicense1StateVerification) or LicenseVerified(licRecs,src.StateLicense1Verification,src.StateLicense1StateVerification);
				lval2 := CustomerLicenseValid(customerlicRecs(TerminationDateValid=true),src.StateLicense2Verification,src.StateLicense2StateVerification) or LicenseValid(licRecs(TerminationDateValid=true),src.StateLicense2Verification,src.StateLicense2StateVerification);
				lver2 := CustomerLicenseVerified(customerlicRecs,src.StateLicense2Verification,src.StateLicense2StateVerification) or LicenseVerified(licRecs,src.StateLicense2Verification,src.StateLicense2StateVerification);
				lmatch2 := LicenseMatch(licRecs,src.StateLicense2Verification,src.StateLicense2StateVerification);
				lval3 := CustomerLicenseValid(customerlicRecs(TerminationDateValid=true),src.StateLicense3Verification,src.StateLicense3StateVerification) or LicenseValid(licRecs(TerminationDateValid=true),src.StateLicense3Verification,src.StateLicense3StateVerification);
				lver3 := CustomerLicenseVerified(customerlicRecs,src.StateLicense3Verification,src.StateLicense3StateVerification) or LicenseVerified(licRecs,src.StateLicense3Verification,src.StateLicense3StateVerification);
				lmatch3 := LicenseMatch(licRecs,src.StateLicense3Verification,src.StateLicense3StateVerification);
				lval4 := CustomerLicenseValid(customerlicRecs(TerminationDateValid=true),src.StateLicense4Verification,src.StateLicense4StateVerification) or LicenseValid(licRecs(TerminationDateValid=true),src.StateLicense4Verification,src.StateLicense4StateVerification);
				lver4 := CustomerLicenseVerified(customerlicRecs,src.StateLicense4Verification,src.StateLicense4StateVerification) or LicenseVerified(licRecs,src.StateLicense4Verification,src.StateLicense4StateVerification);
				lmatch4 := LicenseMatch(licRecs,src.StateLicense4Verification,src.StateLicense4StateVerification);
				lval5 := CustomerLicenseValid(customerlicRecs(TerminationDateValid=true),src.StateLicense5Verification,src.StateLicense5StateVerification) or LicenseValid(licRecs(TerminationDateValid=true),src.StateLicense5Verification,src.StateLicense5StateVerification);
				lver5 := CustomerLicenseVerified(customerlicRecs,src.StateLicense5Verification,src.StateLicense5StateVerification) or LicenseVerified(licRecs,src.StateLicense5Verification,src.StateLicense5StateVerification);
				lmatch5 := LicenseMatch(licRecs,src.StateLicense5Verification,src.StateLicense5StateVerification);
				lval6 := CustomerLicenseValid(customerlicRecs(TerminationDateValid=true),src.StateLicense6Verification,src.StateLicense6StateVerification) or LicenseValid(licRecs(TerminationDateValid=true),src.StateLicense6Verification,src.StateLicense6StateVerification);
				lver6 := CustomerLicenseVerified(customerlicRecs,src.StateLicense6Verification,src.StateLicense6StateVerification) or LicenseVerified(licRecs,src.StateLicense6Verification,src.StateLicense6StateVerification);
				lmatch6 := LicenseMatch(licRecs,src.StateLicense6Verification,src.StateLicense6StateVerification);
				lval7 := CustomerLicenseValid(customerlicRecs(TerminationDateValid=true),src.StateLicense7Verification,src.StateLicense7StateVerification) or LicenseValid(licRecs(TerminationDateValid=true),src.StateLicense7Verification,src.StateLicense7StateVerification);
				lver7 := CustomerLicenseVerified(customerlicRecs,src.StateLicense7Verification,src.StateLicense7StateVerification) or LicenseVerified(licRecs,src.StateLicense7Verification,src.StateLicense7StateVerification);
				lmatch7 := LicenseMatch(licRecs,src.StateLicense7Verification,src.StateLicense7StateVerification);
				lval8 := CustomerLicenseValid(customerlicRecs(TerminationDateValid=true),src.StateLicense8Verification,src.StateLicense8StateVerification) or LicenseValid(licRecs(TerminationDateValid=true),src.StateLicense8Verification,src.StateLicense8StateVerification);
				lver8 := CustomerLicenseVerified(customerlicRecs,src.StateLicense8Verification,src.StateLicense8StateVerification) or LicenseVerified(licRecs,src.StateLicense8Verification,src.StateLicense8StateVerification);
				lmatch8 := LicenseMatch(licRecs,src.StateLicense8Verification,src.StateLicense8StateVerification);
				lval9 := CustomerLicenseValid(customerlicRecs(TerminationDateValid=true),src.StateLicense9Verification,src.StateLicense9StateVerification) or LicenseValid(licRecs(TerminationDateValid=true),src.StateLicense9Verification,src.StateLicense9StateVerification);
				lver9 := CustomerLicenseVerified(customerlicRecs,src.StateLicense9Verification,src.StateLicense9StateVerification) or LicenseVerified(licRecs,src.StateLicense9Verification,src.StateLicense9StateVerification);
				lmatch9 := LicenseMatch(licRecs,src.StateLicense9Verification,src.StateLicense9StateVerification);
				lval10 := CustomerLicenseValid(customerlicRecs(TerminationDateValid=true),src.StateLicense10Verification,src.StateLicense10StateVerification) or LicenseValid(licRecs(TerminationDateValid=true),src.StateLicense10Verification,src.StateLicense10StateVerification);
				lver10 := CustomerLicenseVerified(customerlicRecs,src.StateLicense10Verification,src.StateLicense10StateVerification) or LicenseVerified(licRecs,src.StateLicense10Verification,src.StateLicense10StateVerification);
				lmatch10 := LicenseMatch(licRecs,src.StateLicense10Verification,src.StateLicense10StateVerification);
				self.LicenseValid := lvalOrig or lval1 or lval2 or lval3 or lval4 or lval5 or lval6 or lval7 or lval8 or lval9 or lval10;
				self.LicenseVerified := lverOrig or lver1 or lver2 or lver3 or lver4 or lver5 or lver6 or lver7 or lver8 or lver9 or lver10;
				self.License1Valid := lvalOrig or lval1;
				self.License1Verified :=  lverOrig or lver1;
				self.License1ResultMatch := lmatch1;
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
				tax1 := TaxonomyVerified(results,src.Taxonomy1Verification);
				tax2 := TaxonomyVerified(results,src.Taxonomy2Verification);
				tax3 := TaxonomyVerified(results,src.Taxonomy3Verification);
				tax4 := TaxonomyVerified(results,src.Taxonomy4Verification);
				tax5 := TaxonomyVerified(results,src.Taxonomy5Verification);
				self.TaxonomyVerified := tax1 or tax2 or tax3 or tax4 or tax5;
				self.Taxonomy1Verified := tax1;
				self.Taxonomy2Verified := tax2;
				self.Taxonomy3Verified := tax3;
				self.Taxonomy4Verified := tax4;
				self.Taxonomy5Verified := tax5;
				abmsSpec1 := ABMSSpecialtyVerified(results,src.BoardCertifiedSpecialtyVerification);
				abmsSubSpec1 := ABMSSubSpecialtyVerified(results,src.BoardCertifiedSubSpecialtyVerification);
				abmsSpec2 := ABMSSpecialtyVerified(results,src.BoardCertifiedSpecialty2Verification);
				abmsSubSpec2 := ABMSSubSpecialtyVerified(results,src.BoardCertifiedSubSpecialty2Verification);
				abmsSpec3 := ABMSSpecialtyVerified(results,src.BoardCertifiedSpecialty3Verification);
				abmsSubSpec3 := ABMSSubSpecialtyVerified(results,src.BoardCertifiedSubSpecialty3Verification);
				abmsSpec4 := ABMSSpecialtyVerified(results,src.BoardCertifiedSpecialty4Verification);
				abmsSubSpec4 := ABMSSubSpecialtyVerified(results,src.BoardCertifiedSubSpecialty4Verification);
				abmsSpec5 := ABMSSpecialtyVerified(results,src.BoardCertifiedSpecialty5Verification);
				abmsSubSpec5 := ABMSSubSpecialtyVerified(results,src.BoardCertifiedSubSpecialty5Verification);
				self.BoardCertifiedSpecialtyVerified := abmsSpec1 or abmsSpec2 or abmsSpec3 or abmsSpec4 or abmsSpec5;
				self.BoardCertifiedSubSpecialtyVerified := abmsSubSpec1 or abmsSubSpec2 or abmsSubSpec3 or abmsSubSpec4 or abmsSubSpec5;
				self.BoardCertifiedSpecialty1Verified := abmsSpec1;
				self.BoardCertifiedSubSpecialty1Verified := abmsSubSpec1;
				self.BoardCertifiedSpecialty2Verified := abmsSpec2;
				self.BoardCertifiedSubSpecialty2Verified := abmsSubSpec2;
				self.BoardCertifiedSpecialty3Verified := abmsSpec3;
				self.BoardCertifiedSubSpecialty3Verified := abmsSubSpec3;
				self.BoardCertifiedSpecialty4Verified := abmsSpec4;
				self.BoardCertifiedSubSpecialty4Verified := abmsSubSpec4;
				self.BoardCertifiedSpecialty5Verified := abmsSpec5;
				self.BoardCertifiedSubSpecialty5Verified := abmsSubSpec5;
				abmsSpec1Valid := ABMSSpecialtyValid(results,src.BoardCertifiedSpecialtyVerification);
				abmsSubSpec1Valid := ABMSSubSpecialtyValid(results,src.BoardCertifiedSubSpecialtyVerification);
				abmsSpec2Valid := ABMSSpecialtyValid(results,src.BoardCertifiedSpecialty2Verification);
				abmsSubSpec2Valid := ABMSSubSpecialtyValid(results,src.BoardCertifiedSubSpecialty2Verification);
				abmsSpec3Valid := ABMSSpecialtyValid(results,src.BoardCertifiedSpecialty3Verification);
				abmsSubSpec3Valid := ABMSSubSpecialtyValid(results,src.BoardCertifiedSubSpecialty3Verification);
				abmsSpec4Valid := ABMSSpecialtyValid(results,src.BoardCertifiedSpecialty4Verification);
				abmsSubSpec4Valid := ABMSSubSpecialtyValid(results,src.BoardCertifiedSubSpecialty4Verification);
				abmsSpec5Valid := ABMSSpecialtyValid(results,src.BoardCertifiedSpecialty5Verification);
				abmsSubSpec5Valid := ABMSSubSpecialtyValid(results,src.BoardCertifiedSubSpecialty5Verification);
				self.BoardCertifiedSpecialtyValid := abmsSpec1Valid or abmsSpec2Valid or abmsSpec3Valid or abmsSpec4Valid or abmsSpec5Valid;
				self.BoardCertifiedSubSpecialtyValid := abmsSubSpec1Valid or abmsSubSpec2Valid or abmsSubSpec3Valid or abmsSubSpec4Valid or abmsSubSpec5Valid;
				self.BoardCertifiedSpecialty1Valid := abmsSpec1Valid;
				self.BoardCertifiedSubSpecialty1Valid := abmsSubSpec1Valid;
				self.BoardCertifiedSpecialty2Valid := abmsSpec2Valid;
				self.BoardCertifiedSubSpecialty2Valid := abmsSubSpec2Valid;
				self.BoardCertifiedSpecialty3Valid := abmsSpec3Valid;
				self.BoardCertifiedSubSpecialty3Valid := abmsSubSpec3Valid;
				self.BoardCertifiedSpecialty4Valid := abmsSpec4Valid;
				self.BoardCertifiedSubSpecialty4Valid := abmsSubSpec4Valid;
				self.BoardCertifiedSpecialty5Valid := abmsSpec5Valid;
				self.BoardCertifiedSubSpecialty5Valid := abmsSubSpec5Valid;
				self.isAliveNoSanc := isAliveNoSanc(results);
				self.isDead := results.DeathLookup or results.DateofDeath <> '';
				self.hasSanctions := exists(results.Sanctions);
				self.hasEPLSSanctions := exists(results.Sanctions(sanc_grouptype='FEDERAL',sanc_subgrouptype='GSA'));
				self.hasLEIESanctions := exists(results.Sanctions(sanc_grouptype='FEDERAL',sanc_subgrouptype='OIG'));
				self.hasDisciplinarySanctions := exists(results.Sanctions(sanc_grouptype='STATE')) or exists(results.Sanctions(sanc_grouptype='FEDERAL',sanc_subgrouptype=''));
				self:=[];
			end;
			validation_ds:=dataset([setinput()]);
			OnStepValidation := Functions_OneStepPass.compareResults2Configuration(stringlib.StringToUpperCase(src.OneStepRule),validation_ds);
			self.VerificationInfo := OnStepValidation;
			ssnInfo := results.ssns;
			ssnLookupInfo := results.SSNLookups;
			suppressionType := if(results.glb_ok,'NONE','LAST4');
			suppress.MAC_Mask(ssnInfo, maskedSSNs, ssn, blank, true, false, false, false,ssn,suppressionType);
			suppress.MAC_Mask(ssnLookupInfo, maskedSSNLookups, ssn, blank, true, false, false, false,ssn,suppressionType);
			self.ssns := maskedSSNs;
			self.SSNLookups := maskedSSNLookups;
			self := results;
		end;
END;
