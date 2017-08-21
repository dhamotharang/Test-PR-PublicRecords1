import Address;

unsigned2 LOOKUP_THRESHOLD := 5000; //record limit, if exceeded distribution will be used
Env := Monitoring.Environment;
ERRC := Constants.ERR_CODE;

// fileName    -- file containing request(s) to process
// do_spray    -- if false, no spraying is done (assuming input file already exists in THOR)
EXPORT _UpdateBase (string fileName, boolean do_spray = true, Monitoring.IClient cli) := FUNCTION

  // customer_id -- a unique "name" for a customer: defines directories, file locations, methods
  string customer_id := cli.customer_id;

  string WUID := thorlib.wuid ();
  fnames := FileUtils.GetUpdateJobFileNames (cli.customer_id, fileName, WUID);


  // ============================================================================
  //                    SPRAY CLIENT INPUT or BATCH OUTPUT files
  // ============================================================================
  // Assuming file-by-file processing (customer input, batch addresses, etc. come in separate files).
  act_sprayFile := FileServices.SprayVariable (
    Env.LandingZone.ip, fnames.source_lz, 16384, '|',,',', // maxrecordsize,  separator, terminator, quote
    Env.GROUP_NAME, fnames.source_thor,,,, Env.ALLOW_OVERWRITE,, 
  );

  // read customer input file just sprayed
  ds_request := DATASET (fnames.source_thor, layouts.batch_in_customer, CSV (separator('|'), QUOTE(''), maxlength (16384)));


  // ============================================================================
  //               APPEND TRANSACTIONS TO AN ARCHIVE (history) FILE 
  // ============================================================================
  // For every client all requests are kept in a "history" file (archive); current (or any cutoff date) 
  // monitor state for this client -- submonitor -- can be restored from it, using date-time stamp. 
  // Archive can be shrinked from time to time to save space and improve efficiency.

  // Assign internal id for every record
  layouts.batch_raw AssignId (layouts.batch_in_customer L) := TRANSFORM
    // IMPORTANT: customer_id + record_id should be unique across ALL clients
    Self.customer_id := customer_id;
    Self.record_id := cli.GetID (L.rec.UniqueID_1, L.rec.UniqueID_2, L.rec.UniqueID_3);
    Self.request_code := L.request_code;
    Self.wuid := WUID; // save it for tracking purposes

    // monitor needs parsed name, so I need to parse it, if not done by customer or batch
    boolean doParse := (trim (L.name_first) = '' or trim (L.name_last) = '') AND (trim (L.full_name) != '');
 
    // parse full name    
    clean_name := Address.CleanPersonFML73 (L.full_name); // or Address.CleanPersonFML73
    parsed_first  := clean_name[6..25];
    parsed_middle := clean_name[26..45];
    parsed_last   := clean_name[46..65];
    parsed_suffix := clean_name[66..70];

    Self.name_first  := if (doParse, parsed_first,  L.name_first);
    Self.name_middle := if (doParse, parsed_middle, L.name_middle);
    Self.name_last   := if (doParse, parsed_last,   L.name_last);
    Self.name_suffix := if (doParse, parsed_suffix, L.name_suffix);

    SELF := L;
  END;
  ds_current_request := PROJECT (ds_request, AssignId (Left));

  // read current history (create superfiles, if no exist)
  ds_archive := Files.ClientArchive (customer_id);
  ds_archive_updated := ds_archive + ds_current_request;

  // Check if this subfile already included into main raw; insert, if it is not;
  parent_archive := fnames.customer_dir + Files.Names.ARCHIVE;
  update_archive := IF (FileServices.FindSuperFileSubName (parent_archive, fnames.archive_qa) < 1,
                        FileServices.AddSuperFile (parent_archive, fnames.archive_qa)); 

  act_UpdateArchieve := SEQUENTIAL (
    OUTPUT (ds_archive_updated, , fnames.archive_file),
    FileServices.PromoteSuperFileList (FileUtils.GetList (fnames.archive_ver), fnames.archive_file, TRUE),
    IF (Environment.INIT_FILES, update_archive)
  );


  // ============================================================================
  //                  VERIFY BATCH, SELECT RECORDS GROUPS 
  // ============================================================================
  // NB: input file can have several requests for the same object (defined by record_id)

  // get current raw monitor (also used in the next section)
  ds_client_raw := Files.ClientRaw (customer_id); // can be empty (for instance, in the first run)

  // check input validity
  request_verified := cli.VerifyBatch (ds_current_request, ds_client_raw) : INDEPENDENT;

  // save batch report
  layouts.batch_report FormatReport (layouts.verification L) := transform
    Self := L;
    Self := []; // account_identifier, transaction_id
  end;
  act_writeRequestReport := OUTPUT (PROJECT (request_verified, FormatReport (Left)), , fnames.verified, CSV (separator('|'), terminator('\n')), OVERWRITE);

  // raw and client monitor need executable records only;
  ds_exec := PROJECT (request_verified (executed), layouts.batch_raw);
  COUNT_EXECUTABLE := COUNT (ds_exec) : INDEPENDENT;
  boolean DO_DISTRIBUTE := COUNT_EXECUTABLE > LOOKUP_THRESHOLD;
  DS_REQUEST_EXEC := IF (DO_DISTRIBUTE, DISTRIBUTE (ds_exec, HASH(customer_id, record_id)), ds_exec) : INDEPENDENT;

  // STH files need all valid transactions (coming after last 'Delete', if any)
  ds_valid := request_verified (~cli.IsFatalError (err)); // DISTRIBUTE?
  ds_grp := GROUP (SORT (ds_valid, record_id, ~(request_code = 'D'), seq), record_id);
  ds_ddp := DEDUP (ds_grp, (Left.seq > Right.seq)); // this will leave atmost first D plus later add/updates
  DS_REQUEST_VALID := ds_ddp (request_code != 'D');   // remove first 'D', if any


  // ============================================================================
  //                UPDATE CLIENT "RAW MONITOR" (IN ORIGINAL FORMAT)
  // ============================================================================
  // monitor file, kept in the original format (for linking back the results of monitoring);
  // effectively, a mirror of client requests stored in production Monitor DB.
  // Production DB (for this client) can be restored from this raw monitor.

  // delete records marked as "delete" or "add, update" (choose distribution or lookup)
  ds_raw_lookup := JOIN (ds_client_raw, DS_REQUEST_EXEC,
                         (Left.record_id = Right.record_id),
                         transform (layouts.batch_raw, Self := Left),
                         LEFT ONLY, LOOKUP);

  ds_raw_distr := JOIN (DISTRIBUTE (ds_client_raw, HASH(customer_id, record_id)), DS_REQUEST_EXEC,
                        (Left.record_id = Right.record_id),
                        transform (layouts.batch_raw, Self := Left),
                        LEFT ONLY, LOCAL);

  ds_client_raw_clean := IF (DO_DISTRIBUTE, ds_raw_distr, ds_raw_lookup);

  // append new- and update- records:
  ds_client_updated := ds_client_raw_clean + DS_REQUEST_EXEC (request_code != 'D');

  // Check if this subfile already included into main raw; insert, if it is not;
  parent_raw := fnames.customer_dir + Files.Names.RAW;
  update_raw := IF (FileServices.FindSuperFileSubName (parent_raw, fnames.raw_qa) < 1,
                        FileServices.AddSuperFile (parent_raw, fnames.raw_qa)); 

  act_UpdateRawMonitor := SEQUENTIAL (
    OUTPUT (ds_client_updated, , fnames.raw_file), //for testing use OVERWRITE
    FileServices.PromoteSuperFileList (FileUtils.GetList (fnames.raw_ver), fnames.raw_file, TRUE),
    IF (Environment.INIT_FILES, update_raw)
  );


  // ============================================================================
  //                             NORMALIZE ADDRESS
  // ============================================================================
  // Up to 12 input address; at most 3 will be used for identification purposes, 
  // and at least one should be left here (iven if address is invalid).
  // Note, no 'DELETE' transactions at this point
  ds_address_normed := NORMALIZE (DS_REQUEST_VALID, if (cli.MAX_INPUT_ADDRESSES = 0, 1, cli.MAX_INPUT_ADDRESSES),
                                  cli.NormalizeByAddress (Left, COUNTER))
                         ((seq = 1) OR (zip5 != '' and st != '' and ((p_city_name != '') or (v_city_name != '')))) : INDEPENDENT;

  // ============================================================================
  //                    UPDATE CLIENT SUBFILE IN MONITOR DB
  // ============================================================================
  // Main monitor file should exist, be current, normalized, cleaned, etc. Contains clients' superfiles.
  ds_submonitor := Files.ClientMonitor (customer_id);

  // delete records marked as "delete" or "add, update" (choose distribution or lookup)
  ds_subm_lookup := JOIN (ds_submonitor, DS_REQUEST_EXEC,
                          (Left.record_id = Right.record_id),
                          transform (layouts.monitor, Self := Left),
                          LEFT ONLY, LOOKUP);

  ds_subm_distr := JOIN (DISTRIBUTE (ds_submonitor, HASH(customer_id, record_id)), DS_REQUEST_EXEC,
                         (Left.record_id = Right.record_id),
                         transform (layouts.monitor, Self := Left),
                         LEFT ONLY, LOCAL); 

  ds_submonitor_clean := IF (DO_DISTRIBUTE, ds_subm_distr, ds_subm_lookup);

  // combine new- and update- records
  // NB: records, which we unable to identify in principle, are not added here
  ds_addr_normed := ds_address_normed (executed AND NOT 
         ((err & ERRC.PERSON = ERRC.PERSON) or (err & ERRC.REQUEST_TYPE = ERRC.REQUEST_TYPE)));

  ds_submonitor_new := DEDUP (PROJECT (ds_addr_normed, layouts.monitor), record_id, KEEP (3));
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
  //                 CREATE SHORT-TERM ADDRESS/PHONE/ETC. HISTORY
  // ============================================================================

  // Functions common for both processing customer input and batch address/phone/etc. real-time output
  GetAddressHistoryAction (DATASET (layouts.address_history_ext) addr_to_add) := FUNCTION
    // add to current history
    ds_addr_hist := Files.ClientSTHAddress (customer_id) + addr_to_add;

    //NOTE on further deduping: this can be VERY expensive operation, unless history is cleaned in between Monitor runs
    // it looks that duplicates in History is efficiency issue only (Monitor will just find the first entry)

    // Check if this subfile already included into main monitor, insert, if it is not (only first run);
    update_history_addr := IF (FileServices.FindSuperFileSubName (Files.Names.ADDRESS_SHORT_TERM, fnames.sth_address_qa) < 1,
                               FileServices.AddSuperFile (Files.Names.ADDRESS_SHORT_TERM, fnames.sth_address_qa)); 

    action := SEQUENTIAL (
      OUTPUT (ds_addr_hist, , fnames.sth_address_file),
      FileServices.PromoteSuperFileList (FileUtils.GetList (fnames.sth_address_ver), fnames.sth_address_file, TRUE),
      IF (Environment.INIT_FILES, update_history_addr)
    );
    return action;
  END;

  GetPhoneHistoryAction (DATASET (layouts.phone_history_ext) phone_to_add) := FUNCTION
    ds_phone_hist := Files.ClientSTHPhone (customer_id) + phone_to_add;

    // Check if this subfile already included into main monitor, insert, if it is not;
    update_history_phone := IF (FileServices.FindSuperFileSubName (Files.Names.PHONE_SHORT_TERM, fnames.sth_phone_qa) < 1,
                                FileServices.AddSuperFile (Files.Names.PHONE_SHORT_TERM, fnames.sth_phone_qa)); 

    action := SEQUENTIAL (
      OUTPUT (ds_phone_hist, , fnames.sth_phone_file),
      FileServices.PromoteSuperFileList (FileUtils.GetList (fnames.sth_phone_ver), fnames.sth_phone_file, TRUE),
      IF (Environment.INIT_FILES, update_history_phone)
    );
    return action;
  END;

  // ------------------------ ADDRESS SHORT TERM ------------------------
  // apply same filter as for 'ds_address_normed' above to filter seq=1 record, if no address is there
  ds_addr_hist_new := PROJECT (ds_address_normed, layouts.address_history_ext)
    (zip5 != '', st != '', (p_city_name != '') or (v_city_name != ''));
  act_UpdateAddrHistory := GetAddressHistoryAction (UNGROUP (ds_addr_hist_new));

  // ------------------------ PHONE SHORT TERM ------------------------
  ds_phones_normed := NORMALIZE (DS_REQUEST_VALID, cli.MAX_INPUT_PHONES, cli.NormalizeByPhone (Left, COUNTER));
  act_UpdatePhoneHistory := GetPhoneHistoryAction (UNGROUP (ds_phones_normed));
  


  // ====================================================================================
  // ====================================================================================
  //           APPEND SHORT-TERM ADDRESS/PHONE/etc. FROM REAL-TIME BATCH 
  // ====================================================================================
  // ====================================================================================
  // ------------------------ ADDRESS SHORT TERM ------------------------
  // read file just sprayed
  ds_batch_address := DATASET (fnames.source_thor, layouts.batch_in_address, 
                               CSV (heading (0), separator('|'), QUOTE(''), maxlength (4096)));

  // TODO: check if we need to test batch for validity
  ds_addr_hist_append := PROJECT (ds_batch_address, cli.FormatBatchAddress (Left, WUID)); 
  act_AppendAddressHistory := GetAddressHistoryAction (ds_addr_hist_append);


  // ------------------------ PHONE SHORT TERM ------------------------
  // read file just sprayed
  ds_batch_phone := DATASET (fnames.source_thor, layouts.batch_in_phone, 
                             CSV (heading (0), separator('|'), QUOTE(''), maxlength (4096)));

  // TODO: check if we need to test batch for validity
  ds_phone_hist_append := PROJECT (ds_batch_phone, cli.FormatBatchPhone (Left, WUID)); 
  act_AppendPhoneHistory := GetPhoneHistoryAction (ds_phone_hist_append);



  // ------------------------ PROPERTY SHORT TERM ------------------------
  // read file just sprayed
  ds_batch_prop := DATASET (fnames.source_thor, layouts.batch_in_property,
                            CSV (heading (0), separator('|'), QUOTE('\"'), maxlength (4096)));

  ds_prop_new := PROJECT (ds_batch_prop, cli.FormatBatchProperty (Left, WUID));
  ds_prop_hist := Files.ClientSTHProperty (customer_id) + ds_prop_new;

  // Check if this subfile already included into main monitor, insert, if it is not;
  update_history_prop := IF (FileServices.FindSuperFileSubName (Files.Names.PROPERTY_SHORT_TERM, fnames.sth_prop_qa) < 1,
                             FileServices.AddSuperFile (Files.Names.PROPERTY_SHORT_TERM, fnames.sth_prop_qa)); 

  act_AppendPropertyHistory := SEQUENTIAL (
    OUTPUT (ds_prop_hist, , fnames.sth_prop_file),
    FileServices.PromoteSuperFileList (FileUtils.GetList (fnames.sth_prop_ver), fnames.sth_prop_file, TRUE),
    IF (Environment.INIT_FILES, update_history_prop)
  );


  // ------------------------ PEOPLE AT WORK SHORT TERM ------------------------
  // read file just sprayed
  ds_batch_paw := DATASET (fnames.source_thor, layouts.batch_in_paw, 
                           CSV (heading (0), separator('|'), QUOTE('\"'), maxlength (4096)));

  ds_paw_new := PROJECT (ds_batch_paw, cli.FormatBatchPaw (Left, WUID));
  ds_paw_hist := Files.ClientSTHPaw (customer_id) + ds_paw_new;

  // Check if this subfile already included into main monitor, insert, if it is not;
  update_history_paw := IF (FileServices.FindSuperFileSubName (Files.Names.PAW_SHORT_TERM, fnames.sth_paw_qa) < 1,
                            FileServices.AddSuperFile (Files.Names.PAW_SHORT_TERM, fnames.sth_paw_qa)); 

  act_AppendPawHistory := SEQUENTIAL (
    OUTPUT (ds_paw_hist, , fnames.sth_paw_file),
    FileServices.PromoteSuperFileList (FileUtils.GetList (fnames.sth_paw_ver), fnames.sth_paw_file, TRUE),
    // IF (Environment.INIT_FILES, FileUtils.CreateAllSuperFiles (fname_paw_st_version, true)), // create if not exist
    // FileUtils.MoveSuperFiles (fname_paw_st_version, fname_paw_st, true),
    IF (Environment.INIT_FILES, update_history_paw)
  );

  // ============================================================================
  //                    STORE AND DESPRAY REPORT
  // ============================================================================
  // add current report to report DB
  ds_report := Files.ClientReport (customer_id); // can be empty

  current_report := DATASET (fnames.verified, layouts.batch_report, CSV (separator('|'), maxlength (16384)));
  ds_report_updated := ds_report + current_report;

  // Check if this subfile already included into main report; insert, if it is not;
  parent_report := fnames.customer_dir + Files.Names.REPORT;
  update_report := IF (FileServices.FindSuperFileSubName (parent_report, fnames.report_qa) < 1,
                       FileServices.AddSuperFile (parent_report, fnames.report_qa)); 

  // send "this-batch" report to landing zone
  act_SendReport := FileServices.Despray (fnames.verified, 
                                          Environment.LandingZone.ip, 
                                          Environment.LandingZone.reportPath + fnames.report_despray, 
                                          , , , Environment.ALLOW_OVERWRITE  // timeout, espserversourceIPport, maxConnections, no overwrites
  ) : FAILURE (FileServices.sendemail ('vmyullyari@seisint.com', 'monitoring: despray report failure: ' + WUID, failmessage));

  act_UpdateReport := SEQUENTIAL (
    OUTPUT (ds_report_updated, , fnames.report_file),
    FileServices.PromoteSuperFileList (FileUtils.GetList (fnames.report_ver), fnames.report_file, TRUE),
    IF (Environment.INIT_FILES, update_report)//,
    // act_SendReport
  );


  // ============================================================================
  //                    RUNNABLES
  // ============================================================================
  // Make a choice depending on a file type (customer input, batch -address, -phone, -property, etc.)
  // if no '_' found, then assume customer-input file

  boolean ProcessAddress := (cli.MAX_OUTPUT_ADDRESS > 0) and (fnames.file_descriptor = 'ADDRESS');
  boolean ProcessPhone   := (cli.MAX_OUTPUT_PHONE > 0)   and (fnames.file_descriptor = 'PHONES');
  boolean ProcessProp    := (cli.MAX_OUTPUT_PROP > 0)    and (fnames.file_descriptor = 'PROP');
  boolean ProcessPaw     := (cli.MAX_OUTPUT_PAW > 0)     and (fnames.file_descriptor = 'PAW');

  init := PARALLEL (
    FileUtils.CreateSuperFile (Monitoring.Files.Names.MONITOR, true),
    if (ProcessAddress, FileUtils.CreateSuperFile (Monitoring.Files.Names.ADDRESS_SHORT_TERM, true)),
    if (ProcessPhone, FileUtils.CreateSuperFile (Monitoring.Files.Names.PHONE_SHORT_TERM, true)),
    if (ProcessProp, FileUtils.CreateSuperFile (Monitoring.Files.Names.PROPERTY_SHORT_TERM, true)),
    if (ProcessPaw, FileUtils.CreateSuperFile (Monitoring.Files.Names.PAW_SHORT_TERM, true)),
    FileUtils.CreateSuperFile (parent_raw, true),
    FileUtils.CreateSuperFile (parent_archive, true),
    FileUtils.CreateSuperFile (parent_report, true)
  );

  // check if updates actually done (files will be updated only if records are changed OR in case of errors (not found, etc.))
  boolean ProcessSpray := fnames.file_descriptor != 'RELASSOC'; // ignore it.
  boolean ProcessBatch := ProcessSpray AND EXISTS (ds_request) : INDEPENDENT;
  boolean IsUpdated    := ProcessSpray AND (COUNT_EXECUTABLE > 0);

  _process := SEQUENTIAL (
    // output (ds_request, named ('ds_request')), 
    IF (ProcessBatch, act_UpdateArchieve),
    IF (ProcessBatch, act_writeRequestReport),
    IF (IsUpdated, sequential (act_UpdateRawMonitor, act_UpdateMonitor, act_UpdateAddrHistory, act_UpdatePhoneHistory)),
    IF (ProcessBatch, act_UpdateReport),
    OUTPUT (FileUtils.GetJobLog (fnames), named (customer_id + '_FILES'), EXTEND)
  );

  action := SEQUENTIAL (
    IF (Env.INIT_FILES, init), // generally, required for the first run only
    IF (do_spray AND ProcessSpray, act_sprayFile),
    MAP (ProcessAddress => act_AppendAddressHistory,
         ProcessPhone => act_AppendPhoneHistory,
         ProcessProp => act_AppendPropertyHistory,
         ProcessPaw => act_AppendPawHistory,
         _process)
  ) : FAILURE (FileServices.sendemail (Environment.MAIL_LIST, customer_id + ' monitor update failure: ' + WUID, failmessage));
  return action;

END;