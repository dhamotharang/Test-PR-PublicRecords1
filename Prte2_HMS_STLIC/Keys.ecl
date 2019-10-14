IMPORT  doxie,mdr, Corp2,BIPV2, corp2_mapping;
EXPORT keys := MODULE

 EXPORT key_sourcekey := INDEX(FILES.Source_Keys, 
	 {source_rid}, {files.Source_Keys}, 
	 Constants.KeyName_source + doxie.Version_SuperKey + '::source_rid');

 EXPORT key_lnpidkey := INDEX(FILES.Lnpid_keys, 
	 {lnpid}, {files.lnpid_keys}, 
	 Constants.KeyName_lnpid + doxie.Version_SuperKey + '::lnpid');
End;