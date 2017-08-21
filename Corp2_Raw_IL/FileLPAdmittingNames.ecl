import corp2;
//********************************************************************
//FileLPAdmittingNames -> Project string format into structured layout.
//******************************************************************** 
Corp2_Raw_IL.Layouts.LPAdmittingNamesLayoutIn LPAdmittingNamesTransform(Corp2_Raw_IL.Layouts.StringLayoutIn l) := transform
	self.lp_record_ind_52017 							:= corp2.t2u(l.payload[1..1]);	
	self.lp_file_number_52017 						:= corp2.t2u(l.payload[2..8]);
	self.lp_admitting_name_52017 					:= corp2.t2u(l.payload[9..197]);
	self.lp_date_filed_52017 							:= corp2.t2u(l.payload[198..205]);	
	self.filler 													:= corp2.t2u(l.payload[206..]);
end;

export FileLPAdmittingNames(dataset(Corp2_Raw_IL.Layouts.StringLayoutIn) pInLP) := project(pInLP(corp2.t2u(payload[1..1])='N'),LPAdmittingNamesTransform(LEFT));