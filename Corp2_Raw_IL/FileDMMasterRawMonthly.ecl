import ut;
//********************************************************************
//FileDMMasterRawMonthly -> Project string format into structured layout.
//******************************************************************** 
Corp2_Raw_IL.Layouts.MasterFixedStringLayoutIn MasterTransform(Corp2_Raw_IL.Layouts.StringLayoutIn l) := transform
	self.masterheader 					:= '';
	self.recordtype	 						:= 'M';
	self.payload 		 						:= l.payload[1..];	
end;

export FileDMMasterRawMonthly(dataset(Corp2_Raw_IL.Layouts.StringLayoutIn) pInMaster) := project(pInMaster,MasterTransform(left));