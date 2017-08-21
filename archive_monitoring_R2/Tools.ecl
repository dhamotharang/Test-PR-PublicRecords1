// ======================================================================================
// "Client" is a logical entity sending a request. Client's files are defined by directory
// structure (for example, 'root::NCO::NCO_<nso-source> for NCO). File names are relative
// to a root monitor dir. File routines assume that any superfile can contain atmost one physical file.

// Definitions:
//   client_id -- whatever defines the subdirectory structure for this particular client;
//                for example, for NCO it is 'NCO::NCO_<nso-source>'.
//   nco_id    -- NCO area (server + wsource) (string6);
//   record_id -- this is how we uniquely identify records for every client. Our internal record id.
//                For NCO this is "after-dash" part of account identifier.
//   acc_id    -- account identifier: original id as customer set it.

IMPORT ut;

EXPORT Tools := MODULE
  // used for identifying unique files, file dates, etc.
  shared THIS_WUID := thorlib.wuid ();
  shared backup_dir := Files.NAMES.BACKUP_DIR;

  EXPORT string SetVersion (string pFilenameTemplate, string pVersionString) :=
    RegExReplace('@version@', StringLib.stringtolowercase(pFilenameTemplate), pVersionString);

  EXPORT DetachAndDelete (string fname_base) := FUNCTION
    ds_owners := FileServices.LogicalFileSuperowners (fname_base);
    main_owner := ds_owners[1].name;
    // use only 1st (should be the only) owner; want to fail if it's not the only;
    return IF (count (ds_owners) > 0,
               FileServices.RemoveSuperFile (IF (main_owner[1] = '~', main_owner, '~' + main_owner), fname_base, TRUE));
  END;

  // removes (conditionally deletes) all subfiles from superfile family: "qa", "father", etc.
  // in case of delete, only current super-file (QA) is deleted, others can be removed manually
  EXPORT CleanFileFamily (string fname_base, integer ver = 1, boolean deleteSubfiles = false) := FUNCTION
    ver_name_2 := FileUtils.SetVersion (fname_base, Environment.QA_NAME);
    ver_name_3 := FileUtils.SetVersion (fname_base, Environment.FATHER_NAME);
    ver_name_4 := FileUtils.SetVersion (fname_base, Environment.GR_FATHER_NAME);
    ver_name   := FileUtils.SetVersion (fname_base, Environment.GR_GR_FATHER_NAME);
    action := PARALLEL (
      IF (ver < 2 and FileServices.SuperFileExists (ver_name_2), FileServices.ClearSuperFile (ver_name_2, deleteSubfiles)),
      // detach and delete "qa" version from super, if "delete"; father etc. should be removed manually (lazy)
      IF (ver < 2 and FileServices.SuperFileExists (ver_name_2) and deleteSubfiles, DetachAndDelete (ver_name_2)),
      IF (ver < 3 and FileServices.SuperFileExists (ver_name_3), FileServices.ClearSuperFile (ver_name_3, deleteSubfiles)),
      IF (ver < 4 and FileServices.SuperFileExists (ver_name_4), FileServices.ClearSuperFile (ver_name_4, deleteSubfiles)),
      IF (FileServices.SuperFileExists (ver_name), FileServices.ClearSuperFile (ver_name, deleteSubfiles))
    );
    return action;
  END;

  // deletes superfile family
  EXPORT DeleteFileFamily (string fname_base, integer ver = 1) := FUNCTION
    return CleanFileFamily (fname_base, ver, true);
  END;

  // Cleans (or deletes) all database files for a given client
  EXPORT CleanClientFamily (string client_id, integer ver = 1, boolean deleteSubfiles = false) := FUNCTION
    string dir := Monitoring.Files.Names.THOR_ROOT + client_id + '::@version@::';
    return PARALLEL (
      CleanFileFamily (dir + Files.NAMES.ARCHIVE,     ver, deleteSubfiles),
      CleanFileFamily (dir + Files.NAMES.RAW,         ver, deleteSubfiles),
      CleanFileFamily (dir + Files.NAMES.SUBMONITOR,  ver, deleteSubfiles),
      CleanFileFamily (dir + Files.NAMES.REPORT,      ver, deleteSubfiles),
      CleanFileFamily (dir + Files.NAMES.STH_ADDRESS, ver, deleteSubfiles),
      CleanFileFamily (dir + Files.NAMES.STH_PHONE,   ver, deleteSubfiles),
      CleanFileFamily (dir + Files.NAMES.STH_PROPERTY,ver, deleteSubfiles),
      CleanFileFamily (dir + Files.NAMES.STH_PAW,     ver, deleteSubfiles)
    ); 
  END;

  // Deletes all database files for a given client (shortcut)
  EXPORT DeleteClientFamily (string client_id, integer ver = 1) := FUNCTION
    return CleanClientFamily (client_id, ver, TRUE);
  END;

   // cleanes "main" monitor superfiles (removes subfiels)
  EXPORT CleanMainFiles () := FUNCTION
    action := PARALLEL (
      FileServices.ClearSuperFile (Monitoring.Files.Names.MONITOR),
      FileServices.ClearSuperFile (Monitoring.Files.Names.ADDRESS_SHORT_TERM),
      FileServices.ClearSuperFile (Monitoring.Files.Names.PHONE_SHORT_TERM),
      FileServices.ClearSuperFile (Monitoring.Files.Names.PROPERTY_SHORT_TERM)
    );
    return action;
  END;


  //===================================================================
  //=====================  BACKUP CLIENT ==============================
  //===================================================================
  // backup versions created previously are moved down the superfiles' chain (oldest being deleted);
  // 'fsuffix' is used in backup filenames for tracking purposes solely.

  shared BackupFNameCopyBased (
    string fname, 
    string client_id,
    string fsuffix = '',
    string fcontent = Environment.QA_NAME) := FUNCTION

    // file names: 
    string target_dir := backup_dir + client_id + '::'; // main backup directory
    string fname_sversion := target_dir + '@version@::' + fname; //new super
    string fname_backup := target_dir + fname + '_' + THIS_WUID + fsuffix; // new file name (user choice)

    // current archive:
    sname := Files.Names.THOR_ROOT + client_id + '::' + fcontent + '::' + fname;
    sub_name := FileServices.GetSuperFileSubName (sname, 1, TRUE);

    act_Backup := SEQUENTIAL (
      FileUtils.CreateAllSuperFiles (fname_sversion, true), // checks if backup super files exist
      FileServices.Copy (sub_name, Environment.GROUP_NAME, fname_backup),
      FileUtils.MoveSuperFiles (fname_sversion, fname_backup, true) //qa -> father, etc.
    );
    return If (FileServices.SuperFileExists (sname) AND FileServices.FileExists (sub_name, true), act_Backup);
  end;

  EXPORT BackupClientArchive (string client_id, string fsuffix = '') := 
    BackupFNameCopyBased (Files.NAMES.ARCHIVE, client_id, fsuffix);

  EXPORT BackupClientRaw (string client_id, string fsuffix = '') := 
    BackupFNameCopyBased (Files.NAMES.RAW, client_id, fsuffix);

  EXPORT BackupClientMonitor (string client_id, string fsuffix = '') := 
    BackupFNameCopyBased (Files.NAMES.SUBMONITOR, client_id, fsuffix);

  EXPORT BackupClientReport (string client_id, string fsuffix = '') := 
    BackupFNameCopyBased (Files.NAMES.REPORT, client_id, fsuffix);

  // sth-address
  EXPORT BackupClientSTHAddress (string client_id, string fsuffix = '') := 
    BackupFNameCopyBased (Files.NAMES.STH_ADDRESS, client_id, fsuffix);

  // sth-phone
  EXPORT BackupClientSTHPhone (string client_id, string fsuffix = '') := 
    BackupFNameCopyBased (Files.NAMES.STH_PHONE, client_id, fsuffix);



  //===================================================================
  //=====================  ROLLBACK CLIENT ============================
  //===================================================================

  // Moves subfiels one step up (from older to newer superfile)
  EXPORT Rollback (string client_id) := FUNCTION
    string dir := Files.Names.THOR_ROOT + client_id + '::@version@::';

    action := SEQUENTIAL (
      FileServices.StartSuperFileTransaction (),
      PARALLEL (
        FileUtils.RollbackSuperFiles (dir + Files.NAMES.ARCHIVE),
        FileUtils.RollbackSuperFiles (dir + Files.NAMES.RAW),
        FileUtils.RollbackSuperFiles (dir + Files.NAMES.SUBMONITOR),
        FileUtils.RollbackSuperFiles (dir + Files.NAMES.REPORT),
        FileUtils.RollbackSuperFiles (dir + Files.NAMES.STH_ADDRESS),
        FileUtils.RollbackSuperFiles (dir + Files.NAMES.STH_PHONE),
        FileUtils.RollbackSuperFiles (dir + Files.NAMES.STH_PROPERTY),
        FileUtils.RollbackSuperFiles (dir + Files.NAMES.STH_PAW)
      ),
      FileServices.FinishSuperFileTransaction ()
    );
    return action;
  END;



  //==================================================================================
  //==================================================================================
  //=====  NCO INTERFACE (MAYBE, IS WORTH MOVING TO A SEPARATE ATTRIBUTE; LATER) =====
  //==================================================================================
  //==================================================================================
  // for NCO "Client" is nco source (string6)

  // cleans (w/o deleting files) all superfiles for this NCO-source.
  EXPORT CleanNCO (string6 nco_id, boolean cleanSTH = false) := FUNCTION
    string dir := Monitoring.Files.Names.NCO_ROOT + 'NCO_' + nco_id + '::@version@::';
    act_no_sth := PARALLEL (
      CleanFileFamily (dir + Files.NAMES.ARCHIVE),
      CleanFileFamily (dir + Files.NAMES.RAW),
      CleanFileFamily (dir + Files.NAMES.SUBMONITOR),
      CleanFileFamily (dir + Files.NAMES.REPORT)
    ); 
    return IF (cleanSTH, CleanClientFamily ('NCO::NCO_' + nco_id), act_no_sth);
  END;

  EXPORT BackupNCOArchive (string6 nco_id, string fsuffix = '') := 
    BackupClientArchive ('NCO::NCO_' + nco_id, fsuffix);

  EXPORT BackupNCORaw (string6 nco_id, string fsuffix = '') := 
    BackupClientRaw ('NCO::NCO_' + nco_id, fsuffix);

  EXPORT BackupNCOMonitor (string6 nco_id, string fsuffix = '') := 
    BackupClientMonitor ('NCO::NCO_' + nco_id, fsuffix);

  EXPORT BackupNCOReport (string6 nco_id, string fsuffix = '') := 
    BackupClientReport ('NCO::NCO_' + nco_id, fsuffix);

  EXPORT BackupNCOAddress (string6 nco_id, string fsuffix = '') := 
    BackupClientSTHAddress ('NCO::NCO_' + nco_id, fsuffix);

  EXPORT BackupNCOPhone (string6 nco_id, string fsuffix = '') := 
    BackupClientSTHPhone ('NCO::NCO_' + nco_id, fsuffix);

  EXPORT BackupNCO (string6 nco_id, string fsuffix = '') := FUNCTION
    return SEQUENTIAL (
             BackupNCOArchive (nco_id, fsuffix),
             BackupNCORaw     (nco_id, fsuffix),
             BackupNCOMonitor (nco_id, fsuffix),
             BackupNCOReport  (nco_id, fsuffix),
             BackupNCOAddress (nco_id, fsuffix),
             BackupNCOPhone   (nco_id, fsuffix));
  END;

  EXPORT RollbackNCO (string6 nco_id) := Rollback ('NCO::NCO_' + nco_id);


  //==================================================================================
  //============================  BACKUP WHOLE NCO  ==================================
  //==================================================================================
  // 1. Creates a single file from ALL ("this type") NCO files and saves it in backup dir;
  // 2. No OVERWRITE, since this shouldn't be done more frequently than once a day;
  // 3. !!! Source files are cleaned;

  shared clean (string cname) := function
    string base_name := '~' + RegExReplace (Environment.QA_NAME, cname, '@version@');
    return CleanFileFamily (base_name, 1, true);
  end;

  // creates single NCO-archive file; to be run periodically to save space and processing time;
  EXPORT SaveNCOArchive () := FUNCTION
    ds := FileServices.SuperFileContents (Files.Names.NCO_ARCHIVE);
    return SEQUENTIAL (
      OUTPUT (Files.NCO.Archive, , backup_dir + 'nco::archive_' + THIS_WUID, __COMPRESSED__),
      NOTHOR (APPLY (ds, clean (name))));
  END;

  EXPORT SaveNCORaw () := OUTPUT (Files.NCO.Raw, , backup_dir + 'nco::raw_' + THIS_WUID, __COMPRESSED__);

  // creates single NCO-reports file; to be run periodically to save space and processing time;
  EXPORT SaveNCOReports () := FUNCTION
    ds := FileServices.SuperFileContents (Files.Names.NCO_REPORT);
    return SEQUENTIAL (
      OUTPUT (Files.NCO.Report, , backup_dir + 'nco::reports_' + THIS_WUID, __COMPRESSED__),
      NOTHOR (APPLY (ds, clean (name))));
  END;

  // creates single address-history file; can be run from time to time to improve efficiency;
  EXPORT SaveNCOAddress () := FUNCTION
    ds := FileServices.SuperFileContents (Files.Names.ADDRESS_SHORT_TERM);
    return SEQUENTIAL (
      OUTPUT (Files.ShortHistoryAddr, , backup_dir + 'address_history_short_' + ut.GetDate),
      NOTHOR (APPLY (ds, clean (name))));
  END;

  // creates single phone-history file; can be run from time to time to improve efficiency;
  EXPORT SaveNCOPhone () := FUNCTION
    ds := FileServices.SuperFileContents (Files.Names.PHONE_SHORT_TERM);
    return SEQUENTIAL (
      OUTPUT (Files.ShortHistoryPhone, , backup_dir + 'phone_history_short_' + ut.GetDate),
      NOTHOR (APPLY (ds, clean (name))));
  END;

  // back up of short-term history files; needs to be done, if history files are huge.
  // When Monitor runs, it should pick up all copies from backup destination directory 
  // (usually done manually; clean them after being used by Monitor).
  EXPORT SaveNCOHistory () := PARALLEL (SaveNCOAddress (), SaveNCOPhone ());



  // ==================================================================================
  // ===============================  CHECK CONSTRAINTS ===============================
  // ==================================================================================
  // there should be one and only one ID in raw_monitor file
  EXPORT CheckUniqueID (string6 nco_id) := FUNCTION
    ds := Files.NCO.ClientRaw (nco_id);

    layout_stat := RECORD
      ds.record_id;
      unsigned cnt := COUNT (GROUP);
    END;
    ds_table := TABLE (ds, layout_stat, record_id);

    // if duplicates exists, print them
    rec := RECORD (layouts_NCO.batch_raw)
      unsigned cnt;
    END;
    ds_dupes := ds_table (cnt > 1);
    ds_join := JOIN (ds_dupes, ds,
                     Left.record_id = Right.record_id,
                     transform (rec, Self.cnt := Left.cnt, Self := Right;));

    ds_srt := SORT (ds_join, -cnt, record_id);

    act_getstat := SEQUENTIAL (
      OUTPUT (CHOOSEN (ds_srt, 2000), NAMED ('join')),
      OUTPUT (count (ds_join), NAMED ('count_dupes'))
    );

    return IF (EXISTS (ds_dupes), act_getstat, OUTPUT (SORT (ds_table, -cnt)));
  END;


  // Gets original input records from archive or raw, which are errors (archive only) or warnings.
  EXPORT GetInvalidRaw_NCO (string6 client_id) := FUNCTION
    // get current error report
    ds_err := Files.NCO.ClientReport (client_id) (Client_NCO.IsFatalError (err));
    ds_archive := Files.NCO.ClientArchive (client_id); 
//    ds_archive := Files.NCO.ClientRaw (client_id); 

    layout_error := RECORD
      layouts_NCO.nco_in;
      layouts.error_report AND NOT seq;
    END;
    
    layout_error SetOutput (layouts.batch_report L, layouts_NCO.batch_raw R) := TRANSFORM
      SELF.new_id := L.new_id;
      SELF.executed := L.executed;
      SELF.err := L.err;
      SELF.status := L.status;
      SELF := R;
    END;
    // NB: if "person" is not unique within request, then we may have several "same" records after this join
    ds_res := JOIN (ds_err, ds_archive,
                    (Left.customer_id = Right.customer_id) AND
                    (Left.record_id = Right.record_id) AND
                    (Left.wuid = Right.wuid), // get record from same transaction only
                    SetOutput (Left, Right),
                    Left OUTER); // left outer just to have recs in case archive was deleted

    return ds_res;
  END;

  // Prints sample records (from set of record_id)
  EXPORT PrintNCOClientRecordSet (string6 nco_id, set of string6 rec_id_list) := FUNCTION
    act := SEQUENTIAL (
      output (Files.NCO.ClientArchive (nco_id) (record_id IN rec_id_list), NAMED ('arc_record')),
      output (Files.NCO.ClientRaw     (nco_id) (record_id IN rec_id_list), NAMED ('raw_record')),
      output (Files.NCO.ClientMonitor (nco_id) (record_id IN rec_id_list), NAMED ('monitor_record')),
      output (Files.NCO.ClientReport  (nco_id) (record_id IN rec_id_list), NAMED ('report_record'))
    );
    return act;
  END;

  // Prints sample records (by account id = record_id)
  EXPORT PrintNCOClientRecord (string6 nco_id, string record_id) := FUNCTION
    return PrintNCOClientRecordSet (nco_id, [record_id]);
  END;

  // This can be usefull for conflict resolution: searches all saved archives.
  // If possible, search is done by internal "after-dash" id: i.e. CG8428-4127978 will be found by '4127978'
  EXPORT FindNCORecord (string6 nco_id, string account_id) := FUNCTION
    acc_id  := Client_NCO.GetID (account_id);
    cust_id := 'NCO_' + nco_id;

    ds_raw := Monitoring.Files.NCO.ClientRaw (nco_id);
    ds_arc := Monitoring.Files.NCO.ClientArchive (nco_id);

    // search archives (should be adjusted correspondingly from time to time): 
    // old_1 := DATASET (backup_dir + 'NCO::archive_w20080115-180745', Monitoring.layouts_NCO.batch_raw, THOR);
    // old_2 := DATASET (backup_dir + 'NCO::archive_w20080307-160412', Monitoring.layouts_NCO.batch_raw, THOR);
    // old_3 := DATASET (backup_dir + 'NCO::archive_w20080627-121232', Monitoring.layouts_NCO.batch_raw, THOR);

    old_1 := DATASET (backup_dir + 'NCO::archive_w20080115-180745_distr', Monitoring.layouts_NCO.batch_raw, THOR);
    old_2 := DATASET (backup_dir + 'NCO::archive_w20080307-160412_distr', Monitoring.layouts_NCO.batch_raw, THOR);
    old_3 := DATASET (backup_dir + 'NCO::archive_w20080627-121232_distr', Monitoring.layouts_NCO.batch_raw, THOR);

    act := PARALLEL (
          // raw, current archive:
             output (ds_raw (record_id = acc_id), NAMED ('raw')),
             output (ds_arc (record_id = acc_id), NAMED ('archive')),
          // old archives (in oldest record ID contains dash):
             output (old_1  (Client_NCO.GetID (record_id) = acc_id, customer_id = cust_id), , NAMED ('old_1')),
             output (old_2  (Client_NCO.GetID (record_id) = acc_id, customer_id = cust_id), , NAMED ('old_2')),
             output (old_3  (record_id = acc_id, customer_id = cust_id), , NAMED ('old_3')),
          // history files:
             output (Monitoring.file_address_history (record_id = acc_id, customer_id = cust_id), , NAMED ('addr_hist')),
             output (Monitoring.file_phone_history   (record_id = acc_id, customer_id = cust_id), , NAMED ('addr_phone'))
           );

    // If record is found in any of the above sources, a job it was created with can be found by WUIDs.
    // After that "original" record can be fetched from input file (if still exists in THOR) using:
    file_in_name := Files.NAMES.THOR_ROOT + 'in::nco::upu15027_20080201_0400_appended'; //example
    ds_in := DATASET (file_in_name, layouts_NCO.batch, CSV (separator('|'), maxlength (16384)));
    //output (ds_in (account_identifier = account_id), NAMED ('client_input'));

    return act;
  END;

  // Sends a snapshot of repository to a landing zone ('NCO::NCO_N01030', 'PRA', etc.)
  EXPORT SendDBSnapShot (string customer_id = '') := function
    fname := Monitoring.Files.NAMES.THOR_ROOT + 'db_copy';

    repos_in := if (customer_id != '',
                    Monitoring.Files.ClientMonitor (customer_id),
                    Monitoring.Files.real_Monitor);

   repos := repos_in;
    // repos := project (repos_in, transform ({string15 date, string30 account}, 
                                            // Self.date := Left.wuid[2..16], Self.account := Left.record_id;));

    act_save := output (repos, , fname, CSV (separator('|'), terminator('\n'), heading(SINGLE)), OVERWRITE);

    act_despray := FileServices.Despray (fname, 
                                         Environment.LandingZone.ip, 
                                         // file name will start from '_' for the whole repos...
                                         Environment.LandingZone.resultPath + customer_id + '_mdb_snapshot_' + THIS_WUID [2..14] + '.csv', 
                                         , , , Environment.ALLOW_OVERWRITE);
    return sequential (act_save, act_despray);
  END;

END;
