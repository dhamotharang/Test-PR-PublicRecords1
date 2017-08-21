import corp2;
//********************************************************************
//FileLPDeletedFromSOS -> Project string format into structured layout.
//******************************************************************** 
Corp2_Raw_IL.Layouts.LPDeletedFromSOSLayoutIn LPDeletedFromSOSTransform(Corp2_Raw_IL.Layouts.StringLayoutIn l) := transform
	self.filenumber := corp2.t2u(l.payload[2..9]);
end;

export FileLPDeletedFromSOS(dataset(Corp2_Raw_IL.Layouts.StringLayoutIn) pInLP) := project(pInLP(corp2.t2u(payload[1..1])='D'),LPDeletedFromSOSTransform(LEFT));	 