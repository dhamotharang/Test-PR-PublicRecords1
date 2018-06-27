// -- BH-421 -- analyze underlinking in proxid and seleid, get recall numbers

// 1.5%
// 98.5% recall
#workunit('name','Proxid recall stats');
version := 'qa';

/* -------------------------------------------------------------------------------------------------------------------------
   -- Cluster proxids together using cnp_name, address, corpkey-address, etc. and patch the new proxids onto the base file
   -------------------------------------------------------------------------------------------------------------------------
*/
ds_bip_base   := bipv2.CommonBase.ds_base;
ds_bip_prep := table(ds_bip_base  ,{proxid
  ,string cnp_name_addr             := if(cnp_name                  != '' and prim_name != '' and (v_city_name != '' or zip != '')  ,(string)hash64(cnp_name                ,prim_range,prim_name,v_city_name,zip)  ,'')
  ,string active_domestic_corp_key  := if(active_domestic_corp_key  != ''	and prim_name != '' and (v_city_name != '' or zip != '')  ,(string)hash64(active_domestic_corp_key,prim_range,prim_name,v_city_name,zip)	,'')
  ,string company_fein              := if(company_fein              != ''	and prim_name != '' and (v_city_name != '' or zip != '')  ,(string)hash64(company_fein            ,prim_range,prim_name,v_city_name,zip)	,'')
  ,string active_duns_number        := if(active_duns_number        != ''	and prim_name != '' and (v_city_name != '' or zip != '')  ,(string)hash64(active_duns_number      ,prim_range,prim_name,v_city_name,zip)	,'')
  });

ds_bip_prep_dedup := table(ds_bip_prep  ,{proxid,cnp_name_addr,active_domestic_corp_key,company_fein,active_duns_number} ,proxid,cnp_name_addr,active_domestic_corp_key,company_fein,active_duns_number ,merge);

ds_bip_prep_child := project(ds_bip_prep_dedup  ,transform({unsigned6 proxid,dataset({string grouping})  ds_grouping_fields} 
  ,self.ds_grouping_fields := 
      dataset([{if(left.cnp_name_addr            != '' ,'CNPADDR-' + left.cnp_name_addr            ,'')}],{string grouping}) 
    + dataset([{if(left.active_domestic_corp_key != '' ,'CORPKEY-' + left.active_domestic_corp_key ,'')}],{string grouping}) 
    + dataset([{if(left.company_fein             != '' ,'FEIN-'    + left.company_fein             ,'')}],{string grouping}) 
    + dataset([{if(left.active_duns_number       != '' ,'DUNS-'    + left.active_duns_number       ,'')}],{string grouping}) 
    (grouping != '')
  ,self := left));

ds_bip_prep_norm := normalize(ds_bip_prep_child ,left.ds_grouping_fields  ,transform({unsigned6 proxid,string grouping},self := right,self := left));
ds_bip_prep_table := table(ds_bip_prep_norm ,{proxid,grouping} ,proxid,grouping ,merge) : persist('~persist::lbentley::ds_bip_prep_table');


ds_converged_proxids  := BIPV2_Tools.mac_reform_clusters(ds_bip_prep_table,proxid,grouping,20) : persist('~persist::lbentley::ds_converged_proxids');
ds_mapping_table      := table(ds_converged_proxids  ,{proxid_old,proxid} ,proxid_old,proxid ,merge);

ds_patched_base := join(ds_bip_base ,ds_mapping_table ,left.proxid = right.proxid_old ,transform({unsigned6 proxid_old,recordof(left)},self.proxid := right.proxid/*new one*/,self.proxid_old := left.proxid/*old one*/,self := left) ,left outer ,hash) 
  : persist('~persist::lbentley::ds_patched_base');

/* -------------------------------------------------------------------------------------------------------------------------
   -- Aggregate old proxids using macro, patch new proxid on it and get count of old proxids within the new proxid
   -------------------------------------------------------------------------------------------------------------------------
*/
/*
ds_patched_base_agg  := BIPV2_Tools.AggregateProxidElements(ds_patched_base,proxid_old) : persist('~persist::lbentley::ds_patched_base_agg');//proxid will be in there automatically

ds_patched_base_agg_prep := project(ds_patched_base_agg ,transform({unsigned6 proxid,recordof(left) - proxids},self.proxid := left.proxids[1].proxid,self := left)) : persist('~persist::lbentley::ds_patched_base_agg_prep');
ds_patched_base_agg_prep_count := table(ds_patched_base_agg_prep  ,{proxid,unsigned cnt := count(group)} ,proxid ,merge) : persist('~persist::lbentley::ds_patched_base_agg_prep_count');
ds_patched_base_agg_prep_count_patch := join(ds_patched_base_agg_prep ,ds_patched_base_agg_prep_count ,left.proxid = right.proxid ,transform({unsigned6 proxid,unsigned cnt_proxid_olds,recordof(left) - proxid},self.proxid := left.proxid,self.cnt_proxid_olds := right.cnt,self := left)  ,hash);

output(choosen(ds_converged_proxids,300)  ,named('ds_converge_it'),all);
output(count(ds_converged_proxids(proxid = 0))  ,named('count_ds_converge_it_zero_proxids'),all);

// ds_patched_base_sort := sort(distribute(ds_patched_base_agg_prep,proxid) ,proxid,proxid_old,local);

output(topn(ds_patched_base_agg_prep_count_patch,300,-cnt_proxid_olds,proxid,proxid_old) ,named('topn_ds_patched_base_agg_prep_count_patch'),all);
output(choosen(ds_patched_base_agg_prep_count_patch,300) ,named('choosen_ds_patched_base_agg_prep_count_patch'),all);

output(count(ds_mapping_table                     (proxid             = 0))  ,named('count_ds_mapping_table_zero_proxids'),all);
output(count(ds_patched_base                      (proxid             = 0))  ,named('count_ds_patched_base_zero_proxids'),all);
output(count(ds_patched_base_agg                  (proxids[1].proxid  = 0))  ,named('count_ds_patched_base_agg_zero_proxids'),all);
output(count(ds_patched_base_agg_prep             (proxid             = 0))  ,named('count_ds_patched_base_agg_prep_zero_proxids'),all);
output(count(ds_patched_base_agg_prep_count       (proxid             = 0))  ,named('count_ds_patched_base_agg_prep_count_zero_proxids'),all);
output(count(ds_patched_base_agg_prep_count_patch (proxid             = 0))  ,named('count_ds_patched_base_agg_prep_count_patch_zero_proxids'),all);
*/
/* -------------------------------------------------------------------------------------------------------------------------
   -- get new proxids containing more than one old proxid.  
   -- then do join to produce all possible comparisons within those new proxids.
   -------------------------------------------------------------------------------------------------------------------------
*/
// -- append match candidates info to mapping table for each proxid_old
ds_mapping_table_numproxids       := table(ds_mapping_table  ,{proxid,unsigned cnt := count(group)} ,proxid ,merge);
ds_mapping_table_numproxids_gt1   := ds_mapping_table_numproxids(cnt > 1);
ds_mapping_table_out              := join(ds_mapping_table  ,ds_mapping_table_numproxids_gt1  ,left.proxid = right.proxid ,transform(left)  ,hash);

ih := BIPV2_PROXID.In_DOT_Base;
key_proxid_cands      := BIPV2_PROXID.Keys(ih,version).candidates;
key_proxid_cands_slim := join(key_proxid_cands  ,ds_mapping_table_out ,left.proxid = right.proxid_old ,transform(left)  ,hash);

// -- do matrix of comparisons of proxids within the new proxid
ds_proxid_comparisons := join(ds_mapping_table_out  ,ds_mapping_table_out ,left.proxid = right.proxid and left.proxid_old < right.proxid_old  ,transform({unsigned6 proxid_new,unsigned6 proxid1,unsigned6 proxid2}
  ,self.proxid_new  := left.proxid
  ,self.proxid1     := left.proxid_old
  ,self.proxid2     := right.proxid_old
  // ,self             := []
)  ,hash)
: persist('~persist::ds_proxid_comparisons');

kspec	:= BIPV2_PROXID.Keys(ih).Specificities_Key;
s     := project(kspec,transform(BIPV2_PROXID.Layout_Specificities.R,self := left,self := []))[1];
katts	:= BIPV2_PROXID.Keys(ih).Attribute_Matches;
katts_prep := project(katts ,transform(BIPV2_PROXID.match_candidates(ih).layout_attribute_matches,self := left,self := []));

// ds_proxid_comparisons_prep := project(ds_proxid_comparisons ,BIPV2_PROXID.match_candidates(ih).layout_matches   );

/*
  So, at this point, i have all of the comparisons of proxids that I want.  proxid1, proxid2
  what i need is to get all of the records for both proxid1 and proxid2
  so that I can run the sample match join, and then dedup on proxid1, proxid2, -conf to get the best match for each
*/

lay_cands := BIPV2_PROXID.match_candidates(ih).layout_candidates;

/*----------------------SAMPLE OF COMPARISONS---------------------------------- */
ds_proxid_comparisons_prep := distribute(ds_proxid_comparisons);
// ds_proxid_comparisons_prep := distribute(choosen(ds_proxid_comparisons ,10000000));
// ds_proxid_comparisons_prep := distribute(choosen(project(ds_proxid_comparisons ,BIPV2_PROXID.match_candidates(ih).layout_matches   ),10000000));
// key_proxid_cands_prep      := project(key_proxid_cands_slim ,transform(lay_cands,self := left,self := []));

// mtch := BIPV2_PROXID.Debug(ih,s).AnnotateMatchesFromData(key_proxid_cands_prep,ds_proxid_comparisons_prep ,katts_prep) : persist('~persist::mtch');

key_proxid_cands_dedup := dedup(sort(distribute(key_proxid_cands,hash(proxid,cnp_name,prim_range,prim_name,v_city_name,salt_partition)) ,rcid,whole record ,local)  ,whole record,except rcid,local);

///////////////////////////////////////-------------------------------------------------
/* --------- first join to get all records for proxid1*/
j1  := JOIN(ds_proxid_comparisons_prep  ,key_proxid_cands_dedup ,LEFT.Proxid1 = RIGHT.Proxid  ,transform({recordof(left),unsigned6 rcid1,lay_cands leftrec} ,self := left,self.rcid1 := right.rcid,self.leftrec := row(right,transform(lay_cands,self := left,self := []))  )  ,hash,keep(1000)) : persist('~persist::j1');
/* --------- second join to get all records for proxid2*/
j2  := JOIN(j1                          ,key_proxid_cands_dedup ,LEFT.Proxid2 = RIGHT.Proxid  ,transform({unsigned6 proxid_new,unsigned6 proxid1,unsigned6 rcid1,unsigned6 proxid2,unsigned6 rcid2,recordof(left) - proxid_new - proxid1 - proxid2 - rcid1,lay_cands rightrec}  
,self.rcid2 := right.rcid,,self := left,self.rightrec := row(right,transform(lay_cands,self := left,self := [])))  ,hash  ,keep(1000)) : persist('~persist::j2'  );


r := project(distribute(j2) ,BIPV2_PROXID.Debug(ih,s).sample_match_join( LEFT.leftrec,left.rightrec)) : persist('~persist::r');

d := DEDUP( SORT( distribute(r,hash(Proxid1,proxid2)) , Proxid1, Proxid2, -Conf, LOCAL ), Proxid1, Proxid2, LOCAL )  : persist('~persist::d'  ); // Proxid2 distributed by join
// d := DEDUP( SORT( j2 + d_nosort , Proxid1, Proxid2, -Conf, LOCAL ), Proxid1, Proxid2, LOCAL )  : persist('~persist::d'  ); // Proxid2 distributed by join
mtch := BIPV2_PROXID.Debug(ih,s).AppendAttribs( d, katts_prep )   : persist('~persist::mtch'  );

///////////////////////////////////////-------------------------------------------------

ds_stats := dataset([
   {'ds_mapping_table'                ,count(ds_mapping_table               )}
  ,{'ds_mapping_table_numproxids'     ,count(ds_mapping_table_numproxids    )}
  ,{'ds_mapping_table_numproxids_gt1' ,count(ds_mapping_table_numproxids_gt1)}
  ,{'ds_mapping_table_out'            ,count(ds_mapping_table_out           )}
  ,{'key_proxid_cands'                ,count(key_proxid_cands               )}
  ,{'ds_proxid_comparisons'           ,count(ds_proxid_comparisons          )}
  ,{'katts'                           ,count(katts                          )}
  ,{'ds_proxid_comparisons_prep'      ,count(ds_proxid_comparisons_prep     )}
  ,{'j1'                              ,count(j1                             )}
  ,{'j2'                              ,count(j2                             )}
  ,{'r'                               ,count(r                              )}
  ,{'d'                               ,count(d                              )}
  ,{'mtch'                            ,count(mtch                           )}
],{string stat,unsigned cnt});

output(ds_stats ,named('ds_stats'),extend);

output(choosen(ds_mapping_table_numproxids    ,200) ,named('ds_mapping_table_numproxids'     ),all);
output(choosen(ds_mapping_table_numproxids_gt1,200) ,named('ds_mapping_table_numproxids_gt1' ),all);
output(choosen(ds_mapping_table_out           ,200) ,named('ds_mapping_table_out'            ),all);
output(choosen(key_proxid_cands               ,200) ,named('key_proxid_cands'                ),all);
output(choosen(ds_proxid_comparisons          ,200) ,named('ds_proxid_comparisons'           ),all);
output(choosen(katts                          ,200) ,named('katts'                           ),all);
output(choosen(katts_prep                     ,200) ,named('katts_prep'                      ),all);
output(choosen(ds_proxid_comparisons_prep     ,200) ,named('ds_proxid_comparisons_prep'      ),all);

output(choosen(j1                               ,200) ,named('j1'                        ),all);
output(choosen(j2                               ,200) ,named('j2'                        ),all);

output(choosen(r                                ,200) ,named('r'                             ),all);
output(choosen(d                                ,200) ,named('d'                             ),all);
output(choosen(mtch                           ,200) ,named('mtch'                            ),all);

/*
  so, what we want is to summarize the scores for all matches within the new proxid.
  how many are good matches(above threshold)
  how many below threshold, how many at threshold
  then, for matches below the thresold, what caused it to not match?
    1. mismatch on force field?
    2. mismatch on partitioning?
    3. just a lower score, no force violations.
    4. probably should total up the violations and group by them....
    5. also output samples of the clusters that don't match, some samples of each issue....but can't have a random number of outputs though....
  for matches above threshold, probably means more iterations should fix it.  Should not be a big number of these since our convergence is high(using current proxid/lgid3 rules)
  
  MAY WANT TO NARROW DOWN THE MATCHES TO JUST THOSE THAT EITHER HAVE A CNP_NAME MATCH OR DUNS OR CORPKEY, FEIN OR DUNS
  BUT STILL MISMATCH
  BECAUSE OTHERWISE I AM GETTING SOME WHERE THEY DON'T LOOK LIKE THEY SHOULD MATCH BECAUSE THERE WAS TRANSITIVE CLOSURE IN THE CLUSTERING MACRO
  FOCUS ON THE ONES THAT HAVE SOME INFO THAT LOOK LIKE A GOOD MATCH, BUT HAVE OTHER ISSUES THAT PREVENT THE MATCH!!!
*/
mtch_filtered := mtch(conf < BIPV2_ProxID.Config.MatchThreshold, (cnp_name_score > 0 or active_domestic_corp_key_score > 0 or company_fein_score > 0 or active_duns_number_score > 0)  );

ds_mtch_add_new_proxid := join(mtch_filtered ,ds_mapping_table ,left.proxid1 = right.proxid_old  ,transform({unsigned6 proxid,recordof(left)},self.proxid := right.proxid,self := left)  ,hash,keep(1))
: persist('~persist::ds_mtch_add_new_proxid'  );

ds_add_rid  := project(ds_mtch_add_new_proxid,transform({unsigned record_rid,recordof(left)},self.record_rid := counter,self := left))
: persist('~persist::ds_add_rid'  );

  layouttools3 := tools.macf_LayoutTools(recordof(ds_add_rid),false,'^(?!.*?(left|right|skipped|_score).*).*$',true);
  mtch_score3 := project(ds_add_rid,layouttools3.layout_record)
  : persist('~persist::mtch_score3'  );

  layspecs := {unsigned record_rid,string fieldname,string fieldvalue};
  layouttools2 := tools.macf_LayoutTools(recordof(ds_add_rid),false,'^(?!record_rid).*$',true);

  dnorm_specs2 := normalize(ds_add_rid,count(layouttools2.setAllFields),transform({unsigned field_rid,layspecs}
    ,self.fieldname 	:= layouttools2.fGetFieldName(counter);
    ,self.fieldvalue	:= (string)layouttools2.fGetFieldValue(counter,left)
    ,self.record_rid  := left.record_rid
    ,self.field_rid   := counter;
  ))
  : persist('~persist::dnorm_specs2'  );


  diterate          := iterate(sort(distribute(dnorm_specs2,record_rid),record_rid,field_rid,local),transform(recordof(left)
                         ,self.field_rid := map(regexfind('^left_|^conf$',right.fieldname,nocase) and not regexfind('^support_',left.fieldname,nocase) => right.field_rid  
                                          ,regexfind('^support_',left.fieldname + right.fieldname,nocase) => 1
                                          ,left.field_rid 
                         ) 
                         ,self := right ),local)
  : persist('~persist::diterate'  );
  
  
  dproj             := project(diterate,transform(
                           {unsigned record_rid,unsigned field_rid,dataset(layspecs) child}
                          ,self := left
                          ,self.child := dataset([{left.field_rid,left.fieldname,left.fieldvalue}],layspecs)
                       ))
  : persist('~persist::dproj'  );
                       
  drollup           := rollup(sort(dproj,record_rid,field_rid),left.record_rid = right.record_rid,transform(recordof(left),self.child := left.child + right.child,self := left))
  : persist('~persist::drollup'  );

  // rollup child dataset now
  dprojme := project(drollup,transform(
      {unsigned record_rid,unsigned field_rid,dataset({unsigned record_rid,dataset(layspecs - record_rid) child}) child}
      ,self.record_rid       := left.record_rid
      ,self.field_rid  := left.field_rid
      ,self.child     := project(left.child
                            ,transform(
                              {unsigned record_rid,dataset(layspecs - record_rid) child}
                              ,self.record_rid   := left.record_rid
                              ,self.child := dataset([{left.fieldname,left.fieldvalue}],{layspecs - record_rid}))) 
  ))
  : persist('~persist::dprojme'  );

  //
  drollup2 := project(dprojme,transform(recordof(left)
    ,self.child := rollup(left.child,left.record_rid = right.record_rid,transform(recordof(left),self.child := left.child + right.child,self := left))
    ,self := left
  ))
  : persist('~persist::drollup2'  );

  
  dsortchild        := project(drollup2,transform(recordof(left)
    ,self.child := project(left.child,transform(recordof(left),self.child := 
                   sort(left.child  ,map(regexfind('^left_'   ,fieldname,nocase) => 1
                                        ,regexfind('^right_'  ,fieldname,nocase) => 2
                                        ,regexfind('_score$'  ,fieldname,nocase) => 3
                                        ,regexfind('_skipped$',fieldname,nocase) => 4
                                        ,                                           0
                                    ))
                                    ,self := left
                  ))
   ,self := left
  ))
  : persist('~persist::dsortchild'  );


  dproj3            := project(sort(project(dsortchild,transform(
                        {unsigned record_rid,unsigned field_rid,dataset({unsigned record_rid,dataset(layspecs - record_rid) child,string score,string skipped}) child}
                        ,self.child   := project(left.child,transform({unsigned record_rid,dataset(layspecs - record_rid) child,string score,string skipped}
                                            ,self.child   := left.child(not regexfind('_score$|_skipped$',fieldname,nocase))
                                            ,self.score   := left.child(    regexfind('_score$'   ,fieldname,nocase))[1].fieldvalue
                                            ,self.skipped := left.child(    regexfind('_skipped$' ,fieldname,nocase))[1].fieldvalue
                                            ,self.record_rid     := left.record_rid
                                         ))

                        ,self := left
                                                         )),record_rid,field_rid),{recordof(left)/* - record_rid - field_rid*/})
  : persist('~persist::dproj3'  );

 
  dnorm_specs_filt2 := project(dproj3,transform(
                        {unsigned record_rid,unsigned field_rid,dataset({dataset(layspecs - record_rid) child,string score,string skipped}) child}
    ,self.child := project(left.child(count(child(regexfind('^conf$',fieldname,nocase))) > 0 or (unsigned)score != 0),recordof(left) - record_rid)
//    ,self.child := left.child(count(child(regexfind('^conf$',fieldname,nocase))) >0 or (unsigned)score != 0)
    ,self := left
  ))
  : persist('~persist::dnorm_specs_filt2'  );
  
  djoinme := join(dnorm_specs_filt2,mtch_score3,left.record_rid = right.record_rid,transform({recordof(right) - record_rid,recordof(left) - record_rid - field_rid},self := right,self := left))
  : persist('~persist::djoinme'  );

djoinme_add_new_proxid := join(djoinme ,ds_mapping_table ,left.proxid1 = right.proxid_old  ,transform({unsigned6 proxid,recordof(left)},self.proxid := right.proxid,self := left)  ,hash)
: persist('~persist::djoinme_add_new_proxid'  );

// --------------------------------
djoinme_prep_norm := project(distribute(djoinme_add_new_proxid)  ,transform({recordof(left)},self.child := left.child((integer)score < 0) ,self := left ));
djoinme_norm      := normalize(djoinme_prep_norm  ,left.child ,transform({unsigned6 proxid,djoinme.conf,unsigned6 proxid1,unsigned6 proxid2,string fieldname,string fieldscore}
  ,self.proxid      := left.proxid
  ,self.conf        := left.conf
  ,self.proxid1     := left.proxid1
  ,self.proxid2     := left.proxid2
  ,self.fieldname   := trim(right.child(regexfind('left_',fieldname,nocase))[1].fieldname[6..])
  ,self.fieldscore  := right.score
));

ds_agg_fields := table(djoinme_norm((integer)conf < BIPV2_ProxID.Config.MatchThreshold) ,{fieldname ,unsigned cnt := count(group),unsigned cnt_force_violated := sum(group,if((integer)fieldscore = -9999,1,0)) } ,fieldname ,merge);


ds_agg_stats := table(djoinme_norm  ,{
   unsigned cnt_comparisons     := count(group)
  ,unsigned cnt_above_threshold := sum(group,if((integer)conf >= BIPV2_ProxID.Config.MatchThreshold,1,0))
  ,unsigned cnt_at_threshold    := sum(group,if((integer)conf  = BIPV2_ProxID.Config.MatchThreshold,1,0))
  ,unsigned cnt_below_threshold := sum(group,if((integer)conf <  BIPV2_ProxID.Config.MatchThreshold,1,0))
} ,true ,merge);

//what do I want in the end here?  a way to describe why these clusters are not joining together
//what are the top reasons why???
//such as cnp_number mismatch
//such as partition mismatch
//not enough iterations
//etc



ds_stats3 := dataset([


   {'mtch '                 ,count(mtch  )}
  ,{'mtch_filtered '                 ,count(mtch_filtered  )}
  ,{'ds_mtch_add_new_proxid '                 ,count(ds_mtch_add_new_proxid  )}
  ,{'ds_add_rid             '                 ,count(ds_add_rid              )}
  ,{'mtch_score3            '                 ,count(mtch_score3             )}
  ,{'dnorm_specs2           '                 ,count(dnorm_specs2            )}
  ,{'diterate               '                 ,count(diterate                )}
  ,{'dproj                  '                 ,count(dproj                   )}
  ,{'drollup                '                 ,count(drollup                 )}
  ,{'dprojme                '                 ,count(dprojme                 )}
  ,{'drollup2               '                 ,count(drollup2                )}
  ,{'dsortchild             '                 ,count(dsortchild              )}
  ,{'dproj3                 '                 ,count(dproj3                  )}
  ,{'dnorm_specs_filt2      '                 ,count(dnorm_specs_filt2       )}
  ,{'djoinme                '                 ,count(djoinme                 )}
  
  ,{'djoinme_add_new_proxid    '                 ,count(djoinme_add_new_proxid                 )}
  ,{'djoinme_prep_norm         '                 ,count(djoinme_prep_norm                      )}
  ,{'djoinme_norm              '                 ,count(djoinme_norm                           )}
  ,{'ds_agg_fields             '                 ,count(ds_agg_fields                          )}
  ,{'ds_agg_stats              '                 ,count(ds_agg_stats                 )}

],{string stat,unsigned cnt});

output(ds_stats3 ,named('ds_stats'),extend);

// output(choosen(mtch                      ,200) ,named('mtch'      ),all);
output(choosen(mtch_filtered             ,200) ,named('mtch_filtered'               ),all);
output(choosen(ds_mtch_add_new_proxid    ,200) ,named('ds_mtch_add_new_proxid'      ),all);
output(choosen(ds_add_rid                ,200) ,named('ds_add_rid'                  ),all);
output(choosen(mtch_score3               ,200) ,named('mtch_score3'                 ),all);
output(choosen(dnorm_specs2              ,200) ,named('dnorm_specs2'                ),all);
output(choosen(diterate                  ,200) ,named('diterate'                    ),all);
output(choosen(dproj                     ,200) ,named('dproj'                       ),all);
output(choosen(drollup                   ,200) ,named('drollup'                     ),all);
output(choosen(dprojme                   ,200) ,named('dprojme'                     ),all);
output(choosen(drollup2                  ,200) ,named('drollup2'                    ),all);
output(choosen(dsortchild                ,200) ,named('dsortchild'                  ),all);
output(choosen(dproj3                    ,200) ,named('dproj3'                      ),all);
output(choosen(dnorm_specs_filt2         ,200) ,named('dnorm_specs_filt2'           ),all);
output(choosen(djoinme                   ,200) ,named('djoinme'                     ),all);

output(choosen(djoinme_add_new_proxid   ,200) ,named('djoinme_add_new_proxid'      ),all);
output(choosen(djoinme_prep_norm        ,200) ,named('djoinme_prep_norm'           ),all);
output(choosen(djoinme_norm             ,200) ,named('djoinme_norm'                ),all);
output(choosen(ds_agg_fields            ,200) ,named('ds_agg_fields'               ),all);
output(topn(ds_agg_fields            ,200,-cnt) ,named('topn_ds_agg_fields_cnt'               ),all);
output(topn(ds_agg_fields            ,200,-cnt_force_violated) ,named('topn_ds_agg_fields_cnt_force_violated'               ),all);
output(choosen(ds_agg_stats             ,200) ,named('ds_agg_stats'                ),all);
output(topn(ds_agg_stats            ,200,-cnt_comparisons) ,named('topn_ds_agg_stats_cnt_comparisons'               ),all);
output(topn(ds_agg_stats            ,200,-cnt_above_threshold) ,named('topn_ds_agg_stats_cnt_above_threshold'               ),all);
output(topn(ds_agg_stats            ,200,-cnt_at_threshold   ) ,named('topn_ds_agg_stats_cnt_at_threshold'                  ),all);
output(topn(ds_agg_stats            ,200,-cnt_below_threshold) ,named('topn_ds_agg_stats_cnt_below_threshold'               ),all);