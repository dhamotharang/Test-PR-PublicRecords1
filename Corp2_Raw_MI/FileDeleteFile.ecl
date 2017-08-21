import corp2;
//********************************************************************
//FileDeleteFile => '00'
//******************************************************************** 
Corp2_Raw_MI.Layouts.DeleteLayoutIn  DeleteTransform(Corp2_Raw_MI.Layouts.MasterStringLayoutIn l) := TRANSFORM
		self.date_00 					 		 := corp2.t2u(l.payload[1..7]);
		self.type_00 					 		 := corp2.t2u(l.payload[8..9]);
		self.trans_00 				 		 := corp2.t2u(l.payload[10]);
		self.id_no_00				 			 := corp2.t2u(l.payload[11..16]);		
		self.filler_00 						 := corp2.t2u(l.payload[17..290]);		
end;

export FileDeleteFile(dataset(Corp2_Raw_MI.Layouts.MasterStringLayoutIn) pInMaster) := project(pInMaster(corp2.t2u(payload[8..9])='00'),DeleteTransform(LEFT));