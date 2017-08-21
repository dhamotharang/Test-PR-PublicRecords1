import Monitoring, monitoring_other;

#workunit('name','PRA filter initial load');
#WORKUNIT ('priority', 'high');
CID := Monitoring.Constants.ClientID.PRA;


//-----------------------------------------------------------------
//------------------- SAVE THIS CLIENT RESULTS --------------------
//-----------------------------------------------------------------
// Save this client files
in_hist := monitoring.File_Address_History (customer_id = CID); // DOD history
in_addr  := monitoring.File_Address_Out (customer_id = CID); // Address
in_phone := monitoring.File_Phone_Out (customer_id = CID); // Phone
in_paw   := monitoring_other.file_paw_out (customer_id = CID); // Property

hist_name := '~production_watch_thor::monitoring::result::pra::frun_20080926_history';
addr_out_name  := '~production_watch_thor::monitoring::result::pra::frun_20080926_address_out';
phone_out_name := '~production_watch_thor::monitoring::result::pra::frun_20080926_phone_out';
paw_out_name   := '~production_watch_thor::monitoring::result::pra::frun_20080926_paw_out';

ACT_SAVE := SEQUENTIAL (
  output (in_hist, , hist_name, OVERWRITE),
  output (in_addr, , addr_out_name, OVERWRITE),
  output (in_phone, , phone_out_name, OVERWRITE),
  output (in_paw, , paw_out_name, OVERWRITE));



//-----------------------------------------------------------------
//---------------- SAVE CLIENT INPUT COMBINED SOURCE --------------
//-----------------------------------------------------------------
layout_date := RECORD (Monitoring.layouts_PRA.batch_raw)
  string8 date;
END;

GetDatedBatch (string file_in_name, string date_in) := FUNCTION
  // read file just sprayed
  ds_batch_in := DATASET (file_in_name, Monitoring.layouts_PRA.batch, CSV (separator(','), QUOTE(''), maxlength (16384)));

  layout_date AssignId (Monitoring.layouts_PRA.batch L) := TRANSFORM
    SELF.customer_id := CID ;
    SELF.record_id := Monitoring.Client_PRA.GetID (L.account, L.rel_pos);
    SELF.request_code := '';
    SELF.wuid := '';
    Self.date := date_in;
    SELF := L;
  END;
  ds_current_batch := PROJECT (ds_batch_in, AssignId (Left));
  return ds_current_batch;
END;

batch_1 := GetDatedBatch ('~production_watch_thor::monitoring::in::pra::masterload_04012008_1200', '20080401');
batch_2 := GetDatedBatch ('~production_watch_thor::monitoring::in::pra::masterload_04302008_1200', '20080430');
batch_3 := GetDatedBatch ('~production_watch_thor::monitoring::in::pra::masterload_06132008_1200', '20080613');
batch_4 := GetDatedBatch ('~production_watch_thor::monitoring::in::pra::masterload_07142008_1200', '20080714');

all_input := DISTRIBUTE (batch_1 + batch_2 + batch_3 + batch_4, hash32 (record_id));

all_input_name := '~production_watch_thor::monitoring::result::pra::temp_all_input';
ACT_SAVE_INPUT := output (all_input, , all_input_name, overwrite);



//-----------------------------------------------------------------
//----------------- MAKE FILTERED JOIN WITH THE INPUT -------------
//-----------------------------------------------------------------
all_source := dataset (all_input_name, layout_date, thor);
src_hist := dataset(hist_name, Monitoring.Layout_Address_History, thor, opt);
src_addr  := dataset(addr_out_name, Monitoring.Layout_Address_Update, thor, opt);
src_phone := dataset(phone_out_name, Monitoring.layout_phone_out, thor, opt);
src_paw   := dataset(paw_out_name, Monitoring_Other.layout_paw_out, thor, opt);

res_addr := DISTRIBUTE (src_addr, hash32 (record_id));
res_phon := DISTRIBUTE (src_phone, hash32 (record_id));
res_paw  := DISTRIBUTE (src_paw, hash32 (record_id));

filt_addr := JOIN (res_addr, all_source,
                   (Left.record_id = Right.record_id) AND (Left.addr_dt_first_seen > (Right.date[1..6])),
                   transform (Monitoring.layout_address_update, Self := Left),
                   KEEP (1), LOCAL);
  
filt_phon := JOIN (res_phon, all_source,
                   (Left.record_id = Right.record_id) AND (Left.phone_dt_first_seen > Right.date),
                   transform (Monitoring.layout_phone_out, Self := Left),
                   KEEP (1), LOCAL);

filt_paw := JOIN (res_paw, all_source,
                  (Left.record_id = Right.record_id) AND (Left.pawk_first_seen_1 > Right.date),
                  transform (Monitoring_Other.layout_paw_out, Self := Left),
                  KEEP (1), LOCAL);

ACT_SAVE_JOINED := SEQUENTIAL (
  output (filt_addr, , '~production_watch_thor::monitoring::result::pra::filt_addr', overwrite),
  output (filt_phon, , '~production_watch_thor::monitoring::result::pra::filt_phon', overwrite),
  output (filt_paw,  , '~production_watch_thor::monitoring::result::pra::filt_paw', overwrite)
);



//-----------------------------------------------------------------
//----------------------------- SEND ------------------------------
//-----------------------------------------------------------------
filt_addr_res := dataset ('~production_watch_thor::monitoring::result::pra::filt_addr', Monitoring.layout_address_update, thor);
filt_phon_res := dataset ('~production_watch_thor::monitoring::result::pra::filt_phon', Monitoring.layout_phone_out, thor);
filt_paw_res  := dataset ('~production_watch_thor::monitoring::result::pra::filt_paw', Monitoring_Other.layout_paw_out, thor);

lz_ip := 'batchdev01.br.seisint.com';
lz_path := '/batchshare/THORMonitoring/outgoing/';

ACT_SEND := PARALLEL (
  monitoring.Client (CID).SendAddress (filt_addr_res, src_hist),
  monitoring.Client (CID).SendPhone   (filt_phon_res, src_hist),
  Monitoring.Client (CID).SendPaw     (filt_paw_res,  src_hist, lz_ip, lz_path)
);
// test wuids: W20080902-145606, W20080829-173049 (dataland)

//ACT_SAVE
//ACT_SAVE_INPUT;
//ACT_SAVE_JOINED;
//ACT_SEND;                //W20081023-103441




/*
// W20081002-150347
#workunit('name','Checking PRA results');

ds_in := DATASET ('~production_watch_thor::monitoring::result::pra::pra_20080930_property.txt', 
  Monitoring.layouts.out_property, CSV (separator(','), terminator('\n'), QUOTE(''), maxlength (16384)));

layout_stat := RECORD
  aggr := ds_in.record_id;
  ncount := COUNT(GROUP);
END;
ds_sort_few := SORT (TABLE (ds_in, layout_stat, record_id, FEW), -ncount);
//OUTPUT (ds_sort_few, NAMED ('stat'));
//OUTPUT (count (ds_sort_few), NAMED ('count_unique'));

layout_seq := record
  integer seq;
  Monitoring.layouts.out_property;
end;
layout_seq setSequence (Monitoring.layouts.out_property L, integer C) := transform
  Self.seq := C;
  Self := L;
end;
ds_out := project (ds_in, setSequence (left, COUNT));
//output (ds_out, , '~production_watch_thor::monitoring::result::pra::temp_prop', overwrite);

ds_out_in := dataset ('~production_watch_thor::monitoring::result::pra::temp_prop', layout_seq, thor);
//output (ds_out_in (record_id = ''));

ds_new := ds_in (trim (record_id) != '');

//Monitoring_Other.layout_prp_out);
ds := Monitoring_Other.file_prp_out;
//output (ds);
prop_hist := monitoring_other.file_prp_history (record_id = '8060500762196_1');
//output (prop_hist);

Monitoring.Client (Monitoring.Constants.ClientID.PRA).SendProperty (ds, Monitoring.File_Address_History);
*/


/*
// Last runs: W20081202-131442, W20081202-132144

// Sending first real P@W results;
// result file should be split into initial and "since then" parts;
// "initial" part should be filtered (3 months) against initial load
#workunit ('name', 'sending custom PRA p@w file');
#WORKUNIT ('priority', 'high');
CID := monitoring.Constants.ClientID.PRA;

//ds_paw := monitoring_other.file_paw_out;
ds_paw := dataset('~thor_data400::base::monitoring_paw_outw20081202-130021',monitoring_other.layout_paw_out,thor);


// input file
paw_in := distribute (ds_paw (customer_id = CID), hash32 (record_id)) : INDEPENDENT;

// initial load file (distribute it just on case...)
layout_date := RECORD (Monitoring.layouts_PRA.batch_raw)
  string8 date;
END;
all_input_name := '~production_watch_thor::monitoring::result::pra::temp_all_input';
all_source := dataset (all_input_name, layout_date, thor);
ds_initial := distribute (all_source, hash32 (record_id)) : INDEPENDENT;


// --------------- "Slow" way: calcualtes split separately --------------
// split into "initial" and "since then"
paw_initial := JOIN (paw_in, ds_initial,
                     Left.record_id = Right.record_id,
                     transform (monitoring_other.layout_paw_out, Self := Left),
                     KEEP(1), LOCAL);

paw_since_then := JOIN (paw_in, ds_initial,
                        Left.record_id = Right.record_id,
                        transform (monitoring_other.layout_paw_out, Self := Left),
                        LEFT ONLY, LOCAL);

// filter "initial"
filt_paw := JOIN (paw_initial, ds_initial,
                  (Left.record_id = Right.record_id) AND (Left.pawk_first_seen_1 > Right.date),
                  transform (Monitoring_Other.layout_paw_out, Self := Left),
                  KEEP (1), LOCAL);

ACT_SAVE_FILTERED := output (filt_paw,  , '~production_watch_thor::monitoring::result::pra::filt_paw_20081202_10', overwrite);




// --------------- alternative way (faster, but doesn't show split record numbers) --------------
Monitoring_Other.layout_paw_out CheckInitialLoad (Monitoring_Other.layout_paw_out L, layout_date R) := FUNCTION
  boolean doFilter := (L.record_id = R.record_id) and (L.pawk_first_seen_1 <= R.date);
    
  Monitoring_Other.layout_paw_out myTransform := transform, SKIP (doFilter)
    Self := L;
  end;
  return myTransform;
END;

// split into "initial" and "since then" and filter initial part
paw_res := JOIN (paw_in, ds_initial,
                 Left.record_id = Right.record_id,
                 CheckInitialLoad (Left, Right),
                 KEEP(1), LEFT OUTER, LOCAL);


// Chooose
boolean UseFast := false;
paw_sum := IF (UseFast, paw_res, filt_paw + paw_since_then);
ACT_SAVE_PAW_ALL := output (paw_sum,  , '~production_watch_thor::monitoring::result::pra::all_paw_20081202_10', overwrite);

paw_sum_saved := dataset ('~production_watch_thor::monitoring::result::pra::all_paw_20081202_10', 
                          Monitoring_Other.layout_paw_out, THOR);
ACT_SEND_PAW := monitoring.Client (CID).SendPAW (paw_sum_saved, 
                                                 monitoring.File_Address_History);

// SEQUENTIAL (ACT_SAVE_FILTERED, ACT_SAVE_PAW_ALL);
// ACT_SEND_PAW;
*/