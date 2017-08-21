// Reprojects existing Monitor DB (aka base file)

// [old_layout] and [Format] must be redefined for every case;

// Old format is currently existing format, which has to be changed to 
// a new monitoring.layouts -- a modified (for instance, sandboxed) target format.

// !!! IMPORTANT: Monitor DB can be inconsistent until reprojection runs for all the clients,
// if old format is not the same as new one: new and old subfiles will not fit each other

// Runs for every client separately.
// string client_id := 'NCO::NCO_U99004';
// string client_id := 'BWH';
// string client_id := 'PRA';


#WORKUNIT ('name', 'NCO maintanance: matrix: ' + client_id);
IMPORT ut, standard;

MC := Monitoring.Constants;
subj := MC.T_SUBJECT;
phn := MC.T_PHONES;


  // (old) Monitor subject
  OLD_T_SUBJECT := MODULE
    export unsigned1 NONE     := 0;
    export unsigned1 ADDRESS  := 1;
    export unsigned1 PHONE_TA := 2;
    export unsigned1 PHONE_TB := 4;
    export unsigned1 PHONE_TD := 8;
    export unsigned1 PHONE_TG := 16;
    export unsigned1 PROPERTY := 32;
    export unsigned1 PHONE_TC := 64;
    export unsigned1 PAW := 128;
  END;


// ==============================================================================
// ------------------------------------------------------------------------------
// -------------------- Switch to new style Monitor settings --------------------
// ------------------------------------------------------------------------------
// ==============================================================================
old_m_settings := RECORD
  Monitoring.layouts.monitor AND NOT matrix;
  Monitoring.layouts.m_settings_flat;
end;

unsigned2 GetPhoneType (boolean p_ta, boolean p_tb, boolean p_td, boolean p_tg) := 
  0 + IF (p_ta, phn.PHONE_TA, 0) + IF (p_tb, phn.PHONE_TB, 0) + IF (p_td, phn.PHONE_TD, 0) + IF (p_tg, phn.PHONE_TG, 0);

Monitoring.layouts.m_settings GetMatrix_BWH (
  unsigned1 addr_num, unsigned1 phone_num, boolean p_ta, boolean p_tb, boolean p_td, boolean p_tg,
  boolean p_other1, boolean p_other2, boolean p_other3,
  string1 fr_type, unsigned2 fr_time, string1 d_type, unsigned2 d_time) := FUNCTION
  phn_type := phn.PHONE_TA + phn.PHONE_TB + phn.PHONE_TC + phn.PHONE_TG;

  ds := dataset ([
    {subj.ADDRESS, 0,        MC.T_FREQUENCY.NONE, 0, fr_type, fr_time, Monitoring.Client_BWH.MAXNUM_ADDRESS, false, ''},
    {subj.PHONE,   phn_type, MC.T_FREQUENCY.NONE, 0, fr_type, fr_time, Monitoring.Client_BWH.MAXNUM_PHONE,   false, ''}
  ], Monitoring.layouts.m_settings);
  return ds;
end;

// make delays zero for all the old records
Monitoring.layouts.m_settings GetMatrix_NCO (
  unsigned1 addr_num, unsigned1 phone_num, boolean p_ta, boolean p_tb, boolean p_td, boolean p_tg,
  boolean p_other1, boolean p_other2, boolean p_other3,
  string1 fr_type, unsigned2 fr_time, string1 d_type, unsigned2 d_time) := FUNCTION

  ds := dataset ([
    {subj.ADDRESS, 0,                                    MC.T_FREQUENCY.NONE, 0, fr_type, fr_time, addr_num, false, ''},
    {subj.PHONE,  GetPhoneType (p_ta, p_tb, p_td, p_tg), MC.T_FREQUENCY.NONE, 0, fr_type, fr_time, phone_num,   false, ''}
  ], Monitoring.layouts.m_settings);
  return ds;
end;

Monitoring.layouts.m_settings GetMatrix_PRA (
  unsigned1 addr_num, unsigned1 phone_num, boolean p_ta, boolean p_tb, boolean p_td, boolean p_tg,
  boolean p_other1, boolean p_other2, boolean p_other3,
  string1 fr_type, unsigned2 fr_time, string1 d_type, unsigned2 d_time) := FUNCTION

  ds := dataset ([
    {subj.ADDRESS,  0,                                     d_type, d_time, fr_type, fr_time, Monitoring.Client_PRA.MAXNUM_ADDRESS,  false, ''},
    {subj.PHONE,    GetPhoneType (p_ta, p_tb, p_td, p_tg), d_type, d_time, fr_type, fr_time, Monitoring.Client_PRA.MAXNUM_PHONE,    false, ''},
    {subj.PROPERTY, 0,                                     d_type, d_time, fr_type, fr_time, Monitoring.Client_PRA.MAXNUM_PROPERTY, false, ''},
    {subj.PAW,      0,                                     d_type, d_time, fr_type, fr_time, Monitoring.Client_PRA.MAXNUM_PAW,      false, ''}
  ], Monitoring.layouts.m_settings);
  return ds;
end;

Monitoring.layouts.monitor SeeMonitorProperties (old_m_settings L) := transform
  def_phones := phn.PHONE_TA + phn.PHONE_TB;
  // Set Monitor Properties
  cl := client_id [1..3];
  Self.matrix := MAP (
    cl = MC.ClientID.BWH => GetMatrix_BWH (L.best_address_number, L.best_phone_number, 
                                           L.phone_level_ta, L.phone_level_tb, L.phone_level_td, L.phone_level_tg,
                                           L.phone_level_other1, L.phone_level_other2, L.phone_level_other3,
                                           L.frequency_type, L.frequency_time, L.delay_type, L.delay_time),

    cl = MC.ClientID.NCO => GetMatrix_NCO (L.best_address_number, L.best_phone_number, 
                                           L.phone_level_ta, L.phone_level_tb, L.phone_level_td, L.phone_level_tg,
                                           L.phone_level_other1, L.phone_level_other2, L.phone_level_other3,
                                           L.frequency_type, L.frequency_time, L.delay_type, L.delay_time),

    cl = MC.ClientID.PRA => GetMatrix_PRA (L.best_address_number, L.best_phone_number, 
                                           L.phone_level_ta, L.phone_level_tb, L.phone_level_td, L.phone_level_tg,
                                           L.phone_level_other1, L.phone_level_other2, L.phone_level_other3,
                                           L.frequency_type, L.frequency_time, L.delay_type, L.delay_time),
    // default  
    dataset ([
      {subj.ADDRESS, 0,          MC.T_FREQUENCY.NONE, 0, MC.T_FREQUENCY.DAY, 1, 1, false, ''},
      {subj.PHONE,   def_phones, MC.T_FREQUENCY.NONE, 0, MC.T_FREQUENCY.DAY, 1, 1, false, ''}
    ], Monitoring.layouts.m_settings)); 

  Self := L;
end;
// ------------------------------------------------------------------------------
// ------------------------------------------------------------------------------
// ------------------------------------------------------------------------------



// -------------------- define current reprojection --------------------
old_layout := old_m_settings;
Format (old_layout L) := SeeMonitorProperties (L);



// -------------------- chose a name for a new file --------------------
date := ut.GetDate;
vendor_dir := Monitoring.Files.Names.THOR_ROOT + client_id + '::';
vendor_dir_ver := vendor_dir + '@version@::';
fname_monitor := vendor_dir + 'reproject_msettings_' + date;



// -------------------- get current monitor DB file --------------------
ds_monitor := DATASET (vendor_dir + 'qa::' + Monitoring.Files.NAMES.SUBMONITOR, old_layout, THOR, OPT);



// -------------------- RUN --------------------
ds_monitor_new := PROJECT (ds_monitor, Format (Left));
act_monitor := SEQUENTIAL (
  OUTPUT (ds_monitor_new, , fname_monitor),
  Monitoring.FileUtils.MoveSuperFiles (vendor_dir_ver + Monitoring.Files.NAMES.SUBMONITOR, fname_monitor, true)
); 

act_monitor;
