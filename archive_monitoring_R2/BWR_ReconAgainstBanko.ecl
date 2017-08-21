// WARNING: it is not clear how to link against Banko: by account_identifier OR "after-dash" part.
#WORKUNIT ('name', 'recon against Banko');
// Makes a recon against Banko accounts. 
// This is not a complete recon: the only thing it does it removes records 
// from THOR Monitor DB, which are not present in Banko. Transactions made AFTER banko 
// unique accounts were created, generally should be re-processed after this recon.
// Only RAW and MONITOR files are affected.

string THIS_WUID := thorlib.wuid ();

// custom settings: NCO id, landing zone, name of the file containing Banko unique accounts, etc.
string6 nco_id := 'zzz'; //like, 'N07012'

string vendor_dir := Monitoring.Files.NAMES.THOR_ROOT + 'NCO::NCO_' + nco_id + '::';
string fname_banko_accounts := 'NC' + nco_id + '_AccountNumbers.txt'; // like, 'N07012_AccountNumbers.txt';
string fname_src_in := Monitoring.Environment.LandingZone.RootPath + '/U15007/' + fname_banko_accounts;
string file_accounts_in := Monitoring.Files.NAMES.THOR_ROOT + fname_banko_accounts;


// ----------------------------------------------------
// spray Banko unique accoutns to THOR
act_sprayFile := FileServices.SprayVariable (
  Monitoring.Environment.LandingZone.ip, fname_src_in, 32,,,, 
  Monitoring.Environment.GROUP_NAME, file_accounts_in, 
  ,,, FALSE,, // ALLOWOVERWRITE, change, if needed
);

// read file just sprayed
layout_account := RECORD
  string24 record_id; //account_identifier;
END;
ds_banko_in := DATASET (file_accounts_in, layout_account, CSV (separator('|'), maxlength (32)));

ds_banko := PROJECT (ds_banko_in, transform (layout_account, Self.record_id := Monitoring.Client_NCO.GetID (Left.record_id)));
ds_banko_distr := DISTRIBUTE (ds_banko, HASH32 (record_id)) : INDEPENDENT;

// ----------------------------------------------------
// RAW MONITOR: keep only those RAW records which exist in both Banko and Thor
ds_raw := Monitoring.Files.NCO.ClientRaw (nco_id);
ds_raw_distr := DISTRIBUTE (ds_raw, HASH32 (record_id));

string fname_raw_version := vendor_dir + '@version@::monitor_raw';
string fname_raw := vendor_dir + 'banko_recon_monitor_raw_' + THIS_WUID;

ds_save_raw := JOIN (ds_raw_distr, ds_banko_distr,
                     Left.record_id = Right.record_id,
                     transform (RECORDOF (ds_raw_distr), Self := Left),
                     LOCAL);

// ----------------------------------------------------
// SUBMONITOR: keep only those MONITOR records which exist in both Banko and Thor
ds_monitor := Monitoring.Files.NCO.ClientMonitor (nco_id);
ds_monitor_distr := DISTRIBUTE (ds_monitor, HASH32 (record_id));

string fname_submonitor_version := vendor_dir + '@version@::submonitor';
string fname_submonitor := vendor_dir + 'banko_recon_submonitor_' + THIS_WUID;

ds_save_mon := JOIN (ds_monitor_distr, ds_banko_distr,
                     Left.record_id = Right.record_id,
                     transform (RECORDOF (ds_monitor_distr), Self := Left),
                     LOCAL);

// ----------------------------------------------------
// STAT: check what records were deleted, etc.
ds_deleted := JOIN (ds_raw_distr, ds_banko_distr,
                    Left.record_id = Right.record_id,
                    transform (RECORDOF (ds_raw_distr), Self := Left),
                    LEFT ONLY, LOCAL);

// check what WUID deleted records belong to
layout_wu := RECORD
  string64 wu := ds_deleted.wuid;
  unsigned cnt := count (GROUP);
END;
ds_stat := TABLE (ds_deleted, layout_wu, wuid);


// ======================== ACTIONS ========================
do_check := SEQUENTIAL (
  OUTPUT (ds_deleted, NAMED ('deleted')),
  OUTPUT (count (ds_deleted), NAMED ('delete_count')),
  OUTPUT (SORT (ds_stat, -cnt), NAMED ('delete_wuids'))
);

do_recon := SEQUENTIAL (
  OUTPUT (ds_save_raw, , fname_raw),
  OUTPUT (ds_save_mon, , fname_submonitor),
  Monitoring.FileUtils.MoveSuperFiles (fname_raw_version, fname_raw, true),
  Monitoring.FileUtils.MoveSuperFiles (fname_submonitor_version, fname_submonitor, true)
);


//1. backup, if desired:
// Monitoring.Tools.BackupNCORaw (nco_id, 'rbanko');
// Monitoring.Tools.BackupNCOMonitor (nco_id, 'rbanko');

//2. Usually, it's convenient to spray Banko accounts file in advance
// act_sprayFile;

//3. just some numbers; it's always better to check the stat first and then decide if recon is required
// do_check;  

//4. Recon
// do_recon; // real recon: files are created as "qa" version.

