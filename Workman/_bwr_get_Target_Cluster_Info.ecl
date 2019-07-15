// tools.fun_ThorSpaceHogs('','thor400_20');
targetresults := WorkMan.get_GetTargetClusterInfo('thor400_20');

output(choosen(targetresults.results              ,500) ,named('results'          ),all);
output(choosen(targetresults.normtargetclusters    ,500) ,named('normtargetclusters'),all);
output(choosen(targetresults.normtargetcluster    ,500) ,named('normtargetcluster'),all);
output(choosen(targetresults.normmachineinfo      ,500) ,named('normmachineinfo'  ),all);
output(choosen(targetresults.normStorages          ,500) ,named('normStorages'      ),all);
// output(targetresults.normStorage           ,named('normStorage'      ),all);

dstorage := targetresults.normStorage;

dstorage_dedup := project(dedup(dstorage(ProcessType = 'ThorSlaveProcess',description = '/mnt/disk1'),address,description,all),transform({recordof(left),string available_,string total_}
  ,self.available_ := ut.FHumanReadableSpace(left.available  * power(2.0,20))
  ,self.total_     := ut.FHumanReadableSpace(left.total      * power(2.0,20))
  ,self := left
));

total_storage           := ut.FHumanReadableSpace(sum(dstorage_dedup,total    )/*in MB*/ * power(2.0,20));
total_available_storage := ut.FHumanReadableSpace(sum(dstorage_dedup,Available)/*in MB*/ * power(2.0,20));
total_storage_used      := ut.FHumanReadableSpace((sum(dstorage_dedup,total    ) - sum(dstorage_dedup,Available))/*in MB*/ * power(2.0,20));

output(dstorage_dedup ,named('dstorage_dedup'),all);
output(total_storage           ,named('total_storage'          ));
output(total_available_storage ,named('total_available_storage'));
output(total_storage_used      ,named('total_storage_used'     ));