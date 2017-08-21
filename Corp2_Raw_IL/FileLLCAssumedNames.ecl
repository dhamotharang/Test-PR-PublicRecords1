import corp2;
//********************************************************************
//FileLLCAssumedNames -> Project string format into structured layout.
//******************************************************************** 
Corp2_Raw_IL.Layouts.LLCAssumedNamesLayoutIn LLCAssumedNamesTransform(Corp2_Raw_IL.Layouts.StringLayoutIn l) := transform
	self.ll_record_ind_42006   						:= corp2.t2u(l.payload[1..1]);
	self.ll_file_nbr_42006   							:= corp2.t2u(l.payload[2..9]);
	self.ll_assumed_adopt_date_42006    	:= corp2.t2u(l.payload[10..17]);
	self.ll_assumed_can_date_42006      	:= corp2.t2u(l.payload[18..25]);
	self.ll_assumed_can_code_42006     		:= corp2.t2u(l.payload[26..26]);
	self.ll_assumed_renew_year_42006    	:= corp2.t2u(l.payload[27..30]);
	self.ll_assumed_renew_date_42006    	:= corp2.t2u(l.payload[31..38]);
	self.ll_assumed_ind_42006  						:= corp2.t2u(l.payload[39..39]);
	self.ll_llc_name_42006      					:= corp2.t2u(l.payload[40..159]);
end;

export FileLLCAssumedNames(dataset(Corp2_Raw_IL.Layouts.StringLayoutIn) pInLLC) := project(pInLLC(corp2.t2u(payload[1..1])='A'),LLCAssumedNamesTransform(LEFT));