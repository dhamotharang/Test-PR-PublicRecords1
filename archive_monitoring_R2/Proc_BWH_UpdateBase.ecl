//#WORKUNIT ('priority', 'high');

unsigned2 LOOKUP_THRESHOLD := 1000; //record limit, if exceeded distribution will be used
Env := Monitoring.Environment;

EXPORT Proc_BWH_UpdateBase (string vendorName, string fileName, boolean do_spray = true) := FUNCTION

  #workunit('name', vendorName + ' Monitor Update');
  string WUID := thorlib.wuid ();
  fnames := FileUtils.GetUpdateJobFileNames (vendorName, fileName, WUID);


  // ============================================================================
  //                    SPRAY CLIENT INPUT, BATCH OUTPUT files
  // ============================================================================
  // Assuming file-by-file processing. Otherwise separate spray per file type is required
  act_sprayFile := FileServices.SprayVariable (
    Environment.LandingZone.ip, fnames.source_lz, 16384, '|',,'', // maxrecordsize,  srcCSVseparator, srcCSVterminator, srcCSVquote
    Environment.GROUP_NAME, fnames.source_thor, 
    ,,, Environment.ALLOW_OVERWRITE,, //timeout, espserverIPport, maxConnections, ALLOWOVERWRITE, replicate, compress
  );

  // read file just sprayed
  ds_batch_in := DATASET (fnames.source_thor, layouts_BWH.batch, CSV (separator('|'), QUOTE(''), maxlength (16384)));


  // ============================================================================
  //               APPEND TRANSACTIONS TO AN ARCHIVE (history) FILE 
  // ============================================================================
  // For every client all batch requests are kept in a "batch history" file (archive);
  // Current (or any cutoff date) monitor state for this client -- submonitor -- can be restored from this file, 
  // using date-time stamp. Archive can be shrinked from time to time to save space.

  // Assign internal id for every record
  layouts_BWH.batch_raw AssignId (layouts_BWH.batch L) := TRANSFORM
    // IMPORTANT: customer_id + record_id should be unique across ALL clients
    SELF.customer_id := Constants.ClientID.BWH;
    SELF.record_id := Client_BWH.GetID (L.account);
    SELF.request_code := stringlib.StringToUpperCase (L.request_code);
    SELF.wuid := WUID; // save it for tracking purposes

    SELF := L;
  END;
  ds_current_batch := PROJECT (ds_batch_in, AssignId (Left));

  // read current history (create superfiles, if no exist)
  ds_archive := Files.BWH.Archive;
  ds_archive_updated := ds_archive + ds_current_batch;

  // Check if this subfile already included into main BWH raw, insert, if it is not;
  update_BWH_archive := IF (FileServices.FindSuperFileSubName (Files.Names.BWH_ARCHIVE, fnames.archive_qa) < 1,
                            FileServices.AddSuperFile (Files.Names.BWH_ARCHIVE, fnames.archive_qa)); 

  act_UpdateArchieve := SEQUENTIAL (
    OUTPUT (ds_archive_updated, , fnames.archive_file),
    FileServices.PromoteSuperFileList (FileUtils.GetList (fnames.archive_ver), fnames.archive_file, TRUE),
    IF (Environment.INIT_FILES, update_BWH_archive)
  );


  // ============================================================================
  //                  VERIFY BATCH, SELECT RECORDS GROUPS 
  // ============================================================================
  // new assumption: input file can have several requests for the same object (defined by record_id)

  // get current raw monitor (also used in the next section)
  ds_client_raw := Files.BWH.Raw; // can be empty (for instance, in the first run)

  // check input validity
  batch_verified := Client_BWH.VerifyBatch (ds_current_batch, ds_client_raw) : INDEPENDENT;

  // save batch report
  layouts.batch_report FormatReport (layouts_BWH.verification L) := transform
    Self := L;
    Self := []; // account_identifier, transaction_id
  end;
  act_writeBatchReport := OUTPUT (PROJECT (batch_verified, FormatReport (Left)), , fnames.verified, CSV (separator('|'), terminator('\n')), OVERWRITE);

  // raw and client monitor need executable records only;
  ds_exec := PROJECT (batch_verified (executed), layouts_BWH.batch_raw);
  COUNT_EXECUTABLE := COUNT (ds_exec) : INDEPENDENT;
  boolean DO_DISTRIBUTE := COUNT_EXECUTABLE > LOOKUP_THRESHOLD;
  DS_BATCH_EXEC := IF (DO_DISTRIBUTE, DISTRIBUTE (ds_exec, HASH(customer_id, record_id)), ds_exec) : INDEPENDENT;

  // STH files need all valid transactions (coming after last 'Delete', if any)
  ds_valid := batch_verified (~Client_BWH.IsFatalError (err)); // DISTRIBUTE?
  ds_grp := GROUP (SORT (ds_valid, record_id, ~(request_code = 'D'), seq), record_id);
  ds_ddp := DEDUP (ds_grp, (Left.seq > Right.seq)); // this will leave atmost first D plus later add/updates
  DS_BATCH_VALID := ds_ddp (request_code != 'D');   // remove first 'D', if any
  //NB: without  ": INDEPENDENT" sort,group,dedup of DS_BATCH_VALID is done twice,
  //but this doesn't seem to have any effect on efficiency (and would add another graph)


  // ============================================================================
  //                UPDATE CLIENT "RAW MONITOR" (IN ORIGINAL FORMAT)
  // ============================================================================
  // monitor file, kept in the original format (for linking back the results of monitoring);
  // effectively, a mirror of client requests stored in production Monitor DB.
  // Production DB (for this client) can be restored from this raw monitor.

  // delete records marked as "delete" or "add, update" (choose distribution or lookup)
  ds_raw_lookup := JOIN (ds_client_raw, DS_BATCH_EXEC,
                         (Left.customer_id = Right.customer_id) AND
                         (Left.record_id = Right.record_id),
                         transform (layouts_BWH.batch_raw, Self := Left),
                         LEFT ONLY, LOOKUP);

  ds_raw_distr := JOIN (DISTRIBUTE (ds_client_raw, HASH(customer_id, record_id)), DS_BATCH_EXEC,
                        (Left.customer_id = Right.customer_id) AND
                        (Left.record_id = Right.record_id),
                        transform (layouts_BWH.batch_raw, Self := Left),
                        LEFT ONLY, LOCAL);

  ds_client_raw_clean := IF (DO_DISTRIBUTE, ds_raw_distr, ds_raw_lookup);

  // append new- and update- records:
  ds_client_updated := ds_client_raw_clean + DS_BATCH_EXEC (request_code != 'D');

  // Check if this subfile already included into main BWH raw, insert, if it is not;
  update_BWH_raw := IF (FileServices.FindSuperFileSubName (Files.Names.BWH_RAW, fnames.raw_qa) < 1,
                        FileServices.AddSuperFile (Files.Names.BWH_RAW, fnames.raw_qa)); 

  act_UpdateRawMonitor := SEQUENTIAL (
    OUTPUT (ds_client_updated, , fnames.raw_file), //for testing use OVERWRITE
    FileServices.PromoteSuperFileList (FileUtils.GetList (fnames.raw_ver), fnames.raw_file, TRUE),
    IF (Environment.INIT_FILES, update_BWH_raw)
  );


  // ============================================================================
  //             NORMALIZE BY ADDRESS AND CLEAN "NEW" RECORDS FROM THIS BATCH
  // ============================================================================
  // 1. Normalize by address (normalization by phone is easier and is done separately);
  // 2. Address-normed file will be used for address STH and for updating monitor DB.
  // 3. Monitor DB needs only addresses from BWH input -- upto 6 records;

  // filter non-cleaned (but we need to keep at lest one); note, no 'D' transactions here
  // !!! IMPORTANT !!! 'seq' is different here: it shows the importance of address within every record
  ds_batch_new_normed := NORMALIZE (DS_BATCH_VALID, 6, Client_BWH.NormalizeToBase (Left, COUNTER)) 
    ((seq = 1) OR (zip5 != '' and st != '' and ((p_city_name != '') or (v_city_name != '')))) : INDEPENDENT;



  // ============================================================================
  //              UPDATE CLIENT SUBFILE IN MONITOR DB
  // ============================================================================
  // Main monitor file: should exist; always current; normalized, cleaned, etc.
  // Consisted of clients' superfiles: we need first to get this client subfile, and then update it's content. 
  ds_submonitor := Files.BWH.ClientMonitor ();

  // delete records marked as "delete" or "add, update" (choose distribution or lookup)
  ds_subm_lookup := JOIN (ds_submonitor, DS_BATCH_EXEC,
                          (Left.customer_id = Right.customer_id) AND
                          (Left.record_id = Right.record_id),
                          transform (layouts.monitor, Self := Left),
                          LEFT ONLY, LOOKUP);

  ds_subm_distr := JOIN (DISTRIBUTE (ds_submonitor, HASH(customer_id, record_id)), DS_BATCH_EXEC,
                         (Left.customer_id = Right.customer_id) AND
                         (Left.record_id = Right.record_id),
                         transform (layouts.monitor, Self := Left),
                         LEFT ONLY, LOCAL); 

  ds_submonitor_clean := IF (DO_DISTRIBUTE, ds_subm_distr, ds_subm_lookup);

  // append new- and update- records
  // in addition: records, which we unable to identify in principle, are not added here (not as with NCO)
  ds_addr_normed := ds_batch_new_normed (executed AND ~IsBatchOutput AND NOT (err & Constants.ERR_CODE.PERSON = Constants.ERR_CODE.PERSON));
  ds_submonitor_new := DEDUP (PROJECT (ds_addr_normed, layouts.monitor), record, all);
  ds_submonitor_updated := ds_submonitor_clean + ds_submonitor_new;

  // Check if this subfile already included into main monitor, insert, if it is not;
  update_main := IF (FileServices.FindSuperFileSubName (Files.Names.MONITOR, fnames.submonitor_qa) < 1,
                     FileServices.AddSuperFile (Files.Names.MONITOR, fnames.submonitor_qa)); 
  
  act_UpdateMonitor := SEQUENTIAL (
    OUTPUT (ds_submonitor_updated, , fnames.submonitor_file),
    FileServices.PromoteSuperFileList (FileUtils.GetList (fnames.submonitor_ver), fnames.submonitor_file, TRUE),
    IF (Environment.INIT_FILES, update_main)
  );



  // ============================================================================
  //                    CREATE SHORT-TERM ADDRESS/PHONE HISTORY
  // ============================================================================
  // Similar to NCO processing, but without deleting/replacing

  // Functions common for both processing BWH input and batch address output
  GetAddressHistoryAction (DATASET (layouts.address_history_ext) addr_to_add) := FUNCTION
    // add to current history
    string qa_name := FileUtils.SetVersion (fnames.sth_address_ver, Environment.QA_NAME);
    ds_addr_hist := Files.BWH.ClientSTHAddress () + addr_to_add;

    //NB: further deduping can be VERY expensive operation, unless history is cleaned in between Monitor runs
    // it looks that duplicates in History is efficiency issue only (Monitor will just use the first entry)

    // Check if this subfile already included into main monitor, insert, if it is not (only first run);
    update_history_addr := IF (FileServices.FindSuperFileSubName (Files.Names.ADDRESS_SHORT_TERM, qa_name) < 1,
                               FileServices.AddSuperFile (Files.Names.ADDRESS_SHORT_TERM, qa_name)); 

    action := SEQUENTIAL (
      OUTPUT (ds_addr_hist, , fnames.sth_address_file),
      FileServices.PromoteSuperFileList (FileUtils.GetList (fnames.sth_address_ver), fnames.sth_address_file, TRUE),
      IF (Environment.INIT_FILES, update_history_addr)
    );
    return action;
  END;

  GetPhoneHistoryAction (DATASET (layouts.phone_history_ext) phone_to_add) := FUNCTION
    // add to current history
    string qa_name := FileUtils.SetVersion (fnames.sth_phone_ver, Environment.QA_NAME);
    ds_phone_hist := Files.BWH.ClientSTHPhone () + phone_to_add;

    // Check if this subfile already included into main monitor, insert, if it is not;
    update_history_phone := IF (FileServices.FindSuperFileSubName (Files.Names.PHONE_SHORT_TERM, qa_name) < 1,
                                FileServices.AddSuperFile (Files.Names.PHONE_SHORT_TERM, qa_name)); 

    action := SEQUENTIAL (
      OUTPUT (ds_phone_hist, , fnames.sth_phone_file),
      FileServices.PromoteSuperFileList (FileUtils.GetList (fnames.sth_phone_ver), fnames.sth_phone_file, TRUE),
      IF (Environment.INIT_FILES, update_history_phone)
    );
    return action;
  END;


  // ------------------------ ADDRESS SHORT TERM ------------------------
  // apply same filter as for 'ds_batch_new_normed' above to filter seq=1 record, if no address is there
  ds_addr_hist_normed := PROJECT (ds_batch_new_normed, layouts.address_history_ext)
    (zip5 != '', st != '', (p_city_name != '') or (v_city_name != ''));
  act_UpdateAddrHistory := GetAddressHistoryAction (UNGROUP (ds_addr_hist_normed));


  // ------------------------ PHONE SHORT TERM ------------------------
  ds_phones_normed := NORMALIZE (DS_BATCH_VALID, 10, Client_BWH.NormalizeToPhoneHist (Left, COUNTER)); 
  act_UpdatePhoneHistory := GetPhoneHistoryAction (UNGROUP (ds_phones_normed));
  


  // ====================================================================================
  //           APPEND SHORT-TERM ADDRESS/PHONE HISTORY files
  // ====================================================================================
  // ------------------------ ADDRESS SHORT TERM ------------------------
  ds_addr := DATASET (fnames.source_thor, layouts.batch_in_address,
                      CSV (heading (0), separator('|'), QUOTE(''), maxlength (1024)));
  ds_addr_hist_append := PROJECT (ds_addr, Client (Constants.ClientID.BWH).FormatBatchAddress (Left, WUID));
  act_AppendAddressHistory := GetAddressHistoryAction (ds_addr_hist_append);

  // ------------------------ PHONE SHORT TERM ------------------------
  ds_phone := DATASET (fnames.source_thor, layouts.batch_in_phone,
                       CSV (heading (0), separator('|'), QUOTE(''), maxlength (1024)));
  ds_phone_hist_append := PROJECT (ds_phone, Client (Constants.ClientID.BWH).FormatBatchPhone (Left, WUID));
  act_AppendPhoneHistory := GetPhoneHistoryAction (ds_phone_hist_append);



  // ============================================================================
  //                    STORE AND DESPRAY REPORT
  // ============================================================================
  // add current report to report DB
  ds_report := Files.BWH.Report; // can be empty

  current_report := DATASET (fnames.verified, layouts.batch_report, CSV (separator('|'), maxlength (16384)));
  ds_report_updated := ds_report + current_report;

  // Check if this subfile already included into main BWH report, insert, if it is not;
  update_BWH_report := IF (FileServices.FindSuperFileSubName (Files.Names.BWH_Report, fnames.report_qa) < 1,
                           FileServices.AddSuperFile (Files.Names.BWH_Report, fnames.report_qa)); 

  // send "this-batch" report to landing zone
  act_despray_report := FileServices.Despray (fnames.verified, 
                                              Environment.LandingZone.ip, 
                                              Environment.LandingZone.reportPath + fnames.report_despray,
                                              , , , Environment.ALLOW_OVERWRITE  // timeout, espserversourceIPport, maxConnections, no overwrites
  ) : FAILURE (FileServices.sendemail ('vmyullyari@seisint.com', 'monitoring: despray report failure: ' + WUID, failmessage));

  act_UpdateReport := SEQUENTIAL (
    OUTPUT (ds_report_updated, , fnames.report_file),
    FileServices.PromoteSuperFileList (FileUtils.GetList (fnames.report_ver), fnames.report_file, TRUE),
    IF (Environment.INIT_FILES, update_BWH_report)//,
//    act_despray_report
  );


  // ============================================================================
  //                    RUNNABLES
  // ============================================================================
  // Make a choice depending on a file type (customer input, batch -address, -phone, -property, etc.)
  // if no '_' found, then assume customer-input file
  file_descriptor := stringlib.StringToUpperCase (FileUtils.GetFileSuffix (fileName));

  boolean ProcessAddress := (file_descriptor = 'ADDRESS');
  boolean ProcessPhone   := (file_descriptor = 'PHONES');

  init := PARALLEL (
    FileUtils.CreateSuperFile (Monitoring.Files.Names.MONITOR, true),
    if (ProcessAddress, FileUtils.CreateSuperFile (Monitoring.Files.Names.ADDRESS_SHORT_TERM, true)),
    if (ProcessPhone, FileUtils.CreateSuperFile (Monitoring.Files.Names.PHONE_SHORT_TERM, true)),
    FileUtils.CreateSuperFile (Monitoring.Files.Names.BWH_RAW, true),
    FileUtils.CreateSuperFile (Monitoring.Files.Names.BWH_ARCHIVE, true),
    FileUtils.CreateSuperFile (Monitoring.Files.Names.BWH_REPORT, true)
  );

  // check if updates actually done (files will be updated only if records are changed OR in case of errors (not found, etc.))
  boolean ProcessSpray := file_descriptor != 'RELASSOC'; // ignore it.
  boolean ProcessBatch := ProcessSpray AND EXISTS (ds_batch_in) : INDEPENDENT;
  boolean IsUpdated    := ProcessSpray AND (COUNT_EXECUTABLE > 0);

  _process := SEQUENTIAL (
    // OUTPUT (ds_batch_in, named ('ds_batch_in')),
    // OUTPUT (ds_current_batch, named ('ds_current_batch')),
    // OUTPUT (batch_verified, named ('batch_verified')),
    // OUTPUT (DS_BATCH_VALID, named ('DS_BATCH_VALID')),
    // OUTPUT (ds_batch_new_normed, named ('ds_batch_new_normed')),
    // OUTPUT (ds_submonitor_new, named ('ds_submonitor_new')),
    // OUTPUT (ds_addr_hist_new, named ('ds_addr_hist_new'), ALL),
    // OUTPUT (ds_phone_hist_new, named ('ds_phone_hist_new'), ALL),

    IF (ProcessBatch, act_UpdateArchieve),
    IF (ProcessBatch, act_writeBatchReport),
    IF (IsUpdated, sequential (act_UpdateRawMonitor, act_UpdateMonitor, act_UpdateAddrHistory, act_UpdatePhoneHistory)),
    IF (ProcessBatch, act_UpdateReport),
    OUTPUT (FileUtils.GetJobLog (fnames), NAMED ('BWH_FILES'))
  );

  action := SEQUENTIAL (
    IF (Environment.INIT_FILES, init), // generally, required for the first run only
    IF (do_spray AND ProcessSpray, act_sprayFile),
    MAP (ProcessAddress => act_AppendAddressHistory, 
         ProcessPhone => act_AppendPhoneHistory, 
         _process)
  ) : FAILURE (FileServices.sendemail (Environment.MAIL_LIST, 'BWH Monitor Update failure: ' + WUID, failmessage));
  return action;
END;