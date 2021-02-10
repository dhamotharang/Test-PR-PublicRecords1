IMPORT STD;
EXPORT names(string logical_group = 'roxiedev') := MODULE
  SHARED location := '~';
  SHARED prefix := 'devregression::' + STD.STR.ToLowerCase(logical_group) + '::';
  EXPORT current :=  location + prefix + 'current';
  EXPORT consolidated := location + prefix + 'consolidated';
  EXPORT nextsubfile := FUNCTION 
    logical_files := STD.File.SuperFileContents(current);
    INTEGER max_subfile_id := MAX(
      logical_files(~STD.Str.Contains(name, 'consolidated', false)), // drop 'consolidated' from the list of subfiles
      (INTEGER) STD.Str.FindReplace(name, prefix, '') // ... and grab max subfile id in use
    ); 
    RETURN location + prefix + (max_subfile_id+1);
  END;
END;
