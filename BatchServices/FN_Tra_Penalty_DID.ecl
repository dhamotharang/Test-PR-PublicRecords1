
import doxie ;
export FN_Tra_Penalty_DID(string did_field,string ref_did) := 

FUNCTION

doxie.MAC_Header_Field_Declare()

return MAP ((unsigned8)ref_did=0 or (unsigned8)did_field = (unsigned8)ref_did => 0 , 
	  10);


END;