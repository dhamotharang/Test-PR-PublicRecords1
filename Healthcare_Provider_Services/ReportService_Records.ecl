#option ('expandSelectCreateRow', true);
import DOXIE, iesp, ut, Address, Risk_Indicators, Models, Gateway, Healthcare_Header_Services, Healthcare_Report_Services;

EXPORT ReportService_Records(Healthcare_Header_Services.IParams.ReportParams inputData,
                             doxie.IDataAccess mod_access,
                             iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportBy srcRptBy,boolean isHeaderSearch = false,dataset(Healthcare_Header_Services.Layouts.common_runtime_config) cfg) := FUNCTION
	tmpMod:= MODULE(PROJECT(inputData, Healthcare_Header_Services.IParams.searchParams,opt)) END;
	searchByCriteria := Healthcare_Header_Services.Records.convertInputtoDataset(tmpMod);
	provdata := Healthcare_Header_Services.Records.getReportServiceRecords(searchByCriteria,cfg)(srcid>0);
	prov := choosen(provdata(record_penalty=min(provdata,record_penalty)),1);
	//Get the DID/BDid from either the provider or sanction results
	isIndiv := inputData.LastName <> '';
	isBus := inputData.CompanyName <> '';
	dsDids := if(isIndiv,choosen(project(prov[1].dids,doxie.layout_references),iesp.Constants.HPR.MAX_UNIQUEIDS),dataset([],doxie.layout_references));
	dsDids2 := if(isIndiv,choosen(project(prov[1].dids,transform(doxie.layout_best, self:=left; self := [])),iesp.Constants.HPR.MAX_UNIQUEIDS),dataset([],doxie.layout_best));
	dsBDids := if(isBus,choosen(project(prov[1].bdids,doxie.layout_ref_bdid),iesp.Constants.HPR.MAX_UNIQUEIDS),dataset([],doxie.layout_ref_bdid));
	hasBDids := exists(dsBDids);

	// doxie.MAC_Header_Field_Declare(true);
	/* If GSA records were requested and exist, then remove them from the regular sanction data as they are being reported in the GSA data */
	gsa := Healthcare_Provider_Services.GSA_Records(inputData).dsGSA(inputData.IncludeGSASanctions);
	clia := Healthcare_Provider_Services.CLIA_Records(inputData).dsCLIA(inputData.IncludeCLIA);
	//Add logic to support IncludeRelativesOnlyWhenDeadOrWithSanctions for Relative and Associates

  mod_person := Healthcare_Provider_Services.Person_Records(inputData,mod_access,dsDids); 
	RelativeData := map(isIndiv=>choosen(mod_person.dsRelatives(inputData.IncludeRels),iesp.Constants.BR.MaxRelatives),dataset([],iesp.bpsreport.t_BpsReportRelativeSlim));
	AssociatesData := map(isIndiv=>choosen(mod_person.dsAssociates(inputData.IncludeAssoc),iesp.Constants.BR.MaxAssociates),dataset([],iesp.bpsreport.t_BpsReportAssociate));
	//Project the Relative data to get only the dids.
	RelSlimData := project(relativeData, transform(doxie.layout_references, self.did:=(integer)left.UniqueId;));
	//Call the header to get Sanctions and death
	rawRecsRel := normalize(Healthcare_Header_Services.Records.getRecordsRawDoxiebyDid(RelSlimData,cfg),left.dids,transform(layouts.CombinedHeaderResults,self.SrcId:=right.did;self:=left));
	//Project the Associates data to get only the dids.
	AssocSlimData := project(AssociatesData, transform(doxie.layout_references, self.did:=(integer)left.UniqueId;));
	//Call the header to get Sanctions and death
	rawRecsAssoc := normalize(Healthcare_Header_Services.Records.getRecordsRawDoxiebyDid(AssocSlimData,cfg),left.dids,transform(layouts.CombinedHeaderResults,self.SrcId:=right.did;self:=left));
	//Join the data back to populate flags
	RelativeDataWSanctions := project(RelativeData,transform(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportRelative,self:=left;self:=[];));
	RelativeDataWSanctionsFilter := Join(RelativeData,rawRecsRel,(integer)left.UniqueId=right.SrcId,transform(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportRelative,self.IsDeceased:=right.status='D';self.HasLEIESanctions:=right.hasOIG;self.HasEPLSSanctions:=right.hasOPM;self:=left));
	AssociatesDataWSanctions := project(AssociatesData,transform(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportAssociate,self:=left;self:=[];));
	AssociatesDataWSanctionsFilter := Join(AssociatesData,rawRecsAssoc,(integer)left.UniqueId=right.SrcId,transform(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportAssociate,self.IsDeceased:=right.status='D';self.HasLEIESanctions:=right.hasOIG;self.HasEPLSSanctions:=right.hasOPM;self:=left));
	Neighbors := map(isIndiv=>choosen(mod_person.dsNeighbors(inputData.IncludeNeighs),iesp.Constants.BR.MaxNeighborhood),dataset([],iesp.bpsreport.t_NeighborSlim));
	Associates :=  if (inputData.IncludeRelativesOnlyWhenDeadOrWithSanctions,AssociatesDataWSanctionsFilter(HasLEIESanctions=true or HasEPLSSanctions=true or IsDeceased=true),AssociatesDataWSanctions);
	//End logic to support IncludeRelativesOnlyWhenDeadOrWithSanctions for Relative and Associates
	sexOff	:= map(isIndiv=>Healthcare_Provider_Services.SexualOffender_Records(inputData,dsDids).sexOffenderOffenses,
									dataset([],iesp.sexualoffender.t_SexOffReportRecord));
	sexOffIDs := map(isIndiv=>Healthcare_Provider_Services.SexualOffender_Records(inputData,dsDids).sexOffenderOffenderIds,'');
	crimOff	:= map(isIndiv=>Healthcare_Provider_Services.CriminalOffender_Records(inputData,dsDids).dsCriminalRecords(inputData.IncludeCriminalRecords),dataset([],iesp.criminal.t_CrimReportRecord));
	//Add logic to support IncludeCorporateAffiliationsOnlyWhenSanctions for Business Individuals and Companies
	corpsInd := Healthcare_Provider_Services.Corps_Records(dsDids,dsBdids).dsCorporateAffiliations(inputData.IncludeCorporateAffiliations);	
	corpsBus := Healthcare_Provider_Services.Corps_Records(dsDids,dsBdids).dsBusinessCorporateRecords(inputData.IncludeCorporateAffiliations and hasBDids);	
	corpsMerge := corpsInd+corpsBus;
	CorpSlimData := project(corpsMerge, transform(doxie.layout_ref_bdid, self.bdid:=(integer)left.BusinessId;));
	// rawRecsCorp := normalize(Healthcare_Header_Services.Records.getRecordsRawDoxiebyDid(CorpSlimData,inputData.penalty_threshold),left.bdids,transform(layouts.CombinedHeaderResults,self.SrcId:=right.bdid;self:=left));
	CorpsDataWSanctions := project(corpsMerge,transform(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportAffiliation,self:=left;self:=[];));
	// CorpsDataWSanctions := Join(corpsMerge,rawRecsCorp,(integer)left.BusinessId=right.SrcId,transform(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportAffiliation,self.HasLEIESanctions:=right.hasOIG;self.HasEPLSSanctions:=right.hasOPM;self:=left));
	corpsCombined := project(corpsMerge,transform(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportAffiliation, self:=left;self:=[]));
	corpsFinal := if (inputData.IncludeCorporateAffiliationsOnlyWhenSanctions,CorpsDataWSanctions(HasLEIESanctions=true or HasEPLSSanctions=true),corpsCombined);
	//End Add logic to support IncludeCorporateAffiliationsOnlyWhenSanctions for Business Individuals and Companies
	bnkrptInd := Healthcare_Provider_Services.Bankruptcies_Records(dsDids,dsBdids).dsBankruptciesIndividual(inputData.IncludeBankruptcies);
	bnkrptBus := Healthcare_Provider_Services.Bankruptcies_Records(dsDids,dsBdids).dsBankruptciesBusiness(inputData.IncludeBankruptcies and hasBDids);
	liensInd := Healthcare_Provider_Services.Liens_Records(dsDids,dsBdids).dsLiensJudgmentsInd(inputData.IncludeLiensJudgments);
	liensBus := Healthcare_Provider_Services.Liens_Records(dsDids,dsBdids).dsLiensJudgmentsBus(inputData.IncludeLiensJudgments and hasBDids);
	doIID := isIndiv and inputData.IncludeIndividualInstantID;
	doBID := isBus and inputData.IncludeBusinessInstantID;
	IID :=  map(doIID => Healthcare_Provider_Services.IndividualInstantID_Records().dsIndividualID,dataset([],iesp.instantid.t_InstantIDResult)[1]);
	BID := map(doBID => Healthcare_Provider_Services.BusinessInstantID_Records(inputData).dsBusinessID,dataset([],iesp.instantid.t_BusinessInstantIDResult)[1]);
	
	iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportProviderEx formatRow() := transform
		hasProv := exists(prov);
		provRec:=if(hasProv,prov[1]);
		provIDs := project(provRec.dids(did > 0), transform (iesp.share.t_StringArrayItem, Self.value := (string)(unsigned6)Left.did));
		busID := project(provRec.bdids(Bdid > 0),transform (iesp.share.t_StringArrayItem, Self.value := (String)Left.bdid));
		sancBusID := project(provRec.legacysanctions(Bdid <> '0'), transform (iesp.share.t_StringArrayItem, Self.value := Left.bdid));
		provSancid := project(provRec.legacysanctions, transform (Healthcare_Header_Services.layouts.layout_sancid, self.sanc_id:=left.sanc_id;Self := Left));
		provSancData := project(provRec.legacysanctions, Healthcare_Header_Services.Transforms.processSanctions(left));
		sancGroupComb := dedup(sort(provSancData,SanctionGroupType, -SanctionDate, (unsigned6)SanctionId),SanctionGroupType,SanctionId);
		sancCombined := if(inputData.IncludeGSASanctions and exists(gsa),sancGroupComb(SanctionSubGroupType<>'GSA'),sancGroupComb);
		provFein := project(provRec.feins(fein<>''), transform (iesp.share.t_StringArrayItem, Self.value := Left.fein));
		provBusAddr := project(provRec.addresses, Healthcare_Header_Services.Transforms.processAddressSearchService(left));
		FullName := if(sort(provRec.names,namepenalty)[1].FullName<>'',sort(provRec.names,namepenalty)[1].FullName,sort(provRec.names,namepenalty)[1].CompanyName);
		provNames := dedup(project(provRec.names, transform(iesp.share.t_Name, self := iesp.ECL2ESP.SetName(left.firstName, left.middleName, left.lastName, left.suffix,left.title,fullName))),record,all);
		self.ProviderId := (string)provRec.lnpid;
		self.ProviderSrc := provRec.src;
		genderData := provRec.names(gender<>'');
		self.sex := map(genderData[1].gender = 'M' => 'MALE', genderData[1].gender = 'F' => 'FEMALE','');
		self.UniqueIds := choosen(dedup(sort(provIDs,record),record),iesp.Constants.HPR.MAX_UNIQUEIDS);
		self.BusinessIds := choosen(dedup(sort(busID+sancBusID,record),record),iesp.constants.HPR.MAX_UNIQUEIDS);
		self.Names := choosen(provNames,iesp.Constants.HPR.MAX_NAMES);
		self.Languages := project(choosen(dedup(provRec.languages,all,hash),iesp.Constants.HPR.MAX_LANGUAGES), transform (iesp.share.t_StringArrayItem, Self.value := Left.language));
		self.DOBs := project(choosen(provRec.dobs,iesp.Constants.HPR.MAX_DOBS), transform (iesp.share.t_Date, Self := if(cfg[1].glb_ok,iesp.ECL2ESP.toDatestring8(Left.dob),iesp.ECL2ESP.ApplyDateMask(iesp.ECL2ESP.toDatestring8(Left.dob),0))));
		self.TaxIds := project(choosen(provRec.taxids,iesp.Constants.HPR.MAX_TAXIDS), transform (iesp.share.t_StringArrayItem, Self.value := Left.taxid));
		self.UPINs := project(choosen(dedup(sort(provRec.upins,upin),upin),iesp.Constants.HPR.MAX_UPINS), transform (iesp.share.t_StringArrayItem, Self.value := Left.upin));
		self.Degrees := project(choosen(dedup(sort(provRec.degrees,degree),degree),iesp.Constants.HPR.MAX_DEGREES), transform (iesp.share.t_StringArrayItem, Self.value := Left.degree))(inputData.IncludeDegrees);
		npi_dup_rec := choosen(dedup(sort(provRec.npis,npi),npi),iesp.Constants.HPR.MAX_NPIS);
		self.NationalProviderIds := if(hasProv,project(choosen(npi_dup_rec,iesp.Constants.HPR.MAX_NPIS), transform (iesp.share.t_StringArrayItem, Self.value := Left.npi)));
		self.NPPESVerified := provRec.NPPESVerified;
		sancCombined_final:=project(sancCombined, transform(recordof(sancCombined), self.NationalProviderId:=npi_dup_rec[1].npi;self:=left));
		self.GroupAffiliations := project(choosen(dedup(sort(provRec.affiliates,stringlib.StringToLowerCase(name)),stringlib.StringToLowerCase(name)),iesp.Constants.HPR.MAX_GROUPAFFILIATIONS), transform (iesp.healthcare.t_ProviderRelatedEntity, self.BusinessId:= (string)left.bdid,self:=left;self:=[];))(cfg[1].IncludeGroupAffiliations);
		self.HospitalAffiliations := project(choosen(dedup(sort(provRec.hospitals,stringlib.StringToLowerCase(name)),stringlib.StringToLowerCase(name)),iesp.Constants.HPR.MAX_HOSPITALAFFILIATIONS),  transform (iesp.healthcare.t_ProviderRelatedEntity,  self.BusinessId:=(string)left.bdid,self:=left;self:=[];))(cfg[1].IncludeHospitalAffiliations);
		self.Residencies := project(choosen(dedup(sort(provRec.Residencies,residency),residency),iesp.Constants.HPR.MAX_RESIDENCIES), transform(iesp.healthcare.t_ProviderRelatedEntity, self.BusinessId:= left.bdid, self.Name:=left.residency;self:=[];))(cfg[1].IncludeResidencies);
		self.MedicalSchools := project(choosen(dedup(sort(provRec.medschools,medschoolname,-graduationyear),medschoolname,graduationyear),iesp.Constants.HPR.MAX_MEDICALSCHOOLS), transform(iesp.healthcare.t_MedicalSchool, self.BusinessId:=left.bdid, self.Name:=left.medschoolname, self.GraduationYear:=(Integer)left.graduationyear;self:=[];))(inputData.IncludeMedicalSchools);
		self.Specialties := project(choosen(dedup(sort(provRec.Specialties(specialtyname<>''),specialtyname,specialtygroupname),stringlib.StringToLowerCase(specialtyname),stringlib.StringToLowerCase(specialtygroupname)),iesp.Constants.HPR.MAX_SPECIALTIES),transform(iesp.healthcare.t_Specialty, self.SpecialtyId:=(String)left.specialtyid, self.SpecialtyName:=left.specialtyname, self.GroupId:=(String)left.specialtygroupid, self.GroupName:=left.specialtygroupname))(cfg[1].IncludeSpecialties);
		self.BusinessAddresses := choosen(provBusAddr,iesp.Constants.HPR.MAX_BUSINESSADDRESSES)(inputData.IncludeBusinessAddresses);
		self.Licenses := project(choosen(provRec.StateLicenses,iesp.Constants.HPR.MAX_LICENSES), transform(iesp.healthcare.t_ProviderLicenseInfo, self.LicenseState:=left.licensestate, self.LicenseNumber :=left.licensenumber, self.EffectiveDate:=iesp.ECL2ESP.toDatestring8(Left.effective_date), self.ExpirationDate:=iesp.ECL2ESP.toDatestring8(Left.termination_date),self.LicenseSeqID:=left.licenseseq,self.LicenseNumberOrig:=left.licensenumberfmt,self:=left,self:=[]))(cfg[1].IncludeLicenses);
     self.deceased:= provRec.DeathLookup or provRec.DateofDeath <> '' or exists(provRec.optouts(death_ind='Y')) or exists(provRec.customerDeath);		
		self.IsFederalDeceased := provRec.DeathLookup or provRec.DateofDeath <> '' or exists(provRec.optouts(death_ind='Y'));
		//For Header Results
		self.SSNs := project(choosen(dedup(sort(provRec.ssns+project(choosen(dedup(sort(provRec.ssnlookups,ssn),ssn),iesp.Constants.HPR.MAX_SSNS), transform (Healthcare_Header_Services.Layouts.layout_ssn, Self := Left)),ssn),ssn),iesp.Constants.HPR.MAX_SSNS), transform (iesp.share.t_StringArrayItem, Self.value := Left.ssn));
		self.Providers := choosen(project(Healthcare_Header_Services.Records.fmtRecordsLegacyReportWithVerifications(choosen(prov,1),cfg),Healthcare_Provider_Services.Transforms.formatReportProviderOutput(left,inputData)),iesp.Constants.BR.MaxProviders);
		self.HasSanctions := provRec.VerificationInfo[1].hasSanctions;
		self.HasLEIESanctions :=  provRec.VerificationInfo[1].hasLEIESanctions;
		self.HasEPLSSanctions := provRec.VerificationInfo[1].hasEPLSSanctions;
		self.HasDisciplinarySanctions :=provRec.VerificationInfo[1].hasDisciplinarySanctions;
		self.SanctionIds := project(choosen(dedup(sort(provSancid,record),record),iesp.Constants.HPR.MAX_SANCTIONIDS),transform (iesp.share.t_StringArrayItem, Self.value := (string)Left.sanc_id));
		self.Sanctions := choosen(sancCombined_final,iesp.Constants.HPR.MAX_SANCTIONS)(cfg[1].IncludeSanctions);
		self.FEINs := choosen(dedup(sort(provFein,record),record),iesp.Constants.HPR.MAX_TAXIDS);
		self.NPIReports := choosen(provRec.NPIRaw,iesp.Constants.HPR.MAX_NPIS);
		medicareinfo := if(hasProv,provRec.optouts);
		self.MedicareOptOuts.AffidavitReceivedDate := if(exists(medicareinfo(optout_rec_dt<>'')),project(medicareinfo(optout_rec_dt<>'')[1], transform (iesp.share.t_Date, Self := iesp.ECL2ESP.toDatestring8(Left.optout_rec_dt))));
		self.MedicareOptOuts.OptOutEffectiveDate := if(exists(medicareinfo(optout_eff_dt<>'')),project(medicareinfo(optout_eff_dt<>'')[1], transform (iesp.share.t_Date, Self := iesp.ECL2ESP.toDatestring8(Left.optout_eff_dt))));
		self.MedicareOptOuts.OptOutTerminationDate := if(exists(medicareinfo(optout_term_dt<>'')),project(medicareinfo(optout_term_dt<>'')[1], transform (iesp.share.t_Date, Self := iesp.ECL2ESP.toDatestring8(Left.optout_term_dt))));
		self.MedicareOptOuts.OptOutStatus := if(exists(medicareinfo(optout_status<>'')),medicareinfo[1].optout_status,'');
		self.MedicareOptOuts.OptOutSiteDescription := if(exists(medicareinfo(optout_sitedesc<>'')),medicareinfo[1].optout_sitedesc,'');
		self.Relatives := if (inputData.IncludeRelativesOnlyWhenDeadOrWithSanctions,RelativeDataWSanctionsFilter(HasLEIESanctions=true or HasEPLSSanctions=true or IsDeceased=true),RelativeDataWSanctions);
		self.Neighbors := Neighbors;
		self.Associates :=  Associates;
		self.HistoricalNeighbors := map(isIndiv=>choosen(mod_person.dsHistoricalNeighbors(inputData.IncludeHistoricalNeighbors),iesp.Constants.BR.MaxHistoricalNeighborhood),dataset ([], iesp.bpsreport.t_HistoricalNeighbor));
		self.DODs := iesp.ECL2ESP.toDatestring8(provRec.DateofDeath);
		self.IsSexualOffender := exists(sexOff);
		self.SexualOffenderId := sexOffIDs;
		self.SexOffenderRecords := sexOff;
		self.HasCriminalConviction := exists(crimOff);
		self.CriminalConvictionIds := choosen(project(crimOff, transform(iesp.share.t_StringArrayItem, Self.value := Left.OffenderId)),iesp.Constants.BR.MaxCrimRecords);
		self.CriminalRecords := choosen(crimOff,iesp.Constants.BR.MaxCrimRecords);
		self.HasCorporateAffiliation := exists(corpsFinal);
		self.CorporateAffiliations := choosen(dedup(sort(corpsFinal,record),record),iesp.Constants.BR.MaxCorpAffiliations);
		self.ProfessionalLicenses := dedup(sort(choosen(provRec.ProfLicRaw(inputData.IncludeProfessionalLicenses),iesp.Constants.BR.MaxProfLicenses),SourceState,LicenseNumber,LicenseType,-ExpirationDate,-StatusEffectiveDate),SourceState,LicenseNumber,LicenseType,ExpirationDate.YEAR,ExpirationDate.MONTH,ExpirationDate.DAY,StatusEffectiveDate.YEAR,StatusEffectiveDate.MONTH,StatusEffectiveDate.DAY);
		self.DEAInformation :=  dedup(sort(choosen(provRec.DEARaw(inputData.IncludeDEAInformation),iesp.constants.HPR.MAX_DEAS),Number,RegistrationNumber,-ExpirationDate),Number,RegistrationNumber,ExpirationDate.YEAR,ExpirationDate.MONTH,ExpirationDate.DAY);
		self.HasBankruptcy := exists(bnkrptInd) or exists(bnkrptBus);
		self.Bankruptcies := choosen(bnkrptInd+bnkrptBus,iesp.Constants.BR.MaxBankruptcies);
		self.LiensJudgments := choosen(liensInd+liensBus,iesp.Constants.BR.MaxLiensJudgments);
		self.GSASanctions := choosen(gsa,iesp.constants.MAX_GSA_VERIFICATION_RESPONSE_RECORDS);
		self.CLIARecords := clia;
		self.IndividualInstantID :=  IID;
		self.BusinessInstantID := BID;
		self.Verifications := if(inputData.IncludeVerifications,project(provRec.VerificationInfo,transform(iesp.healthcare.t_HealthCareReportVerifications, self:=left))[1]);
		self.BoardCertifiedRecords := provRec.abmsRaw;
		self := [];
	end;
	resultsFinal := dataset([formatRow()]);
	// hasSomething2Report := if(prov.tooManyDidsFound,false,Healthcare_Provider_Services.raw.verifyResults(resultsFinal));
	hasSomething2Report := Healthcare_Report_Services.Individual_ReportService_Functions.verifyResults(resultsFinal);
	emptyBase						:= dataset([],iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportProviderEx);
	foundRecords := exists(prov);// or sanc.sancDidFound or sanc.sancBDidFound or sanc.sancidFound;
	noHit := not exists(prov);// and sanc.noSancRecordsFound;
	
	/* ********************************************
	 *              Clean Up Inputs               *
	 **********************************************/
	STRING25 Model := '' : STORED('Model_Request');
	UNSIGNED1 NumWarningCode := 4 : STORED('NumberOfWarningCodes');
	UNSIGNED1 DPPAPurp := 0 : STORED('DPPAPurpose');
	UNSIGNED1 GLBPurp := 8 : STORED('GLBPurpose');
	STRING50 DRestrictionMask := Risk_Indicators.iid_constants.default_DataRestriction : STORED('DataRestrictionMask');
	emptyRecord := dataset([{1}], {unsigned a});
	HistoryDate := 999999; // Realtime Only
	gateway := Gateway.Constants.void_gateway;
	Risk_Indicators.Layout_Provider_Scoring.Input sequenceInput(emptyRecord le, UNSIGNED6 seqCounter) := TRANSFORM
		SELF.seq := seqCounter;
		SELF.AcctNo := (STRING)seqCounter;
		
		// Name
		SELF.Provider_Full_Name := TRIM(srcRptBy.Name.Full);
		SELF.Provider_First_Name := TRIM(srcRptBy.Name.First);
		SELF.Provider_Middle_Name := TRIM(srcRptBy.Name.Middle);
		SELF.Provider_Last_Name := TRIM(srcRptBy.Name.Last);
		SELF.Provider_Business_Name := TRIM(srcRptBy.CompanyName);
		// Address
		streetName := TRIM(srcRptBy.Address.StreetName);
		streetNumber := TRIM(srcRptBy.Address.StreetNumber);
		streetPreDirection := TRIM(srcRptBy.Address.StreetPreDirection);
		streetPostDirection := TRIM(srcRptBy.Address.StreetPostDirection);
		streetSuffix := TRIM(srcRptBy.Address.StreetSuffix);
		UnitNumber := TRIM(srcRptBy.Address.UnitNumber);
		UnitDesig := TRIM(srcRptBy.Address.UnitDesignation);
		tempStreetAddr := Address.Addr1FromComponents(streetNumber, StreetPreDirection,	streetName, StreetSuffix, StreetPostDirection, UnitDesig, UnitNumber);
		SELF.StreetAddress1 := IF(TRIM(srcRptBy.Address.StreetAddress1) = '', tempStreetAddr, srcRptBy.Address.StreetAddress1);
		SELF.StreetAddress2 := TRIM(srcRptBy.Address.StreetAddress2);
		SELF.City := TRIM(srcRptBy.Address.City);
		SELF.St := TRIM(srcRptBy.Address.State);
		SELF.Zip := TRIM(srcRptBy.Address.Zip5);
		// Other PII
		SELF.SSN := TRIM(srcRptBy.SSN);
		SELF.DateOfBirth := TRIM(iesp.ECL2ESP.t_DateToString8(srcRptBy.DOB));
		SELF.BusinessPhone := TRIM(srcRptBy.Phone10);
		SELF.FEIN := IF(TRIM(srcRptBy.TaxID) = '', TRIM(srcRptBy.FEIN), TRIM(srcRptBy.TaxID));
		SELF.Medical_License := TRIM(srcRptBy.LicenseNumber);
		
		SELF.HistoryDateYYYYMM := HistoryDate;
		SELF := [];
	END;
	ProviderScoringRequest_Sequenced := PROJECT(emptyRecord, sequenceInput(LEFT, COUNTER));
	BocaShellVersion := MAP(
													Model = 'HCP1206_0' => 4,
																								 0
													);

	/* ********************************************
	 *    Get Boca Shell and Healthcare Data      *
	 **********************************************/
	// Don't do the work if we don't have a valid model request!
	BocaShell_HealthcareShell := IF(BocaShellVersion > 0, Risk_Indicators.ProviderScoring_Search_Function(ProviderScoringRequest_Sequenced, BocaShellVersion, DPPAPurp, GLBPurp, DRestrictionMask, HistoryDate, gateway),
																												DATASET([], Risk_Indicators.Layout_Provider_Scoring.Clam_Plus_Healthcare));

	/* ********************************************
	 *             Get Model Results              *
	 **********************************************/
	modelResult := MAP(
											Model = 'HCP1206_0' => Models.HCP1206_0_0(BocaShell_HealthcareShell, NumWarningCode),
											Model = ''					=> DATASET([], Models.Layout_ModelOut),
																						 FAIL(Models.Layout_ModelOut, 'Invalid/unknown model request: ' + Model)
										);
	
	/* *************************************
	 *    Convert Model Results to ESDL:   *
   ***************************************/
	iesp.providerintegrityscore.t_PSSequencedRiskIndicator getRIs(Risk_Indicators.Layout_Desc modelRIs, UNSIGNED RIOrder) := TRANSFORM
		SELF.Sequence := RIOrder;
		SELF.RiskCode := modelRIs.hri;
		SELF.Description := Risk_Indicators.getHRIDesc(modelRIs.hri);
	END;
	iesp.providerintegrityscore.t_PSScore getScores(Models.Layout_ModelOut modelScore) := TRANSFORM
		SELF.Value := (INTEGER)modelScore.Score;
		SELF.RiskIndicators := PROJECT(modelScore.ri, getRIs(LEFT, COUNTER));
		SELF._Type := MAP(Model = 'HCP1206_0' => 'HealthcareProvider',
																											'');
	END;
	iesp.providerintegrityscore.t_PSModel intoModel(modelResult le) := TRANSFORM
		SELF.Name := Model;
		SELF.Scores := PROJECT(le, getScores(LEFT));
	END;
	
	scoreResults := PROJECT(modelResult, intoModel(LEFT));

	// Format output to iesp
	iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportResponse format() := transform
				string q_id := '' : stored ('_QueryId');
				string t_id := '' : stored ('_TransactionId');
				string msg	:= 'Your subject cannot be uniquely identified.  Please include additional identifying information such as Name, Address, SSN, DOB or Provider ID Number.';
				badheader := ROW ({203, msg, q_id, t_id, [], []}, iesp.share.t_ResponseHeader);
				goodheader := ROW ({0, '', q_id, t_id, [], []}, iesp.share.t_ResponseHeader);
				self._Header         := map(hasSomething2Report or noHit =>goodheader,
																		badheader);
				self.reportby				 := srcRptBy;
				self.RecordCount 		 := if(hasSomething2Report,count(resultsFinal),0);
				self.HealthCareProviders := if(hasSomething2Report,resultsFinal,emptyBase);
				self.Models					 := scoreResults;
	end;

	recs := dataset([format()]);

	// output(searchByCriteria,named('searchcreiteria'),extend);;
 //output(provdata,named('provdata'),extend);
 // output(resultsFinal,named('resultsFinal'),extend);
	//output(inputData);
	// output(dsDids,named('dsDids'));
	// output(dsDids2,named('dsDids2'));
	// output(dsBdids,named('dsBdids'));
	// output(prov[1]);
	// output(sanc);
	// output(nppes,named('nppes'));
	// output(tmp_nppes_layout);
	// output(nppes_penalty);
	// output(nppes_fmt);
	// output(echo,named('echo'));
	// output(rel,named('rel'));
	// output(neigh,named('neigh'));
	// output(assoc,named('assoc'));
	// output(hNeigh,named('hNeigh'));
	// output(dod,named('dod'));
	// output(deathFlg,named('deathFlg'));
	// output(sexOff,named('sexOff'));
	// output(sexOffIDs,named('sexOffIDs'));
	// output(crimOff,named('crimOff'));
	// output(corpsInd,named('corpsInd'));
	// output(corpsBus,named('corpsBus'));
	// output(profLic,named('profLic'));
	// output(dea,named('dea'));
	// output(bnkrptInd,named('bnkrptInd'));
	// output(bnkrptBus,named('bnkrptBus'));
	// output(liensInd,named('liensInd'));
	// output(liensBus,named('liensBus'));
	// output(gsa,named('gsa'));
	// output(iid,named('iid'));
	// output(biid,named('biid'));
 //output(inputData,named('inputData'),extend);;
	 //output(inputData,named('inputData'),extend);;
//output(inputData);	
//output(tmpMod);	
	//output(searchByCriteria,named('ReportService_RecordssearchByCriteria'),extend);
	// output('Testdata',named('TestingBeforeProvdata'));
   //output(provdata);
	// output('Testing',named('TestingafterProvdata'));
  // output(prov,named('prov'),extend);
  // output(isindiv,named('isindiv'),overwrite);
 // output(resultsFinal,named('resultsFinal'),extend);
 // output(gsa,named('gsa'),extend);
 // output(clia,named('clia'),extend);
	//output(inputData);
	// output(dsDids,named('dsDids'));
	// output(dsDids2,named('dsDids2'));
	// output(dsBdids,named('dsBdids'));
	// output(prov[1]);
	// output(sanc);
	// output(nppes,named('nppes'));
	// output(tmp_nppes_layout);
	// output(nppes_penalty);
	// output(nppes_fmt);
	// output(echo,named('echo'));
	// output(rel,named('rel'));
	// output(neigh,named('neigh'));
	// output(assoc,named('assoc'));
	// output(hNeigh,named('hNeigh'));
	// output(dod,named('dod'));
	// output(deathFlg,named('deathFlg'));
	// output(sexOff,named('sexOff'));
	// output(sexOffIDs,named('sexOffIDs'));
	// output(crimOff,named('crimOff'));
	// output(corpsInd,named('corpsInd'));
	// output(corpsBus,named('corpsBus'));
	// output(profLic,named('profLic'));
	// output(dea,named('dea'));
	// output(bnkrptInd,named('bnkrptInd'));
	// output(bnkrptBus,named('bnkrptBus'));
	// output(liensInd,named('liensInd'));
	// output(liensBus,named('liensBus'));
	// output(gsa,named('gsa'));
	// output(iid,named('iid'));
	// output(biid,named('biid'));
//output(recs);

	return recs;
	
END;
