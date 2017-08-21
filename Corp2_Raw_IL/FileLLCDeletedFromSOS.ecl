import corp2;
//********************************************************************
//FileLLCDeletedFromSOS -> Project string format into structured layout.
//******************************************************************** 
Corp2_Raw_IL.Layouts.LLCDeletedFromSOSLayoutIn LLCDeletedFromSOSTransform(Corp2_Raw_IL.Layouts.StringLayoutIn l) := transform,
skip(stringlib.stringfilterout(l.payload[2..9],'0123456789')<>'')
	self.filenbr := corp2.t2u(l.payload[2..9]);
end;

export FileLLCDeletedFromSOS(dataset(Corp2_Raw_IL.Layouts.StringLayoutIn) pInLLC) := project(pInLLC(corp2.t2u(payload[1..1])='D'),LLCDeletedFromSOSTransform(LEFT));