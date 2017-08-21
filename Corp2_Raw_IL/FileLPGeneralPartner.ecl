import corp2;
//********************************************************************
//FileLPGeneralPartner -> Project string format into structured layout.
//******************************************************************** 
Corp2_Raw_IL.Layouts.LPGeneralPartnerLayoutIn LPGeneralPartnerTransform(Corp2_Raw_IL.Layouts.StringLayoutIn l) := transform
	self.lp_record_ind_52004 				:= corp2.t2u(l.payload[1..1]);	
	self.lp_file_number_52004 			:= corp2.t2u(l.payload[2..8]);
	self.lp_gp_name_52004 					:= corp2.t2u(l.payload[9..68]);
	self.lp_gp_street_52004 				:= corp2.t2u(l.payload[69..98]);
	self.lp_gp_city_52004 					:= corp2.t2u(l.payload[99..116]);
	self.lp_gp_state_52004 					:= corp2.t2u(l.payload[117..118]);
	self.lp_mm_zip_52004 						:= corp2.t2u(l.payload[119..127]);
	self.lp_gp_file_date_52004 			:= corp2.t2u(l.payload[128..135]);
	self.filler								 			:= corp2.t2u(l.payload[136..]);
end;

export FileLPGeneralPartner(dataset(Corp2_Raw_IL.Layouts.StringLayoutIn) pInLP) := project(pInLP(corp2.t2u(payload[1..1])='P'),LPGeneralPartnerTransform(LEFT));