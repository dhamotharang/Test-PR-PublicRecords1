output('<a href="http://10.173.14.204:8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=W20200127-154850#/stub/Summary">Parent Workunit</a>' ,named('Parent_Wuid__html'));
#workunit('name','---WorkMan.ChildRunner--- bipv2_proxid, version: 20200124j');
WorkMan.ChildRunner(
   '#workunit(\'name\',\'bipv2_proxid 2020210-@iteration@ workman test\');\nsetpreclustercount  := [392933809 ,382870103  ,381654002  ,381326072  ,381147324];\nsetmatchesperformed := [6265107   ,1032750    ,346601     ,192764     ,117560   ];\nsetconvergence      := [98.406    ,99.730     ,99.909     ,99.949     ,99.969   ];\noutput(setpreclustercount [@iteration@]  ,named(\'PreClusterCount\'));\noutput(setmatchesperformed[@iteration@]  ,named(\'MatchesPerformed\'));\noutput(setconvergence     [@iteration@]  ,named(\'Convergence\'));\n\n'
  ,'20200210a'
  ,'thor50_dev'
  ,'__WORKMAN_MAC_WORKMAN_EVENT__bipv2_proxid_20200124j_1_1_1_557_8_381__50811__'
  ,
  ,4
  ,2
  ,'~workman_testing::@version@::bipv2_proxid'
  ,'~workman_testing::qa::bipv2_proxid'
  ,['MatchesPerformed','PreClusterCount']
  ,'MatchesPerformed < (100000) or (100 - (MatchesPerformed / PreClusterCount * 100.0)) > (99.91)'
  ,['MatchesPerformed_Threshold','Pct_Convergence','Convergence_Threshold']
  ,'EmpIDIters'
  ,'10.173.14.204'
  ,'laverne.bentley@lexisnexis.com'
  ,''
  ,true
  ,'1'
  ,false
  ,false
  ,dataset([],  WsWorkunits  .  Layouts  .  DebugValues)
  ,false
  ,true
);
