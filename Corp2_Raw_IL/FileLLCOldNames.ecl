import corp2;
//********************************************************************
//FileLLCOldNames -> Project string format into structured layout.
//******************************************************************** 
Corp2_Raw_IL.Layouts.LLCOldNamesLayoutIn LLCOldNamesTransform(Corp2_Raw_IL.Layouts.StringLayoutIn l) := transform
	self.ll_record_ind_42007							:= corp2.t2u(l.payload[1..1]);	
	self.ll_file_nbr_42007   							:= corp2.t2u(l.payload[2..9]);
	self.ll_old_date_filed_42007 					:= corp2.t2u(l.payload[10..17]);
	self.ll_llc_name_42007    						:= corp2.t2u(l.payload[18..137]);
end;

export FileLLCOldNames(dataset(Corp2_Raw_IL.Layouts.StringLayoutIn) pInLLC) := project(pInLLC(corp2.t2u(payload[1..1])='O'),LLCOldNamesTransform(LEFT));