﻿import Doxie, Doxie_Raw, doxie_ln, utilfile, header_quick, autokeyb, ut, moxie_phonesplus_server,
       LN_PropertyV2_Services, mdr, iesp, AutoStandardI, CriminalRecords_Services, American_Student_Services, Suppress;

doxie.MAC_Header_Field_Declare();
doxie.MAC_Selection_Declare ();

export ViewSourceDid(
    dataset(Doxie_Raw.Layout_input) input,
    doxie.IDataAccess modAccess,
    boolean IsCRS = false,
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
mod_access := PROJECT (modAccess, doxie.IDataAccess); //Code Generator sometimes doesn't recongize the "type" of an input module

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
did0 := Doxie_Raw.ds_EmptyDIDs;
bdid0 := Doxie_Raw.ds_EmptyBDIDs;
tmsid0 := Doxie_Raw.ds_EmptyTMSIDs;

//============================= rid children ========================
//address, ssn and dob section
ds_address := IF(EXISTS(input(idtype = 'DID',viewCompAddress(section))),
                 Doxie_Raw.CompAddress_Raw(input(idtype = 'DID',viewCompAddress(section)), mod_access));
ds_ssn := IF(EXISTS(input(idtype = 'DID', viewSSN(section))),
             Doxie_Raw.SSN_Raw(input(idtype = 'DID',viewSSN(section)), mod_access));
ds_dob := IF(EXISTS(input(idtype = 'DID', viewDob(section))),
             Doxie_Raw.Dob_Raw(input(idtype = 'DID',viewDob(section)), mod_access));

//============================= did children ====================================
Doxie_Raw.layout_crs_raw getDidChildren(Doxie_Raw.Layout_input fileL) := transform
    unsigned6 did := (unsigned6)fileL.id;
    SELF.did := did;
    dids := dataset([{did}],Doxie.layout_references);
    ds_email_child := if(viewEmail(fileL.section), Doxie.email_records(dids,mod_access.ssn_mask,mod_access.application_type));
    ds_death_child := if(viewDeath(fileL.section),Doxie_Raw.death_raw(dids, , mod_access.date_threshold, mod_access.dppa, mod_access.glb,mod_access.ssn_mask)(IncludeBlankDOD or (integer)DOD8 > 0 ));
    ds_state_death_child := if(viewStateDeath(fileL.section),Doxie_Raw.state_death_raw(dids, mod_access.date_threshold, mod_access.dppa, mod_access.glb,mod_access.ssn_mask));
    ds_atf_child := if(viewAtf(fileL.section), Doxie_Raw.atf_raw(dids, mod_access.date_threshold, mod_access.dppa, mod_access.glb,mod_access.ssn_mask));
    ds_bk_child := if(viewBK(fileL.section),Doxie_Raw.bk_raw(dids, bdid0, , , mod_access.date_threshold, mod_access.dppa, mod_access.glb, mod_access.ssn_mask, in_party_type));
    ds_bk_v2_child := if(viewBKV2(fileL.section),Doxie_Raw.bkV2_raw(dids, bdid0, , mod_access.date_threshold, mod_access.ssn_mask, in_party_type));
    ds_lien_child := if(viewLien(fileL.section), Doxie_Raw.Lien_Raw(dids, bdid0, mod_access.date_threshold, mod_access.dppa, mod_access.glb,,,,,,,,,mod_access.ssn_mask,in_party_type));
    ds_lien_v2_child := if(viewLienV2(fileL.section), Doxie_Raw.Liensv2_Raw(dids, bdid0, tmsid0, mod_access.date_threshold, mod_access.dppa, mod_access.glb,,,,,,,,mod_access.ssn_mask,in_party_type,mod_access.application_type));
    ds_dl_child := if(viewDl(fileL.section), Doxie_Raw.DL_Raw(dids, mod_access.date_threshold, mod_access.dppa, mod_access.glb, mod_access.ln_branded,,,,,,,,,,,mod_access.ssn_mask,dl_mask_value));
    ds_dl2_child := if(viewDl2(fileL.section), Doxie_Raw.DLV2_Raw(dids, , ,mod_access.dppa, mod_access.ssn_mask));
    ds_proflic_child := if(viewProfLic(fileL.section), Doxie_Raw.PL_Raw(dids, mod_access, ''));
    ds_sanc_child := if(viewSanc(fileL.section),Doxie_Raw.Sanc_Raw(dids,,mod_access.date_threshold));
    ds_prov_child := if(viewProv(fileL.section),Doxie_Raw.Prov_Raw(dids));
    ds_veh_child := if(viewVeh(fileL.section), Doxie_Raw.Veh_Raw(dids, , , , , , , mod_access.date_threshold, mod_access.dppa, mod_access.glb, mod_access.ln_branded,mod_access.ssn_mask,dl_mask_value,,,,mod_access.application_type,IncludeNonRegulatedVehicleSources));
    ds_veh_v2_child := if(viewVehV2(fileL.section), Doxie_Raw.VehV2_Raw(dids,,mod_access.ssn_mask,mod_access.date_threshold));
    ds_dea_child := if(viewDea(fileL.section), Doxie_Raw.Dea_Raw(dids, bdid0, mod_access.date_threshold, mod_access.dppa, mod_access.glb, mod_access.ssn_mask));
    ds_dea_v2_child := if(viewDeaV2(fileL.section), Doxie_Raw.DeaV2_Raw(dids, bdid0,, mod_access.dppa, mod_access.glb, mod_access.ssn_mask,mod_access.application_type));
    ds_airc_child := if(viewAircraft(fileL.section), Doxie_Raw.AirCraft_Raw(dids, bdid0, mod_access.date_threshold, mod_access.dppa, mod_access.glb,mod_access.ssn_mask,mod_access.application_type));
    ds_watercraft_child := if(viewWaterCraft(fileL.section), Doxie_Raw.WaterCraft_Raw(dids, mod_access.date_threshold, mod_access.dppa, mod_access.glb,'','','','',bdid0,,IncludeNonRegulatedWatercraftSources));
    ds_ucc_child := if(viewUcc(fileL.section), Doxie_Raw.UCC_Legacy_Raw(dids, bdid0, mod_access.date_threshold, mod_access.dppa, mod_access.glb,mod_access.ssn_mask,,in_party_type));
    ds_ucc_v2_child := if(viewUCCv2(fileL.section), Doxie_Raw.UCCv2_Raw(dids, bdid0, mod_access.date_threshold, mod_access.dppa, mod_access.glb,,,,,,,,,mod_access.ssn_mask,in_party_type));
    ds_corpAffil_child := if(viewCorpAffil(fileL.section), Doxie_Raw.CorpAffil_Raw(dids, mod_access.date_threshold, mod_access.dppa, mod_access.glb));
    ds_emerge_child := project(if(viewCcw(fileL.section), Doxie_Raw.Ccw_Raw(dids, mod_access.date_threshold, mod_access.dppa, mod_access.glb,mod_access.ssn_mask)),
        transform(Doxie_Raw.Layout_emerge_raw, self := left, self := []))
      + project(if(viewHunt(fileL.section), Doxie_Raw.Hunt_Raw(dids, mod_access.date_threshold, mod_access.dppa, mod_access.glb,mod_access.ssn_mask)),
        transform(Doxie_Raw.Layout_emerge_raw, self := left, self := []))
      + project(if(viewVoter(fileL.section), Doxie_Raw.Voter_Raw(dids, mod_access.date_threshold, mod_access.dppa, mod_access.glb,mod_access.ssn_mask)),
        transform(Doxie_Raw.Layout_emerge_raw, self.did := (unsigned6)left.did, self := left, self := []));
    ds_voters_v2_child := if (viewVoterV2 (fileL.section), Doxie_Raw.Votersv2_Raw (dids, mod_access.date_threshold, mod_access.ssn_mask));
    ds_pilot_child := if(viewPilot(fileL.section), Doxie_Raw.Pilot_Raw(dids, mod_access.date_threshold, mod_access.dppa, mod_access.glb,mod_access.ssn_mask));
    ds_pilotCert_child := if(viewPilotCert(fileL.section), Doxie_Raw.Pilot_Cert_Raw(dids, mod_access.date_threshold));
    ds_whoIs_child := if(viewWhoIs(fileL.section), Doxie_Raw.WhoIs_Raw(dids, bdid0, '', mod_access.date_threshold, mod_access.dppa, mod_access.glb));

    prop_ids := doxie_ln.property_ids (
                  dids, bdid0, mod_access.date_threshold, mod_access.dppa, mod_access.glb, mod_access.ln_branded, mod_access.probation_override,
                  false, doxie.stored_Use_CurrentlyOwnedProperty_value,,,,,,mod_access.application_type);
    ds_assessor_child := if(viewProperty(fileL.section) or viewAssessment(fileL.section),
                            sort(Doxie_LN.asses_records(prop_ids, mod_access.date_threshold, mod_access.ln_branded, 200)(current), whole record));
    ds_deed_child := if(viewProperty(fileL.section) or viewDeed(fileL.section),
                        sort(Doxie_LN.deed_records(prop_ids, mod_access.date_threshold, mod_access.ln_branded,200)(current), whole record));

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
    ds_finder_child := if(viewFinder(fileL.section),Doxie_Raw.Finder_Raw(dids, mod_access));
    ds_eq_child := if(viewEq(fileL.section),Doxie_Raw.Eq_Raw(dids, mod_access));
    ds_en_child := if(viewEN(fileL.section),Doxie_Raw.EN_Raw(dids, mod_access));
    ds_util_child := if(viewUtil(fileL.section),Doxie_Raw.Util_Raw(project(dids, doxie.layout_references_hh), mod_access));
    ds_ak_child := if(viewAK(fileL.section),Doxie_Raw.AK_Raw(dids, mod_access));
    ds_mswork_child := if(viewMSWork(fileL.section),Doxie_Raw.MSWork_Raw(dids, mod_access));
    ds_for_child := if(viewFor(fileL.section),Doxie_Raw.For_Raw(dids, mod_access));
    ds_nod_child := if(viewNOD(fileL.section),Doxie_Raw.Nod_Raw(dids, mod_access));
    ds_boater_child := if(viewBoater(fileL.section),Doxie_Raw.Boater_Raw(dids, mod_access));
    ds_tu_child := if(viewTU(fileL.section),Doxie_Raw.TU_Raw(dids, mod_access));
    ds_tn_child := if(viewTN(fileL.section),Doxie_Raw.TN_Raw(dids, mod_access));
    ds_flcrash_child := if(viewFLCrash(fileL.section),Doxie_Raw.FLCrash_Raw(dids,mod_access.date_threshold,mod_access.dppa,mod_access.glb));

    doc_persons := Doxie_Raw.DOC_People_Raw(dids,,,,,,, mod_access.date_threshold, mod_access.dppa, mod_access.glb,mod_access.ssn_mask,,mod_access.application_type);
    ds_doc_people_child := if(viewDOC(fileL.section),doc_persons);
    ds_doc_events_child := if(viewDOC(fileL.section),Doxie_Raw.DOC_Events_Raw(doc_persons,true,true,true,true,true,,,,mod_access.date_threshold,mod_access.dppa,mod_access.glb));
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

    sexoffender_persons := Doxie_Raw.SexOffender_People_Raw(dids,,,,false,mod_access.date_threshold,mod_access.dppa,mod_access.glb,mod_access.application_type, mod_access.ssn_mask);
    ds_sexoffender_people_child := if(viewSexOffender(fileL.section),sexoffender_persons);
    ds_sexoffender_events_child := if(viewSexOffender(fileL.section),Doxie_Raw.SexOffender_Events_Raw(sexoffender_persons,,mod_access.date_threshold,mod_access.dppa,mod_access.glb,mod_access.application_type));
    ds_quickHeader_child := if(viewQuickHeader(fileL.section), Doxie_Raw.QuickHeader_raw(PROJECT(dids, doxie.layout_references_hh),mod_access));
    ds_targ_child := if(viewTargus(fileL.section), Doxie_Raw.Targus_Raw(dids, mod_access.date_threshold, mod_access.dppa, mod_access.glb, mod_access.industry_class));
    ds_pp_child := if(viewPP(fileL.section), moxie_phonesplus_server.phonesplus_did_records(dids, ut.limits.CRS_SOURCE_COUNT.default, score_threshold_value,mod_access.glb,mod_access.dppa,,true).wo_timezone);
    ds_fbn_v2_child := if(viewFBNv2(fileL.section), iesp.transform_FBN(Doxie_Raw.FBNV2_Raw(dids)));
    studentMod:= MODULE(mod_access, global_mod)
      EXPORT string DataPermissionMask := mod_access.DataPermissionMask; //conflicting definition;
      EXPORT string DataRestrictionMask :=  mod_access.DataRestrictionMask; //conflicting definition;

      EXPORT unsigned2 penalty_threshold := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val(project(global_mod,AutoStandardI.InterfaceTranslator.penalt_threshold_value.params)); ;
      EXPORT STRING14  didValue := input[1].id;
      EXPORT BOOLEAN 	 isDeepDive := false;
      EXPORT STRING32  ApplicationType := mod_access.application_type;
    END;
    ds_student := if (viewStudent(fileL.section), American_Student_Services.SearchRecords(PROJECT (studentMod, American_Student_Services.IParam.searchParams, OPT), 3));


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
gong_did_recs := PROJECT(Doxie_Raw.Phone_Raw(input_dids), TRANSFORM(Doxie_Raw.Layout_crs_raw, SELF.did := 0; SELF.rid := 0;
                                                   SELF.phone_child := LEFT; SELF := []));;

gong_in := input(is_gong(id));

did_from_gong_rid(string id_in) := (unsigned) id_in[1..stringlib.stringfind(id_in,'PH',1)-1];
phone_from_gong_rid(string id_in) := trim(id_in[stringlib.stringfind(id_in,'PH',1)+2..]);

doxie.layout_references getD(gong_in le) := TRANSFORM
  self.did := did_from_gong_rid(le.id);
end;

dids_from_rids := project(gong_in, getD(left));
gong_raw_recs := Doxie_Raw.Phone_Raw(dids_from_rids);

// bug 26751 -- only require phone match
gong_rid_recs := join(gong_raw_recs, gong_in, left.phone10 = phone_from_gong_rid(right.id),
                                         TRANSFORM(Doxie_Raw.Layout_crs_raw, SELF.did := 0; SELF.rid := 0;
                                                   SELF.phone_child := LEFT; SELF := []));
gong_out := gong_did_recs + gong_rid_recs;

//QuickHeader records
QuickHeader_in := input(is_QuickHeader(id));

header_quick_temp:= record
    header_quick.layout_records; 
    unsigned4 global_sid;
	unsigned8 record_sid;
end;

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
  
  QH_recs := if(isfake,
    project(header_quick.key_AutokeyPayload(fakeid = iDID and rid = iRID and w_weekly(src)), header_quick_temp),
    project(header_quick.key_DID(DID = iDID and rid = iRID and w_weekly(src) ), header_quick_temp));
 
 self.QuickHeader_child := project(Suppress.MAC_SuppressSource(QH_recs, mod_access), header_quick.layout_records);
  
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

outRid := Doxie_Raw.ViewSourceRid(rids, mod_access,,
                                  BankruptcyVersion,JudgmentLienVersion,DlVersion,VehicleVersion,
                                  VoterVersion,DeaVersion,
                                  IncludeNonRegulatedVehicleSources,IncludeNonRegulatedWatercraftSources);

//===================== addresses, ssn, dob are from Rid too. =====================


return outFile1 + ds_address + ds_SSN + ds_dob + outRid + util_out + gong_out + QuickHeader_out;

END;
