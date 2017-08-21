export MAC_SK_Move(kname, move_type, seq_name) := macro
import roxiekeybuild;

roxiekeybuild.Mac_SK_Move(kname, move_type, seq_name);
	
endmacro : deprecated('use roxiekeybuild.Mac_SK_Move instead');