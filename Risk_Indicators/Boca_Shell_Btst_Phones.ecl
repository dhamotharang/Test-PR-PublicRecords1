/*
Used in the BTST shell
Common Phone Link - btst_phones_in_common - btst_schools_in_common - Number of unique phones in intersection of BT phone history and ST phone history
Common Phones Num Land-Lines - btst_landlines_in_common - Number of unique land-line phones in intersection of BT phone history and ST phone history
Common Phones Num Cellular - btst_cellphones_in_common - Number of unique cellular/mobile phones in intersection of BT phone history and ST phone history
*/
import Risk_Indicators, riskwise, Gong, Phonesplus_V2, phones;

export Boca_Shell_Btst_Phones(grouped dataset(Risk_Indicators.layout_ciid_btst_Output) input,
	unsigned1 dppa, unsigned1 glb, string50 DataRestriction = risk_indicators.iid_constants.default_DataRestriction ) := FUNCTION

	CellPhone := 'CELL';
	LandPhone := 'LAND';
	
	tmpPhones := record
		unsigned4 seq;
		unsigned6 did;
		string10 phone;
		string4 phone_type;
		integer btst_phones_in_common       := 0;             
		integer btst_landlines_in_common    := 0;             
		integer btst_cellphones_in_common   := 0; 
	end;
	tmpPhones searchLandLines(Risk_Indicators.layout_ciid_btst_Output le, Gong.Key_History_did r, integer c):= TRANSFORM
		self.did := r.did;
		self.seq := if(c = 1, le.bill_to_output.seq, le.ship_to_output.seq);
		self.phone := r.phone10;
		self.phone_type := LandPhone;
		self := [];
	END;
	//historical phones
	bt_hist := JOIN(Input, Gong.Key_History_did, 
			left.bill_to_output.did <> 0 and KEYED(LEFT.bill_to_output.did = RIGHT.L_DID) AND 
			(INTEGER)RIGHT.phone10 <> 0 and 
			((unsigned)RIGHT.dt_first_seen < (unsigned)risk_indicators.iid_constants.myGetDate(left.bill_to_output.historydate)), 
			searchLandLines(LEFT, RIGHT, 1), KEEP(RiskWise.max_atmost), 
			ATMOST(2 * RiskWise.max_atmost));
	st_hist := JOIN(Input, Gong.Key_History_did, 
		left.ship_to_output.did <> 0 AND KEYED(LEFT.ship_to_output.did = RIGHT.L_DID) AND 
			(INTEGER)RIGHT.phone10 <> 0 and
			((unsigned)RIGHT.dt_first_seen < (unsigned)risk_indicators.iid_constants.myGetDate(left.ship_to_output.historydate)),
			searchLandLines(LEFT, RIGHT, 2), KEEP(RiskWise.max_atmost), 
			ATMOST(2 * RiskWise.max_atmost));

	tmpPhones searchCells(Risk_Indicators.layout_ciid_btst_Output le, Phonesplus_V2.Key_PhonesPlus_DID r, integer c):= TRANSFORM
		self.did := r.did;
		self.seq := if(c = 1, le.bill_to_output.seq, le.ship_to_output.seq);
		self.phone := r.cellphone;
		self.phone_type := CellPhone;
		self := [];
	END;
	//bt cell phones
	bt_cell:= JOIN(Input, Phonesplus_V2.Key_PhonesPlus_DID, 
		left.bill_to_output.did <> 0 AND KEYED(LEFT.bill_to_output.did = RIGHT.L_DID) AND 
		Phones.Functions.IsPhoneRestricted(RIGHT.origstate, 
																			 glb, 
																			 dppa, 
																			 '',//IndustryClass
																			 , //checkRNA
																			 RIGHT.datefirstseen,
																			 RIGHT.dt_nonglb_last_seen,
																			 RIGHT.rules,
																			 RIGHT.src_all,
																			 DataRestriction
																			) = FALSE AND
		(INTEGER)RIGHT.cellphone <> 0 and
			RIGHT.datefirstseen < (unsigned)risk_indicators.iid_constants.myGetDate(left.bill_to_output.historydate),
		searchCells(LEFT, RIGHT, 1), 
		KEEP(RiskWise.max_atmost), ATMOST(2 * RiskWise.max_atmost));
	//st cell phones
	st_cell := JOIN(Input, Phonesplus_V2.Key_PhonesPlus_DID, 
		left.ship_to_output.did <> 0 AND KEYED(LEFT.ship_to_output.did = RIGHT.L_DID) AND 
		Phones.Functions.IsPhoneRestricted(RIGHT.origstate, 
																			 glb, 
																			 dppa, 
																			 '',//IndustryClass
																			 , //checkRNA
																			 RIGHT.datefirstseen,
																			 RIGHT.dt_nonglb_last_seen,
																			 RIGHT.rules,
																			 RIGHT.src_all,
																			 DataRestriction
																			) = FALSE AND
		(INTEGER)RIGHT.cellphone <> 0 and
			RIGHT.datefirstseen < (unsigned)risk_indicators.iid_constants.myGetDate(left.ship_to_output.historydate),
		searchCells(LEFT, RIGHT, 2), 
		KEEP(RiskWise.max_atmost), ATMOST(2 * RiskWise.max_atmost));

	bt_phones := DEDUP(SORT(bt_hist + bt_cell, SEQ, phone), SEQ, phone);
	st_phones := DEDUP(SORT(st_hist + st_cell, SEQ, phone), SEQ, phone);	

	tmpPhones phonesCombo(tmpPhones l, tmpPhones r ) := TRANSFORM
		self.seq := l.seq;
		CntAsPhone := l.phone <>'' and r.phone <>'' and l.phone = r.phone and l.phone_type = r.phone_type;
		self.btst_phones_in_common := if(CntAsPhone, 1, 0);            
		self.btst_landlines_in_common := if(CntAsPhone and l.phone_type = LandPhone, 1, 0);              
		self.btst_cellphones_in_common := if(CntAsPhone and l.phone_type = CellPhone, 1, 0);  	
		self := [];
	END;

	btst_Combophones := JOIN(bt_phones, st_phones,
		left.seq = right.seq - 1 and left.phone <>'' and left.phone = right.phone,
		phonesCombo(left, right), KEEP(RiskWise.max_atmost), 
			ATMOST(RiskWise.max_atmost),
		left outer);
	
	btst_Combophones_grpd := group(sort(btst_Combophones, seq, -btst_phones_in_common,
			-btst_landlines_in_common, -btst_cellphones_in_common), seq);

	tmpPhones rollCommonPhones(tmpPhones l, tmpPhones r) := transform
		self.btst_phones_in_common := l.btst_phones_in_common + r.btst_phones_in_common;
		self.btst_landlines_in_common := l.btst_landlines_in_common + r.btst_landlines_in_common;
		self.btst_cellphones_in_common := l.btst_cellphones_in_common + r.btst_cellphones_in_common;
		self := l;
	end;
	btst_phones_rolled := rollup(btst_Combophones_grpd, left.seq = right.seq, rollCommonPhones(left, right));

		//output debugs
		// OUTPUT(bt_hist, NAMED('bt_hist'));
		// OUTPUT(st_hist, NAMED('st_hist'));
		// OUTPUT(st_cell, NAMED('st_cell'));
		// OUTPUT(bt_cell, NAMED('bt_cell'));
		// output(bt_phones, named('bt_phones'));
		// output(st_phones, named('st_phones'));
		// output(btst_Combophones, named('btst_Combophones'));
		// output(btst_Combophones_grpd, named('btst_Combophones_grpd'));
		// output(btst_phones_rolled, named('btst_phones_rolled'));
		
	return btst_phones_rolled;
	
end;