EXPORT Mac_DppaCheck(in_ds,out_ds) := MACRO

  IMPORT doxie;

  // extract state_origin and source_code from an iteration_key field
  #uniquename(ikey)
  %ikey%(STRING30 iteration_key) := MODULE
    SHARED len := LENGTH(TRIM(iteration_key));
    EXPORT st := iteration_key[len-3..len-2];
    EXPORT src := iteration_key[len-1..];
  END;
  
  out_ds := in_ds(doxie.compliance.dppa_state_ok (%ikey%(Iteration_Key).st, dppa_purpose, , %ikey%(Iteration_Key).src));

ENDMACRO;
