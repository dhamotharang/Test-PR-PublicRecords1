
// ds_sample_prep := bipv2.commonbase.ds_built(
     // company_fein in ['999999999','000000000','111111111','123456788','XXXXX4986','078051120','XXXXX1553','521052660','542012840','510503019','370533080','630315905','231237295','470589915','911914868','581285159','330311059','760329145','300000000','561948225','473642459','010101010','123456788','XXXXX4986','078051120','XXXXX1553','XXXXX2579'] 
  // or duns_number  in ['999999999','000000000','111111111','123456789','123456788']
// ) : persist('~persist::lbentley::ds_sample_prep');
// ds_sample_seleids := table(ds_sample_prep ,{seleid} ,seleid ,merge);
// ds_sample := join(bipv2.commonbase.ds_built ,ds_sample_seleids  ,left.seleid = right.seleid ,transform(recordof(left),self.lgid3 := if(left.lgid3 % 2 = 1,left.lgid3,0),self.proxid := if(left.proxid % 2 = 1,left.proxid,0),self := left)  ,hash)
// : persist('~persist::lbentley::ds_sample');

// -- 
#workunit('name'  ,'BH845 full file test no explode');
ds_sample     := bipv2.commonbase.ds_built : persist('~persist::lbentley::ds_sample');

ds_suppressed := BIPV2_Field_Suppression.mac_Suppress(ds_sample,pReturnDebugFields := false,pOutputGeneratedEcl := false,pTurnOffExtraOutputs := false,pForceExplosion := true);
// ds_suppressed := LinkingTools.mac_Suppress(ds_sample,,true,'^(company_fein|duns_number|source|proxid|dotid|lgid3|cnp_name)$'  ,'^(source|cnp_name)$','^(lgid3|proxid|dotid)$'  ,false)
// ds_suppressed := LinkingTools.mac_Suppress(ds_sample,ds_supp_file,false,'^(rcid|company_fein|duns_number|source|proxid|dotid|lgid3|cnp_name)$'  ,'^(source|cnp_name)$',['rcid','dotid','proxid','lgid3']  ,rcid ,true,false,true,true)
 // : persist('~persist::lbentley::BH845::ds_suppressed')
 ;
// ds_suppressed;
output_Suppressed_File := output(ds_suppressed  ,,'~temp::BH845::test_fein_suppressions::lgid3::2377261'  ,compressed,overwrite);


ds_diff := tools.mac_dataset_diff(ds_sample ,ds_suppressed ,rcid ,false   )  : persist('~persist::lbentley::BH845::ds_diff');

bip_input_id_check   := BIPV2_Strata.mac_BIP_ID_Check(table(ds_sample    ,{rcid,dotid,proxid,lgid3,seleid})  ,'Proxid','BH845_Testing','20210105a',true);
bip_output_id_check  := BIPV2_Strata.mac_BIP_ID_Check(table(ds_suppressed,{rcid,dotid,proxid,lgid3,seleid})  ,'Proxid','BH845_Testing','20210105a',true);


ds_sample_examples              := ds_sample      (rcid in [407393,11735,33020]);
ds_suppressed_examples_prep     := ds_suppressed  (rcid in [407393,11735,33020]);
ds_suppressed_examples_seleids  := table(ds_suppressed_examples_prep ,{seleid} ,seleid ,merge);
ds_suppressed_examples          := join(ds_suppressed ,ds_suppressed_examples_seleids  ,left.seleid = right.seleid ,transform(left)  ,hash);

ds_join_examples := join(ds_sample_examples ,ds_suppressed_examples ,left.rcid = right.rcid ,transform({unsigned6 rcid  ,unsigned6 seleid ,dataset({string file,unsigned6 rcid,unsigned6 dotid,unsigned6 proxid,unsigned6 lgid3 ,string company_fein}) IDS ,dataset({string file,recordof(left)}) recs}
  ,self.rcid   := left.rcid
  ,self.seleid := left.seleid
  ,self.IDs  :=   project(dataset(left )  ,transform({string file,unsigned6 rcid,unsigned6 dotid,unsigned6 proxid,unsigned6 lgid3 ,string company_fein},self.file :=  'Orig'       ,self := left))
                + project(dataset(right)  ,transform({string file,unsigned6 rcid,unsigned6 dotid,unsigned6 proxid,unsigned6 lgid3 ,string company_fein},self.file :=  'Suppressed' ,self := left))
  ,self.recs :=   project(dataset(left )  ,transform({string file,recordof(left)},self.file :=  'Orig'       ,self := left))
                + project(dataset(right)  ,transform({string file,recordof(left)},self.file :=  'Suppressed' ,self := left))

)  ,hash);

ds_add_diff := join(ds_join_examples  ,ds_diff(exists(diff_info))  ,left.rcid = right.rcid   ,transform({dataset(recordof(right.diff_info)) diff_info ,recordof(left)} ,self.diff_info := right.diff_info,self := left) ,left outer  ,hash);

ds_proxid_persistence_stats := BIPV2_Strata.PersistenceStats(ds_suppressed, ds_sample,rcid,proxid) : independent;
ds_lgid3_persistence_stats  := BIPV2_Strata.PersistenceStats(ds_suppressed, ds_sample,rcid,lgid3 ) : independent;

// output(topn(ds_diff                 (exists(diff_info))   ,500  ,seleid ,rcid) ,named('ds_diff'               ),all);
// output(topn(ds_diff                 (exists(diff_info))   ,500          ,rcid) ,named('ds_diff_rcid'          ),all);


parallel(
    output_Suppressed_File
   ,output(topn(ds_diff(exists(diff_info))                    ,500  ,seleid ,rcid) ,named('ds_diff_examples'      ),all)
   ,output(topn(ds_add_diff                                   ,500  ,seleid ,rcid) ,named('ds_join_examples'      ),all)
   ,output(topn(ds_suppressed_examples                        ,500          ,rcid) ,named('ds_suppressed_examples'),all)
   ,output(topn(ds_sample_examples                            ,500          ,rcid) ,named('ds_sample_examples'    ),all)
   ,output(ds_proxid_persistence_stats                                             ,named('Proxid_Persistence_Stats'))
   ,output(ds_lgid3_persistence_stats                                              ,named('Lgid3_Persistence_Stats' ))
   ,bip_input_id_check 
   ,bip_output_id_check
);





// output(ds_id_integrity_before ,named('Id_Integrity_Stats_Before'));
// output(ds_id_integrity_after  ,named('Id_Integrity_Stats_After' ));

// output(ds_sample(company_fein = '123456788')  ,named('Pre_Suppression_company_fein_123456788'));
// output(ds_sample(company_fein = 'XXXXX4986')  ,named('Pre_Suppression_company_fein_XXXXX4986'));
// output(ds_sample(company_fein = '078051120')  ,named('Pre_Suppression_company_fein_078051120'));
// output(ds_sample(company_fein = 'XXXXX1553')  ,named('Pre_Suppression_company_fein_XXXXX1553'));

// output(ds_suppressed(company_fein = '123456788')  ,named('Suppressed_company_fein_123456788'));
// output(ds_suppressed(company_fein = 'XXXXX4986')  ,named('Suppressed_company_fein_XXXXX4986'));
// output(ds_suppressed(company_fein = '078051120')  ,named('Suppressed_company_fein_078051120'));
// output(ds_suppressed(company_fein = 'XXXXX1553')  ,named('Suppressed_company_fein_XXXXX1553'));
 
