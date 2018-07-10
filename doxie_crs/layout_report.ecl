//**** Full record def for the Comp Reports
import doxie,images,vehicleV2_services,DriversV2_Services,iesp;

recvehi := recordof(doxie.vehicle_search_records_crs); 
recvehi2 := vehicleV2_services.Layout_Report;
recsexo := recordof(doxie.sexoffender_search_records);
recdlsr := recordof(doxie.dl_search_records);
recdlsr2 := DriversV2_Services.layouts.result_wide;
recdocr := recordof(doxie.doc_search_records);
recimar := recordof(images.image_fullrecords);
recdocr2 := iesp.criminal_fcra.t_FcraCrimReportRecord;
transhist :=	iesp.transactionhistory.t_TransactionHistoryRecord;

export layout_report := record, maxlength(doxie_crs.maxlength_report)
	doxie.layout_central_records;
	dataset(recvehi) vehicle_children;
	dataset(recvehi2) vehicle2_children;
	dataset(recsexo) sex_offenses_children;
	dataset(recdlsr) drivers_licenses_children;
	dataset(recdlsr2) drivers_licenses2_children;
	dataset(recdocr) DOC_children;
	dataset(recimar) images_children;
	dataset(recdocr2) DOC2_children{xpath('CriminalRecords/Criminal'), MAXCOUNT(iesp.constants.CRIM.MaxReportRecords)};
	transhist TransactionHistory {xpath('TransactionHistory')};
	DATASET(iesp.ContactPlus.t_ContactPlusProgPhoneRecord) progressive_phones {MAXCOUNT(doxie.rollup_limits.progressivePhone)};
end;

