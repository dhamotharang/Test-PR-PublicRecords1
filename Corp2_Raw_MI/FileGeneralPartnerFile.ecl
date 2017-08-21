import corp2;
//********************************************************************
//GeneralPartnerTransform => '90'
//******************************************************************** 
Corp2_Raw_MI.Layouts.GeneralPartnerLayoutIn  GeneralPartnerTransform(Corp2_Raw_MI.Layouts.MasterStringLayoutIn l) := TRANSFORM
  	self.rec_date_90					 := corp2.t2u(l.payload[1..7]);
		self.rec_type_90 					 := corp2.t2u(l.payload[8..9]);
		self.trans_code_90 				 := corp2.t2u(l.payload[10]);
		self.gp_no_90				 			 := corp2.t2u(l.payload[11..16]);				
		self.gp_name_90 			 		 := corp2.t2u(l.payload[17..76]);
		self.gp_addr1_90 					 := corp2.t2u(l.payload[77..108]);
		self.gp_addr2_90 					 := corp2.t2u(l.payload[109..140]);
		self.gp_city_90 					 := corp2.t2u(l.payload[141..166]);
		self.gp_state_90 					 := corp2.t2u(l.payload[167..168]);
		self.gp_zip_90 						 := corp2.t2u(l.payload[169..177]);
		self.filler_90 						 := corp2.t2u(l.payload[178..290]);
		
end;

export FileGeneralPartnerFile(dataset(Corp2_Raw_MI.Layouts.MasterStringLayoutIn) pInMaster) := project(pInMaster(corp2.t2u(payload[8..9])='90'),GeneralPartnerTransform(LEFT));