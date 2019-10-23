EXPORT proc_segmentation_Master(STRING version) := FUNCTION

	// run iteration
	version_use := version + '_' + WORKUNIT;
	runSegmentation := InsuranceHeader.proc_segmentation(version_use).run;
	
	RETURN SEQUENTIAL(runSegmentation);
	
END;