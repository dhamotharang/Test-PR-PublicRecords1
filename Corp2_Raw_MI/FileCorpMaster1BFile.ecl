import corp2;
//********************************************************************
//CorpMaster1BTransform => '1B'
//******************************************************************** 
Corp2_Raw_MI.Layouts.CorpMaster1BLayoutIn  CorpMaster1BTransform(Corp2_Raw_MI.Layouts.MasterStringLayoutIn l) := TRANSFORM
		self.rec_date_1b 						 := corp2.t2u(l.payload[1..7]);
		self.rec_type_1b 						 := corp2.t2u(l.payload[8..9]);
		self.trans_code_1b 					 := corp2.t2u(l.payload[10]);
		self.c_no_1b 					 			 := corp2.t2u(l.payload[11..16]);		
		self.a_adr_1b 					 		 := corp2.t2u(l.payload[17..48]);
		self.a_city_1b 							 := corp2.t2u(l.payload[49..74]);
		self.a_state_1b 						 := corp2.t2u(l.payload[75..76]);
		self.a_zip_1b 							 := corp2.t2u(l.payload[77..85]);
		self.rpt_fy_1b 							 := corp2.t2u(l.payload[86..89]);
		self.rpt_roll_1b 						 := corp2.t2u(l.payload[90..93]);
		self.rpt_frame_1b 					 := corp2.t2u(l.payload[94..97]);
		self.stock_his_1b 					 := corp2.t2u(l.payload[98]);
		self.fe_no_1b 							 := corp2.t2u(l.payload[99..107]);
		self.name_his_1b 						 := corp2.t2u(l.payload[108]);
		self.purpose_1b 						 := corp2.t2u(l.payload[109..133]);
		self.m_addr_1b 				 			 := corp2.t2u(l.payload[134]);
		self.assum_name_1b 					 := corp2.t2u(l.payload[135..137]);
		self.rpt_ext_1b 						 := corp2.t2u(l.payload[138]);
		self.inc_st_1b 							 := corp2.t2u(l.payload[139..140]);
		self.date_out_1b 						 := corp2.t2u(l.payload[141..148]);
		self.pend_fl_1b 						 := corp2.t2u(l.payload[149]);
		self.out_fl_1b 							 := corp2.t2u(l.payload[150]);
		self.alert_fl_1b 						 := corp2.t2u(l.payload[151]);
		self.reason_out_1b 					 := corp2.t2u(l.payload[152..153]);
		self.total_shares_1b 				 := corp2.t2u(l.payload[154..169]);
		self.filler_1b							 := corp2.t2u(l.payload[170..290]);
end;

export FileCorpMaster1BFile(dataset(Corp2_Raw_MI.Layouts.MasterStringLayoutIn) pInMaster) := project(pInMaster(corp2.t2u(payload[8..9])='1B'),CorpMaster1BTransform(LEFT));