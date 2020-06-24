// !! for admin use only
IMPORT $,STD;
EXPORT admin_tools := MODULE
  
  EXPORT new_bucket(string logical_group = 'roxiedev') := FUNCTION
    string super_fname := $.names(logical_group).super_filename;
    string consolidated_fname := $.names(logical_group).consolidated_filename;
    empty_file := dataset([], $.layouts.testcase);

    RETURN SEQUENTIAL(
      STD.File.CreateSuperFile(super_fname),
      OUTPUT(empty_file,,consolidated_fname, OVERWRITE);
      STD.File.StartSuperFileTransaction(),
      STD.File.AddSuperFile(super_fname, consolidated_fname),    
      STD.File.FinishSuperFileTransaction(),
      OUTPUT('New bucket created: ' + super_fname)
    );
  END;

  EXPORT consolidate() := FUNCTION
    // TBD: go through all sub-files and consolidate into a single (consolidated) subfile.
    RETURN 0;
  END;

END;
