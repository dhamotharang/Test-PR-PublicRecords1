//**** Full record def for the Comp Reports
IMPORT doxie,DriversV2_Services,EquifaxDecisioning,iesp,images,vehicleV2_services;

recvehi  := RECORDOF(doxie.vehicle_search_records_crs); 
recvehi2 := vehicleV2_services.Layout_Report;
recsexo  := RECORDOF(doxie.sexoffender_search_records);
recdlsr  := RECORDOF(doxie.dl_search_records);
recdlsr2 := DriversV2_Services.layouts.result_wide;
recdocr  := RECORDOF(doxie.doc_search_records);
recimar  := RECORDOF(images.image_fullrecords);
recdocr2 := iesp.criminal_fcra.t_FcraCrimReportRecord;
transhist :=	iesp.transactionhistory.t_TransactionHistoryRecord;

EXPORT layout_report_fcra := RECORD, MAXLENGTH(doxie_crs.maxlength_report)
	doxie.layout_central_records;
	DATASET(recvehi) vehicle_children;
	DATASET(recvehi2) vehicle2_children;
	DATASET(recsexo) sex_offenses_children;
	DATASET(recdlsr) drivers_licenses_children;
	DATASET(recdlsr2) drivers_licenses2_children;
	DATASET(recdocr) DOC_children;
	DATASET(recimar) images_children;
	DATASET(recdocr2) DOC2_children{xpath('CriminalRecords/Criminal'), MAXCOUNT(iesp.constants.CRIM.MaxReportRecords)};
	transhist TransactionHistory {xpath('TransactionHistory')};
  EquifaxDecisioning.Layouts.Eq_DecisioningAttr Eq_Decisioning_Attr;
END;

