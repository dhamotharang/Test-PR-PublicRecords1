IMPORT STD;
EXPORT names(string logical_group = 'roxiedev') := MODULE
  EXPORT prefix := '~devregression';
  EXPORT current :=  prefix + '::' + STD.STR.ToLowerCase(logical_group) + '::current';
  EXPORT consolidated := prefix + '::' + STD.STR.ToLowerCase(logical_group) + '::consolidated';
  EXPORT subfile(integer fid) := prefix + '::' + STD.STR.ToLowerCase(logical_group) + '::' + fid;
END;
