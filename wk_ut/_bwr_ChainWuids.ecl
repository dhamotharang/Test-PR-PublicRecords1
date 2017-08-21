startiter         := 78                           ;
numiters          := 2                            ;
version           := '20160313'                   ;
cluster           := wk_ut._Constants.LocalHthor  ;
PollingFrequency  := '1'                          ;
OutputEcl         := false                        ;

ecltext :=  'iteration         := \'@iteration@\';\n'
          + 'pversion          := \'@version@\';\n'
          + 'PreClusterCount   := \'1234567\';\n'
          + 'PostClusterCount  := \'213456\';\n'
          + 'MatchesPerformed  := \'77849594\';\n'
          + 'myset             := [100,80,40,30,20,10,1];\n\n'
          + '#workunit(\'name\',\'wk_ut.test_att \' + pversion + \' \' + iteration);\n\n'
          + 'output(iteration        ,named(\'iteration\'       ));\n'
          + 'output(pversion         ,named(\'pversion\'        ));\n'
          + 'output(PreClusterCount  ,named(\'PreClusterCount\' ));\n'
          + 'output(PostClusterCount ,named(\'PostClusterCount\'));\n'
          + 'output(myset[(unsigned)iteration] ,named(\'MatchesPerformed\'));\n'
          + 'fail(\'testing failure\')'
          ;

kickiters := wk_ut.mac_ChainWuids(
   ecltext
  ,startiter
  ,numiters
  ,version
  ,['PreClusterCount','PostClusterCount','MatchesPerformed']
  ,cluster
  ,pOutputEcl         := OutputEcl
  ,pPollingFrequency  := PollingFrequency
  ,pOutputFilename    := '~wk_ut::' + version + '_@iteration@::workunit_history::test_att'
  ,pOutputSuperfile   := '~wk_ut::qa::workunit_history' 
);

kickiters;


