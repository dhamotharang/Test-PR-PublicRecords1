EXPORT TestSearchV2() := FUNCTION
  resultDs := HIPIESA.SearchV2('11', '092018a');
	
	RETURN resultDs;	
END;