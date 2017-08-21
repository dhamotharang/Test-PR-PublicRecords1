import corp2;
//********************************************************************
//LLC3BTransform => '3B'
//******************************************************************** 
Corp2_Raw_MI.Layouts.LLC3BLayoutIn  LLC3BTransform(Corp2_Raw_MI.Layouts.MasterStringLayoutIn l) := transform		
		self.rec_date_3b 					 := corp2.t2u(l.payload[1..7]);
		self.rec_type_3b 					 := corp2.t2u(l.payload[8..9]);
		self.trans_code_3b 				 := corp2.t2u(l.payload[10]);
		self.corp_3b					 		 := corp2.t2u(l.payload[11..16]);				
		self.agent_addr_3b 				 := corp2.t2u(l.payload[17..48]);
		self.agent_city_3b 				 := corp2.t2u(l.payload[49..74]);
		self.agent_state_3b 			 := corp2.t2u(l.payload[75..76]);
		self.agent_zip_3b 				 := corp2.t2u(l.payload[77..85]);
		self.purpose_3b 					 := corp2.t2u(l.payload[86..110]);
		self.end_date_3b 					 := corp2.t2u(l.payload[111..118]);
		self.out_fl_3b 						 := corp2.t2u(l.payload[119..120]);
		self.asum_nme_3b 					 := corp2.t2u(l.payload[121..123]);
		self.pend_fl_3b 					 := corp2.t2u(l.payload[124]);
		self.alert_fl_3b 					 := corp2.t2u(l.payload[125]);
		self.managed_by_3b 				 := corp2.t2u(l.payload[126..133]);
		self.filler_3b 					 	 := corp2.t2u(l.payload[134..290]);
end;

export FileLLC3BFile(dataset(Corp2_Raw_MI.Layouts.MasterStringLayoutIn) pInMaster) := project(pInMaster(corp2.t2u(payload[8..9])='3B'),LLC3BTransform(LEFT));