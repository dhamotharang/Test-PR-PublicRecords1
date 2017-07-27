// Simplified version of compreport, no distributed call to central records, no hash, no versioning of single sources, non-FCRA
IMPORT Foreclosure_Services,PersonReports,doxie, doxie_crs,ATF_Services, iesp, 
      AutoStandardI, ut, American_Student_Services,  
			LIB_WORD, SmartRollup, FCRA, LN_PropertyV2_Services, PersonReports;
iespOut := iesp.smartlinxreport;			
out_rec := record(iespOut.t_SmartlinxReportIndividual)
    dataset(iesp.share.t_CodeMap) Messages;
end;
// accepts atmost one DID, actually
EXPORT out_rec SmartLinxReport (dataset (doxie.layout_references) dids, 
                                PersonReports.input._smartlinxreport param, 
                                boolean IsFCRA = false) := FUNCTION
  globals := AutoStandardI.GlobalModule();
  subject_did := dids[1].did; // DID should be atmost one (do we keep layout_references for legacy reasons?)
	BOOLEAN doBadSecRange := TRUE;  //used by addressMetaData lookup
	ds_best := project(dids,transform(doxie.layout_best,self:=left,self:=[]));
	ds_flags := if(isFCRA, FCRA.GetFlagFile (ds_best), fcra.compliance.blank_flagfile);
	
	//changes will be needed to excessive_property when this service is used for comp report to handle request for Current properties ONLY.
	excessive_property := param.include_properties and count(choosen(LN_PropertyV2_Services.keys.search_did(isFCRA)(keyed(s_did=subject_did)),1001)) > 1000;
	messages_property_ds := if (excessive_property, dataset([{'1000','Property'}],iesp.share.t_CodeMap));
//****************************************************************************************************
//     PERSON RECORDS
//****************************************************************************************************
  persMod := module (project (param, personreports.input.personal, opt)) end;
	pers := PersonReports.Person_records (dids, persMod, IsFCRA);
 	best_rec_esdl :=       pers.bestrecs_esdl[1]; // best record  this is a record not a dataset???????
	best_rec :=            pers.bestrecs[1];
	iesp.smartlinxreport.t_SLRBestInfo  additionalBest() := transform
	 	self.ssn := if (param.smart_rollup and best_rec.valid_ssn='G',SmartRollup.fn_smart_getSsnMetadata(best_rec.did,best_rec.ssn,best_rec.valid_ssn,globals.IncludeHRI)[1]);
		self.age := best_rec.age;
		self.ageAtDeath := ut.GetAgeI_asOf(iesp.ECL2ESP.DateToInteger(best_rec_esdl.dob),iesp.ECL2ESP.DateToInteger(best_rec_esdl.dod));
		self.addressCDS := SmartRollup.fn_smart_getAddrMetadata.address(best_rec,doBadSecRange)[1];  // add additional data to best section for smartlinx 
    phones2use := choosen(SmartRollup.fn_smart_getPhonesPlusMetadata.byDid(best_rec, param),iesp.Constants.BR.MaxPhonesPlus);
		self.PhonesV2 := phones2use;
		self.Phones := project(phones2use, iesp.dirassistwireless.t_DirAssistWirelessSearchRecord);
		self := best_rec_esdl;
		self.Attributes := SmartRollup.fn_getAttributes(subject_did, param.dppapurpose, param.glbpurpose);
		self := [];
	end;
  best_rec_smart   := if (param.include_best,  dataset([additionalBest()]),dataset([],iesp.smartlinxreport.t_SLRBestInfo)); 
	subject_akas     := IF (param.include_akas, project(pers.Akas,iesp.bps_share.t_BpsReportIdentity), dataset([],iesp.bps_share.t_BpsReportIdentity));
  s_akas           := SmartRollup.fn_smart_rollup_names(subject_akas);
	p_aka_entities   := SmartRollup.fn_smart_aka_entities(s_akas, subject_akas);
	s_akas_count     := count(s_akas);
  p_akas           := choosen (s_Akas, iesp.Constants.SMART.MaxAKA);
  subject_addrs    := IF (param.include_bpsaddress, pers.SubjectAddresses, dataset([],iesp.bpsreport.t_BpsReportAddress) );
	//=======================================================================
	//temporary fix to use Verified as Current indicator based on TNT value.
	//product wanted Current to match doxie.HeaderFileRollupService for current addresses.
	subject_addrs_rolled := SmartRollup.fn_smart_rollup_addr(subject_addrs,subject_did); 
	
	tnt_rec := record
	  integer seq := 0;
	  string15 did := ''; 
		string8 dt_last_seen := '';
	  string1 tnt := '';
		unsigned6 hhid;
	  iesp.bpsreport.t_BpsReportAddress
  end;
	tnt_rec fillPlus(subject_addrs l, integer cnt) := transform
	  self.did := (string)subject_did; 
		self.dt_last_seen := iesp.ecl2esp.DateToString(l.DateLastSeen); 
		self.seq := cnt;
		self.tnt := '';
		self.hhid := 0;
		self := l;
	end;
	subject_addrs_plus := project(subject_addrs_rolled, fillPlus(left,counter));
	
	subject_addrs_hhid := join(subject_addrs_plus,doxie.Key_Did_HDid, 
                  keyed((integer)left.did = right.did), 
                  transform(tnt_rec, self.hhid := right.hhid_relat, self := left), left outer, atmost(ut.limits.HHID_PER_PERSON));
	
	doxie.MAC_getTNTValue(subject_addrs_hhid, pers.bestrecs, subject_addrs_TNT_dups,,,,addressEx.Zip5, 
	                      addressEx.StreetName, addressEx.StreetNumber, addressEx.UnitNumber,addressEx.State);
	
	tnt_rec keepBestTNT(tnt_rec le, tnt_rec ri) := transform
  self.tnt := MAP(le.tnt = 'B' or ri.tnt = 'B' => 'B',
                  le.tnt = 'V' or ri.tnt = 'V' => 'V',
                  le.tnt = 'C' or ri.tnt = 'C' => 'C',
                  le.tnt = 'P' or ri.tnt = 'P' => 'P',
                  le.tnt = 'R' or ri.tnt = 'R' => 'R', 'H');
              SELF := le;
  END;											
  subject_addrs_TNT := ROLLUP(SORT(subject_addrs_TNT_dups, seq), left.seq = right.seq, keepBestTNT(LEFT, RIGHT));

	iesp.bpsreport.t_BpsReportAddress setCurrent(tnt_rec l ) := transform
	    //self.verified := if (l.verified = false, l.tnt in ['B','C','V'], l.verified);  //change made 10/29/2012
	    self.verified := l.tnt in ['B','C','V'];  //changed back 8/13/13 bug 111602
			self := l;
	end;
	iesp.smartlinxreport.t_SLRAddressBpsSeq setSequence(iesp.bpsreport.t_BpsReportAddress l, integer c ) := transform
	    self.addressSequence := c;  //
			self := l;
	end;
	//end of current indicator temp fix using TNT value.
	//=======================================================================

	s_addresses := project(subject_addrs_TNT, setCurrent(LEFT));  
	s_addressesSequence := project(s_addresses, setSequence(LEFT,COUNTER));
	s_addresses_current := s_addresses(verified=true);
	s_addresses_prior := s_addresses(verified=false);
	s_addresses_current_count := count(s_addresses_current);
	s_addresses_prior_count := count(s_addresses_prior);
	tmp_addresses   := choosen (SmartRollup.fn_smart_getAddrMetadata.addresses(s_addressesSequence,doBadSecRange,param),iesp.Constants.SMART.MaxAddress);
	p_addresses      := choosen (SmartRollup.fn_smart_getPhonesPlusMetadata.byPhone(tmp_addresses),iesp.Constants.SMART.MaxAddress);
	p_addresses_current := p_addresses(verified=true);
	p_addresses_prior   := p_addresses(verified=false);
	subject_imposters := IF (param.include_imposters, pers.imposters,dataset([],iesp.bps_share.t_BpsReportImposter));
	s_imposters        := SmartRollup.fn_smart_rollup_imposters(subject_imposters);
	p_imposter_entities := choosen(SmartRollup.fn_smart_imposter_entities(subject_imposters),  iesp.Constants.SMART.MaxImposters);
	s_imposters_count := count(s_imposters);
  p_imposters      := choosen (s_imposters,  iesp.Constants.SMART.MaxImposters);
  s_relatives      := IF (param.include_relatives, pers.RelativesSlim, dataset([],iesp.bpsreport.t_BpsReportRelativeSlim));
	s_relatives_count := count(s_relatives);
	relativesBase    := project(choosen (s_relatives,  iesp.constants.SMART.MaxRelatives),transform(iesp.smartlinxreport.t_SLRRelative, self.title := '', self.relativeofUniqueId := '', self := LEFT, self := []));;
	relativesOf      := SmartRollup.fn_relativeOf(relativesBase,subject_did,param);
	relativesTitle   := relativesOf;  // now titles are taken directly from new index doxie.Key_Relatives_V2
	p_relatives      := relativesTitle; 

	//Neighbors only want for subjects "current/newest" address,  20 addresses (10up10down), 2 Residents
	s_neighbors      := IF (param.include_neighbors, pers.NeighborsSlim, dataset([],iesp.bpsreport.t_NeighborSlim) );
	s_neighbors_count := count(s_neighbors.NeighborAddresses);  //count children since rows are neighborhoods.
  p_neighbors      := choosen (s_neighbors, iesp.constants.SMART.MaxNeighbors);
  p_sources        := PersonReports.SourceCounts_records (dids, module (project (param, input._sources)) end, IsFCRA);
//****************************************************************************************************
//     SINGLE SOURCE RECORDS
//****************************************************************************************************
  // LICENSES

	dl       := IF (param.include_driversLicenses, PersonReports.DL_records(dids), DATASET([],iesp.driverlicense2.t_DLEmbeddedReport2Record));
	s_dls    := SmartRollup.fn_smart_rollup_dls(dl);
	s_dls_count := count(s_dls);
  p_dls    := choosen(if (param.Smart_rollup,s_dls, dl), iesp.Constants.SMART.MaxDLs);

 	voters   := IF (param.include_voters, voter_records (dids,   module(project (param, input.voters, opt)) end, IsFCRA).voters_v2,dataset([],iesp.voter.t_VoterReport2Record));
 	s_voters := SmartRollup.fn_smart_rollup_voter(voters);
	s_voters_count := count(s_voters);
  p_voters := choosen (if (param.Smart_Rollup, s_voters, voters), iesp.Constants.SMART.MaxVoter);

	//combine proflic,  medprov, medsanc
  profmod   := personReports.proflic_records (dids, module (project (param, input.proflic, opt)) end, IsFCRA);
	prof      := IF (param.include_proflicenses and count(profmod.proflicenses_v2) <= iesp.constants.SMART.MaxUnRolledRecords, profmod.proflicenses_v2,dataset([],iesp.proflicense.t_ProfessionalLicenseRecord));
  sanc	    := IF (param.include_proflicenses, personReports.sanctions_records (dids, module (project (param, input.sanctions, opt)) end, IsFCRA),dataset([],iesp.proflicense.t_SanctionRecord));
	prov_recs := IF (param.include_proflicenses, personReports.providers_records (dids, module (project (param, input.providers, opt)) end, IsFCRA));
	prov      := IF (param.include_proflicenses and count(prov_recs) <= iesp.constants.SMART.MaxUnRolledRecords, prov_recs,dataset([],iesp.proflicense.t_ProviderRecord));
	s_profSancProv := SmartRollup.fn_smart_rollup_prof_lic(prof,prov,sanc);
	s_profSancProv_count := count(s_profSancProv);
 	p_profSancProv := choosen (if (param.Smart_rollup, s_profSancProv, dataset([],iesp.smartlinxreport.t_SLRProfLicenseAndSanctionAndProvider)), iesp.constants.SMART.MaxProfLic);
 
	aMod := module(project (globals,ATF_Services.IParam.search_params,opt)) 
	  export string14 did := (string)subject_did;
  end;
  firearms_pre:= IF (param.include_atf,ATF_Services.SearchService_Records.report(aMod, isFCRA, ds_flags));
  firearms    := project(firearms_pre,iesp.firearm.t_FirearmRecord);
 	s_firearms  := SmartRollup.fn_smart_rollup_atf(firearms);	
	s_firearms_count := count(s_firearms);
  p_firearms  := choosen(if (param.Smart_rollup,s_firearms, firearms), iesp.Constants.SMART.MaxFirearms);

  dea         := IF (param.include_controlledsubstances, PersonReports.dea_records(dids), dataset([],iesp.deacontrolledsubstance.t_DEAControlledSubstanceSearch2Record));
	s_dea       := SmartRollup.fn_smart_rollup_dea(dea);
	s_dea_count := count(s_dea);
  p_dea       := choosen (if (param.Smart_Rollup, s_dea, dea),iesp.Constants.SMART.MaxDEA);
 
	weaponsIesp_pre := IF (param.include_weaponpermits, PersonReports.ccw_records (dids, module (project (param, input.ccw)) end, isFCRA));
	weaponsIesp 	 := project(weaponsIesp_pre,iesp.concealedweapon.t_WeaponRecord);
  s_weapons      := SmartRollup.fn_smart_rollup_cweapons(weaponsIesp);
	s_weapons_count := count(s_weapons);
  p_weapons      := choosen (if (param.Smart_rollup, s_weapons, weaponsIesp),iesp.Constants.SMART.MaxWeapons);
 
	HF_recs 			 := doxie.hunting_records(dids, isFCRA, ds_flags(file_id = FCRA.FILE_ID.HUNTING_FISHING));
 	hunting        := IF (param.include_huntingfishing, HF_recs, dataset([],doxie_crs.layout_hunting_records));
  huntfishing    := SmartRollup.fn_hunting_iesp(hunting);
	s_hunting      := SmartRollup.fn_smart_rollup_hunting(huntfishing);
	s_hunting_count := count(s_hunting);
	p_hunting      := choosen (if (param.Smart_rollup, s_hunting, huntfishing),iesp.Constants.SMART.MaxHuntFish);
	faacertMod     := PersonReports.faacert_records (dids, module (project (param, input.faacerts,    opt)) end, IsFCRA);
  faa_cert       := IF (param.include_faacertificates, project(faacertMod.bps_view,iesp.bpsreport.t_BpsFAACertification),DATASET([],iesp.bpsreport.t_BpsFAACertification));
  s_faa_cert     := SmartRollup.fn_smart_rollup_faa_cert(faa_cert);
	s_faa_cert_count := count(s_faa_cert);
  p_faa_cert     := choosen (s_faa_cert, iesp.constants.SMART.MaxFaaCert);

	// PROPERTY
	assess_ext := record (iesp.propassess.t_AssessReportRecord)
    boolean IsSubjectOwned;
    unsigned4 srt_date;
  end;
  msearch := module (project (param, input.dummy_search, opt)) end; // msearch will fill in all the defaults (mainly, search), which I don't ever have when running a report
  added_in_mod   := project(msearch, foreclosure_services.raw.params);
	nod            := Foreclosure_Services.Raw.REPORT_VIEW.by_did(dids,added_in_mod,true);
	s_nod          := if (param.include_properties and not doxie.DataRestriction.Fares,nod,dataset([],iesp.foreclosure.t_ForeclosureReportRecord));
	p_nod          := CHOOSEN (s_nod, iesp.constants.SMART.MaxNOD);
	fore           := Foreclosure_Services.Raw.REPORT_VIEW.by_did(dids,added_in_mod,false);
	s_fore         := if (param.include_properties and not doxie.DataRestriction.Fares,fore,dataset([],iesp.foreclosure.t_ForeclosureReportRecord));
	s_fore_count   := count(s_fore);
	p_fore         := CHOOSEN (s_fore, iesp.constants.SMART.MaxForeclosures);
	propMod        := PersonReports.property_records (dids, param, IsFCRA, ds_flags);  //should set flag for Current or Prior owner
	propUnderLimit := (not excessive_property) and (count(propMod.property_v2) <= iesp.constants.SMART.MaxUnRolledRecords);
	allPropV2      := if (param.include_properties and propUnderLimit, project(propMod.property_v2,iesp.property.t_PropertyReport2Record),dataset([],iesp.property.t_PropertyReport2Record)); //used for other business assoc
	alldeed        := if (param.include_properties and propUnderLimit, project(propMod.prop_deeds_all,iesp.propdeed.t_DeedReportRecord),dataset([],iesp.propdeed.t_DeedReportRecord));
  allass         := if (param.include_properties and propUnderLimit, project(propMod.formatted_assess_all,assess_ext),dataset([],assess_ext)); //exported this dataset because I need isSubjectOwned flag
  s_prop         := SmartRollup.fn_smart_rollup_prop(allass, alldeed, p_fore, p_nod, subject_did, param );
  a_prop				 := SmartRollup.fn_smart_aml_properties(s_prop,param); // AML property version
	out_prop			 := if(param.include_aml_property, a_prop, s_prop);
	s_nod_count    := count(out_prop(NoticeOfDefaultFound or ForeclosureFound));
  s_prop_current := out_prop(CurrentPrior=iesp.Constants.SMART.CURRENT);	
  s_prop_prior 	 := out_prop(CurrentPrior=iesp.Constants.SMART.PRIOR or CurrentPrior=iesp.Constants.SMART.UNKNOWN);
	s_prop_current_count := count(s_prop_current);
	s_prop_prior_count := count(s_prop_prior);
	p_prop_current := choosen (if (param.Smart_rollup, s_prop_current , dataset([],iesp.smartlinxreport.t_SLRPropertyAssessmentDeedsRecord)), iesp.constants.SMART.MaxProperties);
	p_prop_prior   := choosen (if (param.Smart_rollup, s_prop_prior   , dataset([],iesp.smartlinxreport.t_SLRPropertyAssessmentDeedsRecord)), iesp.constants.SMART.MaxProperties);
	

	// OTHER PROPERTY SECTION 
	emails      := IF (param.include_email,  PersonReports.email_records(dids, module (project (param, input.emails)) end, IsFCRA), dataset([],iesp.emailsearch.t_EmailSearchRecord));
	s_emails    := SmartRollup.fn_smart_rollup_email(emails);  //count children since rows are per source
	s_emails_count := count(s_emails);
	p_emails      := choosen (s_emails, iesp.Constants.SMART.MaxEmails);	

  vehiclesMod   := PersonReports.vehicle_records (dids, module (project (param, input.vehicles, opt)) end, IsFCRA);
	vehicles      := IF (param.include_motorvehicles and count(vehiclesMod.vehicles_v2) < iesp.constants.SMART.MaxUnRolledRecords, vehiclesMod.vehicles_v2,dataset([],iesp.motorvehicle.t_MotorVehicleReport2Record)); //using vehicles instead of vehicles_v2 because the v2 version doesn't contain historyFlag.
	s_vehicles    := SmartRollup.fn_smart_rollup_veh(vehicles, subject_did);
  s_vehicles_current := s_vehicles(CurrentPrior=iesp.Constants.SMART.CURRENT);
  s_vehicles_prior   := s_vehicles(CurrentPrior=iesp.Constants.SMART.PRIOR);
  s_vehicles_current_count := count(s_vehicles_current);
  s_vehicles_prior_count   := count(s_vehicles_prior);
	p_vehicles_current := choosen (if (param.Smart_rollup, s_vehicles_current,
	                              project(vehicles,transform(iesp.smartlinxreport.t_SLRVehicle, self := left, self.LengthOfOwnership := '', self.currentPrior := If (Left.isCurrent,iesp.Constants.SMART.CURRENT,iesp.Constants.SMART.PRIOR)))),
														iesp.Constants.SMART.MaxVehicles);
	p_vehicles_prior   := choosen (if (param.Smart_rollup, s_vehicles_prior,
	                              project(vehicles,transform(iesp.smartlinxreport.t_SLRVehicle, self := left, self.LengthOfOwnership := '', self.currentPrior := If (Left.isCurrent,iesp.Constants.SMART.CURRENT,iesp.Constants.SMART.PRIOR)))),
														iesp.Constants.SMART.MaxVehicles);
														
	watercraftMod := PersonReports.watercraft_records (dids, module (project (param, input.watercrafts,  opt)) end, IsFCRA,true, ds_flags);
	//watercrafts   := watercraftMod.wtr_recs;
	watercrafts   := IF (param.include_watercrafts, watercraftMod.watercrafts_v2,dataset([],iesp.watercraft.t_WaterCraftReport2Record));
	s_watercrafts := SmartRollup.fn_smart_rollup_watercraft(watercrafts);
	s_watercrafts_current := s_watercrafts(CurrentPrior=iesp.Constants.SMART.CURRENT);
	s_watercrafts_prior := s_watercrafts(CurrentPrior=iesp.Constants.SMART.PRIOR);
	s_watercrafts_current_count := count(s_watercrafts_current);
	s_watercrafts_prior_count := count(s_watercrafts_prior);
	
  p_watercrafts_current := choosen (if (param.Smart_rollup,s_watercrafts_current, 
	                             project(watercrafts, transform(iesp.smartlinxreport.t_SLRWatercraft, self.LengthOfOwnership := '', self := left, self := []))),
													 iesp.Constants.SMART.MaxWatercrafts);
  p_watercrafts_prior := choosen (if (param.Smart_rollup,s_watercrafts_prior, 
	                             project(watercrafts, transform(iesp.smartlinxreport.t_SLRWatercraft, self := left, self := []))),
													 iesp.Constants.SMART.MaxWatercrafts);													 
	aircrafts     := IF (param.include_faaaircrafts, project(PersonReports.aircraft_records(dids, module (project (param, input.aircrafts,   opt)) end, IsFCRA),iesp.faaaircraft.t_aircraftReportRecord),dataset([],iesp.faaaircraft.t_aircraftReportRecord));
	s_aircrafts   := SmartRollup.fn_smart_rollup_aircraft(aircrafts);
	s_aircrafts_current := s_aircrafts(CurrentPrior=iesp.Constants.SMART.CURRENT);
	s_aircrafts_prior := s_aircrafts(CurrentPrior=iesp.Constants.SMART.PRIOR);
	s_aircrafts_current_count := count(s_aircrafts_current);
	s_aircrafts_prior_count := count(s_aircrafts_prior);	
	p_aircrafts_current   := choosen (if (param.Smart_rollup,s_aircrafts_current, 
                                project(aircrafts,transform(iesp.smartlinxreport.t_SLRAircraft, self := left, self := []))),
														iesp.Constants.SMART.MaxAircrafts);
  p_aircrafts_prior   := choosen (if (param.Smart_rollup,s_aircrafts_prior, 
                                project(aircrafts,transform(iesp.smartlinxreport.t_SLRAircraft, self := left, self := []))),
														iesp.Constants.SMART.MaxAircrafts);		
									
// Bankruptcy, LiensJudgements, UCC
  bankruptcyMod := PersonReports.bankruptcy_records(dids, module (project (param, input.bankruptcy,  opt)) end, IsFCRA);
	bankruptcy    := IF (param.include_bankruptcy,  bankruptcyMod.bankruptcy_v2, dataset([],iesp.bankruptcy.t_BankruptcyReport2Record));
  s_bankruptcy  := SmartRollup.fn_smart_rollup_bankruptcy(bankruptcy);  
	s_bankruptcy_active := s_bankruptcy(ActiveClosed=iesp.Constants.SMART.ACTIVE);
	s_bankruptcy_closed := s_bankruptcy(ActiveClosed=iesp.Constants.SMART.CLOSED);
	s_bankruptcy_active_count := count(s_bankruptcy_active);
	s_bankruptcy_closed_count := count(s_bankruptcy_closed);
	p_bankruptcy_active  := choosen (if (param.Smart_rollup, s_bankruptcy_active, 
	                              project(bankruptcy,transform(iesp.smartlinxreport.t_SLRbankruptcy, self := left, self := []))),
	                          iesp.Constants.SMART.MaxBankruptcies);
	p_bankruptcy_closed  := choosen (if (param.Smart_rollup, s_bankruptcy_closed, 
	                              project(bankruptcy,transform(iesp.smartlinxreport.t_SLRbankruptcy, self := left, self := []))),
	                          iesp.Constants.SMART.MaxBankruptcies);
  liensMod      := PersonReports.lienjudgment_records (dids,MODULE (project (param, input.liens, opt)) END , IsFCRA);
	liens         := IF (param.include_liensjudgments,   project(liensMod.liensjudgment_v2(),iesp.lienjudgement.t_LienJudgmentReportRecord), dataset([],iesp.lienjudgement.t_LienJudgmentReportRecord));
  s_liens       := SmartRollup.fn_smart_rollup_liens(liens);  
	s_liens_active := s_liens(ActiveClosed=iesp.Constants.SMART.ACTIVE);
	s_liens_terminated := s_liens(ActiveClosed=iesp.Constants.SMART.TERMINATED);
  s_liens_active_count := count(s_liens_active);
	s_liens_terminated_count := count(s_liens_terminated);	
  p_liens_active       := choosen (if (param.Smart_rollup,s_liens_active, 
	                              project(liens,transform(iesp.smartlinxreport.t_SLRLienJudgment, self := left, self := []))),
	                          iesp.Constants.SMART.MaxLiens);
  p_liens_terminated       := choosen (if (param.Smart_rollup,s_liens_terminated, 
	                              project(liens,transform(iesp.smartlinxreport.t_SLRLienJudgment, self := left, self := []))),
	                          iesp.Constants.SMART.MaxLiens);
														
	uccsMod       := PersonReports.ucc_records (dids, module (project (param, input.ucc, opt)) end, IsFCRA);
	uccsRecs      := uccsMod.ucc_v2;
	uccs          := IF (param.include_uccfilings and count(uccsRecs) < iesp.constants.SMART.MaxUnRolledRecords,  uccsRecs,dataset([],iesp.ucc.t_UCCReport2Record));
	s_uccs        := SmartRollup.fn_smart_rollup_ucc(uccs,subject_did);
	s_uccs_debtor := s_uccs(SubjectIs=iesp.Constants.SMART.DEBTOR);
	s_uccs_securer := s_uccs(SubjectIs=iesp.Constants.SMART.SECURER);
	s_uccs_debtor_count := count(s_uccs_debtor);
	s_uccs_securer_count := count(s_uccs_securer);
  p_uccs_debtor        := choosen (if (param.Smart_rollup,s_uccs_debtor, 
	                              project(uccs,transform(iesp.smartlinxreport.t_SLRUcc, self := left, self := []))),
	                          iesp.constants.SMART.MaxUCCs);	
  p_uccs_securer  := choosen (if (param.Smart_rollup,s_uccs_securer, 
	                              project(uccs,transform(iesp.smartlinxreport.t_SLRUcc, self := left, self := []))),
	                          iesp.constants.SMART.MaxUCCs);

  crim          := IF (param.include_crimrecords, PersonReports.criminal_records  (dids, module (project (param, PersonReports.input.criminal,  opt)) end, IsFCRA),dataset([],iesp.criminal.t_CrimReportRecord));  
	p_crim        := choosen(crim,iesp.constants.SMART.MaxCrimRecords);
  p_crim_doc_count := count(p_crim(stringlib.stringToUppercase(Datasource)=iesp.Constants.SMART.DOC));
  p_crim_arrest_count := count(p_crim(stringlib.stringToUppercase(Datasource)=iesp.Constants.SMART.ARRESTLOG));
  p_crim_crim_count := count(p_crim(stringlib.stringToUppercase(Datasource)=iesp.Constants.SMART.CRIMINALCOURT));
		 
	sexoff        := IF (param.include_sexualoffences, PersonReports.sexoffenses_records  (dids, module (project (param, PersonReports.input.sexoffenses,  opt)) end, IsFCRA),dataset([],iesp.sexualoffender.t_SexOffReportRecord));	
	p_sexOff      := choosen(sexoff,iesp.constants.SMART.MaxSexualOffenses);
	p_sexOff_count := count(p_sexOff);
//ASSOCIATIONS
  //INDIVIDUALS  relatives, neighbors are assigned above  

  //BUSINESS
     pawRaw     := IF (param.include_peopleatwork, PersonReports.peopleatwork_records (dids,module (project (param, input.peopleatwork, opt))end, IsFCRA),dataset([],iesp.peopleatwork.t_PeopleAtWorkRecord));    
		 pawMod     := SmartRollup.smart_paw(pawRaw);
		 pawNonExec := SmartRollup.fn_smart_rollup_paw(pawMod.paw_nonExec);  //non-executives ONLY rolled up
		 pawNonExec_count := count(pawNonExec);
		 pawExec   := SmartRollup.fn_smart_rollup_paw(pawMod.paw_exec);  //executives ONLY rolled up
		 p_paw     := choosen (pawNonExec, iesp.Constants.SMART.MaxPeopleAtWork);    
     corp_aff_raw  := IF (param.include_corpaffiliations,PersonReports.corpaffiliation_records (dids, module (project (param, input.corpaffil,opt)) end, IsFCRA),dataset([],iesp.bpsreport.t_BpsCorpAffiliation));
		 corp_aff  := SmartRollup.fn_corp_aff_titles(corp_aff_raw); //standardizes titles
		 fbn       := IF (param.include_corpaffiliations,doxie.Comp_FBN2Search(dids),dataset([],iesp.fictitiousbusinesssearch.t_FictitiousBusinessSearchRecord)); 
     s_corp_aff := SmartRollup.fn_smart_rollup_corp_aff(corp_aff, fbn, pawExec);  //fbn added to corp_aff as part of requirements bug 97177   
		 s_corp_aff_count := count(s_corp_aff);
		 p_corp_aff :=  choosen(s_corp_aff, iesp.Constants.SMART.MaxBusiness);
		 

		 s_other_busi_assoc := SmartRollup.fn_smart_OtherBusAssoc(allPropV2, uccs, liens, bankruptcy, vehicles, watercrafts, aircrafts, subject_did);
     p_other_busi_assoc_count := count(s_other_busi_assoc);
		 p_other_busi_assoc := choosen(s_other_busi_assoc, iesp.constants.SMART.MaxOtherBusi);


		 associates       := IF (param.include_associates,  pers.AssociatesSlim, dataset([],iesp.bpsreport.t_BpsReportAssociateSlim));  
		 s_associates     := SmartRollup.fn_smart_OtherPersonAssoc(associates,subject_did,param);
		 s_associates_count := count(s_associates);
     p_associates     := choosen (s_associates, iesp.constants.SMART.MaxAssociates);
		  american_student_input := MODULE(PROJECT(globals, American_Student_Services.IParam.reportParams,opt)) end;
 
		 boolean onlyCurrent := true;  //request only current student records.
     p_education := if(param.include_students,
                        choosen(American_Student_Services.Functions.get_report_recs(dids,
												                                                            american_student_input, 
																																										onlyCurrent),
																																										iesp.Constants.MaxCountASLSearch));
     p_education_count := count(p_education);
	
		 // Key risk indicator
		 s_kris := SmartRollup.fn_smart_KRIAttributes(param,subject_did,best_rec_smart[1],p_profSancProv,p_akas,relativesOf,true);
		 p_kris := IF(param.include_kris,PROJECT(s_kris,TRANSFORM(iesp.smartlinxreport.t_SLRKeyRiskIndInfo,SELF := LEFT)),
																			dataset([],iesp.smartlinxreport.t_SLRKeyRiskIndInfo));
		 
		 p_worldcompliance := IF(param.include_kris,PROJECT(s_kris.WorldCompRecs,TRANSFORM(iesp.smartlinxsearchcore.t_SLRResultMatch,SELF := LEFT)),
																			dataset([],iesp.smartlinxsearchcore.t_SLRResultMatch));
	 
//****************************************************************************************************
//     OUTPUT TRANSFORM
//****************************************************************************************************
  out_rec Format () := TRANSFORM
     Self.UniqueId := intformat (subject_did, 12, 1);
//KEY INDICATORS *******************************************************************************************		
//Counts are based on number found prior to choosen() limit application.
     self.TotalCountsAvailable.Education                   := p_education_count;
		 self.TotalCountsAvailable.Voters                      := s_voters_count;
	  
		 self.TotalCountsAvailable.AddressCurrent              := s_addresses_current_count;
     self.TotalCountsAvailable.AddressPrior                := s_addresses_prior_count;
     self.TotalCountsAvailable.Drivers                     := s_dls_count;
    
     self.TotalCountsAvailable.ProfessionalLicense         := s_profSancProv_count; 
     self.TotalCountsAvailable.FirearmExplosives           := s_firearms_count; 
     self.TotalCountsAvailable.Weapons                     := s_weapons_count; 
     self.TotalCountsAvailable.DEA                         := s_dea_count; 
     self.TotalCountsAvailable.Hunting                     := s_hunting_count;
     self.TotalCountsAvailable.FAACert                     := s_faa_cert_count;
     Self.TotalCountsAvailable.PropertyCurrent             := s_prop_current_count; 
     Self.TotalCountsAvailable.PropertyPrior               := s_prop_prior_count; 		 
     self.TotalCountsAvailable.VehicleCurrent              := s_vehicles_current_count;
     self.TotalCountsAvailable.VehiclePrior                := s_vehicles_prior_count;
     self.TotalCountsAvailable.WatercraftCurrent           := s_watercrafts_current_count;
     self.TotalCountsAvailable.WatercraftPrior             := s_watercrafts_prior_count;
     self.TotalCountsAvailable.AircraftCurrent             := s_aircrafts_current_count;
     self.TotalCountsAvailable.AircraftPrior               := s_aircrafts_prior_count;
     self.TotalCountsAvailable.BankruptcyActive            := s_bankruptcy_active_count;
     self.TotalCountsAvailable.BankruptcyClosed            := s_bankruptcy_closed_count ;
     self.TotalCountsAvailable.LiensJudgmentsActive        := s_liens_active_count;
     self.TotalCountsAvailable.LiensJudgmentsClosed        := s_liens_terminated_count;
     self.TotalCountsAvailable.UCCDebtor                   := s_uccs_debtor_count;
     self.TotalCountsAvailable.UCCSecurer                  := s_uccs_securer_count;
     self.TotalCountsAvailable.CriminalDOC                 := p_crim_doc_count;
     self.TotalCountsAvailable.CriminalArrest              := p_crim_arrest_count;
     self.TotalCountsAvailable.CriminalCourt               := p_crim_crim_count;
     self.TotalCountsAvailable.SexualOffender              := p_sexOff_count;
     self.TotalCountsAvailable.Aka                         := s_akas_count;
     self.TotalCountsAvailable.EmailAddress                := s_emails_count; 
     self.TotalCountsAvailable.Imposter                    := s_imposters_count;
     self.TotalCountsAvailable.NoticesOfDefault            := s_nod_count; 
     self.TotalCountsAvailable.Foreclosure                 := s_fore_count; 
     self.TotalCountsAvailable.Relative                    := s_relatives_count;
     self.TotalCountsAvailable.Associate                   := s_associates_count;
     self.TotalCountsAvailable.Neighbor                    := s_neighbors_count;
     self.TotalCountsAvailable.CorporateAffiliation        := s_corp_aff_count;
     self.TotalCountsAvailable.PeopleAtWork                := pawNonExec_count;
     self.TotalCountsAvailable.OtherAssociatedBusiness     := p_other_busi_assoc_count;

//SUBJECT *******************************************************************************************
     Self.BestInfo                         := best_rec_smart[1];   
	   Self.AKAs                             := p_akas;
		 Self.AKAEntities                      := p_aka_entities;
     Self.ReportAddresses.CurrentAddresses := p_addresses_current;
     Self.ReportAddresses.PriorAddresses   := p_addresses_prior;
		 Self.EmailAddresses                   := p_emails;
     Self.Imposters                        := p_imposters;
		 Self.ImposterEntities                 := p_imposter_entities;
     Self.SexualOffenses                   := p_sexOff;
		 Self.Criminals                        := p_crim;
		 self.Educations                       := p_education;
		 Self.KriInfo													 := p_kris[1];
		 Self.WorldComplianceRecords 					 := p_worldcompliance;
	
//LICENSES *******************************************************************************************		
		 Self.Drivers                          := p_dls;
	   Self.VoterRegistrations               := p_voters;    
		 Self.ProfessionalLicenses             := p_profSancProv; 
     Self.FireArmExplosives                := p_firearms;  
     Self.WeaponPermits                    := p_weapons;		
	   Self.ControlledSubstances             := p_dea;    
     Self.HuntingFishingLicenses           := p_hunting;		
		 Self.FAACertifications                := p_faa_cert;

////PROPERTY *******************************************************************************************		
  
		 Self.Properties.CurrentProperties     := p_prop_current; 
     Self.Properties.PriorProperties       := p_prop_prior; 
		 Self.NoticesOfDefault                 := p_nod; 
		 Self.Foreclosures                     := p_fore;
		 Self.Vehicles.CurrentVehicles         := p_vehicles_current;
		 Self.Vehicles.PriorVehicles           := p_vehicles_prior;
     Self.WaterCrafts.CurrentWatercrafts   := p_watercrafts_current;		
     Self.WaterCrafts.PriorWatercrafts     := p_watercrafts_prior;		
		 Self.Aircrafts.CurrentAircrafts       := p_aircrafts_current;
		 Self.Aircrafts.PriorAircrafts         := p_aircrafts_prior;

//// BLJ *******************************************************************************************   
     Self.Bankruptcies.ActiveBankruptcies     := p_bankruptcy_active; 
     Self.Bankruptcies.ClosedBankruptcies     := p_bankruptcy_closed; 
     Self.LiensJudgments.ActiveLiensJudgments := p_liens_active;
     Self.LiensJudgments.ClosedLiensJudgments := p_liens_terminated;
     Self.UccFilings.DebtorUCCFilings         := p_uccs_debtor;
     Self.UccFilings.SecurerUCCFilings        := p_uccs_securer;
//// ASSOCIATES *******************************************************************************************
   //// PEOPLE ASSOCS

 		 Self.Relatives                         := p_relatives;
   	 Self.Associates                        := p_associates;
     Self.Neighbors                         := p_neighbors;
   	 // BUSINESS ASSOCS
   	 Self.CorporateAffiliations             := p_corp_aff; 
   	 Self.PeopleAtWorks                     := p_paw;    
  	 self.OtherAssociatedBusinesses         := p_other_busi_assoc; 
//// SOURCES *******************************************************************************************
    
		Self.Sources :=     p_sources;
		Self.Messages :=    messages_property_ds;//add addition messages once the Max of 1 is taken off of iesp.bpsreport.t_BpsReportBaseResponse
		self := [];
 END;
  individual := dataset ([Format ()]); // is supposed to produce one row only (usebestdid = true)

	return individual;
END;


