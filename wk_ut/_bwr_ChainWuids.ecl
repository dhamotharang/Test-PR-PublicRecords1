startiter := 36;
numiters  := 3;
version   := '20130719';
cluster   := tools.fun_Groupname('5',false);
PollingFrequency := '1';
OutputEcl := true;

ecltext := 'iteration         := \'@iteration@\';\npversion          := \'@version@\';\nPreClusterCount   := \'1234567\';\nPostClusterCount  := \'213456\';\nMatchesPerformed  := \'77849594\';\n\n#workunit(\'name\',\'wk_ut.test_att \' + pversion + \' \' + iteration);\n\noutput(iteration        ,named(\'iteration\'       ));\noutput(pversion         ,named(\'pversion\'        ));\noutput(PreClusterCount  ,named(\'PreClusterCount\' ));\noutput(PostClusterCount ,named(\'PostClusterCount\'));\noutput(MatchesPerformed ,named(\'MatchesPerformed\'));fail(\'just fail for testing\');';

// kickiters := wk_ut.mac_ChainWuids(ecltext,startiter,numiters,version,[],cluster,pOutputEcl := OutputEcl,pPollingFrequency := PollingFrequency);
// kickiters := wk_ut.mac_ChainWuids(ecltext,startiter,numiters,version,['PreClusterCount'],cluster,pOutputEcl := OutputEcl,pPollingFrequency := PollingFrequency);
kickiters := wk_ut.mac_ChainWuids(ecltext,startiter,numiters,version,['PreClusterCount','PostClusterCount','MatchesPerformed'],cluster,pOutputEcl := OutputEcl,pPollingFrequency := PollingFrequency);
kickiters;
//try to figure out error
