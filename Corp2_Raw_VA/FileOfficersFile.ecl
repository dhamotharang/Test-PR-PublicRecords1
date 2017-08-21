//********************************************************************
//OfficersFile => rec_type = '05'
//********************************************************************  
Corp2_Raw_VA.Layouts.OfficersLayoutIn  OfficersTransform(Corp2_Raw_VA.Layouts.CorpsStringLayoutIn l) := TRANSFORM
	 self.rec_type                 := l.payload[1..2]; 
	 self.dirc_corp_id	           := l.payload[3..9];
	 self.dirc_last_name           := l.payload[10..39];
	 self.dirc_first_name          := l.payload[40..59];
	 self.dirc_middle_name         := l.payload[60..79];
	 self.dirc_title               := l.payload[80..94];  
end; 

EXPORT FileOfficersFile(dataset(Corp2_Raw_VA.Layouts.CorpsStringLayoutIn) pInCorps) := project(pInCorps,OfficersTransform(LEFT));