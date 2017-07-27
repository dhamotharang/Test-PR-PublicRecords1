import salt25,MDR,Health_Provider_services,HealthCareProvider,dea,doxie;
EXPORT Header_Records_SearchKeys(dataset(Healthcare_Provider_Services.Layouts.autokeyInput) input = dataset([],Healthcare_Provider_Services.Layouts.autokeyInput),dataset(doxie.layout_references) inputbyDID = dataset([], doxie.layout_references), boolean byDid = false) := module
	Shared myConst := Healthcare_Provider_Services.Constants;
	Shared Header_Input_Layout := Healthcare_Provider_Services.Layouts.HeaderRequestLayout;
	Shared Header_Input_Layout_Plus := Healthcare_Provider_Services.Layouts.HeaderRequestLayoutPlus;
	Export Header_Output_Layout := Healthcare_Provider_Services.Layouts.HeaderResponseLayout;
	shared myFn := Healthcare_Provider_Services.Provider_Records_Functions;
	shared myTransforms := Healthcare_Provider_Services.Provider_Records_Transforms;
	shared myLayouts := Healthcare_Provider_Services.Layouts;
	shared src_ING := Healthcare_Provider_Services.Provider_Records_ING;
	shared src_AMS := Healthcare_Provider_Services.Provider_Records_AMS;
	shared src_Sanc := Healthcare_Provider_Services.Provider_Records_Sanc;
	shared src_DEA := Healthcare_Provider_Services.Provider_Records_DEA;
	shared src_NPPES := Healthcare_Provider_Services.Provider_Records_NPPES;
	shared src_ProfLic := Healthcare_Provider_Services.Provider_Records_ProfLic;
	shared src_BocaHeader := Healthcare_Provider_Services.Provider_Records_Boca_Header;
	shared src_BocaBusHeader := Healthcare_Provider_Services.Provider_Records_Boca_Bus_Header;

	Export Header_Input_Layout_Plus createHeaderRequest(Healthcare_Provider_Services.Layouts.autokeyInput input) := transform
		searchType := map(input.ProviderSrc = Healthcare_Provider_Services.Constants.SRC_ING => MDR.SourceTools.src_Ingenix_Sanctions,
											input.ProviderSrc = Healthcare_Provider_Services.Constants.SRC_AMS => MDR.SourceTools.src_AMS,
											input.ProviderSrc = Healthcare_Provider_Services.Constants.SRC_DEA =>  MDR.SourceTools.src_DEA,
											input.ProviderSrc = Healthcare_Provider_Services.Constants.SRC_NPPES => MDR.SourceTools.src_NPPES,
											input.ProviderSrc = Healthcare_Provider_Services.Constants.SRC_PROFLIC => MDR.SourceTools.src_Professional_License,
											'');
		hasLicense := input.license_number <>'' or input.DEA <>'' or input.NPI <>'' or input.upin <>''; 
		hasName := input.name_first <>'' or input.name_last <>'';
		hasAddress := (input.prim_range <>'' and input.prim_name <>'') or (input.prim_name <>'' and input.st <>'') or (input.prim_name <>'' and input.z5 <>'');
		isLicenseOnly := hasLicense and (not hasName and not hasAddress);
		isNameAddrOnly := (hasName and hasAddress) and not hasLicense;
		hasSomething2Search := hasLicense or hasName or hasAddress;
		isFullSearch := hasSomething2Search and (not isLicenseOnly and not isNameAddrOnly);
		SELF.rid := (integer)input.acctno;
		self.lnpid := if(searchType = '',input.ProviderID,0);
		SELF.FNAME := stringlib.StringToUpperCase(input.name_first);
		SELF.MNAME := stringlib.StringToUpperCase(input.name_middle);
		SELF.LNAME := stringlib.StringToUpperCase(input.name_last);
		SELF.SNAME := stringlib.StringToUpperCase(input.name_suffix);
		// SELF.GENDER := '';//Not currently supported;
		SELF.PRIM_RANGE := stringlib.StringToUpperCase(input.prim_range);
		SELF.PRIM_NAME := stringlib.StringToUpperCase(input.prim_name);
		SELF.SEC_RANGE := stringlib.StringToUpperCase(input.sec_range);
		SELF.V_CITY_NAME := stringlib.StringToUpperCase(input.p_city_name);
		SELF.ST := stringlib.StringToUpperCase(input.st);
		SELF.ZIP := stringlib.StringToUpperCase(input.z5);
		SELF.SSN := '';//input.ssn;//Not currently populated;
		SELF.DOB := (integer)input.dob;
		self.PHONE := input.workphone;
		SELF.LIC_STATE :=	stringlib.StringToUpperCase(input.license_state);
		SELF.LIC_NBR :=	HealthCareProvider.Clean_License(stringlib.StringToUpperCase(input.license_number));
		SELF.TAX_ID	:= if(input.fein <> '',input.fein,input.TaxID);
		SELF.DEA_NUMBER	:= stringlib.StringToUpperCase(input.DEA);
		SELF.VENDOR_ID := stringlib.StringToUpperCase(if(searchType <> '',(string)input.ProviderID,''));
		SELF.SRC := stringlib.StringToUpperCase(searchType);
		SELF.NPI_NUMBER	:= stringlib.StringToUpperCase(input.NPI);
		SELF.UPIN := stringlib.StringToUpperCase(input.upin);
		SELF.DID := input.DID;
		SELF.BDID := input.BDID;
		SELF.SOURCE_RID := 0;//Not currently supported as the user do not know the rids they only know the lnpids;
		self.hasLicense := hasLicense; 
		self.hasName := hasName;
		self.hasAddress := hasAddress;
		self.isLicenseOnly := isLicenseOnly;
		self.isNameAddrOnly := isNameAddrOnly;
		self.isFullSearch := isFullSearch;
		SELF :=	[];
	End;
	Export Header_Input_Layout_Plus createHeaderRequestByDid(doxie.layout_references inputbyDID) := transform
		SELF.rid := 1;
		self.lnpid := 0;
		SELF.FNAME := '';
		SELF.MNAME := '';
		SELF.LNAME := '';
		SELF.SNAME := '';
		// SELF.GENDER := '';//Not currently supported;
		SELF.PRIM_RANGE := '';
		SELF.PRIM_NAME := '';
		SELF.SEC_RANGE := '';
		SELF.V_CITY_NAME := '';
		SELF.ST := '';
		SELF.ZIP := '';
		SELF.SSN := '';//input.ssn;//Not currently populated;
		SELF.DOB := 0;
		self.PHONE := '';
		SELF.LIC_STATE :=	'';
		SELF.LIC_NBR :=	'';
		SELF.TAX_ID	:= '';
		SELF.DEA_NUMBER	:= '';
		SELF.VENDOR_ID := '';
		SELF.SRC := '';
		SELF.NPI_NUMBER	:= '';
		SELF.UPIN := '';
		SELF.DID := inputbyDID.DID;
		SELF.BDID := 0;
		SELF.SOURCE_RID := 0;//Not currently supported as the user do not know the rids they only know the lnpids;
		self.hasLicense := false; 
		self.hasName := false;
		self.hasAddress := false;
		self.isLicenseOnly := false;
		self.isNameAddrOnly := false;
		self.isFullSearch := true;
		SELF :=	[];
	End;
	Export Header_Input_Layout_Plus createHeaderRequestDEA2(Healthcare_Provider_Services.Layouts.autokeyInput input) := transform
		SELF.rid := (integer)input.acctno;
		SELF.DEA_NUMBER	:= stringlib.StringToUpperCase(input.DEA2);
		self.hasLicense := true; 
		SELF :=	[];
	End;
	Export Header_Input_Layout_Plus createHeaderRequestLicense(Healthcare_Provider_Services.Layouts.autokeyInput input, unsigned cnt) := transform
		lic := map(cnt = 1 => input.StateLicense1Verification,
							 cnt = 2 => input.StateLicense2Verification,
							 cnt = 3 => input.StateLicense3Verification,
							 cnt = 4 => input.StateLicense4Verification,
							 cnt = 5 => input.StateLicense5Verification,
							 cnt = 6 => input.StateLicense6Verification,
							 cnt = 7 => input.StateLicense7Verification,
							 cnt = 8 => input.StateLicense8Verification,
							 cnt = 9 => input.StateLicense9Verification,
							 cnt = 10 => input.StateLicense10Verification,
							 '');
		licSt := map(cnt = 1 => input.StateLicense1StateVerification,
								 cnt = 2 => input.StateLicense2StateVerification,
								 cnt = 3 => input.StateLicense3StateVerification,
								 cnt = 4 => input.StateLicense4StateVerification,
								 cnt = 5 => input.StateLicense5StateVerification,
								 cnt = 6 => input.StateLicense6StateVerification,
								 cnt = 7 => input.StateLicense7StateVerification,
								 cnt = 8 => input.StateLicense8StateVerification,
								 cnt = 9 => input.StateLicense9StateVerification,
								 cnt = 10 => input.StateLicense10StateVerification,
								 '');
		SELF.rid := (integer)input.acctno;
		SELF.LIC_STATE :=	stringlib.StringToUpperCase(licSt);
		SELF.LIC_NBR :=	HealthCareProvider.Clean_License(stringlib.StringToUpperCase(lic));
		self.hasLicense := true; 
		SELF :=	[];
	End;

	Export ConvertedInputRaw := project(input,createHeaderRequest(left));
	Export ConvertedInputRawByDid := project(inputbyDID,createHeaderRequestbyDid(left));
	Export ConvertedDEA2Input := project(input(DEA2<>''),createHeaderRequestDEA2(left));
	Export ConvertedLicense1Input := project(input(StateLicense1Verification<>''),createHeaderRequestLicense(left,1));
	Export ConvertedLicense2Input := project(input(StateLicense2Verification<>''),createHeaderRequestLicense(left,2));
	Export ConvertedLicense3Input := project(input(StateLicense3Verification<>''),createHeaderRequestLicense(left,3));
	Export ConvertedLicense4Input := project(input(StateLicense4Verification<>''),createHeaderRequestLicense(left,4));
	Export ConvertedLicense5Input := project(input(StateLicense5Verification<>''),createHeaderRequestLicense(left,5));
	Export ConvertedLicense6Input := project(input(StateLicense6Verification<>''),createHeaderRequestLicense(left,6));
	Export ConvertedLicense7Input := project(input(StateLicense7Verification<>''),createHeaderRequestLicense(left,7));
	Export ConvertedLicense8Input := project(input(StateLicense8Verification<>''),createHeaderRequestLicense(left,8));
	Export ConvertedLicense9Input := project(input(StateLicense9Verification<>''),createHeaderRequestLicense(left,9));
	Export ConvertedLicense10Input := project(input(StateLicense10Verification<>''),createHeaderRequestLicense(left,10));
	Export ConvertedInput := ConvertedInputRaw+ConvertedInputRawByDid+ConvertedDEA2Input+ConvertedLicense1Input+ConvertedLicense2Input+ConvertedLicense3Input+ConvertedLicense4Input+
													 ConvertedLicense5Input+ConvertedLicense6Input+ConvertedLicense7Input+ConvertedLicense8Input+ConvertedLicense9Input+ConvertedLicense10Input;

	Export getHeaderRecordsRaw := Function
		fullSearch := Project(ConvertedInput(isFullSearch=true),transform(Header_Input_Layout,self:=left));
		nameAddrSearch := Project(ConvertedInput(isNameAddrOnly=true),transform(Header_Input_Layout,self:=left));
		licSearch := Project(ConvertedInput(isLicenseOnly=true),transform(Header_Input_Layout,self:=left));
		//Use different thresholds based on type of search
		Health_Provider_Services.mac_xlinking_on_roxie_withindistance_recs (fullSearch,rid,
															FNAME,MNAME,LNAME,SNAME,
															GENDER,
															PRIM_Range,PRIM_Name,SEC_RANGE,v_city_name,ST,ZIP,
															SSN,DOB,PHONE,
															LIC_STATE,LIC_NBR,
															TAX_ID,DEA_NUMBER,VENDOR_ID,NPI_NUMBER,UPIN,DID,BDID,SRC,SOURCE_RID,headerResults1,lnpid,false,false,myConst.HEADER_SCORE_THRESHOLD,myConst.HEADER_CLOSE_MATCH_SCORE);	
		Health_Provider_Services.mac_xlinking_on_roxie_withindistance_recs (nameAddrSearch,rid,
															FNAME,MNAME,LNAME,SNAME,
															GENDER,
															PRIM_Range,PRIM_Name,SEC_RANGE,v_city_name,ST,ZIP,
															SSN,DOB,PHONE,
															LIC_STATE,LIC_NBR,
															TAX_ID,DEA_NUMBER,VENDOR_ID,NPI_NUMBER,UPIN,DID,BDID,SRC,SOURCE_RID,headerResults2,lnpid,false,false,myConst.HEADER_SCORE_NAME_ADDR_ONLY_THRESHOLD,myConst.HEADER_CLOSE_MATCH_SCORE);	
		Health_Provider_Services.mac_xlinking_on_roxie_withindistance_recs (licSearch,rid,
															FNAME,MNAME,LNAME,SNAME,
															GENDER,
															PRIM_Range,PRIM_Name,SEC_RANGE,v_city_name,ST,ZIP,
															SSN,DOB,PHONE,
															LIC_STATE,LIC_NBR,
															TAX_ID,DEA_NUMBER,VENDOR_ID,NPI_NUMBER,UPIN,DID,BDID,SRC,SOURCE_RID,headerResults3,lnpid,false,false,myConst.HEADER_SCORE_LIC_ONLY_THRESHOLD,myConst.HEADER_CLOSE_MATCH_SCORE);	
		return sort(headerResults1+headerResults2+headerResults3,rid);
	end;
	Export getHdrRecords := Function
		fmtRecs := project(getHeaderRecordsRaw,transform(Header_Output_Layout,
																					self.src:= map(left.src = MDR.SourceTools.src_Ingenix_Sanctions => Healthcare_Provider_Services.Constants.SRC_ING,
																												left.src = MDR.SourceTools.src_AMS => Healthcare_Provider_Services.Constants.SRC_AMS,
																												left.src = MDR.SourceTools.src_NPPES => Healthcare_Provider_Services.Constants.SRC_NPPES,
																												left.src = MDR.SourceTools.src_DEA => Healthcare_Provider_Services.Constants.SRC_DEA,
																												left.src = MDR.SourceTools.src_Professional_License => Healthcare_Provider_Services.Constants.SRC_PROFLIC,
																												left.src);
																					self:=left;
																					self:= []));
		return fmtRecs;
	end;
	shared Healthcare_Provider_Services.Layouts.searchKeyResults xformHdrPids (Header_Output_Layout L) := transform
			self.prov_id:=if(l.src= Healthcare_Provider_Services.Constants.SRC_PROFLIC,l.did,(unsigned6)l.vendor_id);
			self.acctno:=(string)l.uniqueid;
			self.src:=l.src;
			self.hid:=l.LNPID;
			self.isHeaderResult := true;
	end;
	shared getHdrPids(dataset(Header_Output_Layout) hdr_output) := Function
		hdr_pids:= project(hdr_output,xformHdrPids(left)); //Get header pids
		return hdr_pids;
	end;
	Export getHdrPIDsWithDeepDiveAndSanctions := function
		hdr_ids := dedup(sort(getHdrPids(getHdrRecords),record),record);
		getNoHits := join(input,hdr_ids,left.acctno=right.acctno,transform(Healthcare_Provider_Services.Layouts.autokeyInput, self := left),left only);
		checkDeepDive := getNoHits(doDeepDive = true);
		individuals_ids := Healthcare_Provider_Services.Provider_Records_SearchKeys.getDeepDivePids(checkDeepDive(comp_name=''));
		business_ids := Healthcare_Provider_Services.Provider_Records_SearchKeys.getBusDeepDivePids(checkDeepDive(comp_name<>''));
		user_sanc_providerID := Project(getNoHits(providerid>0,providerSrc=Healthcare_Provider_Services.Constants.SRC_SANC),transform(Healthcare_Provider_Services.Layouts.searchKeyResults,self.prov_id := left.providerid;self.acctno:=left.acctno;self.src:=Healthcare_Provider_Services.Constants.SRC_SANC));
		sanc_by_dids := Healthcare_Provider_Services.Provider_Records_SearchKeys.get_sanc_by_dids(getNoHits(did>0));
		sanc_pids_pre:= dedup(sort(user_sanc_providerID+sanc_by_dids,record),record);
		getNoHitsForAK := join(getNoHits,sanc_pids_pre,left.acctno=right.acctno,transform(Healthcare_Provider_Services.Layouts.autokeyInput, self := left),left only);
		//Remove bad input records before sending to autokeys
		removeBadRecs := Project(getNoHitsForAK, transform(Healthcare_Provider_Services.Layouts.autokeyInput,
																		bad:=length(trim(left.name_first,all))>0 and length(trim(left.name_last,all))=0;
																		self.name_last := if(bad,skip,left.name_last);
																		self := left;));
		// hdr_ids_byak := get_hdr_by_ak(removeBadRecs);
		sanc_ids_byak := Healthcare_Provider_Services.Provider_Records_SearchKeys.get_sanc_by_ak(removeBadRecs);
		//Combine search results
		sanc_pids:= dedup(sort(sanc_pids_pre+sanc_ids_byak,record),record);
		return hdr_ids+individuals_ids+business_ids+sanc_pids;
	end;
	Export getRecords (UNSIGNED1 maxPenalty) := function
		hdr_ids := dedup(sort(getHdrPids(getHdrRecords),record),record);
		hits_with_Input := myFn.appendInputToSearchKeyData(hdr_ids,input);

		//Rollup data within each datasource
		ing_providers_final := src_ING.get_ing_entity(hits_with_Input(src=myConst.SRC_ING),maxPenalty);
		ing_providers_final_sorted := sort(ing_providers_final, acctno, HcId, SrcId, Src);
		ing_providers_final_grouped := group(ing_providers_final_sorted, acctno, HcId, SrcId, Src);
		ing_providers_rolled := rollup(ing_providers_final_grouped, group, mytransforms.doSrcIdRollup(left,rows(left)));			

		ams_providers_final := src_AMS.get_ams_entity(hits_with_Input(src=myConst.SRC_AMS),maxPenalty);
		ams_providers_final_sorted := sort(ams_providers_final, acctno, HcId, SrcId, Src);
		ams_providers_final_grouped := group(ams_providers_final_sorted, acctno, HcId, SrcId, Src);
		ams_providers_rolled := rollup(ams_providers_final_grouped, group, mytransforms.doSrcIdRollup(left,rows(left)));	

		dea_providers_final := src_DEA.get_dea_providers_base(hits_with_Input(src=myConst.SRC_DEA),maxPenalty);
		dea_providers_final_sorted := sort(dea_providers_final, acctno, HcId, SrcId, Src);
		dea_providers_final_grouped :=	group(dea_providers_final_sorted, acctno, HcId, SrcId, Src);
		dea_providers_rolled := rollup(dea_providers_final_grouped, group, mytransforms.doSrcIdRollup(left,rows(left)));
		
		nppes_providers_final := src_NPPES.get_nppes_providers_base(hits_with_Input(src=myConst.SRC_NPPES),maxPenalty);
		nppes_providers_final_sorted := sort(nppes_providers_final, acctno, HcId, SrcId, Src);
		nppes_providers_final_grouped :=	group(nppes_providers_final_sorted, acctno, HcId, SrcId, Src);
		nppes_providers_rolled := rollup(nppes_providers_final_grouped, group, mytransforms.doSrcIdRollup(left,rows(left)));
		
		proflic_providers_final := src_ProfLic.get_proflic_providers_base(hits_with_Input(src=myConst.SRC_PROFLIC),maxPenalty);
		proflic_providers_final_sorted := sort(proflic_providers_final, acctno, HcId, SrcId, Src);
		proflic_providers_final_grouped :=	group(proflic_providers_final_sorted, acctno, HcId, SrcId, Src);
		proflic_providers_rolled := rollup(proflic_providers_final_grouped, group, mytransforms.doSrcIdRollup(left,rows(left)));

		//Merge Records
		baseRecs := group(sort(ing_providers_rolled+ams_providers_rolled+dea_providers_rolled+nppes_providers_rolled+proflic_providers_rolled,acctno,HcId),acctno,HcId);
		//Rollup Records
		baseRecs_Rolled := rollup(baseRecs, group, myTransforms.doFinalRollup(left,rows(left)));
		//Apply Penalty
		baseRecs_W_Penalty := myFn.doPenalty(baseRecs_Rolled,input,maxPenalty);

		baseHits := baseRecs_W_Penalty;

		//If we have don't have results_combined_rolled+sanc_providers_rolled, get dataset to sent thru NPPES and Deep Dives
		getNoHits := join(input,baseHits,left.acctno=right.acctno,transform(myLayouts.autokeyInput, self := left),left only);

		//Try Sanctions
		sancByDid := Healthcare_Provider_Services.Provider_Records_SearchKeys.get_sanc_by_dids(getNoHits(did>0));
		sancByAK := Healthcare_Provider_Services.Provider_Records_SearchKeys.get_sanc_by_ak(getNoHits)(not byDID);//Only do this if it is not a bydid search
		sanc_with_Input := myFn.appendInputToSearchKeyData(sancByDid+sancByAK,input);
		sanc_providers_base := src_Sanc.get_sanc_providers_base(sanc_with_Input,maxPenalty);
		sanc_providers_final_sorted := sort(sanc_providers_base, acctno, HcId, SrcId, Src);
		sanc_providers_final_grouped :=	group(sanc_providers_final_sorted, acctno, HcId, SrcId, Src);
		sanc_providers_rolled := rollup(sanc_providers_final_grouped, group, mytransforms.doSrcIdRollup(left,rows(left)));

		//if we still don't have any hits sent thru Deep Dives
		getNoHitsForDeepDive := join(getNoHits(doDeepDive=true),sanc_providers_rolled,left.acctno=right.acctno,transform(myLayouts.autokeyInput, self := left),left only);

		//Deep Dive logic 
		individuals_ids := Healthcare_Provider_Services.Provider_Records_SearchKeys.getDeepDivePids(getNoHitsForDeepDive(comp_name=''));
		DeepDive_with_Input := myFn.appendInputToSearchKeyData(individuals_ids,input);
		DeepDive_final := src_BocaHeader.get_boca_header_base(DeepDive_with_Input,maxPenalty);
		//Rollup data within each datasource
		BocaHeader_final_sorted := sort(DeepDive_final, acctno, HcId, SrcId, Src);
		BocaHeader_final_grouped :=	group(BocaHeader_final_sorted, acctno, HcId, SrcId, Src);
		BocaHeader_rolled := rollup(BocaHeader_final_grouped, group, mytransforms.doSrcIdRollup(left,rows(left)));

		//Deep Dive logic Business
		business_noHits := getNoHitsForDeepDive(comp_name<>'' and z5 <>'' and isReport=false);
		business_ids := Healthcare_Provider_Services.Provider_Records_SearchKeys.getBusDeepDivePids(business_noHits);
		DeepDiveBus_with_Input := myFn.appendInputToSearchKeyData(business_ids,input);
		DeepDiveBus_final := src_BocaBusHeader.get_boca_bus_header_base(DeepDiveBus_with_Input,business_noHits,maxPenalty);
		//Rollup data within each datasource
		BocaBusHeader_final_sorted := sort(DeepDiveBus_final, acctno, HcId, SrcId, Src);
		BocaBusHeader_final_grouped :=	group(BocaBusHeader_final_sorted, acctno, HcId, SrcId, Src);
		BocaBusHeader_rolled := rollup(BocaBusHeader_final_grouped, group, mytransforms.doSrcIdRollup(left,rows(left)));

		//Collect any records we found via the extra lookups
		additional_found_hits :=  myFn.doPenalty(sanc_providers_rolled+BocaHeader_rolled+BocaBusHeader_rolled,getNoHits,maxPenalty);

		//append DEA information for the additional found hits
		getNoHitsForDEA := project(getNoHits(DEA <>'' or DEA2 <>''),transform(myLayouts.autokeyInput,self:=left)); 
		getDeaInfo := dedup(sort(JOIN(getNoHitsForDEA,dea.Key_dea_reg_num,keyed(left.dea= right.dea_registration_number or 
																																						left.dea2= right.dea_registration_number),
													transform(mylayouts.pid_dea_rec, self.deanumber:=right.dea_registration_number;self.expiration_date:=right.Expiration_Date;
																													self :=left;self:=right;self:=[]),keep(myConst.MAX_RECS_ON_JOIN), limit(0)),acctno,providerid,deanumber,-Expiration_Date),acctno,providerid,deanumber,Expiration_Date);
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
		dearesults_child_dataset := rollup(group(sort(dearesult,acctno,ProviderID),acctno),group,doRollup(left,rows(left)));
		//append DEA information to any no hits that we found..
		extraHits := join(additional_found_hits,dearesults_child_dataset,left.acctno=right.acctno,
													transform(myLayouts.CombinedHeaderResults, self.deas:=right.childinfo;self:=left),left outer);
		final := baseHits+extraHits;
		// output(BusinessRecords,named('BusinessRecords'),overwrite);
		// output(IndividualRecords,named('IndividualRecords'),overwrite);
		// output(all_pids_pre,named('Ingenix_pids_pre'),overwrite);
		// output(ams_pids_pre,named('ams_pids_pre'),overwrite);
		// output(sanc_pids_pre,named('sanc_pids_pre'),overwrite);
		// output(Sanc_with_Input,named('Sanc_with_Input'),overwrite);
		// output(sanc_providers_base,named('sanc_providers_base'),overwrite);
		// output(otherLookupPIDs,named('otherLookupPIDs'),overwrite);
		// output(Ing_with_Input,named('Ing_with_Input'),overwrite);
		// output(ing_providers_final,named('ing_providers_final'),overwrite);
		// output(AMS_with_Input,named('AMS_with_Input'),overwrite);
		// output(all_ams_pids,named('all_ams_pids'),overwrite);
		// output(ams_providers_final,named('ams_providers_final'),overwrite);
		// output(getNoHitsForAK,named('getNoHitsForAK'),overwrite);
		// output(AK_results,named('AK_results'),overwrite);
		// output(ing_providers_rolled,named('ing_providers_rolled'),overwrite);
		// output(ams_providers_rolled,named('ams_providers_rolled'),overwrite);
		// output(combined_ing_ams,named('combined_ing_ams'),overwrite);
		// output(sanc_providers_rolled,named('sanc_providers_rolled'),overwrite);
		// output(baseHits,named('baseHits'),overwrite);
		// output(getNoHitsForDeepDive,named('getNoHitsForDeepDive'),overwrite);
		// output(get_deepdive,named('get_deepdive'),overwrite);
		// output(DeepDive_with_Input,named('DeepDive_with_Input'),overwrite);
		// output(DeepDive_final,named('DeepDive_final'),overwrite);
		// output(DeepDiveBusinessRecords,named('DeepDiveBusinessRecords'),overwrite);
		// output(get_BusDeepdive,named('get_BusDeepdive'),overwrite);
		// output(DeepDiveBus_with_Input,named('DeepDiveBus_with_Input'),overwrite);
		// output(DeepDiveBus_final,named('DeepDiveBus_final'),overwrite);
		// output(additional_found_hits,named('additional_found_hits'),overwrite);
		// output(dearesults_child_dataset,named('dearesults_child_dataset'),overwrite);
		// output(extraHits,named('extraHits'),overwrite);
		// output(final,named('final'),overwrite);
		return final;
	end;
end;