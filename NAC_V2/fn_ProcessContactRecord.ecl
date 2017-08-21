import STD;
EXPORT fn_ProcessContactRecord(DATASET(Layouts2.rStateContact) inrec) := FUNCTION

	contacts := DISTRIBUTE(Files('').StateContacts,HASH64(ProgramCode, ProgramState)); 

	deletions := inrec(UpdateType='D');
	
	c1 := contacts - deletions;
	// TO DO: Override records
	
	c2 := c1 + inrec(UpdateType='U');
	
	c3 := DEDUP(c2, all);
	
	
	//Std.file.fPromoteSuperFileList([Files('').StateContacts], c3, deltail := true)
	
	return c3;

END;