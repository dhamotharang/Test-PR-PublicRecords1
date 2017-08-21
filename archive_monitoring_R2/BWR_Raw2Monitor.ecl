#workunit('name','NCO Append Records Raw-Sub')
string6 nco_id := 'Z';
/*
these were processed at 05.09.2008 (a bug was fixed, concerning "is executed" flag)
N01030 //     130 added
N01037 //       7
N01059 //     580
N01063 //     326
N02031 //     201
N02032 //      21
N02034 //   1,836
N02067 //     914
N02068 //       0
N020DE //       1
N03033 //   8,520
N03051 //  32,282
N04035 //  20,950
N06002 //  14,331
N06010 //   2,214
N06099 // 306,663
N07003 //  20,822
N07012 //   7,276
N07013 //       1
N07022 //  37,462
N07016 //       4
N07017 // 552,861 (W20080509-162655)
N07018 //       0
N07019 //   1,100
N07064 //  89,046
N07066 //       1
N09023 //   4,658
N09061 //      58
U14046 //      46
U14055 //  36,539
U15007 //  17,310 
U15009 // 202,766
U15011 //   6,130
U15015 //   4,610
U15027 //  34,925
U15072 //  31,739
U15080 //   7,096
U15081 //  20,162
U21038 //   7,060
U21039 //      30
U21041 //       3
U22050 //       0
U22056 //   3,033
U230JJ //   1,114
U24005 //      76
U99004 //   1,975
*/
string WUID := thorlib.wuid ();

  // this prefix will define all the files for "this" NCO-site: archive, raw, submonitor...
  string vendor_dir := Monitoring.Files.NAMES.THOR_ROOT + 'NCO::NCO_' + nco_id + '::';

  // get current raw monitor (also used in the next section)
  ds_client_raw := Monitoring.Files.NCO.ClientRaw (nco_id); // can be empty (for instance, in the first run)
  ds_submonitor := Monitoring.Files.NCO.ClientMonitor (nco_id); // empty in the first run

  ds_miss := JOIN (DISTRIBUTE (ds_client_raw, HASH (record_id)), DISTRIBUTE (ds_submonitor, HASH (record_id)),
                   Left.record_id = Right.record_id,
                   transform (Monitoring.layouts_NCO.batch_raw, Self := Left),
                   LEFT ONLY, LOCAL);

  Monitoring.layouts_NCO.verification SetValidation (Monitoring.layouts_NCO.batch_raw L) := TRANSFORM
    Self.executed := true;
    Self := L;
    Self := [];
  END;
  DS_BATCH_VALID := PROJECT (ds_miss, SetValidation (Left));


  // ============================================================================
  //             NORMALIZE BY ADDRESS AND CLEAN "NEW" RECORDS FROM THIS BATCH
  // ============================================================================
  // filter non-cleaned (but we need to keep at lest one); note, no 'D' transactions here
  // !!! IMPORTANT !!! 'seq' is different here: it shows the importance of address within every record
  ds_batch_new_normed := NORMALIZE (DS_BATCH_VALID, 3, Monitoring.Client_NCO.NormalizeToBase (Left, COUNTER)) 
    ((seq = 1) OR (zip5 != '' and st != '' and ((p_city_name != '') or (v_city_name != '')))) : INDEPENDENT;


  // ============================================================================
  //              UPDATE CLIENT SUBFILE IN MONITOR DB
  // ============================================================================
  // Main monitor file: should exist; always current; normalized, cleaned, etc.
  // Consisted of clients' superfiles: we need first to get this client subfile, and then update it's content. 
  string fname_submonitor_version := vendor_dir + '@version@::' + Monitoring.Files.NAMES.SUBMONITOR;
  string fname_submonitor := vendor_dir + 'submonitor_add_raw_' + WUID;

  // append new- and update- records:
  ds_submonitor_new := DEDUP (PROJECT (ds_batch_new_normed (executed AND ~IsBatchOutput), Monitoring.layouts.monitor), record, all);
  ds_submonitor_updated := ds_submonitor + ds_submonitor_new;

  act_UpdateMonitor := SEQUENTIAL (
    OUTPUT (ds_submonitor_updated, , fname_submonitor),
    Monitoring.FileUtils.MoveSuperFiles (fname_submonitor_version, fname_submonitor, true)
  );

new_count := count (ds_submonitor_new);
output (new_count, named ('new_count'));
//output (count (DS_BATCH_VALID), named ('diff'));

IF (new_count > 0, act_UpdateMonitor);

// output (DS_BATCH_VALID, NAMED ('DS_BATCH_VALID'));
// output (ds_batch_new_normed, NAMED ('ds_batch_new_normed'));
// output (ds_submonitor_new, NAMED ('ds_submonitor_new'));


