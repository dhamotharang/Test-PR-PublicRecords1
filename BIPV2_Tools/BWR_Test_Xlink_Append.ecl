// BH449 -- test split rest of D&B fein
// -- modified BizLinkFull.Filename_keys to point to 20180402 keys(or whatever version you built in BIPV2_Tools.BWR_Test_Persistence_Stats)

ds_dnb_companies := DNB_DMI.Files().base.Companies.qa : persist('~persist::lbentley::BH449::ds_dnb_companies');
ds_dnb_contacts  := DNB_DMI.Files().base.Contacts.qa  : persist('~persist::lbentley::BH449::ds_dnb_contacts' );

ds_append_bip_ids := DNB_DMI.Append_Bdid(ds_dnb_companies,ds_dnb_contacts)   : persist('~persist::lbentley::BH449::ds_append_bip_ids' );

ds_strata_old  := strata.macf_Pops(ds_dnb_companies   ,'','file','string','Prod'      ,false,false,['proxid','seleid']);
ds_strata_new  := strata.macf_Pops(ds_append_bip_ids  ,'','file','string','Re-did'    ,false,false,['proxid','seleid']);

output(ds_strata_old + ds_strata_new  ,named('ds_strata_pop_stats'));

ds_compare_bip_ids := join(ds_dnb_companies  ,ds_append_bip_ids ,left.rid = right.rid ,transform(
  {unsigned6 proxid_old, unsigned6 proxid_new,unsigned6 seleid_old, unsigned6 seleid_new,dataset({string stat, unsigned value}) ds_stats,dataset({string file,recordof(left)}) recs}
  ,self.proxid_old  := left.proxid
  ,self.proxid_new  := right.proxid
  ,self.seleid_old  := left.seleid
  ,self.seleid_new  := right.seleid
  ,self.ds_stats    := dataset([
      {'Both Zero Proxid'             ,if(self.proxid_old  = 0 and self.proxid_new  = 0                                         ,1  ,0)}
     ,{'Same Populated Proxid'        ,if(self.proxid_old != 0 and self.proxid_new != 0 and self.proxid_old  = self.proxid_new  ,1  ,0)}
     ,{'Different Populated Proxids'  ,if(self.proxid_old != 0 and self.proxid_new != 0 and self.proxid_old != self.proxid_new  ,1  ,0)}
     ,{'Gained Proxid'                ,if(self.proxid_old  = 0 and self.proxid_new != 0                                         ,1  ,0)}
     ,{'Lost Proxid'                  ,if(self.proxid_old != 0 and self.proxid_new  = 0                                         ,1  ,0)}
     ,{'Both Zero Seleid'             ,if(self.Seleid_old  = 0 and self.Seleid_new  = 0                                         ,1  ,0)}
     ,{'Same Populated Seleid'        ,if(self.Seleid_old != 0 and self.Seleid_new != 0 and self.Seleid_old  = self.Seleid_new  ,1  ,0)}
     ,{'Different Populated Seleids'  ,if(self.Seleid_old != 0 and self.Seleid_new != 0 and self.Seleid_old != self.Seleid_new  ,1  ,0)}
     ,{'Gained Seleid'                ,if(self.Seleid_old  = 0 and self.Seleid_new != 0                                         ,1  ,0)}
     ,{'Lost Seleid'                  ,if(self.Seleid_old != 0 and self.Seleid_new  = 0                                         ,1  ,0)}
  ],{string stat, unsigned value})
  ,self.recs := 
     project(dataset(left ),transform({string file,recordof(left)},self.file := 'Prod'  ,self := left))
   + project(dataset(right),transform({string file,recordof(left)},self.file := 'Re-Did',self := left))
),hash);

ds_stats_norm := normalize(ds_compare_bip_ids  ,left.ds_stats  ,transform({string stat, unsigned value},self.stat := right.stat,self.value := right.value));

ds_stats := dataset([
      {'Total D&B File records'                                 ,count(ds_dnb_companies  ) ,'100.00' }
     ,{'Re-Appended D&B File records(should be same as above)'  ,count(ds_append_bip_ids ) ,'100.00' }
     
     ,{'Production Proxids'           ,count(ds_dnb_companies (proxid != 0)) ,realformat(count(ds_dnb_companies (proxid != 0)) / count(ds_dnb_companies) * 100.0,10,4) }
     ,{'Re-Append Proxids'            ,count(ds_append_bip_ids(proxid != 0)) ,realformat(count(ds_append_bip_ids(proxid != 0)) / count(ds_dnb_companies) * 100.0,10,4) }
     ,{'Both Zero Proxid'             ,sum(ds_stats_norm(trim(stat) = 'Both Zero Proxid'           ),value)}
     ,{'Same Populated Proxid'        ,sum(ds_stats_norm(trim(stat) = 'Same Populated Proxid'      ),value) ,realformat(sum(ds_stats_norm(trim(stat) = 'Same Populated Proxid'      ),value) / count(ds_dnb_companies(proxid != 0)) * 100.0,10,4)  }
     ,{'Different Populated Proxids'  ,sum(ds_stats_norm(trim(stat) = 'Different Populated Proxids'),value) ,realformat(sum(ds_stats_norm(trim(stat) = 'Different Populated Proxids'),value) / count(ds_dnb_companies(proxid != 0)) * 100.0,10,4)  }
     ,{'Gained Proxid'                ,sum(ds_stats_norm(trim(stat) = 'Gained Proxid'              ),value) ,realformat(sum(ds_stats_norm(trim(stat) = 'Gained Proxid'              ),value) / count(ds_dnb_companies(proxid != 0)) * 100.0,10,4)  }
     ,{'Lost Proxid'                  ,sum(ds_stats_norm(trim(stat) = 'Lost Proxid'                ),value) ,realformat(sum(ds_stats_norm(trim(stat) = 'Lost Proxid'                ),value) / count(ds_dnb_companies(proxid != 0)) * 100.0,10,4)  }

     ,{'Production Seleids'           ,count(ds_dnb_companies (seleid != 0)) ,realformat(count(ds_dnb_companies (seleid != 0)) / count(ds_dnb_companies) * 100.0,10,4) }
     ,{'Re-Append Seleids'            ,count(ds_append_bip_ids(seleid != 0)) ,realformat(count(ds_append_bip_ids(seleid != 0)) / count(ds_dnb_companies) * 100.0,10,4) }
     ,{'Both Zero Seleid'             ,sum(ds_stats_norm(trim(stat) = 'Both Zero Seleid'           ),value)}
     ,{'Same Populated Seleid'        ,sum(ds_stats_norm(trim(stat) = 'Same Populated Seleid'      ),value) ,realformat(sum(ds_stats_norm(trim(stat) = 'Same Populated Seleid'      ),value) / count(ds_dnb_companies(seleid != 0)) * 100.0,10,4)  }
     ,{'Different Populated Seleids'  ,sum(ds_stats_norm(trim(stat) = 'Different Populated Seleids'),value) ,realformat(sum(ds_stats_norm(trim(stat) = 'Different Populated Seleids'),value) / count(ds_dnb_companies(seleid != 0)) * 100.0,10,4)  }
     ,{'Gained Seleid'                ,sum(ds_stats_norm(trim(stat) = 'Gained Seleid'              ),value) ,realformat(sum(ds_stats_norm(trim(stat) = 'Gained Seleid'              ),value) / count(ds_dnb_companies(seleid != 0)) * 100.0,10,4)  }
     ,{'Lost Seleid'                  ,sum(ds_stats_norm(trim(stat) = 'Lost Seleid'                ),value) ,realformat(sum(ds_stats_norm(trim(stat) = 'Lost Seleid'                ),value) / count(ds_dnb_companies(seleid != 0)) * 100.0,10,4)  }
  ],{string stat, unsigned value,string pct := ''});

output(ds_stats,named('ds_ID_stats'));

output(choosen(ds_compare_bip_ids(proxid_old != 0 and proxid_new != 0 and proxid_old != proxid_new) ,100)  ,named('Proxid_Examples_Diff_proxids'  ));
output(choosen(ds_compare_bip_ids(proxid_old  = 0 and proxid_new != 0                             ) ,100)  ,named('Proxid_Examples_Gained_proxids'));
output(choosen(ds_compare_bip_ids(proxid_old != 0 and proxid_new  = 0                             ) ,100)  ,named('Proxid_Examples_Lost_proxids'  ));

output(choosen(ds_compare_bip_ids(seleid_old != 0 and seleid_new != 0 and seleid_old != seleid_new) ,100)  ,named('seleid_Examples_Diff_seleids'  ));
output(choosen(ds_compare_bip_ids(seleid_old  = 0 and seleid_new != 0                             ) ,100)  ,named('seleid_Examples_Gained_seleids'));
output(choosen(ds_compare_bip_ids(seleid_old != 0 and seleid_new  = 0                             ) ,100)  ,named('seleid_Examples_Lost_seleids'  ));
