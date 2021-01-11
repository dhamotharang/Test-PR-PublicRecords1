import Location_Services;
import dx_header, property, Doxie, Doxie_Raw, Doxie_LN, doxie_cbrs,
     LN_PropertyV2, LN_PropertyV2_Services, iesp, MDR, BIPV2, Suppress;

export location_sources(DATASET(doxie_raw.Layout_input) addr_in,
                Doxie.IDataAccess mod_access,
                BOOLEAN useBusinessIds = FALSE) :=  FUNCTION

doxie.MAC_Header_Field_Declare();


SET OF string20 s := SET(addr_in,section);

boolean viewAll := '' IN s;

boolean viewAtf := 'atf' IN s or viewAll;
boolean viewBK := BankruptcyVersion in [0,1] and ('bk' IN s or viewAll);
boolean viewBKv2 := BankruptcyVersion in [0,2] and ('bk_v2' IN s or viewAll);
boolean viewLien := JudgmentLienVersion in [0,1] and ('lien' IN s or viewAll);
boolean viewLienv2 := JudgmentLienVersion in [0,2] and ('lien_v2' IN s or viewAll);
boolean viewDL := DLVersion in [0,1] and ('dl' IN s or viewAll);
boolean viewDL2 := DLVersion in [0,2] and ('dl_v2' IN s or viewAll);
boolean viewEmerge := 'emerge' IN s or viewAll;
boolean viewDeath := 'death' IN s or viewAll;
boolean viewProfLic := 'proflic' IN s or viewAll;
boolean viewSanc := 'sanc' IN s or viewAll;
boolean viewProv := 'prov' IN s or viewAll;
boolean viewVeh := VehicleVersion in [0,1] and ('veh' IN s or viewAll);
boolean viewVehV2 := VehicleVersion in [0,2] and ('veh_v2' IN s or viewAll);
boolean viewDea   := DeaVersion in [0,1] and ('dea' IN s or viewAll);
boolean viewDeav2 := DeaVersion in [0,2] and ('dea_v2' IN s or viewAll);
boolean viewAirCraft := 'airc' IN s or viewAll;
boolean viewWatercraft := 'watercraft' IN s or viewAll;
boolean viewVoter := VoterVersion in [0,1] and ('voter' IN s or viewAll);
boolean viewVoterV2 := VoterVersion in [0,2] and ('voter_v2' IN s or viewAll);
boolean viewCcw := 'ccw' IN s or viewAll;
boolean viewHunt := 'hunt' IN s or viewAll;
boolean viewPilot := 'pilot' IN s or viewAll;
boolean viewPilotCert := 'pilotcert' IN s or viewAll;
boolean viewPhone := 'phone' IN s or viewAll;
boolean viewWhoIs := 'whois' IN s or viewAll;
boolean viewUCC := UCCVersion in [0,1] and ('ucc' IN s or viewAll);
boolean viewUCCV2 := UCCVersion in [0,2] and ('ucc_v2' IN s or viewAll);
boolean viewCorpAffil := 'corpaffil' IN s or viewAll;
boolean viewProperty := 'property' IN s or viewAll;
boolean viewAssessment := 'assessment' IN s or viewAll;
boolean viewAssessmentV2 := 'assessment_v2' IN s or viewAll;
boolean viewDeed := 'deed' IN s or viewAll;
boolean viewDeedV2 := 'deed_v2' IN s or viewAll;
boolean viewFinder := 'finder' IN s or viewAll;
boolean viewEQ := 'eq' IN s or viewAll;
boolean viewEN := ('en' IN s or viewAll) and not doxie.DataRestriction.ECH;
boolean viewUtil := 'util' IN s or viewAll;
boolean viewAK := 'ak' IN s or viewAll;
boolean viewMSWork := 'mswork' IN s or viewAll;
boolean viewFor := 'for' IN s or viewAll;
boolean viewNOD := 'nod' IN s or viewAll;
boolean viewBoater := 'boater' IN s or viewAll;
boolean viewTU := 'tu' IN s or viewAll;
boolean viewTN := 'tn' IN s or viewAll;
boolean viewBusHeader := 'busheader' IN s or viewAll;
boolean viewTarg := 'targ' IN s or viewAll;
boolean viewFBNv2 := 'fbnv2' IN s or viewAll;

doxie_raw.Layout_address_input getAddr(doxie_raw.Layout_input L) := TRANSFORM
  SELF := L;
END;
addr := PROJECT(addr_in, getAddr(LEFT));

addrDidsWithInputs := getDids(addr,application_type_value);

headerRecs := header_records(addrDidsWithInputs, mod_access);

headerSrcs := header_sources(headerRecs);

// bus data
bus_hdr_raw := recordof(doxie_cbrs.header_records_raw);

bus_mod := GetByBDID(addr, mod_access);
bus_hdr_county := bus_mod.GetCountyRecs();

bus_hdr_link_ids := GetByBusinessIds(addr, mod_access).GetSourceRecs();

bus_prop := IF(useBusinessIds, GetByBusinessIds(addr, mod_access).GetPropFids(), bus_mod.GetPropFids());

deed_out := Location_Services.deed_records(addr,bus_prop);
asset_out := Location_Services.asses_records(addr,bus_prop);

kfs := LN_PropertyV2.key_search_fid();
kh := dx_header.key_header();

rec := RECORD
  kfs.ln_fares_id;
  UNSIGNED6 did := 0;
  QSTRING9 ssn := '';
  UNSIGNED4 global_sid := 0;
  UNSIGNED8 record_sid := 0;
END;

// exclude sensitive DIDs/SSNs from the result
fids := dedup(sort(PROJECT(deed_out, rec) + PROJECT(asset_out, rec), ln_fares_id), ln_fares_id);
fids_dids := join(fids, kfs, keyed(left.ln_fares_id = right.ln_fares_id), TRANSFORM(rec, SELF := RIGHT)) (did<>0);
fids_dids_ssns0 := join(fids_dids, kh, keyed(left.did = right.s_did) and
  (~doxie.DataRestriction.ECH or ~MDR.sourceTools.SourceIsExperian_Credit_Header(right.src)),
  TRANSFORM({rec, unsigned rid}, SELF.ssn := RIGHT.ssn, SELF.rid := RIGHT.rid, SELF.global_sid := RIGHT.global_sid, SELF.record_sid := RIGHT.record_sid, SELF := LEFT));
fids_dids_source_filt := Suppress.MAC_SuppressSource(fids_dids_ssns0,mod_access);
fids_dids_ssns_filt := join(fids_dids_source_filt, dx_header.key_DMV_restricted(), keyed(left.rid = right.rid) and left.did = right.did and right.ssn = '', transform(left), left only);
fids_dids_ssns := project(if(mod_access.suppress_dmv, fids_dids_ssns_filt), rec);
Suppress.MAC_Suppress(fids_dids,good_fids_did,application_type_value,Suppress.Constants.LinkTypes.DID,did);
Suppress.MAC_Suppress(fids_dids_ssns,good_fids_ssn,application_type_value,Suppress.Constants.LinkTypes.SSN,ssn);

good_fids := dedup(sort(good_fids_did + good_fids_ssn, ln_fares_id),ln_fares_id);

deeds_clean := join(deed_out, good_fids, left.ln_fares_id = right.ln_fares_id, TRANSFORM(doxie_ln.layout_deed_records, SELF := LEFT), local);
assets_clean := join(asset_out, good_fids, left.ln_fares_id = right.ln_fares_id, TRANSFORM(doxie_ln.layout_assessor_records, SELF := LEFT), local);

deeds := sort(deeds_clean, ln_fares_id);
assets := sort(assets_clean, ln_fares_id);

propv2_fids := project(deeds, LN_PropertyV2_Services.layouts.search_fid) + project(assets, LN_PropertyV2_Services.layouts.search_fid);
prop2 := LN_PropertyV2_Services.fn_get_report( propv2_fids );
deeds2 := prop2(fid_type='D');
assets2 := prop2(fid_type='A');

l_assess_widest := LN_PropertyV2_Services.layouts.assess.result.widest;
l_deeds_widest  := LN_PropertyV2_Services.layouts.deeds.result.widest2;
l_party         := LN_PropertyV2_Services.layouts.parties.pparty;
l_tmp           := LN_PropertyV2_Services.layouts.combined.tmp;
l_propv2        := LN_PropertyV2_Services.layouts.out_widest;
l_propv2 toPropV2(l_tmp L) := transform
  self.isDeepDive := false;
  self.assessments  := project( L.assessments,  l_assess_widest );
  self.deeds        := project( L.deeds,        l_deeds_widest );
  self.parties      := project( L.parties,      l_party );
  self := L;
end;

Doxie_raw.layout_crs_raw fixSrcs(Doxie_raw.layout_crs_raw L) := transform
  //// test each section and fill in datasets accordingly (or force empty)
  SELF.atf_child := if(viewAtf, L.atf_child);
  SELF.bk_child := if (viewBK, L.bk_child);
  SELF.bk_V2_child := if (viewBKV2, L.bk_V2_child);
  SELF.lien_child := if(viewLien, L.lien_child);
  SELF.lien_V2_child := if(viewLienV2, L.lien_V2_child);
  SELF.dl_child := if(viewDL, L.dl_child);
  SELF.dl2_child := if(viewDL2, L.dl2_child);
  SELF.emerge_child := if(viewEmerge, L.emerge_child);
  SELF.voters_v2_child := if(viewVoterV2, L.voters_v2_child);
  SELF.death_child := if(viewDeath, L.death_child);
  SELF.proflic_child := if(viewProfLic, L.proflic_child);
  SELF.sanc_child := if(viewSanc, L.sanc_child);
  SELF.prov_child := if(viewProv, L.prov_child);
  SELF.veh_child := if(viewVeh,L.veh_child);
  SELF.veh_v2_child := if(viewVehV2,L.veh_v2_child);
  SELF.dea_child := if(viewDea,L.dea_child);
  SELF.dea_v2_child := if(viewDeaV2,L.dea_v2_child);
  SELF.airc_child := if(viewAirCraft,L.airc_child);
  SELF.pilot_child := if(viewPilot,L.pilot_child);
  SELF.pilotCert_child := if(viewPilotCert,L.pilotCert_child);
  SELF.watercraft_child := if(viewWatercraft,L.watercraft_child);
  SELF.ucc_child := if(viewUCC,L.ucc_child);
  SELF.ucc_v2_child := if(viewUCCV2,L.ucc_v2_child);
  SELF.corpAffil_child := if(viewCorpAffil,L.corpAffil_child);
  SELF.whoIs_child := if(viewWhoIs,L.whoIs_child);
  SELF.phone_child := if(viewPhone,L.phone_child);
  // deeds and assessments get filled in later
  SELF.deed_child := dataset([],doxie_ln.layout_deed_records);
  SELF.deed2_child := dataset([],LN_PropertyV2_Services.layouts.out_widest);
  SELF.assessor_child := dataset([],Doxie_LN.layout_assessor_records);
  SELF.assessor2_child := dataset([],LN_PropertyV2_Services.layouts.out_widest);
  SELF.ak_child := if(viewAK,L.ak_child);
  SELF.mswork_child := if(viewMSWork,L.mswork_child);
  SELF.util_child := if(viewUtil,L.util_child);
  SELF.eq_child := if(viewEQ,L.eq_child);
  SELF.eN_child := if(viewEN,L.en_child);
  SELF.for_child := if(viewFor,L.for_child);
  SELF.nod_child := if(viewNOD,L.nod_child);
  SELF.boater_child := if(viewBoater,L.boater_child);
  SELF.tu_child := if(viewTU,L.tu_child);
  SELF.tn_child := if(viewTN,L.tn_child);
  SELF.finder_child := if(viewFinder,L.finder_child);
  // bus srcs get filled in later
  SELF.BusHdr_child := dataset([],bus_hdr_raw);
  SELF.BusHdrLinkIds_child := dataset([], BIPV2.Key_BH_Linking_Ids.kfetchoutrec);
  SELF.targ_child := if(viewTarg,L.targ_child);
  SELF.fbnv2_child := if(viewFBNv2,L.fbnv2_child);
  SELF := L;
END;

Doxie_raw.Layout_crs_raw deed_as_source(deeds le) :=
TRANSFORM
  SELF.deed_child := DATASET(PROJECT(le,
                             TRANSFORM(doxie_ln.layout_deed_records, SELF := LEFT)));
  SELF := [];
END;

Doxie_raw.Layout_crs_raw deed2_as_source(deeds2 le) :=
TRANSFORM
  SELF.deed2_child := DATASET(PROJECT(le, toPropV2(left)));
  SELF := [];
END;

Doxie_raw.Layout_crs_raw assess_as_source(assets le) :=
TRANSFORM
  SELF.assessor_child := DATASET(PROJECT(le,
                             TRANSFORM(doxie_ln.layout_assessor_records, SELF := LEFT)));
  SELF := [];
END;

Doxie_raw.Layout_crs_raw assess2_as_source(assets2 le) :=
TRANSFORM
  SELF.assessor2_child := DATASET(PROJECT(le, toPropV2(left)));
  SELF := [];
END;

Doxie_raw.Layout_crs_raw busHdr_as_source(bus_hdr_county le) :=
TRANSFORM
  SELF.BusHdr_child := DATASET(PROJECT(le,TRANSFORM(bus_hdr_raw, SELF := LEFT)));
  SELF := [];
END;

recordof(BIPV2.Key_BH_Linking_Ids.kfetchoutrec) xFormCompName(recordof(BIPV2.Key_BH_Linking_Ids.kfetchoutrec) le) := TRANSFORM
      SELF := le;

END;

Doxie_raw.Layout_crs_raw bus_hdr_link_ids_as_source(bus_hdr_link_ids le) := TRANSFORM

  SELF.BusHdrLinkIds_child := DATASET(PROJECT(le,
                                TRANSFORM(recordof(BIPV2.Key_BH_Linking_Ids.kfetchoutrec),
                                                    SELF := LEFT)));
  SELF := [];
END;

allSources := PROJECT(headerSrcs, fixSrcs(LEFT))+
              if(viewAssessment, PROJECT(assets, assess_as_source(LEFT))) +
              if(viewAssessmentV2, PROJECT(assets2, assess2_as_source(LEFT))) +
              if(viewDeed, PROJECT(deeds, deed_as_source(LEFT))) +
              if(viewDeedV2, PROJECT(deeds2, deed2_as_source(LEFT))) +
              if(viewBusHeader AND ~useBusinessIds, PROJECT(bus_hdr_county, busHdr_as_source(LEFT))) +
              if(viewBusHeader AND useBusinessIds, PROJECT(bus_hdr_link_ids, bus_hdr_link_ids_as_source(LEFT)));

outRec := Doxie_Raw.Layout_crs_raw;
outRec combineChildResults(outRec L, outRec R) := transform
  self.did := L.did;
  self.atf_child := (L.atf_child + R.atf_child);
  self.bk_child := (L.bk_child + R.bk_child);
  self.bk_V2_child := (L.bk_v2_child + R.bk_v2_child);
  self.lien_child := (L.lien_child + R.lien_child);
  self.lien_V2_child := (L.lien_V2_child + R.lien_V2_child);
  self.dl_child := (L.dl_child + R.dl_child);
  self.dl2_child := (L.dl2_child + R.dl2_child);
  self.emerge_child := (L.emerge_child + R.emerge_child);
  self.voters_v2_child := (L.voters_v2_child + R.voters_v2_child);
  self.death_child := (L.death_child + R.death_child);
  self.proflic_child := (L.proflic_child + R.proflic_child);
  self.sanc_child := (L.sanc_child + R.sanc_child);
  self.prov_child := (L.prov_child + R.prov_child);
  self.veh_child := (L.veh_child + R.veh_child);
  self.veh_v2_child := (L.veh_v2_child + R.veh_v2_child);
  self.dea_child := (L.dea_child + R.dea_child);
  self.dea_v2_child := (L.dea_v2_child + R.dea_v2_child);
  self.airc_child := (L.airc_child + R.airc_child);
  self.pilot_child := (L.pilot_child + R.pilot_child);
  self.pilotCert_child := (L.pilotCert_child + R.pilotCert_child);
  self.watercraft_child := (L.watercraft_child + R.watercraft_child);
  self.ucc_child := (L.ucc_child + R.ucc_child);
  self.ucc_v2_child := (L.ucc_v2_child + R.ucc_v2_child);
  self.corpAffil_child := (L.corpAffil_child + R.corpAffil_child);
  self.whoIs_child := (L.whoIs_child + R.whoIs_child);
  self.deed_child := (L.deed_child + R.deed_child);
  self.deed2_child := (L.deed2_child + R.deed2_child);
  self.assessor_child := (L.assessor_child + R.assessor_child);
  self.assessor2_child := (L.assessor2_child + R.assessor2_child);
  self.ak_child := (L.ak_child + R.ak_child);
  self.mswork_child := (L.mswork_child + R.mswork_child);
  self.util_child := (L.util_child + R.util_child);
  self.eq_child := (L.eq_child + R.eq_child);
  self.en_child := (L.en_child + R.en_child);
  self.for_child := (L.for_child + R.for_child);
  self.nod_child := (L.nod_child + R.nod_child);
  self.boater_child := (L.boater_child + R.boater_child);
  self.tu_child := (L.tu_child + R.tu_child);
  self.tn_child := (L.tn_child + R.tn_child);
  self.finder_child := (L.finder_child + R.finder_child);
  self.phone_child := (L.phone_child + R.phone_child);
  self.busHdr_child := (L.busHdr_child + R.busHdr_child);
  self.busHdrLinkIds_child := (L.busHdrLinkIds_child + R.busHdrLinkIds_child);
  self.targ_child := (L.targ_child + R.targ_child);
  self.fbnv2_child := (L.fbnv2_child + R.fbnv2_child);
  self := [];
end;

outSectAll := rollup(allSources, true, combineChildResults(LEFT, RIGHT));

outRec ddp_Sections(outRec L) :=
TRANSFORM
  self.did := L.did;
  self.atf_child := dedup(SORT(L.atf_child, RECORD), record);
  self.bk_child := dedup(SORT(L.bk_child, RECORD), record);
  self.bk_v2_child := dedup(SORT(L.bk_v2_child, RECORD), record);
  self.lien_child := dedup(SORT(L.lien_child, RECORD), record);
  self.lien_V2_child := dedup(SORT(L.lien_V2_child, RECORD), record);
  self.dl_child := dedup(SORT(L.dl_child , RECORD), record);
  self.dl2_child := dedup(SORT(L.dl2_child , RECORD), record);
  self.emerge_child := dedup(SORT(L.emerge_child, RECORD), record);
  self.voters_v2_child := dedup(SORT(L.voters_v2_child, RECORD), record);
  self.death_child := dedup(SORT(L.death_child, RECORD), record);
  self.proflic_child := dedup(SORT(L.proflic_child, RECORD), record);
  self.sanc_child := dedup(SORT(L.sanc_child, RECORD), record);
  self.prov_child := dedup(SORT(L.prov_child, RECORD), record);
  self.veh_child := dedup(SORT(L.veh_child, RECORD), record);
  self.veh_v2_child := dedup(SORT(L.veh_v2_child, RECORD), record);
  self.dea_child := dedup(SORT(L.dea_child, RECORD), record);
  self.dea_v2_child := dedup(SORT(L.dea_v2_child, RECORD), record);
  self.airc_child := dedup(SORT(L.airc_child, RECORD), record);
  self.pilot_child := dedup(SORT(L.pilot_child, RECORD), record);
  self.pilotCert_child := dedup(SORT(L.pilotCert_child, RECORD), record);
  self.watercraft_child := dedup(SORT(L.watercraft_child, RECORD), record);
  self.ucc_child := dedup(SORT(L.ucc_child, RECORD), record);
  self.ucc_v2_child := dedup(SORT(L.ucc_v2_child, RECORD), record);
  self.corpAffil_child := dedup(SORT(L.corpAffil_child, RECORD), record);
  self.whoIs_child := dedup(SORT(L.whoIs_child, RECORD), record);
  self.deed_child := dedup(SORT(if(doxie.DataRestriction.Fares,L.deed_child(ln_fares_id[1] <>'R'),L.deed_child), RECORD), record);
  self.deed2_child := dedup(SORT(if(doxie.DataRestriction.Fares,L.deed2_child(ln_fares_id[1] <>'R'),L.deed2_child), RECORD), record);
  self.assessor_child := dedup(SORT(if(doxie.DataRestriction.Fares,L.assessor_child(ln_fares_id[1] <>'R'),L.assessor_child), RECORD), record);
  self.assessor2_child := dedup(SORT(if(doxie.DataRestriction.Fares,L.assessor2_child(ln_fares_id[1] <>'R'),L.assessor2_child), RECORD), record);
  self.ak_child := dedup(SORT(L.ak_child, RECORD), record);
  self.mswork_child := dedup(SORT(L.mswork_child, RECORD), record);
  self.util_child := dedup(SORT(L.util_child, RECORD), record);
  self.eq_child := dedup(SORT(L.eq_child, RECORD), record);
  self.en_child := dedup(SORT(L.en_child, RECORD), record);
  self.for_child := dedup(SORT(if(doxie.DataRestriction.Fares,dataset([],Property.Layout_Fares_Foreclosure_Ex_Sids), L.for_child), RECORD), record);
  self.nod_child := dedup(SORT(if(doxie.DataRestriction.Fares,dataset([],iesp.foreclosure.t_ForeclosureReportRecord), L.nod_child), RECORD), record);
  self.boater_child := dedup(SORT(L.boater_child, RECORD), record);
  self.tu_child := dedup(SORT(L.tu_child, RECORD), record);
  self.tn_child := dedup(SORT(L.tn_child, RECORD), record);
  self.finder_child := dedup(SORT(L.finder_child, RECORD), record);
  self.phone_child := dedup(SORT(L.phone_child, RECORD), record);
  self.busHdr_child := dedup(SORT(L.busHdr_child, RECORD), record);
  self.busHdrLinkIds_child := dedup(SORT(L.busHdrLinkIds_child, RECORD), record);
  self.targ_child := dedup(SORT(L.targ_child, RECORD), record);
  self.fbnv2_child := dedup(SORT(L.fbnv2_child, RECORD), record);
  self := [];
END;

Sections_ddpd := PROJECT(outSectAll, ddp_Sections(LEFT));

RETURN Sections_ddpd;

END;
