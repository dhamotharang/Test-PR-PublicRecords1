// !! for admin use only
IMPORT $,STD,ut;
EXPORT admin_tools(string logical_group = 'roxiedev') := MODULE
  
  SHARED file := $.names(logical_group);
  SHARED empty_file := dataset([], $.layouts.testcase);

  EXPORT new_bucket() := FUNCTION
    #WORKUNIT('name', '-- dev regression - new bucket --');
    
    RETURN SEQUENTIAL(
      STD.File.CreateSuperFile(file.current), // <-- will fail if file exists
      OUTPUT(empty_file,,file.consolidated, OVERWRITE);
      STD.File.StartSuperFileTransaction(),
      STD.File.AddSuperFile(file.current, file.consolidated),    
      STD.File.FinishSuperFileTransaction(),
      OUTPUT('New bucket created: ' + file.current)
    );
  END;

  EXPORT consolidate() := FUNCTION
    #WORKUNIT('name', '-- dev regression consolidate --');

    fconsolidated_temp := file.consolidated+'_tmp';
    fconsolidated_bkp := file.consolidated+'::backup::'+STD.Date.Today()+ut.getTime();
    testcases := DATASET(file.current, $.layouts.testcase, THOR);

    RETURN SEQUENTIAL(
      OUTPUT(testcases,, fconsolidated_temp, OVERWRITE), // <- this will be renamed and added to new current
      OUTPUT(testcases,, fconsolidated_bkp, OVERWRITE), // <- this will be kept as back up
      
      // delete all current files  
      STD.File.StartSuperFileTransaction(),
      STD.File.DeleteSuperFile(file.current, TRUE), 
      STD.File.FinishSuperFileTransaction(),

      // and now consolidate all testcases into a single file
      STD.File.StartSuperFileTransaction(),
      STD.File.CreateSuperFile(file.current),
      STD.File.RenameLogicalFile(fconsolidated_temp, file.consolidated),
      STD.File.AddSuperFile(file.current, file.consolidated), 
      STD.File.FinishSuperFileTransaction(),

      OUTPUT('Regression bucket has been consolidated')
    );
  END;

  EXPORT delete_bucket() := FUNCTION
    #WORKUNIT('name', '-- dev regression delete --');
    RETURN SEQUENTIAL(
      STD.File.DeleteSuperFile(file.current, TRUE), 
      OUTPUT('Regression bucket has been cleaned')
    );
  END;

END;
