//********************************************************************
//LLCFile => rec_type = '09'
//******************************************************************** 
Corp2_Raw_VA.Layouts.LLCLayoutIn  LLCTranform(Corp2_Raw_VA.Layouts.CorpsStringLayoutIn l) := TRANSFORM
	 self.rec_type                 := l.payload[1..2]; 
	 self.corp_id                  := l.payload[3..9];
	 self.corp_name                := l.payload[10..109];
	 self.corp_status              := l.payload[110..111];
	 self.corp_status_date         := l.payload[112..119];
	 self.corp_per_dur             := l.payload[120..127]; 
	 self.corp_inc_date            := l.payload[128..135];
	 self.corp_state_inc           := l.payload[136..137];
	 self.corp_ind_code            := l.payload[138..139];
	 self.corp_street1             := l.payload[140..184];
	 self.corp_street2             := l.payload[185..229];
	 self.corp_city                := l.payload[230..252];
	 self.corp_state               := l.payload[253..254];
	 self.corp_zip                 := l.payload[255..263];
	 self.corp_po_eff_date         := l.payload[264..271];
	 self.corp_ra_name             := l.payload[272..371];
	 self.corp_ra_street1          := l.payload[372..416];
	 self.corp_ra_street2          := l.payload[417..461];
	 self.corp_ra_city             := l.payload[462..484];
	 self.corp_ra_state            := l.payload[485..486];
	 self.corp_ra_zip              := l.payload[487..495];
	 self.corp_ra_eff_date         := l.payload[496..503];
	 self.corp_ra_status           := l.payload[504..504];
	 self.corp_ra_loc              := l.payload[505..507];   
end;

EXPORT FileLLCFile(dataset(Corp2_Raw_VA.Layouts.CorpsStringLayoutIn) pInCorps) := project(pInCorps,LLCTranform(LEFT));