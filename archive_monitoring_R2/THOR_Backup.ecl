import ut, lib_fileservices, _control, Monitoring_Other;

string THIS_WUID := thorlib.wuid ();
unsigned1 FILENAME_MAXLENGTH := 128;
string8 current_date := ut.GetDate : INDEPENDENT;
integer DAYS_SINCE_1900 := ut.DaysSince1900 (current_date[1..4], current_date[5..6], current_date[7..8]) : INDEPENDENT;

// Backup settings (logical names, cluster)
unsigned1 DAYS_BACK_DELETE := 2; // defines which versions to delete
string BACKUP_DIR := Thorlib.Cluster () + '::backup::';
string TARGET_DIR := '/c$/thordata/thor_200/backup';
string TARGET_IPBASE := '10.173.76.';
unsigned2 NODES_NUM := 200;
string FNAME_INFO := 'monitor'; // summary file

// Source (super file names)
string SOURCE_DIR := '~foreign::' + _control.IPAddress.prod_watch_dali + '::' + 'thor_data400::base::';
string fname_bluemark := 'monitoring_address_bluemark';
string fname_address  := 'monitoring_address_history';
string fname_customer := 'monitoring_customer_base';
string fname_phone    := 'monitoring_phone_history';
string fname_property := 'monitoring_property_history';
string fname_paw      := 'monitoring_paw_history';
string fname_address_reserve := 'monitoring_address_reserve';
string fname_phone_reserve   := 'monitoring_phone_reserve';

// enforce same rules for backup names
string GetBackupName (string fname, string8 dt_stamp) := fname + '_' + dt_stamp;


// =====================================================================
// ============================= do backup =============================
// =====================================================================
F_Address_blue    := DATASET (SOURCE_DIR + fname_bluemark, Monitoring.layout_address_update, THOR, OPT);
F_Address_History := DATASET (SOURCE_DIR + fname_address,  Monitoring.Layout_Address_History, THOR, OPT);
F_Customer_Base   := DATASET (SOURCE_DIR + fname_customer, Monitoring.Layout_Customer_Base, THOR, OPT);
F_Phone_History   := DATASET (SOURCE_DIR + fname_phone,    Monitoring.layout_phone_update, THOR, OPT);
F_Prop_History    := DATASET (SOURCE_DIR + fname_property, Monitoring_Other.layout_prp_slim, THOR, OPT);
F_PAW_History     := DATASET (SOURCE_DIR + fname_paw, Monitoring_Other.layout_paw_out, THOR, OPT);
F_Address_Reserve := DATASET (SOURCE_DIR + fname_address_reserve,  Monitoring.layout_address_update, THOR, OPT);
F_Phone_Reserve   := DATASET (SOURCE_DIR + fname_phone_reserve,    Monitoring.layout_phone_out, THOR, OPT);

act_CopyMonitorFiles () := SEQUENTIAL (
  OUTPUT (distribute (F_Address_blue, random()),    , '~' + BACKUP_DIR + GetBackupName (fname_bluemark, current_date), __COMPRESSED__),
  OUTPUT (distribute (F_Address_History, random()), , '~' + BACKUP_DIR + GetBackupName (fname_address,  current_date), __COMPRESSED__),
  OUTPUT (distribute (F_Customer_Base, random()),   , '~' + BACKUP_DIR + GetBackupName (fname_customer, current_date), __COMPRESSED__),
  OUTPUT (distribute (F_Phone_History, random()),   , '~' + BACKUP_DIR + GetBackupName (fname_phone,    current_date), __COMPRESSED__),
  OUTPUT (distribute (F_Prop_History, random()),    , '~' + BACKUP_DIR + GetBackupName (fname_property, current_date), __COMPRESSED__),
  //  OUTPUT (F_PAW_History,     , '~' + BACKUP_DIR + GetBackupName (fname_paw,      current_date), __COMPRESSED__),
  OUTPUT (distribute (F_Address_Reserve, random()), , '~' + BACKUP_DIR + GetBackupName (fname_address_reserve, current_date), __COMPRESSED__),
  OUTPUT (distribute (F_Phone_Reserve, random()),   , '~' + BACKUP_DIR + GetBackupName (fname_phone_reserve, current_date), __COMPRESSED__)
);


// ======================================================================
// =========================== delete previous ==========================
// ======================================================================
DeletePrevious (string fname, days_back) := FUNCTION
  string8 old_date := ut.DateFrom_DaysSince1900 (DAYS_SINCE_1900 - days_back);
  name := '~' + BACKUP_DIR + GetBackupName (fname, old_date);
  return IF (FileServices.FileExists (name), FileServices.DeleteLogicalFile (name));
END;

act_DeletePrevious := SEQUENTIAL (
  DeletePrevious (fname_bluemark, DAYS_BACK_DELETE),
  DeletePrevious (fname_address,  DAYS_BACK_DELETE),
  DeletePrevious (fname_customer, DAYS_BACK_DELETE),
  DeletePrevious (fname_phone,    DAYS_BACK_DELETE),
  DeletePrevious (fname_property, DAYS_BACK_DELETE),
  //  DeletePrevious (fname_paw,      DAYS_BACK_DELETE),
  DeletePrevious (fname_address_reserve, DAYS_BACK_DELETE),
  DeletePrevious (fname_phone_reserve, DAYS_BACK_DELETE)
);


// ======================================================================
// ============================ counts, etc =============================
// ======================================================================
    // static array of IPs
    ip_rec := RECORD, MAXLENGTH (32)
      string ip;
    END;
    ds_in := DATASET ([{TARGET_IPBASE}], ip_rec);

    ip_rec GetNodeIP (ip_rec L, UNSIGNED C) := TRANSFORM
      SELF.ip := L.ip + C;
    END;
    DS_ALL_IP := NORMALIZE (ds_in, NODES_NUM, GetNodeIP (Left, COUNTER));

GetNodeInfo (string ip_base, string dir, string fname) := FUNCTION
  lib_fileservices.FsFilenameRecord SetInfo (ip_rec L) := TRANSFORM
    ds_info := FileServices.remotedirectory (L.ip, dir, fname + '*.*');
    Self.name := ds_info[1].name;
    Self.size := ds_info[1].size;
    Self.modified := ds_info[1].modified;
  END;
  return PROJECT (DS_ALL_IP, SetInfo (Left));
END;

// initialize
layout_init := RECORD
  string fname {MAXLENGTH (128)};
END;
layout_file := RECORD (lib_fileservices.FsLogicalFileInfoRecord)
  unsigned8 compressed_size := 0;
  decimal5_2 compression_rate := 0.0;
END;
layout_info := RECORD (layout_init)
  DATASET (layout_file) info {MAXCOUNT (3)}; // source super+actual, target actual
END;
ds_init := DATASET ([{fname_bluemark}, {fname_address}, {fname_customer}, {fname_phone},
                     {fname_property}, {fname_address_reserve}, {fname_phone_reserve}], layout_init);

layout_info GetSizeInfo (layout_init L) := TRANSFORM
  // source data
  // src_flist := PROJECT (FileServices.LogicalFileList (SOURCE_DIR + L.fname, true, true), layout_file);
  // sub_name := FileServices.GetSuperFileSubName ('~' + src_flist[1].name, 1, false); // do not prepend '~'
  // src_info := src_flist + IF (src_flist[1].superfile, PROJECT (FileServices.LogicalFileList (sub_name, true, false), layout_file));

  // backup_data
  fname_backup := GetBackupName (L.fname, current_date);
  ds_nodes := GetNodeInfo (TARGET_IPBASE, TARGET_DIR, fname_backup);
  cmpr_size := SUM (ds_nodes, (integer) size);
  backup_info := PROJECT (FileServices.LogicalFileList (BACKUP_DIR + fname_backup, true, true), 
                          transform (layout_file, 
                                     Self.compressed_size := cmpr_size, 
                                     Self.compression_rate := (100 - (cmpr_size / Left.size * 100)), 
                                     Self := Left));

  SELF.fname := L.fname;
  SELF.info := backup_info; //src_info + backup_info;
END;
ds_res_info := PROJECT (ds_init, GetSizeInfo (Left));

source_kb := SUM (ds_res_info, info[1].size / 1024);
res_kb := SUM (ds_res_info, info[1].compressed_size / 1024);

act_GetInfo := SEQUENTIAL (
  OUTPUT (ds_res_info, , '~' + BACKUP_DIR + GetBackupName (FNAME_INFO, current_date)),
  OUTPUT (DATASET ([
   {'source size (Kb): ' + source_kb},
   {'res size (Kb): ' + res_kb},
   {'compression (%): ' + (100 - (res_kb / source_kb * 100))}], {string64 _log}), NAMED ('counts'))
);

// ACTION
email_body := 'Copied files listed in: ' + BACKUP_DIR + GetBackupName (FNAME_INFO, current_date);

EXPORT THOR_Backup := SEQUENTIAL (
  act_CopyMonitorFiles (),
  act_GetInfo,
  act_DeletePrevious) :
FAILURE (FileServices.sendemail (Environment.BACKUP_MAIL_LIST, 'Monitor backup failed: ' + THIS_WUID, failmessage)),
SUCCESS (FileServices.sendemail (Environment.BACKUP_MAIL_LIST, 'Monitor backup completed: ' + THIS_WUID, email_body));

/*
// this is how to schedule it on THOR:

// check whether we're already running (courtesy of Tony Kirk)
lWorkunitName := Monitoring.Files.Names.WUID_BACKUP_MAIN;
#workunit('name', lWorkunitName);
	
lWorkunitStates := ['RUNNING','WAIT'];
boolean ExistsSameJob := function
  dOtherWorkunits       := WorkunitServices.WorkUnitList('','','','',lWorkunitName);
  dOtherWorkunitsActive := dOtherWorkunits (wuid <> workunit and (qstring)state in lWorkunitStates);
  return count(dOtherWorkunitsActive) != 0;
end;

act_run := Monitoring.THOR_Backup;
string str_failure := 'Abort ' + workunit + ': Another workunit with name "' + lWorkunitName + '" is already active.';
if (ExistsSameJob,
   sequential (FileServices.sendemail ('Vladimir.Myullyari@lexisnexis.com', str_failure, ''), fail (str_failure)));
act_run : WHEN (EVENT ('CRON', '30 15 * * *'));  //EST: 11.30
*/