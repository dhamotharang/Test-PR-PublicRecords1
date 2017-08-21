import corp2;
//********************************************************************
//LLC3ATransform => '3A'
//******************************************************************** 
Corp2_Raw_MI.Layouts.LLC3ALayoutIn  LLC3ATransform(Corp2_Raw_MI.Layouts.MasterStringLayoutIn l) := TRANSFORM
		self.rec_date_3a					 := corp2.t2u(l.payload[1..7]);
		self.rec_type_3a					 := corp2.t2u(l.payload[8..9]);
		self.trans_code_3a				 := corp2.t2u(l.payload[10]);
		self.corp_3a					 		 := corp2.t2u(l.payload[11..16]);				
		self.corp_name_3a 				 := corp2.t2u(l.payload[17..156]);
		self.corp_agent_code_3a 	 := corp2.t2u(l.payload[157]);
		self.incorp_date_3a 			 := corp2.t2u(l.payload[158..165]);
		self.term_code_3a 				 := corp2.t2u(l.payload[166]);
		self.end_date_3a 					 := corp2.t2u(l.payload[167..174]);
		self.r_agent_3a 					 := corp2.t2u(l.payload[175..219]);
		self.agent_addr_3a 				 := corp2.t2u(l.payload[220..251]);
		self.act1_3a							 := corp2.t2u(l.payload[252..259]);
		self.act2_3a 							 := corp2.t2u(l.payload[260..267]);
		self.act3_3a 							 := corp2.t2u(l.payload[268..275]);
		self.filler_3a 						 := corp2.t2u(l.payload[276..290]);		
end;

export FileLLC3AFile(dataset(Corp2_Raw_MI.Layouts.MasterStringLayoutIn) pInMaster) := project(pInMaster(corp2.t2u(payload[8..9])='3A'),LLC3ATransform(LEFT));