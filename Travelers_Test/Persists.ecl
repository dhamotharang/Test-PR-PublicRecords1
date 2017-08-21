export Persists(

	boolean puseotherenvironment = false

) :=
module
	
	shared pnames := persistnames(puseotherenvironment);
	
	export NormalizeInputNames				:= dataset(pnames.NormalizeInputNames		 		,Layouts.NormNames 									,flat);
	export NormalizeInputVehicles			:= dataset(pnames.NormalizeInputVehicles		,Layouts.NormVehicles								,flat);
	export StandardizeInput						:= dataset(pnames.StandardizeInput					,Layouts.Temporary.StandardizeInput ,flat);
	export AppendIds									:= dataset(pnames.AppendIds							 		,Layouts.Temporary.UniqueId					,flat);
	export FillHoles_GetFormerAddress	:= dataset(pnames.FillHoles_GetFormerAddress,Layouts.Temporary.UniqueId					,flat);
	export FillHoles_GetSSN						:= dataset(pnames.FillHoles_GetSSN					,Layouts.Temporary.UniqueId					,flat);
	export FillHoles_GetDLState				:= dataset(pnames.FillHoles_GetDLState			,Layouts.Temporary.UniqueId					,flat);
	export FillHoles_GetVinStuff			:= dataset(pnames.FillHoles_GetVinStuff			,Layouts.NormVehicles								,flat);
	export ReadyOutput								:= dataset(pnames.ReadyOutput								,Layouts.Input.Sprayed							,flat);
                                                  
end;