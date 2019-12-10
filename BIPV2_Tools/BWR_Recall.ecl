/*
  this will group by the pGrouping_Field(which can be a hash of any fields you want, such as cnp_name and address)
  and patch onto every unique group the lowest cluster ID for that group.
  then, it will patch the lowest cluster ID that occurs within the current cluster ID.
  there is an optional parent ID which, if used, it will only group within that parent cluster ID, not the whole dataset.  This is useful
  for when you reset overlinked clusters and want to reform it within that parent cluster, without trying to link to any outside clusters.
  Used within mac_reform_loop with the counter parameter to loop and get to convergence.
*/
// BH-747 -- precision and recall for BIP
// 1.5%
// 98.5% recall
#workunit('name','Proxid recall stats');

ds_bip_base   := bipv2.CommonBase.ds_base;
ds_bip_prep := table(ds_bip_base  ,{proxid
  ,string cnp_name_addr             := if(cnp_name                  != '' and prim_name != '' and (v_city_name != '' or zip != '')  ,(string)hash64(cnp_name                ,prim_range,prim_name,v_city_name,zip)  ,'')
  ,string active_domestic_corp_key  := if(active_domestic_corp_key  != ''	and prim_name != '' and (v_city_name != '' or zip != '')  ,(string)hash64(active_domestic_corp_key,prim_range,prim_name,v_city_name,zip)	,'')
  ,string company_fein              := if(company_fein              != ''	and prim_name != '' and (v_city_name != '' or zip != '')  ,(string)hash64(company_fein            ,prim_range,prim_name,v_city_name,zip)	,'')
  ,string active_duns_number        := if(active_duns_number        != ''	and prim_name != '' and (v_city_name != '' or zip != '')  ,(string)hash64(active_duns_number      ,prim_range,prim_name,v_city_name,zip)	,'')
  });

ds_bip_prep_dedup := table(ds_bip_prep  ,{proxid,cnp_name_addr,active_domestic_corp_key,company_fein,active_duns_number} ,proxid,cnp_name_addr,active_domestic_corp_key,company_fein,active_duns_number ,merge);

ds_bip_prep_child := project(ds_bip_prep_dedup  ,transform({unsigned6 proxid,dataset({string grouping})  ds_grouping_fields} 
  ,self.ds_grouping_fields := (
      dataset([{if(left.cnp_name_addr            != '' ,'CNPADDR-' + left.cnp_name_addr            ,'')}],{string grouping}) 
    + dataset([{if(left.active_domestic_corp_key != '' ,'CORPKEY-' + left.active_domestic_corp_key ,'')}],{string grouping}) 
    + dataset([{if(left.company_fein             != '' ,'FEIN-'    + left.company_fein             ,'')}],{string grouping}) 
    + dataset([{if(left.active_duns_number       != '' ,'DUNS-'    + left.active_duns_number       ,'')}],{string grouping}) 
    )(grouping != '')
  ,self := left));

ds_bip_prep_norm := normalize(ds_bip_prep_child ,left.ds_grouping_fields  ,transform({unsigned6 proxid,string grouping},self := right,self := left));
ds_bip_prep_table := table(ds_bip_prep_norm ,{proxid,grouping} ,proxid,grouping ,merge) : persist('~persist::lbentley::ds_bip_prep_table');


BIPV2_Tools.mac_reform_clusters(ds_bip_prep_table,proxid,grouping,20);

// ds_base_table := table(ds_bip_base  ,{seleid,cnp_name,prim_range,prim_name,v_city_name,zip,string cname_addr_hash := (string)hash64(cnp_name,prim_range,prim_name,v_city_name,zip)} ,seleid,cnp_name,prim_range,prim_name,v_city_name,zip  ,merge);

// sequential(
   // output(dataset([{'proxid',0,count(table(ds_prep_slim,{proxid},proxid,merge))}],{string ID,unsigned iteration,unsigned cluster_count })  ,named('Clustering_Info'),extend)
  // ,output(choosen(ds_converge_it,300)  ,named('ds_converge_it'),all)
// );



// ds_converge_it := loop(ds_prep_slim  
  // ,exists(rows(left)(isdone = false))
  // ,BIPV2_Tools.mac_reform(rows(left), new_proxid,proxid,lowest_proxid,cname_addr_hash,counter)
  // );


// ds_cand_iter5 := loop(ds_iter_prep  
  ////,counter < 10 and exists(table(table(rows(left),{proxid,cnp_name,lowest_dotid},proxid,cnp_name,lowest_dotid,merge) ,{proxid,cnp_name,unsigned cnt := count(group)},proxid,cnp_name,merge) (cnt > 1))
  // ,counter < 10 and exists(rows(left)(isdone = false))
  // ,BIPV2_Tools.mac_reform(rows(left),counter)
  // );

    // ,mac_reform(project(rows(left),transform(recordof(left)
                                    // ,self.pParent_ID        := if(ds_prep_slim[1].pParent_ID = 0,0,left.pParent_ID)
                                    // ,self.pCluster_ID         := if(ds_prep_slim[1].pParent_ID = 0  //if parent id is zero, want the group by fields to go across whole dataset, not just within that parent id
                                                                  // ,if(left.pParent_ID = 0
                                                                    // ,left.pCluster_ID       
                                                                    // ,left.pParent_ID 
                                                                  // )
                                                                  // ,left.pCluster_ID                 //if parent id is populated, want the group by fields within the parent id.
                                                               // )
                                    // ,self.pLowest_Cluster_ID  := self.pCluster_ID
                                    // ,self                   := left
                // ))
                // ,pCluster_ID,pLowest_Cluster_ID,pGrouping_Field,counter,%CLUSTER_ID_OLD%/*,pParent_ID*/)
    // ,if(count(table(ds_prep_slim,{pParent_ID},pParent_ID,merge)) = 0,count(table(ds_prep_slim,{pCluster_ID},pCluster_ID,merge)),count(table(ds_prep_slim,{pParent_ID},pParent_ID,merge)))}],{string ID,unsigned iteration,unsigned cluster_count });
