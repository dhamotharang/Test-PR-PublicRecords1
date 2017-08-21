// "moves" NCO from one server/source to another (it is actually just renaming in THOR).
// Customer IDs should be changed in all main files (RAW, ARCHIVE, etc.)
// W20090310-115237, W20090508-110435+

//U14525 --> U14054
string6 client_id_old := 'U14525';
string6 client_id_new := 'U14054';

#WORKUNIT ('name', 'NCO maintanance: renaming, ' + client_id_old + ' --> ' + client_id_new);
#WORKUNIT ('priority', 'high');

string WUID := thorlib.wuid ();

// generate file names
fnames_old := Monitoring.FileUtils.GetUpdateJobFileNames ('NCO', 'rename_id', WUID, 'NCO_' + client_id_old);
fnames_new := Monitoring.FileUtils.GetUpdateJobFileNames ('NCO', '', WUID, 'NCO_' + client_id_new);
//output (Monitoring.FileUtils.GetJobLog (fnames));

// Archive:  customer_id, nco_server  (as well as tr. UPN07012200903051825-2671-49483905, but this is not relevant)
ds_archive := Monitoring.Files.NCO.ClientArchive (client_id_old);

recordof (ds_archive) SetArchiveSource (recordof (ds_archive) L) := transform
  Self.customer_id := stringlib.StringFindReplace(L.customer_id, client_id_old, client_id_new);
  Self.nco_server     := client_id_new[1..3];
  Self.work_source_id := client_id_new[4..6];
  Self := L;
end;
ds_archive_new := project (ds_archive, SetArchiveSource (Left));

parent_archive := Monitoring.Files.NAMES.THOR_ROOT + 'NCO::' + Monitoring.Files.Names.ARCHIVE;

act_UpdateArchieve := SEQUENTIAL (
  OUTPUT (ds_archive_new, , fnames_old.archive_file),
  FileServices.PromoteSuperFileList (Monitoring.FileUtils.GetList (fnames_new.archive_ver), fnames_old.archive_file, TRUE),
  FileServices.AddSuperFile (parent_archive, fnames_new.archive_qa)
);
// --------------------------------------


// Raw:  customer_id, nco_server  (as well as tr. UPN07012200903051825-2671-49483905, but this is not relevant)
ds_raw := Monitoring.Files.NCO.ClientRaw (client_id_old);

recordof (ds_raw) SetRawSource (recordof (ds_raw) L) := transform
  Self.customer_id := stringlib.StringFindReplace(L.customer_id, client_id_old, client_id_new);
  Self.nco_server     := client_id_new[1..3];
  Self.work_source_id := client_id_new[4..6];
  Self := L;
end;
ds_raw_new := project (ds_raw, SetRawSource (Left));

parent_Raw := Monitoring.Files.NAMES.THOR_ROOT + 'NCO::' + Monitoring.Files.Names.RAW;

act_UpdateRaw := SEQUENTIAL (
  OUTPUT (ds_raw_new, , fnames_old.raw_file),
  FileServices.PromoteSuperFileList (Monitoring.FileUtils.GetList (fnames_new.raw_ver), fnames_old.raw_file, TRUE),
  FileServices.AddSuperFile (parent_raw, fnames_new.raw_qa)
);
// --------------------------------------


// Submonitor:  customer_id
ds_monitor := Monitoring.Files.NCO.ClientMonitor (client_id_old);

recordof (ds_monitor) SetMonitorSource (recordof (ds_monitor) L) := transform
  Self.customer_id := stringlib.StringFindReplace(L.customer_id, client_id_old, client_id_new);
  Self := L;
end;
ds_monitor_new := project (ds_monitor, SetMonitorSource (Left));

act_UpdateMonitor := SEQUENTIAL (
  OUTPUT (ds_monitor_new, , fnames_old.submonitor_file),
  FileServices.PromoteSuperFileList (Monitoring.FileUtils.GetList (fnames_new.submonitor_ver), fnames_old.submonitor_file, TRUE),
  FileServices.AddSuperFile (Monitoring.Files.Names.MONITOR, fnames_new.submonitor_qa)
);
// --------------------------------------


// report:  customer_id
ds_report := Monitoring.Files.NCO.ClientReport (client_id_old);

recordof (ds_report) SetReportSource (recordof (ds_report) L) := transform
  Self.customer_id := stringlib.StringFindReplace(L.customer_id, client_id_old, client_id_new);
  Self := L;
end;
ds_report_new := project (ds_report, SetReportSource (Left));

parent_report := Monitoring.Files.NAMES.THOR_ROOT + 'NCO::' + Monitoring.Files.Names.REPORT;

act_UpdateReport := SEQUENTIAL (
  OUTPUT (ds_report_new, , fnames_old.report_file),
  FileServices.PromoteSuperFileList (Monitoring.FileUtils.GetList (fnames_new.report_ver), fnames_old.report_file, TRUE),
  FileServices.AddSuperFile (parent_report, fnames_new.report_qa)
);
// --------------------------------------

SEQUENTIAL (act_UpdateArchieve, act_UpdateRaw, act_UpdateMonitor, act_UpdateReport);
