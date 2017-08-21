//********************************************************************
//CorpsFile => rec_type = '02'
//******************************************************************** 
Corp2_Raw_VA.Layouts.CorpsLayoutIn  CorpsTranform(Corp2_Raw_VA.Layouts.CorpsStringLayoutIn l) := TRANSFORM
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
	 self.corp_stock_ind           := l.payload[508..508];
	 self.corp_total_shares        := l.payload[509..519];
	 self.corp_merger_ind          := l.payload[520..520];
	 self.corp_asmt_ind            := l.payload[521..521];
	 self.corp_stock_class1        := l.payload[522..529];
	 self.corp_stock_class2        := l.payload[530..537];
	 self.corp_stock_class3        := l.payload[538..545];
	 self.corp_stock_class4        := l.payload[546..553];
	 self.corp_stock_class5        := l.payload[554..561];
	 self.corp_stock_class6        := l.payload[562..569];
	 self.corp_stock_class7        := l.payload[570..577];
	 self.corp_stock_class8        := l.payload[578..585];
	 self.corp_stock_share_auth1   := l.payload[586..596];
	 self.corp_stock_share_auth2   := l.payload[597..607];
	 self.corp_stock_share_auth3   := l.payload[608..618];
	 self.corp_stock_share_auth4   := l.payload[619..629];
	 self.corp_stock_share_auth5   := l.payload[630..640];
	 self.corp_stock_share_auth6   := l.payload[641..651];
	 self.corp_stock_share_auth7   := l.payload[652..662];
	 self.corp_stock_share_auth8   := l.payload[663..673];
	 self.filler 									 := l.payload[674..677];
end; 

EXPORT FileCorpsFile(dataset(Corp2_Raw_VA.Layouts.CorpsStringLayoutIn) pInCorps) := project(pInCorps,CorpsTranform(LEFT));