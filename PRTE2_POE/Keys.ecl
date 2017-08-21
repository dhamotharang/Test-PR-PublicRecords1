IMPORT  doxie,mdr, PRTE2_POE;

EXPORT keys := MODULE

EXPORT key_poe_did := INDEX(
	FILES.DS_Did, 
	 {did}, 
	 {Files.DS_Did},
	constants.KeyName_poe + '@version@::did');
	
	EXPORT key_poe_source_hierarchy := INDEX(
	FILES.ds_source_hierarchy, 
	 {source}, 
	 {Files.ds_source_hierarchy},
	constants.KeyName_poe + '@version@::source_hierarchy');

END;
