import _control, ut;
export _Dataset :=
module

	export Name										:= 'Sheila_Greco'			;
	export thor_cluster_Files			:= '~thor_data400::'	;
	export thor_cluster_Persists	:= thor_cluster_Files	;
	export max_record_size				:= 80000							;

	export Groupname	:= if(	_Control.ThisEnvironment.name		 = 'Dataland'	,'thor50_dev02'
																																					,'thor400_44'
											);

end;