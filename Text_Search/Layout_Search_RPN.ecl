// The RPN version of the search
export Layout_Search_RPN := RECORD
	Types.OpCode					opCode;
	Types.Distance				leftWindow;
	Types.Distance				rightWindow;
	Types.Stage						stage;
	// UNSIGNED1							st;
	// UNSIGNED1							en;
	Layout_Search_operand A;
	// UNSIGNED1							numOprnds;
END;