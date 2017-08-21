//********************************************************************
//HistoryFile => rec_type = '04'
//******************************************************************** 
Corp2_Raw_VA.Layouts.HistoryLayoutIn  HistoryTranform(Corp2_Raw_VA.Layouts.CorpsStringLayoutIn l) := TRANSFORM
	 self.rec_type                 := l.payload[1..2]; 
	 self.hist_corp_id	           := l.payload[3..9];
	 self.hist_amend_ind           := l.payload[10..10];
	 self.hist_amend_type1         := l.payload[11..11];
	 self.hist_amend_type2         := l.payload[12..12];
	 self.hist_amend_type3         := l.payload[13..13];
	 self.hist_amend_type4         := l.payload[14..14];
	 self.hist_amend_type5         := l.payload[15..15];
	 self.hist_amend_type6         := l.payload[16..16];
	 self.hist_amend_type7         := l.payload[17..17];
	 self.hist_amend_type8         := l.payload[18..18];
	 self.hist_amend_date          := l.payload[19..26];
	 self.hist_stock_info          := l.payload[27..29]; 
	 self.hist_old_shares_auth1    := l.payload[30..40];
	 self.hist_old_shares_auth2    := l.payload[41..51];
	 self.hist_old_shares_auth3    := l.payload[52..62];
	 self.hist_old_shares_auth4    := l.payload[63..73];
	 self.hist_old_shares_auth5    := l.payload[74..84];
	 self.hist_old_shares_auth6    := l.payload[85..95];
	 self.hist_old_shares_auth7    := l.payload[96..106];
	 self.hist_old_shares_auth8    := l.payload[107..117];
	 self.hist_old_stock_class1    := l.payload[118..125];
	 self.hist_old_stock_class2    := l.payload[126..133];
	 self.hist_old_stock_class3    := l.payload[134..141];
	 self.hist_old_stock_class4    := l.payload[142..149];
	 self.hist_old_stock_class5    := l.payload[150..157];
	 self.hist_old_stock_class6    := l.payload[158..165];
	 self.hist_old_stock_class7    := l.payload[166..173];
	 self.hist_old_stock_class8    := l.payload[174..181];
end; 

EXPORT FileHistoryFile(dataset(Corp2_Raw_VA.Layouts.CorpsStringLayoutIn) pInCorps) := project(pInCorps,HistoryTranform(LEFT));