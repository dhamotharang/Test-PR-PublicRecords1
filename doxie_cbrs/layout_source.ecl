IMPORT bankruptcyv2_services, corp2_services, doxie, doxie_cbrs, doxie_crs, ebr_services, 
  irs5500, govdata, LiensV2_Services, LN_PropertyV2_Services, UCCv2_Services, VehicleV2_Services, WatercraftV2_Services;

rechdrr := doxie_cbrs.layout_base_rec; // doxie_cbrs.header_records_raw 
recdnbr := doxie_cbrs.layouts.dnb_record; // doxie_cbrs.dnb_records
reccorr := doxie_cbrs.layouts.corporation_filings_record; // doxie_cbrs.Corporation_Filings_records
reccorr_v2 := corp2_services.layout_corp2_rollup; // doxie_cbrs.Corporation_Filings_records_v2
recbnkr := doxie_cbrs.layouts.bankruptcy_record; // doxie_cbrs.bankruptcy_records
recbnkr_v2 := bankruptcyv2_services.layouts.layout_rollup; // doxie_cbrs.bankruptcy_records_v2.source_view 
recuccr := UCCv2_Services.layout_legacy.raw_level_rec; // doxie_cbrs.UCC_Records -> .. -> UCCv2_services.Legacy.fn_getUCC_legacy_rawLevels

recuccr_v2 := UCCv2_Services.layout_ucc_rollup_src; // doxie_cbrs.UCC_Records_v2.source_view -> .. -> UCCv2_Services.fn_getUCC_rmsid
recljr := doxie_cbrs.Layout_Liens_Judgments_raw; // doxie_cbrs.Liens_Judments_records
recljr_v2 := LiensV2_Services.layout_lien_rollup; // doxie_cbrs.Liens_Judments_records_v2.source_view -> .. -> LiensV2_Services.GetCRSOutput
recconr := doxie_cbrs.layout_contact.standardized_rec; // doxie_cbrs.contact_records_standardized
recpror := doxie_cbrs.layout_property_records;// doxie_cbrs.property_records
recpror_v2_assess := LN_PropertyV2_Services.layouts.out_widest;// doxie_cbrs.property_records_source.assessments -> LN_PropertyV2_Services.Source_records 
recpror_v2_deed := LN_PropertyV2_Services.layouts.out_widest; // doxie_cbrs.property_records_source.deeds -> LN_PropertyV2_Services.Source_records 
recnodr := doxie_cbrs.layouts.foreclosure_record; // doxie_cbrs.foreclosure_records
recforr := recnodr;
recidor := doxie_cbrs.layouts.internet_domains_record; // doxie_cbrs.Internet_Domains_records
recplir := doxie_cbrs.layouts.proflic_record; // doxie_cbrs.proflic_records_dayton
recmvrr := doxie.Layout_VehicleSearch; // doxie_cbrs.motor_vehicle_records_dayton
recmvrr_V2 := VehicleV2_Services.Layout_Report; // doxie_cbrs.motor_vehicle_records_v2.source_view -> .. -> vehiclev2_services.raw.get_vehicle_report
recwtcr := watercraftV2_Services.layouts.report_out; // doxie_cbrs.watercraft_records
recairr := doxie_crs.layout_Faa_Aircraft_records; // doxie_cbrs.aircraft_records
recebrr := ebr_services.Layout_EBR_Report; // doxie_cbrs.experian_business_reports_raw

recirs := irs5500.layout_irs5500_base; // doxie_cbrs.IRS5500_records
recirsn := RECORDOF(govdata.Key_IRS_NonProfit_BDID); // doxie_cbrs.IRSNonP_records
recfdicr := RECORDOF(govdata.key_fdic_bdid); // doxie_cbrs.FDIC_member_records
recbbbmemberr:= doxie_cbrs.layouts.bbb_member_record; // doxie_cbrs.BBBMember_member_records
recbbbnonmemberr := doxie_cbrs.layouts.bbb_nonmember_record; // doxie_cbrs.BBBNonMember_member_records
reccasalestaxr := RECORDOF(govdata.key_ca_sales_tax_bdid); // doxie_cbrs.CASalesTax_member_records
reciasalestaxr := RECORDOF(govdata.Key_IA_SalesTax_BDID); // doxie_cbrs.IASalesTax_member_records;
recmsworkcompr := RECORDOF(govdata.key_ms_workers_comp_BDID); // doxie_cbrs.MSWorkComp_member_records
recorworkcompr := RECORDOF(govdata.key_or_workers_comp_bdid); // doxie_cbrs.ORWorkComp_member_records
recsrcr := $.layout_source_counts;

EXPORT layout_source := RECORD, MAXLENGTH(doxie_crs.maxlength_report) // doxie_cbrs.all_base_records_source
  DATASET(rechdrr) FINDER;
  DATASET(recdnbr) DNB;
  DATASET(reccorr) CORPORATE_FILINGS;
  DATASET(reccorr_v2) CORPORATE_FILINGS_V2;
  DATASET(recbnkr) BANKRUPTCY;
  DATASET(recbnkr_v2) BANKRUPTCY_V2;
  DATASET(recuccr) UCCS;
  DATASET(recuccr_v2) UCCS_V2;
  DATASET(recljr) LIENS_JUDGMENTS;
  DATASET(recljr_v2) LIENS_JUDGMENTS_V2;
  DATASET(recconr) CONTACTS;
  DATASET(recpror) PROPERTY;
  DATASET(recpror_v2_assess) PROPERTY_V2_ASSESS;
  DATASET(recpror_v2_deed) PROPERTY_V2_DEED;
  DATASET(recnodr) NOTICE_OF_DEFAULTS{xpath('NoticesOfDefaults/NoticeOfDefaults')};
  DATASET(recforr) FORECLOSURES{xpath('ForeclosureDocuments/ForeclosureDocument')};
  DATASET(recidor) INTERNET;
  DATASET(recplir) PROFESSIONAL_LICENSES;
  DATASET(recmvrr) MOTOR_VEHICLES;
  DATASET(recmvrr_V2) MOTOR_VEHICLES_V2;
  DATASET(recwtcr) WATERCRAFTS;
  DATASET(recairr) AIRCRAFTS;
  DATASET(recebrr) EXPERIAN_BUSINESS_REPORTS;
  DATASET(recirs) IRS_5500;
  DATASET(recirsn) IRS_NON_PROFIT;
  DATASET(recfdicr) FDIC;
  DATASET(recbbbmemberr) BBBMember;
  DATASET(recbbbnonmemberr) BBBNonMember;
  DATASET(reccasalestaxr) CASalesTax;
  DATASET(reciasalestaxr) IASalesTax;
  DATASET(recmsworkcompr) MSWorkComp;
  DATASET(recorworkcompr) ORWorkComp;
  // DATASET(recbasr) BUSINESS_ASSOCIATES;
  DATASET(recsrcr) SOURCE_COUNTS;
END;
