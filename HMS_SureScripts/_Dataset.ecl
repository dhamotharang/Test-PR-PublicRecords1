import _control, versioncontrol;

export _Dataset(boolean pUseProd = false) := module

	export Name										:= 'hms::SureScripts'	;
	export Specialty_Name					:= 'hms::SureScripts::SpecCodes';
	export Prof_Lic_Name					:='hms::SureScripts::Prof_Licenses';
	EXPORT HMS_Spec_to_Taxonomy   := 'hms::SureScripts::HMS_Spec_to_Taxonomy';
	export thor_cluster_Files			:= 	if(pUseProd 
																			,VersionControl.foreign_prod + 'Thor400_data::',
																			'~Thor400_data::'
																		);
	export thor_cluster_Persists	:= thor_cluster_Files		;
	export max_record_size				:= 40000;

	export Groupname	:= versioncontrol.Groupname();

end;