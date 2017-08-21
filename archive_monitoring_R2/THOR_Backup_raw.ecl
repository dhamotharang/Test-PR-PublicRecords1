import ut, lib_fileservices, _control;

string THIS_WUID := thorlib.wuid ();
unsigned1 FILENAME_MAXLENGTH := 128;
string8 current_date := ut.GetDate : INDEPENDENT;
integer DAYS_SINCE_1900 := ut.DaysSince1900 (current_date[1..4], current_date[5..6], current_date[7..8]) : INDEPENDENT;

// Backup settings (logical names, cluster)
unsigned1 DAYS_BACK_DELETE := 7; // defines which versions to delete
string BACKUP_DIR := Thorlib.Cluster () + '::backup::';
string TARGET_DIR := '/c$/thordata/thor_200/backup';
string TARGET_IPBASE := '10.173.76.';
unsigned2 NODES_NUM := 200;

string FNAME_INFO := BACKUP_DIR + 'raw_files_' + current_date; // summary file name

// Source (logical file names)
string fname_raw_nco := Monitoring.Files.NAMES.NCO_RAW;
string fname_raw_pra := Monitoring.Files.NAMES.PRA_RAW;
string fname_raw_bwh := Monitoring.Files.NAMES.BWH_RAW;

//enforce same rules for backup names
string GetBackupName (string3 CID, string8 dt_stamp) := 'raw_' + dt_stamp + '_' + CID;



// =====================================================================
// =============== do backup (add files when needed) ===================
// =====================================================================
F_nco_raw := DATASET ('~foreign::' + _control.IPAddress.prod_watch_dali + '::' + Monitoring.FileUtils.GetNoTildaName (fname_raw_nco), 
                      Monitoring.layouts_NCO.batch_raw, THOR, OPT);
F_pra_raw := DATASET ('~foreign::' + _control.IPAddress.prod_watch_dali + '::' + Monitoring.FileUtils.GetNoTildaName (fname_raw_pra), 
                      Monitoring.layouts_PRA.batch_raw, THOR, OPT);
F_bwh_raw := DATASET ('~foreign::' + _control.IPAddress.prod_watch_dali + '::' + Monitoring.FileUtils.GetNoTildaName (fname_raw_bwh), 
                      Monitoring.layouts_BWH.batch_raw, THOR, OPT);
act_CopyRawFiles () := SEQUENTIAL (
  OUTPUT (distribute (F_nco_raw, random()), , '~' + BACKUP_DIR + GetBackupName ('NCO', current_date), __COMPRESSED__),
  OUTPUT (distribute (F_pra_raw, random()), , '~' + BACKUP_DIR + GetBackupName ('PRA', current_date), __COMPRESSED__),
  OUTPUT (distribute (F_bwh_raw, random()), , '~' + BACKUP_DIR + GetBackupName ('BWH', current_date), __COMPRESSED__)
);



// ======================================================================
// =============== delete previous (add files when needed) ==============
// ======================================================================
DeletePrevious (string fname, days_back) := FUNCTION
  string8 old_date := ut.DateFrom_DaysSince1900 (DAYS_SINCE_1900 - days_back);
  name := '~' + BACKUP_DIR + GetBackupName (fname, old_date);
  return IF (FileServices.FileExists (name), FileServices.DeleteLogicalFile (name));
END;

act_DeletePrevious := SEQUENTIAL (
  DeletePrevious ('NCO', DAYS_BACK_DELETE),
  DeletePrevious ('PRA', DAYS_BACK_DELETE),
  DeletePrevious ('BWH', DAYS_BACK_DELETE)
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

    // warning: this call is case sensitive!
    ds_info := FileServices.remotedirectory (L.ip, dir, stringlib.StringToLowerCase (fname) + '*.*');
    Self.name := ds_info[1].name;
    Self.size := ds_info[1].size;
    Self.modified := ds_info[1].modified;
  END;
  return PROJECT (DS_ALL_IP, SetInfo (Left));
END;

// initialize (all other files for counting sizes can be added here)
layout_init := RECORD
  string3 client_id;
  string src_fname {MAXLENGTH (FILENAME_MAXLENGTH)};
END;
layout_file := RECORD (lib_fileservices.FsLogicalFileInfoRecord)
  unsigned8 compressed_size := 0;
  decimal5_2 compression_rate := 0.0;
END;
layout_info := RECORD
  string3 client_id;
  string src_fname {MAXLENGTH (FILENAME_MAXLENGTH)};
  DATASET (layout_file) info {MAXCOUNT (2)}; // source super(s), target actual
END;
ds_init := DATASET ([
  {'NCO', fname_raw_nco}, {'PRA', fname_raw_pra}, {'BWH', fname_raw_bwh} 
], layout_init) : INDEPENDENT;


// produces stat on compression
layout_info GetSizeInfo (layout_init L) := TRANSFORM
  SELF.client_id := L.client_id;

  // backup_data
  fname_backup := GetBackupName (L.client_id, current_date);
  ds_nodes := GetNodeInfo (TARGET_IPBASE, TARGET_DIR, fname_backup);
  cmpr_size := SUM (ds_nodes, (integer) size);

  flist := FileServices.LogicalFileList (BACKUP_DIR + fname_backup, true, true); 
  backup_info := PROJECT (flist, transform (layout_file, 
                                            Self.compressed_size := cmpr_size, 
                                            Self.compression_rate := (100 - (cmpr_size / Left.size * 100)), 
                                            Self := Left));
  SELF.src_fname := L.src_fname;
  SELF.info := backup_info; //src_info + backup_info;
END;
ds_res_info := PROJECT (ds_init, GetSizeInfo (Left));

source_kb := SUM (ds_res_info, info[1].size / 1024);
res_kb := SUM (ds_res_info, info[1].compressed_size / 1024);
 
act_GetInfo := SEQUENTIAL (
  OUTPUT (ds_res_info, , '~' + FNAME_INFO);
  OUTPUT (DATASET ([
   {'source size (Kb): ' + source_kb},
   {'res size (Kb): ' + res_kb},
   {'compression (%): ' + (100 - (res_kb / source_kb * 100))}], {string64 _log}), NAMED ('counts'))
);



// ======================================================================
// =========================    ACTION    ===============================
// ======================================================================
string email_body := 'Copied files listed in: ' + FNAME_INFO;
action := SEQUENTIAL (
  act_CopyRawFiles (),
  act_GetInfo,
  act_DeletePrevious) :
FAILURE (FileServices.sendemail (Environment.BACKUP_MAIL_LIST, 'raw clients backup failed: ' + THIS_WUID, failmessage)),
SUCCESS (FileServices.sendemail (Environment.BACKUP_MAIL_LIST, 'raw clients backup completed: ' + THIS_WUID, email_body));

// this is "wrong": indeed, symbolic names must be used.
do_backup := (ut.Weekday ((unsigned) current_date) = 'SUNDAY') or 
             (ut.Weekday ((unsigned) current_date) = 'WEDNESDAY');

EXPORT THOR_Backup_raw := action;//IF (do_backup, action, OUTPUT ('bad day for backup'));
/*
// this is how to schedule it on THOR:

// check whether we're already running (courtesy of Tony Kirk)
lWorkunitName := Monitoring.Files.Names.WUID_BACKUP_RAW;
#workunit('name', lWorkunitName);
	
lWorkunitStates := ['RUNNING','WAIT'];
boolean ExistsSameJob := function
  dOtherWorkunits       := WorkunitServices.WorkUnitList('','','','',lWorkunitName);
  dOtherWorkunitsActive := dOtherWorkunits (wuid <> workunit and (qstring)state in lWorkunitStates);
  return count(dOtherWorkunitsActive) != 0;
end;

act_run := Monitoring.THOR_Backup_raw;
string str_failure := 'Abort ' + workunit + ': Another workunit with name "' + lWorkunitName + '" is already active.';
if (ExistsSameJob,
   sequential (FileServices.sendemail ('Vladimir.Myullyari@lexisnexis.com', str_failure, ''), fail (str_failure)));
act_run : WHEN (EVENT ('CRON', '20 18 * * 0,3'));  //EST: 14.20

*/