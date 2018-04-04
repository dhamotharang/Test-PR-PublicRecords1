import Doxie, Doxie_Raw, doxie_ln, utilfile, header_quick, autokeyb, ut, moxie_phonesplus_server, 
       LN_PropertyV2_Services, mdr, iesp, AutoStandardI, CriminalRecords_Services,American_Student_Services;

doxie.MAC_Header_Field_Declare();
doxie.MAC_Selection_Declare ();

export ViewSourceDid(
    dataset(Doxie_Raw.Layout_input) input,
    unsigned4 dateVal = 0,
    unsigned1 dppa_purpose = 0,
    unsigned1 glb_purpose = 0,
		string32 application_type_value = '',
		boolean ln_branded_value = false,
		boolean probation_override_value = false,
		string5 industry_class_value,
    boolean IsCRS = false,
		string6 ssn_mask_value = 'NONE',
		boolean dl_mask_value = false,
		BankruptcyVersion = 0,
		JudgmentLienVersion = 0,
		UccVersion = 0,
		DlVersion = 0,
		VehicleVersion = 0,
		VoterVersion = 0,
		DeaVersion =0,
		CriminalRecordVersion =0,
		string1 in_party_type = ''
) := FUNCTION
global_mod := AutoStandardI.GlobalModule();
//================== Section Select ==========================
boolean IncludeBlankDOD := false : stored('IncludeBlankDOD');
boolean viewAll(string20 sect) := sect = '';

boolean viewSSN(string20 sect) := sect = 'ssn'; //No ssn for 'ALL' option for now.
boolean viewDob(string20 sect) := sect = 'dob'; //No dob for 'ALL' option for now.
boolean viewCompAddress(string20 sect) := sect = 'addresses'; //No compAddress for 'ALL' option.

boolean viewPP(string20 sect)        	:= IF (IsCRS, Include_PhonesPlus_val, viewAll(sect) OR sect = 'pp');
boolean viewAtf(string20 sect)        := IF (IsCRS, Include_FirearmsAndExplosives_val, viewAll(sect) OR sect = 'atf');
boolean viewBK(string20 sect)         := BankruptcyVersion in [0,1] and IF (IsCRS, Include_Bankruptcies_val, viewAll(sect) OR sect = 'bk');
boolean viewBKV2(string20 sect)       := BankruptcyVersion in [0,2] and IF (IsCRS, Include_Bankruptcies_val, viewAll(sect) OR sect = 'bk_v2');
boolean viewLien(string20 sect)       := JudgmentLienVersion in [0,1] and IF (IsCRS, Include_LiensJudgments_val, viewAll(sect) OR sect = 'lien');
boolean viewLienV2(string20 sect)     := JudgmentLienVersion in [0,2] and IF (IsCRS, Include_LiensJudgments_val, viewAll(sect) OR sect = 'lien_v2');
boolean viewDL(string20 sect)         := DlVersion in [0,1] and IF (IsCRS, Include_DriversLicenses_val, viewAll(sect) OR sect = 'dl');
boolean viewDL2(string20 sect)        := DlVersion in [0,2] and IF (IsCRS, Include_DriversLicenses_val, viewAll(sect) OR sect = 'dl_v2');
boolean viewDeath(string20 sect)      := viewAll(sect) OR sect = 'death';
boolean viewStateDeath(string20 sect) := viewAll(sect) OR sect = 'statedeath';
boolean viewProfLic(string20 sect)    := IF (IsCRS, Include_ProfessionalLicenses_val, viewAll(sect) OR sect = 'proflic');
boolean viewSanc(string20 sect)				:= IF (IsCRS, Include_Sanctions_val, viewAll(sect) OR sect = 'sanc');
boolean viewProv(string20 sect)				:= IF (IsCRS, Include_Providers_val, viewAll(sect) OR sect = 'prov');
boolean viewEmail(string20 sect)			:= IF (isCRS, Include_Email_addresses_val, viewAll(sect) or sect = 'email');
boolean viewVeh(string20 sect)        := VehicleVersion in [0,1] and IF (IsCRS, Include_MotorVehicles_val, viewAll(sect) OR sect = 'veh');
boolean viewVehV2(string20 sect)      := VehicleVersion in [0,2] and IF (IsCRS, Include_MotorVehicles_val, viewAll(sect) OR sect = 'veh_v2');
boolean viewDea(string20 sect)        := DeaVersion in [0,1] and IF (IsCRS, Include_DEA_Val, viewAll(sect) OR sect = 'dea');
boolean viewDeaV2(string20 sect)      := DeaVersion in [0,2] and IF (IsCRS, Include_DEA_Val, viewAll(sect) OR sect = 'dea_v2');
boolean viewAirCraft(string20 sect)   := IF (IsCRS, Include_FAAAircrafts_val, viewAll(sect) OR sect = 'airc');
boolean viewWatercraft(string20 sect) := IF (IsCRS, Include_Watercrafts_val, viewAll(sect) OR sect = 'watercraft');
boolean viewVoter(string20 sect)      := VoterVersion in [0,1] and IF (IsCRS, Include_VoterRegistrations_val, viewAll(sect) OR sect = 'voter');
boolean viewVoterV2(string20 sect)    := VoterVersion in [0,2] and IF (IsCRS, Include_VoterRegistrations_val, viewAll(sect) OR sect = 'voter_v2');
boolean viewCcw(string20 sect)        := viewAll(sect) OR sect = 'ccw';
boolean viewHunt(string20 sect)       := IF (IsCRS, Include_HuntingFishingLicenses_val, viewAll(sect) OR sect = 'hunt');
boolean viewPilot(string20 sect)      := viewAll(sect) OR sect = 'pilot';
boolean viewPilotCert(string20 sect)  := IF (IsCRS, Include_FAACertificates_val, viewAll(sect) OR sect = 'pilotcert');
boolean viewPhone(string20 sect)      := viewAll(sect) OR sect = 'phone';
boolean viewWhoIs(string20 sect)      := IF (IsCRS, Include_InternetDomains_val, viewAll(sect) OR sect = 'whois');
boolean viewUCC(string20 sect)        := UccVersion in [0,1] and IF (IsCRS, Include_UCCFilings_val, viewAll(sect) OR sect = 'ucc');
boolean viewUCCv2(string20 sect)      := UccVersion in [0,2] and IF (IsCRS, Include_UCCFilings_val, viewAll(sect) OR sect = 'ucc_v2');
boolean viewCorpAffil(string20 sect)  := IF (IsCRS, Include_CorporateAffiliations_val, viewAll(sect) OR sect = 'corpaffil');
boolean viewProperty(string20 sect)   :=  PropertyVersion in [0,1] and IF (IsCRS, Include_Properties_val, viewAll(sect) OR sect = 'property');
boolean viewAssessment(string20 sect) := PropertyVersion in [0,1] and IF (IsCRS, Include_Properties_val, viewAll(sect) OR sect = 'assessment');
boolean viewDeed(string20 sect)       := PropertyVersion in [0,1] and IF (IsCRS, Include_Properties_val, viewAll(sect) OR sect = 'deed');
boolean viewPropertyV2(string20 sect)   := PropertyVersion in [0,2] and IF (IsCRS, Include_Properties_val, viewAll(sect) OR sect = 'property_v2');
boolean viewAssessmentV2(string20 sect) := PropertyVersion in [0,2] and IF (IsCRS, Include_Properties_val, viewAll(sect) OR sect = 'assessment_v2');
boolean viewDeedV2(string20 sect)       := PropertyVersion in [0,2] and IF (IsCRS, Include_Properties_val, viewAll(sect) OR sect = 'deed_v2');
boolean viewFinder(string20 sect)     := viewAll(sect) OR sect = 'finder';
boolean viewEQ(string20 sect)         := viewAll(sect) OR sect = 'eq';
boolean viewEN(string20 sect)         := (viewAll(sect) OR sect = 'en') and not doxie.DataRestriction.ECH;
boolean viewUtil(string20 sect)       := viewAll(sect) OR sect = 'util';
boolean viewAK(string20 sect)         := viewAll(sect) OR sect = 'ak';
boolean viewMSWork(string20 sect)     := viewAll(sect) OR sect = 'mswork';
boolean viewFor(string20 sect)        := IF (IsCRS, include_foreclosures_val, viewAll(sect) OR sect = 'for');
boolean viewNOD(string20 sect)        := IF (IsCRS, Include_NoticeOfDefaults_val, viewAll(sect) OR sect = 'nod');
boolean viewBoater(string20 sect)     := viewAll(sect) OR sect = 'boater';
boolean viewTU(string20 sect)         := viewAll(sect) OR sect = 'tu';
boolean viewTN(string20 sect)         := viewAll(sect) OR sect = 'tn';
boolean viewFLCrash(string20 sect)    := IF (IsCRS, Include_Accidents_val, viewAll(sect) OR sect = 'flcrash');
// "doc" is shared between v1 and v2
boolean viewDOC  (string20 sect)      := CriminalRecordVersion in [0,1] and IF (IsCRS, Include_CriminalRecords_val, viewAll(sect) OR sect = 'doc');
boolean viewDOCv2(string20 sect)      := CriminalRecordVersion in [0,2] and IF (IsCRS, Include_CriminalRecords_val, viewAll(sect) OR sect = 'doc');



boolean viewSexOffender(string20 sect):= IF (IsCRS, Include_SexualOffenses_val, viewAll(sect) OR sect = 'sexoffender');
//probably not needed here since they're only ever filled in for a Loc Report
boolean viewBusHeader(string20 sect)  := viewAll(sect) OR sect = 'busheader';

// -- Removed Quickheader section from headersourceservice since the records are redundant and will appear in their respective sections(equifax, bankruptcy, etc..)
boolean viewQuickHeader(string20 sect):= viewAll(sect) OR sect = 'qh';

boolean viewTargus(string20 sect)     := viewAll(sect) OR sect = 'targ';
boolean viewFBNv2(string20 sect)      := viewAll(sect) OR sect = 'fbnv2';
boolean viewStudent(string20 sect)    := viewALL(sect) OR sect = 'student';

//=============== Extract Children =================================
did0 := doxie_raw.ds_EmptyDIDs;
bdid0 := doxie_raw.ds_EmptyBDIDs;
tmsid0 := doxie_raw.ds_EmptyTMSIDs;

//============================= rid children ========================
//address, ssn and dob section
ds_address := IF(EXISTS(input(idtype = 'DID',viewCompAddress(section))),
	Doxie_Raw.CompAddress_Raw(input(idtype = 'DID',viewCompAddress(section)), dateVal, dppa_purpose, glb_purpose, 
                            ln_branded_value,probation_override_value,ssn_mask_value,dl_mask_value,application_type_value, industry_class_value));
ds_ssn := IF(EXISTS(input(idtype = 'DID', viewSSN(section))),
	Doxie_Raw.SSN_Raw(input(idtype = 'DID',viewSSN(section)),dateVal,dppa_purpose,glb_purpose,ssn_mask_value,dl_mask_value,application_type_value));
ds_dob := IF(EXISTS(input(idtype = 'DID', viewDob(section))),
	Doxie_Raw.Dob_Raw(input(idtype = 'DID',viewDob(section)),dateVal,dppa_purpose,glb_purpose,ssn_mask_value,dl_mask_value,application_type_value));

//============================= did children ====================================
Doxie_raw.layout_crs_raw getDidChildren(Doxie_Raw.Layout_input fileL) := transform
    unsigned6 did := (unsigned6)fileL.id;
    SELF.did := did;
		dids := dataset([{did}],Doxie.layout_references);
		ds_email_child := if(viewEmail(fileL.section), Doxie.email_records(dids,ssn_mask_value,application_type_value));
    ds_death_child := if(viewDeath(fileL.section),Doxie_raw.death_raw(dids, , dateVal, dppa_purpose, glb_purpose,ssn_mask_value)(IncludeBlankDOD or (integer)DOD8 > 0 ));
    ds_state_death_child := if(viewStateDeath(fileL.section),Doxie_raw.state_death_raw(dids, dateVal, dppa_purpose, glb_purpose,ssn_mask_value));		
    ds_atf_child := if(viewAtf(fileL.section), Doxie_raw.atf_raw(dids, dateVal, dppa_purpose, glb_purpose,ssn_mask_value));
    ds_bk_child := if(viewBK(fileL.section),Doxie_raw.bk_raw(dids, bdid0, , , dateVal, dppa_purpose, glb_purpose, ssn_mask_value, in_party_type));
		ds_bk_v2_child := if(viewBKV2(fileL.section),Doxie_raw.bkV2_raw(dids, bdid0, , dateVal, ssn_mask_value, in_party_type));
	  ds_lien_child := if(viewLien(fileL.section), Doxie_raw.Lien_Raw(dids, bdid0, dateVal, dppa_purpose, glb_purpose,,,,,,,,,ssn_mask_value,in_party_type));
	  ds_lien_v2_child := if(viewLienV2(fileL.section), Doxie_raw.Liensv2_Raw(dids, bdid0, tmsid0, dateVal, dppa_purpose, glb_purpose,,,,,,,,ssn_mask_value,in_party_type,application_type_value));
	  ds_dl_child := if(viewDl(fileL.section), Doxie_raw.DL_Raw(dids, dateVal, dppa_purpose, glb_purpose, ln_branded_value,,,,,,,,,,,ssn_mask_value,dl_mask_value));
	  ds_dl2_child := if(viewDl2(fileL.section), Doxie_Raw.DLV2_Raw(dids, , ,dppa_purpose, ssn_mask_value) );
	  ds_proflic_child := if(viewProfLic(fileL.section), Doxie_raw.PL_Raw(dids, bdid0, '', dateVal,dppa_purpose, glb_purpose,ssn_mask_value));
		ds_sanc_child := if(viewSanc(fileL.section),Doxie_Raw.Sanc_Raw(dids,,dateVal));
		ds_prov_child := if(viewProv(fileL.section),Doxie_Raw.Prov_Raw(dids)); 	  
		ds_veh_child := if(viewVeh(fileL.section), Doxie_raw.Veh_Raw(dids, , , , , , , dateVal, dppa_purpose, glb_purpose, ln_branded_value,ssn_mask_value,dl_mask_value,,,,application_type_value,IncludeNonRegulatedVehicleSources));
    ds_veh_v2_child := if(viewVehV2(fileL.section), Doxie_raw.VehV2_Raw(dids,,,ssn_mask_value,dateVal));	  
    ds_dea_child := if(viewDea(fileL.section), Doxie_raw.Dea_Raw(dids, bdid0, dateVal, dppa_purpose, glb_purpose, ssn_mask_value));
		ds_dea_v2_child := if(viewDeaV2(fileL.section), Doxie_raw.DeaV2_Raw(dids, bdid0,, dppa_purpose, glb_purpose, ssn_mask_value,application_type_value));
	  ds_airc_child := if(viewAircraft(fileL.section), Doxie_raw.AirCraft_Raw(dids, bdid0, dateVal, dppa_purpose, glb_purpose,ssn_mask_value,application_type_value));
    ds_watercraft_child := if(viewWaterCraft(fileL.section), Doxie_Raw.WaterCraft_Raw(dids, dateVal, dppa_purpose, glb_purpose,'','','','',bdid0,,IncludeNonRegulatedWatercraftSources));
    ds_ucc_child := if(viewUcc(fileL.section), Doxie_Raw.UCC_Legacy_Raw(dids, bdid0, dateVal, dppa_purpose, glb_purpose,ssn_mask_value,,in_party_type));
    ds_ucc_v2_child := if(viewUCCv2(fileL.section), Doxie_Raw.UCCv2_Raw(dids, bdid0, dateVal, dppa_purpose, glb_purpose,,,,,,,,,ssn_mask_value,in_party_type));
    ds_corpAffil_child := if(viewCorpAffil(fileL.section), Doxie_Raw.CorpAffil_Raw(dids, dateVal, dppa_purpose, glb_purpose));
    ds_emerge_child := project(if(viewCcw(fileL.section), Doxie_Raw.Ccw_Raw(dids, dateVal, dppa_purpose, glb_purpose,ssn_mask_value)),  
        transform(Doxie_Raw.Layout_emerge_raw, self := left, self := []))
      + project(if(viewHunt(fileL.section), Doxie_Raw.Hunt_Raw(dids, dateVal, dppa_purpose, glb_purpose,ssn_mask_value)),  
        transform(Doxie_Raw.Layout_emerge_raw, self := left, self := [])) 
      + project(if(viewVoter(fileL.section), Doxie_Raw.Voter_Raw(dids, dateVal, dppa_purpose, glb_purpose,ssn_mask_value)),  
        transform(Doxie_Raw.Layout_emerge_raw, self.did := (unsigned6)left.did, self := left, self := []));	
	  ds_voters_v2_child := if (viewVoterV2 (fileL.section), Doxie_raw.Votersv2_Raw (dids, dateVal, ssn_mask_value));
    ds_pilot_child := if(viewPilot(fileL.section), Doxie_Raw.Pilot_Raw(dids, dateVal, dppa_purpose, glb_purpose,ssn_mask_value));
    ds_pilotCert_child := if(viewPilotCert(fileL.section), Doxie_Raw.Pilot_Cert_Raw(dids, dateVal));
    ds_whoIs_child := if(viewWhoIs(fileL.section), Doxie_Raw.WhoIs_Raw(dids, bdid0, '', dateVal, dppa_purpose, glb_purpose));

    prop_ids := doxie_ln.property_ids (
                  dids, bdid0, dateVal, dppa_purpose, glb_purpose, ln_branded_value, probation_override_value,
                  false, doxie.stored_Use_CurrentlyOwnedProperty_value,,,,,,application_type_value);
    ds_assessor_child := if(viewProperty(fileL.section) or viewAssessment(fileL.section), 
                            sort(Doxie_LN.asses_records(prop_ids, dateVal, ln_branded_value, 200)(current), whole record));
    ds_deed_child := if(viewProperty(fileL.section) or viewDeed(fileL.section),
                        sort(Doxie_LN.deed_records(prop_ids, dateVal, ln_branded_value,200)(current), whole record));
    
    ds_assessor2_child := if(
			viewPropertyV2(fileL.section) or viewAssessmentV2(fileL.section), 
			sort( LN_PropertyV2_Services.Source_records(dids, project(bdid0,LN_PropertyV2_Services.layouts.search_bdid))(fid_type='A'), record)
		);
    ds_deed2_child := if(
			viewPropertyV2(fileL.section) or viewDeedV2(fileL.section),
			sort( LN_PropertyV2_Services.Source_records(dids, project(bdid0,LN_PropertyV2_Services.layouts.search_bdid))(fid_type='D'), record)
		);

    // moving population of phone_child outside the transform to get past codegen FAIL issue
    ds_phone_child := [];
    ds_finder_child := if(viewFinder(fileL.section),doxie_raw.Finder_Raw(dids, dateVal, dppa_purpose, glb_purpose,ssn_mask_value,application_type_value));
    ds_eq_child := if(viewEq(fileL.section),doxie_raw.Eq_Raw(dids, dateVal, dppa_purpose, glb_purpose,ssn_mask_value,application_type_value));
    ds_en_child := if(viewEN(fileL.section),doxie_raw.EN_Raw(dids, dateVal, dppa_purpose, glb_purpose,ssn_mask_value,application_type_value));
    ds_util_child := if(viewUtil(fileL.section),doxie_raw.Util_Raw(project(dids, doxie.layout_references_hh), dateVal, dppa_purpose, glb_purpose, industry_class_value,ssn_mask_value,dl_mask_value,application_type_value));
    ds_ak_child := if(viewAK(fileL.section),doxie_raw.AK_Raw(dids, dateVal, dppa_purpose, glb_purpose,application_type_value));
    ds_mswork_child := if(viewMSWork(fileL.section),doxie_raw.MSWork_Raw(dids, dateVal, dppa_purpose, glb_purpose,ssn_mask_value,application_type_value));
    ds_for_child := if(viewFor(fileL.section),doxie_raw.For_Raw(dids, dateVal, dppa_purpose, glb_purpose,ssn_mask_value,application_type_value));
    ds_nod_child := if(viewNOD(fileL.section),doxie_raw.Nod_Raw(dids, dateVal, dppa_purpose, glb_purpose,ssn_mask_value,application_type_value));
    ds_boater_child := if(viewBoater(fileL.section),doxie_raw.Boater_Raw(dids, dateVal, dppa_purpose, glb_purpose,application_type_value));
    ds_tu_child := if(viewTU(fileL.section),doxie_raw.TU_Raw(dids, dateVal, dppa_purpose, glb_purpose,ssn_mask_value,dl_mask_value,application_type_value));
    ds_tn_child := if(viewTN(fileL.section),doxie_raw.TN_Raw(dids, dateVal, dppa_purpose, glb_purpose,ssn_mask_value,dl_mask_value,application_type_value));
		ds_flcrash_child := if(viewFLCrash(fileL.section),doxie_raw.FLCrash_Raw(dids,dateVal,dppa_purpose,glb_purpose));

		doc_persons := doxie_raw.DOC_People_Raw(dids,,,,,,, dateval, dppa_purpose, glb_purpose,ssn_mask_value,,application_type_value);
		ds_doc_people_child := if(viewDOC(fileL.section),doc_persons);
		ds_doc_events_child := if(viewDOC(fileL.section),doxie_raw.DOC_Events_Raw(doc_persons,true,true,true,true,true,,,,dateVal,dppa_purpose,glb_purpose));
		// same as in doxie@Comprehensive_Report_Service
		tempmod := module(project(global_mod,CriminalRecords_Services.IParam.report,opt))
			export string14 did := input[1].id;	
			export string25   doc_number   := '' ;
			export string60   offender_key := '' ;
			export boolean    IncludeAllCriminalRecords := true;
			export boolean    IncludeSexualOffenses := false;           
		end;
		docr2 := project(CriminalRecords_Services.ReportService_Records.val(tempmod).CriminalRecords, iesp.criminal.t_CrimReportRecord);
		ds_doc_v2_child := if(viewDOCv2 (fileL.section), docr2);

		sexoffender_persons := doxie_raw.SexOffender_People_Raw(dids,,,,false,dateVal,dppa_purpose,glb_purpose,application_type_value, ssn_mask_value);
		ds_sexoffender_people_child := if(viewSexOffender(fileL.section),sexoffender_persons);
		ds_sexoffender_events_child := if(viewSexOffender(fileL.section),doxie_raw.SexOffender_Events_Raw(sexoffender_persons,,dateVal,dppa_purpose,glb_purpose,application_type_value));
	  ds_quickHeader_child := if(viewQuickHeader(fileL.section), doxie_raw.QuickHeader_raw(PROJECT(dids, doxie.layout_references_hh),dateVal,dppa_purpose,glb_purpose,ssn_mask_value));
	  ds_targ_child := if(viewTargus(fileL.section), Doxie_raw.Targus_Raw(dids, dateVal, dppa_purpose, glb_purpose));
		ds_pp_child := if(viewPP(fileL.section), moxie_phonesplus_server.phonesplus_did_records(dids, ut.limits.CRS_SOURCE_COUNT.default, score_threshold_value,glb_purpose,dppa_purpose,,true).wo_timezone);
	  ds_fbn_v2_child := if(viewFBNv2(fileL.section), iesp.transform_FBN(Doxie_Raw.FBNV2_Raw(dids)));
    studentMod:= MODULE(PROJECT(global_mod, American_Student_Services.IParam.searchParams,opt))		
	  	EXPORT unsigned2 penalty_threshold := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val(project(global_mod,AutoStandardI.InterfaceTranslator.penalt_threshold_value.params)); ;
		  EXPORT STRING14  didValue := input[1].id;
	  	EXPORT BOOLEAN 	 isDeepDive := false;
		  EXPORT unsigned1 dob_mask_value := AutoStandardI.InterfaceTranslator.dob_mask_value.val(project(global_mod, AutoStandardI.InterfaceTranslator.dob_mask_value.params));      				
		  EXPORT STRING32  ApplicationType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(global_mod,AutoStandardI.InterfaceTranslator.application_type_val.params));
	  END;
		ds_student := if (viewStudent(fileL.section), American_Student_Services.SearchRecords(studentMod, 3));

	  self.death_child := CHOOSEN (ds_death_child, ut.limits.CRS_SOURCE_COUNT.default);
    self.state_death_child := CHOOSEN (ds_state_death_child, ut.limits.CRS_SOURCE_COUNT.default);
    self.atf_child := CHOOSEN (ds_atf_child, ut.limits.CRS_SOURCE_COUNT.default);
    self.bk_child := CHOOSEN (ds_bk_child, ut.limits.CRS_SOURCE_COUNT.default);
		self.bk_v2_child := CHOOSEN (ds_bk_v2_child, ut.limits.CRS_SOURCE_COUNT.default);
	  self.lien_child := CHOOSEN (ds_lien_child, ut.limits.CRS_SOURCE_COUNT.default);
	  self.lien_v2_child := CHOOSEN (ds_lien_v2_child, ut.limits.CRS_SOURCE_COUNT.default);
	  self.dl_child := CHOOSEN (ds_dl_child, ut.limits.CRS_SOURCE_COUNT.default);
	  self.dl2_child := CHOOSEN (ds_dl2_child, ut.limits.CRS_SOURCE_COUNT.default);
	  self.proflic_child := CHOOSEN (ds_proflic_child, ut.limits.CRS_SOURCE_COUNT.default);
		self.sanc_child := CHOOSEN (ds_sanc_child, ut.limits.CRS_SOURCE_COUNT.default);
		self.prov_child := CHOOSEN (ds_prov_child, ut.limits.CRS_SOURCE_COUNT.default); 
	  self.veh_child := CHOOSEN (ds_veh_child, ut.limits.CRS_SOURCE_COUNT.default);
    self.veh_v2_child := CHOOSEN (ds_veh_v2_child, ut.limits.CRS_SOURCE_COUNT.default);
    self.dea_child := CHOOSEN (ds_dea_child, ut.limits.CRS_SOURCE_COUNT.default);
		self.dea_v2_child := CHOOSEN (ds_dea_v2_child, ut.limits.CRS_SOURCE_COUNT.default);
	  self.airc_child := CHOOSEN (ds_airc_child, ut.limits.CRS_SOURCE_COUNT.default);
    self.watercraft_child := CHOOSEN (ds_watercraft_child, ut.limits.CRS_SOURCE_COUNT.default);
    self.ucc_child := CHOOSEN (ds_ucc_child, ut.limits.CRS_SOURCE_COUNT.default);
    self.ucc_v2_child := CHOOSEN (ds_ucc_v2_child, ut.limits.CRS_SOURCE_COUNT.default);
    self.corpAffil_child := CHOOSEN (ds_corpAffil_child, ut.limits.CRS_SOURCE_COUNT.default);
    self.emerge_child := CHOOSEN (ds_emerge_child, ut.limits.CRS_SOURCE_COUNT.default);
    self.voters_v2_child := CHOOSEN (ds_voters_v2_child, ut.limits.CRS_SOURCE_COUNT.default);
    self.pilot_child := CHOOSEN (ds_pilot_child, ut.limits.CRS_SOURCE_COUNT.default);
    self.pilotCert_child := CHOOSEN (ds_pilotCert_child, ut.limits.CRS_SOURCE_COUNT.default);
    self.whoIs_child := CHOOSEN (ds_whoIs_child, ut.limits.CRS_SOURCE_COUNT.default);
    self.assessor_child := CHOOSEN (ds_assessor_child, ut.limits.CRS_SOURCE_COUNT.default);
    self.deed_child := CHOOSEN (ds_deed_child, ut.limits.CRS_SOURCE_COUNT.default);
    self.assessor2_child := CHOOSEN (ds_assessor2_child, ut.limits.CRS_SOURCE_COUNT.default);
    self.deed2_child := CHOOSEN (ds_deed2_child, ut.limits.CRS_SOURCE_COUNT.default);
    // moving population of phone_child outside the transform to get past codegen FAIL issue
    self.phone_child := [];
    self.finder_child := CHOOSEN (ds_finder_child, ut.limits.CRS_SOURCE_COUNT.default);
    self.eq_child := CHOOSEN (ds_eq_child, ut.limits.CRS_SOURCE_COUNT.default);
    self.en_child := CHOOSEN (ds_en_child, ut.limits.CRS_SOURCE_COUNT.default);
    self.util_child := CHOOSEN (ds_util_child, ut.limits.CRS_SOURCE_COUNT.default);
    self.ak_child := CHOOSEN (ds_ak_child, ut.limits.CRS_SOURCE_COUNT.default);
    self.mswork_child := CHOOSEN (ds_mswork_child, ut.limits.CRS_SOURCE_COUNT.default);
    self.for_child := CHOOSEN (ds_for_child, ut.limits.CRS_SOURCE_COUNT.default);
    self.nod_child := CHOOSEN (ds_nod_child, ut.limits.CRS_SOURCE_COUNT.default);
    self.boater_child := CHOOSEN (ds_boater_child, ut.limits.CRS_SOURCE_COUNT.default);
    self.tu_child := CHOOSEN (ds_tu_child, ut.limits.CRS_SOURCE_COUNT.default);
    self.tn_child := CHOOSEN (ds_tn_child, ut.limits.CRS_SOURCE_COUNT.default);
		self.flcrash_child := CHOOSEN (ds_flcrash_child, ut.limits.CRS_SOURCE_COUNT.default);
		self.doc_people_child := CHOOSEN (ds_doc_people_child, ut.limits.CRS_SOURCE_COUNT.default);
		self.doc_events_child := CHOOSEN (ds_doc_events_child, ut.limits.CRS_SOURCE_COUNT.default);
		self.docv2_child := CHOOSEN (ds_doc_v2_child, ut.limits.CRS_SOURCE_COUNT.default);
		self.sexoffender_people_child := CHOOSEN (ds_sexoffender_people_child, ut.limits.CRS_SOURCE_COUNT.default);
		self.sexoffender_events_child := CHOOSEN (ds_sexoffender_events_child, ut.limits.CRS_SOURCE_COUNT.default);
	  self.quickHeader_child := CHOOSEN (ds_quickHeader_child, ut.limits.CRS_SOURCE_COUNT.default);
	  self.targ_child := CHOOSEN (ds_targ_child, ut.limits.CRS_SOURCE_COUNT.default);
		self.phonesPlus_child := CHOOSEN(ds_pp_child, ut.limits.CRS_SOURCE_COUNT.default);
		self.email_child := CHOOSEN(ds_email_child,ut.limits.CRS_SOURCE_COUNT.default); //this should always be 1 record
    self.FBNv2_child := CHOOSEN (ds_fbn_v2_child, ut.limits.CRS_SOURCE_COUNT.default);
		self.student_child := CHOOSEN(ds_student, ut.limits.CRS_SOURCE_COUNT.default);
		self.busHdr_child := [];
		self.rid := 0;
		self.uid := 0;
		self.src := '';
		self := [];
end;

outFile1 := project(input(idtype = 'DID', section not in ['ssn', 'dob', 'addresses']), getDidChildren(left));

//=============== BY RID ========================================================
//Check for Gong or utility records
is_Gong(string id_in) := stringlib.stringfilterout(id_in,' 0123456789')='PH';
is_Utility(string id_in) := stringlib.stringfilterout(id_in,'0123456789')='UT';
is_QuickHeader(string id_in) := stringlib.stringfilterout(id_in,'0123456789')='QH';


//util records
utils_in := input(is_utility(id));

Doxie_Raw.Layout_crs_raw dailyUtility(utils_in L) := transform
 self.rid := 0;
 self.did := 0;
 self.util_child := project(utilfile.Key_Util_Daily_FDID(fdid=(unsigned6)(trim(l.id[stringlib.stringfind(l.id,'UT',1)+2..]))),
														TRANSFORM(utilfile.layout_utility_in, SELF := LEFT));
 self := [];
end;

util_out := project(utils_in,dailyUtility(left));

//gong records

input_dids := PROJECT(input(idtype = 'DID',viewPhone(section)), TRANSFORM(doxie.layout_references, SELF.did := (unsigned6)LEFT.id;));
gong_did_recs := PROJECT(doxie_raw.Phone_Raw(input_dids), TRANSFORM(Doxie_Raw.Layout_crs_raw, SELF.did := 0; SELF.rid := 0; 
																				           SELF.phone_child := LEFT; SELF := []));;

gong_in := input(is_gong(id));

did_from_gong_rid(string id_in) := (unsigned) id_in[1..stringlib.stringfind(id_in,'PH',1)-1];
phone_from_gong_rid(string id_in) := trim(id_in[stringlib.stringfind(id_in,'PH',1)+2..]);

doxie.layout_references getD(gong_in le) := TRANSFORM
	self.did := did_from_gong_rid(le.id);
end;

dids_from_rids := project(gong_in, getD(left));
gong_raw_recs := doxie_raw.Phone_Raw(dids_from_rids);

// bug 26751 -- only require phone match
gong_rid_recs := join(gong_raw_recs, gong_in, left.phone10 = phone_from_gong_rid(right.id), 
																			   TRANSFORM(Doxie_Raw.Layout_crs_raw, SELF.did := 0; SELF.rid := 0; 
																				           SELF.phone_child := LEFT; SELF := []));
gong_out := gong_did_recs + gong_rid_recs;

//QuickHeader records
QuickHeader_in := input(is_QuickHeader(id));

Doxie_Raw.Layout_crs_raw QuickHeader(QuickHeader_in L) := transform
	id := l.id;
	qhpos := stringlib.stringfind(id,'QH',1);
	lRID := trim(id[qhpos+2..]);
	lDID := trim(id[1..qhpos-1]);
	iRID := (unsigned6)lRID;
	iDID := (unsigned6)lDID;
	isfake := autokeyb.isFakeID(iDID, 'HEAD');

 self.rid := 0;
 self.did := 0;
 
	w_weekly(string2 src) := if(doxie.DataRestriction.WH,~mdr.sourceTools.sourceisWeeklyHeader(src),TRUE);
	
 self.QuickHeader_child := 
	 if(isfake,
		project(header_quick.key_AutokeyPayload(fakeid = iDID and rid = iRID and w_weekly(src) ), header_quick.layout_records),
		project(header_quick.key_DID(DID = iDID and rid = iRID and w_weekly(src) ), header_quick.layout_records));
 self := [];
end;

QuickHeader_out := project(QuickHeader_in,QuickHeader(left));

Doxie.layout_ref_rid toRid(Doxie_Raw.Layout_input fileL) := Transform
    self.did := 0;
    //138824: Deciphering QH RID doctoring & sending in the right RIDs.
		qh_pos := stringlib.StringFind (fileL.id, 'QH', 1);
    self.rid :=  if( qh_pos > 0 , (unsigned6)fileL.id[qh_pos+2..],(unsigned6)fileL.id );
End;
rids := project(input(idtype = 'RID' and ~is_Gong(id) and ~is_utility(id) ), toRid(left));

outRid := Doxie_Raw.ViewSourceRid(rids, dateVal, dppa_purpose, glb_purpose, ssn_mask_value, dl_mask_value,,
																	BankruptcyVersion,JudgmentLienVersion,DlVersion,VehicleVersion,
																	VoterVersion,DeaVersion,application_type_value,
																	IncludeNonRegulatedVehicleSources,IncludeNonRegulatedWatercraftSources);

//===================== addresses, ssn, dob are from Rid too. =====================


return outFile1 + ds_address + ds_SSN + ds_dob + outRid + util_out + gong_out + QuickHeader_out;

END;