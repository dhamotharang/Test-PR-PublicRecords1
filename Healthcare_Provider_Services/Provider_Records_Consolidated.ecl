import doxie,doxie_files,AutoStandardI,Ingenix_NatlProf,ams,AMS_Services,Prof_LicenseV2_Services,iesp,address,dea,ut,Healthcare_Header_Services;
EXPORT Provider_Records_Consolidated := module
	shared myFn := Healthcare_Provider_Services.Provider_Records_Functions;
	shared myFnAms := Healthcare_Provider_Services.Provider_Records_Functions_Ams;
	shared myFnIng := Healthcare_Provider_Services.Provider_Records_Functions_Ing;
	shared myConst := Healthcare_Provider_Services.Constants;
	shared myLayouts := Healthcare_Provider_Services.Layouts;
	shared myTransforms := Healthcare_Provider_Services.Provider_Records_Transforms;
	shared src_ING := Healthcare_Provider_Services.Provider_Records_ING;
	shared src_AMS := Healthcare_Provider_Services.Provider_Records_AMS;
	shared src_Sanc := Healthcare_Provider_Services.Provider_Records_Sanc;
	shared src_DEA := Healthcare_Provider_Services.Provider_Records_DEA;
	shared src_NPPES := Healthcare_Provider_Services.Provider_Records_NPPES;
	shared src_ProfLic := Healthcare_Provider_Services.Provider_Records_ProfLic;
	shared src_BocaHeader := Healthcare_Provider_Services.Provider_Records_Boca_Header;
	shared src_BocaBusHeader := Healthcare_Provider_Services.Provider_Records_Boca_Bus_Header;
	shared srch_keys := Healthcare_Provider_Services.Provider_Records_SearchKeys;
	shared hdr_keys := Healthcare_Provider_Services.Header_Records_SearchKeys;

	Export getRecordsRawByDid (dataset(doxie.layout_references) input, UNSIGNED1 maxPenalty, boolean isHeaderSearch = false) := function
		searchResults := map(isHeaderSearch => hdr_keys(,input,true).getRecords(maxPenalty),
												 srch_keys.getRecordsByDid(input, maxPenalty));
		return searchResults;
	end;
	Export getRecordsRaw (dataset(mylayouts.autokeyInput) input, UNSIGNED1 maxPenalty, boolean isHeaderSearch = false) := function
		searchResults := map(isHeaderSearch => hdr_keys(input).getRecords(maxPenalty),
												 srch_keys.getRecords(input, maxPenalty));
		return searchResults;
	end;

	Export getRecordsAppend (dataset(myLayouts.autokeyInput) input, dataset(layouts.CombinedHeaderResults) rawRecs, UNSIGNED1 maxPenalty, boolean includeCliaFull = false, boolean isHeaderSearch = false) := function
		rawDoxieFmt := project(rawRecs,layouts.CombinedHeaderResultsDoxieLayout);
		slim := myFn.getSlimRecords(rawRecs);
		fmtRec_w_Language := myFnING.appendLanguage(slim,rawDoxieFmt);
		fmtRec_w_Degree := myFn.appendDegree(slim,fmtRec_w_Language);
		fmtRec_w_Specialty := myFn.appendSpecialty(slim,fmtRec_w_Degree);
		fmtRec_w_Residency := myFnING.appendResidency(slim,fmtRec_w_Specialty);
		fmtRec_w_MedSchool := myFnING.appendMedSchool(slim,fmtRec_w_Residency);
		fmtRec_w_Taxonomy := myFnING.appendTaxonomy(slim,fmtRec_w_MedSchool);
		slimSanc := dedup(sort(myFn.getSlimSancRecordsAppendSrcName(myFn.getSlimSancRecords(slim,rawRecs),input),acctno,providerid),acctno,providerid);
		fmtRec_w_Sanction := myFn.appendSanction(slimSanc,fmtRec_w_Taxonomy);
		fmtRec_w_SSN := myFn.appendSSN(slimSanc,fmtRec_w_Sanction);
		fmtRec_w_Death := myFn.appendDeath(slimSanc,fmtRec_w_SSN);
		fmtRec_w_NPI := myFn.appendNPI(slimSanc, fmtRec_w_Death, input);
		fmtRec_w_CustomerLicense := if(input[1].includeCustomerData,Functions.appendCustomerLicenseData(input, fmtRec_w_NPI),fmtRec_w_NPI);
		fmtRec_w_CustomerDeath := if(input[1].includeCustomerData,Functions.appendCustomerDeathData(input, fmtRec_w_CustomerLicense),fmtRec_w_CustomerLicense);
		fmtRec_Clia := Functions.getClia(slimSanc(clianumbers[1].clianumber<>''));
		fmtRec_w_Clia := if(includeCliaFull,join(fmtRec_w_CustomerDeath,fmtRec_Clia, left.acctno=right.acctno and left.srcID=(integer)right.providerid,
																		transform(myLayouts.CombinedHeaderResultsDoxieLayout,
																							self.CLIARaw := right.childinfo;
																							self := left),
																		left outer),
																		fmtRec_w_CustomerDeath);
		fmtRec_w_ABMS := Functions.appendABMSData(input,slimSanc,fmtRec_w_Clia);
		fmtRec_Final := join(fmtRec_w_ABMS,input(derivedinputrecord=false),left.acctno=right.acctno,Functions_Validation.processVerifications(left,right));
		// output(rawDoxieFmt,named('rawDoxieFmt'),overwrite);
		// output(fmtRec_w_Language,named('fmtRec_w_Language'),overwrite);
		// output(fmtRec_w_Degree,named('fmtRec_w_Degree'),overwrite);
		// output(fmtRec_w_Specialty,named('fmtRec_w_Specialty'),overwrite);
		// output(fmtRec_w_Residency,named('fmtRec_w_Residency'),overwrite);
		// output(fmtRec_w_MedSchool,named('fmtRec_w_MedSchool'),overwrite);
		// output(fmtRec_w_Taxonomy,named('fmtRec_w_Taxonomy'),overwrite);
		// output(fmtRec_w_Sanction,named('fmtRec_w_Sanction'),overwrite);
		// output(fmtRec_w_SSN,named('fmtRec_w_SSN'),overwrite);
		// output(fmtRec_w_Death,named('fmtRec_w_Death'),overwrite);
		// output(fmtRec_w_SSN,named('fmtRec_w_SSN'),overwrite);
		// output(fmtRec_w_NPI,named('fmtRec_w_NPI'),overwrite);
		// output(fmtRec_w_CustomerLicense,named('fmtRec_w_CustomerLicense'),overwrite);
		// output(fmtRec_w_CustomerDeath,named('fmtRec_w_CustomerDeath'),overwrite);
		// output(fmtRec_Clia,named('fmtRec_Clia'),overwrite);
		// output(fmtRec_w_Clia,named('fmtRec_w_Clia'),overwrite);
		// output(fmtRec_w_ABMS,named('fmtRec_w_ABMS'),overwrite);
		// output(fmtRec_Final,named('fmtRec_Final'),overwrite);
		return sort(fmtRec_Final,acctno,record_penalty);
	end;

	Export getRecordsRawDoxiebyDid (dataset(doxie.layout_references) input, UNSIGNED1 maxPenalty, boolean includeCliaFull = false, boolean isHeaderSearch = false) := function
		rawRecs := getRecordsRawByDid(input, maxPenalty, isHeaderSearch);
		appendSupplementalData := getRecordsAppend(project(input,transform(myLayouts.autokeyInput, self.acctno:='1';self.did:=left.did;self:=[])),rawRecs,maxPenalty,includeCliaFull,isHeaderSearch);
		// output(rawRecs,named('rawRecs'),overwrite);
		// output(rawDoxieFmt,named('rawDoxieFmt'),overwrite);
		return appendSupplementalData;
	end;

	Export getRecordsRawDoxie (dataset(myLayouts.autokeyInput) input, UNSIGNED1 maxPenalty, boolean includeCliaFull = false, boolean isHeaderSearch = false) := function
		splitHeader := project(input(providersrc=myConst.SRC_HEADER or trim(matchcode,left,right)=myConst.SRC_HEADER),transform(Healthcare_Header_Services.Layouts.autokeyInput,self:=left));
		normalProcessing := join(input,splitHeader,left.acctno=right.acctno,transform(myLayouts.autokeyInput, self:=left),left only);
		rawRecs := getRecordsRaw(normalProcessing, maxPenalty, isHeaderSearch);
		appendSupplementalData := getRecordsAppend(normalProcessing,rawRecs,maxPenalty,includeCliaFull,isHeaderSearch);
		headerResults := project(Healthcare_Header_Services.Records.getRecordsRawDoxie(splitHeader,maxPenalty,includeCliaFull),transform(mylayouts.CombinedHeaderResultsDoxieLayout,self.hcid:=left.srcid;self.Sanctions:=project(left.LegacySanctions,transform(mylayouts.layout_sanctions,self:=left)),self:=left));
		// output(rawRecs,named('rawRecs'),overwrite);
		return appendSupplementalData+headerResults;
	end;
	Export fmtRecordsLegacyReport (dataset(myLayouts.CombinedHeaderResultsDoxieLayout) rawRecs,IParams.searchParams searchCriteria =  module(project(AutoStandardI.GlobalModule(), IParams.searchParams, opt)) end) := function
		return project(rawRecs,myTransforms.fmtLegacyRpt(left,searchCriteria));
	end;
	Export fmtRecordsLegacyReportWithVerifications (dataset(myLayouts.CombinedHeaderResultsDoxieLayout) rawRecs,IParams.searchParams searchCriteria =  module(project(AutoStandardI.GlobalModule(), IParams.searchParams, opt)) end) := function
		return project(rawRecs,myTransforms.fmtLegacyRptWithVerifications(left,searchCriteria));
	end;
	Export getRecords (dataset(myLayouts.autokeyInput) input, UNSIGNED1 maxPenalty,IParams.searchParams searchCriteria =  module(project(AutoStandardI.GlobalModule(), IParams.searchParams, opt)) end,boolean isHeaderSearch = false) := function
		raw := getRecordsRawDoxie(input, maxPenalty,isHeaderSearch);
		fmtRec := fmtRecordsLegacyReportWithVerifications(raw,searchCriteria);
		return fmtRec;
	end;

	Export convertInputtoDataset(Healthcare_Provider_Services.IParams.searchParams inputCriteria,unsigned1 acctno = 1) := function
		layout  := myLayouts.autokeyInput;
		//Get clean address if needed
		cleanAddr := inputCriteria.addr <> '';
		testInput:=stringlib.StringFind(inputCriteria.addr,',',1);
		splitRaw1 := if(testInput>0,inputCriteria.addr[1..testInput-1],inputCriteria.addr);
		splitRaw2 := if(testInput>0,inputCriteria.addr[testInput+1..],'');
		tmpCity := If(inputCriteria.city ='' and inputCriteria.zip ='', 'ANYTOWN',inputCriteria.city);
		line2:=if(inputCriteria.City <>'' or inputCriteria.State <>'' or inputCriteria.Zip <>'',tmpCity+' '+inputCriteria.state+' '+inputCriteria.zip,splitRaw2);
		clnAddr := Address.CleanFields(Address.GetCleanAddress(splitRaw1,line2,address.Components.Country.US).str_addr);
		
		layout setinput():=transform
			self.acctno := (string) acctno;
			self.comp_name := stringlib.StringToUpperCase(inputCriteria.CompanyName);
			self.name_first := stringlib.StringToUpperCase(inputCriteria.FirstName);
			self.name_middle := stringlib.StringToUpperCase(inputCriteria.MiddleName);
			self.name_last := stringlib.StringToUpperCase(inputCriteria.LastName);
			self.predir := if(cleanAddr and clnAddr.predir <> '',clnAddr.predir,stringlib.StringToUpperCase(inputCriteria.predir));
			self.prim_range := if(cleanAddr and clnAddr.prim_range <> '',clnAddr.prim_range,stringlib.StringToUpperCase(inputCriteria.prim_range));
			self.prim_name := if(cleanAddr and clnAddr.prim_name <> '',clnAddr.prim_name,stringlib.StringToUpperCase(inputCriteria.prim_name));
			self.addr_suffix := if(cleanAddr and clnAddr.addr_suffix <> '',clnAddr.addr_suffix,stringlib.StringToUpperCase(inputCriteria.suffix));
			self.postdir := if(cleanAddr and clnAddr.postdir <> '',clnAddr.postdir,stringlib.StringToUpperCase(inputCriteria.postdir));
			self.sec_range := if(cleanAddr and clnAddr.sec_range <> '',clnAddr.sec_range,stringlib.StringToUpperCase(inputCriteria.sec_range));
			self.p_city_name := if(cleanAddr and clnAddr.p_city_name <> '',if(clnAddr.p_city_name='ANYTOWN','',clnAddr.p_city_name),stringlib.StringToUpperCase(inputCriteria.City));
			self.st := if(cleanAddr and clnAddr.st <> '',clnAddr.st,stringlib.StringToUpperCase(inputCriteria.State));
			self.z5 := if(cleanAddr and clnAddr.zip <> '',clnAddr.zip,inputCriteria.Zip);
			self.dob := (String)inputCriteria.dob;
			self.SSN := inputCriteria.SSN;
			self.NPI := inputCriteria.NPI;
			self.UPIN := inputCriteria.UPIN;
			self.DEA := inputCriteria.DEA;
			self.DEA2 := inputCriteria.DEA2;
			self.TAXID := inputCriteria.TaxID;
			self.FEIN := inputCriteria.FEIN;
			self.NCPDPNumber := inputCriteria.NCPDPNumber;
			self.license_number := if(inputCriteria.LicenseNumber<>'',stringlib.StringToUpperCase(inputCriteria.LicenseNumber),stringlib.StringToUpperCase(inputCriteria.StateLicenses[1].LicenseNumber));
			self.license_state := if(inputCriteria.LicenseState<>'',stringlib.StringToUpperCase(inputCriteria.LicenseState),stringlib.StringToUpperCase(inputCriteria.StateLicenses[1].LicenseState));
			self.cliaNumber := inputCriteria.CLIANumber;
			self.did := if(inputCriteria.derivedLexID,0,(integer)inputCriteria.did);
			self.bdid := if(inputCriteria.derivedLexID,0,(integer)inputCriteria.bdid);
			self.ProviderID := (integer)inputCriteria.ProviderId;	
			self.ProviderSrc := stringlib.StringToUpperCase(inputCriteria.ProviderSrc);
			self.CustomerID := inputCriteria.requestorCompanyID;
			self.glb_ok :=  ut.glb_ok (inputCriteria.GLBPurpose);
			self.dppa_ok := ut.dppa_ok(inputCriteria.DPPAPurpose);
			self.DRM := inputCriteria.DataRestrictionMask;
			self.OneStepRule := inputCriteria.OneStepRule;
			self.MedicalSchoolNameVerification := inputCriteria.MedicalSchoolName;
			self.GraduationYearVerification := inputCriteria.GraduationYear;
			Self.Taxonomy1Verification := stringlib.StringToUpperCase(inputCriteria.Taxonomy);
			Self.Taxonomy2Verification := stringlib.StringToUpperCase(inputCriteria.Taxonomy2);
			Self.Taxonomy3Verification := stringlib.StringToUpperCase(inputCriteria.Taxonomy3);
			Self.Taxonomy4Verification := stringlib.StringToUpperCase(inputCriteria.Taxonomy4);
			Self.Taxonomy5Verification := stringlib.StringToUpperCase(inputCriteria.Taxonomy5);
			Self.StateLicense1Verification := if(inputCriteria.LicenseNumber<>'',stringlib.StringToUpperCase(inputCriteria.LicenseNumber),stringlib.StringToUpperCase(inputCriteria.StateLicenses[1].LicenseNumber));
			Self.StateLicense1StateVerification := if(inputCriteria.LicenseState<>'',stringlib.StringToUpperCase(inputCriteria.LicenseState),stringlib.StringToUpperCase(inputCriteria.StateLicenses[1].LicenseState));
			Self.StateLicense2Verification := stringlib.StringToUpperCase(inputCriteria.StateLicenses[2].LicenseNumber);
			Self.StateLicense2StateVerification := stringlib.StringToUpperCase(inputCriteria.StateLicenses[2].LicenseState);
			Self.StateLicense3Verification := stringlib.StringToUpperCase(inputCriteria.StateLicenses[3].LicenseNumber);
			Self.StateLicense3StateVerification := stringlib.StringToUpperCase(inputCriteria.StateLicenses[3].LicenseState);
			Self.StateLicense4Verification := stringlib.StringToUpperCase(inputCriteria.StateLicenses[4].LicenseNumber);
			Self.StateLicense4StateVerification := stringlib.StringToUpperCase(inputCriteria.StateLicenses[4].LicenseState);
			Self.StateLicense5Verification := stringlib.StringToUpperCase(inputCriteria.StateLicenses[5].LicenseNumber);
			Self.StateLicense5StateVerification := stringlib.StringToUpperCase(inputCriteria.StateLicenses[5].LicenseState);
			Self.StateLicense6Verification := stringlib.StringToUpperCase(inputCriteria.StateLicenses[6].LicenseNumber);
			Self.StateLicense6StateVerification := stringlib.StringToUpperCase(inputCriteria.StateLicenses[6].LicenseState);
			Self.StateLicense7Verification := stringlib.StringToUpperCase(inputCriteria.StateLicenses[7].LicenseNumber);
			Self.StateLicense7StateVerification := stringlib.StringToUpperCase(inputCriteria.StateLicenses[7].LicenseState);
			Self.StateLicense8Verification := stringlib.StringToUpperCase(inputCriteria.StateLicenses[8].LicenseNumber);
			Self.StateLicense8StateVerification := stringlib.StringToUpperCase(inputCriteria.StateLicenses[8].LicenseState);
			Self.StateLicense9Verification := stringlib.StringToUpperCase(inputCriteria.StateLicenses[9].LicenseNumber);
			Self.StateLicense9StateVerification := stringlib.StringToUpperCase(inputCriteria.StateLicenses[9].LicenseState);
			Self.StateLicense10Verification := stringlib.StringToUpperCase(inputCriteria.StateLicenses[10].LicenseNumber);
			Self.StateLicense10StateVerification := stringlib.StringToUpperCase(inputCriteria.StateLicenses[10].LicenseState);
			self.BoardCertifiedSpecialtyVerification := inputCriteria.BoardCertifiedSpecialty;
			self.BoardCertifiedSubSpecialtyVerification := inputCriteria.BoardCertifiedSubSpecialty;
			self.BoardCertifiedSpecialty2Verification := inputCriteria.BoardCertifiedSpecialty2;
			self.BoardCertifiedSubSpecialty2Verification := inputCriteria.BoardCertifiedSubSpecialty2;
			self.BoardCertifiedSpecialty3Verification := inputCriteria.BoardCertifiedSpecialty3;
			self.BoardCertifiedSubSpecialty3Verification := inputCriteria.BoardCertifiedSubSpecialty3;
			self.BoardCertifiedSpecialty4Verification := inputCriteria.BoardCertifiedSpecialty4;
			self.BoardCertifiedSubSpecialty4Verification := inputCriteria.BoardCertifiedSubSpecialty4;
			self.BoardCertifiedSpecialty5Verification := inputCriteria.BoardCertifiedSpecialty5;
			self.BoardCertifiedSubSpecialty5Verification := inputCriteria.BoardCertifiedSubSpecialty5;
			self.isReport := inputCriteria.isReport;
			self.IncludeSanctions := inputCriteria.IncludeSanctions;
			self.includeCustomerData := inputCriteria.includeCustomerData;
			self.doDeepDive := inputCriteria.IncludeAlsoFound;
			self.IncludeABMSSpecialty := inputCriteria.IncludeBoardCertifiedSpecialty;
			self.IncludeABMSCareer := inputCriteria.IncludeCareer;
			self.IncludeABMSEducation := inputCriteria.IncludeEducation;
			self.IncludeABMSProfessionalAssociations := inputCriteria.IncludeProfessionalAssociations;
			self.IncludeAllSources := inputCriteria.IncludeAllSources;
			self.IncludeSourceIngenix := inputCriteria.IncludeSourceIngenix;
			self.IncludeSourceAMS := inputCriteria.IncludeSourceAMS;
			self.IncludeSourceNPPES := inputCriteria.IncludeSourceNPPES;
			self.IncludeSourceDEA := inputCriteria.IncludeSourceDEA;
			self.IncludeSourceProfLic := inputCriteria.IncludeSourceProfLic;
			self.IncludeSourceSelectFile := inputCriteria.IncludeSourceSelectFile;
			self.IncludeSourceCLIA := inputCriteria.IncludeSourceCLIA;
			self.IncludeSourceABMS := inputCriteria.IncludeSourceABMS;
			self.IncludeSourceNCPDP := inputCriteria.IncludeSourceNCPDP;
			self:=[];
			end;
		ds:=dataset([setinput()]);
		// getinputLicenses := project(inputCriteria.StateLicenses(LicenseNumber<>''),
																// transform(layout,self.acctno := (string)left.licenseAcctno;
																					// self.CustomerID := inputCriteria.requestorCompanyID;
																					// self.license_number := left.LicenseNumber;
																					// self.license_state := left.LicenseState;
																					// self.derivedInputRecord := true));
		// ds2:=if(count(inputCriteria.StateLicenses[2..])>0,getinputLicenses[2..]);
		// return ds+ds2;
		return ds;
	end;
	Export getReportServiceDidValues (dataset(mylayouts.autokeyInput) input, UNSIGNED1 maxPenalty, boolean isHeaderSearch = false) := function
		provRec:=sort(dedup(sort(getRecordsRaw(input,maxPenalty,isHeaderSearch),acctno, HCID,map(src='I'=>1,src='A'=>2,3)),record),record_penalty);
		return provRec;
	end;
	Export getReportServiceRecords (dataset(mylayouts.autokeyInput) input, UNSIGNED1 maxPenalty, boolean isHeaderSearch = false) := function
		// getPids := if(isHeaderSearch,hdr_keys(input).getHdrPIDsWithDeepDiveAndSanctions,srch_keys.getRecordsPIDs(input));
		getPids := srch_keys.getRecordsPIDs(input);
		fmtPid_with_Input := myFn.appendInputToSearchKeyData(getPids,input);
		sanc_pids:= myFn.getSearchKeyDataByType(fmtPid_with_Input,myConst.SRC_SANC);
		sanc_providers_base := src_Sanc.get_sanc_providers_base(sanc_pids,maxPenalty);
		sancLookup := normalize(sanc_providers_base,left.dids,transform(mylayouts.autokeyInput, self.did := right.did; self := left; self:=[]));
		otherLookupPIDs := srch_keys.getRecordsPIDs(sancLookup);
		lookupPIDS_with_Input := myFn.appendInputToSearchKeyData(otherLookupPIDs,input);
		combinedPids_with_Input_raw := dedup(sort(fmtPid_with_Input+lookupPIDS_with_Input,acctno,prov_id,src),acctno,prov_id,src);
		combinedPids_with_Input := if (isHeaderSearch or input[1].isReport,combinedPids_with_Input_raw,combinedPids_with_Input_raw(comp_name=''));
		ing_pids:= myFn.getSearchKeyDataByType(combinedPids_with_Input,myConst.SRC_ING);
		ams_pids:=myFn.getSearchKeyDataByType(combinedPids_with_Input,myConst.SRC_AMS);
		nppes_pids := myFn.getSearchKeyDataByType(combinedPids_with_Input_raw,myConst.SRC_NPPES);
		dea_pids := myFn.getSearchKeyDataByType(combinedPids_with_Input_raw,myConst.SRC_DEA);
		proflic_pids := myFn.getSearchKeyDataByType(combinedPids_with_Input_raw,myConst.SRC_PROFLIC);
		deepdive_pids := myFn.getSearchKeyDataByType(combinedPids_with_Input_raw,myConst.SRC_BOCA_PERSON_HEADER);
		busdeepdive_pids := myFn.getSearchKeyDataByType(combinedPids_with_Input_raw,myConst.SRC_BOCA_BUS_HEADER);
		ing_providers_final := src_ING.get_ing_entity(ing_pids,maxPenalty);
		nppes_providers_final := src_NPPES.get_nppes_providers_base(nppes_pids,maxPenalty);
		dea_providers_final := src_DEA.get_dea_providers_base(dea_pids,maxPenalty);
		proflic_providers_final := src_ProfLic.get_proflic_providers_base(proflic_pids,maxPenalty);
		BocaHeader_final := src_BocaHeader.get_boca_header_base(deepdive_pids,maxPenalty);
		BocaBusHeader_final := src_BocaBusHeader.get_boca_bus_header_base(busdeepdive_pids,input,maxPenalty);
		slimDown := project(input(providerid>0 or did>0 or bdid>0 or 
															name_first<>'' or name_last<>'' or Comp_name <>'' or
															prim_range<>'' or prim_name<>'' or p_city_name<>'' or st<>'' or z5<>''), 
												transform(mylayouts.layout_slimInput, self:=left;));
		filterRecs := join (slimDown,ing_providers_final, left.acctno=right.acctno, 
												transform(mylayouts.CombinedHeaderResults, self:=right));
		childDataLicense := normalize(filterRecs,left.StateLicenses,
												transform(mylayouts.slimINGforAMSLookup, self := right;self:=left));
		childDataNPI := normalize(filterRecs,left.npis,transform(mylayouts.slimINGforAMSLookup, self := right;self:=left));
		childDataDID := normalize(filterRecs,left.dids,transform(mylayouts.slimINGforAMSLookup, self := right;self:=left));
		amsLookupRecs := dedup(sort(childDataLicense+childDataNPI+childDataDID,record),record);
		provideridBasedSearch_pids := myFnAms.checkAMS(amsLookupRecs);
		additional_ams_pids:= join(provideridBasedSearch_pids,input, left.acctno = right.acctno, 
															transform(mylayouts.searchKeyResults_plus_input, self:=left;self:=right));
		//Add the lookup pids into the regular pid stream. if the search was initiated via a providerid and it was not a sanction search to start with
		all_ams_pids := if(count(input)=1 and input[1].ProviderID > 0 and input[1].ProviderSrc <> 'S',dedup(sort(ams_pids+additional_ams_pids,acctno,prov_id,src),acctno,prov_id,src),ams_pids);
		ams_providers_final := src_AMS.get_ams_entity(all_ams_pids,maxPenalty);
		//TODO  If we are searching a Header record that does not have an AMS or ING or Sanction Record 
		//			we need to go to the vendor source and collect the data and roll it up into the same format.
		
		//Rollup data by acctno,srcid, src
		ing_providers_final_sorted := sort(ing_providers_final, acctno, HcId, SrcId, Src);
		ing_providers_final_grouped := group(ing_providers_final_sorted, acctno, HcId, SrcId, Src);
		ing_providers_rolled := rollup(ing_providers_final_grouped, group, mytransforms.doSrcIdRollup(left,rows(left)));			
		ams_providers_final_sorted := sort(ams_providers_final, acctno, HcId, SrcId, Src);
		ams_providers_final_grouped := group(ams_providers_final_sorted, acctno, HcId, SrcId, Src);
		ams_providers_rolled := rollup(ams_providers_final_grouped, group, mytransforms.doSrcIdRollup(left,rows(left)));	
		sanc_providers_final_sorted := sort(sanc_providers_base, acctno, HcId, SrcId, Src);
		sanc_providers_final_grouped :=	group(sanc_providers_final_sorted, acctno, HcId, SrcId, Src);
		sanc_providers_rolled := rollup(sanc_providers_final_grouped, group, mytransforms.doSrcIdRollup(left,rows(left)));
		dea_providers_final_sorted := sort(dea_providers_final, acctno, HcId, SrcId, Src);
		dea_providers_final_grouped :=	group(dea_providers_final_sorted, acctno, HcId, SrcId, Src);
		dea_providers_rolled := rollup(dea_providers_final_grouped, group, mytransforms.doSrcIdRollup(left,rows(left)));
		nppes_providers_final_sorted := sort(nppes_providers_final, acctno, HcId, SrcId, Src);
		nppes_providers_final_grouped :=	group(nppes_providers_final_sorted, acctno, HcId, SrcId, Src);
		nppes_providers_rolled_raw := rollup(nppes_providers_final_grouped, group, mytransforms.doSrcIdRollup(left,rows(left)));
		nppes_providers_rolled := myFn.doPenalty(nppes_providers_rolled_raw,input,maxPenalty);
		proflic_providers_final_sorted := sort(proflic_providers_final, acctno, HcId, SrcId, Src);
		proflic_providers_final_grouped :=	group(proflic_providers_final_sorted, acctno, HcId, SrcId, Src);
		proflic_providers_rolled := rollup(proflic_providers_final_grouped, group, mytransforms.doSrcIdRollup(left,rows(left)));
		BocaHeader_final_sorted := sort(BocaHeader_final, acctno, HcId, SrcId, Src);
		BocaHeader_final_grouped :=	group(BocaHeader_final_sorted, acctno, HcId, SrcId, Src);
		BocaHeader_rolled := rollup(BocaHeader_final_grouped, group, mytransforms.doSrcIdRollup(left,rows(left)));
		BocaBusHeader_final_sorted := sort(BocaBusHeader_final, acctno, HcId, SrcId, Src);
		BocaBusHeader_final_grouped :=	group(BocaBusHeader_final_sorted, acctno, HcId, SrcId, Src);
		BocaBusHeader_rolled := rollup(BocaBusHeader_final_grouped, group, mytransforms.doSrcIdRollup(left,rows(left)));
		consolidatedRecords := ing_providers_rolled+ams_providers_rolled+sanc_providers_rolled+dea_providers_rolled+proflic_providers_rolled;//+nppes_providers_rolled+BocaHeader_rolled+BocaBusHeader_rolled;
		//Match up records with custom logic
		//Keep only records that actually resolved to something.
		ing_matchRecs := join(ing_pids(hid=0),ing_providers_rolled,left.acctno=right.acctno and left.prov_id = right.SrcId,transform(myLayouts.searchKeyResults_plus_input,self:=left));
		ams_matchRecs := join(all_ams_pids(hid=0),ams_providers_rolled,left.acctno=right.acctno and left.prov_id = right.SrcId,transform(myLayouts.searchKeyResults_plus_input,self:=left));
		custom_matching_logic:= Provider_Records_Matching.buildMatchTable(ing_matchRecs,ams_matchRecs);
		//set the HCID for ING records with ing matches
		filterCustomMatchING := dedup(custom_matching_logic(ingkey <> '' and matchID <> ''),acctno,ingkey);
		ing_providers_w_hcid := myFnING.doCustomMatchIng(ing_providers_rolled,filterCustomMatchING);
		ing_providers_w_hcid_final := project(ing_providers_w_hcid,transform(myLayouts.CombinedHeaderResults, 
																							self.hcid := if(left.hcid=0,left.srcid,left.hcid);self:=left));
		//set the HCID for AMS records with ing matches
		filterCustomMatchAMS := dedup(sort(custom_matching_logic(amskey <> '' and ingkey <> ''),acctno,amskey,(integer)ingkey),acctno,amskey);
		ams_providers_w_hcid := myFnAMS.doCustomMatchAMS(ams_providers_rolled,filterCustomMatchAMS);
		ams_providers_w_hcid_final := project(ams_providers_w_hcid,transform(myLayouts.CombinedHeaderResults, 
																							self.hcid := if(left.hcid=0,left.srcid,left.hcid);self:=left));
		//Combine the two primary search sources and then use other data if none exists
		combined_ing_ams := ing_providers_w_hcid_final + ams_providers_w_hcid_final;
		//If you have something from the two sources keep it, but if you don't and you have sanction data use it
		combined_final := map (isHeaderSearch=>consolidatedRecords,
													 exists(combined_ing_ams)=>combined_ing_ams,
													 consolidatedRecords);
		//Roll up the sources by HCID
		combined_final_sorted := sort(combined_final, acctno, HCID, map(src='I'=>1,src='A'=>2,3));
		combined_final_grouped := group(combined_final_sorted, acctno, HCID);
		results_rollup := rollup(combined_final_grouped(HCID > 0), group, myTransforms.doFinalRollup(left,rows(left)));
		//Return AMS ID numbers as providerid's if HCID has nothing else and assigning record level penalty
		results_combined := myFn.doPenalty(results_rollup,input,maxPenalty);
		acctnoWithNoHits := join(input,results_combined,left.acctno=right.acctno,left only);
		results_NPPES := join(nppes_providers_rolled,acctnoWithNoHits,left.acctno=right.acctno,transform(myLayouts.CombinedHeaderResults,self:=left));
		acctnoWithNoNPPESHits := join(acctnoWithNoHits,results_NPPES,left.acctno=right.acctno,left only);
		results_DeepDive := join(BocaHeader_rolled+BocaBusHeader_rolled,acctnoWithNoNPPESHits,left.acctno=right.acctno,transform(myLayouts.CombinedHeaderResults,self:=left));
		//Get DEA info for nohits
		getDeaInfo := dedup(sort(JOIN(acctnoWithNoHits(DEA <>'' or DEA2 <>''),dea.Key_dea_reg_num,keyed(left.dea= right.dea_registration_number or left.dea2= right.dea_registration_number),transform(mylayouts.pid_dea_rec, self.deanumber:=left.dea;self.expiration_date:=right.Expiration_Date;self :=left;self:=right;self:=[]),keep(myConst.MAX_RECS_ON_JOIN), limit(0)),acctno,providerid,deanumber,-Expiration_Date),acctno,providerid,deanumber,Expiration_Date);
		mylayouts.pid_dea_rec doRollDea(mylayouts.pid_dea_rec l, mylayouts.pid_dea_rec r) := TRANSFORM
			self.acctno := l.acctno;
			SELF.providerid := l.providerid;
			self.deanumber := trim(l.deanumber,all);
			self.deanumberTierTypeID := if(l.deanumberTierTypeID<r.deanumberTierTypeID,l.deanumberTierTypeID,r.deanumberTierTypeID);
			self.expiration_date := if(l.expiration_date <>'',l.expiration_date,r.expiration_date);
		END;
		f_dea_rollup := rollup(getDeaInfo,doRollDea(left,right),acctno,providerid,deanumber,Expiration_Date);
		dearesult:=project(f_dea_rollup, transform(mylayouts.layout_dea,
												self.acctno:=left.acctno;
												SELF.providerid := left.providerid;
												self.dea := trim(left.deanumber,all);
												self.expiration_date := left.expiration_date;
												self := []));
		mylayouts.layout_child_dea doRollup(mylayouts.layout_dea l, dataset(mylayouts.layout_dea) r) := TRANSFORM
			SELF.acctno := l.acctno;
			self.ProviderID := l.ProviderID;
			self.childinfo := r;
		END;
		dearesults_rolled := rollup(group(sort(dearesult,acctno,ProviderID),acctno),group,doRollup(left,rows(left)));
		results_NPPES_Final := dedup(sort(join(results_NPPES,dearesults_rolled, left.acctno=right.acctno,
																			transform(myLayouts.CombinedHeaderResults,
																								self.deas := right.childinfo;
																								self := left),left outer),record),record);
		results_DeepDive_Final :=  dedup(sort(join(results_DeepDive,dearesults_rolled, left.acctno=right.acctno,
																			transform(myLayouts.CombinedHeaderResults,
																								self.deas := right.childinfo;
																								self := left),left outer),record),record);
		// output(getPids,named('getPids'));
		// output(ing_pids,named('ing_pids'));
		// output(ing_providers_final,named('ing_providers_final'));
		// output(ing_providers_final_sorted,named('ing_providers_final_sorted'));
		// output(ing_providers_rolled,named('ing_providers_rolled'));
		// output(all_ams_pids,named('all_ams_pids'));
		// output(ams_providers_rolled,named('ams_providers_rolled'));
		// output(nppes_providers_final,named('nppes_providers_final'));
		// output(nppes_providers_rolled,named('nppes_providers_rolled'));
		// output(ing_matchRecs,named('ing_matchRecs'));
		// output(ams_matchRecs,named('ams_matchRecs'));
		// output(custom_matching_logic,named('MatchingLogic'));
		// output(ing_providers_w_hcid,named('ing_providers_w_hcid'));
		// output(ing_providers_w_hcid_final,named('ing_providers_w_hcid_final'));
		// output(ams_providers_w_hcid,named('ams_providers_w_hcid'));
		// output(ams_providers_w_hcid_final,named('ams_providers_w_hcid_final'));
		// output(combined_ing_ams,named('combined_ing_ams'));
		// output(combined_final_grouped,named('combined_final_grouped'));
		// output(results_rollup,named('results_rollup'));
		// output(results_combined,named('results_combined'));
		// output(acctnoWithNoHits,named('results_acctnoWithNoHits'));
		// output(results_NPPES,named('results_NPPES'));
		// output(acctnoWithNoNPPESHits,named('results_acctnoWithNoNPPESHits'));
		// output(results_NPPES_Final,named('results_NPPES_Final'));
		// output(results_DeepDive,named('results_DeepDive'));
		// output(results_DeepDive_Final,named('results_DeepDive_Final'));
		finalRecs := getRecordsAppend(input,results_combined+results_NPPES_Final+results_DeepDive_Final,maxPenalty,true,isHeaderSearch);
		return finalRecs;
	end;
	Export convertInputtoDatasetForAutoKeys (IParams.searchParams aInputData) := function
		prov_ids_byak := dedup(sort(Healthcare_Provider_Services.AutoKey_ids(aInputData).providers,record),record);
		prov_ids_byak_filterd := if(aInputData.CompanyName <> '', prov_ids_byak(isbdid = true),prov_ids_byak);
		cleanAddr := aInputData.addr <> '';
		testInput:=stringlib.StringFind(aInputData.addr,',',1);
		splitRaw1 := if(testInput>0,aInputData.addr[1..testInput-1],aInputData.addr);
		splitRaw2 := if(testInput>0,aInputData.addr[testInput+1..],'');
		tmpCity := If(aInputData.city ='' and aInputData.zip ='', 'ANYTOWN',aInputData.city);
		line2:=if(aInputData.City <>'' or aInputData.State <>'' or aInputData.Zip <>'',tmpCity+' '+aInputData.state+' '+aInputData.zip,splitRaw2);
		clnAddr := Address.CleanFields(Address.GetCleanAddress(splitRaw1,line2,address.Components.Country.US).str_addr);
		isBusiness := aInputData.CompanyName <> '';
		prov_recs := join(prov_ids_byak_filterd,Ingenix_NatlProf.Key_Provider_Payload,
										keyed(left.id=right.fakeid),
										transform(myLayouts.autokeyInput,
															self.acctno := '1';
															self.ProviderID:=if(not isBusiness,(integer)right.ProviderID,skip);
															self.ProviderSrc:=myConst.SRC_ING;
															self.comp_name := aInputData.CompanyName;
															self.name_first := aInputData.FirstName;
															self.name_middle := aInputData.MiddleName;
															self.name_last := aInputData.LastName;
															self.predir := if(cleanAddr and clnAddr.predir <> '',clnAddr.predir,aInputData.predir);
															self.prim_range := if(cleanAddr and clnAddr.prim_range <> '',clnAddr.prim_range,aInputData.prim_range);
															self.prim_name := if(cleanAddr and clnAddr.prim_name <> '',clnAddr.prim_name,aInputData.prim_name);
															self.addr_suffix := if(cleanAddr and clnAddr.addr_suffix <> '',clnAddr.addr_suffix,aInputData.suffix);
															self.postdir := if(cleanAddr and clnAddr.postdir <> '',clnAddr.postdir,aInputData.postdir);
															self.sec_range := if(cleanAddr and clnAddr.sec_range <> '',clnAddr.sec_range,aInputData.sec_range);
															self.p_city_name := if(cleanAddr and clnAddr.p_city_name <> '',clnAddr.p_city_name,aInputData.City);
															self.st := if(cleanAddr and clnAddr.st <> '',clnAddr.st,aInputData.State);
															self.z5 := if(cleanAddr and clnAddr.zip <> '',clnAddr.zip,aInputData.Zip);
															self.dob := (String)aInputData.dob;
															self.SSN := aInputData.SSN;
															self.NPI := aInputData.NPI;
															self.UPIN := aInputData.UPIN;
															self.DEA := aInputData.DEA;
															self.DEA2 := aInputData.DEA2;
															self.TAXID := aInputData.TaxID;
															self.FEIN := aInputData.FEIN;
															self.license_number := if(aInputData.LicenseNumber<>'',stringlib.StringToUpperCase(aInputData.LicenseNumber),stringlib.StringToUpperCase(aInputData.StateLicenses[1].LicenseNumber));
															self.license_state := if(aInputData.LicenseState<>'',stringlib.StringToUpperCase(aInputData.LicenseState),stringlib.StringToUpperCase(aInputData.StateLicenses[1].LicenseState));
															self.cliaNumber := aInputData.CLIANumber;
															self.did := if(aInputData.derivedLexID,0,(integer)aInputData.did);
															self.bdid := if(aInputData.derivedLexID,0,(integer)aInputData.bdid);
															self.CustomerID := aInputData.requestorCompanyID;
															self.OneStepRule := aInputData.OneStepRule;
															self.MedicalSchoolNameVerification := aInputData.MedicalSchoolName;
															self.GraduationYearVerification := aInputData.GraduationYear;
															Self.Taxonomy1Verification := aInputData.Taxonomy;
															Self.Taxonomy2Verification := aInputData.Taxonomy2;
															Self.Taxonomy3Verification := aInputData.Taxonomy3;
															Self.Taxonomy4Verification := aInputData.Taxonomy4;
															Self.Taxonomy5Verification := aInputData.Taxonomy5;
															Self.StateLicense1Verification := if(aInputData.LicenseNumber<>'',stringlib.StringToUpperCase(aInputData.LicenseNumber),stringlib.StringToUpperCase(aInputData.StateLicenses[1].LicenseNumber));
															Self.StateLicense1StateVerification := if(aInputData.LicenseState<>'',stringlib.StringToUpperCase(aInputData.LicenseState),stringlib.StringToUpperCase(aInputData.StateLicenses[1].LicenseState));
															Self.StateLicense2Verification := stringlib.StringToUpperCase(aInputData.StateLicenses[2].LicenseNumber);
															Self.StateLicense2StateVerification := stringlib.StringToUpperCase(aInputData.StateLicenses[2].LicenseState);
															Self.StateLicense3Verification := stringlib.StringToUpperCase(aInputData.StateLicenses[3].LicenseNumber);
															Self.StateLicense3StateVerification := stringlib.StringToUpperCase(aInputData.StateLicenses[3].LicenseState);
															Self.StateLicense4Verification := stringlib.StringToUpperCase(aInputData.StateLicenses[4].LicenseNumber);
															Self.StateLicense4StateVerification := stringlib.StringToUpperCase(aInputData.StateLicenses[4].LicenseState);
															Self.StateLicense5Verification := stringlib.StringToUpperCase(aInputData.StateLicenses[5].LicenseNumber);
															Self.StateLicense5StateVerification := stringlib.StringToUpperCase(aInputData.StateLicenses[5].LicenseState);
															Self.StateLicense6Verification := stringlib.StringToUpperCase(aInputData.StateLicenses[6].LicenseNumber);
															Self.StateLicense6StateVerification := stringlib.StringToUpperCase(aInputData.StateLicenses[6].LicenseState);
															Self.StateLicense7Verification := stringlib.StringToUpperCase(aInputData.StateLicenses[7].LicenseNumber);
															Self.StateLicense7StateVerification := stringlib.StringToUpperCase(aInputData.StateLicenses[7].LicenseState);
															Self.StateLicense8Verification := stringlib.StringToUpperCase(aInputData.StateLicenses[8].LicenseNumber);
															Self.StateLicense8StateVerification := stringlib.StringToUpperCase(aInputData.StateLicenses[8].LicenseState);
															Self.StateLicense9Verification := stringlib.StringToUpperCase(aInputData.StateLicenses[9].LicenseNumber);
															Self.StateLicense9StateVerification := stringlib.StringToUpperCase(aInputData.StateLicenses[9].LicenseState);
															Self.StateLicense10Verification := stringlib.StringToUpperCase(aInputData.StateLicenses[10].LicenseNumber);
															Self.StateLicense10StateVerification := stringlib.StringToUpperCase(aInputData.StateLicenses[10].LicenseState);
															self.IncludeSanctions := aInputData.IncludeSanctions;
															self.includeCustomerData := aInputData.includeCustomerData;
															self.IncludeABMSSpecialty := aInputData.IncludeBoardCertifiedSpecialty;
															self.IncludeABMSCareer := aInputData.IncludeCareer;
															self.IncludeABMSEducation := aInputData.IncludeEducation;
															self.IncludeABMSProfessionalAssociations := aInputData.IncludeProfessionalAssociations;
															self.isExactAddressMatch:=true;
															self.derivedInputRecord := true;
															self.IncludeAllSources := aInputData.IncludeAllSources;
															self.IncludeSourceIngenix := aInputData.IncludeSourceIngenix;
															self.IncludeSourceAMS := aInputData.IncludeSourceAMS;
															self.IncludeSourceNPPES := aInputData.IncludeSourceNPPES;
															self.IncludeSourceDEA := aInputData.IncludeSourceDEA;
															self.IncludeSourceProfLic := aInputData.IncludeSourceProfLic;
															self.IncludeSourceSelectFile := aInputData.IncludeSourceSelectFile;
															self.IncludeSourceCLIA := aInputData.IncludeSourceCLIA;
															self.IncludeSourceABMS := aInputData.IncludeSourceABMS;
															self.IncludeSourceNCPDP := aInputData.IncludeSourceNCPDP;
															self.isReport:=aInputData.isReport;self:=[]),
										keep(myConst.MAX_RECS_ON_JOIN),limit(0));		
		ams_ids_byak := dedup(sort(Healthcare_Provider_Services.AutoKey_ids(aInputData).ams,record),record);
		ams_ids_byak_filterd := if(aInputData.CompanyName <> '', ams_ids_byak(isbdid = true),ams_ids_byak);
		ams_recs := join(ams_ids_byak_filterd,AMS.Key_Autokey_Payload,
										keyed(left.id=right.fakeid),
										transform(myLayouts.autokeyInput,
															self.acctno := '1';
															self.ProviderID:=if(not isBusiness,(integer)right.ams_id,skip);
															self.ProviderSrc:=myConst.SRC_AMS;
															self.comp_name := aInputData.CompanyName;
															self.name_first := aInputData.FirstName;
															self.name_middle := aInputData.MiddleName;
															self.name_last := aInputData.LastName;
															self.predir := if(cleanAddr and clnAddr.predir <> '',clnAddr.predir,aInputData.predir);
															self.prim_range := if(cleanAddr and clnAddr.prim_range <> '',clnAddr.prim_range,aInputData.prim_range);
															self.prim_name := if(cleanAddr and clnAddr.prim_name <> '',clnAddr.prim_name,aInputData.prim_name);
															self.addr_suffix := if(cleanAddr and clnAddr.addr_suffix <> '',clnAddr.addr_suffix,aInputData.suffix);
															self.postdir := if(cleanAddr and clnAddr.postdir <> '',clnAddr.postdir,aInputData.postdir);
															self.sec_range := if(cleanAddr and clnAddr.sec_range <> '',clnAddr.sec_range,aInputData.sec_range);
															self.p_city_name := if(cleanAddr and clnAddr.p_city_name <> '',clnAddr.p_city_name,aInputData.City);
															self.st := if(cleanAddr and clnAddr.st <> '',clnAddr.st,aInputData.State);
															self.z5 := if(cleanAddr and clnAddr.zip <> '',clnAddr.zip,aInputData.Zip);
															self.dob := (String)aInputData.dob;
															self.SSN := aInputData.SSN;
															self.NPI := aInputData.NPI;
															self.UPIN := aInputData.UPIN;
															self.DEA := aInputData.DEA;
															self.DEA2 := aInputData.DEA2;
															self.TAXID := aInputData.TaxID;
															self.FEIN := aInputData.FEIN;
															self.license_number := if(aInputData.LicenseNumber<>'',stringlib.StringToUpperCase(aInputData.LicenseNumber),stringlib.StringToUpperCase(aInputData.StateLicenses[1].LicenseNumber));
															self.license_state := if(aInputData.LicenseState<>'',stringlib.StringToUpperCase(aInputData.LicenseState),stringlib.StringToUpperCase(aInputData.StateLicenses[1].LicenseState));
															self.cliaNumber := aInputData.CLIANumber;
															self.did := if(aInputData.derivedLexID,0,(integer)aInputData.did);
															self.bdid := if(aInputData.derivedLexID,0,(integer)aInputData.bdid);
															self.CustomerID := aInputData.requestorCompanyID;
															self.OneStepRule := aInputData.OneStepRule;
															self.MedicalSchoolNameVerification := aInputData.MedicalSchoolName;
															self.GraduationYearVerification := aInputData.GraduationYear;
															Self.Taxonomy1Verification := aInputData.Taxonomy;
															Self.Taxonomy2Verification := aInputData.Taxonomy2;
															Self.Taxonomy3Verification := aInputData.Taxonomy3;
															Self.Taxonomy4Verification := aInputData.Taxonomy4;
															Self.Taxonomy5Verification := aInputData.Taxonomy5;
															Self.StateLicense1Verification := if(aInputData.LicenseNumber<>'',stringlib.StringToUpperCase(aInputData.LicenseNumber),stringlib.StringToUpperCase(aInputData.StateLicenses[1].LicenseNumber));
															Self.StateLicense1StateVerification := if(aInputData.LicenseState<>'',stringlib.StringToUpperCase(aInputData.LicenseState),stringlib.StringToUpperCase(aInputData.StateLicenses[1].LicenseState));
															Self.StateLicense2Verification := stringlib.StringToUpperCase(aInputData.StateLicenses[2].LicenseNumber);
															Self.StateLicense2StateVerification := stringlib.StringToUpperCase(aInputData.StateLicenses[2].LicenseState);
															Self.StateLicense3Verification := stringlib.StringToUpperCase(aInputData.StateLicenses[3].LicenseNumber);
															Self.StateLicense3StateVerification := stringlib.StringToUpperCase(aInputData.StateLicenses[3].LicenseState);
															Self.StateLicense4Verification := stringlib.StringToUpperCase(aInputData.StateLicenses[4].LicenseNumber);
															Self.StateLicense4StateVerification := stringlib.StringToUpperCase(aInputData.StateLicenses[4].LicenseState);
															Self.StateLicense5Verification := stringlib.StringToUpperCase(aInputData.StateLicenses[5].LicenseNumber);
															Self.StateLicense5StateVerification := stringlib.StringToUpperCase(aInputData.StateLicenses[5].LicenseState);
															Self.StateLicense6Verification := stringlib.StringToUpperCase(aInputData.StateLicenses[6].LicenseNumber);
															Self.StateLicense6StateVerification := stringlib.StringToUpperCase(aInputData.StateLicenses[6].LicenseState);
															Self.StateLicense7Verification := stringlib.StringToUpperCase(aInputData.StateLicenses[7].LicenseNumber);
															Self.StateLicense7StateVerification := stringlib.StringToUpperCase(aInputData.StateLicenses[7].LicenseState);
															Self.StateLicense8Verification := stringlib.StringToUpperCase(aInputData.StateLicenses[8].LicenseNumber);
															Self.StateLicense8StateVerification := stringlib.StringToUpperCase(aInputData.StateLicenses[8].LicenseState);
															Self.StateLicense9Verification := stringlib.StringToUpperCase(aInputData.StateLicenses[9].LicenseNumber);
															Self.StateLicense9StateVerification := stringlib.StringToUpperCase(aInputData.StateLicenses[9].LicenseState);
															Self.StateLicense10Verification := stringlib.StringToUpperCase(aInputData.StateLicenses[10].LicenseNumber);
															Self.StateLicense10StateVerification := stringlib.StringToUpperCase(aInputData.StateLicenses[10].LicenseState);
															self.IncludeSanctions := aInputData.IncludeSanctions;
															self.includeCustomerData := aInputData.includeCustomerData;
															self.IncludeABMSSpecialty := aInputData.IncludeBoardCertifiedSpecialty;
															self.IncludeABMSCareer := aInputData.IncludeCareer;
															self.IncludeABMSEducation := aInputData.IncludeEducation;
															self.IncludeABMSProfessionalAssociations := aInputData.IncludeProfessionalAssociations;
															self.isExactAddressMatch:=true;
															self.derivedInputRecord := true;
															self.IncludeAllSources := aInputData.IncludeAllSources;
															self.IncludeSourceIngenix := aInputData.IncludeSourceIngenix;
															self.IncludeSourceAMS := aInputData.IncludeSourceAMS;
															self.IncludeSourceNPPES := aInputData.IncludeSourceNPPES;
															self.IncludeSourceDEA := aInputData.IncludeSourceDEA;
															self.IncludeSourceProfLic := aInputData.IncludeSourceProfLic;
															self.IncludeSourceSelectFile := aInputData.IncludeSourceSelectFile;
															self.IncludeSourceCLIA := aInputData.IncludeSourceCLIA;
															self.IncludeSourceABMS := aInputData.IncludeSourceABMS;
															self.IncludeSourceNCPDP := aInputData.IncludeSourceNCPDP;
															self.isReport:=aInputData.isReport;self:=[]),
										keep(myConst.MAX_RECS_ON_JOIN),limit(0));		
		sanc_ids_byak := dedup(sort(Healthcare_Provider_Services.AutoKey_ids(aInputData).sanctions,record),record);
		Sanc_recs := join(sanc_ids_byak,Ingenix_NatlProf.Key_Sanctions_Payload,
										keyed(left.id=right.fakeid),
										transform(myLayouts.autokeyInput, 
															self.acctno := '1';
															self.ProviderID := (integer)right.sanc_id;
															self.ProviderSrc:=myConst.SRC_SANC;
															closematch1:= if(right.sanc_busnme<>'',ut.CompanySimilar100(right.sanc_busnme,aInputData.CompanyName),1000);
															closematch2:= if(right.sanc_busnme<>'',ut.CompanySimilar100(right.sanc_busnme[1..10],aInputData.CompanyName[1..10]),1000);
															bestmatch := if(closematch1<closematch2,closematch1,closematch2);
															self.comp_name := if(isBusiness,if(bestmatch<=Constants.BUS_NAME_MATCH_THRESHOLD,aInputData.CompanyName,skip),aInputData.CompanyName);
															self.name_first := aInputData.FirstName;
															self.name_middle := aInputData.MiddleName;
															self.name_last := aInputData.LastName;
															self.predir := if(cleanAddr and clnAddr.predir <> '',clnAddr.predir,aInputData.predir);
															self.prim_range := if(cleanAddr and clnAddr.prim_range <> '',clnAddr.prim_range,aInputData.prim_range);
															self.prim_name := if(cleanAddr and clnAddr.prim_name <> '',clnAddr.prim_name,aInputData.prim_name);
															self.addr_suffix := if(cleanAddr and clnAddr.addr_suffix <> '',clnAddr.addr_suffix,aInputData.suffix);
															self.postdir := if(cleanAddr and clnAddr.postdir <> '',clnAddr.postdir,aInputData.postdir);
															self.sec_range := if(cleanAddr and clnAddr.sec_range <> '',clnAddr.sec_range,aInputData.sec_range);
															self.p_city_name := if(cleanAddr and clnAddr.p_city_name <> '',clnAddr.p_city_name,aInputData.City);
															self.st := if(cleanAddr and clnAddr.st <> '',clnAddr.st,aInputData.State);
															self.z5 := if(cleanAddr and clnAddr.zip <> '',clnAddr.zip,aInputData.Zip);
															self.dob := (String)aInputData.dob;
															self.SSN := aInputData.SSN;
															self.NPI := aInputData.NPI;
															self.UPIN := aInputData.UPIN;
															self.DEA := aInputData.DEA;
															self.DEA2 := aInputData.DEA2;
															self.TAXID := aInputData.TaxID;
															self.FEIN := aInputData.FEIN;
															self.license_number := if(aInputData.LicenseNumber<>'',stringlib.StringToUpperCase(aInputData.LicenseNumber),stringlib.StringToUpperCase(aInputData.StateLicenses[1].LicenseNumber));
															self.license_state := if(aInputData.LicenseState<>'',stringlib.StringToUpperCase(aInputData.LicenseState),stringlib.StringToUpperCase(aInputData.StateLicenses[1].LicenseState));
															self.cliaNumber := aInputData.CLIANumber;
															self.did := if(aInputData.derivedLexID,0,(integer)aInputData.did);
															self.bdid := if(aInputData.derivedLexID,0,(integer)aInputData.bdid);
															self.CustomerID := aInputData.requestorCompanyID;
															self.OneStepRule := aInputData.OneStepRule;
															self.MedicalSchoolNameVerification := aInputData.MedicalSchoolName;
															self.GraduationYearVerification := aInputData.GraduationYear;
															Self.Taxonomy1Verification := aInputData.Taxonomy;
															Self.Taxonomy2Verification := aInputData.Taxonomy2;
															Self.Taxonomy3Verification := aInputData.Taxonomy3;
															Self.Taxonomy4Verification := aInputData.Taxonomy4;
															Self.Taxonomy5Verification := aInputData.Taxonomy5;
															Self.StateLicense1Verification := if(aInputData.LicenseNumber<>'',stringlib.StringToUpperCase(aInputData.LicenseNumber),stringlib.StringToUpperCase(aInputData.StateLicenses[1].LicenseNumber));
															Self.StateLicense1StateVerification := if(aInputData.LicenseState<>'',stringlib.StringToUpperCase(aInputData.LicenseState),stringlib.StringToUpperCase(aInputData.StateLicenses[1].LicenseState));
															Self.StateLicense2Verification := stringlib.StringToUpperCase(aInputData.StateLicenses[2].LicenseNumber);
															Self.StateLicense2StateVerification := stringlib.StringToUpperCase(aInputData.StateLicenses[2].LicenseState);
															Self.StateLicense3Verification := stringlib.StringToUpperCase(aInputData.StateLicenses[3].LicenseNumber);
															Self.StateLicense3StateVerification := stringlib.StringToUpperCase(aInputData.StateLicenses[3].LicenseState);
															Self.StateLicense4Verification := stringlib.StringToUpperCase(aInputData.StateLicenses[4].LicenseNumber);
															Self.StateLicense4StateVerification := stringlib.StringToUpperCase(aInputData.StateLicenses[4].LicenseState);
															Self.StateLicense5Verification := stringlib.StringToUpperCase(aInputData.StateLicenses[5].LicenseNumber);
															Self.StateLicense5StateVerification := stringlib.StringToUpperCase(aInputData.StateLicenses[5].LicenseState);
															Self.StateLicense6Verification := stringlib.StringToUpperCase(aInputData.StateLicenses[6].LicenseNumber);
															Self.StateLicense6StateVerification := stringlib.StringToUpperCase(aInputData.StateLicenses[6].LicenseState);
															Self.StateLicense7Verification := stringlib.StringToUpperCase(aInputData.StateLicenses[7].LicenseNumber);
															Self.StateLicense7StateVerification := stringlib.StringToUpperCase(aInputData.StateLicenses[7].LicenseState);
															Self.StateLicense8Verification := stringlib.StringToUpperCase(aInputData.StateLicenses[8].LicenseNumber);
															Self.StateLicense8StateVerification := stringlib.StringToUpperCase(aInputData.StateLicenses[8].LicenseState);
															Self.StateLicense9Verification := stringlib.StringToUpperCase(aInputData.StateLicenses[9].LicenseNumber);
															Self.StateLicense9StateVerification := stringlib.StringToUpperCase(aInputData.StateLicenses[9].LicenseState);
															Self.StateLicense10Verification := stringlib.StringToUpperCase(aInputData.StateLicenses[10].LicenseNumber);
															Self.StateLicense10StateVerification := stringlib.StringToUpperCase(aInputData.StateLicenses[10].LicenseState);
															self.IncludeSanctions := aInputData.IncludeSanctions;
															self.includeCustomerData := aInputData.includeCustomerData;
															self.IncludeABMSSpecialty := aInputData.IncludeBoardCertifiedSpecialty;
															self.IncludeABMSCareer := aInputData.IncludeCareer;
															self.IncludeABMSEducation := aInputData.IncludeEducation;
															self.IncludeABMSProfessionalAssociations := aInputData.IncludeProfessionalAssociations;
															self.isExactAddressMatch:=true;
															self.derivedInputRecord := true;
															self.IncludeAllSources := aInputData.IncludeAllSources;
															self.IncludeSourceIngenix := aInputData.IncludeSourceIngenix;
															self.IncludeSourceAMS := aInputData.IncludeSourceAMS;
															self.IncludeSourceNPPES := aInputData.IncludeSourceNPPES;
															self.IncludeSourceDEA := aInputData.IncludeSourceDEA;
															self.IncludeSourceProfLic := aInputData.IncludeSourceProfLic;
															self.IncludeSourceSelectFile := aInputData.IncludeSourceSelectFile;
															self.IncludeSourceCLIA := aInputData.IncludeSourceCLIA;
															self.IncludeSourceABMS := aInputData.IncludeSourceABMS;
															self.IncludeSourceNCPDP := aInputData.IncludeSourceNCPDP;
															self.isReport:=aInputData.isReport;self:=[]),
										keep(myConst.MAX_RECS_ON_JOIN),limit(0));
		convertedInput:=choosen(dedup(sort(prov_recs+ams_recs+Sanc_recs,record),record),myConst.MAX_SEARCH_RESULTS);
		return convertedInput;
	end;
	Export getRecordsByAutoKeys (IParams.searchParams aInputData,boolean isHeaderSearch = false) := function
		convertedInput:=convertInputtoDatasetForAutoKeys(aInputData);
		provRec:=getRecordsRaw(convertedInput,aInputData.penalty_threshold,isHeaderSearch);
		return provRec;
	end;
	Export getSearchServiceRecords (IParams.searchParams aInputData,boolean isHeaderSearch = false) := function
		convertedInput := convertInputtoDataset(aInputData);
		convertedInput2:= convertInputtoDatasetForAutoKeys(aInputData);
		convertedInputFinal := if(isHeaderSearch,convertedInput,convertedInput+convertedInput2);
		rawRecs:=sort(dedup(sort(getRecordsRawDoxie(convertedInputFinal,aInputData.penalty_threshold,true,isHeaderSearch),acctno, HCID,map(src='I'=>1,src='A'=>2,3)),acctno, HCID),acctno,record_penalty);
		provRec:=project(rawRecs,Healthcare_Provider_Services.Transforms.formatSearchServiceProviderOutput(left,convertedInput,aInputData));
		return provRec;
	end;
	Export fmtRecordsSearch (dataset(myLayouts.CombinedHeaderResults) rawRecs) := function
		return project(rawRecs,myTransforms.fmtLegacySearch(left));
	end;

End;