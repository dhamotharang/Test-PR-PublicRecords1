import _control, versioncontrol;

export _Dataset(boolean pUseProd = false) := module

	export Name										:= 'hms_pm';
	export thor_cluster_Files			:= if (pUseProd 
	                                     // these two lines for processing the original large data files
																			 ,VersionControl.foreign_prod + 'thor400_data::',
																			 '~thor400_data::'
																			 // these two lines for processing the smaller test files (for testing)
//																			 ,VersionControl.foreign_prod + 'thor400_dev::',
//																			 '~thor400_dev::'
																	 );
	export thor_cluster_Persists	:= thor_cluster_Files;
	export max_record_size				:= 40000;

	export Groupname							:= versioncontrol.Groupname();

end;