IMPORT PRTE2_PhoneFinderUpdateRules, PromoteSupers, PRTE2_PhoneFraud;

EXPORT proc_build_base(String filedate) := FUNCTION
 
PromoteSupers.MAC_SF_BuildProcess(Files.carrier_reference_base_in, Constants.base_carrier_reference, writefile_carrier_reference,,,,filedate);
	  
 
  RETURN  writefile_carrier_reference;	

END;