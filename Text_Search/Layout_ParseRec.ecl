EXPORT Layout_ParseRec := RECORD
	Types.OpCode		opCode;
	Types.Distance	leftWindow;
	Types.Distance	rightWindow;
	Types.HitCount	atl;
	Types.Stage			stage;
	Layout_OprndRec	A;
END;