import corp2_mapping,corp2;
//********************************************************************
//FileLPInitialRecord -> Project string format into structured layout.
//******************************************************************** 
Corp2_Raw_IL.Layouts.LPInitialRecordLayoutIn LPInitialRecordTransform(Corp2_Raw_IL.Layouts.StringLayoutIn l) := transform,
skip(stringlib.stringfilterout(l.payload[2..9],'0123456789')<>'')
	self.filecreationdate		:= corp2_mapping.fValidateDate(corp2.t2u(l.payload[5..8] + l.payload[1..2] + l.payload[3..4]),'CCYYMMDD').PastDate;
end;

export FileLPInitialRecord(dataset(Corp2_Raw_IL.Layouts.StringLayoutIn) pInLP) := project(pInLP,LPInitialRecordTransform(LEFT))(corp2.t2u(filecreationdate)<>'');	 