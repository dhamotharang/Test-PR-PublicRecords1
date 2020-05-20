IMPORT Suppress, data_services;

EXPORT CheckSuppression (ds_in, mod_access, did_field = 'did', gsid_field = 'global_sid', use_distributed = FALSE, data_env = data_services.data_env.iNonFCRA) := FUNCTIONMACRO

	LOCAL skipped := ds_in(skip_opt_out);
	LOCAL checked_input := ds_in(skip_opt_out=false);
	
	LOCAL checked := Suppress.MAC_FlagSuppressedSource(checked_input, mod_access, did_field, gsid_field, use_distributed, data_env);
	
	LOCAL l_out := record
		recordof(ds_in);
		boolean is_suppressed;
	end;
	
	LOCAL final := checked + project(skipped, transform(l_out, self.is_suppressed := false, self := left));
	
	return final;

ENDMACRO;