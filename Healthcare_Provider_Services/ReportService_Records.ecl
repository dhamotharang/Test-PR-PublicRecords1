EXPORT ReportService_Records := Module
 #option ('expandSelectCreateRow', true);
 import DOXIE, iesp, ut, Address, Risk_Indicators, Models, Gateway, Healthcare_Header_Services, Healthcare_Report_Services;
 Shared getModel(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportBy srcRptBy) := function
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
	
	return PROJECT(modelResult, intoModel(LEFT));
 End;
 Export getIndiv(Healthcare_Header_Services.IParams.ReportParams inputData,
                             doxie.IDataAccess mod_access,
                             iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportBy srcRptBy,
														 dataset(Healthcare_Header_Services.Layouts.common_runtime_config) cfg) := FUNCTION
	tmpMod:= MODULE(PROJECT(inputData, Healthcare_Header_Services.IParams.searchParams,opt)) END;
	searchByCriteria := Healthcare_Header_Services.Records.convertInputtoDataset(tmpMod);
	provdata := Healthcare_Header_Services.Records.getRecordsRawDoxieIndividual(searchByCriteria,cfg)(srcid>0);
	prov := choosen(provdata(record_penalty=min(provdata,record_penalty)),1);
	dsDids := choosen(project(prov[1].dids,doxie.layout_references),iesp.Constants.HPR.MAX_UNIQUEIDS);
	dsDids2 := choosen(project(prov[1].dids,transform(doxie.layout_best, self:=left; self := [])),iesp.Constants.HPR.MAX_UNIQUEIDS);
	dsBDids := dataset([],doxie.layout_ref_bdid);

	/* If GSA records were requested and exist, then remove them from the regular sanction data as they are being reported in the GSA data */
	gsa := Healthcare_Provider_Services.GSA_Records(inputData).dsGSA(inputData.IncludeGSASanctions);
	//Add logic to support IncludeRelativesOnlyWhenDeadOrWithSanctions for Relative and Associates

  mod_person := Healthcare_Provider_Services.Person_Records(inputData,mod_access,dsDids); 
	RelativeData := choosen(mod_person.dsRelatives(inputData.IncludeRels),iesp.Constants.BR.MaxRelatives);
	AssociatesData := choosen(mod_person.dsAssociates(inputData.IncludeAssoc),iesp.Constants.BR.MaxAssociates);
	//Project the Relative data to get only the dids.
	RelSlimData := project(relativeData, transform(doxie.layout_references, self.did:=(integer)left.UniqueId;));
	//Call the header to get Sanctions and death
	rawRecsRel := normalize(Healthcare_Header_Services.Records.getRecordsRawDoxiebyDid(RelSlimData,cfg),left.dids,transform(Healthcare_Provider_Services.layouts.CombinedHeaderResults,self.SrcId:=right.did;self:=left));
	//Project the Associates data to get only the dids.
	AssocSlimData := project(AssociatesData, transform(doxie.layout_references, self.did:=(integer)left.UniqueId;));
	//Call the header to get Sanctions and death
	rawRecsAssoc := normalize(Healthcare_Header_Services.Records.getRecordsRawDoxiebyDid(AssocSlimData,cfg),left.dids,transform(Healthcare_Provider_Services.layouts.CombinedHeaderResults,self.SrcId:=right.did;self:=left));
	//Join the data back to populate flags
	RelativeDataWSanctions := project(RelativeData,transform(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportRelative,self:=left;self:=[];));
	RelativeDataWSanctionsFilter := Join(RelativeData,rawRecsRel,(integer)left.UniqueId=right.SrcId,transform(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportRelative,self.IsDeceased:=right.status='D';self.HasLEIESanctions:=right.hasOIG;self.HasEPLSSanctions:=right.hasOPM;self:=left));
	AssociatesDataWSanctions := project(AssociatesData,transform(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportAssociate,self:=left;self:=[];));
	AssociatesDataWSanctionsFilter := Join(AssociatesData,rawRecsAssoc,(integer)left.UniqueId=right.SrcId,transform(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportAssociate,self.IsDeceased:=right.status='D';self.HasLEIESanctions:=right.hasOIG;self.HasEPLSSanctions:=right.hasOPM;self:=left));
	Neighbors := choosen(mod_person.dsNeighbors(inputData.IncludeNeighs),iesp.Constants.BR.MaxNeighborhood);
	Associates :=  if (inputData.IncludeRelativesOnlyWhenDeadOrWithSanctions,AssociatesDataWSanctionsFilter(HasLEIESanctions=true or HasEPLSSanctions=true or IsDeceased=true),AssociatesDataWSanctions);
	//End logic to support IncludeRelativesOnlyWhenDeadOrWithSanctions for Relative and Associates
	sexOff	:= Healthcare_Provider_Services.SexualOffender_Records(inputData,mod_access,dsDids).sexOffenderOffenses;
	sexOffIDs := Healthcare_Provider_Services.SexualOffender_Records(inputData,mod_access,dsDids).sexOffenderOffenderIds;
	crimOff	:= Healthcare_Provider_Services.CriminalOffender_Records(inputData,mod_access,dsDids).dsCriminalRecords(inputData.IncludeCriminalRecords);
	//Add logic to support IncludeCorporateAffiliationsOnlyWhenSanctions for Business Individuals and Companies
	corpsInd := Healthcare_Provider_Services.Corps_Records(dsDids,dsBdids).dsCorporateAffiliations(inputData.IncludeCorporateAffiliations);	
	corpsMerge := corpsInd;
	CorpSlimData := project(corpsMerge, transform(doxie.layout_ref_bdid, self.bdid:=(integer)left.BusinessId;));
	CorpsDataWSanctions := project(corpsMerge,transform(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportAffiliation,self:=left;self:=[];));
	corpsCombined := project(corpsMerge,transform(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportAffiliation, self:=left;self:=[]));
	corpsFinal := if (inputData.IncludeCorporateAffiliationsOnlyWhenSanctions,CorpsDataWSanctions(HasLEIESanctions=true or HasEPLSSanctions=true),corpsCombined);
	//End Add logic to support IncludeCorporateAffiliationsOnlyWhenSanctions for Business Individuals and Companies
	bnkrptInd := Healthcare_Provider_Services.Bankruptcies_Records(dsDids,dsBdids).dsBankruptciesIndividual(inputData.IncludeBankruptcies);
	liensInd := Healthcare_Provider_Services.Liens_Records(dsDids,dsBdids).dsLiensJudgmentsInd(inputData.IncludeLiensJudgments);
	doIID := inputData.IncludeIndividualInstantID;
	IID :=  map(doIID => Healthcare_Provider_Services.IndividualInstantID_Records().dsIndividualID,dataset([],iesp.instantid.t_InstantIDResult)[1]);
	
	iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportProviderEx formatIndivRow() := transform
		hasProv := exists(prov);
		provRec:=if(hasProv,prov[1]);
		provIDs := project(provRec.dids(did > 0), transform (iesp.share.t_StringArrayItem, Self.value := (string)(unsigned6)Left.did));
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
		self.HistoricalNeighbors := choosen(mod_person.dsHistoricalNeighbors(inputData.IncludeHistoricalNeighbors),iesp.Constants.BR.MaxHistoricalNeighborhood);
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
		self.HasBankruptcy := exists(bnkrptInd);
		self.Bankruptcies := choosen(bnkrptInd,iesp.Constants.BR.MaxBankruptcies);
		self.LiensJudgments := choosen(liensInd,iesp.Constants.BR.MaxLiensJudgments);
		self.GSASanctions := choosen(gsa,iesp.constants.MAX_GSA_VERIFICATION_RESPONSE_RECORDS);
		self.IndividualInstantID :=  IID;
		self.Verifications := if(inputData.IncludeVerifications,project(provRec.VerificationInfo,transform(iesp.healthcare.t_HealthCareReportVerifications, self:=left))[1]);
		self.BoardCertifiedRecords := provRec.abmsRaw;
		self := [];
	end;
	resultsIndivFinal := dataset([formatIndivRow()]);
	hasIndivSomething2Report := Healthcare_Report_Services.Individual_ReportService_Functions.verifyResults(resultsIndivFinal);
	emptyIndivBase						:= dataset([],iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportProviderEx);
	foundIndivRecords := exists(prov);// or sanc.sancDidFound or sanc.sancBDidFound or sanc.sancidFound;
	noIndivHit := not exists(prov);// and sanc.noSancRecordsFound;
	
	scoreIndivResults := getModel(srcRptBy);

	// Format output to iesp
	iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportResponse formatIndiv() := transform
				string q_id := '' : stored ('_QueryId');
				string t_id := '' : stored ('_TransactionId');
				string msg	:= 'Your subject cannot be uniquely identified.  Please include additional identifying information such as Name, Address, SSN, DOB or Provider ID Number.';
				badheader := ROW ({203, msg, q_id, t_id, [], []}, iesp.share.t_ResponseHeader);
				goodheader := ROW ({0, '', q_id, t_id, [], []}, iesp.share.t_ResponseHeader);
				self._Header         := map(hasIndivSomething2Report or noIndivHit =>goodheader,
																		badheader);
				self.reportby				 := srcRptBy;
				self.RecordCount 		 := if(hasIndivSomething2Report,count(resultsIndivFinal),0);
				self.HealthCareProviders := if(hasIndivSomething2Report,resultsIndivFinal,emptyIndivBase);
				self.Models					 := scoreIndivResults;
	end;

	recs := dataset([formatIndiv()]);
	return recs;
 end;	
 Export getBus(Healthcare_Header_Services.IParams.ReportParams inputData,
                             doxie.IDataAccess mod_access,
                             iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportBy srcRptBy,
														 dataset(Healthcare_Header_Services.Layouts.common_runtime_config) cfg) := FUNCTION
	tmpMod:= MODULE(PROJECT(inputData, Healthcare_Header_Services.IParams.searchParams,opt)) END;
	searchByCriteria := Healthcare_Header_Services.Records.convertInputtoDataset(tmpMod);
	provdata := Healthcare_Header_Services.Records.getRecordsRawDoxieBusinessLegacy(searchByCriteria,cfg)(srcid>0);
	prov := choosen(provdata(record_penalty=min(provdata,record_penalty)),1);
	dsDids := dataset([],doxie.layout_references);
	dsBDids := choosen(project(prov[1].bdids,doxie.layout_ref_bdid),iesp.Constants.HPR.MAX_UNIQUEIDS);
	hasBDids := exists(dsBDids);
	gsa := Healthcare_Provider_Services.GSA_Records(inputData).dsGSA(inputData.IncludeGSASanctions);
	clia := Healthcare_Provider_Services.CLIA_Records(inputData).dsCLIA(inputData.IncludeCLIA);
	corpsBus := Healthcare_Provider_Services.Corps_Records(dsDids,dsBdids).dsBusinessCorporateRecords(inputData.IncludeCorporateAffiliations and hasBDids);	
	corpsMerge := corpsBus;
	CorpSlimData := project(corpsMerge, transform(doxie.layout_ref_bdid, self.bdid:=(integer)left.BusinessId;));
	CorpsDataWSanctions := project(corpsMerge,transform(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportAffiliation,self:=left;self:=[];));
	corpsCombined := project(corpsMerge,transform(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportAffiliation, self:=left;self:=[]));
	corpsFinal := if (inputData.IncludeCorporateAffiliationsOnlyWhenSanctions,CorpsDataWSanctions(HasLEIESanctions=true or HasEPLSSanctions=true),corpsCombined);
	bnkrptBus := Healthcare_Provider_Services.Bankruptcies_Records(dsDids,dsBdids).dsBankruptciesBusiness(inputData.IncludeBankruptcies and hasBDids);
	liensBus := Healthcare_Provider_Services.Liens_Records(dsDids,dsBdids).dsLiensJudgmentsBus(inputData.IncludeLiensJudgments and hasBDids);
	doBID := inputData.IncludeBusinessInstantID;
	BID := map(doBID => Healthcare_Provider_Services.BusinessInstantID_Records(inputData).dsBusinessID,dataset([],iesp.instantid.t_BusinessInstantIDResult)[1]);
	iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportProviderEx formatBusRow() := transform
		hasProv := exists(prov);
		provRec:=if(hasProv,prov[1]);
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
		self.BusinessIds := choosen(dedup(sort(busID+sancBusID,record),record),iesp.constants.HPR.MAX_UNIQUEIDS);
		self.Names := choosen(provNames,iesp.Constants.HPR.MAX_NAMES);
		self.Languages := project(choosen(dedup(provRec.languages,all,hash),iesp.Constants.HPR.MAX_LANGUAGES), transform (iesp.share.t_StringArrayItem, Self.value := Left.language));
		self.TaxIds := project(choosen(provRec.taxids,iesp.Constants.HPR.MAX_TAXIDS), transform (iesp.share.t_StringArrayItem, Self.value := Left.taxid));
		self.UPINs := project(choosen(dedup(sort(provRec.upins,upin),upin),iesp.Constants.HPR.MAX_UPINS), transform (iesp.share.t_StringArrayItem, Self.value := Left.upin));
		npi_dup_rec := choosen(dedup(sort(provRec.npis,npi),npi),iesp.Constants.HPR.MAX_NPIS);
		self.NationalProviderIds := if(hasProv,project(choosen(npi_dup_rec,iesp.Constants.HPR.MAX_NPIS), transform (iesp.share.t_StringArrayItem, Self.value := Left.npi)));
		self.NPPESVerified := provRec.NPPESVerified;
		sancCombined_final:=project(sancCombined, transform(recordof(sancCombined), self.NationalProviderId:=npi_dup_rec[1].npi;self:=left));
		self.GroupAffiliations := project(choosen(dedup(sort(provRec.affiliates,stringlib.StringToLowerCase(name)),stringlib.StringToLowerCase(name)),iesp.Constants.HPR.MAX_GROUPAFFILIATIONS), transform (iesp.healthcare.t_ProviderRelatedEntity, self.BusinessId:= (string)left.bdid,self:=left;self:=[];))(cfg[1].IncludeGroupAffiliations);
		self.HospitalAffiliations := project(choosen(dedup(sort(provRec.hospitals,stringlib.StringToLowerCase(name)),stringlib.StringToLowerCase(name)),iesp.Constants.HPR.MAX_HOSPITALAFFILIATIONS),  transform (iesp.healthcare.t_ProviderRelatedEntity,  self.BusinessId:=(string)left.bdid,self:=left;self:=[];))(cfg[1].IncludeHospitalAffiliations);
		self.Residencies := project(choosen(dedup(sort(provRec.Residencies,residency),residency),iesp.Constants.HPR.MAX_RESIDENCIES), transform(iesp.healthcare.t_ProviderRelatedEntity, self.BusinessId:= left.bdid, self.Name:=left.residency;self:=[];))(cfg[1].IncludeResidencies);
		self.Specialties := project(choosen(dedup(sort(provRec.Specialties(specialtyname<>''),specialtyname,specialtygroupname),stringlib.StringToLowerCase(specialtyname),stringlib.StringToLowerCase(specialtygroupname)),iesp.Constants.HPR.MAX_SPECIALTIES),transform(iesp.healthcare.t_Specialty, self.SpecialtyId:=(String)left.specialtyid, self.SpecialtyName:=left.specialtyname, self.GroupId:=(String)left.specialtygroupid, self.GroupName:=left.specialtygroupname))(cfg[1].IncludeSpecialties);
		self.BusinessAddresses := choosen(provBusAddr,iesp.Constants.HPR.MAX_BUSINESSADDRESSES)(inputData.IncludeBusinessAddresses);
		self.Licenses := project(choosen(provRec.StateLicenses,iesp.Constants.HPR.MAX_LICENSES), transform(iesp.healthcare.t_ProviderLicenseInfo, self.LicenseState:=left.licensestate, self.LicenseNumber :=left.licensenumber, self.EffectiveDate:=iesp.ECL2ESP.toDatestring8(Left.effective_date), self.ExpirationDate:=iesp.ECL2ESP.toDatestring8(Left.termination_date),self.LicenseSeqID:=left.licenseseq,self.LicenseNumberOrig:=left.licensenumberfmt,self:=left,self:=[]))(cfg[1].IncludeLicenses);
		//For Header Results
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
		self.HasCorporateAffiliation := exists(corpsFinal);
		self.CorporateAffiliations := choosen(dedup(sort(corpsFinal,record),record),iesp.Constants.BR.MaxCorpAffiliations);
		self.ProfessionalLicenses := dedup(sort(choosen(provRec.ProfLicRaw(inputData.IncludeProfessionalLicenses),iesp.Constants.BR.MaxProfLicenses),SourceState,LicenseNumber,LicenseType,-ExpirationDate,-StatusEffectiveDate),SourceState,LicenseNumber,LicenseType,ExpirationDate.YEAR,ExpirationDate.MONTH,ExpirationDate.DAY,StatusEffectiveDate.YEAR,StatusEffectiveDate.MONTH,StatusEffectiveDate.DAY);
		self.DEAInformation :=  dedup(sort(choosen(provRec.DEARaw(inputData.IncludeDEAInformation),iesp.constants.HPR.MAX_DEAS),Number,RegistrationNumber,-ExpirationDate),Number,RegistrationNumber,ExpirationDate.YEAR,ExpirationDate.MONTH,ExpirationDate.DAY);
		self.HasBankruptcy := exists(bnkrptBus);
		self.Bankruptcies := choosen(bnkrptBus,iesp.Constants.BR.MaxBankruptcies);
		self.LiensJudgments := choosen(liensBus,iesp.Constants.BR.MaxLiensJudgments);
		self.GSASanctions := choosen(gsa,iesp.constants.MAX_GSA_VERIFICATION_RESPONSE_RECORDS);
		self.CLIARecords := clia;
		self.BusinessInstantID := BID;
		self.Verifications := if(inputData.IncludeVerifications,project(provRec.VerificationInfo,transform(iesp.healthcare.t_HealthCareReportVerifications, self:=left))[1]);
		self := [];
	end;
	resultsBusFinal := dataset([formatBusRow()]);
	hasBusSomething2Report := Healthcare_Report_Services.Individual_ReportService_Functions.verifyResults(resultsBusFinal);
	emptyBusBase						:= dataset([],iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportProviderEx);
	foundBusRecords := exists(prov);// or sanc.sancDidFound or sanc.sancBDidFound or sanc.sancidFound;
	noBusHit := not exists(prov);// and sanc.noSancRecordsFound;
	scoreResults := getModel(srcRptBy);
	// Format output to iesp
	iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportResponse formatBus() := transform
				string q_id := '' : stored ('_QueryId');
				string t_id := '' : stored ('_TransactionId');
				string msg	:= 'Your subject cannot be uniquely identified.  Please include additional identifying information such as Name, Address, SSN, DOB or Provider ID Number.';
				badheader := ROW ({203, msg, q_id, t_id, [], []}, iesp.share.t_ResponseHeader);
				goodheader := ROW ({0, '', q_id, t_id, [], []}, iesp.share.t_ResponseHeader);
				self._Header         := map(hasBusSomething2Report or noBusHit =>goodheader,
																		badheader);
				self.reportby				 := srcRptBy;
				self.RecordCount 		 := if(hasBusSomething2Report,count(resultsBusFinal),0);
				self.HealthCareProviders := if(hasBusSomething2Report,resultsBusFinal,emptyBusBase);
				self.Models					 := scoreResults;
	end;

	recs := dataset([formatBus()]);
	return recs;
 End;
END;
