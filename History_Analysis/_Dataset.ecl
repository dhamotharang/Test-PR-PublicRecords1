
Import _control, Data_Services, VersionControl;

Export _Dataset( boolean pUseProd = False ) := Module 
  
  Export deltas             := 'counted_deltas';
  Export statistics         := 'delta_statistics';
  Export dops_name          := 'dops_keysizedhistory';
  Export dops_service       := 'dops_servicehistory';
  Export dops_rawdata        := 'raw_data';
  Export orbit_name         := 'orbit_buildinstance';
  Export master_build_name  := 'master_build_frequency';
  Export thor_cluster_files := if(pUseProd, 
                                    Data_Services.foreign_prod + '~thor_data400::',
                                    '~thor_data400::');

  Export max_record_size := 40000;

  Export Groupname := VersionControl.Groupname();

END;
