//********************************************************************
//ReservedFile => rec_type = '08'
//******************************************************************** 
Corp2_Raw_VA.Layouts.ReservedLayoutIn  ReservedTransform(Corp2_Raw_VA.Layouts.CorpsStringLayoutIn l) := TRANSFORM
	 self.rec_type                 := l.payload[1..2]; 
	 self.res_number               := l.payload[3..9];
	 self.res_type                 := l.payload[10..10];
	 self.res_status               := l.payload[11..12];
	 self.res_name                 := l.payload[13..112];
	 self.res_exp_date             := l.payload[113..120]; 
	 self.res_requestor            := l.payload[121..220];
	 self.res_street1              := l.payload[221..265];
	 self.res_street2              := l.payload[266..310];
	 self.res_city                 := l.payload[311..333];
	 self.res_state                := l.payload[334..335];
	 self.res_zip                  := l.payload[336..344];    
end; 

EXPORT FileReservedFile(dataset(Corp2_Raw_VA.Layouts.CorpsStringLayoutIn) pInCorps) := project(pInCorps,ReservedTransform(LEFT));