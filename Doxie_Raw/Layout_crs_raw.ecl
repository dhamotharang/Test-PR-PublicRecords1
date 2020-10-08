
import header, ak_perm_fund,atf_services,bankrupt,bankruptcyv2_services,BIPV2,drivers,emerges,govdata,prof_license,
    property,utilfile,vehlic,dea,faa,watercraft, Doxie, Doxie_Raw, Doxie_crs,
    uccd, Gong_Services, Doxie_files, LN_TU, Doxie_LN, doxie_cbrs, moxie_phonesplus_server,
	liensv2_services, header_quick, UCCv2_Services, Votersv2_services, vehiclev2_services, DriversV2_Services,
	LN_PropertyV2_Services,DEAV2_Services,EmailService,FBNV2_services,iesp,ExperianCred, TransunionCred,
	American_Student_Services, EmailV2_Services;

did0 := dataset([], Doxie.layout_references);

export Layout_crs_raw := record, maxlength(doxie_crs.maxlength_report)
  unsigned6 did;
  unsigned6 rid;
  header.layout_Source_ID;
  dataset(atf_services.layouts.firearms_out) atf_child;
  dataset(Doxie.layout_bk_output) bk_child;
	dataset(bankruptcyv2_services.layouts.layout_rollup) bk_V2_child;
  dataset(bankrupt.layout_liens) lien_child;
  dataset(liensv2_services.layout_lien_rollup) lien_V2_child;
  dataset(Doxie.Layout_DlSearch) dl_child;
  dataset(DriversV2_Services.layouts.result_rolled) dl2_child;
  dataset(Doxie_Raw.Layout_emerge_raw) emerge_child;
  dataset(Votersv2_services.layouts.SourceOutput) voters_v2_child; //
  dataset(Doxie_Raw.layout_death_Raw) death_child;
  dataset(Doxie_Raw.layout_state_death_Raw) state_death_child;
  dataset(prof_license.layout_doxie) proflic_child;
	dataset(doxie.ingenix_sanctions_module.layout_ingenix_sanctions_report) sanc_child;
	dataset(doxie.ingenix_provider_module.layout_ingenix_provider_report) prov_child;
	dataset(EmailService.Assorted_Layouts.layout_report_rollup) Email_child;
	dataset(EmailV2_Services.Layouts.crs_email_raw_rec) Email_v2_child;
  dataset(Doxie.Layout_VehicleSearch) veh_child;
  dataset(vehiclev2_services.Layout_Report) veh_v2_child;
  dataset(Doxie_Raw.Layout_Dea_Raw) dea_child;
	dataset(DeaV2_Services.assorted_layouts.Layout_Output) dea_v2_child;
  dataset(Doxie_crs.layout_Faa_Aircraft_records) airc_child;
  dataset(Doxie_crs.layout_pilot_records) pilot_child;
  dataset(Doxie_crs.layout_pilot_cert_records) pilotCert_child;
  dataset(Doxie_crs.layout_watercraft_report) watercraft_child;
  dataset(UCCv2_services.layout_legacy.raw_rec) ucc_child;
  dataset(UCCv2_services.layout_ucc_rollup_src) ucc_v2_child;
  dataset(doxie_crs.layout_corp_affiliations_records) corpAffil_child;
  dataset(Doxie_crs.layout_whois) whoIs_child;
  dataset(Gong_Services.Layout_GongHistorySearchService) phone_child;
  dataset(doxie_ln.layout_deed_records) deed_child;
  dataset(Doxie_LN.layout_assessor_records) assessor_child;
  dataset(LN_PropertyV2_Services.layouts.out_widest)	deed2_child;
  dataset(LN_PropertyV2_Services.layouts.out_widest)	assessor2_child;
  dataset(ak_perm_fund.Layout_AK_Common) ak_child;
  dataset(govdata.layout_ms_workers_comp_in) mswork_child;
  dataset(utilfile.layout_utility_in) util_child;
  dataset(header_quick.layout_records) QuickHeader_child;
  dataset(header.Layout_Eq_src_dates) eq_child; // #138824
  dataset(ExperianCred.Layouts.Layout_SourceDoc) EN_child;
  dataset(Property.Layout_Fares_Foreclosure_Ex_Sids) for_child;
  dataset(iesp.foreclosure.t_ForeclosureReportRecord) nod_child{xpath('NoticesOfDefaults/NoticeOfDefaults')};
  dataset(emerges.Layout_Boats_In) boater_child;
  dataset(LN_TU.Layout_In_Header_All) tu_child;
  dataset(TransunionCred.Layouts.base) tn_child;
  dataset(doxie_raw.layout_header_raw) finder_child;
	dataset(doxie_crs.layout_FLCrash_Search_Records) FLCrash_child;
	dataset(doxie.layout_DOCSearch_Person) DOC_people_child;
	dataset(doxie.Layout_DOCSearch_Events) DOC_events_child;
	dataset(doxie.Layout_SexOffender_SearchPerson) SexOffender_people_child;
	dataset(doxie.layout_sexoffender_searchevents) SexOffender_events_child;
	dataset(recordof(doxie_cbrs.header_records_raw)) BusHdr_child;
	dataset(BIPV2.Key_BH_Linking_Ids.kfetchoutrec) BusHdrLinkIds_child := DATASET([], BIPV2.Key_BH_Linking_Ids.kfetchoutrec);
  dataset(Doxie_Raw.Layout_Targus_Raw) targ_child;
	dataset(moxie_phonesplus_server.Layout_batch_did.wo_timezone) PhonesPlus_child;
	dataset(iesp.fictitiousbusinesssearch.t_FictitiousBusinessSearchRecord) FBNv2_child{xpath('FictitiousBusinesses/FictitiousBusiness')};
	dataset(iesp.criminal.t_CrimReportRecord) DOCv2_child {xpath('CriminalRecords/CriminalRecord')};
	dataset(American_Student_Services.Layouts.full_output) student_child {xpath('StudentRecords/StudentRecord'), MAXCOUNT(iesp.Constants.MaxCountASLSearch)};
end;
