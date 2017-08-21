export mac_SF_Move(bname, move_type, seq_name, num_gens = '3', include_built = 'false', is_key = 'false', preview = 'false') := macro
import PromoteSupers;

PromoteSupers.Mac_SF_Move(bname, move_type, seq_name, num_gens, include_built, is_key, preview);
	
endmacro : deprecated('use promotesupers.Mac_SF_Move instead');