import Monitoring;

#workunit ('priority', 'high');
Env := Monitoring.Environment;
THIS_WUID := thorlib.wuid ();


string nco_id := 'RP1980';
#workunit ('name', 'NCO: Fix blank area/worksource for ' + nco_id);

string area := nco_id [1..3];
string worksource := nco_id [4..6];

ds_raw :=  Monitoring.Files.NCO.ClientRaw (nco_id) : independent;
// ds_raw :=  dataset (
  // '~production_watch_thor::monitoring::nco::nco_p2b929::dlp2b929_20100722_1_appended_monitor_raw_w20100722-075502',
                    // monitoring.layouts_nco.batch_raw, THOR) : independent;

monitoring.layouts_nco.batch_raw FixID (monitoring.layouts_nco.batch_raw L) := transform
  // Self.nco_server := if (L.nco_server = '', area, L.nco_server);
  // Self.work_source_id := if (L.work_source_id = '', worksource, L.work_source_id);
  // replace no matter what
  Self.nco_server := area;
  Self.work_source_id := worksource;
  Self := L; 
end;

ds_res := project (ds_raw, FixID (Left));
output (choosen (ds_raw, 100), named ('raw'));
output (choosen (ds_res, 100), named ('result'));

// create a file: similar to Monitoring.Proc_NCO_UpdateBase

string vendor_dir := Monitoring.Files.NAMES.THOR_ROOT + 'NCO::NCO_' + nco_id + '::';
string fname_raw_version := vendor_dir + '@version@::' + Monitoring.Files.NAMES.RAW;
string fname_raw := vendor_dir + 'fix_blank_id_raw_' + THIS_WUID;

ds_info := dataset ([
  {'records in ' + nco_id, (string) count (ds_raw)},
  {'records with no server/worksource', (string) count (ds_raw (nco_server = '' or work_source_id = ''))},
  {'records with different server/worksource', 
    (string) count (ds_raw ((nco_server != '' and nco_server != area) or 
                            (work_source_id != '' and work_source_id != worksource)))},
  {'super file', fname_raw_version},
  {'logical file', fname_raw}
], {string32 info, string128 value});

act_UpdateRawMonitor := SEQUENTIAL (
  OUTPUT (ds_res, , fname_raw),
  Monitoring.FileUtils.MoveSuperFiles (fname_raw_version, fname_raw, true),  // update superfiles
  output (ds_info, named ('log'))
);
act_UpdateRawMonitor;