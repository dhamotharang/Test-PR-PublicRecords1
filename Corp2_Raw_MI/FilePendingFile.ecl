import corp2;
//********************************************************************
//PendingTransform => '60'
//******************************************************************** 
Corp2_Raw_MI.Layouts.PendingLayoutIn  PendingTransform(Corp2_Raw_MI.Layouts.MasterStringLayoutIn l) := TRANSFORM
	  self.rec_date_60					 := corp2.t2u(l.payload[1..7]);
		self.rec_type_60					 := corp2.t2u(l.payload[8..9]);
		self.trans_code_60				 := corp2.t2u(l.payload[10]);
		self.pend_no_60			 		 	 := corp2.t2u(l.payload[11..16]);				
		self.pend_status_60				 := corp2.t2u(l.payload[17..20]);
		self.pend_name_60					 := corp2.t2u(l.payload[21..160]);
		self.pend_ex_60						 := corp2.t2u(l.payload[161..162]);
		self.p_rej_code1_60				 := corp2.t2u(l.payload[163..164]);
		self.p_rej_code2_60				 := corp2.t2u(l.payload[165..166]);
		self.p_rej_code3_60				 := corp2.t2u(l.payload[167..168]);
		self.fil_date_60					 := corp2.t2u(l.payload[169..176]);
		self.exp_date_60					 := corp2.t2u(l.payload[177..184]);
		self.rcd_date_60 					 := corp2.t2u(l.payload[185..192]);
		self.new_form_60 					 := corp2.t2u(l.payload[193..198]);	
		self.filler_60 						 := corp2.t2u(l.payload[199..290]);	
end;

export FilePendingFile(dataset(Corp2_Raw_MI.Layouts.MasterStringLayoutIn) pInMaster) := project(pInMaster(corp2.t2u(payload[8..9])='60'),PendingTransform(LEFT));