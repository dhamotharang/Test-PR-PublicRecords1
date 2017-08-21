import corp2;
//********************************************************************
//MailingTransform => '50'
//Add "PO BOX: " if a pob_50<>'' and addr1_50=''
//******************************************************************** 
Corp2_Raw_MI.Layouts.MailingLayoutIn  MailingTransform(Corp2_Raw_MI.Layouts.MasterStringLayoutIn l) := TRANSFORM
		self.rec_date_50 					 := corp2.t2u(l.payload[1..7]);
		self.rec_type_50 					 := corp2.t2u(l.payload[8..9]);
		self.trans_code_50 				 := corp2.t2u(l.payload[10]);
		self.corp_no_50 					 := corp2.t2u(l.payload[11..16]);		
		self.addr1_50 						 := if(corp2.t2u(l.payload[17..48])='' and corp2.t2u(l.payload[107..114])<>'',
																		 corp2.t2u('PO BOX: ' + l.payload[107..114]),
																		 corp2.t2u(l.payload[17..48])
																		);
		self.addr2_50 						 := corp2.t2u(l.payload[49..80]);
		self.city_50 							 := corp2.t2u(l.payload[81..106]);
		self.pob_50 							 := corp2.t2u(l.payload[107..114]);
		self.st_50 							 	 := corp2.t2u(l.payload[115..116]);
		self.zip_50 							 := corp2.t2u(l.payload[117..125]);
		self.filler_50 						 := corp2.t2u(l.payload[126..290]);		
end;

export FileMailingFile(dataset(Corp2_Raw_MI.Layouts.MasterStringLayoutIn) pInMaster) := project(pInMaster(corp2.t2u(payload[8..9])='50'),MailingTransform(LEFT));