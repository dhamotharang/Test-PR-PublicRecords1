IMPORT ut;
EXPORT _config:= MODULE

    #WORKUNIT('protect',true);
    #WORKUNIT('priority','high');
    #WORKUNIT('priority',11);
    #STORED ('production', false);
    #STORED ('_Validate_Year_Range_Low', '1800');
    #STORED ('_Validate_Year_Range_high', ut.GetDate[1..4]);
    #OPTION ('multiplePersistInstances',FALSE);
    #OPTION ('implicitSubSort',FALSE);
    #OPTION ('implicitBuildIndexSubSort',FALSE);
    #OPTION ('implicitJoinSubSort',FALSE);
    #OPTION ('implicitGroupSubSort',FALSE);
    #STORED ('emailList', 'gabriel.marcan@lexisnexisrisk.com,Debendra.Kumar@lexisnexisrisk.com');

    EXPORT setup_build := output('ATTRIBUTE WITH WORKUNIT OPTIONS AND STORED VARIABLES HAS BEED REFERENCED');
    EXPORT dops_datasetname:='PersonHeaderKeys';

END;