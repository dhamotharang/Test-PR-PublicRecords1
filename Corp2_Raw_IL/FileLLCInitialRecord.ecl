import corp2;
//********************************************************************
//FileLLCInitialRecord -> Project string format into structured layout.
//******************************************************************** 
Corp2_Raw_IL.Layouts.LLCInitialRecordLayoutIn LLCInitialRecordTransform(Corp2_Raw_IL.Layouts.StringLayoutIn l) := transform
	self.filecreationdate		:= corp2.t2u(l.payload[8..15]);
end;

export FileLLCInitialRecord(dataset(Corp2_Raw_IL.Layouts.StringLayoutIn) pInLLC) := project(pInLLC(corp2.t2u(payload[1..4])='DATE'),LLCInitialRecordTransform(LEFT));