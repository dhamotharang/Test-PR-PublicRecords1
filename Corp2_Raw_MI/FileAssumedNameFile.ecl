import corp2;
//********************************************************************
//AssumedNameTranform => '80'
//******************************************************************** 
Corp2_Raw_MI.Layouts.AssumedNameLayoutIn  AssumedNameTransform(Corp2_Raw_MI.Layouts.MasterStringLayoutIn l) := TRANSFORM
		self.rec_date_80					 := corp2.t2u(l.payload[1..7]);
		self.rec_type_80					 := corp2.t2u(l.payload[8..9]);
		self.trans_code_80				 := corp2.t2u(l.payload[10]);
		self.corp_no_80 					 := corp2.t2u(l.payload[11..16]);
		self.rec_no_80						 := corp2.t2u(l.payload[17..19]);
		self.file_date_80					 := corp2.t2u(l.payload[20..27]);
		self.exp_date_80					 := corp2.t2u(l.payload[28..35]);
		self.name_80					 		 := corp2.t2u(l.payload[36..175]);
		self.renw_date_80 				 := corp2.t2u(l.payload[176..183]);	
		self.filler_80 						 := corp2.t2u(l.payload[184..290]);	
end;

export FileAssumedNameFile(dataset(Corp2_Raw_MI.Layouts.MasterStringLayoutIn) pInMaster) := project(pInMaster(corp2.t2u(payload[8..9])='80'),AssumedNameTransform(LEFT));