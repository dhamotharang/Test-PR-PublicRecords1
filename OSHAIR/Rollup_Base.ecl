import ut;
export Rollup_Base(dataset(OSHAIR.layout_OSHAIR_inspection_clean_BIP) pDataset,
									 string filedate, string process_date) := function

	  OSHAIR.layout_OSHAIR_inspection_clean_BIP RollupInspection(OSHAIR.layout_OSHAIR_inspection_clean_BIP l, OSHAIR.layout_OSHAIR_inspection_clean_BIP r) := transform
     
   	self.dt_first_seen  					:= ut.EarliestDate(l.dt_first_seen ,r.dt_first_seen	);  
   	self.dt_last_seen 						:= Max(l.dt_last_seen	 ,r.dt_last_seen);
   	self.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported	,r.dt_vendor_first_reported	);	
    self.dt_vendor_last_reported  := Max(l.dt_vendor_last_reported	,r.dt_vendor_last_reported);
   	self 													:= l;
   	
   end;
   
   srtOSHAIR	:=	sort(pDataset,activity_number,source_rec_id, record, 
   									   except dt_first_seen, dt_last_seen, dt_vendor_first_reported, dt_vendor_last_reported,
   									   BDID_score, DotScore, DotWeight, EmpScore, EmpWeight,	POWScore, POWWeight, ProxScore, 
   									   ProxWeight, SeleScore, SeleWeight, OrgScore, OrgWeight, UltScore, UltWeight, 
											 cart, cr_sort_sz, lot, lot_order, dpbc, chk_digit, geo_lat, geo_long, cbsa,
											 geo_blk, geo_match, err_stat, local);
   
   InspectionRollup := rollup(srtOSHAIR, RollupInspection(left, right), record, 
   													  except dt_first_seen, dt_last_seen, dt_vendor_first_reported, dt_vendor_last_reported,
													    BDID_score, DotScore, DotWeight, EmpScore, EmpWeight,	POWScore, POWWeight, ProxScore, 
													    ProxWeight, SeleScore, SeleWeight, OrgScore, OrgWeight, UltScore, UltWeight, 
														  cart, cr_sort_sz, lot, lot_order, dpbc, chk_digit, geo_lat, geo_long, cbsa,
														  geo_blk, geo_match, err_stat, local);
   
	 return output(InspectionRollup,,'~thor_data400::base::oshair::' + filedate + '::inspection',compressed, overwrite);
	
end;