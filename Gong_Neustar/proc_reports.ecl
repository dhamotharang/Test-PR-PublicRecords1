EXPORT proc_reports(string update_date) := SEQUENTIAL
(
	output(enth(gong_Neustar.File_Master(filedate=update_date,dt_first_seen=dt_last_seen),100),named('NewEntries')),
	File_GongVendorIDs.fn_master_vendor_counts(File_Master, update_date)
	// ,output('Count Vendor Connect/Disconnect - Unique Vendor/Phone/CurrentFlag')
	// ,Gong.File_GongVendorIDs.fn_master_vendor_counts(dedup(sort(gong_v2.File_GongMaster, vendor, npa, telno, -current_record_flag), vendor, npa, telno))
  ,out_STRATA_population_stats(update_date) //STRATA
  ,proc_build_gongAsClickdata //Clickdata
);