utilfile.Layout_DID_Out t(utilfile.Layout_DID_Out le, unsigned6 i) :=
TRANSFORM
	SELF.fdid := i;
	SELF := le;
	
END;
p := PROJECT(UtilFile.file_util_daily, t(LEFT, COUNTER));

export daily_fdid := p;