/*
  BH-780 -- improve gold 

  -- add uccs to high confidence sources, see if this gets us to about 32-33 million golds.  UCCs uses process date for dt_last_seen, but it is run every day, so the date might be ok.
  liensv2 uses filing date, so that might be ok too.  might try that next.
  i wonder about property too.  what does that use?  uses tax year, recording date or sale date.  all of which are good, but only if it has the month.
  uccs, liens and property seem like they would be more stable too.
  added ucc, liens and property to high conf sources.  see if we get over 30 million golds. just ucc gives us 29.8 million
  try high confidence sources in gold calc + trusted  31.6 million
  31.0 for father
  30.361 for grandfather

  add cclue and yellowpages to high conf
*/

// ds_clean := bipv2.CommonBase.clean2(bipv2.CommonBase.DS_GRANDFATHER) : persist('~persist::lbentley::ds_clean');
// mytoday  := '20200203';
// ds_clean := bipv2.CommonBase.DS_FATHER_CLEAN2 : persist('~persist::lbentley::ds_clean');
// mytoday  := '20200303';
ds_clean := bipv2.CommonBase.DS_CLEAN;
mytoday  := '20200403';

ds_reset_statuses := BIPV2_tools.mac_Set_Statuses       (ds_clean ,pToday := mytoday)
 : persist('~persist::lbentley::ds_reset_statuses');
ds_reset_gold     := BIPV2_statuses.mac_Calculate_Gold  (ds_reset_statuses        ,pShow_Work := true)
 : persist('~persist::lbentley::ds_reset_gold');

output(choosen(ds_reset_gold  ,100)  ,named('ds_reset_gold'));


output(count(ds_reset_gold )  ,named('count_ds_reset_gold'));

ds_gold_seleids := table(ds_reset_gold(sele_gold = 'G'),{seleid}  ,seleid ,merge);
ds_sample_golds := enth(ds_gold_seleids ,300);
ds_sample_gold_recs := join(ds_reset_gold ,ds_sample_golds  ,left.seleid = right.seleid ,transform(left)  ,hash) : persist('~persist::lbentley::ds_sample_gold_recs');
// output(BIPV2_Tools.Agg_Slim(ds_sample_gold_recs ,seleid) ,named('Sample_Gold_Seleids'),all);
output(count(ds_gold_seleids )  ,named('count_ds_gold_seleids'));

output(sort(table(ds_sample_gold_recs(seleid = 15697020) 
  ,{seleid,string source := mdr.sourcetools.translatesource(source),cnp_name,prim_range,Prim_name,unsigned4 dt_last_seen := max(group,dt_last_seen),company_status_derived} 
  ,seleid,source, cnp_name,prim_range,Prim_name,company_status_derived
  ,merge) ,seleid,source,-dt_last_seen) ,named('seleid_15697020_inactive'),all);
