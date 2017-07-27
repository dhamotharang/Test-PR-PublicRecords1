//
// Add the Focus index to the RPN
//

// Add a GET for the FOCUS LIST and AND it into the rest of the search request
export Focus_RPN_Add(DATASET(Layout_Search_RPN_Set) InRPN) := FUNCTION

 // Find max stage in RPN
 mystage := MAX(InRPN, stage);
 
 // Define Fields I need
 
 Stub_Oprnd := RECORD
	Types.WordStr				searchArg;
	Types.Stage					stageIn;	
	Types.TermID				id;
END;

 Stub_RPN := RECORD
   Types.OpCode					     opCode;
	 Types.Stage						   stage;
	 DATASET(Layout_RPN_Oprnd) inputs{MAXCOUNT(Limits.Max_Terms)};
 END;
 
 OperandForGet := dataset( [{'FocusList', mystage+1, mystage}], Stub_Oprnd);
 OperandForAnd := dataset( [{'',mystage,0},{'',mystage+1,0}], Stub_Oprnd);
 
 Layout_RPN_Oprnd MakeOpr( Stub_Oprnd l ) := TRANSFORM
   self := l;
	 self := [];
 END;
 OGP := PROJECT(OperandForGet,MakeOpr(LEFT));
 OAP := PROJECT(OperandForAnd,MakeOpr(LEFT));
 
 
 SetForGet := dataset([{Map_Search_Operands.code_FOCGET,mystage+1,OGP},
                       {Map_Search_Operands.code_AND,mystage+2,OAP}], Stub_RPN);

 
 Layout_Search_RPN_Set MakeRPN( Stub_RPN l ) := TRANSFORM
   self := l;
	 self := [];
 END;
 RPNAdd := PROJECT(SetForGet,MakeRPN(LEFT));

 
 return InRPN & RPNAdd;

END;