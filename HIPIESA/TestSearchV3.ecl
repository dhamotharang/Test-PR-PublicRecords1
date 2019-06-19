EXPORT TestSearchV3() := FUNCTION
  resultDs := HIPIESA.SearchV3('test', 'taxid');
	
	RETURN resultDs;	
END;