IMPORT doxie,iesp,PersonReports,PublicProfileServices,AutoStandardI,Address,ut,
	ATF_Services,CriminalRecords_Services,Foreclosure_Services,
	Hunting_Fishing_Services,InternetDomain_Services,VehicleV2_Services, NID, header;

EXPORT Records := MODULE

		EXPORT BOOLEAN validDidRec(PublicProfileServices.Layouts.DidRecord didRec,PublicProfileServices.IParam.searchParams rptByMod) := FUNCTION
		hdrRecs := doxie.header_records_byDID(DATASET([{didRec.did,FALSE}],doxie.layout_references_hh));

		// INPUT DOB EXISTS IN DATASET OF HEADER RECORDS
		BOOLEAN existsDOB := rptByMod.DOB!=0 AND rptByMod.DOB IN SET(hdrRecs,DOB);

		// INPUT SSN EXISTS IN DATASET OF HEADER RECORDS
		BOOLEAN validSSN := ut.full_ssn(rptByMod.SSN);
		BOOLEAN existsSSN := validSSN AND rptByMod.SSN IN SET(hdrRecs,SSN);

		// INPUT NAME EXISTS IN DATASET OF HEADER RECORDS
		BOOLEAN validLastName := LENGTH(TRIM(rptByMod.LastName))>1;
		BOOLEAN existsLastName := validLastName AND rptByMod.LastName IN SET(hdrRecs,LName);
		BOOLEAN validFirstName := LENGTH(TRIM(rptByMod.FirstName))>1;
		firstNamesSet := SET(hdrRecs,FName);
		preferredFirst := NID.PreferredFirstNew(rptByMod.FirstName);
		BOOLEAN existsFirstName := validFirstName AND (rptByMod.FirstName IN firstNamesSet OR preferredFirst IN firstNamesSet);
		BOOLEAN existsFirstInitial := validFirstName AND rptByMod.FirstName[1] IN SET(hdrRecs,FName[1]);
		BOOLEAN existsName := existsLastName AND (existsFirstName OR existsFirstInitial); 

		// INPUT ADDRESS EXISTS IN DATASET OF HEADER RECORDS
		BOOLEAN validAddr := TRIM(rptByMod.Addr)!='' AND ((TRIM(rptByMod.City)!='' AND TRIM(rptByMod.State)!='') OR TRIM(rptByMod.Zip)!='');
		a := address.GetCleanAddress(rptByMod.Addr,rptByMod.City+' '+rptByMod.State+' '+rptByMod.Zip,address.Components.Country.US).str_addr;
		clnAddr := Address.CleanFields(a);
		BOOLEAN existsPrimRange := validAddr AND clnAddr.prim_range IN SET(hdrRecs,prim_range);
		BOOLEAN existsPrimName := validAddr AND clnAddr.prim_name IN SET(hdrRecs,prim_name);
		BOOLEAN isPoBox := ut.isPOBox(clnAddr.prim_name);
		BOOLEAN isRRTyp := clnAddr.prim_name[1..3] IN ['RR ','HC '];
		BOOLEAN existsStreet := (existsPrimRange AND existsPrimName) OR ((isPoBox OR isRRTyp) AND existsPrimName);
		BOOLEAN existsCity := validAddr AND clnAddr.p_city_name IN SET(hdrRecs,city_name);
		BOOLEAN existsState := validAddr AND clnAddr.st IN SET(hdrRecs,st);
		BOOLEAN existsZip := validAddr AND clnAddr.zip IN SET(hdrRecs,zip);
		BOOLEAN existsAddr := existsStreet AND ((existsCity AND existsState) OR existsZip);

		// VALIDATE SETS
		setNameSsnDob  := IF(existsName AND existsSSN AND existsDOB ,PublicProfileServices.Constants.setNameSsnDob ,[]);
		setNameSsnAddr := IF(existsName AND existsSSN AND existsAddr,PublicProfileServices.Constants.setNameSsnAddr,[]);
		setNameDobAddr := IF(existsName AND existsDOB AND existsAddr,PublicProfileServices.Constants.setNameDobAddr,[]);
		setSsnDobAddr  := IF(existsSSN  AND existsDOB AND existsAddr,PublicProfileServices.Constants.setSsnDobAddr ,[]);
		setNameSSN  := IF(existsName AND existsSSN ,PublicProfileServices.Constants.setNameSSN ,[]);
		setNameAddr := IF(existsName AND existsAddr,PublicProfileServices.Constants.setNameAddr,[]);
		setNameDOB  := IF(existsName AND existsDOB ,PublicProfileServices.Constants.setNameDOB ,[]);
		setAddrOnly := IF(existsAddr,PublicProfileServices.Constants.setAddrOnly,[]);
		setSSNOnly  := IF(existsSSN ,PublicProfileServices.Constants.setSSNOnly ,[]);

		// DATASETS
		DS1 := DATASET([{didRec.srchBy}],{SET OF STRING Key {MAXLENGTH(PublicProfileServices.Constants.MAX_LEN)}});
		DS2 := DATASET([{setNameSsnDob},{setNameSsnAddr},{setNameDobAddr},{setSsnDobAddr},{setNameSSN},
			{setNameAddr},{setNameDOB},{setAddrOnly},{setSSNOnly}],{SET OF STRING Key {MAXLENGTH(PublicProfileServices.Constants.MAX_LEN)}});

		RETURN EXISTS(JOIN(DS1,DS2,LEFT.Key=RIGHT.Key));
	END;

	EXPORT getHdrDids(PublicProfileServices.IParam.searchParams rptByMod) := FUNCTION
		BOOLEAN validDOB  := rptByMod.DOB!=0;
		BOOLEAN validSSN  := TRIM(rptByMod.SSN)!='' AND LENGTH(TRIM(rptByMod.SSN))=9;
		BOOLEAN validName := TRIM(rptByMod.LastName)!='' AND LENGTH(TRIM(rptByMod.LastName))>1;;
		BOOLEAN validAddr := TRIM(rptByMod.Addr)!='' AND ((TRIM(rptByMod.City)!='' AND TRIM(rptByMod.State)!='') OR TRIM(rptByMod.Zip)!='');

		BOOLEAN srchByNameSsnDob  := rptByMod.IncludeCombination AND validName AND validSSN AND validDOB;
		BOOLEAN srchByNameSsnAddr := rptByMod.IncludeCombination AND validName AND validSSN AND validAddr;
		BOOLEAN srchByNameDobAddr := rptByMod.IncludeCombination AND validName AND validDOB AND validAddr;
		BOOLEAN srchBySsnDobAddr  := rptByMod.IncludeCombination AND validSSN  AND validDOB AND validAddr;
		BOOLEAN srchByNameSSN  := rptByMod.IncludeNameSSN AND validName AND validSSN;
		BOOLEAN srchByNameAddr := rptByMod.IncludeNameAddress AND validName AND validAddr;
		BOOLEAN srchByNameDOB  := rptByMod.IncludeNameDOB AND validName AND validDOB;
		BOOLEAN srchByAddrOnly := rptByMod.IncludeAddress AND validAddr;
		BOOLEAN srchBySSNOnly  := rptByMod.IncludeSSN AND validSSN;

		srchReq := DATASET([
			PublicProfileServices.Transforms.initSrch(srchByNameSsnDob ,PublicProfileServices.Constants.setNameSsnDob ,rptByMod),
			PublicProfileServices.Transforms.initSrch(srchByNameSsnAddr,PublicProfileServices.Constants.setNameSsnAddr,rptByMod),
			PublicProfileServices.Transforms.initSrch(srchByNameDobAddr,PublicProfileServices.Constants.setNameDobAddr,rptByMod),
			PublicProfileServices.Transforms.initSrch(srchBySsnDobAddr ,PublicProfileServices.Constants.setSsnDobAddr ,rptByMod),
			PublicProfileServices.Transforms.initSrch(srchByNameSSN    ,PublicProfileServices.Constants.setNameSSN    ,rptByMod),
			PublicProfileServices.Transforms.initSrch(srchByNameAddr   ,PublicProfileServices.Constants.setNameAddr   ,rptByMod),
			PublicProfileServices.Transforms.initSrch(srchByNameDOB    ,PublicProfileServices.Constants.setNameDOB    ,rptByMod),
			PublicProfileServices.Transforms.initSrch(srchByAddrOnly   ,PublicProfileServices.Constants.setAddrOnly   ,rptByMod),
			PublicProfileServices.Transforms.initSrch(srchBySSNOnly    ,PublicProfileServices.Constants.setSSNOnly    ,rptByMod)]);

		IF(NOT TRUE IN SET(srchReq,validSrch) AND rptByMod.UniqueID='',FAIL(301,doxie.ErrorCodes(301)));

		hdrDids    := PROJECT(srchReq,PublicProfileServices.Transforms.getDids(LEFT,COUNTER));
		normDids   := NORMALIZE(hdrDids,LEFT.didRecs,TRANSFORM(PublicProfileServices.Layouts.didRecord,SELF:=RIGHT));
		filterDids := PROJECT(normDids,TRANSFORM(PublicProfileServices.Layouts.didRecord,SELF.seq:=IF(validDidRec(LEFT,rptByMod),LEFT.seq,SKIP),SELF:=LEFT));
		dedupDids  := DEDUP(SORT(filterDids,did,seq),did);

		RETURN dedupDids;
	END;

	EXPORT PersonSummary(PublicProfileServices.IParam.searchParams rptByMod) := FUNCTION

		getID(iesp.sexualoffender.t_SexOffRecordIdNumbers recID) := FUNCTION
			ID := MAP(TRIM(recID.OffenderId)!='' => recID.OffenderId,
								TRIM(recID.DocNumber)!='' => recID.DocNumber,
								TRIM(recID.SORNumber)!='' => recID.SORNumber,
								TRIM(recID.StateIdNumber)!='' => recID.StateIdNumber,
								TRIM(recID.FBINumber)!='' => recID.FBINumber,
								TRIM(recID.NCICNumber)!='' => recID.NCICNumber,
								'');
			RETURN ID;
		END;
		
		// ONLY DID USED FROM GLOBAL MODULE
		glbMod := AutoStandardI.GlobalModule();
		dids := IF(rptByMod.UniqueID='',PublicProfileServices.Functions.FetchI_Hdr_Indv_do(rptByMod),
			DATASET([{(UNSIGNED6)rptByMod.UniqueID}],doxie.layout_references));

		atfMod := MODULE(PROJECT(glbMod,ATF_Services.IParam.search_params,opt))
			EXPORT STRING14 did := (STRING)dids[1].did;
		END;
		crmMod := MODULE(PROJECT(glbMod,CriminalRecords_Services.IParam.report,opt))
			EXPORT STRING14 did := (STRING)dids[1].did;
			EXPORT STRING25 doc_number := '';
			EXPORT STRING60 offender_key := '';
			EXPORT BOOLEAN  IncludeAllCriminalRecords := FALSE;
			EXPORT BOOLEAN  IncludeSexualOffenses := FALSE;
		END;
		forMod := MODULE(PROJECT(glbMod,Foreclosure_Services.ReportService_Records.params,opt))
			EXPORT STRING14 did := (STRING)dids[1].did;
		END;
		hntMod := MODULE(PROJECT(glbMod,Hunting_Fishing_Services.Search_Records.params,opt))
			EXPORT STRING14 did := (STRING)dids[1].did;
		END;
		intMod := MODULE(PROJECT(glbMod,InternetDomain_Services.SearchService_Records.params,opt))
			EXPORT STRING14 did := (STRING)dids[1].did;
		END;
		nodMod := MODULE(PROJECT(glbMod,Foreclosure_Services.Records.params,opt))
			EXPORT STRING14 did := (STRING)dids[1].did;
		END;
		accidents_mode := MODULE (project (glbMod, PersonReports.input.accidents, opt)) //?
			EXPORT boolean mask_dl := rptByMod.mask_dl;
		END;
		sexoffenses_mode := MODULE (project (rptByMod, PersonReports.input.sexoffenses)) END;
	
		iesp.public_profile_report.t_PublicProfileIndividual setIndividual() := TRANSFORM
			SELF.UniqueId := IF(dids[1].did>0,(STRING)dids[1].did,'');
			SELF.SexualOffenses := CHOOSEN(GLOBAL(PersonReports.sexoffenses_records(dids,sexoffenses_mode)),iesp.Constants.BR.MaxSexualOffenses);
			SELF.IsSexualOffender := COUNT(SELF.SexualOffenses)>0;
			SELF.SexualOffenderId := getID(SELF.SexualOffenses[1].IdNumbers);
			SELF.Accidents := CHOOSEN(GLOBAL(PersonReports.accident_records(dids, accidents_mode)),iesp.Constants.BR.MaxAccidents);
			veh_mod := VehicleV2_Services.IParam.GetReportModule ();
			SELF.Vehicles := CHOOSEN(GLOBAL(iesp.transform_vehiclesV2(VehicleV2_Services.raw.get_vehicle_crs_report(veh_mod, dids))),iesp.Constants.BR.MaxVehicles);
			SELF.FictitiousBusinesses := CHOOSEN(GLOBAL(doxie.Comp_FBN2Search(dids)),iesp.Constants.BR.MaxFictitiousBusinesses);
			SELF.NoticesOfDefaults := CHOOSEN(GLOBAL(Foreclosure_Services.Records.val(nodMod,TRUE)),IESP.CONSTANTS.PUBLICPROFILE.MAX_NOTICE_OF_DEFAULTS);
			ucc_mode := module (project(rptByMod, PersonReports.input.ucc, opt)) 
				export string1 ucc_party_type := 'D';
			end;
			SELF.UCCFilings := CHOOSEN(GLOBAL(PersonReports.ucc_records(dids, ucc_mode).ucc_v2),iesp.Constants.BR.MaxUCCFilings);
			SELF.InternetDomains := CHOOSEN(GLOBAL(InternetDomain_Services.SearchService_Records.val(intMod)),iesp.Constants.BR.MaxInternetDomains);			
			crim_recs := CHOOSEN(GLOBAL(CriminalRecords_Services.ReportService_Records.val(crmMod).CriminalRecords),IESP.CONSTANTS.PUBLICPROFILE.MAX_CRIMINAL_RECORDS);
			SELF.CriminalRecords := PROJECT(crim_recs, iesp.criminal.t_CrimReportRecord);			
			SELF.HasCriminalConviction := COUNT(SELF.CriminalRecords)>0;
			SELF.CriminalConvictionId := SELF.CriminalRecords[1].OffenderId;
			SELF.AKAs := CHOOSEN(PROJECT(GLOBAL(PersonReports.Person_records(dids,PROJECT(glbMod,PersonReports.input.personal,OPT)).AKAs),iesp.public_profile_report.t_PublicProfileIdentity),iesp.Constants.BR.MaxAKA);
			SELF.DriverLicenses := CHOOSEN(GLOBAL(PersonReports.DL_records(dids)),iesp.Constants.DL.MaxCountDL);
			bankruptcy_mod := module (project(rptByMod, PersonReports.input.bankruptcy, opt)) end;
			SELF.Bankruptcies := CHOOSEN(GLOBAL(PersonReports.bankruptcy_records(dids, bankruptcy_mod).bankruptcy_v2),iesp.Constants.BR.MaxBankruptcies);
			SELF.HasBankruptcy := COUNT(SELF.Bankruptcies)>0;
			SELF.CorporateAffiliations := CHOOSEN(GLOBAL(PersonReports.CorpAffiliation_records(dids)),iesp.Constants.BR.MaxCorpAffiliations);
			SELF.HasCorporateAffiliation := COUNT(SELF.CorporateAffiliations)>0;
			faaCert_mod := module (project(glbMod, PersonReports.input.faacerts, opt)) end;
			SELF.FAACertifications := project(CHOOSEN(GLOBAL(PersonReports.faaCert_records(dids,FAACert_mod).bps_view),iesp.Constants.BR.MaxFaaCertificates), iesp.bpsreport.t_BpsFAACertification );
			air_mod := module (project(rptByMod, PersonReports.input.aircrafts)) end;
			SELF.Aircrafts := project(CHOOSEN(GLOBAL(PersonReports.aircraft_records(dids,air_mod)),IESP.CONSTANTS.PUBLICPROFILE.MAX_AIRCRAFTS),iesp.faaaircraft.t_AircraftReportRecord);
			props_mod := module (project(rptByMod, PersonReports.input.property, opt)) end;
			SELF.Properties := CHOOSEN(GLOBAL(PersonReports.Property_Records(dids,props_mod).property_v2),iesp.Constants.BR.MaxProperties);
			SELF.HasProperty := COUNT(SELF.Properties)>0;
			liens_mod := module (project(rptByMod, PersonReports.input.liens, opt)) 
				export string1 leins_party_type := 'D';
			end;
			SELF.LiensJudgments := CHOOSEN(GLOBAL(project(PersonReports.lienjudgment_records(dids, liens_mod).liensjudgment_v2,iesp.lienjudgement.t_LienJudgmentReportRecord)),iesp.Constants.BR.MaxLiensJudgments);
			SELF.ProfessionalLicenses := CHOOSEN(GLOBAL(PersonReports.proflic_records(dids).proflicenses_v2),iesp.Constants.BR.MaxProfLicenses);
			SELF.Providers := CHOOSEN(GLOBAL(PersonReports.providers_records(dids)),iesp.Constants.BR.MaxProviders);
			SELF.Sanctions := CHOOSEN(GLOBAL(PersonReports.sanctions_records(dids)),iesp.Constants.BR.MaxSanctions);
			dea_mod := module (project(rptByMod, PersonReports.input.dea)) end;
			SELF.ControlledSubstances := CHOOSEN(GLOBAL(PersonReports.DEA_records(dids, dea_mod)),iesp.Constants.BR.MaxDEASubstances);
			voters_mod := module (project(rptByMod, PersonReports.input.voters)) end;
			SELF.VoterRegistrations := CHOOSEN(GLOBAL(PersonReports.voter_records(dids, voters_mod).voters_v2),iesp.Constants.BR.MaxVoterRegistrations);
			SELF.HuntingFishingLicenses :=CHOOSEN(GLOBAL(Hunting_Fishing_Services.Search_Records.val(hntMod).Records),iesp.Constants.BR.MaxHFLicenses);
			ccw_mod := module (project(rptByMod, PersonReports.input.ccw)) end;
			SELF.WeaponPermits := CHOOSEN(GLOBAL(PersonReports.CCW_records (dids, ccw_mod)),iesp.Constants.BR.MaxWeaponPermits);
			SELF.HasConcealedWeapon := COUNT(SELF.WeaponPermits)>0;
			SELF.ConcealedWeaponId := SELF.WeaponPermits[1].permit.permitNumber;
			SELF.FirearmExplosives := CHOOSEN(GLOBAL(ATF_Services.SearchService_Records.report(atfMod)),iesp.Constants.BR.MaxFirearmsExplosives);
			watercrafts_mod := module (project(rptByMod, PersonReports.input.watercrafts, opt)) end;
			SELF.WaterCrafts := CHOOSEN(GLOBAL(PersonReports.Watercraft_Records(dids, watercrafts_mod).watercrafts_v2),iesp.Constants.BR.MaxWatercrafts);
			SELF.Foreclosures := CHOOSEN(GLOBAL(Foreclosure_Services.ReportService_Records.val(forMod)),IESP.CONSTANTS.PUBLICPROFILE.MAX_FORECLOSURES);
			pp_mod := module (project(rptByMod, PersonReports.input.phonesplus, opt)) end;
			SELF.PhonesPluses := CHOOSEN(GLOBAL(PersonReports.phonesplus_records(dids, pp_mod).phonesplus_v2),iesp.Constants.BR.MaxPhonesPlus);
			SELF.EmailAddresses := CHOOSEN(GLOBAL(PersonReports.email_records(dids,PROJECT(rptByMod,PersonReports.input.emails))),iesp.Constants.BR.MaxEmails);
		END;

		RETURN ROW(setIndividual());
	END;

	EXPORT currentResidentsOnly(PublicProfileServices.IParam.searchParams rptByMod, DATASET(doxie.layout_presentation) hdrRecs) := FUNCTION
		a := address.GetCleanAddress(rptByMod.addr,rptByMod.city+' '+rptByMod.state+' '+rptByMod.zip,address.Components.Country.US).str_addr;
		clnAddr := Address.CleanFields(a);
		doxie.layout_presentation filterCurrentResidents(doxie.layout_presentation L) := TRANSFORM
			BOOLEAN matchPrimRange := TRIM(clnAddr.prim_range)!='' AND TRIM(clnAddr.prim_range)=TRIM(L.prim_range);
			BOOLEAN matchPrimName := TRIM(clnAddr.prim_name)!='' AND TRIM(clnAddr.prim_name)=TRIM(L.prim_name);
			BOOLEAN isPoBox := ut.isPOBox(L.prim_name);
			BOOLEAN isRRTyp := L.prim_name[1..3] IN ['RR ','HC '];
			BOOLEAN matchStreet := (matchPrimRange AND matchPrimName) OR ((isPoBox OR isRRTyp) AND matchPrimName);
			BOOLEAN matchCity := TRIM(clnAddr.v_city_name)!='' AND TRIM(clnAddr.v_city_name)=TRIM(L.city_name);
			BOOLEAN matchState := TRIM(clnAddr.st)!='' AND TRIM(clnAddr.st)=TRIM(L.st);
			BOOLEAN matchZip := TRIM(clnAddr.zip)!='' AND TRIM(clnAddr.zip)=TRIM(L.zip);
			BOOLEAN matchAddr := matchStreet AND ((matchCity AND matchState) OR matchZip);
			BOOLEAN isCurrent := doxie.isrecent(L.dt_last_seen+'01',PublicProfileServices.Constants.MIN_MONTHS);
			SELF.did := IF(isCurrent AND matchAddr,L.did,SKIP);
			SELF := L;
		END;
		RETURN PROJECT(hdrRecs,filterCurrentResidents(LEFT));
	END;

	Export HeaderSummaryFilter(dataset(doxie.layout_presentation) inrecs, boolean searchContainsSSN = false) := FUNCTION
		//Add filters for NLR (No longer reported) data removal.
		filterCriteria := if(searchContainsSSN,PublicProfileServices.Constants.filterNLR_SSN,PublicProfileServices.Constants.filterNLR);
		inrecs_pulled:=join(inrecs,header.key_NLR_payload,
													keyed(left.did=right.did)
													and keyed (left.rid=right.rid)
													and (right.Not_in_Bureau & filterCriteria > 0),
													TRANSFORM(doxie.layout_presentation,self:=left),
													LEFT ONLY);
		return inrecs_pulled;
	END;
	
	EXPORT HeaderSummary(PublicProfileServices.IParam.searchParams rptByMod) := FUNCTION

		hdrDids := getHdrDids(rptByMod);
		hdrTemp := doxie.header_records_byDID(PROJECT(hdrDids,doxie.layout_references_hh));
		//Remove undesireable record sources
		hdrTemp1 := hdrTemp(src not in PublicProfileServices.Constants.srcFilter);
		hdrRecs := PROJECT(hdrTemp1,TRANSFORM(doxie.layout_presentation,SELF:=LEFT));

		// FILTER HEADER RECORDS BY INPUT SSN AND DOB YYYYMM
		SoHdr  := HeaderSummaryFilter(hdrRecs(did IN SET(hdrDids(srchBy=PublicProfileServices.Constants.setSSNOnly),did),ssn=rptByMod.ssn),true);
		NsHdr  := HeaderSummaryFilter(hdrRecs(did IN SET(hdrDids(srchBy=PublicProfileServices.Constants.setNameSSN),did),ssn=rptByMod.ssn),true);
		NdHdr  := HeaderSummaryFilter(hdrRecs(did IN SET(hdrDids(srchBy=PublicProfileServices.Constants.setNameDOB),did),dob[1..6]=rptByMod.dob[1..6]));
		NaHdr  := HeaderSummaryFilter(hdrRecs(did IN SET(hdrDids(srchBy=PublicProfileServices.Constants.setNameAddr),did)));
		AoHdr  := HeaderSummaryFilter(currentResidentsOnly(rptByMod,hdrRecs(did IN SET(hdrDids(srchBy=PublicProfileServices.Constants.setAddrOnly),did))));
		NsdHdr := HeaderSummaryFilter(hdrRecs(did IN SET(hdrDids(srchBy=PublicProfileServices.Constants.setNameSsnDob) ,did),ssn=rptByMod.ssn,dob[1..6]=rptByMod.dob[1..6]),true);
		NsaHdr := HeaderSummaryFilter(hdrRecs(did IN SET(hdrDids(srchBy=PublicProfileServices.Constants.setNameSsnAddr),did),ssn=rptByMod.ssn),true);
		NdaHdr := HeaderSummaryFilter(hdrRecs(did IN SET(hdrDids(srchBy=PublicProfileServices.Constants.setNameDobAddr),did),dob[1..6]=rptByMod.dob[1..6]));
		SdaHdr := HeaderSummaryFilter(hdrRecs(did IN SET(hdrDids(srchBy=PublicProfileServices.Constants.setSsnDobAddr) ,did),ssn=rptByMod.ssn,dob[1..6]=rptByMod.dob[1..6]),true);

		hdrFilt := SoHdr+NsHdr+NdHdr+NaHdr+AoHdr+NsdHdr+NsaHdr+NdaHdr+SdaHdr;
		cntSsnDob := PublicProfileServices.Functions.cntUnqSsnDob(hdrFilt);
		
		hdrRoll := PROJECT(JOIN(doxie.rollup_presentation(hdrFilt,,,true)[1].Results,cntSsnDob,(INTEGER)LEFT.did=RIGHT.did,
			KEEP(1),LIMIT(PublicProfileServices.Constants.MAX_DIDS,SKIP)),PublicProfileServices.Layouts.hdrRollupRecord);

		// SEPARATE ROLLUP RECORDS
		SoRoll := hdrRoll((INTEGER)did IN SET(hdrDids(srchBy=PublicProfileServices.Constants.setSSNOnly),did));
		NsRoll := hdrRoll((INTEGER)did IN SET(hdrDids(srchBy=PublicProfileServices.Constants.setNameSSN),did));
		NdRoll := hdrRoll((INTEGER)did IN SET(hdrDids(srchBy=PublicProfileServices.Constants.setNameDOB),did));
		NaRoll := hdrRoll((INTEGER)did IN SET(hdrDids(srchBy=PublicProfileServices.Constants.setNameAddr),did));
		AoRoll := hdrRoll((INTEGER)did IN SET(hdrDids(srchBy=PublicProfileServices.Constants.setAddrOnly),did));

		NsdRoll := hdrRoll((INTEGER)did IN SET(hdrDids(srchBy=PublicProfileServices.Constants.setNameSsnDob),did));
		NsaRoll := hdrRoll((INTEGER)did IN SET(hdrDids(srchBy=PublicProfileServices.Constants.setNameSsnAddr),did));
		NdaRoll := hdrRoll((INTEGER)did IN SET(hdrDids(srchBy=PublicProfileServices.Constants.setNameDobAddr),did));
		SdaRoll := hdrRoll((INTEGER)did IN SET(hdrDids(srchBy=PublicProfileServices.Constants.setSsnDobAddr),did));

		// IESP SUBJECT RECORDS
		SoSub := PROJECT(CHOOSEN(SoRoll,iesp.Constants.PublicProfile.MAX_SUBJECT_RECORDS),PublicProfileServices.Transforms.SetSubject(LEFT));
		NsSub := PROJECT(CHOOSEN(NsRoll,iesp.Constants.PublicProfile.MAX_SUBJECT_RECORDS),PublicProfileServices.Transforms.SetSubject(LEFT));
		NdSub := PROJECT(CHOOSEN(NdRoll,iesp.Constants.PublicProfile.MAX_SUBJECT_RECORDS),PublicProfileServices.Transforms.SetSubject(LEFT));
		NaSub := PROJECT(CHOOSEN(NaRoll,iesp.Constants.PublicProfile.MAX_SUBJECT_RECORDS),PublicProfileServices.Transforms.SetSubject(LEFT));
		AoSub := PROJECT(CHOOSEN(AoRoll,iesp.Constants.PublicProfile.MAX_SUBJECT_RECORDS),PublicProfileServices.Transforms.SetSubject(LEFT));

		NsdSub := PROJECT(CHOOSEN(NsdRoll,iesp.Constants.PublicProfile.MAX_SUBJECT_RECORDS),PublicProfileServices.Transforms.SetSubject(LEFT,PublicProfileServices.Constants.keyNameSsnDob));
		NsaSub := PROJECT(CHOOSEN(NsaRoll,iesp.Constants.PublicProfile.MAX_SUBJECT_RECORDS),PublicProfileServices.Transforms.SetSubject(LEFT,PublicProfileServices.Constants.keyNameSsnAddr));
		NdaSub := PROJECT(CHOOSEN(NdaRoll,iesp.Constants.PublicProfile.MAX_SUBJECT_RECORDS),PublicProfileServices.Transforms.SetSubject(LEFT,PublicProfileServices.Constants.keyNameDobAddr));
		SdaSub := PROJECT(CHOOSEN(SdaRoll,iesp.Constants.PublicProfile.MAX_SUBJECT_RECORDS),PublicProfileServices.Transforms.SetSubject(LEFT,PublicProfileServices.Constants.keySsnDobAddr));
		CmbSub := NsdSub & NsaSub & NdaSub & SdaSub;

		// IESP RESULT RECORDS
		SoRes  := ROW(PublicProfileServices.Transforms.setSSNResults(SoSub));
		NsRes  := ROW(PublicProfileServices.Transforms.setNameSSNResults(NsSub));
		NdRes  := ROW(PublicProfileServices.Transforms.setNameDOBResults(NdSub));
		NaRes  := ROW(PublicProfileServices.Transforms.setNameAddrResults(NaSub));
		AoRes  := ROW(PublicProfileServices.Transforms.setAddrResults(AoSub));
		CmbRes := ROW(PublicProfileServices.Transforms.setCombinationResults(CmbSub));

		PublicProfileServices.Layouts.hdrSumRecord initSummary() := TRANSFORM
			SELF.SSNResults := GLOBAL(SoRes);
			SELF.NameSSNResults := GLOBAL(NsRes);
			SELF.NameDOBResults := GLOBAL(NdRes);
			SELF.AddressResults := GLOBAL(AoRes);
			SELF.NameAddressResults := GLOBAL(NaRes);
			SELF.CombinationResults := GLOBAL(cmbRes);
		END;

		RETURN ROW(initSummary());
	END;

END;