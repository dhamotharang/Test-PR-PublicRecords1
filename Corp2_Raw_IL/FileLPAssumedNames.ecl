import corp2;
//********************************************************************
//FileLPAssumedNames -> Project string format into structured layout.
//******************************************************************** 
Corp2_Raw_IL.Layouts.LPAssumedNamesLayoutIn LPAssumedNamesTransform(Corp2_Raw_IL.Layouts.StringLayoutIn l) := transform
	self.lp_record_ind_52005   					:= corp2.t2u(l.payload[1..1]);
	self.lp_file_number_52005   				:= corp2.t2u(l.payload[2..8]);
	self.lp_assumed_name_52005  				:= corp2.t2u(l.payload[9..197]);
	self.lp_assumed_date_adopted_52005  := corp2.t2u(l.payload[198..205]);
	self.lp_assumed_date_cancel_52005 	:= corp2.t2u(l.payload[206..213]);
	self.lp_assumed_date_renew_52005   	:= corp2.t2u(l.payload[214..221]);
	self.lp_assumed_cancel_code_52005   := corp2.t2u(l.payload[222..222]);
	self.filler   											:= corp2.t2u(l.payload[223..]);
end;

export FileLPAssumedNames(dataset(Corp2_Raw_IL.Layouts.StringLayoutIn) pInLP) := project(pInLP(corp2.t2u(payload[1..1])='A'),LPAssumedNamesTransform(LEFT));