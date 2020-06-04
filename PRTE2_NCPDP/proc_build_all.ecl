EXPORT proc_build_all(string filedate) := FUNCTION
	#workunit('name', 'PRTE NCPDP Build - ' + filedate);
	
	return_val := sequential(/*fspray, proc_build_base(filedate),*/proc_build_keys(filedate));

	return return_val;

END;