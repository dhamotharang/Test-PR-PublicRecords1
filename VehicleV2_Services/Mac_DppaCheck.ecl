export Mac_DppaCheck(in_ds,out_ds) := MACRO

  import doxie;

	// extract state_origin and source_code from an iteration_key field
	#uniquename(ikey)
	%ikey%(string30 iteration_key) := module
		shared len	:= length(trim(iteration_key));
		export st		:= iteration_key[len-3..len-2];
		export src	:= iteration_key[len-1..];
	end;
	
	out_ds := in_ds(doxie.compliance.dppa_state_ok (%ikey%(Iteration_Key).st, dppa_purpose, , %ikey%(Iteration_Key).src));

ENDMACRO;
