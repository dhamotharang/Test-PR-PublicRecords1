
EXPORT proc_build_all(string filedate) := FUNCTION
	#workunit('name','PRTE FBN BUILD ' + filedate);
	
	return_val := sequential(fSpray, proc_build_business(filedate),proc_build_contact(filedate),proc_build_keys(filedate));

	return return_val;

END;