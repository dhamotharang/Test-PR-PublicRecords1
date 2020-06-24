import iesp,ABMS,Autokey_batch,suppress,Healthcare_Header_Services;
export ABMS_Records(unsigned1 glb=8, unsigned1 dppa=0, unsigned1 PenaltThreshold=10) := module
	shared myConst := Healthcare_Provider_Services.ABMS_Constants;
	shared myFn := Healthcare_Provider_Services.ABMS_Functions;
	shared myLayouts := Healthcare_Provider_Services.ABMS_Layouts;

	Export ids_by_did (dataset(myLayouts.autokeyInput) input):= function
			return choosen(dedup(sort(join(input(did>0), ABMS.Keys().Main.DID.qa,
																				 left.did=right.did, 
																				 transform(myLayouts.searchKeyResults,self.acctno:=left.acctno; self.biog_number:=right.biog_number;self.isAutokeysResult:=false;self:=right;self:=left;),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
	end;
	Export ids_by_bdid (dataset(myLayouts.autokeyInput) input):= function
			return choosen(dedup(sort(join(input(bdid>0), ABMS.Keys().Main.BDID.qa,
																				 left.bdid=right.bdid, 
																				 transform(myLayouts.searchKeyResults,self.acctno:=left.acctno; self.biog_number:=right.biog_number;self.isAutokeysResult:=false;self:=right;self:=left),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
	end;
	Export ids_by_npi (dataset(myLayouts.autokeyInput) input):= function
			return choosen(dedup(sort(join(input(npi<>''), ABMS.Keys().Main.NPI.qa,
																				 left.npi=right.npi, 
																				 transform(myLayouts.searchKeyResults,self.acctno:=left.acctno; self.biog_number:=right.biog_number;self.isAutokeysResult:=false;self:=right;self:=left),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
	end;
	Export ids_by_NameAndSpecialty (dataset(myLayouts.autokeyInput) input):= function
			//Check for hits based on multiple Specialty
			specialty1 := choosen(dedup(sort(join(input(Specialty<>''), ABMS.Keys().Main.LNameCertFName.qa,
																				 stringlib.StringToUpperCase(left.name_last)=right.last_name and
																				 stringlib.StringToUpperCase(left.Specialty)=right.cert_name, 
																				 transform(myLayouts.searchKeyResults,self.acctno:=left.acctno; self.biog_number:=right.biog_number;self.isAutokeysResult:=false;self:=right;self:=left),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
			specialty2 := choosen(dedup(sort(join(input(Specialty2<>''), ABMS.Keys().Main.LNameCertFName.qa,
																				 stringlib.StringToUpperCase(left.name_last)=right.last_name and
																				 stringlib.StringToUpperCase(left.Specialty)=right.cert_name, 
																				 transform(myLayouts.searchKeyResults,self.acctno:=left.acctno; self.biog_number:=right.biog_number;self.isAutokeysResult:=false;self:=right;self:=left),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
			specialty3 := choosen(dedup(sort(join(input(Specialty3<>''), ABMS.Keys().Main.LNameCertFName.qa,
																				 stringlib.StringToUpperCase(left.name_last)=right.last_name and
																				 stringlib.StringToUpperCase(left.Specialty)=right.cert_name, 
																				 transform(myLayouts.searchKeyResults,self.acctno:=left.acctno; self.biog_number:=right.biog_number;self.isAutokeysResult:=false;self:=right;self:=left),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
			specialty4 := choosen(dedup(sort(join(input(Specialty4<>''), ABMS.Keys().Main.LNameCertFName.qa,
																				 stringlib.StringToUpperCase(left.name_last)=right.last_name and
																				 stringlib.StringToUpperCase(left.Specialty)=right.cert_name, 
																				 transform(myLayouts.searchKeyResults,self.acctno:=left.acctno; self.biog_number:=right.biog_number;self.isAutokeysResult:=false;self:=right;self:=left),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
			specialty5 := choosen(dedup(sort(join(input(Specialty5<>''), ABMS.Keys().Main.LNameCertFName.qa,
																				 stringlib.StringToUpperCase(left.name_last)=right.last_name and
																				 stringlib.StringToUpperCase(left.Specialty)=right.cert_name, 
																				 transform(myLayouts.searchKeyResults,self.acctno:=left.acctno; self.biog_number:=right.biog_number;self.isAutokeysResult:=false;self:=right;self:=left),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
			combinedSpecialty := choosen(dedup(sort(specialty1+specialty2+specialty3+specialty4+specialty5,record),record),myConst.MAX_RECS_ON_JOIN);
			return combinedSpecialty;
	end;
	Export ids_by_NameAndSubSpecialty (dataset(myLayouts.autokeyInput) input):= function
			//Check for hits based on multiple sub Specialty
			subspecialty1 := choosen(dedup(sort(join(input(SubSpecialty<>''), ABMS.Keys().Main.LNameCertFName.qa,
																				 stringlib.StringToUpperCase(left.name_last)=right.last_name and
																				 stringlib.StringToUpperCase(left.Specialty)=right.cert_name, 
																				 transform(myLayouts.searchKeyResults,self.acctno:=left.acctno; self.biog_number:=right.biog_number;self.isAutokeysResult:=false;self:=right;self:=left),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
			subspecialty2 := choosen(dedup(sort(join(input(SubSpecialty2<>''), ABMS.Keys().Main.LNameCertFName.qa,
																				 stringlib.StringToUpperCase(left.name_last)=right.last_name and
																				 stringlib.StringToUpperCase(left.Specialty)=right.cert_name, 
																				 transform(myLayouts.searchKeyResults,self.acctno:=left.acctno; self.biog_number:=right.biog_number;self.isAutokeysResult:=false;self:=right;self:=left),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
			subspecialty3 := choosen(dedup(sort(join(input(SubSpecialty3<>''), ABMS.Keys().Main.LNameCertFName.qa,
																				 stringlib.StringToUpperCase(left.name_last)=right.last_name and
																				 stringlib.StringToUpperCase(left.Specialty)=right.cert_name, 
																				 transform(myLayouts.searchKeyResults,self.acctno:=left.acctno; self.biog_number:=right.biog_number;self.isAutokeysResult:=false;self:=right;self:=left),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
			subspecialty4 := choosen(dedup(sort(join(input(SubSpecialty4<>''), ABMS.Keys().Main.LNameCertFName.qa,
																				 stringlib.StringToUpperCase(left.name_last)=right.last_name and
																				 stringlib.StringToUpperCase(left.Specialty)=right.cert_name, 
																				 transform(myLayouts.searchKeyResults,self.acctno:=left.acctno; self.biog_number:=right.biog_number;self.isAutokeysResult:=false;self:=right;self:=left),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
			subspecialty5 := choosen(dedup(sort(join(input(SubSpecialty5<>''), ABMS.Keys().Main.LNameCertFName.qa,
																				 stringlib.StringToUpperCase(left.name_last)=right.last_name and
																				 stringlib.StringToUpperCase(left.Specialty)=right.cert_name, 
																				 transform(myLayouts.searchKeyResults,self.acctno:=left.acctno; self.biog_number:=right.biog_number;self.isAutokeysResult:=false;self:=right;self:=left),
																				 keep(myConst.MAX_RECS_ON_JOIN),limit(0)),record),record),myConst.MAX_RECS_ON_JOIN);
			combinedSubSpecialty := choosen(dedup(sort(subspecialty1+subspecialty2+subspecialty3+subspecialty4+subspecialty5,record),record),myConst.MAX_RECS_ON_JOIN);
     
			return combinedSubSpecialty;
	end;
	Export myLayouts.searchKeyResults xformLimit(myLayouts.searchKeyResults l, integer cnt) := transform
		limitNameOnlyAutoKeySearch := (l.name_last <> '' or l.comp_name <> '') and l.prim_name='' and l.p_city_name='' and l.st ='' and l.z5 = '';
		cntLimit := if(limitNameOnlyAutoKeySearch,myConst.MAX_NAMEONLY_AUTOKEY_SEARCH_RECS,myConst.MAX_AUTOKEY_SEARCH_RECS);
		self.acctno:=if(cnt>cntLimit, skip, l.acctno);
		self:=l;
	end;
	 Export ids_by_ak (dataset(myLayouts.autokeyInput) input,dataset(Healthcare_Header_Services.Layouts.common_runtime_config) cfg):= function
			fmtInput := project(input,transform(Healthcare_Provider_Services.Layouts.autokeyInput, 
																	self.name_first := if(left.hasoptout,'',stringlib.StringToUpperCase(left.name_first));
																	self.name_middle := if(left.hasoptout,'',stringlib.StringToUpperCase(left.name_middle));
																	self.name_last := if(left.hasoptout,'',stringlib.StringToUpperCase(left.name_last));
																	self.name_suffix := if(left.hasoptout,'',stringlib.StringToUpperCase(left.name_suffix));
																	self.prim_range := if(left.hasoptout,'',stringlib.StringToUpperCase(left.prim_range));
																	self.predir := if(left.hasoptout,'',stringlib.StringToUpperCase(left.predir));
																	self.prim_name := if(left.hasoptout,'',stringlib.StringToUpperCase(left.prim_name));
																	self.addr_suffix := if(left.hasoptout,'',stringlib.StringToUpperCase(left.addr_suffix));
																	self.postdir := if(left.hasoptout,'',stringlib.StringToUpperCase(left.postdir));
																	self.unit_desig := if(left.hasoptout,'',stringlib.StringToUpperCase(left.unit_desig));
																	self.sec_range := if(left.hasoptout,'',stringlib.StringToUpperCase(left.sec_range));
																	self.p_city_name := if(left.hasoptout,'',stringlib.StringToUpperCase(left.p_city_name));
																	self.st := if(left.hasoptout,'',stringlib.StringToUpperCase(left.st));
																	self.comp_name := stringlib.StringToUpperCase(left.comp_name);
																	self.NPI := stringlib.StringToUpperCase(left.NPI);	
																	self := left));
			results:=dedup(sort(project(AutoKey_for_Batch(fmtInput).abms_autokeys,transform(myLayouts.searchKeyResults,self.acctno:=left.acctno;self.biog_number:=left.biog_number;self.isAutokeysResult:=true;self:=left;)),record),record);
			noHits:=join(input,results,left.acctno=right.acctno,left only);
			refmtInput := project(input,transform(Healthcare_Provider_Services.Layouts.autokeyInput, 
																	self.name_first := stringlib.StringToUpperCase(left.name_last);
																	self.name_middle := stringlib.StringToUpperCase(left.name_middle);
																	self.name_last := stringlib.StringToUpperCase(left.name_first);
																	self.name_suffix := stringlib.StringToUpperCase(left.name_suffix);
																	self.prim_range := stringlib.StringToUpperCase(left.prim_range);
																	self.predir := stringlib.StringToUpperCase(left.predir);
																	self.prim_name := stringlib.StringToUpperCase(left.prim_name);
																	self.addr_suffix := stringlib.StringToUpperCase(left.addr_suffix);
																	self.postdir := stringlib.StringToUpperCase(left.postdir);
																	self.unit_desig := stringlib.StringToUpperCase(left.unit_desig);
																	self.sec_range := stringlib.StringToUpperCase(left.sec_range);
																	self.p_city_name := stringlib.StringToUpperCase(left.p_city_name);
																	self.st := stringlib.StringToUpperCase(left.st);
																	self.comp_name := stringlib.StringToUpperCase(left.comp_name);
																	self.NPI := stringlib.StringToUpperCase(left.NPI);	
																	self := left));
			results2:=dedup(sort(project(AutoKey_for_Batch(refmtInput).abms_autokeys,transform(myLayouts.searchKeyResults,self.acctno:=left.acctno;self.biog_number:=left.biog_number;self.isAutokeysResult:=true;self:=left;)),record),record);
			results_final := sort(join(input,results+results2,left.acctno=right.acctno,transform(myLayouts.searchKeyResults, self:=left,self:=right;),keep(myConst.MAX_RECS_ON_JOIN),limit(0)),acctno);
      mod_access:=Healthcare_Header_Services.ConvertcfgtoIdataaccess(cfg);      
			suppress_mac_idsbyak:=Suppress.MAC_FlagSuppressedSource(results_final, mod_access); 	
		  optoutrecs_idsbyak := project(suppress_mac_idsbyak, transform(ABMS_Layouts.searchKeyResults,self.hasOptOut:= left.is_suppressed;self:=left;self:=[];))   ;		
		  finout:= ungroup(project(group(optoutrecs_idsbyak(hasoptout=false),acctno),xformLimit(left,counter)));			
			return ungroup(project(group(finout,acctno),xformLimit(left,counter)));
	end;

		Export getBiogNumbers(dataset(ABMS_Layouts.autokeyInput) inputData,dataset(Healthcare_Header_Services.Layouts.common_runtime_config) cfg) := function
		ids_by_biog_number := project(inputData(ProviderID>0),transform(myLayouts.searchKeyResults,self.acctno:=left.acctno; self.biog_number:=(string)left.ProviderID;self.isAutokeysResult:=false;self:=left;));
		ids_by_keys := dedup(sort(ids_by_did(inputData)+ids_by_bdid(inputData)+ids_by_npi(inputData)+ids_by_NameAndSpecialty(inputData)+ids_by_NameAndSubSpecialty(inputData)+ids_by_biog_number,record),record);
		getNoHits := join(inputData,ids_by_keys,left.acctno=right.acctno,transform(ABMS_Layouts.autokeyInput,self:=left),left only);
  	byAK := ids_by_ak(getnohits,cfg);
		mod_access:=Healthcare_Header_Services.ConvertcfgtoIdataaccess(cfg);
    suppress_macAbms:=Suppress.MAC_FlagSuppressedSource(ids_by_keys+byAK, mod_access); 	
		optoutrecsabms := project(suppress_macAbms, transform(ABMS_Layouts.searchKeyResults,self.hasOptOut:= left.is_suppressed;self:=left;self:=[];))   ; 
   
		return optoutrecsabms;
	end;


	Export getRecords(dataset(ABMS_Layouts.autokeyInput) inputData,dataset(Healthcare_Header_Services.Layouts.common_runtime_config) cfg) := function
		//Get BIOG_NUMBERS that match input criteria....
		ids := getBiogNumbers(inputData,cfg);
		//Get Base data records
		baseRecs := join(ids,ABMS.Keys().Main.BIOGNumber.qa,left.biog_number=right.biog_number,
													ABMS_Transforms.buildBase(left,right,PenaltThreshold),
													keep(myConst.MAX_RECS_ON_JOIN),limit(0));
		modaccess:=Healthcare_Header_Services.ConvertcfgtoIdataaccess(cfg);
    suppressmacAbmsbiognumber:=Suppress.MAC_FlagSuppressedSource(	baseRecs,	modaccess);	
		optoutrecsabmsberbiognumber := project(suppressmacAbmsbiognumber, transform(ABMS_Layouts.LayoutOutput,
																						self.hasOptOut:= left.is_suppressed;
																						self.AccountNumber:=left.AccountNumber;
																						self._Penalty:=left._Penalty;
																						self:=if(not left.is_suppressed,left);
																						self:=[];));    

		
		//Rollup and dedup by biog_number
		grp_baseRecs := group(sort(optoutrecsabmsberbiognumber,AccountNumber,ABMSBiogID),AccountNumber,ABMSBiogID);
		roll_baseRecs := rollup(grp_baseRecs,group,Healthcare_Provider_Services.ABMS_Transforms.doABMSBiogIDRollup(left,rows(left)));
		//Join to get Type of Practice Information
		appendBaseWithType := myFn.appendTypeOfPractice(roll_baseRecs);
		//Join to get Certificates Information
		appendBaseWithCertificates := myFn.appendCertificates(appendBaseWithType);
		//Get optional data
		appendOptionalData := myFn.appendOptionalData(appendBaseWithCertificates,inputData);
	
		return sort(appendOptionalData,_Penalty);
	end;
	Export getRecordsBatch(dataset(ABMS_Layouts.autokeyInput) inputData,dataset(Healthcare_Header_Services.Layouts.common_runtime_config) cfg) := function
		recs := getRecords(inputData,cfg);
		recsWithBatchCertificates := myFn.appendBatchCertificates(recs);
		fmtRecs:=project(recsWithBatchCertificates,Healthcare_Provider_Services.ABMS_Transforms.fmtBatchResults(left));
		setflags:=join(inputData,fmtRecs,left.acctno=right.acctno,Healthcare_Provider_Services.ABMS_Transforms.setBatchResultsFlags(left,right),keep(myConst.MAX_RECS_ON_JOIN),limit(0));
		return sort(setflags,acctno,recordPenalty);
	end;
end;