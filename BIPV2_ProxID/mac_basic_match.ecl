import tools,ut,bipv2_files,mdr,bipv2;
EXPORT mac_basic_match(
  dataset(layout_dot_base) pDataset  = BIPV2_Files.files_proxid().DS_PROXID_BASE + project(BIPV2_Files.files_dotid.DS_DOTID_BASE(mdr.sourcetools.sourceisZoom(source)),transform(recordof(left),self.proxid := if(left.proxid = 0,left.dotid,left.proxid),self :=left))
) :=
function
ds_in := pDataset;
// ds_in := BIPV2_Files.files_proxid().DS_PROXID_BASE(st='WY');
//only use recs that have fields we need
ds_filt := ds_in(cnp_name<>'',prim_name<>'',st<>'',v_city_name<>'' or zip<>'');
l_patch := record
	unsigned4 h;
	unsigned6 proxid1;
	unsigned6 proxid2:=0;
end;
//further filter for fields that have force and prop on them
ds_filt2 := ds_filt(trim(active_duns_number + active_domestic_corp_key + active_enterprise_number + cnp_number,all) != '');
ds_prep := table(ds_filt2  ,{proxid,cnp_number,active_duns_number,active_enterprise_number,active_domestic_corp_key});
ds_agg  := tools.mac_AggregateFieldsPerID(ds_prep,proxid,,false);
//reset overlinks first
ds_agg_overlinks := table(ds_agg(
   count(cnp_numbers               ) > 1
or count(active_duns_numbers       ) > 1
or count(active_domestic_corp_keys ) > 1
or count(active_enterprise_numbers ) > 1
) ,{proxid});
ds_agg_notoverlinks := table(ds_agg(not(
   count(cnp_numbers               ) > 1
or count(active_duns_numbers       ) > 1
or count(active_domestic_corp_keys ) > 1
or count(active_enterprise_numbers ) > 1
)) ,{proxid});
ds_removeoverlinks := join(
   ds_filt
  ,ds_agg_overlinks
  ,left.proxid = right.proxid
  ,transform(
     recordof(left)
//    ,self.proxid  := if(right.proxid != 0  ,left.dotid ,left.proxid)
    ,self         := left
  )
  ,left only
);
ds_aggremove  := tools.mac_AggregateFieldsPerID(ds_removeoverlinks,proxid,['cnp_number','active_duns_number','active_domestic_corp_key','active_enterprise_number'],false);
ds_aggremove_overlinks := table(ds_aggremove(
   count(cnp_numbers               ) > 1
or count(active_duns_numbers       ) > 1
or count(active_domestic_corp_keys ) > 1
or count(active_enterprise_numbers ) > 1
) ,{proxid});
//propagate force, prop fields
ds_proj := project(ds_aggremove,transform(
  {unsigned6 proxid,string cnp_number,string active_duns_number,string active_enterprise_number,string active_domestic_corp_key}
  ,self.proxid                    := left.proxid
  ,self.active_duns_number        := left.active_duns_numbers      [1].active_duns_number      
  ,self.active_domestic_corp_key  := left.active_domestic_corp_keys[1].active_domestic_corp_key
  ,self.active_enterprise_number  := left.active_enterprise_numbers[1].active_enterprise_number
  ,self.cnp_number                := left.cnp_numbers              [1].cnp_number              
));
ds_prop := join(
   ds_removeoverlinks
  ,ds_proj
  ,left.proxid = right.proxid
  ,transform(
     recordof(left)
    ,self.active_duns_number        := right.active_duns_number
    ,self.active_domestic_corp_key  := right.active_domestic_corp_key
    ,self.active_enterprise_number  := right.active_enterprise_number
    ,self.cnp_number                := right.cnp_number
    ,self                           := left
  )
  ,left outer
);
ds_hash := dedup(project(ds_prop, transform(l_patch,
	self.h:=hash64(left.active_duns_number,left.active_enterprise_number,left.active_domestic_corp_key,left.cnp_name,left.cnp_number,left.cnp_btype,left.company_fein,left.prim_range,left.prim_name,left.v_city_name,left.st,left.zip),
	self.proxid1:=left.proxid)),h,proxid1,all);
  
ds_dist   := distribute(ds_hash,h);
//patch lowest proxid2 per h
ds_patch1 := table(ds_dist, {h, unsigned6 proxid2:=min(group,proxid1)}, h, local);
ds_join   := join(ds_dist, ds_patch1, left.h=right.h, transform(l_patch, self:=right, self:=left), local);
//patch lowest proxid2 per proxid1
ds_patch2 := table(ds_join, {proxid1, unsigned6 proxid2:=min(group,ut.min2(proxid2,proxid1))}, proxid1);
ds_join2  := join(ds_join, ds_patch2, left.proxid1=right.proxid1, transform(l_patch, self.proxid2:=right.proxid2, self:=left))(proxid1>proxid2);
ds_doublecheck := table(ds_join2,{proxid1,proxid2},proxid1,proxid2);
ut.MAC_Patch_Id(ds_in,proxid,ds_doublecheck,proxid1,proxid2,ds_out); // Join Clusters
ds_aggout  := tools.mac_AggregateFieldsPerID(ds_out,proxid,['cnp_number','active_duns_number','active_domestic_corp_key','active_enterprise_number'],false);
ds_aggout_overlinks := table(ds_aggout(
   count(cnp_numbers               ) > 1
or count(active_duns_numbers       ) > 1
or count(active_domestic_corp_keys ) > 1
or count(active_enterprise_numbers ) > 1
) ,{proxid});
//proxid count before/after
dproxidsbefore  := count(table(table(ds_in  ,{proxid},proxid,local),{proxid},proxid));
dproxidsreset   := count(table(table(ds_removeoverlinks  ,{proxid},proxid,local),{proxid},proxid));
dproxidsafter   := count(table(table(ds_out ,{proxid},proxid,local),{proxid},proxid));
//get samples
ds_top10ChangedProxids := topn(table(ds_patch2  ,{proxid2, unsigned8 cnt := count(group)},proxid2),10,-cnt) : global;
newproxids        := ds_out(proxid in set(ds_top10ChangedProxids,proxid2)) : global;
rcidsOfNewProxids := table(newproxids ,{rcid});
oldproxids        := join(ds_in,rcidsOfNewProxids,left.rcid = right.rcid,transform(left)) : global;
setproxids1        := set(ds_patch2(proxid2 = ds_top10ChangedProxids[1 ].proxid2),proxid1) + [ds_top10ChangedProxids[1 ].proxid2];
setproxids2        := set(ds_patch2(proxid2 = ds_top10ChangedProxids[2 ].proxid2),proxid1) + [ds_top10ChangedProxids[2 ].proxid2];
setproxids3        := set(ds_patch2(proxid2 = ds_top10ChangedProxids[3 ].proxid2),proxid1) + [ds_top10ChangedProxids[3 ].proxid2];
setproxids4        := set(ds_patch2(proxid2 = ds_top10ChangedProxids[4 ].proxid2),proxid1) + [ds_top10ChangedProxids[4 ].proxid2];
setproxids5        := set(ds_patch2(proxid2 = ds_top10ChangedProxids[5 ].proxid2),proxid1) + [ds_top10ChangedProxids[5 ].proxid2];
setproxids6        := set(ds_patch2(proxid2 = ds_top10ChangedProxids[6 ].proxid2),proxid1) + [ds_top10ChangedProxids[6 ].proxid2];
setproxids7        := set(ds_patch2(proxid2 = ds_top10ChangedProxids[7 ].proxid2),proxid1) + [ds_top10ChangedProxids[7 ].proxid2];
setproxids8        := set(ds_patch2(proxid2 = ds_top10ChangedProxids[8 ].proxid2),proxid1) + [ds_top10ChangedProxids[8 ].proxid2];
setproxids9        := set(ds_patch2(proxid2 = ds_top10ChangedProxids[9 ].proxid2),proxid1) + [ds_top10ChangedProxids[9 ].proxid2];
setproxids10       := set(ds_patch2(proxid2 = ds_top10ChangedProxids[10].proxid2),proxid1) + [ds_top10ChangedProxids[10].proxid2];
ds_agginbigs  := sort(BIPV2_ProxID.AggregateProxidElements(oldproxids),proxid) : global;
ds_aggoutbigs := sort(BIPV2_ProxID.AggregateProxidElements(newproxids),proxid) : global;
return
sequential(
  parallel(
     output(count(ds_prop                    ),named('ds_prop' ))
    ,output(count(ds_hash                    ),named('ds_hash' ))
    ,output(count(ds_dist                    ),named('ds_dist' ))
    ,output(count(ds_patch1                  ),named('ds_patch1' ))
    ,output(count(ds_join                    ),named('ds_join' ))
    ,output(count(ds_patch2                  ),named('ds_patch2' ))
    ,output(count(ds_join2                   ),named('ds_join2' ))
    ,output(count(ds_doublecheck             ),named('ds_doublecheck' ))
    
    ,output(ds_doublecheck,,'~temp::lbentley::BIPV2_ProxID::basic_match::patch'          ,compressed,overwrite)
    ,output(ds_out   ,,BIPV2_ProxID.filenames(bipv2.KeySuffix + 'a_27').base.logical,compressed,overwrite)
    ,output(dproxidsbefore                    ,named('PreClusterCount' ))
    ,output(dproxidsreset                     ,named('PreClusterReset'  ))
    ,output(dproxidsafter                     ,named('PostClusterCount'  ))
    ,output(dproxidsbefore - dproxidsafter    ,named('MatchesPerformed'  ))
    ,output(ds_top10ChangedProxids            ,named('Top10ChangedProxids'))
    ,output(count(ds_agg_overlinks)                           ,named('CountOverlinksBefore'     ),all)
    ,output(count(ds_aggremove_overlinks)                     ,named('CountOverlinksAfterRemove'),all)
    ,output(count(ds_aggout_overlinks)                        ,named('CountOverlinksAfter'     ),all)
    ,output(count(ds_agginbigs)                               ,named('countProxidsBefore'     ),all)
    ,output(count(ds_aggoutbigs)                              ,named('countProxidsAfter'      ),all)
    ,output(choosen(ds_agginbigs (proxid in setproxids1),100) ,named('InfileBigProxidChanged1'),all)
    ,output(choosen(ds_agginbigs (proxid in setproxids2),100) ,named('InfileBigProxidChanged2'),all)
    ,output(choosen(ds_agginbigs (proxid in setproxids3),100) ,named('InfileBigProxidChanged3'),all)
    ,output(choosen(ds_agginbigs (proxid in setproxids4),100) ,named('InfileBigProxidChanged4'),all)
    ,output(choosen(ds_agginbigs (proxid in setproxids5),100) ,named('InfileBigProxidChanged5'),all)
    ,output(choosen(ds_agginbigs (proxid in setproxids6),100) ,named('InfileBigProxidChanged6'),all)
    ,output(choosen(ds_agginbigs (proxid in setproxids7),100) ,named('InfileBigProxidChanged7'),all)
    ,output(choosen(ds_agginbigs (proxid in setproxids8),100) ,named('InfileBigProxidChanged8'),all)
    ,output(choosen(ds_agginbigs (proxid in setproxids9),100) ,named('InfileBigProxidChanged9'),all)
    ,output(choosen(ds_agginbigs (proxid in setproxids10),100) ,named('InfileBigProxidChanged10'),all)
    ,output(choosen(ds_aggoutbigs(proxid in setproxids1),10) ,named('OutfileBigProxidChanged1'),all)
    ,output(choosen(ds_aggoutbigs(proxid in setproxids2),10) ,named('OutfileBigProxidChanged2'),all)
    ,output(choosen(ds_aggoutbigs(proxid in setproxids3),10) ,named('OutfileBigProxidChanged3'),all)
    ,output(choosen(ds_aggoutbigs(proxid in setproxids4),10) ,named('OutfileBigProxidChanged4'),all)
    ,output(choosen(ds_aggoutbigs(proxid in setproxids5),10) ,named('OutfileBigProxidChanged5'),all)
    ,output(choosen(ds_aggoutbigs(proxid in setproxids6),10) ,named('OutfileBigProxidChanged6'),all)
    ,output(choosen(ds_aggoutbigs(proxid in setproxids7),10) ,named('OutfileBigProxidChanged7'),all)
    ,output(choosen(ds_aggoutbigs(proxid in setproxids8),10) ,named('OutfileBigProxidChanged8'),all)
    ,output(choosen(ds_aggoutbigs(proxid in setproxids9),10) ,named('OutfileBigProxidChanged9'),all)
    ,output(choosen(ds_aggoutbigs(proxid in setproxids10),10) ,named('OutfileBigProxidChanged10'),all)
  )
);
end;
