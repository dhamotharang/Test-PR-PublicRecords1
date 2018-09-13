/*2018-04-13T23:16:00Z (Peterson, Camryn (RIS-MIN))
review
*/
IMPORT Healthcare_Ganga,Healthcare_Shared,Healthcare_Header_Services,Address,STD,BIPV2_Best,DCAV2;
EXPORT Records := Module
	//reformat data into standard input format
	reformatInput (DATASET(Healthcare_Ganga.Layouts.IdentityInput) inRecs) := FUNCTION
		results := project(inRecs,transform(Healthcare_Header_Services.Layouts.autokeyInput,
																					cleanAddr := left.StreetAddress1 <> '';
																					clnAddr := Address.CleanFields(Address.GetCleanAddress(trim(left.StreetAddress1,right)+' '+left.StreetAddress2,left.City+' '+left.State+' '+left.Zip5,address.Components.Country.US).str_addr);
																					self.Acctno:=left.acctno;
																					self.name_first := STD.Str.ToUpperCase(left.FirstName);
																					self.name_last := STD.Str.ToUpperCase(left.LastName);
																					self.dob := left.DoB;
																					self.ssn := left.SSN;
																					self.NPI := left.NPI;
																					self.prim_range := if(cleanAddr,clnAddr.prim_range,'');
																					self.predir := if(cleanAddr,clnAddr.predir,'');
																					self.prim_name := if(cleanAddr,clnAddr.prim_name,'');
																					self.addr_suffix := if(cleanAddr,clnAddr.addr_suffix,'');
																					self.postdir := if(cleanAddr,clnAddr.postdir,'');
																					self.unit_desig := if(cleanAddr,clnAddr.unit_desig,'');
																					self.sec_range := if(cleanAddr,clnAddr.sec_range,'');
																					self.p_city_name := left.City;
																					self.st := left.State;
																					self.z5 := left.Zip5;
																					self.zip4 := left.Zip4;
																					self.comp_name:= map(left.LegalName <> '' => STD.Str.ToUpperCase(left.LegalName),
																															STD.Str.ToUpperCase(left.BusinessName));
																					self.TaxID := left.taxid;
																					self.IsIndividualSearch := left.EntityType in [Healthcare_Ganga.Constants.HCP,
																																																	Healthcare_Ganga.Constants.Principles];
																					self.IsBusinessSearch := left.EntityType in [Healthcare_Ganga.Constants.HCO,
																																																Healthcare_Ganga.Constants.Orgs];
																					self := left;
																					self := [];
																					));
		return results;
	END;
		
	//Record with 'P' entity type
	byPrinciples (DATASET(Healthcare_Ganga.Layouts.IdentityInput) inRecs, dataset(Healthcare_Header_Services.Layouts.common_runtime_config) cfg) := FUNCTION
		refmt := reformatInput(inRecs);
		getBocaHeader := Healthcare_Header_Services.Datasource_Boca_Header.get_boca_header_entity(refmt);
		getRaw := join(refmt, getBocaHeader, left.acctno=right.acctno, transform(recordof(getBocaHeader), 
																																							self.acctno := left.acctno; 
																																							self:=right; self:=left;), left outer);
		getRawAppend := Healthcare_Header_Services.Records.getRecordsAppend(refmt,getRaw,cfg);
		final := Join(dedup(sort(getRawAppend, acctno, record_penalty, -lnpid), acctno),inrecs,left.acctno=right.acctno,Healthcare_Ganga.Transforms.xformCommon(left,right));				
		return final;
	END;
	
	//Record with 'I' entity type
	byHCP (DATASET(Healthcare_Ganga.Layouts.IdentityInput) inRecs, dataset(Healthcare_Header_Services.Layouts.common_runtime_config) cfg) := FUNCTION
		refmt := reformatInput(inRecs);
		getRecordsIndividual := Healthcare_Header_Services.Records.getRecordsIndividual(refmt,cfg);
		getRaw := join(refmt, getRecordsIndividual, left.acctno=right.acctno, transform(recordof(getRecordsIndividual), 
																																							self.acctno := left.acctno; 
																																							self:=right; self:=left;), left outer);
		getRawAppend := Healthcare_Header_Services.Records.getRecordsAppend(refmt,getRaw,cfg);
		final := Join(dedup(sort(getRawAppend, acctno, record_penalty, -lnpid), acctno),inrecs,left.acctno=right.acctno,Healthcare_Ganga.Transforms.xformCommon(left,right));		
		return final;
	END;
	
	//Function to fill in byOrgs missing data
	fillGap (DATASET(Healthcare_Ganga.Layouts.gapInput) inRecs) := FUNCTION
		DCAKey:=DCAV2.Key_LinkIds.Key;
		//Join inRecs with DCA data
		FirstJoin:=dedup(sort(Join(inRecs,DCAKey,
																	keyed(right.UltID=left.bipkeys.UltID and right.OrgID=left.bipkeys.OrgID and right.SELEID=left.bipkeys.SELEID and right.ProxID=left.bipkeys.ProxID),
															transform(Healthcare_Ganga.Layouts.gapInput, 
																					self.Enterprise_num := right.rawfields.Enterprise_num, 
																					self.bipkeys:= left.bipkeys;
																					self.Url := right.rawfields.url;
																					self.Email := right.rawfields.e_mail;
																					self.Description := right.rawfields.Bus_Desc;
																					self.BusinessType := right.rawfields.company_type;
																					self.StartYear := (integer)right.rawfields.incorp;
																					self.TotalEmployees :=(integer)right.rawfields.EMP_NUM;
																					self.Sales	:= right.rawfields.sales;
																					self.SicCode := right.rawfields.sic1;
																					self.SicDesc := right.rawfields.text1;
																					self.dt_last_seen := right.date_last_seen;
																					self := left),keep(Healthcare_Header_Services.Constants.MAX_SEARCH_RECS),limit(0)),record),record);

		missing := join(inrecs,FirstJoin,
															left.bipkeys.UltID=right.bipkeys.UltID and left.bipkeys.OrgID=right.bipkeys.OrgID and 
															left.bipkeys.SELEID=right.bipkeys.SELEID and left.bipkeys.ProxID=right.bipkeys.ProxID, 
											transform(left),left only);
		bipKey:=BIPV2_Best.Key_linkids.Key;
		//Joins the remaining missing records with bip data
		SecondJoin:=Join(missing,bipKey,
											keyed(right.UltID=left.bipkeys.UltID and right.OrgID=left.bipkeys.OrgID and right.SELEID=left.bipkeys.SELEID and right.ProxID=left.bipkeys.ProxID),
											transform(right),keep(Healthcare_Header_Services.Constants.MAX_SEARCH_RECS),limit(0));
		BIP_FilterCompany := normalize(SecondJoin,left.company_name, transform(recordof(SecondJoin),self.company_name:=right;self:=left));
		BIP_FilterCompanySources := normalize(BIP_FilterCompany,left.company_name[1].sources(source = 'DF'), 
																							transform(Healthcare_Ganga.Layouts.gapInput, 
																												self.Enterprise_num := right.vl_id, 
																												bipK:=row({0,0,0,/*dot*/0,0,0,/*emp*/0,0,0,/*pow*/left.ProxID,0,0,/*prox*/left.SELEID,0,0,/*sele*/
																																	 left.OrgID,0,0,/*org*/left.UltID,0,0,/*utl*/0},Healthcare_Header_Services.Layouts.layout_bipkeys);
																												self.bipkeys:= bipK;
																												self.Url := left.company_url[1].company_url;
																												self.Email := '';
																												self.Description := '';
																												self.BusinessType := '';
																												self.StartYear := left.company_incorporation_date[1].company_incorporation_date;
																												self.TotalEmployees := 0;
																												self.Sales	:= '';
																												self.SicCode := left.sic_code[1].company_sic_code1;
																												self.SicDesc := '';
																												self.Code := '';
																												self.Source := '';
																												self.dt_last_seen := left.company_name[1].dt_last_seen;
																												self := left));		
		combineData:= FirstJoin+BIP_FilterCompanySources;
		sg_combine:= group(sort(combineData,acctno,lnpid,-dt_last_seen),acctno,lnpid);
		Healthcare_Ganga.Layouts.gapInput xformrollup(Healthcare_Ganga.Layouts.gapInput l,
																										dataset(Healthcare_Ganga.Layouts.gapInput) allrows)	:= 
																										transform(Healthcare_Ganga.Layouts.gapInput, 
																												self.Enterprise_num := l.Enterprise_num, 
																												self.bipkeys:= l.bipkeys;
																												self.Url := allrows(url<>'')[1].url;
																												self.Email := allrows(email<>'')[1].email;
																												self.Description := allrows(Description<>'')[1].Description;
																												self.BusinessType := allrows(BusinessType<>'')[1].BusinessType;
																												self.StartYear := allrows(StartYear>0)[1].StartYear;
																												self.TotalEmployees := allrows(TotalEmployees>0)[1].TotalEmployees;
																												self.Sales	:= allrows(Sales<>'')[1].Sales;
																												self.SicCode := allrows(SicCode<>'')[1].SicCode;
																												self.SicDesc := allrows(SicDesc<>'')[1].SicDesc;
																												self.Code := allrows(Code<>'')[1].Code;
																												self.Source := allrows(Source<>'')[1].Source;
																												self.dt_last_seen := l.dt_last_seen;
																												self := l);		

		r_combine:= rollup(sg_combine,group,xformrollup(left,rows(left)));
		return r_combine;
	END;
	
	//Records with 'O' entity type
	byHCO (DATASET(Healthcare_Ganga.Layouts.IdentityInput) inRecs, dataset(Healthcare_Header_Services.Layouts.common_runtime_config) cfg) := FUNCTION
		refmt := reformatInput(inRecs);
		getRecordsBusiness := Healthcare_Header_Services.Records.getRecordsBusiness(refmt,cfg);
		getRaw := join(refmt, getRecordsBusiness, left.acctno=right.acctno, transform(recordof(getRecordsBusiness), 
																																									self.acctno := left.acctno; 
																																									self:=right; self:=left;), left outer);
		getRawAppend := Project(getRaw,transform(Healthcare_Header_Services.Layouts.CombinedHeaderResultsDoxieLayout, self:=left));
		final := Join(dedup(sort(getRawAppend, acctno, record_penalty, -lnpid), acctno),inrecs,left.acctno=right.acctno,Healthcare_Ganga.Transforms.xformCommon(left,right));	
		return final;
	END;
	
	//Records with 'M' entity type
	byOrgs (DATASET(Healthcare_Ganga.Layouts.IdentityInput) inRecs,dataset(Healthcare_Header_Services.Layouts.common_runtime_config) cfg) := FUNCTION
		refmt := reformatInput(inRecs);
		getBocaHeader := Healthcare_Header_Services.Datasource_Boca_Bus_Header.get_boca_bus_header_entity(refmt);
		getRaw := join(refmt, getBocaHeader, left.acctno=right.acctno, transform(recordof(getBocaHeader), 
																																							self.acctno := left.acctno; 
																																							self:=right; self:=left;), left outer);
		getRawPenalty := sort(Project(getRaw,transform(recordof(getRaw),
																											np:=min(left.names,namepenalty);
																											ap:=min(left.addresses,addrpenalty);
																											self.record_penalty := np+ap;
																											self.record_penalty_name := np;
																											self.record_penalty_addr := ap;
																											self:=left)),record_penalty);
		gapdata := normalize(getRawPenalty, left.bipkeys, transform(Healthcare_Ganga.Layouts.gapInput, 
																					self.acctno := left.acctno, 
																					self.bipkeys:= right;
																					self.Url := '';
																					self.Email := '';
																					self.Description := '';
																					self.BusinessType := '';
																					self.StartYear := 0;
																					self.TotalEmployees := 0;
																					self.Sales	:= '';
																					self.SicCode := '';
																					self.SicDesc := '';
																					self.lnpid := left.lnpid;
																					self := []));
		filldata := fillGap(gapdata);
		joinData := dedup(sort(join(dedup(sort(getRawPenalty, acctno,record_penalty,-lnpid),acctno),filldata, left.acctno = right.acctno and left.lnpid = right.lnpid, 
										transform(Healthcare_Ganga.Layouts.IdentityOutput,
																names:= sort(left.Names,namepenalty,-nameSeq);
																addr := sort(left.Addresses,addrpenalty, -last_seen);
																self.acctno := left.acctno;
																self.TransactionId := left.acctno;
																self.UniqueId	:= (string)left.dids[1].did;
																self.NamePrefix := names[1].title;
																self.FirstName := names[1].FirstName;
																self.MiddleName := names[1].MiddleName;
																self.LastName := names[1].LastName;
																self.NameSuffix := names[1].suffix;
																self.Gender := names(Gender<>'')[1].Gender;
																self.DOB := left.dobs(dob<>'')[1].dob;
																self.SSN := left.ssns(ssn<>'')[1].ssn;
																self.TaxId:= map(exists(left.taxids)=>left.taxids[1].taxid,
																							exists(left.feins)=>left.feins[1].fein,
																							'');
																phones := addr(PhoneNumber<>'')[1].PhoneNumber;
																self.PhoneNumber := phones;
																self.RawPhoneNumber := phones;
																self.StreetAddress1 := STD.str.cleanspaces(addr[1].prim_range+ ' ' + addr[1].predir+ ' ' + addr[1].prim_name+ ' ' + addr[1].addr_suffix + ' ' + addr[1].postdir);
																self.StreetAddress2 := STD.str.cleanspaces(addr[1].unit_desig+ ' ' +addr[1].sec_range);
																self.City := addr[1].p_city_name;
																self.State := addr[1].st;
																self.Zip5 := addr[1].z5;
																self.Zip4 := addr[1].zip4;
																self.NPI	:= left.npis[1].npi;
																self.BusinessId := (string)left.bdids[1].bdid;
																self.BusinessName := names[1].CompanyName;
																lbn :=  names(nameSeq = 2 or nameSeq = 4)[1].CompanyName;
																self.LegalName := if(left.NPIRaw[1].EntityInformation.ParentOrganization <> '',left.NPIRaw[1].EntityInformation.ParentOrganization,lbn);
																self.DoingBusinessAs	:= if(left.NPIRaw[1].EntityInformation.CompanyNameAKA <> '',left.NPIRaw[1].EntityInformation.CompanyNameAKA,lbn);
																self.FaxNumber := addr(FaxNumber<>'')[1].FaxNumber;
																self:=right;),left outer,keep(Healthcare_Header_Services.Constants.BUS_NAME_BIPMATCH_THRESHOLD), limit(0)),record),record);
		final := sort(dedup(sort(join(joinData, inrecs, left.acctno = right.acctno,
										transform(Healthcare_Ganga.Layouts.IdentityOutput,
															self.EntityType := right.EntityType;
															self.RecordIdentifier := right.RecordIdentifier;
															self := left;), keep(Healthcare_Header_Services.Constants.BUS_NAME_BIPMATCH_THRESHOLD), limit(0)),record),record),acctno,-lnpid);		
		return final;
	END;
	Export getAllRecords (DATASET(Healthcare_Ganga.Layouts.IdentityInput) inRecs, dataset(Healthcare_Header_Services.Layouts.common_runtime_config) cfg) := FUNCTION
		//Calls function based off entity type and check minimum input
		doPrinciple := inRecs(EntityType = Healthcare_Ganga.Constants.Principles AND FirstName <> '' AND LastName <> '' AND SSN <> '');
		missingPrinciple := inRecs(EntityType = Healthcare_Ganga.Constants.Principles AND (FirstName = '' or LastName = '' or SSN = ''));
		doHCP := inRecs(EntityType = Healthcare_Ganga.Constants.HCP AND FirstName <> '' AND LastName <> '' AND SSN <> '' AND NPI <> '');
		missingHCP := inRecs(EntityType = Healthcare_Ganga.Constants.HCP AND (FirstName = '' or  LastName = '' or  SSN = '' or NPI = ''));
		doHCO := inRecs(EntityType = Healthcare_Ganga.Constants.HCO AND LegalName <> '' AND StreetAddress1 <> '' AND City <> '' AND State <> '' AND Zip5 <> '' AND NPI <> '');
		missingHCO := inRecs(EntityType = Healthcare_Ganga.Constants.HCO AND (LegalName = '' or StreetAddress1 = '' or City = '' or State = '' or Zip5 = '' or NPI = ''));
		doOrgs := inRecs(EntityType = Healthcare_Ganga.Constants.Orgs AND LegalName <> '' AND StreetAddress1 <> '' AND City <> '' AND State <> '' AND Zip5 <> '');
		missingOrgs := inRecs(EntityType = Healthcare_Ganga.Constants.Orgs AND (LegalName = '' or StreetAddress1 = '' or City = '' or State = '' or Zip5 = ''));
		missingType := inRecs(EntityType Not in [Healthcare_Ganga.Constants.Principles,Healthcare_Ganga.Constants.HCP,Healthcare_Ganga.Constants.HCO,Healthcare_Ganga.Constants.Orgs]);
		
		//Process records based off type
		ProcessPrinciple := byPrinciples(doPrinciple,cfg);
		ProcessHCP := byHCP(doHCP,cfg);
		ProcessHCO:= byHCO(doHCO,cfg);
		ProcessOrgs := byOrgs(doOrgs,cfg);
		
		GoodRecords := ProcessPrinciple+ProcessHCP+ProcessHCO+ProcessOrgs;
		//Process input warnings
		getInputWarnings := Healthcare_Ganga.Functions.getInputWarnings(doPrinciple+doHCP+doHCO+doOrgs);
		getInvalidInputWarnings := Healthcare_Ganga.Functions.getInputWarnings(missingPrinciple+missingHCP+missingHCO+missingOrgs+missingType);
		//Process output warnings
		getOutputWarnings := Healthcare_Ganga.Functions.getOutputWarnings(GoodRecords);
		
		GoodResults := join(getInputWarnings,getOutputWarnings,left.acctno=right.acctno,
																								transform(Healthcare_Ganga.Layouts.IdentityOutput,
																									self.acctno := left.acctno;
																									self.Warnings := dedup(sort(left.Warnings + if(exists(right.Warnings) OR 
																																																	right.EntityType in [Healthcare_Ganga.Constants.Principles,Healthcare_Ganga.Constants.HCP,Healthcare_Ganga.Constants.Orgs,Healthcare_Ganga.Constants.HCO], 
																																																	right.Warnings, dataset([{Healthcare_Ganga.Constants.Warnings.NoHit,Healthcare_Ganga.Constants.LexisNexis}], Healthcare_Ganga.Layouts.WarningsOutput)),record),record);
																									self.ResponseDateTime := left.ResponseDateTime;
																									self.EntityType := left.EntityType;
																									self.RecordIdentifier := left.RecordIdentifier;
																									self := right;),left outer,keep(Healthcare_Header_Services.Constants.MAX_SEARCH_RECS),limit(0));
		FinalGoodResults := sort(GoodResults+getInvalidInputWarnings, acctno);
		CatchNoHits := join(inRecs, FinalGoodResults, left.acctno = right.acctno, transform(left), left only);
		FormatNoHits := project(CatchNoHits, transform(Healthcare_Ganga.Layouts.IdentityOutput,
																										self.acctno := left.acctno;
																										self.Warnings := dataset([{Healthcare_Ganga.Constants.Warnings.NoHit,Healthcare_Ganga.Constants.LexisNexis}], Healthcare_Ganga.Layouts.WarningsOutput);
																										self := left));
		Results := sort(FinalGoodResults + FormatNoHits, acctno);
		return Results;
	END;
END;