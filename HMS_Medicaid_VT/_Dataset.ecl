/* import _control, versioncontrol;
   
   export _Dataset(boolean pUseProd = false) := module
   
   	export Name										:= 'hms::Medicaid_VT'	;
   	export thor_cluster_Files			:= 	if(pUseProd 
   																			,VersionControl.foreign_prod + 'Thor400_data::',
   																			'~Thor400_data::'
   																		);
   	export thor_cluster_Persists	:= thor_cluster_Files		;
   	export max_record_size				:= 40000;
   
   	export Groupname	:= versioncontrol.Groupname();
   
   end;
*/