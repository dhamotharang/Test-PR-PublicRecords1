import corp2;
//********************************************************************
//HistoryTransform => '70'
//******************************************************************** 
Corp2_Raw_MI.Layouts.HistoryLayoutIn  HistoryTransform(Corp2_Raw_MI.Layouts.MasterStringLayoutIn l) := TRANSFORM
		self.rec_date_70					 := corp2.t2u(l.payload[1..7]);
		self.rec_type_70					 := corp2.t2u(l.payload[8..9]);
		self.trans_code_70				 := corp2.t2u(l.payload[10]);
		self.corp_no_70			 			 := corp2.t2u(l.payload[11..16]);				
		self.rec_typ_70						 := corp2.t2u(l.payload[17..18]);
		self.info_70							 := corp2.t2u(l.payload[19..63]);
		self.h_date_70						 := corp2.t2u(l.payload[64..71]);
		self.roll_70							 := corp2.t2u(l.payload[72..75]);
		self.frame_70							 := corp2.t2u(l.payload[76..79]);
		self.info2_70							 := corp2.t2u(l.payload[80..124]);
		self.info3_70							 := corp2.t2u(l.payload[125..169]);
		self.info4_70 						 := corp2.t2u(l.payload[170..214]);
		self.info5_70 						 := corp2.t2u(l.payload[215..259]);
		self.filler_70 						 := corp2.t2u(l.payload[260..290]);
end;

export FileHistoryFile(dataset(Corp2_Raw_MI.Layouts.MasterStringLayoutIn) pInMaster) := project(pInMaster(corp2.t2u(payload[8..9])='70'),HistoryTransform(LEFT));