//********************************************************************
//MergersFile => rec_type = '07'
//******************************************************************** 
Corp2_Raw_VA.Layouts.MergersLayoutIn  MergersTransform(Corp2_Raw_VA.Layouts.CorpsStringLayoutIn l) := TRANSFORM
	 self.rec_type                 := l.payload[1..2];
	 self.merg_corp_id         		 := l.payload[3..9];
	 self.merg_type        		     := l.payload[10..10];
	 self.merg_eff_date            := l.payload[11..18];
	 self.merg_surv_id             := l.payload[19..25];
	 self.merg_for_corp_name       := l.payload[26..125];  
end; 

EXPORT FileMergersFile(dataset(Corp2_Raw_VA.Layouts.CorpsStringLayoutIn) pInCorps) := project(pInCorps,MergersTransform(LEFT));