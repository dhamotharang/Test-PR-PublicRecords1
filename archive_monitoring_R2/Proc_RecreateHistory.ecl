#workunit('name','NCO recreate short term history')
import address, standard;

EXPORT Proc_RecreateHistory (string6 nco_id) := FUNCTION
  string THIS_WUID := thorlib.wuid ();
  string vendor_dir := Monitoring.Files.NAMES.THOR_ROOT + 'NCO::NCO_' + nco_id + '::';
  string fname_addr_st  := vendor_dir + 'arhived_sth_address_' + THIS_WUID;
  string fname_phone_st := vendor_dir + 'arhived_sth_phone_' + THIS_WUID;

  // Get current archive for this source
  ds_archive := Files.NCO.ClientArchive (nco_id);
  // example of using backup archive
  ds_archive_backup := DATASET (
    '~thor_data400::monitoring::nco::backup::archive_' + nco_id + '_w20080115-180745', layouts_NCO.batch_raw, THOR);
  ds_client_archive := DISTRIBUTE (ds_archive + ds_archive_backup, hash32 (record_id)) (request_code != 'D');

  // get current raw monitor for this source
  ds_client_raw := DISTRIBUTE (Files.NCO.ClientRaw (nco_id), hash32 (record_id)); 

  ds_current := JOIN (ds_client_archive, ds_client_raw,
                      Left.record_id = Right.record_id,
                      transform (layouts_NCO.batch_raw, Self := Left),
                      LIMIT (1), LOCAL);

  DS_BATCH_NEW := Client_NCO.VerifyBatch (ds_current, ds_client_raw);

  // NORMALIZE BY ADDRESS AND CLEAN "NEW" RECORDS FROM THIS BATCH
  // filter non-cleaned records
  ds_batch_new_normed := NORMALIZE (DS_BATCH_NEW, 9, Client_NCO.NormalizeToBase (Left, COUNTER)) 
    (zip5 != '' and st != '' and ((p_city_name != '') or (v_city_name != '')));

  // ------------------------ ADDRESS SHORT TERM ------------------------
  ds_addr_pr := PROJECT (ds_batch_new_normed, layouts.address_history_ext);
    
  // dedup, making preferences to addresses from batch
  ds_addr_hist_new := 
     DEDUP (SORT (ds_addr_pr,
            customer_id, record_id, prim_range, predir, prim_name, addr_suffix, postdir, unit_desig, sec_range,
            p_city_name, v_city_name, st, zip5, zip4, name_first, name_middle, name_last, name_suffix, 
            seq),
            customer_id, record_id, prim_range, predir, prim_name, addr_suffix, postdir, unit_desig, sec_range,
            p_city_name, v_city_name, st, zip5, zip4, name_first, name_middle, name_last, name_suffix);
  act_WriteAddressHistory := OUTPUT (ds_addr_hist_new, , fname_addr_st);


  // ------------------------ PHONE SHORT TERM ------------------------
  ds_phones_normed := NORMALIZE (DS_BATCH_NEW, 22, Client_NCO.NormalizeToPhoneHist (Left, COUNTER)) (phone10 != '');
  ds_phone_pr := PROJECT (ds_phones_normed, layouts.phone_history_ext);

  // dedup, making preferences to phones from batch
  ds_phone_hist_new := DEDUP (SORT (ds_phone_pr, 
                         customer_id, record_id, phone10, name_first, name_middle, name_last, name_suffix, seq),
                         customer_id, record_id, phone10, name_first, name_middle, name_last, name_suffix); 
  act_WritePhoneHistory := OUTPUT (ds_phone_hist_new, , fname_phone_st);

  action := SEQUENTIAL (
    act_WriteAddressHistory,
    act_WritePhoneHistory
  );

  return action;
END;