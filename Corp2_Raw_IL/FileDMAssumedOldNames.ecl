import corp2;
//********************************************************************
//FileDMAssumedOldNames -> Project string format into structured layout.
//******************************************************************** 
Corp2_Raw_IL.Layouts.AssumedOldNamesLayoutIn CorpNamesAssumedNamesTransform(Corp2_Raw_IL.Layouts.MasterFixedStringLayoutIn l) := transform
		self.cd40008_file_number 							:= corp2.t2u(l.payload[1..8]);
		self.cd40008_date_cancel 							:= corp2.t2u(l.payload[9..16]); 
		self.cd40008_assumed_curr_date 				:= corp2.t2u(l.payload[17..24]);
		self.cd40008_assumed_old_ind 					:= corp2.t2u(l.payload[25..25]);
		self.cd40008_assumed_old_date 				:= corp2.t2u(l.payload[26..33]);
		self.cd40008_assumed_old_name 				:= corp2.t2u(l.payload[34..223]);
		self.filler										 				:= corp2.t2u(l.payload[224..]);
end;

export FileDMAssumedOldNames(dataset(Corp2_Raw_IL.Layouts.MasterFixedStringLayoutIn) pInCorpNames) := project(pInCorpNames,CorpNamesAssumedNamesTransform(LEFT));		 