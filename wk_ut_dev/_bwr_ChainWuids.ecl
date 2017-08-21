startiter := 36;
numiters  := 3;
version   := '20130719';
cluster   := 'hthor_dev';//tools.fun_Groupname('5',false);
PollingFrequency := '1';
OutputEcl := false;

ecltext := 'iteration         := \'@iteration@\';\npversion          := \'@version@\';\nPreClusterCount   := \'1234567\';\nPostClusterCount  := \'213456\';\nMatchesPerformed  := \'77849594\';\nmyset             := [100,80,40,30,20,10,1];\n\n#workunit(\'name\',\'wk_ut_dev.test_att \' + pversion + \' \' + iteration);\n\noutput(iteration        ,named(\'iteration\'       ));\noutput(pversion         ,named(\'pversion\'        ));\noutput(PreClusterCount  ,named(\'PreClusterCount\' ));\noutput(PostClusterCount ,named(\'PostClusterCount\'));\noutput(myset[(unsigned)iteration] ,named(\'MatchesPerformed\'));';

// kickiters := wk_ut_dev.mac_ChainWuids(ecltext,startiter,numiters,version,[],cluster,pOutputEcl := OutputEcl,pPollingFrequency := PollingFrequency);
// kickiters := wk_ut_dev.mac_ChainWuids(ecltext,startiter,numiters,version,['PreClusterCount'],cluster,pOutputEcl := OutputEcl,pPollingFrequency := PollingFrequency);
kickiters := wk_ut_dev.mac_ChainWuids(ecltext,startiter,numiters,version,['PreClusterCount','PostClusterCount','MatchesPerformed'],cluster,pOutputEcl := OutputEcl,pPollingFrequency := PollingFrequency
  ,pOutputFilename   := '~wk_ut_dev::' + version + '_@iteration@::workunit_history::test_att'
  ,pOutputSuperfile  := '~wk_ut_dev::qa::workunit_history' 
);

kickiters;
