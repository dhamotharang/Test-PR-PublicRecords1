/*
	To run the build, modify the dnb.version attribute to reflect the build date, check out/in.
	Then open the DNB.bwrBuild_All attribute in a builder window.
	Make sure the
	
		DestinationIP		:= '172.16.68.91';
		DestinationVolume	:= '/dnb_16/';
	
	value types are correct for the destination of the desprays and dkcs.
	Then execute the builder window.
	
	Instead of modifying the version attribute, you can pass the build date as a third parameter 
	to the DNB.Proc_Build_All attribute.  Example:
	
		DNB.Proc_Build_All(DestinationIP, DestinationVolume, '20060608').All;
		
	The DNB.Proc_Build_All attribute builds the base files, the output files, the roxie keys, the moxie keys,
	desprays the output files and keys, creates the as_business_header and as_business_contact persists, 
	and runs stats on the company and contact base files.

*/