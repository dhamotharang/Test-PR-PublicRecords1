import BatchShare, AutoStandardI, AutoKeyI, AutoHeaderI, Suppress;

EXPORT IParam := MODULE

	export options := interface (AutoStandardI.InterfaceTranslator.penalt_threshold_value.params,
															 AutoStandardI.PermissionI_Tools.params)
		export boolean is_audit   			:= false;
	  export boolean include_history 	:= false;
		export boolean noFail 					:= false;
		export string32 ApplicationType := Suppress.Constants.ApplicationTypes.DEFAULT;
	end;
	
	export nac_params := interface(
			options,
			AutoKeyI.AutoKeyStandardFetchBaseInterface,
			AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full)
		export boolean workHard 			:= true;
		export boolean isdeepDive 		:= false;
	end;
	
END;


