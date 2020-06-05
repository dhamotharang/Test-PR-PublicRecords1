IMPORT _Control, Data_Services;

EXPORT _Dataset(BOOLEAN pUseProd = FALSE):= MODULE

  EXPORT Name                   := 'OneKey';
  EXPORT thor_cluster_Files     := IF(pUseProd, Data_Services.foreign_prod + 'thor_data400::', '~thor_data400::');
  EXPORT thor_cluster_Persists  := thor_cluster_Files;
  EXPORT max_record_size        := 4096;
  EXPORT Groupname              := ThorLib.Group();

END;