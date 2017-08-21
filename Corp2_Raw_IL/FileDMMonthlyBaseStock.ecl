import corp2;
//********************************************************************
//FileDMMonthlyBaseStock -> Project string format into structured layout.
//******************************************************************** 
Corp2_Raw_IL.Layouts.StockLayoutBase StockTransform(Corp2_Raw_IL.Layouts.StringLayoutBase l) := transform
	self.action_flag										:= corp2.t2u(l.action_flag);
	self.dt_first_received							:= l.dt_first_received;
	self.dt_last_received								:= l.dt_last_received;	
	self.cd40019_file_number 						:= corp2.t2u(l.payload[1..8]);
	self.cd40019_stock_class 						:= corp2.t2u(l.payload[9..33]);
	self.cd40019_stock_series 					:= corp2.t2u(l.payload[34..58]);
	self.cd40019_voting_rights 					:= corp2.t2u(l.payload[59..59]);
	self.cd40019_authorized_shares 			:= corp2.t2u(l.payload[60..72]);
	self.cd40019_issued_shares 					:= corp2.t2u(l.payload[73..88]);
	self.cd40019_par_value 							:= corp2.t2u(l.payload[90..101]);
end;

export FileDMMonthlyBaseStock(dataset(Corp2_Raw_IL.Layouts.StringLayoutBase) pInStock) := project(pInStock,StockTransform(LEFT));