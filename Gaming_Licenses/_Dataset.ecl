import _control;

export _Dataset :=
module

	export Name										:= 'Gaming_Licenses'	;
	export thor_cluster_Files			:= '~thor_data400::'	;
	export thor_cluster_Persists	:= thor_cluster_Files	;
	export max_record_size				:= 5024000						;
	export Groupname							:= if(	_Control.ThisEnvironment.name	= 'Dataland'	,'\'thor_dataland_linux\''
																																										,'\'thor_dell400\''
	);

end;