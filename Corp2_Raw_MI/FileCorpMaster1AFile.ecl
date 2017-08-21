import corp2;
//********************************************************************
//CorpMaster1ATranform => '1A'
//******************************************************************** 
Corp2_Raw_MI.Layouts.CorpMaster1ALayoutIn  CorpMaster1ATransform(Corp2_Raw_MI.Layouts.MasterStringLayoutIn l) := TRANSFORM
		self.rec_date_1a				 	 := corp2.t2u(l.payload[1..7]);
		self.rec_type_1a				 	 := corp2.t2u(l.payload[8..9]);
		self.trans_code_1a			 	 := corp2.t2u(l.payload[10]);
		self.c_no_1a 							 := corp2.t2u(l.payload[11..16]);		
	  self.c_name_1a 						 := corp2.t2u(l.payload[17..156]);
		self.c_agent_1a 					 := corp2.t2u(l.payload[157]);
		self.c_date_inc_1a				 := corp2.t2u(l.payload[158..165]);
		self.c_term_1a 						 := corp2.t2u(l.payload[166]);
		self.c_date_end_1a 				 := corp2.t2u(l.payload[167..174]);
		self.c_reg_agent_1a 			 := corp2.t2u(l.payload[175..219]);
		self.c_agent_adr_1a 			 := corp2.t2u(l.payload[220..251]);
		self.c_act1_1a 						 := corp2.t2u(l.payload[252..259]);
		self.c_act2_1a 						 := corp2.t2u(l.payload[260..267]);
		self.c_act3_1a 						 := corp2.t2u(l.payload[268..275]);
		self.c_filler_1a 					 := corp2.t2u(l.payload[276..290]);		
end;

export FileCorpMaster1AFile(dataset(Corp2_Raw_MI.Layouts.MasterStringLayoutIn) pInMaster) := project(pInMaster(corp2.t2u(payload[8..9])='1A'),CorpMaster1ATransform(LEFT));