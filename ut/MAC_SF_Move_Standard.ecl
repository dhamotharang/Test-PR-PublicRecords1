export MAC_SF_Move_Standard( basename			// -- with the @version@ in the filename
							,move_type 
							,seq_name 
							,num_gens = 3 
							) := 
macro
  import tools;
  seq_name := tools.MAC_SF_Move_Standard(basename ,move_type  ,num_gens) : DEPRECATED('Use tools.MAC_SF_Move_Standard instead');
  
endmacro;