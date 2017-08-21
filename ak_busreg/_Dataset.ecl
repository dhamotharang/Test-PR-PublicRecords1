import _control, versioncontrol;
export _Dataset(
   boolean pUseOtherEnvironment = false
) :=
module
   export Name                            := 'Ak_BusReg'                    ;
   export thor_cluster_Files        := '~thor_data400::'    ;
   export thor_cluster_Persists  := thor_cluster_Files      ;
   export max_record_size           := 8192                          ;
   export Groupname  := versioncontrol.groupname();
end;
