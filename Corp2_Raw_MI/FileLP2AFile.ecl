import corp2;
//********************************************************************
//LP2ATransform => '2A'
//******************************************************************** 
Corp2_Raw_MI.Layouts.LP2ALayoutIn  LP2ATransform(Corp2_Raw_MI.Layouts.MasterStringLayoutIn l) := TRANSFORM
	  self.rec_date_2a					 := corp2.t2u(l.payload[1..7]);
		self.rec_type_2a 				 	 := corp2.t2u(l.payload[8..9]);
		self.trans_code_2a 			 	 := corp2.t2u(l.payload[10]);
		self.l_corp_no_2a			 		 := corp2.t2u(l.payload[11..16]);				
		self.l_name_2a 					 	 := corp2.t2u(l.payload[17..156]);
		self.l_addr1_2a 					 := corp2.t2u(l.payload[157..188]);
		self.l_addr2_2a 					 := corp2.t2u(l.payload[189..220]);
		self.l_city_2a 						 := corp2.t2u(l.payload[221..246]);
		self.l_state_2a 					 := corp2.t2u(l.payload[247..248]);
		self.l_zip_2a 						 := corp2.t2u(l.payload[249..257]);
		self.filler_2a 						 := corp2.t2u(l.payload[258..290]);		
end;

export FileLP2AFile(dataset(Corp2_Raw_MI.Layouts.MasterStringLayoutIn) pInMaster) := project(pInMaster(corp2.t2u(payload[8..9])='2A'),LP2ATransform(LEFT));