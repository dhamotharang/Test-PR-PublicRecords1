IMPORT PRTE2_RiskTable;

EXPORT proc_build_all(string filedate) := FUNCTION
	
	build_keys :=	PRTE2_RiskTable.proc_build_keys(filedate);

	return build_keys;

END;