EXPORT TestSearchV4() := FUNCTION
// Query name should be hipiesa.search_{GCID}_{JOBID}
// Example (demo client): hipiesa.search_6530205_640123
// Example: hipiesa.search_6786855_579483

  resultDs := HIPIESA.SearchV4('6786855', '579483');
	
	RETURN resultDs;	
END;