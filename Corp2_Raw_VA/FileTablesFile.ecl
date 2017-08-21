//********************************************************************	
//TablesFile => rec_type = '01'
//******************************************************************** 	
Corp2_Raw_VA.Layouts.TablesLayoutIn  TableTranform(Corp2_Raw_VA.Layouts.CorpsStringLayoutIn l) := TRANSFORM
	 self.rec_type   							 := l.payload[1..2];
	 self.table_id   							 := l.payload[3..4];
	 self.table_code 							 := l.payload[5..14];
	 self.table_desc 							 := l.payload[15..64];
end; 

export FileTablesFile(dataset(Corp2_Raw_VA.Layouts.CorpsStringLayoutIn) pInCorps) := project(pInCorps,TableTranform(LEFT));