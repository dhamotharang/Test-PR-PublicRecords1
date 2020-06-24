IMPORT STD;
EXPORT names(string logical_group = 'roxiedev') := MODULE
  SHARED base_prefix := '~devregression';
  EXPORT super_filename := base_prefix + '::'+STD.STR.ToLowerCase(logical_group);
  EXPORT consolidated_filename := base_prefix + '::' + STD.STR.ToLowerCase(logical_group) + '::consolidated';
  EXPORT sub_filename(integer sub_file_id) := base_prefix + '::' + STD.STR.ToLowerCase(logical_group) + '::' + sub_file_id;
END;
