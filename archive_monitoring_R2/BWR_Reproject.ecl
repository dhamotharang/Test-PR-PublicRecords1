/*
  Rather formal, but important layout change, which allows to avoid some code redundancy;
  WUID is forced to be in standard LN layouts and moved to the first position
*/

// list of NCO directories (ordered by record numbers in raw file)
/*
NCO::NCO_N07012
NCO::NCO_N06099
NCO::NCO_N07022
NCO::NCO_N07013
NCO::NCO_N07017
NCO::NCO_U15009
NCO::NCO_N07064
NCO::NCO_U21038
NCO::NCO_N06002
NCO::NCO_U14055
NCO::NCO_N03051
NCO::NCO_N07019
NCO::NCO_N07003
NCO::NCO_U15027
NCO::NCO_N07018
NCO::NCO_N04035
NCO::NCO_N03033
NCO::NCO_N020DE
NCO::NCO_U22050
NCO::NCO_U15072
NCO::NCO_U15011
NCO::NCO_N09023
NCO::NCO_U99004
NCO::NCO_N09061
NCO::NCO_N02031
NCO::NCO_U15015
NCO::NCO_U230JJ
NCO::NCO_U21039
NCO::NCO_U15080
NCO::NCO_N02068
NCO::NCO_P2B426
NCO::NCO_N02034
NCO::NCO_U15007
NCO::NCO_N01063
NCO::NCO_U24005
NCO::NCO_N02067
NCO::NCO_N01030
NCO::NCO_U15081
NCO::NCO_N07016
NCO::NCO_U14046
NCO::NCO_N07066
NCO::NCO_U22056
NCO::NCO_N01059
NCO::NCO_N02032
NCO::NCO_N01037
NCO::NCO_N06010
NCO::NCO_U21041
*/

string client_id := 'NCO::NCO_N00000';

#WORKUNIT ('name', 'NCO maintanance: add wuid to ID, ' + client_id);
IMPORT standard;

// =========================================================================================
// NEW LAYOUTS (Monitoring.layouts and Monitoring.layouts_NCO should be replaced with these)
// =========================================================================================
new := MODULE
  export id := RECORD
    string10 customer_id;
    string30 record_id;
  end;

  export wid := RECORD
    string16 wuid;
    id;
  end;

  export address_history := record
    wid;
    Monitoring.layouts.address_slim;
    string6 addr_dt_last_seen;
    string6 addr_dt_first_seen; 
    string2 src;
    unsigned1 best_address_count;
    standard.Name_Slim; // do we need name?
    string8 addr_version_number;
  end;

  // the purpose is to temporarily save addresses from both customer and batch parts of the batch request;
  export address_history_ext := RECORD (address_history)
    unsigned1 seq;         // "importance" of this address for this account
    boolean IsBatchOutput; // specifies if this address comes from batch portion
  end;

  // same for the phones
  export phone_history := record
    wid;
    string10  phone10;
    string8   phone_dt_last_seen;
    string8   phone_dt_first_seen;
    standard.Name_Slim;
    string2   phone_type;
    string1   dual_name_flag;
    string3   listing_type;
    string1   publish_code;  
    string30  carrier_name;
    string25  carrier_city;
    string2   carrier_state;
    string8   phone_version_number; 
    unsigned1 best_phone_number;
  end;

  export phone_history_ext := RECORD (phone_history)
    unsigned1 seq;         // "importance" of this phone for this account (not used so far)
    boolean IsBatchOutput; // specifies if this address comes from batch portion
  end;

  // Main internal layout
  export monitor := RECORD
    wid;
    standard.Name_Slim;
    string9   ssn;
    string8   dob;
    string10  phoneno;
    Monitoring.layouts.address_slim; 
    unsigned1 glb_purpose;
    unsigned1 dppa_purpose;
    boolean   market_restriction;
    string8   addr_version_number;
    string8   phone_version_number;
    string1   transaction_type; //change to boolean is_new_record;

    unsigned1 best_address_number; // number of "new found" address(es) to return (client's specific)
    unsigned1 best_phone_number;   // number of "new found" phone(s)
    boolean   phone_level_ta;
    boolean   phone_level_tb;
    boolean   phone_level_td;
    boolean   phone_level_tg;
    boolean   phone_level_other1; // not used, reserved for future needs
    boolean   phone_level_other2; // ...
    boolean   phone_level_other3; // ...

    string1   frequency_type; //so far only day, week, month
    unsigned2 frequency_time;
    string1   delay_type;
    unsigned2 delay_time;
  end;

  export batch_report := RECORD
    wid;  // internal LN monitoring id
    string1  request_code;
    // 2 custom-specific ID fields (originally provided to accomodate NCO needs)
    string24 account_identifier;
    string65 transaction_id;
    Monitoring.layouts.error_report;
  end;
END;

string WUID := thorlib.wuid ();
vendor_dir := Monitoring.Files.Names.THOR_ROOT + client_id + '::';
vendor_dir_ver := vendor_dir + '@version@::';

fname_monitor := vendor_dir + 'reproject_id_monitor_' + WUID;
fname_address := vendor_dir + 'reproject_id_address_' + WUID;
fname_phone   := vendor_dir + 'reproject_id_phone_' + WUID;
fname_report  := vendor_dir + 'reproject_id_report_' + WUID;


// ==================== MONITOR ====================
ds_monitor := Monitoring.Files.ClientMonitor (client_id);
ds_monitor_new := PROJECT (ds_monitor, new.monitor);
act_monitor := SEQUENTIAL (
  OUTPUT (ds_monitor_new, , fname_monitor);
  Monitoring.FileUtils.MoveSuperFiles (vendor_dir_ver + Monitoring.Files.NAMES.SUBMONITOR, fname_monitor, true)
); 

// ==================== STH Address ====================
ds_address := Monitoring.Files.ClientSTHAddress (client_id);
ds_address_new := PROJECT (ds_address, new.address_history_ext);

act_address := SEQUENTIAL (
  OUTPUT (ds_address_new, , fname_address);
  Monitoring.FileUtils.MoveSuperFiles (vendor_dir_ver + Monitoring.Files.NAMES.STH_ADDRESS, fname_address, true)
); 

// ==================== STH Phone ====================
ds_phone := Monitoring.Files.ClientSTHPhone (client_id);
ds_phone_new := PROJECT (ds_phone, new.phone_history_ext);

act_phone := SEQUENTIAL (
  OUTPUT (ds_phone_new, , fname_phone);
  Monitoring.FileUtils.MoveSuperFiles (vendor_dir_ver + Monitoring.Files.NAMES.STH_PHONE, fname_phone, true)
); 

// ==================== REPORT ====================
ds_report := Monitoring.Files.ClientReport (client_id);
ds_report_new := PROJECT (ds_report, new.batch_report);
act_report := SEQUENTIAL (
  OUTPUT (ds_report_new, , fname_report);
  Monitoring.FileUtils.MoveSuperFiles (vendor_dir_ver + Monitoring.Files.NAMES.REPORT, fname_report, true)
); 

act_pring_after := PARALLEL ( 
  OUTPUT (choosen (ds_monitor_new, 100), NAMED ('ds_submon_new')), OUTPUT (ds_report_new, NAMED ('ds_report_new')),
  OUTPUT (choosen (ds_address_new, 100), NAMED ('ds_address_new')), OUTPUT (ds_phone_new, NAMED ('ds_phone_new'))
);

SEQUENTIAL (act_monitor, act_address, act_phone, act_report);


/*
#WORKUNIT ('name', 'PRA maintanance: turn on P@W');
IMPORT ut;

client_id := monitoring.Constants.ClientID.PRA;
string WUID := thorlib.wuid ();

vendor_dir := Monitoring.Files.Names.THOR_ROOT + client_id + '::';
vendor_dir_ver := vendor_dir + '@version@::';

fname_monitor := vendor_dir + 'reproject_paw_submonitor_' + WUID;

//output (fname_monitor);

// ==================== MONITOR ====================
ds_monitor := Monitoring.Files.ClientMonitor ('PRA');
ds_monitor_new := PROJECT (ds_monitor, transform (monitoring.layouts.monitor, 
                                                  self.phone_level_other2 := true,
                                                  self := Left));
act_monitor := SEQUENTIAL (
  OUTPUT (ds_monitor_new, , fname_monitor);

  Monitoring.FileUtils.MoveSuperFiles (vendor_dir_ver + Monitoring.Files.NAMES.SUBMONITOR, fname_monitor, true)
); 
act_monitor;
*/