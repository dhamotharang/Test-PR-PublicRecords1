/*
	Please use raw aids and cleaned aids in this process
	must have unique id(probably child dataset) that ties each record back to it's source record
	This requires that each source have an index on that unique id so we can do a "show sources" type thing
	Also, each source will also need a did, bdid, and autokeys built on them
	probably should "lock" in sources like in business header and person header to prevent them from changing
	during the build
	Need strata stats and also some comprehensive stats that we could maybe include in strata
	data sources, build sources, sources, source files
	source lock, source unlock

	Source_Data				-- concatenated list of sources datasets
	Source_filenames	-- concatenated list of source filenames
	Source_Lock				-- Lock in sources by promoting them to a using_in_poe superfile
	Source_Unlock			-- Unlock sources by removing them from a using_in_poe superfile

	Need to add the "using_in_poe" version to the mbuildfilenameversions 
	and also to the promote logic.  Probably should make this generic so can just pass in the version u want to 
	lock/unlock to.

	Sources should use source codes in mdr.sourcetools
	Add raw aids and cleaned aids to each source + to the poe file
	Append ssn like in bus contacts
	propagate populated dids to zero dids within a bdid if company name is same
	maybe also within groups?
	append did, don't trust did on records?
	append bdid also?
	clean up data a little bit before doing that? preprocess?
	propagate some fields before the rollup if the source, did, bdid the same--to improve the rollup
	

	
*/