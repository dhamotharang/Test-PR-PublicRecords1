EXPORT TestSearch() := FUNCTION
  resultDs := HIPIESA.Search('version2', '091918');
	
	RETURN resultDs;	
END;