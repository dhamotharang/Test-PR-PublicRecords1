// 1.3%
// = 98.7%

#workunit('name','Seleid recall stats');

//corpkey
//duns number
//fein
//sbfe_id
//ent num


ds_bip_base   := bipv2.CommonBase.ds_base;
ds_bip_prep := table(ds_bip_base  ,{seleid
  ,string cnp_name_addr := if(cnp_name != '' and prim_name != '' and (v_city_name != '' or zip != '') ,(string)hash64(cnp_name,prim_range,prim_name,v_city_name,zip)  ,'')
  ,string corp_key	    := if(company_inc_state != '' and company_charter_number != ''	,trim(company_inc_state,left,right) + '-' + trim(company_charter_number,left,right)	,'')
  ,string sbfe_id       := if(mdr.sourcetools.SourceIsBusiness_Credit(source),vl_id ,'')
  ,company_fein
  ,duns_number
  ,active_enterprise_number
  });

ds_bip_prep_dedup := table(ds_bip_prep  ,{seleid,cnp_name_addr,corp_key,sbfe_id,company_fein,duns_number,active_enterprise_number} ,seleid,cnp_name_addr,corp_key,sbfe_id,company_fein,duns_number,active_enterprise_number ,merge);

ds_bip_prep_child := project(ds_bip_prep_dedup  ,transform({unsigned6 seleid,dataset({string grouping})  ds_grouping_fields} 
  ,self.ds_grouping_fields := (
      dataset([{if(left.cnp_name_addr              != '' ,'CNPADDR-' + left.cnp_name_addr             ,'')}],{string grouping}) 
    + dataset([{if(left.corp_key                   != '' ,'CORPKEY-' + left.corp_key                  ,'')}],{string grouping}) 
    + dataset([{if(left.sbfe_id                    != '' ,'SBFEID-'  + left.sbfe_id                   ,'')}],{string grouping}) 
    + dataset([{if(left.company_fein               != '' ,'FEIN-'    + left.company_fein              ,'')}],{string grouping}) 
    + dataset([{if(left.duns_number                != '' ,'DUNS-'    + left.duns_number               ,'')}],{string grouping}) 
    + dataset([{if(left.active_enterprise_number   != '' ,'ENTNUM-'  + left.active_enterprise_number  ,'')}],{string grouping}) 
    )(trim(grouping) != '')
  ,self := left));

ds_bip_prep_norm := normalize(ds_bip_prep_child ,left.ds_grouping_fields  ,transform({unsigned6 seleid,string grouping},self := right,self := left))(trim(grouping) != '');
ds_bip_prep_table := table(ds_bip_prep_norm ,{seleid,grouping} ,seleid,grouping ,merge) : persist('~persist::lbentley::ds_bip_prep_table');

// ds_base_table := table(ds_bip_base  ,{seleid,cnp_name,prim_range,prim_name,v_city_name,zip,string cname_addr_hash := (string)hash64(cnp_name,prim_range,prim_name,v_city_name,zip)} ,seleid,cnp_name,prim_range,prim_name,v_city_name,zip  ,merge);

BIPV2_Tools.mac_reform_clusters(ds_bip_prep_table,seleid,grouping,20);