IMPORT Monitoring, ut;
// ===================================================================
// ================ SEND RESULTS IN DIFFERENT FORMATS ================
// ===================================================================
#workunit ('name', 'building custom NCO files');
// #workunit ('name', 'FirstRun for NCO N03033');

#WORKUNIT ('priority', 'high')
string current_date := ut.GetDate;
string CID := Monitoring.COnstants.ClientID.NCO;

// input file name: 
string fname_in := 'WHN00000_20080415_0600_THOR.CSV'; // fake file name
string6 nco_id := fname_in [3..8];
string fname_monitor := Monitoring.Files.NAMES.RESULT_DIR + 'nco::' + fname_in; // monitor results

// output:
target_ip   := Monitoring.Environment.LandingZone.ip;
target_path := Monitoring.Environment.LandingZone.RootPath + 'FirstRun/' + CID + '/';
string fname_csv  := fname_in[1..22] + '_TEST_' + current_date + '.CSV';
string fname_thor := Monitoring.Files.Names.RESULT_DIR + 'nco::' + fname_csv;


// monitor results and current raw file
ds_results := DATASET (fname_monitor, Monitoring.layouts_NCO.monitor_result, CSV (separator('|'), maxlength (16384)));
raw_file := Monitoring.Files.NCO.ClientRaw (nco_id);

// some records in the result file may have no server_id and worksource.
// therefore, splitting it into 2 files (more paranoical approach)
res_complete := ds_results ((nco_server != '') and work_source_id != '');
res_fuzzy := ds_results ((nco_server = '') or (work_source_id = ''));

Monitoring.layouts_NCO.batch setFields (Monitoring.layouts_NCO.monitor_result L, Monitoring.layouts_NCO.batch_raw R) := TRANSFORM
  SELF.request_code := 'W';
  SELF.response_code := '1';
  SELF.HitCodes := 'EG';
  SELF := L;
  SELF.ssn := R.ssn;
  SELF := [];
END;
ds_fuzzy := JOIN (res_fuzzy, raw_file,
                  (Left.account_identifier = Right.account_identifier),
                  setFields (Left, Right),
                  ATMOST (1));
ds_complete := JOIN (ds_results, raw_file,
                     ('NCO_' + Left.nco_server + Left.work_source_id = Right.customer_id) AND
                     (Left.account_identifier = Right.account_identifier),
                     setFields (Left, Right),
                     ATMOST (1));

ds_res := ds_fuzzy + ds_complete;
// output (ds_results, NAMED ('ds_results'));
// output (raw_file, NAMED ('raw_file'));
// output (ds_res, NAMED ('ds_res'));
// output (count (ds_res), NAMED ('count'));

Send_banko := SEQUENTIAL (
  OUTPUT (ds_res, , fname_thor, CSV (separator('|'), terminator('\n')), OVERWRITE);
  FileServices.Despray (fname_thor, target_ip, target_path + fname_csv));

Send_thor  := FileServices.Despray (fname_monitor, target_ip, target_path + fname_in);

// THIS IS TO MANUALLY BUILD AND SEND RESULT FILES.
// MODIFY Monitoring.Client_NCO BEFORE RUNNING THIS:
//   1) Use appropriate output name in JoinAndDespray (for instanse, "..._THOR_SCORE.CSV:);
//   2) Comment out all not-necessary calls of JoinAndDespray;
//   3) use appropriate LandingZone.ip and target path below;
Send_auto  := Monitoring.Client_NCO.SendMonitorResults (
  monitoring.File_Address_Out,
  monitoring.File_Phone_Out,
  monitoring.File_Address_History,
  Monitoring.Environment.LandingZone.ip,
  Monitoring.Environment.LandingZone.RootPath + 'FirstRun/'
);

Send_banko;
//Send_auto;
//Send_thor;



// CUSTOM SEND
target_ip_2 :=  'batchdev01.br.seisint.com';
fname_res_thor := '~production_watch_thor::monitoring::result::cps::cps_20090107_phones.txt';
fname := '/batchshare/THORMonitoring/FirstRun/CPS/CPS_20090107_PHONES.TXT';
act_despr := FileServices.Despray (fname_res_thor, target_ip_2, fname, , , , TRUE);

// or using custom results
phone_new := DATASET ('~thor_data400::base::monitoring_phone_out_patchedw20090107-000634',
                      Monitoring.layout_phone_out, thor, opt);
addr_hist := DATASET ('~thor_data400::base::monitoring_address_historyw20090107-000634',
                      Monitoring.Layout_Address_History, thor, opt);
act_send_phones := parallel (
  Monitoring.Client_CPS.SendPhone (phone_new, addr_hist, target_ip_2, '/batchshare/THORMonitoring/FirstRun/'),
  Monitoring.Client_FFC.SendPhone (phone_new, addr_hist, target_ip_2, '/batchshare/THORMonitoring/FirstRun/'));

// act_despr;
// act_send_phones;

