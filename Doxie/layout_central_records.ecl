// Extends header-based data with single source data

import moxie_phonesplus_server, bankruptcyv2_services, doxie_crs, doxie, liensv2_services,
  UCCv2_Services, Votersv2_services, WatercraftV2_services,	DeaV2_Services, EmailService, EmailV2_Services, iesp;

con := doxie_crs.constants;

recuccr := doxie_crs.layout_UCC_Records;
recucc2r:= UCCv2_Services.layout_ucc_rollup;
reccorr := doxie_crs.layout_corp_affiliations_records;
recprop := doxie_Crs.layout_property_ln;
recprop2:= doxie_crs.layout_property_v2;
recflcr := doxie_crs.layout_FLCrash_Search_Records;
recvotr := doxie_crs.layout_voter_records;
recvot2r:= Votersv2_services.layouts.EmbeddedOutput;
recccwr := doxie_crs.layout_ccw_records;
recplrr := doxie_crs.layout_PL_Records;
recsancr:= doxie.ingenix_sanctions_module.layout_ingenix_sanctions_report;
recprovr:= doxie.ingenix_provider_module.layout_ingenix_provider_report;
recUtility := doxie_crs.layout_utility.record_layout_slim;
recatfr := iesp.firearm_fcra.t_FcraFirearmRecord;
rechunr := doxie_crs.layout_hunting_records;
recpilr := doxie_crs.layout_pilot_records;
reccerr := doxie_crs.layout_pilot_cert_records;
recfaar := doxie_crs.layout_Faa_Aircraft_records;
recbkrr := doxie.Layout_BK_output_ext;
recbkr2r:= Bankruptcyv2_services.layouts.layout_rollup;
reclier := doxie_Crs.layout_Liens_Judgments_records;
reclv2r := liensv2_services.layout_lien_rollup;
recderr := doxie_crs.layout_dea_records;
recderr2 := DEAV2_Services.assorted_layouts.Layout_Output;
recwtcr := WatercraftV2_services.Layouts.report_out;
recidom := doxie_crs.layout_whois;
employm := doxie_crs.layout_employment;
recnod := iesp.foreclosure.t_ForeclosureSearchRecord;
recfrcl := doxie_crs.layout_foreclosure_report;
recphpl := moxie_phonesplus_server.Layout_batch_did.w_timezone;
recprph := doxie.premium_phone.premium_phone_rec;
recEmail := EmailService.Assorted_Layouts.layout_report_rollup;
recDLAA := iesp.driverlicense2.t_DLEmbeddedReport2Record;
recPatA := iesp.globalwatchlist.t_GlobalWatchListSearchRecord;
recRTV	:= iesp.motorvehicle.t_MotorVehicleReport2Record;
recfbnr := iesp.fictitiousbusinesssearch.t_FictitiousBusinessSearchRecord;

recverification := iesp.verification.t_IndividualVerificationRecord;
recpsummary := iesp.phonesummary.t_PhoneSummaryRecord;
recASL			:= iesp.student.t_PossibleStudentInformation;
recASL2			:= iesp.student.t_StudentRecord;

//**** Individual record defs


//**** Monster record def
// maxlength overrides maxcount on child datasets
// but maxcount for all new child datasets needs to specified to future compatibility
export layout_central_records := record, maxlength(doxie_crs.maxlength_report)
  doxie.layout_central_header and not [subject_names, subject_addresses, errors];
	dataset(recuccr) ucc_children;
	dataset(recucc2r) uccv2_children;
	dataset(reccorr) corporate_affiliations_children;
	dataset(recprop) property_children;
	dataset(recprop2) propertyV2_children;
	dataset(recflcr) fl_crash_children;
	dataset(recvotr) voter_children;
	dataset(recvot2r) voterv2_children;
	dataset(recccwr) concealed_weapon_licenses_children;
	dataset(recplrr) professional_licenses_children;
	dataset(recsancr) sanction_children;
	dataset(recprovr) provider_children;
  dataset(recUtility) utility_children;
	dataset(recEmail) Email_children;
	dataset(employm) employment_children;
	dataset(recatfr) firearms_and_explosives_children{xpath('FirearmExplosives/FirearmExplosive')};
	dataset(rechunr) hunting_licenses_children;
	dataset(recpilr) pilot_licenses_children;
	dataset(reccerr) pilot_certificates_children;
	dataset(recfaar) pilot_aircraft_children;
	dataset(recbkrr) bankruptcies_children;
	dataset(recbkr2r) bankruptcies_v2_children;
	dataset(iesp.bankruptcy_fcra.t_FcraBankruptcy3BpsRecord) bankruptcies_v3_children;
	dataset(reclier) liens_judgements_children;
	dataset(reclv2r) liens_judgements_v2_children;
	dataset(recderr) dea_children;
	dataset(recderr2)deaV2_children;
	dataset(recwtcr) watercraft_children;
	dataset(recidom) netdomain_children;
	dataset(recnod) nod_children{xpath('NoticesOfDefaults/NoticeOfDefaults')};
	dataset(recfrcl) foreclosure_children;
	dataset(recphpl) phonesplus_children {maxcount(con.max_phonesplus)};
	dataset(recprph) premium_phone_children {maxcount(con.max_phonesplus)};
	dataset(recDLAA) driversataddress_children;
	dataset(recPatA) PatriotSearch_children{xpath('GlobalWatchLists/GlobalWatchList')};
	dataset(recfbnr) FBNSearch_children{xpath('FictitiousBusinesses/FictitiousBusiness')};
	dataset(recrtv) RealTime_Vehicle_children{xpath('RealTimeVehicles/RealTimeVehicle')};
	dataset(recverification) verification {xpath('Verification'), maxcount(con.max_verification)};
	dataset(recpsummary) phone_summary {xpath('PhoneSummary'), maxcount(con.max_phone_summary)};
	dataset(recASL) student_information {xpath('PossibleStudentInformation'), MAXCOUNT(iesp.Constants.MaxCountASL)};
	dataset(recASL2) studentV2_information {xpath('PossibleStudentRecords/PossibleStudentRecord'), MAXCOUNT(iesp.Constants.MaxCountASLSearch)};

  EmailV2_Services.Layouts.crs_email_combined_rec;
	boolean bankruptcies_v2_indicator := false;
	boolean corporate_affiliations_indicator := false;
	boolean propertyV2__indicator := false;
	boolean hasCriminalConviction := false;
	boolean isSexualOffender := false;
end;
