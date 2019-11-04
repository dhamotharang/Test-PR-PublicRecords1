/*
  Get from BIP base:
    msa
    err_stat
    dt_first_seen
    dt_last_seen
    age_of_company
    
*/
import BIPV2,ut;
EXPORT Best_From_BIP_Base_Proxid(

   dataset(recordof(Marketing_List.Source_Files().bip_base) ) pDataset_Base = Marketing_List.Source_Files().bip_base
  ,dataset(Marketing_List.Layouts.business_information_prep ) pBest_Prep    = Marketing_List.Best_From_BIP_Best_Proxid()
) :=
function

  // -- define set of marketing approved sources
  ds_base       := pDataset_Base;
  mktg_sources  := Marketing_List._Config().set_marketing_approved_sources;

  // -- Filter base file for only marketing sources, active proxids, company name non-blank, and address non-blank
  ds_base_clean := ds_base;
  ds_base_filt  := ds_base_clean(source in mktg_sources ,trim(proxid_status_public) = ''  ,trim(company_name) != ''  ,trim(prim_name) != ''  ,trim(v_city_name) != '' ,trim(st) != '',trim(zip) != '');

  // -- slim down best file to just seleid and address, slim down base file to just seleid, address and msa and err_stat
  ds_Best_Prep          := table(pBest_Prep ,{proxid,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,v_city_name,st,zip});
  ds_base_prep          := table(ds_base_filt(trim(msa) != '' or trim(err_stat) != '')  ,{proxid,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,v_city_name,st,zip,msa,err_stat} ,proxid,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,v_city_name,st,zip,msa,err_stat ,merge);

  // -- dedup slim base file on seleid and address for msa and err_stat
  ds_base_msa_prep      := dedup(sort(distribute(ds_base_prep(trim(msa     ) != '')  ,hash(proxid)),proxid,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,v_city_name,st,zip,local),proxid,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,v_city_name,st,zip ,local);
  ds_base_err_stat_prep := dedup(sort(distribute(ds_base_prep(trim(err_stat) != '')  ,hash(proxid)),proxid,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,v_city_name,st,zip,local),proxid,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,v_city_name,st,zip ,local);
  
  // -- get MSA and err_stat from best prep file to make sure we pull them from the exact same address
  ds_base_msa := join(ds_Best_Prep  ,ds_base_msa_prep   ,     left.proxid  = right.proxid  and left.prim_range = right.prim_range and left.predir    = right.predir     and left.prim_name    = right.prim_name   and left.addr_suffix  = right.addr_suffix 
                                                          and left.postdir = right.postdir and left.unit_desig = right.unit_desig and left.sec_range = right.sec_range  and left.v_city_name  = right.v_city_name and left.st           = right.st 
                                                          and left.zip     = right.zip  
                    ,transform(Marketing_List.Layouts.business_information_prep
                      ,self.msa       := right.msa
                      // ,self.err_stat  := right.err_stat
                      ,self           := left
                      ,self := []
                    )
                  ,keep(1),left outer,hash);
                  
  ds_base_err_stat := join(ds_base_msa  ,ds_base_err_stat_prep   ,    left.proxid  = right.proxid  and left.prim_range = right.prim_range and left.predir    = right.predir     and left.prim_name    = right.prim_name   and left.addr_suffix  = right.addr_suffix 
                                                                  and left.postdir = right.postdir and left.unit_desig = right.unit_desig and left.sec_range = right.sec_range  and left.v_city_name  = right.v_city_name and left.st           = right.st 
                                                                  and left.zip     = right.zip  
                    ,transform(Marketing_List.Layouts.business_information_prep
                      // ,self.msa       := right.msa
                      ,self.err_stat  := right.err_stat
                      ,self           := left
                      ,self := []
                    )
                  ,keep(1),left outer,hash);

   // -- get age, dt_xxx_seen
   ds_base_age_prep := table(ds_base_filt(dt_first_seen != 0 or dt_last_seen != 0) ,{proxid  ,unsigned4 dt_first_seen := min(group,if(dt_first_seen = 0  ,99999999 ,dt_first_seen))  ,unsigned4 dt_last_seen := max(group,dt_last_seen)} ,proxid ,merge );
   ds_base_age  := project(ds_base_age_prep ,transform({recordof(left),string3 age_of_company}
      ,dt_first_seen := if(left.dt_first_seen = 99999999  ,0  ,left.dt_first_seen);
       self.dt_first_seen   := if(dt_first_seen  = 0 and left.dt_last_seen != 0 ,left.dt_last_seen  ,     dt_first_seen);
       self.dt_last_seen    := if(dt_first_seen != 0 and left.dt_last_seen  = 0 ,     dt_first_seen ,left.dt_last_seen );
       self.age_of_company  := if(ut.Age(self.dt_first_seen) > 0  ,(string3)ut.Age(self.dt_first_seen) ,'');
       self.proxid          := left.proxid
       
   ));
   
   // -- get latest business email
   ds_base_email_prep := table(ds_base_filt(trim(contact_email) != '')  ,{proxid,dt_last_seen,string60 business_email := contact_email} ,proxid,dt_last_seen ,contact_email,merge);
   ds_base_email      := dedup(sort(distribute(ds_base_email_prep ,hash(proxid)) ,proxid,-dt_last_seen,business_email,local) ,proxid,local);
   
   // -- append dt_xxx_seen ,age_of_company , and business email
   ds_add_age   := join(ds_base_err_stat  ,ds_base_age    ,left.proxid = right.proxid ,transform(recordof(left),self.dt_first_seen  := right.dt_first_seen ,self.dt_last_seen := right.dt_last_seen,self.age_of_company := right.age_of_company,self := left)  ,left outer,hash);
   ds_add_email := join(ds_add_age        ,ds_base_email  ,left.proxid = right.proxid ,transform(recordof(left),self.business_email := right.business_email,self := left)  ,left outer,hash);
   
  return ds_add_email;
end;