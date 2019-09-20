import _control, versioncontrol;

export _Dataset(boolean pUseProd = false, boolean pIsFull = false) 
:= module

  // Add name stem to deliniate between FULL or DAILY build.
	export Name := 'log_' + IF(pIsFull, 'full', 'daily');
  
	export thor_cluster_Files := 
      if (pUseProd,
          VersionControl.foreign_prod + 'wwtm::',
          '~wwtm::'
      );
                                    
	export thor_cluster_Persists := thor_cluster_Files;

	export Groupname := versioncontrol.Groupname();

end;