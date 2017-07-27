import doxie;

EXPORT Fetch_BC_DID(dataset(doxie.layout_references) did_ds) := 
	Business_Header.Fetch_BC_Full(Business_Header.Fetch_BC_Key_DID(did_ds));
	
		
	 
