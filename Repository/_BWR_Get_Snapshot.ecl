// -- run on thor.  hthor gets memory pool exhausted errors.  Takes about 8 minutes.
getsnapshot := Repository.get_Snapshot(
   pFilterModules  := ''
  ,pGetHistory     := true
  ,pAttributeTypes := ['ECL','SALT','ESDL','XSLT','KEL','DUD','CMP']  //get all attribute types
);

output(getsnapshot  ,,'~temp::repository_snapshot.' + workunit,overwrite,__compressed__);