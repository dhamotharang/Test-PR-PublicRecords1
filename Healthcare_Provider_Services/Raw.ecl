
IMPORT AMS, AMS_Services, Business_Header, doxie, doxie_cbrs, doxie_files, iesp,AutoHeaderI, 
       Ingenix_NatlProf, NPPES, Prof_LicenseV2_Services;

EXPORT Raw := MODULE 

	EXPORT getReportDids(IParams.reportParams aInputData) := FUNCTION
			//Deep dive Indivdial dids
			tempmod := module(project(aInputData,AutoheaderI.LIBIN.FetchI_Hdr_Indv.full,opt))
					export noFail := true;
				end;
			deep_dids	:= limit( AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do(tempmod), 100, skip);

			//accumulate dids by input and autoheaderi lookups.
			// in_did := dataset ([(unsigned6) aInputData.did],doxie.layout_references); 	//User provided DID
			// ds_dids := project(in_did,transform(layouts.deepDids,self:=left));
			all_dids := project(deep_dids,transform(layouts.deepDids,self.isdeepdive := true; self:=left));
			// all_dids := dedup(sort(ds_dids + if(aInputData.isDeepDive,ds_deep_dids),did),did);

			return all_dids;
	END;

	EXPORT getReportBDids(IParams.reportParams aInputData) := FUNCTION
			//Deep dive Bdids
			tempmod := module(project(aInputData,AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,opt))
				export boolean score_results := false;
				export boolean noFail := true;
			end;
			deep_bdids_1 := limit( project(AutoHeaderI.LIBCALL_FetchI_Hdr_Biz.do(tempmod),doxie_cbrs.layout_references), 100, skip);
			deep_bdids_2 := project(Business_Header.doxie_get_bdids_plus(),doxie_cbrs.layout_references);
			deep_bdids := if(exists(deep_bdids_1),deep_bdids_1,deep_bdids_2);

			//accumulate bdids by input and autoheaderi lookups.
			in_bdid := dataset ([(unsigned6) aInputData.bdid],doxie_cbrs.layout_references); 	//User provided BDID
			ds_bdids := project(in_bdid,transform(layouts.deepBDids,self:=left));
			ds_deep_bdids := project(deep_bdids,transform(layouts.deepBDids,self.isdeepdive := true; self:=left));
			all_bdids := dedup(sort(ds_bdids + if(aInputData.isDeepDive,ds_deep_bdids),bdid),bdid);
			return all_bdids;
	END;
	EXPORT getNPPESdata(IParams.reportParams aInputData, doxie.ingenix_provider_module.layout_ingenix_provider_report providersRaw) := FUNCTION
			//Get NPPESData
			input_npi := dataset([{aInputData.NPI}], Layouts.npis);
			rec_NPI	:= project(providersRaw.NPI,Layouts.npis);
			combinedNPI := input_npi(npi<>'')+rec_NPI(npi<>'');
			providers_by_npi_NPPES := NPPES.Key_NPPES_npi(npi=combinedNPI[1].npi);
			NPPESResults := dedup(sort(project(providers_by_npi_NPPES,transform(layouts.layout_NPPES_data,self.isdeepdive := false; self:=left)),record),record);
			return NPPESResults;
	END;
	EXPORT SanctionsRecords(IParams.searchParams aInputData, dataset(layouts.deepDids) all_dids, dataset(layouts.deepBDids) bdids, dataset(layouts.layout_sancid) userSuppliedSancSet=dataset([{''}],layouts.layout_sancid), dataset(layouts.layout_sancid) providerSancSet=dataset([{''}],layouts.layout_sancid)) := FUNCTION
		
		// get id's from autokeys for name, address, and ssn etc.
		sanc_ids_byak := AutoKey_Ids(aInputData).sanctions;	
		
		input_fein_final := if(aInputData.fein='', aInputData.taxid, aInputData.fein);
		input_feins_l_c_name := dataset([{input_fein_final, aInputData.CompanyName, aInputData.lastname}], Layouts.feins_l_c_name);
		sanc_ids_by_fein_name := join(input_feins_l_c_name, doxie_files.key_sanctions_taxid_name,
										 keyed(left.fein = right.l_taxid) and
										 keyed(if(left.cname ='', left.lname, left.cname) = right.l_fname), 
										 transform(Layouts.layout_sancid,  self.sanc_id:=(integer)right.sanc_id),
										 keep(Constants.MAX_RECS_ON_JOIN));

		sanc_ids_by_fein_only := join(input_feins_l_c_name, doxie_files.key_sanctions_taxid_name,
										 keyed(left.fein = right.l_taxid),
										 transform(Layouts.layout_sancid,  self.sanc_id:=(integer)right.sanc_id),
										 keep(Constants.MAX_RECS_ON_JOIN));
		
		sanc_ids_by_fein := if(count(dedup(sort(sanc_ids_by_fein_only,record),record))>1,
													sanc_ids_by_fein_name,
													sanc_ids_by_fein_only);

		//Autokey searches
		all_sids := dedup(sort(sanc_ids_byak,id),id);
		
		//get sanction id's by dids
		recs_sids_by_dids := Functions.getSIDSByDIDS(all_dids);
		
		//get sanction id's by bdids
		recs_sids_by_bdids := Functions.getSIDSByBDIDS(bdids);
		
		//get provider and sanction id's by autokey id's
		recs_by_ids := Functions.getPayloadByIDS(all_sids);
		
		//Gather all sanction id's 
		all_sanc_ids := dedup(sort(sanc_ids_by_fein + recs_by_ids + recs_sids_by_dids + recs_sids_by_bdids + userSuppliedSancSet + providerSancSet, sanc_id),sanc_id);
		sancs_by_sid := join(all_sanc_ids, doxie_files.key_sanctions_sancid,
											keyed((unsigned6)left.SANC_ID = right.l_sancid), 
											transform(Layouts.sanc_penalty_recs, self.sanc_id:=(string)left.sanc_id;self:=left; self:=right),
											 keep(Constants.MAX_RECS_ON_JOIN));
											 
		//Apply penalty to all resolved identities
		ds_pen_recs := Functions.apply_penalty(sancs_by_sid, aInputData);	
		
		ds_filter_by_pen := ds_pen_recs(record_penalty <= aInputData.penalty_threshold);

		//Get full response data for sanctions and providers.
		sids := set(ds_filter_by_pen,(integer)sanc_id);
		
		getSanctionRaw:= doxie.ING_sanctions_report_records(sids);
	RETURN getSanctionRaw;
		
	END;

	EXPORT SanctionsReportRecords(IParams.reportParams aInputData, dataset(layouts.deepDids) all_dids, dataset(layouts.deepBDids) bdids, dataset(layouts.layout_sancid) userSuppliedSancSet=dataset([{''}],layouts.layout_sancid), dataset(layouts.layout_sancid) providerSancSet=dataset([{''}],layouts.layout_sancid)) := FUNCTION
		tmpMod:= MODULE(PROJECT(aInputData, Healthcare_Provider_Services.IParams.searchParams,opt)) END;
		RETURN SanctionsRecords(tmpMod, all_dids, bdids, userSuppliedSancSet, providerSancSet);
	END;

	EXPORT ProvidersRecords(IParams.searchParams aInputData, dataset(layouts.deepDids) all_dids) := FUNCTION
		// No longer needed.
		/*	Business search by pass determine business and if business skip the provider search as providers data does
				not contain business data and the address only portion of the search causes lots of erroneous records to 
				get pulled
		*/
		/*
		isBusinessSearch := aInputData.CompanyName <> '' and aInputData.LastName = '';
		// get id's from autokeys for name, address, and ssn etc.
		prov_ids_byak := if(not isBusinessSearch,AutoKey_Ids(aInputData).providers);
		// get id's from NPPES which has both business and individual data to fill the business gap
		// nppes_byak :=  project(NPPES.Autokey_payload(),Transforms.nppesProvider(left));
		nppes_byak_raw := Functions.getNPPESByAutokeys(aInputData);		
		nppes_byak_penalt_recs := Functions.apply_penalty_nppes(nppes_byak_raw, aInputData);
		nppes_byak := project(nppes_byak_penalt_recs(record_penalty = nppes_byak_penalt_recs[1].record_penalty),Transforms.nppesProvider(left));
		//Autokey searches
		all_pids := dedup(sort(prov_ids_byak,id),id);
		
		//get provider and sanction id's by dids
		recs_pids_by_dids := if(not isBusinessSearch,Functions.getPIDSByDIDS(all_dids));	
		
		//get provider id's by autokey id's
		recs_by_pids := Functions.getPayloadByPIDS(all_pids);
		
		//License and Licens State
		providers_by_License_NoState := doxie_files.key_provider_license(LicenseNumber=aInputData.LicenseNumber);
		providers_by_License_State := providers_by_License_NoState(Licensestate=aInputData.LicenseState);

		providers_by_License_and_State := PROJECT(if(aInputData.LicenseState='',providers_by_License_NoState,providers_by_License_State),transform(layouts.layout_provid,self.prov_id:=(String)left.providerid));
		
		//FEIN or TaxID
		input_fein_final := if(not isBusinessSearch, aInputData.taxid, aInputData.fein);
		input_feins_l_c_name := dataset([{input_fein_final, aInputData.CompanyName, aInputData.lastname}], Layouts.feins_l_c_name);

		prov_ids_by_fein := join(input_feins_l_c_name, doxie_files.key_provider_taxid,
										 keyed(left.fein = right.l_taxid),
										 transform(Layouts.layout_provid, self.prov_id := right.providerid),
										 keep(Constants.MAX_RECS_ON_JOIN));

		//NPI and UPIN look up
		input_upin := dataset([{aInputData.Upin}], Layouts.upins);
		input_npi := dataset([{aInputData.NPI}], Layouts.npis);
		
		providers_by_upin := join(input_upin, Ingenix_NatlProf.key_ProviderID_UPIN,
											keyed(left.upin = right.l_upin), 
											transform(Layouts.layout_provid, self.prov_id := right.providerid),
											 keep(1), limit(0));
											
		providers_by_npi := join(input_npi, Ingenix_NatlProf.key_providerID_NPI,
											keyed(left.npi = right.l_npi), 
											transform(Layouts.layout_provid, self.prov_id := right.providerid),
											 keep(1), limit(0));
		//Get NPI from NPPES
		providers_by_npi_NPPES := join(input_npi, NPPES.Key_NPPES_npi,
											keyed(left.npi = right.npi), 
											Transforms.nppesProvider(project(right,transform(Layouts.NPPES_Layouts.nppes_penalty_recs,self:=left;self:=[]))),
											 keep(1), limit(0));
		
		//Gather all sanction id's and provider id's
		all_prov_ids := dedup(sort(recs_by_pids + providers_by_upin + providers_by_npi + recs_pids_by_dids + prov_ids_by_fein + providers_by_License_and_State, prov_id),prov_id);

		providers_by_pid := join(all_prov_ids, doxie_files.key_provider_id,
											keyed(left.prov_id = (string)right.l_providerid), 
											transform(Layouts.prov_penalty_recs, self:=left; self:=right),
											 keep(Constants.MAX_RECS_ON_JOIN));
		
		//Apply penalty to all resolved identities
		ds_pen_prov_recs := Functions.apply_penalty_prov(providers_by_pid, aInputData);	
		ds_filter_by_prov_pen := sort(ds_pen_prov_recs(record_penalty <= aInputData.penalty_threshold),record_penalty);
		
		//Get Provider Data based on supplied ProviderID
		userInputPid := dataset([{aInputData.providerid,false}],Prof_LicenseV2_Services.Layout_Search_Ids_Prov);
		//Get full response data for sanctions and providers.
		pids := project(ds_filter_by_prov_pen,transform(Prof_LicenseV2_Services.Layout_Search_Ids_Prov, self.providerid:= (unsigned6)left.providerid));
		finalPid:= if(count(userInputPid(providerid<>0))>0,userInputPid,pids);
		getProvidersRaw:= doxie.ING_provider_report_records(dedup(sort(finalPid,providerid),providerid));
		//If we do not have a provider then see if we have a providers_by_npi_NPPES or nppes_byak
		// output(nppes_byak);
		// output(recs_pids_by_dids);
		// output(recs_by_pids);
		// output(prov_ids_by_fein);
		// output(providers_by_upin);
		// output(providers_by_npi);
		// output(providers_by_npi_NPPES);
		// output(providers_by_pid);
		// output(ds_pen_prov_recs);
		// output(finalPid);
		finalProviderRecs := map(exists(getProvidersRaw)=> getProvidersRaw,
														 exists(providers_by_npi_NPPES) => dedup(sort(providers_by_npi_NPPES,record),record),
														 exists(nppes_byak)=> dedup(sort(nppes_byak,record),record),
														getProvidersRaw);
		RETURN finalProviderRecs;
		*/
		return '';
		
	END;

	EXPORT ProvidersReportRecords(IParams.reportParams aInputData, dataset(layouts.deepDids) all_dids) := FUNCTION
		// tmpMod:= MODULE(PROJECT(aInputData, Healthcare_Provider_Services.IParams.searchParams,opt)) END;
		// rollup records if possible
		// rawRecs := ProvidersRecords(tmpMod, all_dids);

		// doxie.ingenix_provider_module.layout_ingenix_provider_report rollit(doxie.ingenix_provider_module.layout_ingenix_provider_report L,doxie.ingenix_provider_module.layout_ingenix_provider_report R) := TRANSFORM
			// SELF.providerid := L.providerid;
			// self.gender := if(l.gender <> '',l.gender,r.gender);
			// self.gender_name := if(l.gender_name <> '',l.gender_name,r.gender_name);
			// self.sanc_flag := if(l.sanc_flag = true,l.sanc_flag,r.sanc_flag);
			// self.sanction_id := if(l.sanc_flag = true,l.sanction_id,r.sanction_id);
			// self.providerdid := if(count(l.providerdid)>=1,l.providerdid,r.providerdid);
			// self.name := l.name+r.name;
			// self.taxid := if(count(l.taxid)>=1,l.taxid,r.taxid);
			// self.dob := if(count(l.dob)>=1,l.dob,r.dob);
			// self.language := if(count(l.language)>=1,l.language,r.language);
			// self.upin := if(count(l.upin)>=1,l.upin,r.upin);
			// self.npi := if(count(l.npi)>=1,l.npi,r.npi);
			// self.license := if(count(l.license)>=1,l.license,r.license);
			// self.dea := if(count(l.dea)>=1,l.dea,r.dea);
			// self.degree := if(count(l.degree)>=1,l.degree,r.degree);
			// self.specialty := if(count(l.specialty)>=1,l.specialty,r.specialty);
			// self.business_address := if(count(l.business_address)>=1,l.business_address,r.business_address);
			// self.group_affiliation := if(count(l.group_affiliation)>=1,l.group_affiliation,r.group_affiliation);
			// self.hospital_affiliation := if(count(l.hospital_affiliation)>=1,l.hospital_affiliation,r.hospital_affiliation);
			// self.residency := if(count(l.residency)>=1,l.residency,r.residency);
			// self.medschool := if(count(l.medschool)>=1,l.medschool,r.medschool);
			// self.taxonomy := if(count(l.taxonomy)>=1,l.taxonomy,r.taxonomy);
			// self.sanction_data := if(count(l.sanction_data)>=1,l.sanction_data,r.sanction_data);
			// self.ssn := if(count(l.ssn)>=1,l.ssn,r.ssn);
			// self.medicareoptout := if(count(l.medicareoptout)>=1,l.medicareoptout,r.medicareoptout);
			// self.dod := if(count(l.dod)>=1,l.dod,r.dod);
			// self.deceased := if(l.deceased=true,l.deceased,r.deceased);
		// END;		
		
		// rolledRecs := rollup(rawRecs, left.providerdid=right.providerdid, rollit(left,right));
		// returnRecs := if(count(dedup(sort(rawRecs,providerid),providerid))=1 and count(rawRecs)>1,rolledRecs,rawRecs);

		
		// Backfill Ingenix records with AMS Provider data for greater coverage.
		// params_AMS_backfill := MODULE(AMS.Interfaces.params)
			// EXPORT DID           := (UNSIGNED6)aInputData.DID;
			// EXPORT BDID          := (UNSIGNED6)aInputData.BDID;
			// EXPORT TaxID         := aInputData.TaxID;
			// EXPORT NPI           := aInputData.NPI;	
			// EXPORT LicenseState  := aInputData.LicenseState;
			// EXPORT LicenseNumber := aInputData.LicenseNumber;
			// EXPORT ProviderId    := aInputData.ProviderId;
		// END;
		
		// returnRecs_with_backfill := AMS_Services.mod_AMS_backfill.do(returnrecs,params_AMS_backfill);

		// AMS backfill has been replaced with Healthcare_Provider_Services.Provider_Records_Consolidated 
		// this function is also no longer being used forcing return to be empty.
		
		RETURN '';
	END;

	// export appendVerificationData(dataset(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportProviderEx) source, IParams.ReportParams inputData) := function
			// tmpSearchMod := MODULE(PROJECT(inputData, IParams.searchParams,opt))		
				// EXPORT STRING 		NPI := inputData.NPI;
				// EXPORT STRING 		UPIN := inputData.UPIN;
				// EXPORT string11 	Fein := if(inputData.Fein<>'',inputData.Fein,inputData.TaxID);//Make these interchangable
				// EXPORT string11 	TaxID := if(inputData.TaxID<>'',inputData.TaxID,inputData.Fein);//Make these interchangable
				// EXPORT string15 	CLIANumber := inputData.CLIANumber;
				// EXPORT STRING 		MedicalSchoolName := '';
				// EXPORT integer 		GraduationYear := 0;
				// EXPORT BOOLEAN 		includeProvidersOnly := false;
				// EXPORT BOOLEAN 		includeSanctionsOnly := false;
			// END;
			// return project(source,transform(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportProviderEx,
											// self.Verifications.MedicalSchoolNameVerified := if(inputData.IncludeVerifications,Functions.medicalSchoolNameVerified(source.MedicalSchools, tmpSearchMod),false);
											// self.Verifications.GraduationYearVerified := if(inputData.IncludeVerifications,Functions.gradYearVerified(source.MedicalSchools, tmpSearchMod),false);
											// self.Verifications.UPINVerified := if(inputData.IncludeVerifications,Functions.upinVerified(source.Upins, tmpSearchMod),false);
											// self.Verifications.NPIVerified := if(inputData.IncludeVerifications,Functions.npiVerified(source.NationalProviderIds, tmpSearchMod),false);
											// self.Verifications.NameVerified := if(inputData.IncludeVerifications,Functions.NameVerified(source.Names, tmpSearchMod),false);
											// self.Verifications.CompanyNameVerified := if(inputData.IncludeVerifications,source[1].BusinessInstantID.CompanyResults.VerificationIndicators.CompanyName,false);
											// self.Verifications.AddressVerified := if(inputData.IncludeVerifications,Functions.AddressVerified(source.BusinessAddresses, tmpSearchMod),false);
											// self.Verifications.PhoneVerified := if(inputData.IncludeVerifications,Functions.PhoneVerified(source.BusinessAddresses, tmpSearchMod),false);
											// self.Verifications.FEINVerified := if(inputData.IncludeVerifications,Functions.FEINVerified(source.FEINs, source.TaxIds, tmpSearchMod),false);
											// self.Verifications.SSNVerified := if(inputData.IncludeVerifications,Functions.SSNVerified(source.SSNs, tmpSearchMod),false);
											// self.Verifications.LicenseVerified := if(inputData.IncludeVerifications,Functions.LicenseVerified(source.Licenses, tmpSearchMod),false);
											// self.Verifications.CLIAVerified := if(inputData.IncludeVerifications,Functions.CLIAVerified(source.CLIARecords, tmpSearchMod),false);
											// self := left));
	// end;
	export verifyProviderSantion(dataset(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportProviderEx) source) := function
			hasProviderorSanctionData := exists(source.Sanctions) or exists(source.UniqueIds) or exists(source.Names) or 
																	 exists(source.NationalProviderIds) or exists(source.UPINs) or exists(source.Licenses);
			return hasProviderorSanctionData;
	end;
	export verifyPersonRelativesData(dataset(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportProviderEx) source) := function
			hasPersonRelativesData := exists(source.Relatives);
			return hasPersonRelativesData;
	end;
	export verifyPersonNeighborsData(dataset(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportProviderEx) source) := function
			hasPersonNeighborsData := exists(source.Neighbors);
			return hasPersonNeighborsData;
	end;
	export verifyPersonHNeighborsData(dataset(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportProviderEx) source) := function
			hasPersonHNeighborsData := exists(source.HistoricalNeighbors);
			return hasPersonHNeighborsData;
	end;
	export verifyPersonAssociatesData(dataset(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportProviderEx) source) := function
			hasPersonAssociatesData := exists(source.Associates);
			return hasPersonAssociatesData;
	end;
	export verifyPersonDODsData(dataset(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportProviderEx) source) := function
			hasPersonDODsData := exists(source.DODs);
			return hasPersonDODsData;
	end;
	export verifyCriminalData(dataset(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportProviderEx) source) := function
			hasCriminalData := exists(source.CriminalRecords);
			return hasCriminalData;
	end;
	export verifyCorporateData(dataset(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportProviderEx) source) := function
			hasCorporateData := exists(source.CorporateAffiliations);
			return hasCorporateData;
	end;
	export verifyProfLicData(dataset(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportProviderEx) source) := function
			hasProfLicData := exists(source.ProfessionalLicenses);
			return hasProfLicData;
	end;
	export verifyDEAData(dataset(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportProviderEx) source) := function
			hasDEAData := exists(source.DEAInformation);
			return hasDEAData;
	end;
	export verifyBankruptciesData(dataset(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportProviderEx) source) := function
			hasBankruptciesData := exists(source.Bankruptcies);
			return hasBankruptciesData;
	end;
	export verifyLiensJudgmentsData(dataset(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportProviderEx) source) := function
			hasLiensJudgmentsData := exists(source.LiensJudgments);
			return hasLiensJudgmentsData;
	end;
	export verifyGSASanctionsData(dataset(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportProviderEx) source) := function
			hasGSASanctionsData := exists(source.GSASanctions);
			return hasGSASanctionsData;
	end;
	export verifyResults(dataset(iesp.healthcareconsolidatedreport.t_HealthCareConsolidatedReportProviderEx) source) := function
			hasProviderorSanctionData := verifyProviderSantion(source);
			hasPersonRelativesData := verifyPersonRelativesData(source);
			hasPersonNeighborsData := verifyPersonNeighborsData(source);
			hasPersonHNeighborsData := verifyPersonHNeighborsData(source);
			hasPersonAssociatesData := verifyPersonAssociatesData(source);
			hasPersonDODsData := verifyPersonDODsData(source);
			hasCriminalData := verifyCriminalData(source);
			hasCorporateData := verifyCorporateData(source);
			hasProfLicData := verifyProfLicData(source);
			hasDEAData := verifyDEAData(source);
			hasBankruptciesData := verifyBankruptciesData(source);
			hasLiensJudgmentsData := verifyLiensJudgmentsData(source);
			hasGSASanctionsData := verifyGSASanctionsData(source);
			hasSomething2Report := hasPersonRelativesData or hasPersonNeighborsData or hasPersonHNeighborsData or 
														 hasPersonAssociatesData or hasPersonDODsData or hasCriminalData or hasCorporateData or 
														 hasProfLicData or hasDEAData or hasBankruptciesData or hasLiensJudgmentsData or 
														 hasGSASanctionsData or hasProviderorSanctionData;

			return hasSomething2Report;
	end;
END;