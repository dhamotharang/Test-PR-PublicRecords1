import _control,tools;

export _Dataset :=
module

	export Name										:= 'Liquor_Licenses'	;
	export thor_cluster_Files			:= '~thor_data400::'	;
	export thor_cluster_Persists	:= thor_cluster_Files	;
	export Groupname							:= tools.fun_Groupname('44',true);
	
end;