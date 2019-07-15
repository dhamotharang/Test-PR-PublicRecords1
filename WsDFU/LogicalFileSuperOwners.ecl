EXPORT LogicalFileSuperOwners(

   string pfilename
  ,string pesp       = _Config.LocalEsp
  ,string pcluster   = ''
  
) :=
function

  FsLogicalFileNameRecord := {  STRING name };

  ds_dfuinfo := WsDFU.soapcall_DFUInfo(pfilename ,pcluster ,,,pesp);
  
  ds_superfiles := normalize(ds_dfuinfo ,left.superfiles  ,transform(FsLogicalFileNameRecord  ,self.name := right.name));
  
  return ds_superfiles;
  
end;