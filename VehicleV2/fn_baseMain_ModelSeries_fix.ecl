export fn_baseMain_ModelSeries_fix
	(
	 dataset(recordof(VehicleV2.Layout_Base_Main))	in_VehicleV2_base_main
	,string2										pSource			= 'AE'
	)

:= FUNCTION
	
		VehicleV2.Layout_Base_Main tFix(in_VehicleV2_base_main L) := transform

			self.vina_model_desc		:=if(	L.source_code=pSource
											and L.orig_model_desc<>''
											and L.orig_model_desc<>L.vina_model_desc
													,L.orig_model_desc
													,L.vina_model_desc);
			self.vina_series_desc		:=if(	L.source_code=pSource
											and L.orig_series_desc<>''
											and L.orig_series_desc<>L.vina_series_desc
													,L.orig_series_desc
													,L.vina_series_desc);

			self := L;

		end; 
	 
	out_fix := project(in_VehicleV2_base_main, tFix(left));

	RETURN	out_fix;

END;