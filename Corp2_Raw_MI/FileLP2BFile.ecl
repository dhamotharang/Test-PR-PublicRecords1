import corp2;
//********************************************************************
//LP2BTransform => '2B'
//******************************************************************** 
Corp2_Raw_MI.Layouts.LP2BLayoutIn  LP2BTransform(Corp2_Raw_MI.Layouts.MasterStringLayoutIn l) := TRANSFORM
		self.rec_date_2b				 	 := corp2.t2u(l.payload[1..7]);
		self.rec_type_2b 					 := corp2.t2u(l.payload[8..9]);
		self.trans_code_2b 				 := corp2.t2u(l.payload[10]);
		self.l_corp_no_2b			 		 := corp2.t2u(l.payload[11..16]);				
		self.l_agent_2b						 := corp2.t2u(l.payload[17..61]);
		self.l_agent_addr1_2b			 := corp2.t2u(l.payload[62..93]);
		self.l_agent_addr2_2b			 := corp2.t2u(l.payload[94..125]);
		self.l_agent_city_2b			 := corp2.t2u(l.payload[126..151]);
		self.l_agent_state_2b			 := corp2.t2u(l.payload[152..153]);
		self.l_agent_zip_2b				 := corp2.t2u(l.payload[154..162]);
		self.l_county_code_2b			 := corp2.t2u(l.payload[163..164]);
		self.l_formed_date_2b			 := corp2.t2u(l.payload[165..172]);
		self.l_term_date_2b				 := corp2.t2u(l.payload[173..180]);
		self.l_term_flag_2b				 := corp2.t2u(l.payload[181]);
		self.l_form_state_2b			 := corp2.t2u(l.payload[182..183]);
		self.l_out_date_2b				 := corp2.t2u(l.payload[184..191]);
		self.l_out_why_2b					 := corp2.t2u(l.payload[192..193]);
		self.l_hist_flag_2b				 := corp2.t2u(l.payload[194]);
		self.l_assum_flag_2b			 := corp2.t2u(l.payload[195..198]);
		self.l_p_flag_2b					 := corp2.t2u(l.payload[199]);
		self.l_out_flag_2b				 := corp2.t2u(l.payload[200]);
		self.l_alert_flag_2b			 := corp2.t2u(l.payload[201]);
		self.l_num_part_2b 				 := corp2.t2u(l.payload[202..204]);
		self.l_fe_num_2b 					 := corp2.t2u(l.payload[205..213]);
		self.filler_2b	 					 := corp2.t2u(l.payload[214..290]);		
end;

export FileLP2BFile(dataset(Corp2_Raw_MI.Layouts.MasterStringLayoutIn) pInMaster) := project(pInMaster(corp2.t2u(payload[8..9])='2B'),LP2BTransform(LEFT));