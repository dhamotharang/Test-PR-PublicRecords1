IMPORT PRTE2_DOC;

EXPORT proc_build_all(string filedate) := FUNCTION
	do_all := 	sequential(fspray,	proc_build_base(filedate), proc_build_keys(filedate));
	return do_all;

END;