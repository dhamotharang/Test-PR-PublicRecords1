import corp2;
//********************************************************************
//NameRegistrationTransform => '30'
//******************************************************************** 
Corp2_Raw_MI.Layouts.NameRegistrationLayoutIn  NameRegistrationTransform(Corp2_Raw_MI.Layouts.MasterStringLayoutIn l) := TRANSFORM
		self.rec_date_30 					 := corp2.t2u(l.payload[1..7]);
		self.rec_type_30 					 := corp2.t2u(l.payload[8..9]);
		self.trans_code_30 				 := corp2.t2u(l.payload[10]);
		self.r_no_30			 		 		 := corp2.t2u(l.payload[11..16]);				
		self.name_30				 			 := corp2.t2u(l.payload[17..156]);
		self.addr1_30							 := corp2.t2u(l.payload[157..188]);
		self.addr2_30							 := corp2.t2u(l.payload[189..220]);
		self.city_30							 := corp2.t2u(l.payload[221..246]);
		self.st_30								 := corp2.t2u(l.payload[247..248]);
		self.zip_30								 := corp2.t2u(l.payload[249..257]);
		self.corp_st_30						 := corp2.t2u(l.payload[258..259]);
		self.corp_date_30					 := corp2.t2u(l.payload[260..267]);
		self.reg_date_30 					 := corp2.t2u(l.payload[268..275]);
		self.exp_date_30 					 := corp2.t2u(l.payload[276..283]);
		self.pend_fl_30 					 := corp2.t2u(l.payload[284]);
		self.out_fl_30 						 := corp2.t2u(l.payload[285]);
		self.alert_fl_30 					 := corp2.t2u(l.payload[286]);
		self.filler_30 						 := corp2.t2u(l.payload[287..290]);

end;

export FileNameRegistrationFile(dataset(Corp2_Raw_MI.Layouts.MasterStringLayoutIn) pInMaster) := project(pInMaster(corp2.t2u(payload[8..9])='30'),NameRegistrationTransform(LEFT));