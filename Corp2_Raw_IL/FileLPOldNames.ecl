import corp2;
//********************************************************************
//FileLPOldNames -> Project string format into structured layout.
//******************************************************************** 
Corp2_Raw_IL.Layouts.LPOldNamesLayoutIn LPOldNamesTransform(Corp2_Raw_IL.Layouts.StringLayoutIn l) := transform
	self.lp_record_ind_52006							:= corp2.t2u(l.payload[1..1]);
	self.lp_file_number_52006  	 					:= corp2.t2u(l.payload[2..8]);
	self.lp_old_name_52006   							:= corp2.t2u(l.payload[9..197]);
	self.lp_date_filed_52006 							:= corp2.t2u(l.payload[198..205]);	
end;

export FileLPOldNames(dataset(Corp2_Raw_IL.Layouts.StringLayoutIn) pInLP) := project(pInLP(corp2.t2u(payload[1..1])='N'),LPOldNamesTransform(LEFT));