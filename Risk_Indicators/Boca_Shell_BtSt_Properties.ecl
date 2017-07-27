/*
Used in the BTST shell
Just gets the deed information for the BT and ST. However, the dataset
is then passed back as this information is needed for Boca_shell_BtSt_Address.
*/
import Risk_Indicators, RiskWise, LN_PropertyV2, Address;

export Boca_Shell_BtSt_Properties(grouped dataset(Risk_Indicators.layout_ciid_btst_Output) input ) := FUNCTION
	input_unGrp := ungroup(input);

	prop_key := LN_PropertyV2.key_Property_did(false);
	searchKey := LN_PropertyV2.key_search_fid(false);
	keepValue := 500;	
	bt_getFaresId := join(input_unGrp, prop_key,
		keyed(left.bill_to_output.did = right.s_did),
		transform(Risk_Indicators.Layout_BocaShell_BtSt.prop_rec, 
			self.ln_fares_id := right.ln_fares_id;
			self.seq := left.bill_to_output.seq;
			self.did := left.bill_to_output.did;
			self.btst_property_deeds_in_common := 0;
			self.historydate := left.bill_to_output.historydate;
			self := []), KEEP(keepValue), 
			ATMOST(RiskWise.max_atmost),
			left outer);

	st_getFaresId := join(input_unGrp, prop_key,
		keyed(left.ship_to_output.did = right.s_did),
		transform(Risk_Indicators.Layout_BocaShell_BtSt.prop_rec, 
			self.ln_fares_id := right.ln_fares_id;
			self.seq := left.ship_to_output.seq;
			self.did := left.ship_to_output.did;
			self.btst_property_deeds_in_common := 0;
			self.historydate := left.ship_to_output.historydate;
			self := []), KEEP(keepValue), 
			ATMOST(RiskWise.max_atmost),
			left outer);

	deedRec := record
		Risk_Indicators.Layout_BocaShell_BtSt.deedSlimRec;
		recordof(searchKey);
	end;

	bt_Deeds := join(bt_getFaresId, searchKey,
		keyed(left.ln_fares_id = right.ln_fares_id) and 
			wild(right.which_orig) and
			keyed(RIGHT.source_code_2='P') and
			(unsigned)(RIGHT.process_date[1..6]) < left.historydate and
			right.ln_fares_id[2] = 'D',//,
			transform(deedRec, 
				self.ln_fares_id := left.ln_fares_id;
				self.seq := left.seq;
				self.did := left.did;
				self.btst_property_deeds_in_common := 0;
				self.historydate := left.historydate;
				self.clean_pr := right.prim_range;
				self.clean_pn := right.prim_name;
				self.clean_sr := right.sec_range;
				self.clean_z5 := right.zip;
				self := right), KEEP(keepValue), 
			ATMOST(RiskWise.max_atmost));
	bt_Deeds_dpd1 := dedup(sort(bt_Deeds, seq, ln_fares_id), seq, ln_fares_id); //get unique fares Ids then do address as otherwise could get diff results
	bt_Deeds_dpd := dedup(sort(bt_Deeds_dpd1, seq, clean_pr, clean_pn, clean_z5, clean_sr, ln_fares_id), seq, clean_pr, clean_pn, clean_sr, clean_z5);	
		
	st_Deeds := join(st_getFaresId, searchKey,
			keyed(left.ln_fares_id = right.ln_fares_id) and 
			wild(right.which_orig) and
			keyed(RIGHT.source_code_2='P') and
			(unsigned)(RIGHT.process_date[1..6]) < left.historydate and
			right.ln_fares_id[2] = 'D',
			transform(deedRec, 
			self.ln_fares_id := left.ln_fares_id;
				self.seq := left.seq;
				self.did := left.did;
				self.btst_property_deeds_in_common := 0;
				self.historydate := left.historydate;
				self.clean_pr := right.prim_range;
				self.clean_pn := right.prim_name;
				self.clean_sr := right.sec_range;
				self.clean_z5 := right.zip;
				self := right), KEEP(keepValue), 
			ATMOST(RiskWise.max_atmost));

	st_Deeds_dpd1 := dedup(sort(st_Deeds, seq, ln_fares_id), seq, ln_fares_id); //get unique fares Ids then do address as otherwise could get diff results
	st_Deeds_dpd := dedup(sort(st_Deeds_dpd1, seq, clean_pr, clean_pn, clean_z5, clean_sr, ln_fares_id), seq, clean_pr, clean_pn, clean_sr, clean_z5);				
		
	Risk_Indicators.Layout_BocaShell_BtSt.deedSlimRec DeedsCombo(bt_Deeds_dpd l, st_Deeds_dpd r ) := TRANSFORM
		self.seq := l.seq;
		self.did := l.did;
		self.ln_fares_id := l.ln_fares_id;
	//using address components since the same address can be tied to different addresses
		self.btst_property_deeds_in_common := if(l.clean_pr = r.clean_pr and 
					((l.clean_pr <>'' and r.clean_pr <>'') OR (l.clean_pn <>'' and r.clean_pn <>'')) and l.clean_pn = r.clean_pn and 
					l.clean_sr = r.clean_sr and 
					l.clean_z5 = r.clean_z5, 1, 0);  
		self := l;
		self := [];
	END;

	btst_Combodeeds := JOIN(bt_Deeds_dpd, st_Deeds_dpd,
		left.seq = right.seq - 1,
		DeedsCombo(left, right),
			KEEP(keepValue), 
			ATMOST(RiskWise.max_atmost),
		left outer);
		
	btstDeeds := btst_Combodeeds(btst_property_deeds_in_common > 0);
	
	//put the rest of code in Boca_shell_btst_Address attribute as needed this dataset for joining with address history

	// //debug outputs	
	// output(bt_getFaresId, named('bt_getFaresId'));
	// output(st_getFaresId, named('st_getFaresId'));
	// output(bt_Deeds, named('bt_Deeds'));
	// output(st_Deeds, named('st_Deeds'));
	// output(bt_Deeds_dpd1, named('bt_Deeds_dpd1'));
	// output(bt_Deeds_dpd, named('bt_Deeds_dpd'));
	// output(st_Deeds_dpd1, named('st_Deeds_dpd1'));
	// output(st_Deeds_dpd, named('st_Deeds_dpd'));
	// output(btst_Combodeeds, named('btst_Combodeeds'));
	 // output(btstDeeds, named('btstDeeds'));
	
	return btstDeeds;

end;
