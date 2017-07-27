import iesp,ABMS,Autokey_batch,STD,Healthcare_Shared,Healthcare_ABMS;
export Raw := module
	Export ids_by_did (dataset(Healthcare_ABMS.Layouts.autokeyInput) input):= function
			return choosen(dedup(sort(join(input(did>0), ABMS.Keys().Main.DID.qa,
																				 left.did=right.did, 
																				 transform(Healthcare_ABMS.Layouts.searchKeyResults,self.acctno:=left.acctno; self.biog_number:=right.biog_number;self.isAutokeysResult:=false;self:=left;),
																				 keep(Healthcare_ABMS.Constants.MAX_RECS_ON_JOIN),limit(0)),record),record),Healthcare_ABMS.Constants.MAX_RECS_ON_JOIN);
	end;
	Export ids_by_bdid (dataset(Healthcare_ABMS.Layouts.autokeyInput) input):= function
			return choosen(dedup(sort(join(input(bdid>0), ABMS.Keys().Main.BDID.qa,
																				 left.bdid=right.bdid, 
																				 transform(Healthcare_ABMS.Layouts.searchKeyResults,self.acctno:=left.acctno; self.biog_number:=right.biog_number;self.isAutokeysResult:=false;self:=left;),
																				 keep(Healthcare_ABMS.Constants.MAX_RECS_ON_JOIN),limit(0)),record),record),Healthcare_ABMS.Constants.MAX_RECS_ON_JOIN);
	end;
	Export ids_by_npi (dataset(Healthcare_ABMS.Layouts.autokeyInput) input):= function
			return choosen(dedup(sort(join(input(npi<>''), ABMS.Keys().Main.NPI.qa,
																				 left.npi=right.npi, 
																				 transform(Healthcare_ABMS.Layouts.searchKeyResults,self.acctno:=left.acctno; self.biog_number:=right.biog_number;self.isAutokeysResult:=false;self:=left;),
																				 keep(Healthcare_ABMS.Constants.MAX_RECS_ON_JOIN),limit(0)),record),record),Healthcare_ABMS.Constants.MAX_RECS_ON_JOIN);
	end;
	Export ids_by_NameAndSpecialty (dataset(Healthcare_ABMS.Layouts.autokeyInput) input):= function
			//Check for hits based on multiple Specialty
			specialty1 := choosen(dedup(sort(join(input(Specialty<>''), ABMS.Keys().Main.LNameCertFName.qa,
																				 STD.Str.ToUpperCase(left.name_last)=right.last_name and
																				 STD.Str.ToUpperCase(left.Specialty)=right.cert_name, 
																				 transform(Healthcare_ABMS.Layouts.searchKeyResults,self.acctno:=left.acctno; self.biog_number:=right.biog_number;self.isAutokeysResult:=false;self:=left;),
																				 keep(Healthcare_ABMS.Constants.MAX_RECS_ON_JOIN),limit(0)),record),record),Healthcare_ABMS.Constants.MAX_RECS_ON_JOIN);
			specialty2 := choosen(dedup(sort(join(input(Specialty2<>''), ABMS.Keys().Main.LNameCertFName.qa,
																				 STD.Str.ToUpperCase(left.name_last)=right.last_name and
																				 STD.Str.ToUpperCase(left.Specialty)=right.cert_name, 
																				 transform(Healthcare_ABMS.Layouts.searchKeyResults,self.acctno:=left.acctno; self.biog_number:=right.biog_number;self.isAutokeysResult:=false;self:=left;),
																				 keep(Healthcare_ABMS.Constants.MAX_RECS_ON_JOIN),limit(0)),record),record),Healthcare_ABMS.Constants.MAX_RECS_ON_JOIN);
			specialty3 := choosen(dedup(sort(join(input(Specialty3<>''), ABMS.Keys().Main.LNameCertFName.qa,
																				 STD.Str.ToUpperCase(left.name_last)=right.last_name and
																				 STD.Str.ToUpperCase(left.Specialty)=right.cert_name, 
																				 transform(Healthcare_ABMS.Layouts.searchKeyResults,self.acctno:=left.acctno; self.biog_number:=right.biog_number;self.isAutokeysResult:=false;self:=left;),
																				 keep(Healthcare_ABMS.Constants.MAX_RECS_ON_JOIN),limit(0)),record),record),Healthcare_ABMS.Constants.MAX_RECS_ON_JOIN);
			specialty4 := choosen(dedup(sort(join(input(Specialty4<>''), ABMS.Keys().Main.LNameCertFName.qa,
																				 STD.Str.ToUpperCase(left.name_last)=right.last_name and
																				 STD.Str.ToUpperCase(left.Specialty)=right.cert_name, 
																				 transform(Healthcare_ABMS.Layouts.searchKeyResults,self.acctno:=left.acctno; self.biog_number:=right.biog_number;self.isAutokeysResult:=false;self:=left;),
																				 keep(Healthcare_ABMS.Constants.MAX_RECS_ON_JOIN),limit(0)),record),record),Healthcare_ABMS.Constants.MAX_RECS_ON_JOIN);
			specialty5 := choosen(dedup(sort(join(input(Specialty5<>''), ABMS.Keys().Main.LNameCertFName.qa,
																				 STD.Str.ToUpperCase(left.name_last)=right.last_name and
																				 STD.Str.ToUpperCase(left.Specialty)=right.cert_name, 
																				 transform(Healthcare_ABMS.Layouts.searchKeyResults,self.acctno:=left.acctno; self.biog_number:=right.biog_number;self.isAutokeysResult:=false;self:=left;),
																				 keep(Healthcare_ABMS.Constants.MAX_RECS_ON_JOIN),limit(0)),record),record),Healthcare_ABMS.Constants.MAX_RECS_ON_JOIN);
			combinedSpecialty := choosen(dedup(sort(specialty1+specialty2+specialty3+specialty4+specialty5,record),record),Healthcare_ABMS.Constants.MAX_RECS_ON_JOIN);
			return combinedSpecialty;
	end;
	Export ids_by_NameAndSubSpecialty (dataset(Healthcare_ABMS.Layouts.autokeyInput) input):= function
			//Check for hits based on multiple sub Specialty
			subspecialty1 := choosen(dedup(sort(join(input(SubSpecialty<>''), ABMS.Keys().Main.LNameCertFName.qa,
																				 STD.Str.ToUpperCase(left.name_last)=right.last_name and
																				 STD.Str.ToUpperCase(left.Specialty)=right.cert_name, 
																				 transform(Healthcare_ABMS.Layouts.searchKeyResults,self.acctno:=left.acctno; self.biog_number:=right.biog_number;self.isAutokeysResult:=false;self:=left;),
																				 keep(Healthcare_ABMS.Constants.MAX_RECS_ON_JOIN),limit(0)),record),record),Healthcare_ABMS.Constants.MAX_RECS_ON_JOIN);
			subspecialty2 := choosen(dedup(sort(join(input(SubSpecialty2<>''), ABMS.Keys().Main.LNameCertFName.qa,
																				 STD.Str.ToUpperCase(left.name_last)=right.last_name and
																				 STD.Str.ToUpperCase(left.Specialty)=right.cert_name, 
																				 transform(Healthcare_ABMS.Layouts.searchKeyResults,self.acctno:=left.acctno; self.biog_number:=right.biog_number;self.isAutokeysResult:=false;self:=left;),
																				 keep(Healthcare_ABMS.Constants.MAX_RECS_ON_JOIN),limit(0)),record),record),Healthcare_ABMS.Constants.MAX_RECS_ON_JOIN);
			subspecialty3 := choosen(dedup(sort(join(input(SubSpecialty3<>''), ABMS.Keys().Main.LNameCertFName.qa,
																				 STD.Str.ToUpperCase(left.name_last)=right.last_name and
																				 STD.Str.ToUpperCase(left.Specialty)=right.cert_name, 
																				 transform(Healthcare_ABMS.Layouts.searchKeyResults,self.acctno:=left.acctno; self.biog_number:=right.biog_number;self.isAutokeysResult:=false;self:=left;),
																				 keep(Healthcare_ABMS.Constants.MAX_RECS_ON_JOIN),limit(0)),record),record),Healthcare_ABMS.Constants.MAX_RECS_ON_JOIN);
			subspecialty4 := choosen(dedup(sort(join(input(SubSpecialty4<>''), ABMS.Keys().Main.LNameCertFName.qa,
																				 STD.Str.ToUpperCase(left.name_last)=right.last_name and
																				 STD.Str.ToUpperCase(left.Specialty)=right.cert_name, 
																				 transform(Healthcare_ABMS.Layouts.searchKeyResults,self.acctno:=left.acctno; self.biog_number:=right.biog_number;self.isAutokeysResult:=false;self:=left;),
																				 keep(Healthcare_ABMS.Constants.MAX_RECS_ON_JOIN),limit(0)),record),record),Healthcare_ABMS.Constants.MAX_RECS_ON_JOIN);
			subspecialty5 := choosen(dedup(sort(join(input(SubSpecialty5<>''), ABMS.Keys().Main.LNameCertFName.qa,
																				 STD.Str.ToUpperCase(left.name_last)=right.last_name and
																				 STD.Str.ToUpperCase(left.Specialty)=right.cert_name, 
																				 transform(Healthcare_ABMS.Layouts.searchKeyResults,self.acctno:=left.acctno; self.biog_number:=right.biog_number;self.isAutokeysResult:=false;self:=left;),
																				 keep(Healthcare_ABMS.Constants.MAX_RECS_ON_JOIN),limit(0)),record),record),Healthcare_ABMS.Constants.MAX_RECS_ON_JOIN);
			combinedSubSpecialty := choosen(dedup(sort(subspecialty1+subspecialty2+subspecialty3+subspecialty4+subspecialty5,record),record),Healthcare_ABMS.Constants.MAX_RECS_ON_JOIN);
			return combinedSubSpecialty;
	end;
	Export Healthcare_ABMS.Layouts.searchKeyResults xformLimit(Healthcare_ABMS.Layouts.searchKeyResults l, integer cnt) := transform
		limitNameOnlyAutoKeySearch := (l.name_last <> '' or l.comp_name <> '') and l.prim_name='' and l.p_city_name='' and l.st ='' and l.z5 = '';
		cntLimit := if(limitNameOnlyAutoKeySearch,Healthcare_ABMS.Constants.MAX_NAMEONLY_AUTOKEY_SEARCH_RECS,Healthcare_ABMS.Constants.MAX_AUTOKEY_SEARCH_RECS);
		self.acctno:=if(cnt>cntLimit, skip, l.acctno);
		self:=l;
	end;
	Export ids_by_ak (dataset(Healthcare_ABMS.Layouts.autokeyInput) input):= function
			fmtInput := project(input,transform(Healthcare_Shared.Layouts.autokeyInput, 
																	self.name_first := STD.Str.ToUpperCase(left.name_first);
																	self.name_middle := STD.Str.ToUpperCase(left.name_middle);
																	self.name_last := STD.Str.ToUpperCase(left.name_last);
																	self.name_suffix := STD.Str.ToUpperCase(left.name_suffix);
																	self.prim_range := STD.Str.ToUpperCase(left.prim_range);
																	self.predir := STD.Str.ToUpperCase(left.predir);
																	self.prim_name := STD.Str.ToUpperCase(left.prim_name);
																	self.addr_suffix := STD.Str.ToUpperCase(left.addr_suffix);
																	self.postdir := STD.Str.ToUpperCase(left.postdir);
																	self.unit_desig := STD.Str.ToUpperCase(left.unit_desig);
																	self.sec_range := STD.Str.ToUpperCase(left.sec_range);
																	self.p_city_name := STD.Str.ToUpperCase(left.p_city_name);
																	self.st := STD.Str.ToUpperCase(left.st);
																	self.comp_name := STD.Str.ToUpperCase(left.comp_name);
																	self.NPI := STD.Str.ToUpperCase(left.NPI);	
																	self := left));
			results:=dedup(sort(project(Healthcare_ABMS.Fn_get_autokeys(fmtInput).abms_autokeys,transform(Healthcare_ABMS.Layouts.searchKeyResults,self.acctno:=left.acctno;self.biog_number:=left.biog_number;self.isAutokeysResult:=true;self:=left;)),record),record);
			noHits:=join(input,results,left.acctno=right.acctno,left only);
			refmtInput := project(input,transform(Healthcare_Shared.Layouts.autokeyInput, 
																	self.name_first := STD.Str.ToUpperCase(left.name_last);
																	self.name_middle := STD.Str.ToUpperCase(left.name_middle);
																	self.name_last := STD.Str.ToUpperCase(left.name_first);
																	self.name_suffix := STD.Str.ToUpperCase(left.name_suffix);
																	self.prim_range := STD.Str.ToUpperCase(left.prim_range);
																	self.predir := STD.Str.ToUpperCase(left.predir);
																	self.prim_name := STD.Str.ToUpperCase(left.prim_name);
																	self.addr_suffix := STD.Str.ToUpperCase(left.addr_suffix);
																	self.postdir := STD.Str.ToUpperCase(left.postdir);
																	self.unit_desig := STD.Str.ToUpperCase(left.unit_desig);
																	self.sec_range := STD.Str.ToUpperCase(left.sec_range);
																	self.p_city_name := STD.Str.ToUpperCase(left.p_city_name);
																	self.st := STD.Str.ToUpperCase(left.st);
																	self.comp_name := STD.Str.ToUpperCase(left.comp_name);
																	self.NPI := STD.Str.ToUpperCase(left.NPI);	
																	self := left));
			results2:=dedup(sort(project(Healthcare_ABMS.Fn_get_autokeys(refmtInput).abms_autokeys,transform(Healthcare_ABMS.Layouts.searchKeyResults,self.acctno:=left.acctno;self.biog_number:=left.biog_number;self.isAutokeysResult:=true;self:=left;)),record),record);
			results_final := sort(join(input,results+results2,left.acctno=right.acctno,transform(Healthcare_ABMS.Layouts.searchKeyResults, self:=left,self:=right;),keep(Healthcare_ABMS.Constants.MAX_RECS_ON_JOIN),limit(0)),acctno);
			return ungroup(project(group(results_final,acctno),xformLimit(left,counter)));
	end;
	Export getBiogNumbers(dataset(Healthcare_ABMS.Layouts.autokeyInput) inputData) := function
		ids_by_biog_number := project(inputData(ProviderID>0),transform(Healthcare_ABMS.Layouts.searchKeyResults,self.acctno:=left.acctno; self.biog_number:=(string)left.ProviderID;self.isAutokeysResult:=false;self:=left;));
		ids_by_keys := dedup(sort(ids_by_did(inputData)+ids_by_bdid(inputData)+ids_by_npi(inputData)+ids_by_NameAndSpecialty(inputData)+ids_by_NameAndSubSpecialty(inputData)+ids_by_biog_number,record),record);
		getNoHits := join(inputData,ids_by_keys,left.acctno=right.acctno,transform(Healthcare_ABMS.Layouts.autokeyInput,self:=left),left only);
		byAK := ids_by_ak(getNoHits);
		final_recs := ids_by_keys+byAK;
		return final_recs;
	end;


	Export getRecords(dataset(Healthcare_ABMS.Layouts.autokeyInput) inputData, unsigned1 glb=8, unsigned1 dppa=0, unsigned2 PenaltThreshold=10) := function
		//Get BIOG_NUMBERS that match input criteria....
		ids := getBiogNumbers(inputData);
		//Get Base data records
		baseRecs := join(ids,ABMS.Keys().Main.BIOGNumber.qa,left.biog_number=right.biog_number,
													Healthcare_ABMS.Transforms.buildBase(left,right,PenaltThreshold),
													keep(Healthcare_ABMS.Constants.MAX_RECS_ON_JOIN),limit(0));
		//Rollup and dedup by biog_number
		grp_baseRecs := group(sort(baseRecs,AccountNumber,ABMSBiogID),AccountNumber,ABMSBiogID);
		roll_baseRecs := rollup(grp_baseRecs,group,Healthcare_ABMS.Transforms.doABMSBiogIDRollup(left,rows(left)));
		//Join to get Type of Practice Information
		appendBaseWithType := Healthcare_ABMS.Functions.appendTypeOfPractice(roll_baseRecs);
		//Join to get Certificates Information
		appendBaseWithCertificates := Healthcare_ABMS.Functions.appendCertificates(appendBaseWithType);
		//Get optional data
		appendOptionalData := Healthcare_ABMS.Functions.appendOptionalData(appendBaseWithCertificates,inputData);
		// output(inputData,named('inputData'));
		// output(ids,named('CollectedIDs'));
		// output(baseRecs,named('baseRecs'));
		// output(roll_baseRecs,named('roll_baseRecs'));
		// output(appendBaseWithType,named('appendBaseWithType'));
		// output(appendBaseWithCertificates,named('appendBaseWithCertificates'));
		return sort(appendOptionalData,_Penalty);
	end;
	Export getRecordsBatch(dataset(Healthcare_ABMS.Layouts.autokeyInput) inputData,unsigned1 glb=8, unsigned1 dppa=0, unsigned2 PenaltThreshold=10) := function
		recs := getRecords(inputData);
		recsWithBatchCertificates := Healthcare_ABMS.Functions.appendBatchCertificates(recs);
		fmtRecs:=project(recsWithBatchCertificates,Healthcare_ABMS.Transforms.fmtBatchResults(left));
		setflags:=join(inputData,fmtRecs,left.acctno=right.acctno,Healthcare_ABMS.Transforms.setBatchResultsFlags(left,right),keep(Healthcare_ABMS.Constants.MAX_RECS_ON_JOIN),limit(0));
		return sort(setflags,acctno,recordPenalty);
	end;
end;