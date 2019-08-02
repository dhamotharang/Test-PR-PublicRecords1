import ut, riskwise, AddrFraud, address, doxie;

export Boca_Shell_Address_Risk(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, integer bsversion, doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION
					
with_addrfraud_geolink := join(clam, AddrFraud.Key_AddrFraud_GeoLink,
												left.shell_input.st<>'' and left.shell_input.county <>'' and left.shell_input.geo_blk <> '' and
												keyed(right.geolink=left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk),
		transform(risk_indicators.Layout_Boca_Shell, 
							self.addr_risk_summary.occupants_1yr := right.occupants_1yr;
							self.addr_risk_summary.turnover_1yr_in := right.turnover_1yr_in;
							self.addr_risk_summary.turnover_1yr_out := right.turnover_1yr_out;
							self := left),
		atmost(riskwise.max_atmost), left outer, keep(1));


risk_indicators.layout_boca_shell getNeighborhoodStats(risk_indicators.layout_boca_shell l, Risk_Indicators.Key_Neighborhood_Stats_geolink r) := TRANSFORM
	self.addr_risk_summary.N_Vacant_Properties 	:= r.Neighborhood_Vacant_Properties;
	self.addr_risk_summary.N_Business_Count 		:= r.Neighborhood_Business_Count;
	self.addr_risk_summary.N_SFD_Count 					:= r.Neighborhood_SFD_Count;
	self.addr_risk_summary.N_MFD_Count 					:= r.Neighborhood_MFD_Count;
	self.addr_risk_summary.N_ave_building_age 		:= r.ave_building_age;
	self.addr_risk_summary.N_ave_purchase_amount 	:= r.ave_purchase_amount;
	self.addr_risk_summary.N_ave_mortgage_amount 	:= r.ave_mortgage_amount;
	self.addr_risk_summary.N_ave_assessed_amount 	:= r.ave_assessed_amount;
	self.addr_risk_summary.N_ave_building_area 		:= r.ave_building_area;
	self.addr_risk_summary.N_ave_price_per_sf 		:= r.ave_price_per_sf;
	self.addr_risk_summary.N_ave_no_of_stories_count 		:= r.ave_no_of_stories_count;
	self.addr_risk_summary.N_ave_no_of_rooms_count 			:= r.ave_no_of_rooms_count;
	self.addr_risk_summary.N_ave_no_of_bedrooms_count 	:= r.ave_no_of_bedrooms_count;
	self.addr_risk_summary.N_ave_no_of_baths_count 			:= r.ave_no_of_baths_count;
	self := l;
End;

with_Neighborhood_stats1 := join(with_addrfraud_geolink, 
																Risk_Indicators.Key_Neighborhood_Stats_geolink, 
	left.shell_input.st<>'' and left.shell_input.county <>'' and left.shell_input.geo_blk <> '' and
	keyed(right.geolink=left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk),
	getNeighborhoodStats(left, right),
	atmost(riskwise.max_atmost), keep(1), left Outer);
						

with_addrfraud_geolink2 := join(with_Neighborhood_stats1, AddrFraud.Key_AddrFraud_GeoLink,
												left.Address_Verification.Address_History_1.st<>'' and left.Address_Verification.Address_History_1.county <>'' and left.Address_Verification.Address_History_1.geo_blk <> '' and
												keyed(right.geolink=left.Address_Verification.Address_History_1.st+left.Address_Verification.Address_History_1.county+left.Address_Verification.Address_History_1.geo_blk),
		transform(risk_indicators.Layout_Boca_Shell, 
							self.addr_risk_summary2.occupants_1yr := right.occupants_1yr;
							self.addr_risk_summary2.turnover_1yr_in := right.turnover_1yr_in;
							self.addr_risk_summary2.turnover_1yr_out := right.turnover_1yr_out;
							self := left),
		atmost(riskwise.max_atmost), left outer, keep(1));


risk_indicators.layout_boca_shell getNeighborhoodStats2(risk_indicators.layout_boca_shell l, Risk_Indicators.Key_Neighborhood_Stats_geolink  r) := TRANSFORM
	self.addr_risk_summary2.N_Vacant_Properties 	:= r.Neighborhood_Vacant_Properties;
	self.addr_risk_summary2.N_Business_Count 		:= r.Neighborhood_Business_Count;
	self.addr_risk_summary2.N_SFD_Count 					:= r.Neighborhood_SFD_Count;
	self.addr_risk_summary2.N_MFD_Count 					:= r.Neighborhood_MFD_Count;
	self.addr_risk_summary2.N_ave_building_age 		:= r.ave_building_age;
	self.addr_risk_summary2.N_ave_purchase_amount 	:= r.ave_purchase_amount;
	self.addr_risk_summary2.N_ave_mortgage_amount 	:= r.ave_mortgage_amount;
	self.addr_risk_summary2.N_ave_assessed_amount 	:= r.ave_assessed_amount;
	self.addr_risk_summary2.N_ave_building_area 		:= r.ave_building_area;
	self.addr_risk_summary2.N_ave_price_per_sf 		:= r.ave_price_per_sf;
	self.addr_risk_summary2.N_ave_no_of_stories_count 		:= r.ave_no_of_stories_count;
	self.addr_risk_summary2.N_ave_no_of_rooms_count 			:= r.ave_no_of_rooms_count;
	self.addr_risk_summary2.N_ave_no_of_bedrooms_count 	:= r.ave_no_of_bedrooms_count;
	self.addr_risk_summary2.N_ave_no_of_baths_count 			:= r.ave_no_of_baths_count;
	self := l;
End;

with_Neighborhood_stats2 := join(with_addrfraud_geolink2, Risk_Indicators.Key_Neighborhood_Stats_geolink,
	left.Address_Verification.Address_History_1.st<>'' and left.Address_Verification.Address_History_1.county <>'' and left.Address_Verification.Address_History_1.geo_blk <> '' and
	keyed(right.geolink=left.Address_Verification.Address_History_1.st+left.Address_Verification.Address_History_1.county+left.Address_Verification.Address_History_1.geo_blk),
	getNeighborhoodStats2(left, right),
	atmost(riskwise.max_atmost), keep(1), left Outer);
	
	
with_addrfraud_geolink3 := join(with_Neighborhood_stats2, AddrFraud.Key_AddrFraud_GeoLink,
												left.Address_Verification.Address_history_2.st<>'' and left.Address_Verification.Address_history_2.county <>'' and left.Address_Verification.Address_history_2.geo_blk <> '' and
												keyed(right.geolink=left.Address_Verification.Address_history_2.st+left.Address_Verification.Address_history_2.county+left.Address_Verification.Address_history_2.geo_blk),
		transform(risk_indicators.Layout_Boca_Shell, 
							self.addr_risk_summary3.occupants_1yr := right.occupants_1yr;
							self.addr_risk_summary3.turnover_1yr_in := right.turnover_1yr_in;
							self.addr_risk_summary3.turnover_1yr_out := right.turnover_1yr_out;
							self := left),
		atmost(riskwise.max_atmost), left outer, keep(1));


risk_indicators.layout_boca_shell getNeighborhoodStats3(risk_indicators.layout_boca_shell l, Risk_Indicators.Key_Neighborhood_Stats_geolink  r) := TRANSFORM
	self.addr_risk_summary3.N_Vacant_Properties 	:= r.Neighborhood_Vacant_Properties;
	self.addr_risk_summary3.N_Business_Count 		:= r.Neighborhood_Business_Count;
	self.addr_risk_summary3.N_SFD_Count 					:= r.Neighborhood_SFD_Count;
	self.addr_risk_summary3.N_MFD_Count 					:= r.Neighborhood_MFD_Count;
	self.addr_risk_summary3.N_ave_building_age 		:= r.ave_building_age;
	self.addr_risk_summary3.N_ave_purchase_amount 	:= r.ave_purchase_amount;
	self.addr_risk_summary3.N_ave_mortgage_amount 	:= r.ave_mortgage_amount;
	self.addr_risk_summary3.N_ave_assessed_amount 	:= r.ave_assessed_amount;
	self.addr_risk_summary3.N_ave_building_area 		:= r.ave_building_area;
	self.addr_risk_summary3.N_ave_price_per_sf 		:= r.ave_price_per_sf;
	self.addr_risk_summary3.N_ave_no_of_stories_count 		:= r.ave_no_of_stories_count;
	self.addr_risk_summary3.N_ave_no_of_rooms_count 			:= r.ave_no_of_rooms_count;
	self.addr_risk_summary3.N_ave_no_of_bedrooms_count 	:= r.ave_no_of_bedrooms_count;
	self.addr_risk_summary3.N_ave_no_of_baths_count 			:= r.ave_no_of_baths_count;
	self := l;
End;

with_Neighborhood_stats3 := join(with_addrfraud_geolink3, Risk_Indicators.Key_Neighborhood_Stats_geolink,
	left.Address_Verification.Address_history_2.st<>'' and left.Address_Verification.Address_history_2.county <>'' and left.Address_Verification.Address_history_2.geo_blk <> '' and
	keyed(right.geolink=left.Address_Verification.Address_history_2.st+left.Address_Verification.Address_history_2.county+left.Address_Verification.Address_history_2.geo_blk),
	getNeighborhoodStats3(left, right),
	atmost(riskwise.max_atmost), keep(1), left Outer);	
// output(clam);
// output(with_law_enforcement2);


// shell version 5.0 added the extra search for addr_risk_summary3
shell_address_risk := if(bsversion>=50, with_neighborhood_stats3, with_neighborhood_stats2);
	
return shell_address_risk;   

end;
