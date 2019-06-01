ds_base := bipv2.CommonBase.ds_clean;

ds_proxid_prep := table(ds_base  ,{proxid,source,unsigned cnt := count(group)} ,proxid ,source,merge);
ds_seleid_prep := table(ds_base  ,{seleid,source,unsigned cnt := count(group)} ,seleid ,source,merge);

ds_proxid := table(ds_proxid_prep  ,{proxid,unsigned cnt := count(group)} ,proxid ,merge);
ds_seleid := table(ds_seleid_prep  ,{seleid,unsigned cnt := count(group)} ,seleid ,merge);

ds_proxid_sort := sort(distribute(ds_proxid(cnt > 1)),random(),local) : persist('~persist::BIPV2_Tools::BWR_Precision::ds_proxid_sort');
ds_seleid_sort := sort(distribute(ds_seleid(cnt > 1)),random(),local) : persist('~persist::BIPV2_Tools::BWR_Precision::ds_seleid_sort');

ds_proxid_enth := enth(ds_proxid_sort,300);
ds_seleid_enth := enth(ds_seleid_sort,300);

ds_proxid_samplerecs := join(ds_base  ,ds_proxid_enth ,left.proxid = right.proxid ,transform(left)  ,lookup) : persist('~persist::BIPV2_Tools::BWR_Precision::ds_proxid_samplerecs');
ds_seleid_samplerecs := join(ds_base  ,ds_seleid_enth ,left.seleid = right.seleid ,transform(left)  ,lookup) : persist('~persist::BIPV2_Tools::BWR_Precision::ds_seleid_samplerecs');

ds_proxid_samples_prep := BIPV2_Tools.AggregateProxidElements(ds_proxid_samplerecs  ,proxid,,false,false,false,false);
ds_seleid_samples_prep := BIPV2_Tools.AggregateProxidElements(ds_seleid_samplerecs  ,seleid,,false,false,false,false);

ds_proxid_samples := project(ds_proxid_samples_prep  ,transform({string Rating,recordof(left),string cluster_diff},
   self.Rating       := ''
  ,self.cluster_diff := '=MOD(IF(ROW()=3,0,IF(OR(B3=B2,B3=0),BU2,BU2+1)),2)'
  ,self              := left
));
ds_seleid_samples := project(ds_seleid_samples_prep  ,transform({string Rating,recordof(left),string cluster_diff},
   self.Rating       := ''
  ,self.cluster_diff := '=MOD(IF(ROW()=3,0,IF(OR(B3=B2,B3=0),BU2,BU2+1)),2)'
  ,self              := left
));

ds_stats := dataset([
   {'ds_base'             ,count(ds_base              )}
  ,{'ds_proxid'           ,count(ds_proxid            )}
  ,{'ds_seleid'           ,count(ds_seleid            )}
  ,{'ds_proxid_sort'      ,count(ds_proxid_sort       )}
  ,{'ds_seleid_sort'      ,count(ds_seleid_sort       )}
  ,{'ds_proxid_enth'      ,count(ds_proxid_enth       )}
  ,{'ds_seleid_enth'      ,count(ds_seleid_enth       )}
  ,{'ds_proxid_samplerecs',count(ds_proxid_samplerecs )}
  ,{'ds_seleid_samplerecs',count(ds_seleid_samplerecs )}
  ,{'ds_proxid_samples'   ,count(ds_proxid_samples    )}
  ,{'ds_seleid_samples'   ,count(ds_seleid_samples    )}


],{string stat, unsigned value});

mac_blank_for_excel(pdataset) := functionmacro
  return project(pdataset ,transform(recordof(left),self.cluster_diff := if(counter = 1,left.cluster_diff,''),self := left));
endmacro;

output(ds_stats                           ,named('ds_stats'             ));
output(mac_blank_for_excel(ds_proxid_samples                  ),named('ds_proxid_samples'    ),all);
output(mac_blank_for_excel(ds_seleid_samples                  ),named('ds_seleid_samples'    ),all);

output(mac_blank_for_excel(ds_proxid_samples[1..50]                  ),named('JA_proxid'    ),all);
output(mac_blank_for_excel(ds_proxid_samples[51..100]                ),named('ZS_proxid'    ),all);
output(mac_blank_for_excel(ds_proxid_samples[101..150]               ),named('DS_proxid'    ),all);
output(mac_blank_for_excel(ds_proxid_samples[151..200]               ),named('KW_proxid'    ),all);
output(mac_blank_for_excel(ds_proxid_samples[201..250]               ),named('RP_proxid'    ),all);
output(mac_blank_for_excel(ds_proxid_samples[251..300]               ),named('VB_proxid'    ),all);

output(mac_blank_for_excel(ds_seleid_samples[1..50]                  ),named('JA_seleid'    ),all);
output(mac_blank_for_excel(ds_seleid_samples[51..100]                ),named('ZS_seleid'    ),all);
output(mac_blank_for_excel(ds_seleid_samples[101..150]               ),named('DS_seleid'    ),all);
output(mac_blank_for_excel(ds_seleid_samples[151..200]               ),named('KW_seleid'    ),all);
output(mac_blank_for_excel(ds_seleid_samples[201..250]               ),named('RP_seleid'    ),all);
output(mac_blank_for_excel(ds_seleid_samples[251..300]               ),named('VB_seleid'    ),all);


output(choosen(ds_base              ,100) ,named('ds_base'             ));
// output(choosen(ds_proxid            ,100) ,named('ds_proxid'           ));
// output(choosen(ds_seleid            ,100) ,named('ds_seleid'           ));
output(choosen(ds_proxid_sort       ,100) ,named('ds_proxid_sort'      ));
output(choosen(ds_seleid_sort       ,100) ,named('ds_seleid_sort'      ));
output(choosen(ds_proxid_enth       ,100) ,named('ds_proxid_enth'      ));
output(choosen(ds_seleid_enth       ,100) ,named('ds_seleid_enth'      ));
output(choosen(ds_proxid_samplerecs ,100) ,named('ds_proxid_samplerecs'));
output(choosen(ds_seleid_samplerecs ,100) ,named('ds_seleid_samplerecs'));