import corp2;
//********************************************************************
//FileLLCManagerMember -> Project string format into structured layout.
//******************************************************************** 
Corp2_Raw_IL.Layouts.LLCManagerMemberLayoutIn LLCManagerMemberTransform(Corp2_Raw_IL.Layouts.StringLayoutIn l) := transform
	self.ll_record_ind_42008 								:= corp2.t2u(l.payload[1..1]);
	self.ll_file_nbr_42008 									:= corp2.t2u(l.payload[2..9]);
	self.ll_mm_name_42008 									:= corp2.t2u(l.payload[10..69]);
	self.ll_mm_street_42008 								:= corp2.t2u(l.payload[70..99]);
	self.ll_mm_city_42008 									:= corp2.t2u(l.payload[100..117]);
	self.ll_mm_juris_42008 									:= corp2.t2u(l.payload[118..119]);
	self.ll_mm_zip_42008 										:= corp2.t2u(l.payload[120..128]);
	self.ll_mm_file_date_42008 							:= corp2.t2u(l.payload[129..136]);
	self.ll_mm_type_code_42008 							:= corp2.t2u(l.payload[137..137]);
end;

export FileLLCManagerMember(dataset(Corp2_Raw_IL.Layouts.StringLayoutIn) pInLLC) := project(pInLLC(corp2.t2u(payload[1..1])='P'),LLCManagerMemberTransform(LEFT));