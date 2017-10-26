import header;
#workunit('protect',true);
#workunit('name','Yogurt:Quick Header Build -'+Header.Sourcedata_month.v_eq_as_of_date);
#workunit('priority','high');
#workunit('priority',12);
#option('skipFileFormatCrcCheck', 1);
//#OPTION('defaultSkewyeError','0.00275');
//#OPTION('AllowedClusters', 'thor400_44');
#OPTION('AllowAutoQueueSwitch',TRUE);
#OPTION('multiplePersistInstances',FALSE);
header_quick.proc_quickHdr_build_all('bctlpedata10.risk.regn.net',Header.Sourcedata_month.v_eq_as_of_date);s 