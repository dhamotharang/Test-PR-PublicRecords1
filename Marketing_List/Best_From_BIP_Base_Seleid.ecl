/*
  Get from BIP base:
    msa
    err_stat
    dt_first_seen
    dt_last_seen
    age_of_company
    
*/
import BIPV2,ut;
EXPORT Best_From_BIP_Base_Seleid(
   string                                                     pversion        = BIPV2.KeySuffix
  ,dataset(recordof(Marketing_List.Source_Files().bip_base) ) pDataset_Base   = Marketing_List.Source_Files().bip_base
  ,dataset(Marketing_List.Layouts.business_information_prep ) pBest_Prep      = Marketing_List.Best_From_BIP_Best_Seleid()
  ,boolean                                                    pDebug          = false
  ,set of unsigned6                                           pSampleProxids  = []
) :=
function

  // -- define set of marketing approved sources
  ds_base       := pDataset_Base;
  mktg_sources  := Marketing_List._Config().set_marketing_approved_sources;

  // -- get debug seleids from proxids
  ds_debug_seleids  := table(pDataset_Base(proxid in pSampleProxids )  ,{seleid},seleid,few);
  set_debug_seleids := set(ds_debug_seleids ,seleid);

  // -- Filter base file for only marketing sources, active seleids, company name non-blank, and address non-blank
  ds_base_clean := ds_base;
  ds_base_filt  := ds_base_clean(source in mktg_sources ,trim(seleid_status_public) = ''  ,trim(company_name) != ''  ,trim(prim_name) != ''  ,trim(v_city_name) != '' ,trim(st) != '',trim(zip) != '');

  // -- slim down best file to just seleid and address, slim down base file to just seleid, address and msa and err_stat
  ds_Best_Prep  := table(pBest_Prep ,{seleid,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,v_city_name,st,zip});
  ds_base_prep  := table(ds_base_filt(trim(msa) != '' or trim(err_stat) != '')  ,{seleid,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,v_city_name,st,zip,msa,err_stat} ,seleid,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,v_city_name,st,zip,msa,err_stat ,merge);

  // -- dedup slim base file on seleid and address for msa and err_stat
  ds_base_msa_prep      := dedup(sort(distribute(ds_base_prep(trim(msa     ) != '')  ,hash(seleid)),seleid,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,v_city_name,st,zip,local),seleid,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,v_city_name,st,zip ,local);
  ds_base_err_stat_prep := dedup(sort(distribute(ds_base_prep(trim(err_stat) != '')  ,hash(seleid)),seleid,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,v_city_name,st,zip,local),seleid,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,v_city_name,st,zip ,local);
  
  // -- get MSA and err_stat from best prep file to make sure we pull them from the exact same address
  ds_base_msa := join(ds_Best_Prep  ,ds_base_msa_prep   ,     left.seleid  = right.seleid  and left.prim_range = right.prim_range and left.predir    = right.predir     and left.prim_name    = right.prim_name   and left.addr_suffix  = right.addr_suffix 
                                                          and left.postdir = right.postdir and left.unit_desig = right.unit_desig and left.sec_range = right.sec_range  and left.v_city_name  = right.v_city_name and left.st           = right.st 
                                                          and left.zip     = right.zip  
                    ,transform(Marketing_List.Layouts.business_information_prep
                      ,self.msa       := right.msa
                      // ,self.err_stat  := right.err_stat
                      ,self           := left
                      ,self := []
                    )
                  ,keep(1),left outer,hash);
                  
  ds_base_err_stat := join(ds_base_msa  ,ds_base_err_stat_prep   ,    left.seleid  = right.seleid  and left.prim_range = right.prim_range and left.predir    = right.predir     and left.prim_name    = right.prim_name   and left.addr_suffix  = right.addr_suffix 
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
   ds_base_age_prep := table(ds_base_filt(dt_first_seen != 0 or dt_last_seen != 0) ,{seleid  ,unsigned4 dt_first_seen := min(group,if(dt_first_seen = 0  ,99999999 ,dt_first_seen))  ,unsigned4 dt_last_seen := max(group,dt_last_seen)} ,seleid ,merge );
   ds_base_age  := project(ds_base_age_prep ,transform({recordof(left),string3 age_of_company},
       dt_first_seen := if(left.dt_first_seen = 99999999  ,0  ,Marketing_List.Validate_Date(left.dt_first_seen,pversion));
       dt_last_seen  := if(left.dt_last_seen  = 99999999  ,0  ,Marketing_List.Validate_Date(left.dt_last_seen ,pversion));
      
       self.dt_first_seen   := if((dt_first_seen  = 0 and dt_last_seen != 0) or (dt_first_seen > dt_last_seen and dt_last_seen != 0),dt_last_seen   ,dt_first_seen);  //if self.dt_first_seen is zero, then both are zero
       self.dt_last_seen    := map( self.dt_first_seen = 0 
                                    or (dt_first_seen = 0 and dt_last_seen != 0) or (dt_first_seen != 0 and dt_last_seen = 0) => self.dt_first_seen //both are zero or one of them is zero.  dt_first_seen took care of that
                                   ,dt_first_seen > dt_last_seen                                                              => dt_first_seen  
                                   ,                                                                                             dt_last_seen 
                               );
       self.age_of_company  := if(self.dt_first_seen > 17760704  ,(string3)ut.Age(self.dt_first_seen) ,'');
       self.seleid          := left.seleid
       
   ));
   
   // -- get latest business email
   ds_base_email_filtered := ds_base_filt(Marketing_List.Validate_Email(contact_email) != '');
   
   ds_base_email_prep := table(ds_base_email_filtered  ,{seleid,dt_last_seen,string60 business_email := contact_email} ,seleid,dt_last_seen ,contact_email,merge);
   ds_base_email      := dedup(sort(distribute(ds_base_email_prep ,hash(seleid)) ,seleid,-dt_last_seen,business_email,local) ,seleid,local);
   
   // -- append dt_xxx_seen ,age_of_company , and business email
   ds_add_age   := join(ds_base_err_stat  ,ds_base_age    ,left.seleid = right.seleid ,transform(recordof(left),self.dt_first_seen  := right.dt_first_seen ,self.dt_last_seen := right.dt_last_seen,self.age_of_company := right.age_of_company,self := left)  ,left outer,hash);
   ds_add_email := join(ds_add_age        ,ds_base_email  ,left.seleid = right.seleid ,transform(recordof(left),self.business_email := right.business_email,self := left)  ,left outer,hash);
   
  output_debug := parallel(
   
    output('---------------------Marketing_List.Best_From_BIP_Base_Seleid---------------------'            ,named('Marketing_List_Best_From_BIP_Base_Seleid'          ),all)
   ,output(choosen(pDataset_Base          (count(pSampleProxids) = 0 or seleid in set_debug_seleids),300)  ,named('Best_From_BIP_Base_Seleid_pDataset_Base'           ),all)
   ,output(choosen(pBest_Prep             (count(pSampleProxids) = 0 or seleid in set_debug_seleids),300)  ,named('Best_From_BIP_Base_Seleid_pBest_Prep'              ),all)
   ,output(choosen(ds_base_filt           (count(pSampleProxids) = 0 or seleid in set_debug_seleids),300)  ,named('Best_From_BIP_Base_Seleid_ds_base_filt'            ),all)
   ,output(choosen(ds_Best_Prep           (count(pSampleProxids) = 0 or seleid in set_debug_seleids),300)  ,named('Best_From_BIP_Base_Seleid_ds_Best_Prep'            ),all)
   ,output(choosen(ds_base_prep           (count(pSampleProxids) = 0 or seleid in set_debug_seleids),300)  ,named('Best_From_BIP_Base_Seleid_ds_base_prep'            ),all)
   ,output(choosen(ds_base_msa_prep       (count(pSampleProxids) = 0 or seleid in set_debug_seleids),300)  ,named('Best_From_BIP_Base_Seleid_ds_base_msa_prep'        ),all)
   ,output(choosen(ds_base_err_stat_prep  (count(pSampleProxids) = 0 or seleid in set_debug_seleids),300)  ,named('Best_From_BIP_Base_Seleid_ds_base_err_stat_prep'   ),all)
   ,output(choosen(ds_base_msa            (count(pSampleProxids) = 0 or seleid in set_debug_seleids),300)  ,named('Best_From_BIP_Base_Seleid_ds_base_msa'             ),all)
   ,output(choosen(ds_base_err_stat       (count(pSampleProxids) = 0 or seleid in set_debug_seleids),300)  ,named('Best_From_BIP_Base_Seleid_ds_base_err_stat'        ),all)
   ,output(choosen(ds_base_age_prep       (count(pSampleProxids) = 0 or seleid in set_debug_seleids),300)  ,named('Best_From_BIP_Base_Seleid_ds_base_age_prep'        ),all)
   ,output(choosen(ds_base_age            (count(pSampleProxids) = 0 or seleid in set_debug_seleids),300)  ,named('Best_From_BIP_Base_Seleid_ds_base_age'             ),all)
   ,output(choosen(ds_base_email_prep     (count(pSampleProxids) = 0 or seleid in set_debug_seleids),300)  ,named('Best_From_BIP_Base_Seleid_ds_base_email_prep'      ),all)
   ,output(choosen(ds_base_email          (count(pSampleProxids) = 0 or seleid in set_debug_seleids),300)  ,named('Best_From_BIP_Base_Seleid_ds_base_email'           ),all)
   ,output(choosen(ds_add_age             (count(pSampleProxids) = 0 or seleid in set_debug_seleids),300)  ,named('Best_From_BIP_Base_Seleid_ds_add_age'              ),all)
   ,output(choosen(ds_add_email           (count(pSampleProxids) = 0 or seleid in set_debug_seleids),300)  ,named('Best_From_BIP_Base_Seleid_ds_add_email'            ),all)
                                                                                                                                       
  );

  return when(ds_add_email  ,if(pDebug = true ,output_debug));
end;