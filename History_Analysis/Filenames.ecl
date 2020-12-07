Import History_Analysis, tools;

Export Filenames( string pVersion, boolean pUseProd = False ) := Module 
    
	Export baseDeltas	       := _Dataset(pUseProd).thor_cluster_files + 'history_analysis::base::' + _Dataset().deltas;

	Export baseStatistics	   := _Dataset(pUseProd).thor_cluster_files + 'history_analysis::base::' + _Dataset().statistics;

	Export dopsInputTemplate   := _Dataset(pUseProd).thor_cluster_files + 'history_analysis::in::' + _Dataset().dops_name;

	Export dopsServiceData    := _Dataset(pUseProd).thor_cluster_files + 'history_analysis::in::' + _Dataset().dops_service;

	Export dopsInputRawdata    := _Dataset(pUseProd).thor_cluster_files + 'history_analysis::in::' + _Dataset().dops_rawdata;

	Export orbitinputTemplate  := _Dataset(pUseProd).thor_cluster_files + 'history_analysis::in::' + _Dataset().orbit_name;
	
	Export masterBuildTemplate := _Dataset(pUseProd).thor_cluster_files + 'history_analysis::in::' + _Dataset().master_build_name;
  
End;