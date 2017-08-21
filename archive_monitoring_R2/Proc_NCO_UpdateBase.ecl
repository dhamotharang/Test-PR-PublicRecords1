#workunit('name','NCO Monitor Update')
//#WORKUNIT ('priority', 'high')

unsigned2 LOOKUP_THRESHOLD := 1000; //record limit, if exceeded distribution will be used
FS := FileServices;

// NCO input file name format:
// VVWWWXXX_CCYYMMDD_Nnnn
  // VV = File Type: NB=New Business, AH=Ad-hoc, DL=Del, UP=Update, RC=Reconciliation file
	// WWW = NCO Server Identifier;	XXX = NCO Worksource ID
	// CCYYMMDD = Date/Time Stamp; 	Nnnn = Sequence number  or Time Stamp (1-4 chars)
EXPORT Proc_NCO_UpdateBase (string vendorName, string fileName, boolean do_spray = true) := FUNCTION

  string WUID := thorlib.wuid ();
	string targetFileName := FileUtils.GetFileNameShort (fileName); // file name without extension
  string file_in_name := Files.NAMES.THOR_ROOT + 'in::' + vendorName + '::' + targetFileName;

  // this prefix will define all the files for "this" NCO-site: archive, raw, submonitor...
  string6 nco_id := stringlib.StringToUpperCase (targetFileName [3..8]); // this is server + worksource
  string vendor_dir := Files.NAMES.THOR_ROOT + vendorName + '::NCO_' + nco_id + '::';


  // ============================================================================
  //                    SPRAY BATCH 
  // ============================================================================
  fname_src := Environment.LandingZone.sourcePath + vendorName + '/' + fileName;

  act_sprayFile := FileServices.SprayVariable (
    Environment.LandingZone.ip, fname_src, 16384, '|',,',', // maxrecordsize,  srcCSVseparator, srcCSVterminator, srcCSVquote
    Environment.GROUP_NAME, file_in_name, 
    ,,, Environment.ALLOW_OVERWRITE,, //timeout, espserverIPport, maxConnections, ALLOWOVERWRITE, replicate, compress
  );

  // read file just sprayed
  ds_batch_in := DATASET (file_in_name, layouts_NCO.batch, CSV (separator('|'), QUOTE(''), maxlength (16384)));


  // ============================================================================
  //               APPEND TRANSACTIONS TO AN ARCHIVE (history) FILE 
  // ============================================================================
  // For every client all batch requests are kept in a "batch history" file (archive);
  // Current (or any cutoff date) monitor state for this client -- submonitor -- can be restored from this file, 
  // using date-time stamp. Archive can be shrinked from time to time to save space.

  string fname_archive_version := vendor_dir + '@version@::' + Files.NAMES.ARCHIVE;
  string fname_archive := vendor_dir + targetFileName + '_archive_' + WUID;
  string qa_name_archive := FileUtils.SetVersion (fname_archive_version, Environment.QA_NAME);

  // Assign internal id for every record (linking monitoring results back to input records, updating address short term history, etc.)
  layouts_NCO.batch_raw AssignId (layouts_NCO.batch L) := TRANSFORM
    // IMPORTANT: customer_id + record_id should be unique across ALL clients
    SELF.customer_id := Constants.ClientID.NCO + '_' + nco_id;
    SELF.record_id := Client_NCO.GetID (L.account_identifier);
    SELF.wuid := WUID; // save it for tracking purposes

    SELF := L;
  END;
  ds_current_batch := PROJECT (ds_batch_in, AssignId (Left));

  // read current history (create superfiles, if no exist)
  ds_archive := Files.NCO.ClientArchive (nco_id);
  ds_archive_updated := ds_archive + ds_current_batch;

  // Check if this subfile already included into main NCO raw, insert, if it is not;
  update_NCO_archive := IF (FS.FindSuperFileSubName (Files.Names.NCO_ARCHIVE, qa_name_archive) < 1,
                            FS.AddSuperFile (Files.Names.NCO_ARCHIVE, qa_name_archive)); 

  act_UpdateArchieve := SEQUENTIAL (
    IF (Environment.INIT_FILES, FileUtils.CreateAllSuperFiles (fname_archive_version, true)),
    OUTPUT (ds_archive_updated, , fname_archive),
    FileUtils.MoveSuperFiles (fname_archive_version, fname_archive, true), //qa -> father, etc.
    IF (Environment.INIT_FILES, update_NCO_archive)
  );


  // ============================================================================
  //                  VERIFY BATCH, SELECT RECORDS GROUPS 
  // ============================================================================
  // new assumption: input file can have several requests for the same object (defined by record_id)
  string fname_verified := vendor_dir + 'verified_batch'; 

  // get current raw monitor (also used in the next section)
  ds_client_raw := Files.NCO.ClientRaw (nco_id); // can be empty (for instance, in the first run)

  // check input validity
  batch_verified := Client_NCO.VerifyBatch (ds_current_batch, ds_client_raw) : INDEPENDENT;
  act_writeBatchReport := OUTPUT (PROJECT (batch_verified, layouts.batch_report), , fname_verified, CSV (separator('|'), terminator('\n')), OVERWRITE);

  // raw and client monitor need executable records only;
  ds_exec := PROJECT (batch_verified (executed), layouts_NCO.batch_raw);
  COUNT_EXECUTABLE := COUNT (ds_exec) : INDEPENDENT;
  boolean DO_DISTRIBUTE := COUNT_EXECUTABLE > LOOKUP_THRESHOLD;
  DS_BATCH_EXEC := IF (DO_DISTRIBUTE, DISTRIBUTE (ds_exec, HASH(customer_id, record_id)), ds_exec) : INDEPENDENT;

  // STH files need all valid transactions (coming after last 'Delete', if any)
  ds_valid := batch_verified (~Client_NCO.IsFatalError (err)); // DISTRIBUTE?
  ds_grp := GROUP (SORT (ds_valid, record_id, ~(request_code = 'D'), seq), record_id);
  ds_ddp := DEDUP (ds_grp, (Left.seq > Right.seq)); // this will leave atmost first D plus later add/updates
  DS_BATCH_VALID := ds_ddp (request_code != 'D');   // remove first 'D', if any


  // ============================================================================
  //                UPDATE CLIENT "RAW MONITOR" (IN ORIGINAL FORMAT)
  // ============================================================================
  // "this client" monitor file, kept in the original format (for linking back the results of monitoring);
  // effectively, a mirror of client requests stored in production Monitor DB, but non-normalized and not cleaned.
  // Production DB (for this client) can be restored from this raw monitor.

  string fname_raw_version := vendor_dir + '@version@::' + Files.NAMES.RAW;
  string fname_raw := vendor_dir + targetFileName + '_monitor_raw_' + WUID;
  string qa_name_raw := FileUtils.SetVersion (fname_raw_version, Environment.QA_NAME);

  // delete records marked as "delete" or "add, update" (choose distribution or lookup)
  ds_raw_lookup := JOIN (ds_client_raw, DS_BATCH_EXEC,
                         (Left.customer_id = Right.customer_id) AND
                         (Left.record_id = Right.record_id),
                         transform (layouts_NCO.batch_raw, Self := Left),
                         LEFT ONLY, LOOKUP);

  ds_raw_distr := JOIN (DISTRIBUTE (ds_client_raw, HASH(customer_id, record_id)), DS_BATCH_EXEC,
                        (Left.customer_id = Right.customer_id) AND
                        (Left.record_id = Right.record_id),
                        transform (layouts_NCO.batch_raw, Self := Left),
                        LEFT ONLY, LOCAL);

  ds_client_raw_clean := IF (DO_DISTRIBUTE, ds_raw_distr, ds_raw_lookup);

  // append new- and update- records:
  ds_client_updated := ds_client_raw_clean + DS_BATCH_EXEC (request_code != 'D');

  // Check if this subfile already included into main NCO raw, insert, if it is not;
  update_NCO_raw := IF (FS.FindSuperFileSubName (Files.Names.NCO_RAW, qa_name_raw) < 1,
                        FS.AddSuperFile (Files.Names.NCO_RAW, qa_name_raw)); 

  act_UpdateRawMonitor := SEQUENTIAL (
    IF (Environment.INIT_FILES, FileUtils.CreateAllSuperFiles (fname_raw_version, true)),
    OUTPUT (ds_client_updated, , fname_raw), //for testing use OVERWRITE
    FileUtils.MoveSuperFiles (fname_raw_version, fname_raw, true),  // update superfiles
    IF (Environment.INIT_FILES, update_NCO_raw)
  );


  // ============================================================================
  //             NORMALIZE BY ADDRESS AND CLEAN "NEW" RECORDS FROM THIS BATCH
  // ============================================================================
  // 1. Normalize by address (normalization by phone is easier and is done separately);
  // 2. Address-normed file will be used for address STH and for updating monitor DB.
  // 3. Monitor DB needs only addresses from NCO input -- upto 3 records;

  // filter non-cleaned (but we need to keep at lest one); note, no 'D' transactions here
  // !!! IMPORTANT !!! 'seq' is different here: it shows the importance of address within every record
  ds_batch_new_normed := NORMALIZE (DS_BATCH_VALID, 9, Client_NCO.NormalizeToBase (Left, COUNTER)) 
    ((seq = 1) OR (zip5 != '' and st != '' and ((p_city_name != '') or (v_city_name != '')))) : INDEPENDENT;


  // ============================================================================
  //              UPDATE CLIENT SUBFILE IN MONITOR DB
  // ============================================================================
  // Main monitor file: should exist; always current; normalized, cleaned, etc.
  // Consisted of clients' superfiles: we need first to get this client subfile, and then update it's content. 
  string fname_submonitor_version := vendor_dir + '@version@::' + Files.NAMES.SUBMONITOR;
  string fname_submonitor := vendor_dir + 'submonitor_' + WUID;
  string qa_name_submonitor := FileUtils.SetVersion (fname_submonitor_version, Environment.QA_NAME);
  ds_submonitor := Files.NCO.ClientMonitor (nco_id);

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

  // append new- and update- records:
  ds_submonitor_new := DEDUP (PROJECT (ds_batch_new_normed (executed AND ~IsBatchOutput), layouts.monitor), record, all);
  ds_submonitor_updated := ds_submonitor_clean + ds_submonitor_new;

  // Check if this subfile already included into main monitor, insert, if it is not;
  update_main := IF (FS.FindSuperFileSubName (Files.Names.MONITOR, qa_name_submonitor) < 1,
                     FS.AddSuperFile (Files.Names.MONITOR, qa_name_submonitor)); 
  
  act_UpdateMonitor := SEQUENTIAL (
    IF (Environment.INIT_FILES, FileUtils.CreateAllSuperFiles (fname_submonitor_version, true)), // create if not exist
    OUTPUT (ds_submonitor_updated, , fname_submonitor),
    FileUtils.MoveSuperFiles (fname_submonitor_version, fname_submonitor, true),
    IF (Environment.INIT_FILES, update_main)
  );


  // ============================================================================
  //                    CREATE SHORT-TERM ADDRESS/PHONE HISTORY
  // ============================================================================
  // Both address and phone STH are shared -- have same layout -- for all clients;
  // Prevents sending back to a customer data (address/phone) it already has
  //   (customer's portion of batch request, LN's portion)
  // 1. STH is normalized by address (already done above) and phone;
  // 2. Monitor is responsible for cleaning those files every time it runs;
  // 3. records are appended, not replaced (as in raw or monitor). Only "D" records are removed;

  // ------------------------ ADDRESS SHORT TERM ------------------------
  string fname_addr_st_version := vendor_dir + '@version@::' + Files.NAMES.STH_ADDRESS;
  string fname_addr_st := vendor_dir + targetFileName + '_address_' + WUID;
  string qa_name_addr := FileUtils.SetVersion (fname_addr_st_version, Environment.QA_NAME);

  // current short term history: address
  ds_addr_hist_current := Files.NCO.ClientSTHAddress (nco_id);

  ds_addr_hist_lookup := JOIN (ds_addr_hist_current, DS_BATCH_EXEC (request_code = 'D'),
                               (Left.customer_id = Right.customer_id) AND
                               (Left.record_id = Right.record_id),
                               transform (layouts.address_history_ext, Self := Left),
                               LEFT ONLY, LOOKUP);

  ds_addr_hist_distr := JOIN (DISTRIBUTE (ds_addr_hist_current, HASH(customer_id, record_id)), DS_BATCH_EXEC (request_code = 'D'),
                              (Left.customer_id = Right.customer_id) AND
                              (Left.record_id = Right.record_id),
                              transform (layouts.address_history_ext, Self := Left),
                              LEFT ONLY, LOCAL);

  ds_addr_hist_clean := IF (DO_DISTRIBUTE, ds_addr_hist_distr, ds_addr_hist_lookup);

  // apply same filter as for 'ds_batch_new_normed' above to filter seq=1 record, if no address is there
  ds_addr_pr := PROJECT (ds_batch_new_normed, layouts.address_history_ext)
    (zip5 != '', st != '', (p_city_name != '') or (v_city_name != ''));

  // dedup, making preferences to addresses from batch
  ds_addr_hist_new := 
          DEDUP (SORT (ds_addr_pr,
            customer_id, record_id, prim_range, predir, prim_name, addr_suffix, postdir, unit_desig, sec_range,
            p_city_name, v_city_name, st, zip5, zip4, name_first, name_middle, name_last, name_suffix, 
            seq),
            customer_id, record_id, prim_range, predir, prim_name, addr_suffix, postdir, unit_desig, sec_range,
            p_city_name, v_city_name, st, zip5, zip4, name_first, name_middle, name_last, name_suffix);
  
  ds_addr_hist := ds_addr_hist_clean + ds_addr_hist_new;

  //NOTE on further deduping: this can be VERY expensive operation, unless history is cleaned in between Monitor runs
  // it looks that duplicates in History is efficiency issue only (Monitor will just find the first entry)

  act_updateHistorySubfile := OUTPUT (ds_addr_hist, , fname_addr_st);

  // Check if this subfile already included into main monitor, insert, if it is not (only first run);
  update_history_addr := IF (FS.FindSuperFileSubName (Files.Names.ADDRESS_SHORT_TERM, qa_name_addr) < 1,
                             FS.AddSuperFile (Files.Names.ADDRESS_SHORT_TERM, qa_name_addr)); 

  act_UpdateAddrHistory := SEQUENTIAL (
    IF (Environment.INIT_FILES, FileUtils.CreateAllSuperFiles (fname_addr_st_version, true)), // create if not exist
    act_updateHistorySubfile,
    FileUtils.MoveSuperFiles (fname_addr_st_version, fname_addr_st, true),
    IF (Environment.INIT_FILES, update_history_addr)
  );


  // ------------------------ PHONE SHORT TERM ------------------------
  string fname_phone_st_version := vendor_dir + '@version@::' + Files.NAMES.STH_PHONE;
  string fname_phone_st := vendor_dir + targetFileName + '_phone_' + WUID;
  string qa_name_phone := FileUtils.SetVersion (fname_phone_st_version, Environment.QA_NAME);

  ds_phones_normed := NORMALIZE (DS_BATCH_VALID, 22, Client_NCO.NormalizeToPhoneHist (Left, COUNTER)); 

  ds_phone_hist_current := Files.NCO.ClientSTHPhone (nco_id);

  // delete records marked as "delete"
  ds_phone_hist_lookup := JOIN (ds_phone_hist_current, DS_BATCH_EXEC (request_code = 'D'),
                               (Left.customer_id = Right.customer_id) AND
                               (Left.record_id = Right.record_id),
                               transform (layouts.phone_history_ext, Self := Left),
                               LEFT ONLY, LOOKUP);

  ds_phone_hist_distr := JOIN (DISTRIBUTE (ds_phone_hist_current, HASH(customer_id, record_id)), DS_BATCH_EXEC (request_code = 'D'),
                               (Left.customer_id = Right.customer_id) AND
                               (Left.record_id = Right.record_id),
                               transform (layouts.phone_history_ext, Self := Left),
                               LEFT ONLY, LOCAL);

  ds_phone_hist_clean := IF (DO_DISTRIBUTE, ds_phone_hist_distr, ds_phone_hist_lookup);

  // dedup, making preferences to phones from batch
  ds_phone_hist_new := DEDUP (SORT (ds_phones_normed, 
                         customer_id, record_id, phone10, name_first, name_middle, name_last, name_suffix, seq),
                         customer_id, record_id, phone10, name_first, name_middle, name_last, name_suffix); 
  
  ds_phone_hist := ds_phone_hist_clean + ds_phone_hist_new;
  act_updatePhoneSubfile := OUTPUT (ds_phone_hist, , fname_phone_st);

  // Check if this subfile already included into main monitor, insert, if it is not;
  update_history_phone := IF (FS.FindSuperFileSubName (Files.Names.PHONE_SHORT_TERM, qa_name_phone) < 1,
                              FS.AddSuperFile (Files.Names.PHONE_SHORT_TERM, qa_name_phone)); 

  act_UpdatePhoneHistory := SEQUENTIAL (
    IF (Environment.INIT_FILES, FileUtils.CreateAllSuperFiles (fname_phone_st_version, true)), // create if not exist
    act_updatePhoneSubfile,
    FileUtils.MoveSuperFiles (fname_phone_st_version, fname_phone_st, true),
    IF (Environment.INIT_FILES, update_history_phone)
  );


  // ============================================================================
  //                    STORE AND DESPRAY REPORT
  // ============================================================================
  // file names
  string fname_report_version := vendor_dir + '@version@::' + Files.NAMES.REPORT;
  string fname_report         := vendor_dir + targetFileName + '_report_' + WUID;
  string fname_despray_report := vendorName + '/' + targetFileName + '_REPORT_' + WUID + '.CSV';
  string qa_name_report := FileUtils.SetVersion (fname_report_version, Environment.QA_NAME);

  // add current report to report DB
  ds_report := Files.NCO.ClientReport (nco_id); // can be empty

  current_report := DATASET (fname_verified, layouts.batch_report, CSV (separator('|'), maxlength (16384)));
  ds_report_updated := ds_report + current_report;

  // Check if this subfile already included into main NCO report, insert, if it is not;
  update_NCO_report := IF (FS.FindSuperFileSubName (Files.Names.NCO_Report, qa_name_report) < 1,
                           FS.AddSuperFile (Files.Names.NCO_Report, qa_name_report)); 

  // send "this-batch" report to landing zone
  act_despray_report := FileServices.Despray (fname_verified, 
                                              Environment.LandingZone.ip, 
                                              Environment.LandingZone.reportPath + fname_despray_report, 
                                              , , , Environment.ALLOW_OVERWRITE  // timeout, espserversourceIPport, maxConnections, no overwrites
  ) : FAILURE (FileServices.sendemail ('vmyullyari@seisint.com', 'monitoring: despray report failure: ' + WUID, failmessage));

  act_UpdateReport := SEQUENTIAL (
    IF (Environment.INIT_FILES, FileUtils.CreateAllSuperFiles (fname_report_version, true)),
    OUTPUT (ds_report_updated, , fname_report),
    FileUtils.MoveSuperFiles (fname_report_version, fname_report, true), //qa -> father, etc.
    IF (Environment.INIT_FILES, update_NCO_report)//,
//    act_despray_report
  );


  // ============================================================================
  //                    RUNNABLES
  // ============================================================================

  ds_filenames := DATASET ([
    {'WUID', WUID}, 
    {'(input) vendor name', vendorName}, 
    {'(input) fileName', fileName}, 
    {'file_in_name', file_in_name}, 
    {'vendor_dir', vendor_dir}, 
    {'batch in', fname_src}, 

    {'monitor', Files.Names.MONITOR}, 
    {'address history super',  Files.Names.ADDRESS_SHORT_TERM}, 
    {'phone history super',  Files.Names.PHONE_SHORT_TERM}, 
    {'archive NCO', Files.Names.NCO_ARCHIVE}, 
    {'archive super', qa_name_archive}, 
    {'archive subfile', fname_archive}, 
    {'monitor raw',  Files.Names.NCO_RAW}, 
    {'monitor raw super', qa_name_raw}, 
    {'monitor raw subfile', fname_raw}, 
    {'submonitor super', qa_name_submonitor}, 
    {'submonitor subfile', fname_submonitor}, 
    {'address history super',   fname_addr_st_version}, 
    {'address history subfile', fname_addr_st}, 
    {'phone history super',   fname_phone_st_version}, 
    {'phone history subfile', fname_phone_st}, 
    {'report NCO', Files.Names.NCO_REPORT},
    {'report super', qa_name_report},
    {'report subfile', fname_report},
    {'report despray', fname_despray_report} 
  ], {string32 name, string128 value});
  
  init := PARALLEL (
    FileUtils.CreateSuperFile (Monitoring.Files.Names.MONITOR, true),
    FileUtils.CreateSuperFile (Monitoring.Files.Names.ADDRESS_SHORT_TERM, true),
    FileUtils.CreateSuperFile (Monitoring.Files.Names.PHONE_SHORT_TERM, true),
    FileUtils.CreateSuperFile (Monitoring.Files.Names.NCO_RAW, true),
    FileUtils.CreateSuperFile (Monitoring.Files.Names.NCO_ARCHIVE, true),
    FileUtils.CreateSuperFile (Monitoring.Files.Names.NCO_REPORT, true)
  );

  // check if updates actually done (files will be updated only if records are changed OR in case of errors (not found, etc.))
  string2 fprefix := StringLib.StringToUpperCase (fileName[1..2]);
  boolean ProcessSpray := (fprefix != 'AH') and (fprefix != 'WH'); //ad-hoc and warehouse (to avoid possible errs)
  boolean ProcessBatch := ProcessSpray AND EXISTS (ds_batch_in) : INDEPENDENT;
  boolean IsUpdated    := ProcessSpray AND (COUNT_EXECUTABLE > 0);
  action := SEQUENTIAL (
    // init,
    IF (do_spray AND ProcessSpray, act_sprayFile),
    IF (ProcessBatch, act_UpdateArchieve),
    IF (ProcessBatch, act_writeBatchReport),
    IF (IsUpdated, act_UpdateRawMonitor),
    IF (IsUpdated, act_UpdateMonitor),
    IF (IsUpdated, act_UpdateAddrHistory),
    IF (IsUpdated, act_UpdatePhoneHistory),
    IF (ProcessBatch, act_UpdateReport),
//    OUTPUT (batch_verified, NAMED ('batch_verified')),
    OUTPUT (ds_filenames, NAMED ('FILES'))
  ) : FAILURE (FileServices.sendemail (Environment.MAIL_LIST, 'NCO Monitor Update failure: ' + WUID, failmessage));

  // action := PARALLEL (
    // OUTPUT (ds_current_batch, named ('ds_current_batch')),
    // OUTPUT (batch_verified, named ('batch_verified')),
    // OUTPUT (DS_BATCH_VALID, named ('DS_BATCH_VALID')),
    // OUTPUT (ds_submonitor_new, named ('ds_submonitor_new')),
    // OUTPUT (ds_filenames, NAMED ('FILES'))
  // );

  return action;
END;