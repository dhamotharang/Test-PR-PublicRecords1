import versioncontrol,tools,Data_Services;

export Filenames(boolean pUseProd = false , boolean pUseDelta = false ) := module

	shared suffixBaseBuilt
		:= if(pUseDelta, '_delta', '_full');

	shared thor_cluster
		:= if(pUseProd ,Data_Services.foreign_bair_float_dali + 'thor400_data::','~thor400_data::');
		
  export composite_input							:=  thor_cluster + 'base::composite_public_safety_data' + suffixBaseBuilt;

	shared thor_bair_cluster := '~thor_data400::';
		
	shared project_name
		:= bair_composite._Dataset(pUseProd).Name;
	
	export composite_mo_building 		:=  thor_bair_cluster + 'base::'+project_name+'::dbo::mo::delta::building';
	export composite_per_building 	:=  thor_bair_cluster + 'base::'+project_name+'::dbo::persons::delta::building';
	export composite_veh_building 	:=  thor_bair_cluster + 'base::'+project_name+'::dbo::vehicle::delta::building';	
	export composite_building				:=  '~thor400_data::base::composite_public_safety_data_delta_building';
	export composite_temp						:=  '~thor400_data::base::composite_public_safety_data_delta_temp';
		
end;