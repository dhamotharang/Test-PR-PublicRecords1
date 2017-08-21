import lib_fileservices;
export Persistnames(

	boolean puseotherenvironment = false

) :=
module
	
	shared root := _Dataset(puseotherenvironment).thor_cluster_Persists + 'persist::' + _Dataset().name + '::';
	
	export NormalizeInputNames				:= root + 'Normalize_Input.Names'					;
	export NormalizeInputVehicles			:= root + 'Normalize_Input.Vehicles'			;
	export StandardizeInput						:= root + 'Standardize_Input'							;
	export AppendIds									:= root + 'Append_Ids'										;
	export FillHoles_GetFormerAddress	:= root + 'Fill_Holes.Get_Former_Address'	;
	export FillHoles_GetSSN						:= root + 'Fill_Holes.Get_SSN'						;
	export FillHoles_GetMisc					:= root + 'Fill_Holes.Get_Misc'						;
	export FillHoles_GetDLState				:= root + 'Fill_Holes.Get_DL_State'				;
	export FillHoles_GetVinStuff			:= root + 'Fill_Holes.Get_Vin_Stuff'			;
	export ReadyOutput								:= root + 'Ready_Output'									;
                            

	export All := dataset([
		 {NormalizeInputNames				}
		,{NormalizeInputVehicles		}
		,{StandardizeInput					}
		,{AppendIds									}
		,{FillHoles_GetFormerAddress}
		,{FillHoles_GetSSN					}
		,{FillHoles_GetMisc					}
		,{FillHoles_GetDLState			}
		,{FillHoles_GetVinStuff			}
		,{ReadyOutput								}
      
	], lib_fileservices.FsLogicalFileNameRecord);


end;