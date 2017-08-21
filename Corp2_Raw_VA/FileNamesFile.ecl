//********************************************************************
//NamesFile => rec_type = '06'
//********************************************************************  
Corp2_Raw_VA.Layouts.NamesLayoutIn  NamesTransform(Corp2_Raw_VA.Layouts.CorpsStringLayoutIn l) := TRANSFORM
	 self.rec_type                 := l.payload[1..2]; 
	 self.name_corp_id	           := l.payload[3..9];
	 self.name_status              := l.payload[10..11];
	 self.name_corp_name           := l.payload[12..111];
	 self.name_eff_date            := l.payload[112..119];  
end; 

EXPORT FileNamesFile(dataset(Corp2_Raw_VA.Layouts.CorpsStringLayoutIn) pInCorps) := project(pInCorps,NamesTransform(LEFT));